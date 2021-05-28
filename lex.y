%{
    #include <stdio.h>
    #include <stdlib.h>
    #include "pile.h"
    #include "table_symbole.h"
    #include "table_instructions.h" 


    int yylex();
    int yydebug = 1;
    int yyerror(char*);
    FILE * fichier = NULL;
%}

%union {
	int integer;
    char * string;
	}

%token tIF tELSE tWHILE tMAIN tACCG tACCD tPRINTF tPG tPD tCONST tINT tFLOAT tINT_NUM tFLOAT_NUM tNAME tPLUS tMOINS tSLASH tSTAR tEQUAL tINF tSUP tSPACE tCOMA tET tPCOMA tTAB tENTREE

%right tEQUAL
%left tPLUS tMOINS
%left tSTAR tSLASH

%type <integer>	tINT_NUM
%type <integer> tPG
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
        //fprintf (fichier,"COP %d %d\n",address,addressVar);
        add_instruc("COP", address, addressVar, -1);
    }
    
    ;
If:
    tIF tPG Expression{/*fprintf(fichier, "JMF %d %d\n", pop(), -1);*/  
    $2 = get_index();
    int address = pop();
    add_instruc("JMF", address,-1, -1);
    }  
    tPD tACCG Instructions tACCD {//fprintf(fichier, "JMP %d", -1);
    modify($2,get_index()+1,f);
    $2 = get_index();
    add_instruc("JMP", -1, -1, -1);
    }
    
    Else
    {
        printf ("If else\n");
        modify($2,get_index(),p);
    }
    | tIF tPG tINT_NUM tPD tACCG Instructions tACCD
    {
        printf ("If sans else\n");
        int address = pop();
        add_instruc("JMF", address, get_index(), -1); 
    }
    ;

Else:
    tELSE tACCG Instructions tACCD
    ;

Printf:
    tPRINTF tPG tNAME tPD
    {
        //int address = push();
        int address = getAddress($3);
        //fprintf (fichier,"PRI %d\n",address);
        add_instruc("PRI",address,-1,-1);
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
        //fprintf (fichier,"COP %d %d\n",address,tNameAddress);
        add_instruc("COP",address,tNameAddress, -1);
    }

    | tINT_NUM
    {
        printf ("tINT_NUM \n");
        int address = push();
        //fprintf (fichier,"AFC %d %d\n",address,$1);
        add_instruc("AFC",address,$1,-1);
    }

    | tPG Expression tPD
    {}

    | Expression tPLUS Expression
    {
        printf ("Expression + \n");
        int address1 = pop();
        int address2 = pop();
        int raddress = push();
        //fprintf (fichier,"ADD %d %d %d\n",raddress,address1,address2);
        add_instruc("ADD",raddress, address1, address2);
    }

    | Expression tSTAR Expression
    {
        printf ("Expression * \n");
        int address1 = pop();
        int address2 = pop();
        int raddress = push();
        //fprintf (fichier,"MUL %d %d %d\n",raddress,address1,address2);
        add_instruc("MUL", raddress, address1, address2);
    }

    | Expression tMOINS Expression
    {
        printf ("Expression - \n");
        int address1 = pop();
        int address2 = pop();
        int raddress = push();
        //fprintf (fichier,"SOU %d %d %d\n",raddress,address1,address2);
        add_instruc("SOU", raddress, address1, address2);
    }

    | Expression tSLASH Expression
    {
        printf ("Expression / \n");
        int address1 = pop();
        int address2 = pop();
        int raddress = push();
        //fprintf (fichier,"DIV %d %d %d\n",raddress,address1,address2);
        add_instruc("DIV", raddress, address1, address2);
    }
    | Comparaison{} 
    ;

Comparaison: 
    Expression tEQUAL tEQUAL Expression 
    {
        int address1 = pop();
        int address2 = pop();
        int raddress = push();
        add_instruc("EQU", raddress, address1, address2);
    }
    Expression tINF Expression
    {
        int address1 = pop();
        int address2 = pop();
        int raddress = push();
        add_instruc("INF", raddress, address1, address2);
    } 
    Expression tSUP Expression
    {
        int address1 = pop();
        int address2 = pop();
        int raddress = push();
        add_instruc("SUP", raddress, address1, address2);
    } 
    ;

%%

int main()
{
    init_pile();
    fichier = fopen("asm.txt","w");
    write_in_file(fichier);
    if (fichier == NULL){printf("Impossible d'ouvrir le fichier test.txt");};
    yyparse(); 
    return 0;
}
