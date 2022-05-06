package tetrimino;

import variable_globale.Globals;

import java.awt.*;

/**
 * Created by Jimmy on 29/09/2015.
 */
public abstract class AbstractTetrimino {
    private int numTetrimino;
    private int numPos;
    private int nbPos;
    private Point tabCoor[];
    private Image spriteBloc;

    // Constructeur
    public AbstractTetrimino(int numTetrimino, int nbPos, Image spriteBloc){
        this.numTetrimino = numTetrimino;
        this.numPos = -1;
        this.nbPos = nbPos;
        this.tabCoor = new Point[4];
        this.spriteBloc = spriteBloc;

        initTetri();
    }

    // Getter & Setter
    public int getNumTetri() {
        return numTetrimino;
    }
    public int getNumPos() {
        return numPos;
    }
    public int getNbPos() {
        return nbPos;
    }
    public Image getSpriteBloc() {
        return spriteBloc;
    }
    public int getI(int indice){
        return (int)tabCoor[indice].getY();
    }
    public int getJ(int indice){
        return (int)tabCoor[indice].getX();
    }

    public void setElemTabCoor(int indice, int i, int j){
        this.tabCoor[indice].setLocation(i, j);
    }
    public void setNumPos(int numPos) {
        this.numPos = numPos;
        updateCoor();
    }

    /**
     * Met a jour les coordonnEes selon numPOS
     */
    public void updateCoor(){ }

    public void rotateTetri(){
        int newNumPos = getNumPos() + 1;
        if (newNumPos >= getNbPos()){
            newNumPos = 0;
        }
        setNumPos(newNumPos);
    }

    public void initTetri(){
        for (int i = 0; i < Globals.NB_BLOCS; i++) {
            this.tabCoor[i] = new Point(0,0);
        }
        rotateTetri();
    }
}
