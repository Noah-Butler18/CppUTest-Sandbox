#------- Regular build configuration makefile -------#
# Tool definitions
CC ?= gcc

# Build settings
SRC_DIR = ./src
TEST_DIR = ./tests
BUILD_DIR = .
BUILD_NAME = app.elf

# Search path for header files
# We want to include a header file in our main.c that is no in the same directory as main.c
# So, we have to instruct the compiler on where to find the header file using -I
CFLAGS += -I $(SRC_DIR)/kv_store

# List module source files
# Wildcard symbol (%, *, etc) expansion happens automatically in rules, but wildcard expansion does not normally take place when a variable is set, or inside the arguments of a function. 
# If you want to do wildcard expansion in such places, you need to use the wildcard function, like this:
# $(wildcard pattern…)
CSOURCES = $(SRC_DIR)/main.c
CSOURCES += $(wildcard $(SRC_DIR)/kv_store/*.c)
# $(wildcard $(SRC_DIR)/kv_store/*.c) effectively expands into all .c files (source files) in the ./src/kv_store directory

# Compiler flags
CFLAGS += -Wall

# Linker flags
LDFLAGS += 

# Generate names for output object files (*.o) of each source file 
# Uses built-in make function patsubst "pattern string substitute"  
# syntax: $(patsubst pattern,replacement,text)
# patsubst finds whitespace-separated words in text that match pattern and replaces them with replacement
COBJECTS += $(patsubst %.c, %.o, $(CSOURCES))

# Default rule: build application
.PHONY: all
all : $(BUILD_NAME)

# Build components (individual object files)
# The first line here is an expansion, not a rule. It takes the *.o files in CSOURCES and expands them out to both .o and .c files for the following recipe
# This is required because without this line, make would not be able to find any .c files (they are in src, not the local directory with the makefile)
$(COBJECTS) : %.o : %.c
%.o : %.c
	$(CC) $(CFLAGS) -c $< -o $@
# No build directory is specified for this recipe, it will be default put the .o files in the same directory where the .c files reside
# -c flag = gcc flag that gets parsed by the bash shell. Tells compiler to stop at object file stage, and to not link the files.
# 	-c is needed for running unit tests within each .o file later; each source file should build independently 
# $< = first symbol in prerequisite
# $@ = target of the rule, in this case it would be %.o

# Build the target application
.PHONY: $(BUILD_NAME)
$(BUILD_NAME) : $(COBJECTS)
	$(CC) $(COBJECTS) -o $(BUILD_DIR)/$(BUILD_NAME) $(LDFLAGS)

# Remove any object files (Uses BASH command rm)
.PHONY: clean
clean:
	rm -f $(COBJECTS) $(BUILD_NAME)
# -f flag = Do not prompt user before removing files

# Run tests from home directory of project
.PHONY: test
test:
	make -C $(TEST_DIR)

#clean test directories of any object files, etc.
.PHONY: test_clean
test_clean:
	make -C $(TEST_DIR) clean





# ------ CppUTest makefile configurations ------#
# Set home directory of CppUTest
#CPPUTEST_HOME ?= /usr
#TARGET_PLATFORM ?= x86_64-linux-gnu

# Define compiler and linker flags
#CPPFLAGS += -I$(CPPUTEST_HOME)/include
#CXXFLAGS += -include $(CPPUTEST_HOME)/include/CppUTest/MemoryLeakDetectorNewMacros.h
#CFLAGS += -include $(CPPUTEST_HOME)/include/CppUTest/MemoryLeakDetectorMallocMacros.h

#LD_LIBRARIES = -L$(CPPUTEST_HOME)/lib -lCppUTest -lCppUTestExt

# Define source files and test files
#SOURCES = unittest_practice/main.c unittest_practice/kv_store.c
#TESTS = unittest_practice/tests/test_kv_store.cpp

# Define the target for building the test executable
#test: $(TESTS) $(SOURCES)
#	$(CC) $(CXXFLAGS) $(CFLAGS) $(CPPFLAGS) $(TESTS) $(SOURCES) -o test $(LDFLAGS)

# Define the target for running the tests
#run: test
#	./test



# Default target
#all: test run





