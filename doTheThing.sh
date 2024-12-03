#!/bin/bash

bison -d complex_parser.y
flex complex_lexer.l
gcc lex.yy.c complex_parser.tab.c -o complex

echo "YAY!"
