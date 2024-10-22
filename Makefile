NAME = libasm.a
BIN = bin
FILE_NAMES = ft_read ft_write ft_strlen ft_strcpy
TEST_FILE = ./tests/main.c
TEST_FILE++ = ./tests/main.cpp
OBJ_Files = $(addprefix $(BIN)/, $(addsuffix .o , $(FILE_NAMES)))
ASM_FILES = $(addprefix ./src/, $(addsuffix .asm , $(FILE_NAMES)))

all: $(NAME)

$(NAME): $(OBJ_Files)
	ar rc $(NAME) $(OBJ_Files)

$(BIN):
	mkdir $(BIN)

$(BIN)/%.o: ./src/%.asm $(BIN)
	nasm -f elf64  $< -o $@

tests: $(NAME)
	gcc $(TEST_FILE) $(NAME)

ctests: $(NAME)
	g++  $(TEST_FILE++) $(NAME)

clean:
	rm -rf $(BIN)

fclean: clean
	rm -f $(NAME)

re: fclean $(NAME)
