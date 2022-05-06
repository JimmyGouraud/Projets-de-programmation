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

static void deplacement ( grid g,int i, int j,int a, int b );
static tile fusion (tile *t,int i,int j);
static void grid_case_empty(grid g);
static bool possible(grid g, int i,int j,int a,int b);

grid
new_grid (){
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


bool game_over(grid g){
  assert (g!=NULL);
  return can_move(g,UP)==false && can_move(g,LEFT)==false && can_move(g,RIGHT)==false && can_move(g,DOWN)==false; //si aucun deplacement alors retourne true sinon retourne false
}

bool can_move(grid g,dir d){
  switch (d){
  case UP:
    return possible(g,0,0,1,0);
    break;
  case DOWN:
    return possible(g,3,0,-1,0);
    break;
  case LEFT:
    return possible(g,0,0,0,1);
    break;
  case RIGHT:
    return possible(g,0,3,0,-1);
    break;
  default:
    return false;
    break;
  }
}


void do_move(grid g, dir d){
  printf("do_move");
  switch (d){
  case UP:
    printf("UP");
    deplacement(g,0,0,1,0);
    break;
  case DOWN:
    //deplacement(g,3,0,-1,0);
    break;
  case LEFT:
    //deplacement(g,0,0,0,1);
    break;
  case RIGHT:
    //deplacement(g,0,3,0,-1);
    break;
  default:
    break;
  }
}



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


void play (grid g, dir d){
  if(can_move(g, d)){
    do_move(g, d);
    add_tile(g);
  }
}

static tile fusion (tile *t,int i,int j){
  return t[i]+=t[j];
}


static void reset_param(int *i, int *j, int tmpi, int tmpj,int a, int b){
  if ( a==-1 || a==1 )
    *i=tmpi;
  else
    *j=tmpj;
}

static void deplacement(grid g,int i, int j,int a, int b ){
  int tmpi=i;
  int tmpj=j;
  for (int cpt=0;cpt<4;cpt++){
    tile *s=malloc(4*sizeof(tile));
    int cpt_nombre= 0;
    printf("for\n");
    while(0<=i && i<4 && 0<=j && j<4 ){
      if (get_tile(g,i,j)!=0){
        s[cpt_nombre]=get_tile(g,i,j);
        cpt_nombre++;
        printf("while");
      }
      i+=a;
      j+=b;
      printf("%d %d",i,j);
    }
    printf("%d %d",i,j);
    reset_param(&i,&j,tmpi,tmpj,a,b);
    printf("%d %d",i,j);
    int nb_deplacement=0;
    while(nb_deplacement<cpt_nombre){
      printf("while2éme\n");
      if (nb_deplacement <cpt_nombre-1 && s[nb_deplacement]==s[nb_deplacement+1]){
        tile new_valeur=fusion(s,i,j);
        set_tile(g,i,j,new_valeur);
        nb_deplacement+=2;
      }
      else{
        set_tile(g,i,j,s[nb_deplacement]);
        nb_deplacement++;
      }
      i=+a;
      j+=b;
    }
    while(0<=i && i<GRID_SIDE && 0<=j && j<GRID_SIDE ){
      set_tile(g,i,j,0);
      i+=a;
      j+=b;
    }
    reset_param(&i,&j,tmpi,tmpj,a,b);
    printf("fin for\n");
  }
}

static bool possible(grid g, int i,int j,int a,int b){
  int tmpi=i;
  int tmpj=j;
  for (int cpt=0;cpt<4;cpt++){
    while(i<3 && i>=0 && j<3 && j>=0){
      if ((get_tile(g,i,j)==get_tile(g,i+a,j+b)&&get_tile(g,i,j)!=0)||(get_tile(g,i,j)==0 && get_tile(g,i+a,j+b))){
	return true;
      }
      i+=a;
      j+=b;
    }
    if (a==-1 || a==1){
      j++;
      i=tmpi;
    }
    else {
      i++;
      j=tmpj;
    }
  }
  return false;
}
