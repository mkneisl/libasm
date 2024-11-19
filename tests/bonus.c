#include <fcntl.h>
#include <stddef.h>
#include <string.h>
#include <unistd.h>
#include <stdio.h>
#include <errno.h>
#define BONUS
#include "../include/libasm.h"

int compare(long long a, long long b)
{
    return a - b;
}

void print_list(t_list** startNode)
{
    t_list* pNode = *startNode;
    printf("--------------------\n");
    while (pNode)
    {
        printf("Node: %p\n", pNode);
        printf("Data: %x\n", (int)pNode->data);
        printf("Next: %p\n", pNode->next);
        pNode = pNode ->next;
    }
    printf("--------------------\n");
}

void freeFunc(void* data)
{
    printf("Freed: %i\n", (int)data);
}

int testAtoi()
{
    char baseTen[] = "0123456789";
    char strTen[] = "42";

    char baseBin[] = "01";
    char strBin[] = "101010";

    char invldBase_0[] = "1";
    char invldBase_1[] = "x-ab";
    char invldBase_2[] = " no";
    char strTest[] = "1x ";

    int num = 0;

    num = ft_atoi_base(strTen, baseTen);
    if (num != 42)
    {
        printf("Base 10 wrong! - %i\n", num);
        return 1;
    }
    num = 0;
    num = ft_atoi_base(strBin, baseBin);
    if (num != 42)
    {
        printf("Base 2 wrong!\n");
        return 1;
    }
    if (ft_atoi_base(strTest, invldBase_0))
        return 1;
    if (ft_atoi_base(strTest, invldBase_1))
        return 1;
    if (ft_atoi_base(strTest, invldBase_2))
        return 1;
    return 0;
}

void testList()
{
    t_list* listBase = NULL;

    ft_list_push_front(&listBase, (void*)0);
    ft_list_push_front(&listBase, (void*)1);
    ft_list_push_front(&listBase, (void*)2);
    ft_list_push_front(&listBase, (void*)3);
    ft_list_push_front(&listBase, (void*)4);
    ft_list_push_front(&listBase, (void*)5);

    printf("list size %i\n", ft_list_size(listBase));
    printf("listBase %p\n", listBase);

    t_list* pNode = listBase;
    while (pNode)
    {
        printf("NR: %x -> %p\n", (int)pNode->data, pNode);
        pNode = pNode->next;
    }
    printf("Sorting....\n");

    ft_list_sort(&listBase, &compare);

    printf("listBase %p\n", listBase);

    pNode = listBase;
    while (pNode)
    {
        printf("NR: %x -> %p\n", (int)pNode->data, pNode);
        pNode = pNode->next;
    }

    ft_list_remove_if(&listBase, (void*)3, compare, freeFunc);

    printf("listBase %p\n", listBase);

    pNode = listBase;
    while (pNode)
    {
        printf("NR: %x -> %p\n", (int)pNode->data, pNode);
        pNode = pNode->next;
    }
}

int main()
{
    if (testAtoi())
    {
        printf("ft_atoi_base KO!\n");
        return 1;
    }
    else
        printf("ft_atoi_base OK\n");
    testList();
    return 0;
}
