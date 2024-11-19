NAME = libasm.a
BIN = bin

FILE_NAMES = ft_write \
			ft_read \
			ft_strlen \
			ft_strcpy \
			ft_strcmp \
			ft_strdup
BONUS_FILE_NAMES = ft_atoi_base \
				ft_list_new \
				ft_list_push_front \
				ft_list_sort \
				ft_list_remove_if \
				ft_list_size

OBJ_FILES = $(addprefix $(BIN)/, $(addsuffix .o , $(FILE_NAMES)))
BONUS_OBJ_FILES = $(addprefix $(BIN)/bonus/, $(addsuffix .o , $(BONUS_FILE_NAMES)))

TEST_FILE_MANDATORY = ./tests/mandatory.cpp
TEST_FILE_BONUS = ./tests/bonus.c

ASM_DEBUG_INFO = -g -F dwarf
CFLAGS = -Werror -Wall -Wextra
CPPFLAGS = -std=c++2a

OS_NAME = $(shell uname -s)
DIR_GUARD=@mkdir -p $(@D)
BONUS_FILE=$(shell ar -t $(NAME) 2>/dev/null | grep ft_atoi_base)

all: $(NAME)

$(NAME): $(OBJ_FILES)
	ar rc $(NAME) $(OBJ_FILES)

bonus: $(BONUS_OBJ_FILES) $(OBJ_FILES)
ifeq ($(BONUS_FILE), ft_atoi_base.o)
	@echo "make: Nothing to be done for \`bonus'."
else
	ar rc $(NAME) $(OBJ_FILES) $(BONUS_OBJ_FILES)
endif

$(BIN)/%.o: ./src/%.s
	$(DIR_GUARD)
ifeq ($(OS_NAME), Darwin)
	nasm -f macho64 $< -o $@
else ifeq ($(OS_NAME), Linux)
	nasm -f elf64 $< -o $@
else
	@echo "[ERROR]: Unsupported OS!"
	@exit 1
endif

mandatoryTests: $(NAME) $(TEST_FILE_MANDATORY)
	c++ $(CFLAGS) $(CPPFLAGS) $(TEST_FILE_MANDATORY) $(NAME) -o $@

bonusTests: $(TEST_FILE_BONUS)
ifneq ($(BONUS_FILE), ft_atoi_base.o)
	$(MAKE) bonus
endif
	cc  $(CFLAGS) $(TEST_FILE_BONUS) $(NAME) -o $@

clean:
	@rm -rf $(BIN)

fclean: clean
	@rm -f $(NAME)
	@rm -f mandatoryTests
	@rm -f bonusTests
	@rm -f test.txt

re: fclean $(NAME)
