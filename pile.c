#include "pile.h"



#define SIZE_PILE 50
//#define BEGIN_PILE 100

struct Pile
{
    int address;
};
struct Pile pile[SIZE_PILE];
int top_pile;

void init_pile(){
    top_pile = 0;
}

int push() {
    //if (top_pile >= (BEGIN_PILE+SIZE_PILE-1)){return -1;}
    if (top_pile >= (SIZE_PILE-1)){return -1;}
    return &pile[top_pile++];
}

int pop() {
    //if (top_pile == (BEGIN_PILE-1)){return -1;}
    if (top_pile == 0){return -1;} 
    //top_pile--;
    return &pile[--top_pile];
}

