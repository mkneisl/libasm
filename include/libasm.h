#ifndef LIBASM_H
#define LIBASM_H
#include <stddef.h>

#ifndef __cplusplus

ssize_t ft_read(int fd, void* buffer, size_t count);
ssize_t ft_write(int fd, void* buffer, size_t count);

#else

extern "C" ssize_t ft_read(int fd, void* buffer, size_t count);
extern "C" ssize_t ft_write(int fd, void* buffer, size_t count);

#endif
#endif
