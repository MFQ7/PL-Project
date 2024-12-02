

%{
#include <stdio.h>
#include <stdlib.h>

int yylex(void);
void yyerror(const char *s);
void customerror(const char *s);
%}

%token INTEGER IMAGINARY
%token NEWLINE QUIT
%token PLUS MINUS TIMES DIVIDE
%token LPAREN RPAREN

%left PLUS MINUS
%left TIMES DIVIDE
%right UMINUS

%%
program:
    expression
    line
    ;
expression:
    term
    | expression PLUS term
    | expression MINUS term
    ;

term:
    factor
    | term TIMES factor
    | term DIVIDE factor
    ;

factor:
    INTEGER
    | IMAGINARY
    | MINUS factor
    | LPAREN expression RPAREN
    | LPAREN error { customerror("Unmatched '('"); yyclearin; }
    ;
line:
    NEWLINE {printf("Seems Fine to me!\n"); yyclearin;}
%%

void yyerror(const char *s) {
    fprintf(stderr, "Parser Error: %s\n", s);
}
void customerror(const char *s) {
    fprintf(stderr, "WOW! You really did that. %s\n", s);
}

int main(void) {
    printf("Enter expressions (Ctrl+D to exit):\n");
    return yyparse();
}

