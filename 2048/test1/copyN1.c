#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#include <math.h>
#include "testgrid.h"

struct grid_s{
  tile **grid;
  int **case_empty;  //stock les coordonnées des cases vides dans un tableau 2D
  int nbr_case_empty;
  long score;
};

static void grid_case_empty(grid g);

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
  for (int i=0;i<GRID_SIDE;i++)
    for(int j=0;j<GRID_SIDE;j++)
      set_tile(dst,i,j,get_tile(src,i,j)); //utilisation des accesseurs pour lire et modifier.
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





static void grid_case_empty(grid g){
  int a=0; //conteur tableau case vide
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


void do_move (grid g, dir d){
    for(int i=0; i<GRID_SIDE; i++){
        int cpt2 = 0; // cpt2 permet de coller les chiffres si il y a eu un déplacement antérieur.
        for(int j=0; j<GRID_SIDE; j++){
            int cpt = 0;
            switch(d){
            case UP:
                cpt = j+1;
                while(cpt<GRID_SIDE){
                    fusion(g, i, j, &cpt, cpt2);
                    cpt += 1;
                }
            case DOWN:
                j = GRID_SIDE-j-1;
                cpt = j-1;
                while(cpt>0){
                    fusion(g, i, j, &cpt, cpt2);
                    cpt -= 1;
                }
            case LEFT:
                i = GRID_SIDE-i-1;
                cpt = j+1;
                while(cpt<GRID_SIDE){
                    fusion(g, i, j, &cpt, cpt2);
                    cpt += 1;
                }
            case RIGHT:
                j = GRID_SIDE-j-1;
                cpt = j-1;
                while(cpt>0){
                    fusion(g, i, j, &cpt, cpt2);
                    cpt -= 1;
                }
            }
        }
    }
}

void fusion(grid g, int i, int j, int *cpt, int cpt2){
    int tmp = *cpt;
    if(g->grid[i][*cpt] != 0 && (g->grid[i][j]==0 || g->grid[i][j] == g->grid[i][*cpt])){
        if(g->grid[i][j]==0)
            g->grid[i][j] = g->grid[i][*cpt];
        else
            g->grid[i][j] += g->grid[i][*cpt];
        g->grid[i][*cpt] = 0;
        cpt = GRID_SIDE;
        cpt2 = GRID_SIDE-1-j;
    }
    while(cpt2 > 1){
      g->grid[i][tmp] = g->grid[i][tmp+1];
      g->grid[i][tmp+1] = 0;
      tmp +=1;
      cpt2-=1;
    }
}

