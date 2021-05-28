//typedef struct Symbole Symbole;
#include <string.h>

#define SIZE 50

struct Symbole
{
    char * var;

};
struct Symbole tab[SIZE];
int next_var_index = 0;

void addVar(char * name){
    tab[next_var_index].var = name;
    next_var_index++;
}

int getAddress(char * id){
    int index = -1;
    for (int i=0 ; i<next_var_index ; i++){
        if (strcmp(id,tab[i].var)==0){
            index = i;
        }
    }
    return &tab[index];
}

