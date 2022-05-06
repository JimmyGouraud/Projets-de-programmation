#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#include <math.h>
#include "grid.h"

struct grid_s{
    tile **grid;
    int **case_empty;  //stock les coordonnées des cases vides dans un tableau 2D
    int nbr_case_empty;
    long score;
};

static void deplacer(tile **t,int i, int j ,int a , int b);
static void deplacement ( tile **t,int i, int j,int a, int b );
static void fusion (tile **t,int i,int j, int i1,int j1);
static void grid_case_empty(grid g);

int main(int argc,char **argv){
    grid g = new_grid();
    for (int i=0;i<GRID_SIDE;i++){
        for (int j=0;j<GRID_SIDE;j++){
            if((i+j)<3)
                set_tile(g,i,j,2);
            else
                set_tile(g,i,j,4);
            printf("%d",get_tile(g,i,j));
        }
        printf("\n");
    }
    for (int i=0;i<1000;i++){
        do_move(g,UP);
        do_move(g,DOWN);
        do_move(g,LEFT);
        do_move(g,RIGHT);
    }
    for (int i=0;i<GRID_SIDE;i++){
        for (int j=0;j<GRID_SIDE;j++){
            printf("%d",get_tile(g,i,j));
        }
        printf("\n");
    }
    printf("\n");
}

grid new_grid (){
    grid g = malloc(sizeof(struct grid_s));
    assert(g); //verification existence

    assert (g->grid = malloc(sizeof(tile*)*GRID_SIDE));
    assert (g->case_empty = malloc(sizeof(int*)*GRID_SIDE*GRID_SIDE)); // initialisation tableau case vide.
    for(int i=0; i< GRID_SIDE; i++){
        assert (g->grid[i] = malloc(sizeof(tile)*GRID_SIDE));
        for(int j=0; j< GRID_SIDE; j++) // initilisation grille a zero
            set_tile(g,i,j,0);
    }
    for (int i=0; i<GRID_SIDE*GRID_SIDE;i++){
        assert (g->case_empty[i] = malloc(sizeof(int)*2));   // creation deuxieme colonne du tableau de case vide
    }
    g->nbr_case_empty=16;
    g->score = 0;
    grid_case_empty(g);
    return g;
}


void delete_grid (grid g){
    assert ( g!=NULL && g->grid!=NULL);
    for(int i = 0; i< GRID_SIDE; i++){
        assert( g->grid[i] != NULL);
        free(g->grid[i]);
    }
    free(g->grid);
    free(g);
}


void copy_grid (grid src,grid dst){
    assert (src!=NULL && dst!=NULL);
    for (int i=0;i<GRID_SIDE;i++){
        for(int j=0;j<GRID_SIDE;j++)
            set_tile(dst,i,j,get_tile(src,i,j)); //utilisation des accesseurs pour lire et modifier.
    }
}

unsigned long int grid_score (grid g){
    assert(g!=NULL);
    return g->score;
}

tile get_tile(grid g,int x, int y){
    assert( 0<=x && x<GRID_SIDE && 0<=y && y<GRID_SIDE); // verification si coordonnées sont dans la grille
    return g->grid[x][y];
}

void set_tile(grid g,int x, int y, tile t){
    assert( 0<=x && x<GRID_SIDE && 0<=y && y<GRID_SIDE);// verification si coordonnées sont dans la grille
    g->grid[x][y]=t;
}

//bool can_move (grid g, dir d);


/* bool game_over(grid g){ */
/*   assert (g!=NULL); */
/*   return can_move(g,UP)==false && can_move(g,LEFT)==false && can_move(g,RIGHT)==false && can_move(g,DOWN)==false; //si aucun deplacement alors retourne true sinon retourne false */
/* } */



 void do_move (grid g, dir d){
    switch (d){
    case UP:
        deplacement(g->grid,0,0,1,0);
        break;
    case DOWN:
        deplacement(g->grid,3,0,-1,0);
        break;
    case LEFT:
        deplacement(g->grid,0,0,0,1);
        break;
    case RIGHT:
        deplacement(g->grid,0,3,0,-1);
        break;
    default:
        break;
    }
}



static void grid_case_empty(grid g){
    int a=0; //compteur tableau case vide
    for(int i=0; i<GRID_SIDE; i++){
        for(int j = 0; j< GRID_SIDE; j++){
            if(g->grid[i][j] == 0){
                g->case_empty[a][0]=i;
                g->case_empty[a][1]=j;
                a++;
            }
        }
    }
    g->nbr_case_empty=a+1;
}


void add_tile (grid g){
    int position_aleatoire = rand()%g->nbr_case_empty;
    int nombre_tile = rand()%10;
    int x = g->case_empty[position_aleatoire][0];
    int y = g->case_empty[position_aleatoire][1];
    if (nombre_tile==9)
        set_tile(g,x,y,pow(2,2));
    else
        set_tile(g,x,y,pow(2,1));
    grid_case_empty(g);
}


/* void play (grid g, dir d){ */
/*   if(can_move(g, d)){ */
/*     do_move(g, d); */
/*     add_tile(g); */
/*   } */
/* } */


// srand(time(NULL)) //dans le main include time.h


void fusion (tile **t,int i,int j, int i1,int j1){
    t[i][j]+=t[i1][j1];
    t[i1][j1]=0;
}

void deplacer(tile **t, int i, int j ,int a , int b){
    if (a==1){
        while(i>=0 && i<3){
            t[i][j]=t[i+a][j];
            i+=a;
        }
    }
    if (a==-1){
        while(i>0 && i<=3){
            t[i][j]=t[i+a][j];
            i+=a;
        }
    }
    if (b == 1){
        while(j>=0 && j<3){
            t[i][j]=t[i][j+b];
            j+=b;
        }
    }
    if (b == -1){
        while(j>0 && j<=3){
            t[i][j]=t[i][j+b];
            j+=b;
        }
    }
  t[i][j]=0;
}

/*
 *la fonction deplacement permet de deplacer dans n'importe qu'elle direction selon les paramettre passé.
 */

void deplacement ( tile **t,int i, int j,int a, int b ){
    int cpt=0; // sert à executer 4 fois le procédé
    int tmp1=i;
    int tmp2=j;
    while (cpt<4){
        int compZero=0;  // boucle au maximum 4 fois si on tombe sur des 0

        // boucle qui fusionne et deplace les lignes ou les colones selon se que l'on veut.
        while(compZero<GRID_SIDE && 0<=i && i<GRID_SIDE && 0<=j && j<GRID_SIDE ){
            // deplace la ligne si on tombe sur un 0.
            if (t[i][j]==0){
                deplacer(t,i,j,a,b);
                compZero++;
            }
            // fusion si deux cases sont identique
            else if (t[i][j]==t[i+a][j+b]){
                fusion(t,i,j,i+a,j+b);
                i+=a;
                j+=b;
            }
            // si non identique et non egale a 0 on passe a la case suivante
            else{
                i+=a;
                j+=b;
            }
        }
        // change de colonne et reintialise la ligne de depart
        if( a==-1 || a==1 ){
            j++;
            i=tmp1;
            cpt++;
        }
        // change de ligne et reinistialise la colonne de depart
        else{
            i++;
        j=tmp2;
        cpt++;
        }
    }
}

