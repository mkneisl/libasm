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
        int ft_atoi_base(const char* str, const char* base);

        t_list* ft_list_new(void* data);
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
        extern "C" int ft_atoi_base(const char* str, const char* base);
        extern "C" int ft_atoi_base(const char* str, const char* base);
    #endif
#endif
#endif
