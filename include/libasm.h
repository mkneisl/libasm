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

#ifdef __cplusplus
#   define C_SYMBOL extern "C"
#else
#   define C_SYMBOL
#endif

#ifdef __APPLE__
    C_SYMBOL size_t  ft_strlen(const char *s);
    //extern "C" size_t  ft_strlen_1(const char *s);
#else
    C_SYMBOL size_t  ft_strlen(const char *s) noexcept;
#endif
C_SYMBOL char*   ft_strcpy(char * dst, const char * src);
C_SYMBOL int     ft_strcmp(const char *s1, const char *s2);
C_SYMBOL ssize_t ft_read(int fd, void* buffer, size_t count);
C_SYMBOL ssize_t ft_write(int fd, const void* buffer, size_t count);
C_SYMBOL char*   ft_strdup(const char *s);

#ifdef BONUS
    C_SYMBOL int     ft_atoi_base(const char* str, const char* base);

    C_SYMBOL t_list* ft_list_new(void* data);
    C_SYMBOL void    ft_list_push_front(t_list **begin_list, void *data);
    C_SYMBOL int     ft_list_size(t_list *begin_list);
    C_SYMBOL void    ft_list_sort(t_list **begin_list, int (*cmp)());
    C_SYMBOL void    ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *));
#endif
#endif
