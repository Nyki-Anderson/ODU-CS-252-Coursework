# Macro definitions for "standard" language compilations
#
# First, define special compilation flags. These may change when we're done testing and debugging.
CPPFLAGS=-g -DDEBUG
#
# The following is "boilerplate" to set up the standard compilation
# commands:
.SUFFIXES:
.SUFFIXES: .cpp .c .cpp .h .o
.c.o: ; gcc $(CPPFLAGS) -c $*.cpp
.cpp.o: ;  g++ $(CPPFLAGS) -c $*.cpp
#
# Targets:
#
all: computeSqrt

clean:
	rm *.o

computeSqrt: computeSqrt.o sqrt.o
	g++ $(CPPFLAGS) computeSqrt.o sqrt.o
	mv a.out computeSqrt

computeSqrt.o: computeSqrt.cpp sqrt.h

sqrt.o: sqrt.cpp sqrt.h
