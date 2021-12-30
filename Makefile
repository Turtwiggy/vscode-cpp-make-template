#
# Make the "Example" main
#

CC = gcc
CXX = g++

# build dirs
BUILD_DIR = build
OBJ_DIR = build-objs
EXE = build/example.exe# This should match the launch.json output

PROJECT_DIR = src

DEBUG = 1#could be env variable? e.g. DEBUG = $(DEBUG)
CXXFLAGS =

#
# BUILD OPTIONS
#

ifeq ($(DEBUG), 1)
	CXXFLAGS += -g -Wall
endif
CXXFLAGS += -std=c++17 -Wformat
# CXXFLAGS += -O2

#
# INCLUDE DIRS
#
CXXFLAGS += -I$(PROJECT_DIR)

#
# SOURCE FILES
#

SOURCES = $(PROJECT_DIR)/main.cpp

OBJS = $(addprefix $(OBJ_DIR)/,$(addsuffix .o, $(basename $(notdir $(SOURCES)))))

#
# BUILD RULES
#

# Notes:
# $< is input file name
# $@ is output file name
# $^ is all the inputs
# $(outputs) all the outputs

$(OBJ_DIR)/%.o:$(PROJECT_DIR)/%.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

all: $(EXE)
	$(info Build complete for: $(EXE))

$(EXE): $(OBJS)
	$(CXX) -o $@ $^ $(CXXFLAGS)

# Create dirs if they don't exist

$(OBJS): | $(OBJ_DIR)

$(OBJ_DIR):
	mkdir "$(BUILD_DIR)" "$(OBJ_DIR)"