#include <fcntl.h>
#include <stddef.h>
#include <string.h>
#include <unistd.h>
#include <stdio.h>
#include <errno.h>
#include "../include/libasm.h"

void testValidReadWrite()
{
    int fd;
    ssize_t retVal;
    char buffer[64];

    memset(buffer, 0, sizeof(buffer));
    fd = open("test.txt", O_CREAT | O_RDWR, S_IRWXU);
    if (fd < 0)
        return;
    retVal = write(fd, "std\n", 4);
    printf("std valid write: ret: %li  - errno %i\n", retVal, errno);
    retVal = read(fd, buffer, sizeof(buffer));
    printf("std valid read: ret: %li  - errno %i\n", retVal, errno);

    memset(buffer, 0, sizeof(buffer));
    lseek(fd, 0, SEEK_SET);
    retVal = ft_write(fd, "ft_\n", 4);
    printf("ft valid write: ret: %li  - errno %i\n", retVal, errno);
    retVal = ft_read(fd, buffer, sizeof(buffer));
    printf("ft valid read: ret: %li  - errno %i\n", retVal, errno);
}

int main()
{
    testValidReadWrite();
    return 0;
}
