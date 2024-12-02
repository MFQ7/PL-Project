%{
#include "parserizer.tab.h"
extern char *yytext;
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
q		{ return QUIT;}
.             	{ 
              	fprintf(stderr, "Bro, WHAT? I can't read this.\nScanner Error: Invalid character '%s'\n", yytext); 
    		return 0; 
    		}
%%

int yywrap(void) {
    return 1;
}

