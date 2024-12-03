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

program_line: NEWLINE { printf("Enter expressions in the form of complex numbers \"(a ± bi)\". (Ctrl+D to exit):\n"); }
        | multi_expression NEWLINE { printf("Seems Good!\n"); }
        | error NEWLINE { yyerrok; printf("Recovered from error.\n");}
        ;

multi_expression: enclosed_expression
        | multi_expression addop enclosed_expression
	| multi_expression multop enclosed_expression
        ;

enclosed_expression: LPAREN expression RPAREN
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
    printf("Enter expressions in the form of complex numbers \"(a ± bi)\". (Ctrl+D to exit):\n");
    return yyparse();
}
