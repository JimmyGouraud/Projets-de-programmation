package tetrimino;


import java.io.IOException;

/**
 * Created by Jimmy on 30/09/2015.
 */
public class TabTetrimino {
    private AbstractTetrimino [] tabTetri;

    public TabTetrimino() throws IOException{
        tabTetri = new AbstractTetrimino[7];
        tabTetri[0] = new TetriminoBar();
        tabTetri[1] = new TetriminoCarre();
        tabTetri[2] = new TetriminoZ();
        tabTetri[3] = new TetriminoT();
        tabTetri[4] = new TetriminoL();
        tabTetri[5] = new TetriminoJ();
        tabTetri[6] = new TetriminoS();
    }

    public AbstractTetrimino getElemTabTetri(int indice){
        return tabTetri[indice];
    }
}
