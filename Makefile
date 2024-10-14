# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fvon-der <fvon-der@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/07/28 04:26:53 by fvon-der          #+#    #+#              #
#    Updated: 2024/10/14 18:08:29 by fvon-der         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Colors for output
RESET_COLOR = \033[0;39m
YELLOW      = \033[0;93m
BLUE        = \033[0;94m
GREEN       = \033[0;92m
RED         = \033[1;31m

# Project settings
CC = 			cc
CFLAGS = -Wall -Wextra -Werror
DEBUG_FLAGS = -g -O0 -Wall -Wextra -Werror -fsanitize=address -fno-strict-aliasing
 # Default version if not specified
VERSION ?= v3
SRC_DIR = src/$(VERSION)
OBJ_DIR = obj/$(VERSION)
NAME_SERVER = server_$(VERSION)
NAME_CLIENT = client_$(VERSION)

# Source files
SRCS_SERVER = $(SRC_DIR)/server.c $(SRC_DIR)/utils.c
SRCS_CLIENT = $(SRC_DIR)/client.c $(SRC_DIR)/utils.c

# Object files
OBJS_SERVER = $(OBJ_DIR)/server.o $(OBJ_DIR)/utils.o
OBJS_CLIENT = $(OBJ_DIR)/client.o $(OBJ_DIR)/utils.o

# Ensure object directory exists
$(OBJ_DIR):
	@mkdir -p $(OBJ_DIR)

# Default rule to build server and client
all: $(NAME_SERVER) $(NAME_CLIENT)

# Server build rule
$(NAME_SERVER): $(OBJ_DIR) $(OBJS_SERVER)
	@echo "$(YELLOW)Compiling $(NAME_SERVER)...$(RESET_COLOR)"
	$(CC) $(CFLAGS) $(OBJS_SERVER) -o $(NAME_SERVER)
	@echo "$(GREEN)$(NAME_SERVER) compilation successful!$(RESET_COLOR)"

# Client build rule
$(NAME_CLIENT): $(OBJ_DIR) $(OBJS_CLIENT)
	@echo "$(YELLOW)Compiling $(NAME_CLIENT)...$(RESET_COLOR)"
	$(CC) $(CFLAGS) $(OBJS_CLIENT) -o $(NAME_CLIENT)
	@echo "$(GREEN)$(NAME_CLIENT) compilation successful!$(RESET_COLOR)"

# Rule to compile .o files from .c files
$(OBJ_DIR)/server.o: $(SRC_DIR)/server.c
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $(SRC_DIR)/server.c -o $@

$(OBJ_DIR)/client.o: $(SRC_DIR)/client.c
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $(SRC_DIR)/client.c -o $@

$(OBJ_DIR)/utils.o: $(SRC_DIR)/utils.c
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $(SRC_DIR)/utils.c -o $@

# Clean object files
clean:
	@echo "$(BLUE)Cleaning object files in $(OBJ_DIR)...$(RESET_COLOR)"
	rm -rf $(OBJ_DIR)
	@echo "$(GREEN)Object files cleaned!$(RESET_COLOR)"

# Clean everything
fclean: clean
	@echo "$(BLUE)Removing executables...$(RESET_COLOR)"
	rm -f $(NAME_SERVER) $(NAME_CLIENT)
	@echo "$(GREEN)Executables removed!$(RESET_COLOR)"

# Rebuild everything
re: fclean all

# Norminette target
norm:
	@echo "$(BLUE)Running Norminette...$(RESET_COLOR)"
	norminette $(SRCS_SERVER) $(SRCS_CLIENT)
	@echo "$(GREEN)Norminette check complete!$(RESET_COLOR)"


# Debug target
debug: clean
	@echo "$(RED)Compiling in debug mode...$(RESET_COLOR)"
	$(CC) $(DEBUG_FLAGS) $(SRCS_SERVER) -o $(NAME_SERVER)_debug
	$(CC) $(DEBUG_FLAGS) $(SRCS_CLIENT) -o $(NAME_CLIENT)_debug
	@echo "$(GREEN)Debug build complete!$(RESET_COLOR)"


# Version targets for different builds
v1: 
	@$(MAKE) VERSION=v1

v2: 
	@$(MAKE) VERSION=v2

v3: 
	@$(MAKE) VERSION=v3

.PHONY: all clean fclean re norm debug v1 v2 v3
