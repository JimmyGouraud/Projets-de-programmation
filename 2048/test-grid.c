/* grid.c */

#include <stdio.h>
#include <stdlib.h>
#include "grid.h"

struct grid{
  int size_grid = GRID_SIDE;
  char grid_board[size_grid*2+1][size_grid*3+1];
  int grid_number[size_grid][size_grid];
};


typedef unsigned int tile;
typedef enum dir_e {UP,LEFT,DOWN,RIGHT} dir;


grid new_grid (){
  grid_s g;
  //initialisation de la grille des nombres
  for(int i=0; i<g->size_grid; i++){
    for(int j=0; j<g->size_grid; j++){
      grid_number[i][j] = 0;
    }
  }

  //initialisation du contour de la grille
  for(int i=0; i<9; i++){
    for(int j=0; j<13; j++){
      if(i%2 == 0){
	if(j%3 == 0)
	  g->grid_board[i][j] = '+';
	else
	  g->grid_board[i][j] = '-';
      }else{
	if(j%3 == 0)
	  g->grid_board[i][j] = '|';
        else
	  g->grid_board[i][j] = ' ';
      }
    }
  }
}

void delete_grid (grid g);

void copy_grid (grid src, grid dst);

unsigned long int grid_score (grid g);


tile get_tile (grid g, int x, int y);

void set_tile (grid g, int x, int y, tile t);

bool can_move (grid g, dir d);

bool game_over (grid g);

void do_move (grid g, dir d);

void add_tile (grid g);

void play (grid g, dir d);



#endif
