#include <fcntl.h>
#include <stddef.h>
#include <string.h>
#include <unistd.h>
#include <stdio.h>
#include <errno.h>
#define BONUS
#include "../include/libasm.h"

// void testValidReadWrite()
// {
//     int fd;
//     ssize_t retVal;
//     char buffer[64];

//     memset(buffer, 0, sizeof(buffer));
//     fd = open("test.txt", O_CREAT | O_RDWR, S_IRWXU);
//     if (fd < 0)
//         return;
//     retVal = write(fd, "std\n", 4);
//     printf("std valid write: ret: %li  - errno %i\n", retVal, errno);
//     retVal = read(fd, buffer, sizeof(buffer));
//     printf("std valid read: ret: %li  - errno %i\n", retVal, errno);

//     memset(buffer, 0, sizeof(buffer));
//     lseek(fd, 0, SEEK_SET);
//     retVal = ft_write(fd, "ft_\n", 4);
//     printf("ft valid write: ret: %li  - errno %i\n", retVal, errno);
//     retVal = ft_read(fd, buffer, sizeof(buffer));
//     printf("ft valid read: ret: %li  - errno %i\n", retVal, errno);
// }

int main()
{
    t_list* listBase = NULL;

    ft_list_add_front(&listBase, 0);
    ft_list_add_front(&listBase, 1);
    ft_list_add_front(&listBase, 2);
    ft_list_add_front(&listBase, 3);
    ft_list_add_front(&listBase, 4);
    ft_list_add_front(&listBase, 5);
    
    printf("list size %i\n", ft_list_size(listBase));
    t_list* pNode = listBase;
    while (pNode)
    {
        prinf("NR: %x", pNode->data);
        pNode = pNode->next;
    }
    //ft_write(1, "Hello\n", 7);

    //char baseTen[] = "0123456789";
    //char strTen[] = "42";

    //char baseBin[] = "01";
    //char strBin[] = "00101010";

    //int num = ft_atoi_base(strBin, baseBin);


    //printf("num : %i\n", num);
    //testValidReadWrite();
    return 0;
}
