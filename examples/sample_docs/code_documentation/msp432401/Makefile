PROJECT_NAME=assembly_calculator
BOARD=msp432401R

SRC_DIR ?= src
OBJ_DIR ?= obj
BIN_DIR ?= bin

CC=arm-none-eabi-gcc
CFLAGS ?= -Ilib/TI/Include -Ilib/CMSIS/Include --specs=nosys.specs
AS=arm-none-eabi-as

TARGET=$(BIN_DIR)/$(BOARD)_$(PROJECT_NAME).elf

SRCS := $(shell find $(SRC_DIR) -name *.c -or -name *.s)

$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) $(LDFLAGS) $(SRCS) -o $@

$(OBJ_DIR)/%.o: $(SRCS)
	$(CC) $(CFLAGS) $(LDFLAGS) $(SRCS) -o $@

.PHONY: clean
clean:
	@rm -rf bin/* src/*.o

run:
	@echo "mspdebug tilib "prog $(BINDIR)/$(TARGET)""
	@mspdebug tilib "prog $(BINDIR)/$(TARGET)"

