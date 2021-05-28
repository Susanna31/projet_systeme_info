#include <stdio.h>
#include <stdlib.h>  
#define SIZE 100

struct Instruction{
    char nom[4];
    int a_resultat;
    int a_op1;
    int a_op2;
};
struct Instruction table[SIZE];
int current_index = 0;

//la plupart des instructions assembleur comportent 4 paramètres
void add_instruc(char*n,int r,int o1,int o2){
    table[current_index].nom[0] = n;
    table[current_index].a_resultat = r;
    table[current_index].a_op1 = o1;
    table[current_index].a_op2 = o2;  
    current_index++;
} 

//que le if que l'on voudra potentiellement modifier
//instruc = f correspond à jmf et p à jmp
void modify(int index,int remplacement,char instruc){
    if(instruc == 'f'){ 
        table[index].a_op1 = remplacement; 
    } 
    else if(instruc == 'p'){
        table[index].a_resultat = remplacement; 
    } 
}

int get_index(){
    return current_index;
}

void write_in_file(FILE * fichier){
    for (int i=0; i<current_index; i++){
        if(table[i].a_op2 != (-2))
            fprintf(fichier,"%s %d %d %d\n", table[i].nom, table[i].a_resultat, table[i].a_op1, table[i].a_op2);
        else if(table[i].a_op1 != (-2))
            fprintf(fichier,"%s %d %d\n", table[i].nom, table[i].a_resultat, table[i].a_op1);
        else
            fprintf(fichier, "%s %d\n", table[i].nom, table[i].a_resultat);
    }
} 