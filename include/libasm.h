#ifndef LIBASM_H
#define LIBASM_H
#include <stddef.h>
#include <sys/types.h>

#ifdef BONUS
    typedef struct s_list
    {
        void *data;
        struct s_list *next;
    }t_list;
#endif

#ifndef __cplusplus
    ssize_t ft_read(int fd, void* buffer, size_t count);
    ssize_t ft_write(int fd, const void* buffer, size_t count);
    size_t  ft_strlen(const char *s);
    char*   ft_strcpy(char * dst, const char * src);
    char*   ft_strdup(const char *s);
    int     ft_strcmp(const char *s1, const char *s2);

    #ifdef BONUS
        int     ft_atoi_base(const char* str, const char* base);

        t_list* ft_list_new(void* data);
        void    ft_list_push_front(t_list **begin_list, void *data);
        int     ft_list_size(t_list *begin_list);
        void    ft_list_sort(t_list **begin_list, int (*cmp)());
        void    ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *));
    #endif
#else
    extern "C" ssize_t ft_read(int fd, void* buffer, size_t count);
    extern "C" ssize_t ft_write(int fd, const void* buffer, size_t count);
    #ifdef __APPLE__
        extern "C" size_t  ft_strlen(const char *s);
    #else
        extern "C" size_t  ft_strlen(const char *s) noexcept;
    #endif
    extern "C" char*   ft_strcpy(char * dst, const char * src);
    extern "C" char*   ft_strdup(const char *s);
    extern "C" int     ft_strcmp(const char *s1, const char *s2);

    #ifdef BONUS
        extern "C" int     ft_atoi_base(const char* str, const char* base);

        extern "C" t_list* ft_list_new(void* data);
        extern "C" void    ft_list_push_front(t_list **begin_list, void *data);
        extern "C" int     ft_list_size(t_list *begin_list);
        extern "C" void    ft_list_sort(t_list **begin_list, int (*cmp));
        extern "C" void    ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *));
    #endif
#endif
#endif
