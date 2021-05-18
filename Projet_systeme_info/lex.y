%{
    #include <stdio.h>
    #include <stdlib.h>
    #include "pile.h"
    #include "table_symbole.h"

    int yylex();
    int yydebug = 1;
    int yyerror(char*);
    FILE * fichier = NULL;
%}

%union {
	int integer;
    char * string;
	}

%token tIF tELSE tWHILE tMAIN tACCG tACCD tPRINTF tPG tPD tCONST tINT tFLOAT tINT_NUM tFLOAT_NUM tNAME tPLUS tMOINS tSLASH tSTAR tEQUAL tSPACE tCOMA tET tPCOMA tTAB tENTREE

%right tEQUAL
%left tPLUS tMOINS
%left tSTAR tSLASH

%type <integer>	tINT_NUM
%type <string> tNAME

%%

Main:
    tMAIN tPG tPD Body
    {printf ("Main\n");}
    |
    {printf ("Fichier vide\n");}
    ;

Body:
    tACCG Declarations Instructions tACCD
    {printf ("Body\n");}
    | tACCG tACCD
    {printf ("Body vide\n");}
    ;

Declarations:
    Declaration tPCOMA Declarations
    | Declaration tPCOMA
    ;

Declaration:
    Type tNAME tEQUAL tINT_NUM 
    {
        printf ("Declaration et initialisation\n");
        addVar($2);
    }
    | Type tNAME tCOMA Declaration_else
    {
        printf ("Declaration multiple (a,b,c;)\n");
        addVar($2);
    }
    | Type tNAME 
    {
        printf ("Declaration simple\n");
        addVar($2);
    }
    ;

Declaration_else:
    tNAME tCOMA Declaration_else
    {
        addVar($1);
    }
    |
    tNAME
    {
        addVar($1);
    }
    ;

Instructions:
    Instruction tPCOMA Instructions
    | Instruction tPCOMA
    | 
    ;

Instruction:
    Printf 
    {printf ("Instruction printf\n");}
    | tNAME tEQUAL Expression 
    {
        printf ("Instruction arithmetique\n");
        int address = getAddress($1);
        int addressVar = pop();
        fprintf (fichier,"COP %d %d\n",address,addressVar);
    }
    
    ;
If:
    tIF tPG Comparaison tPD tACCG Instructions tACCD Else
    {
        printf ("If else\n");
    }
    | tIF tPG Expression tPD tACCG Instructions tACCD
    {
        printf ("If sans else\n");
    }
    | tIF tPG tINT_NUM tPD tACCG Instructions tACCD
    {
        printf ("If sans else\n");
    }
    ;

Else:
    tELSE tACCG Instructions tACCD
    ;

Printf:
    tPRINTF tPG tNAME tPD
    {
        int address = push();
        fprintf (fichier,"PRI %d\n",address);
    }
    |
    tPRINTF tPG tPD
    ;

Type: 
    tINT | tFLOAT 
    ;


Expression:
    tNAME
    {
        printf ("tNAME \n");
        int address = push();
        int tNameAddress = getAddress($1);
        fprintf (fichier,"COP %d %d\n",address,tNameAddress);
    }

    | tINT_NUM
    {
        printf ("tINT_NUM \n");
        int address = push();
        fprintf (fichier,"AFC %d %d\n",address,$1);
    }

    | tPG Expression tPD
    {}

    | Expression tPLUS Expression
    {
        printf ("Expression + \n");
        int address1 = pop();
        int address2 = pop();
        int raddress = push();
        fprintf (fichier,"ADD %d %d %d\n",raddress,address1,address2);
    }

    | Expression tSTAR Expression
    {
        printf ("Expression * \n");
        int address1 = pop();
        int address2 = pop();
        int raddress = push();
        fprintf (fichier,"MUL %d %d %d\n",raddress,address1,address2);
    }

    | Expression tMOINS Expression
    {
        printf ("Expression - \n");
        int address1 = pop();
        int address2 = pop();
        int raddress = push();
        fprintf (fichier,"SOU %d %d %d\n",raddress,address1,address2);
    }

    | Expression tSLASH Expression
    {
        printf ("Expression / \n");
        int address1 = pop();
        int address2 = pop();
        int raddress = push();
        fprintf (fichier,"DIV %d %d %d\n",raddress,address1,address2);
    }
    ;

Comparaison: 
    tNAME tEQUAL tEQUAL tINT_NUM
    {

    }
    |
    tNAME tEQUAL tEQUAL tNAME
    {

    }
    ;

%%

int main()
{
    init_pile();
    fichier = fopen("asm.txt","w");
    if (fichier == NULL){printf("Impossible d'ouvrir le fichier test.txt");};
    yyparse(); 
    return 0;
}
