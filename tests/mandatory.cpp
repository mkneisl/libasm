#include "../include/libasm.h"
#include <iostream>
#include <functional>
#include <unistd.h>
#include <errno.h>
#include <cstring>
#include <fcntl.h>
#include <chrono>

typedef std::chrono::steady_clock aclock;

template <typename R, typename ...Args>
R measureCallDuration(R (*func)(Args...), Args... args)
{
    R ret;
    aclock::time_point start = aclock::now();
    ret = func(args...);
    aclock::time_point end = aclock::now();
    printf("duration : %lli\n", std::chrono::duration_cast<std::chrono::nanoseconds>(end - start).count());
    return ret;
}

template <const bool checkReturn, typename Fn, typename ...Args>
bool compareCall(std::function<void()> resetState, Fn stdFunc, Fn ftFunc, Args... args)
{
    bool valid;
    int stdErrno, ftErrno;
    auto doCall = [&](Fn func, int& rerrno) -> auto {
        errno = 0;
        auto ret = func(args...);
        rerrno = errno;
        return ret;
    };

    resetState();
    auto stdReturn =
        doCall(stdFunc, stdErrno);
    resetState();
    auto ftReturn =
        doCall(ftFunc, ftErrno);
    valid = ((checkReturn ? stdReturn == ftReturn : true) && ftErrno == stdErrno);
    if (!valid)
        printf("stdErrno: %i\nftErrno: %i\nstdReturn: %i\nftReturn: %i\n\n", stdErrno, ftErrno, (int)stdReturn, (int)ftReturn); 
    return valid;
}

bool testReadWrite()
{
    char buffer[64];
    int testFile;

    memset(buffer, 0x34343434, 64);
    testFile = open("test.txt", O_CREAT | O_RDWR, S_IRWXU);
    if (testFile == -1)
    {
        printf("Error opening file!\n");
        return false;
    }
    if (!compareCall<true>([]()-> void {}, write, ft_write, 42, buffer, 64))
    {
        close(testFile);
        printf("invalid write missmatch!\n");
        return false;
    }
    if (!compareCall<true>([]()-> void {}, read, ft_read, 42, buffer, 64))
    {
        close(testFile);
        printf("invalid read missmatch!\n");
        return false;
    }
    if (!compareCall<true>([&]()-> void {lseek(testFile, 0, SEEK_SET);}, write, ft_write, testFile, buffer, 64))
    {
        close(testFile);
        printf("valid write missmatch!\n");
        return false;
    }
    if (!compareCall<true>([&]()-> void {lseek(testFile, 0, SEEK_SET);}, read, ft_read, testFile, buffer, 64))
    {
        close(testFile);
        printf("valid read missmatch!\n");
        return false;
    }
    close(testFile);
    return true;
}

bool testStrStuff()
{
    char buffer_1[] = "Test42";
    char buffer_1_target[sizeof(buffer_1)];
    char buffer_2[] = "Test41";

    if (!compareCall<true>([]()-> void {}, strlen, ft_strlen, buffer_1))
    {
        printf("strlen missmatch!\n");
        return false;
    }
    if (ft_strcpy(buffer_1_target, buffer_1) != buffer_1_target && strcmp(buffer_1_target, buffer_1))
    {
        printf("strcpy missmatch!\n");
        return false;
    }
    if (ft_strcmp(buffer_1_target, buffer_1) != strcmp(buffer_1_target, buffer_1))
    {
        printf("strcmp1 missmatch!\n");
        return false;
    }
    if (ft_strcmp(buffer_1_target, buffer_1) != strcmp(buffer_1_target, buffer_1) ||
        ft_strcmp(buffer_2, buffer_1) != strcmp(buffer_2, buffer_1)               ||
        ft_strcmp(buffer_1, buffer_2) != strcmp(buffer_1, buffer_2))
    {
        printf("strcmp missmatch!\n");
        return false;
    }

    {
        char* stdDup = strdup(buffer_1);
        char* ftDup = ft_strdup(buffer_1);

        if (ft_strcmp(stdDup, ftDup))
        {
            free(stdDup);
            free(ftDup);
            printf("strdup missmatch!\n");
            return false;
        }
        free(stdDup);
        free(ftDup);
    }
    return true;
}

int main()
{
    if (!testReadWrite())
        return 1;
    if (!testStrStuff())
        return 1;
    printf("All OK (or tests are screwed)\n");
}