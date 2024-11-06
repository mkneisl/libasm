NAME = libasm.a
BIN = bin
FILE_NAMES = ft_read ft_write ft_strlen ft_strcpy ft_strcmp ft_strdup ft_atoi_base
TEST_FILE = ./tests/main.c
TEST_FILE++ = ./tests/main.cpp
OBJ_Files = $(addprefix $(BIN)/, $(addsuffix .o , $(FILE_NAMES)))
ASM_FILES = $(addprefix ./src/, $(addsuffix .asm , $(FILE_NAMES)))
ASM_DEBUG_INFO = -g -F dwarf
CFLAGS = -Werror -Wall -Wextra
OS_NAME = $(shell uname -s)

all: $(NAME)

$(NAME): $(BIN) $(OBJ_Files)
	ar rc $(NAME) $(OBJ_Files)

$(BIN)/%.o: ./src/%.asm
ifeq ($(OS_NAME), Darwin)
	nasm -f macho64 $< -o $@
else ifeq ($(OS_NAME), Linux)
	nasm -f elf64 $< -o $@
else
	@echo "[ERROR]: Unsupported OS!"
	@exit 1
endif

$(BIN):
	@mkdir $(BIN)

testsc: $(NAME) $(TEST_FILE)
	cc  $(CFLAGS) $(TEST_FILE) $(NAME) -o $@

tests++: $(NAME) $(TEST_FILE++)
	c++ $(CFLAGS) $(TEST_FILE++) $(NAME) -o $@

clean:
	@rm -rf $(BIN)

fclean: clean
	@rm -f $(NAME)
	@rm -f tests++
	@rm -f testsc
	@rm -f test.txt

re: fclean $(NAME)
