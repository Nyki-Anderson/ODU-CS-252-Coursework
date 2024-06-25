# Macro definitions for "standard" language compilations
# 
#  First, define special compilation flags. These may change when
#  we're done testing and debugging.
CFLAGS=-g -DDEBUG
# 
#  The following is "boilerplate" to set up the standard compilation
#  commands:
.SUFFIXES:
.SUFFIXES: .cpp .c .cpp .h .o
.c.o: ; gcc $(CFLAGS) -c $*.c
# 
# Targets:
#
all: cpp2html

cpp2html: cpp2html.o lex.yy.o
	gcc $(Cflags) cpp2html.o lex.yy.o
	mv a.out cpp2html

cpp2html.o: cpp2html.c

lex.yy.c: cppscanner.l
	flex cppscanner.l

lex.yy.o: lex.yy.c
