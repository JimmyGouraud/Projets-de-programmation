#include <stdlib.h>
#include <stdio.h>

#include "testgrid.h"

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
  printf("\n");

  do_move(g,DOWN);
  for (int i=0;i<GRID_SIDE;i++){
    for (int j=0;j<GRID_SIDE;j++){
      printf("%d",get_tile(g,i,j));
    }
    printf("\n");
  }
  printf("\n");

  do_move(g,DOWN);
  for (int i=0;i<GRID_SIDE;i++){
    for (int j=0;j<GRID_SIDE;j++){
      printf("%d",get_tile(g,i,j));
    }
    printf("\n");
  }
  printf("\n");
}

