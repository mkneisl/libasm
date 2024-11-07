NAME = libasm.a
BIN = bin
FILE_NAMES = ft_write ft_read  ft_strlen ft_strcpy ft_strcmp ft_strdup
BONUS_FILE_NAMES = ft_atoi_base ft_list_new
TEST_FILE = ./tests/main.c
TEST_FILE++ = ./tests/main.cpp
OBJ_FILES = $(addprefix $(BIN)/, $(addsuffix .o , $(FILE_NAMES)))
BONUS_OBJ_FILES = $(addprefix $(BIN)/bonus/, $(addsuffix .o , $(BONUS_FILE_NAMES)))
ASM_FILES = $(addprefix ./src/, $(addsuffix .asm , $(FILE_NAMES)))
ASM_DEBUG_INFO = -g -F dwarf
CFLAGS = -Werror -Wall -Wextra
CPPFLAGS = -std=c++2a
OS_NAME = $(shell uname -s)
DIR_GUARD=@mkdir -p $(@D)

all: $(NAME)

$(NAME): $(OBJ_FILES)
	ar rc $(NAME) $(OBJ_FILES)

bonus: $(BONUS_OBJ_FILES)
	ar rc $(NAME) $(OBJ_FILES) $(BONUS_OBJ_FILES)

$(BIN)/%.o: ./src/%.asm
	$(DIR_GUARD)
ifeq ($(OS_NAME), Darwin)
	nasm -f macho64 $< -o $@
else ifeq ($(OS_NAME), Linux)
	nasm -f elf64 $< -o $@
else
	@echo "[ERROR]: Unsupported OS!"
	@exit 1
endif

# $(BIN):
# 	@mkdir $(BIN)

testsc: $(NAME) $(TEST_FILE)
	cc  $(CFLAGS) $(TEST_FILE) $(NAME) -o $@

tests++: $(NAME) $(TEST_FILE++)
	c++ $(CFLAGS) $(CPPFLAGS) $(TEST_FILE++) $(NAME) -o $@

clean:
	@rm -rf $(BIN)

fclean: clean
	@rm -f $(NAME)
	@rm -f tests++
	@rm -f testsc
	@rm -f test.txt

re: fclean $(NAME)
