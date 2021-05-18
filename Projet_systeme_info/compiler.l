%{
	#include <stdlib.h>
	#include <string.h>
    #include "y.tab.h"
%}

integer_nb [-]?[0-9]+
float_nb [-]?[0-9]+,[0-9]*
name [_a-zA-Z][_a-zA-Z0-9]*
space [ \t]
newline [\n]+

%% 

if {return tIF;}
else {return tELSE;}
while {return tWHILE;}
main {return tMAIN;}

"printf" {return tPRINTF;}
"{" {return tACCG;}
"}" {return tACCD;}
"(" {return tPG;}
")" {return tPD;}
"int" {return tINT;}

{integer_nb}	{
			yylval.integer = atoi(yytext);
			return tINT_NUM;
		}
{name}		{
			yylval.string = strdup(yytext);
			return tNAME;
		}
{space}		{}
{newline}	{}

"+" {return tPLUS;}
"-" {return tMOINS;}
"/" {return tSLASH;}
"*" {return tSTAR;}
"=" {return tEQUAL;}

"," {return tCOMA;}
";" {return tPCOMA;}
"&" {return tET;}



%%

int yywrap(void){
    return 1;}

int yyerror(char * str){
    extern int yylineno;
    fprintf(stderr,"Error line %d %s\n",yylineno,str);
}

