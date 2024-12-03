%{
#include <stdio.h>
#include <stdlib.h>

int yylex(void);
void yyerror(const char *s);
%}

%define parse.error verbose

%token INTEGER IMAGINARY
%token NEWLINE
%token PLUS MINUS TIMES DIVIDE
%token LPAREN RPAREN

%left PLUS MINUS
%left TIMES DIVIDE
%right UMINUS

%%
program:
	program_line
    	| program program_line
    	;

program_line: NEWLINE { printf("Enter expressions (Ctrl+D to exit or you can control this D):\n"); }
    	| expression NEWLINE { printf("Seems good!\n"); }
	| error NEWLINE { yyerrok; printf("Recovered from error.\n");}
    	;
expression: term
        | expression addop term
        ;

term: factor
	| term multop factor
     	;

factor: INTEGER
       	| IMAGINARY
       	| MINUS factor
       	| LPAREN expression RPAREN
       	;
addop: PLUS | MINUS ;
multop: TIMES | DIVIDE ;
%%

void yyerror(const char *s) {
    fprintf(stderr, "Parser Error: %s\n", s);
}
int main(void) {
    printf("Enter expressions (Ctrl+D to exit or you can control this D):\n");
    return yyparse();
}
