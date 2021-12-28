#
# Make the "Example" main
#

CC = gcc
CXX = g++

# build dirs
BUILD_DIR = build
OBJDIR = build-objs
EXE = build/example.exe# This should match the launch.json output

PROJECT_DIR = src

DEBUG = 1
CXXFLAGS =

#
# BUILD OPTIONS
#

ifeq ($(DEBUG), 1)
	CXXFLAGS += -g -Wall
endif
CXXFLAGS += -std=c++17 -Wformat -Os
CXXFLAGS += -I$(PROJECT_DIR)

#
# SOURCE FILES
#

SOURCES = $(PROJECT_DIR)/main.cpp

OBJS = $(addprefix $(OBJDIR)/,$(addsuffix .o, $(basename $(notdir $(SOURCES)))))

#
# BUILD RULES
#

# Notes:
# $< is input file name
# $@ is output file name
# $^ is all the inputs
# $(outputs) all the outputs

$(OBJDIR)/%.o:$(PROJECT_DIR)/%.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

all: $(EXE)
	$(info Build complete for: $(EXE))

$(EXE): $(OBJS)
	$(CXX) -o $@ $^ $(CXXFLAGS)

# Create dirs if they don't exist

$(OBJS): | $(OBJDIR)

$(OBJDIR):
	mkdir "$(BUILD_DIR)" "$(OBJDIR)"