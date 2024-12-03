%{
#include "parserizer.tab.h"
%}

%%
[0-9]+        	{ return INTEGER; }
[0-9]+i 	{ return IMAGINARY; }
"i"   		{ return IMAGINARY; }
"+"           	{ return PLUS; }
"-"           	{ return MINUS; }
"*"           	{ return TIMES; }
"/"           	{ return DIVIDE; }
"("           	{ return LPAREN; }
")"           	{ return RPAREN; }
[ \t]       	; /* Skip whitespace */
\n 		{ return NEWLINE;}
.             	{ fprintf(stderr, "Scanner Error: Invalid character '%s'\n", yytext); }
%%

int yywrap(void) {
    return 1;
}
