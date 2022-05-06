package gridGame;

import tetrimino.AbstractTetrimino;
import variable_globale.Globals;


/**
 * Created by Jimmy on 29/09/2015.
 */
public class GridGame {
    private int[][] tabGrid;
    private int height;
    private int width;
    private int score;
    private int level;
    private int speedDown;

    // Constructeur
    public GridGame() {
        this.height = 24;
        this.width = 12;
        this.tabGrid = new int[this.height][];
        for(int i = 0; i < this.height; i++){
            this.tabGrid[i] = new int[this.width];
        }
        this.score = 0;
        this.level = 1;
        speedDownTetri();
        initTabGrid();
    }

    // Getter et setter
    public int getHeight() {
        return height;
    }
    public int getWidth() {
        return width;
    }

    public void setElemTabGrid(int i, int j, int value){
        tabGrid[i][j] = value;
    }
    public int getElemTabGrid(int i, int j){
        return tabGrid[i][j];
    }

    public int[][] getTabGrid() {
        return tabGrid;
    }

    public int getScore() {
        return score;
    }
    public void setScore(int score) {
        this.score = score;
    }

    public int getLevel() {
        return this.level;
    }
    public void setLevel(int level) {
        this.level = level;
    }

    public int getSpeedDown() {
        return speedDown;
    }
    public void setSpeedDown(int speedDown) {
        this.speedDown = speedDown;
    }

    // Fonctions

    /**
     * Initialise le tableau qui servira de grille
     * Remplit les cotes de la grille de 1.
     */
    public void initTabGrid(){
        for(int i = 0; i < getHeight(); i++) {
            for (int j = 0; j < getWidth(); j++) {
                if (i == 0 || i == getHeight() - 1 || j == 0 || j == getWidth() - 1) {
                    setElemTabGrid(i, j, 3);
                } else {
                    setElemTabGrid(i, j, -1);
                }
            }
        }
    }

    /**
     * Supprime la ligne à l'indice indexLine et descend la grille
     * @param indexLine
     */
    private void deleteLine(int indexLine){
        for(int i = indexLine; i > 0; i--){
            for (int j = 1; j < getWidth()-1; j++){
                setElemTabGrid(i, j, getElemTabGrid(i - 1, j));
            }
        }
        for (int j = 1; j < getWidth()-1; j++) {
            setElemTabGrid(1, j, -1);
        }
    }

    /**
     * Met à jour la grille :
     *   - supprime les lignes completes et descend les autres cases
     */
    public void updateGrid() {
        boolean toDelete;
        int nbLineDelete = 0;
        for (int i = 1; i < getHeight() - 1; i++) {
            toDelete = true;
            for (int j = 1; j < getWidth() - 1; j++) {
                if (getElemTabGrid(i, j) == -1) {
                    toDelete = false;
                    break;
                }
            }

            if (toDelete) {
                deleteLine(i);
                nbLineDelete++;
            }
        }
        addScore(nbLineDelete);
    }

    public void addScore(int nbLineDeleted){
        switch (nbLineDeleted){
            case 1:
                setScore(getScore() + (getLevel() * 40));
                break;
            case 2:
                setScore(getScore() + (getLevel() * 100));
                break;
            case 3:
                setScore(getScore() + (getLevel() * 300));
                break;
            case 4:
                setScore(getScore() + (getLevel() * 1200));
                break;
        }
    }

    public void speedDownTetri(){
        setSpeedDown(500 - 150 * getLevel());
    }

    public void fusionTetriToGrid(AbstractTetrimino tetrimino, int posI, int posJ){
        for (int i = 0; i < Globals.NB_BLOCS; i++){
            setElemTabGrid(tetrimino.getI(i) + posI,
                    tetrimino.getJ(i) + posJ,
                    tetrimino.getNumTetri());

        }
    }
}