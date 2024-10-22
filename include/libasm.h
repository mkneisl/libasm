#ifndef LIBASM_H
#define LIBASM_H
#include <stddef.h>
#include <sys/types.h>
#ifndef __cplusplus

ssize_t ft_read(int fd, void* buffer, size_t count);
ssize_t ft_write(int fd, void* buffer, size_t count);
size_t ft_strlen(const char *s);
char *ft_strcpy(char *restrict dst, const char *restrict src);
#else

extern "C" ssize_t ft_read(int fd, void* buffer, size_t count);
extern "C" ssize_t ft_write(int fd, void* buffer, size_t count);

#endif
#endif
