
void afficher(struct grid g){
  for(int i=0; i<9; i++){
    for(int j=0; j<13; j++){
      printf("%c", g.grid_board[i][j]);
    }
    printf("\n");
  }
}

int main(int argc, char** argv){
    struct grid g;
    for(int i=0; i<9; i++){
        for(int j=0; j<13; j++){
            if(i%2 == 0){
                if(j%3 == 0)
                    g.grid_board[i][j] = '+';
                else
                    g.grid_board[i][j] = '-';
            }else{
                if(j%3 == 0)
                    g.grid_board[i][j] = '|';
                if(j%3 == 1)
                    g.grid_board[i][j] = '4';
                if(j%3 == 2)
                    g.grid_board[i][j] = ' ';
            }
        }
    }
    afficher(g);
    return EXIT_SUCCESS;
}
