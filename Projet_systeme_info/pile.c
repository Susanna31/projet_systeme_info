#include "pile.h"

#define SIZE_PILE 50
#define BEGIN_PILE 100

struct Pile
{
    int top_pile;
};
struct Pile p;

void init_pile(){
    p.top_pile = BEGIN_PILE;
}

int push() {
    if (p.top_pile >= (BEGIN_PILE+SIZE_PILE-1)){return -1;}
    return p.top_pile++;
}


int pop() {
    if (p.top_pile == (BEGIN_PILE-1)){return -1;}

    p.top_pile--;
    return p.top_pile;
}

