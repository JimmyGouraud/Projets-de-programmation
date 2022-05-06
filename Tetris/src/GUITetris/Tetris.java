package GUITetris;

import variable_globale.Globals;
import gridGame.GridGame;
import tetrimino.AbstractTetrimino;
import tetrimino.TabTetrimino;

import javax.swing.*;
import java.awt.*;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.awt.image.BufferedImage;
import java.io.IOException;

/**
 * Created by Jimmy on 28/10/2015.
 */
public class Tetris extends JPanel implements KeyListener {
    private static final long serialVersionUID = 1L;
    private static final Color backgroundColor = new Color(0xFF, 122, 28);
    private BufferedImage buffer = null;
    private Graphics graphicContext = null;

    private GridGame gridGame;
    private TabTetrimino tabTetri;
    private int numTetri;
    private int posI;
    private int posJ;
    private boolean changeTetris;

    long timeGame;

    public Tetris() throws IOException {
        this.tabTetri = new TabTetrimino();
        this.gridGame = new GridGame();
        this.numTetri = 0;
        this.posI = 0;
        this.posJ = 0;
        this.timeGame = System.currentTimeMillis();
        initTetri();

        this.setPreferredSize(new Dimension(Globals.SIZE_TETRIS_X, Globals.SIZE_TETRIS_Y));
        this.addKeyListener(this);
    }

    @Override
    public void keyTyped(KeyEvent e) {
    }

    @Override
    public void keyPressed(KeyEvent e) {
        switch (e.getKeyCode()) {
            case KeyEvent.VK_UP:
            case KeyEvent.VK_KP_UP:
                rotation();
                break;
            case KeyEvent.VK_DOWN:
            case KeyEvent.VK_KP_DOWN:
                moveDown();
                break;
            case KeyEvent.VK_LEFT:
            case KeyEvent.VK_KP_LEFT:
                moveLeft();
                break;
            case KeyEvent.VK_RIGHT:
            case KeyEvent.VK_KP_RIGHT:
                moveRight();
                break;
            case KeyEvent.VK_P:
                System.out.println("touche P !");
                try {
                    pause();
                } catch (InterruptedException e1) {
                    e1.printStackTrace();
                }
                break;
            default:
                System.out.println("got press " + e);
        }
        repaint();
    }

    @Override
    public void keyReleased(KeyEvent e) {
    }

    public boolean canRotation(){
        System.out.println("canRotation");
        int saveNumPos = getTetri().getNumPos();
        getTetri().rotateTetri();
        boolean canRotate = true;

        for (int i = 0; i < Globals.NB_BLOCS; i++) {
            // On verifie que chaque bloc n'est pas sur une case occupee
            if (gridGame.getElemTabGrid(
                    posI + getTetri().getI(i),
                    posJ + getTetri().getJ(i))
                    != -1) {
                canRotate =  false;
            }
        }
        getTetri().setNumPos(saveNumPos);
        return canRotate;
    }

    public void doRotation() {
        getTetri().rotateTetri();
    }

    public void rotation(){
        if(canRotation()) {
            doRotation();
        }
    }

    public AbstractTetrimino getTetri() {
        return tabTetri.getElemTabTetri(numTetri);
    }

    private boolean canMoveDown() {
        for (int i = 0; i < Globals.NB_BLOCS; i++) {
            // On verifie que chaque bloc n'est pas sur une case occupee
            if (gridGame.getElemTabGrid(
                    posI + getTetri().getI(i) + 1,
                    posJ + getTetri().getJ(i))
                    != -1) {
                return false;
            }
        }
        return true;
    }

    private void doMoveDown() {
        posI++;
    }

    private void moveDown() {
        if (canMoveDown()) {
            doMoveDown();
        } else {
            gridGame.fusionTetriToGrid(getTetri(), posI, posJ);
            changeTetris = true;
        }
    }

    private boolean canMoveRight() {
        for (int i = 0; i < Globals.NB_BLOCS; i++) {
            // On verifie que chaque bloc n'est pas sur une case occupee
            if (gridGame.getElemTabGrid(
                    posI + getTetri().getI(i),
                    posJ + getTetri().getJ(i) + 1)
                    != -1) {
                return false;
            }
        }
        return true;
    }

    private void doMoveRight() {
        posJ++;
    }

    private void moveRight() {
        if (canMoveRight()) {
            doMoveRight();
        }
    }

    private boolean canMoveLeft() {
        for (int i = 0; i < Globals.NB_BLOCS; i++) {
            // On verifie que chaque bloc n'est pas sur une case occupee
            if (gridGame.getElemTabGrid(
                    posI + getTetri().getI(i),
                    posJ + getTetri().getJ(i) - 1)
                    != -1) {
                return false;
            }
        }
        return true;
    }

    private void doMoveLeft() {
        posJ--;
    }

    private void moveLeft() {
        if (canMoveLeft()) {
            doMoveLeft();
        }
    }

    private void pause() throws InterruptedException {
        System.out.println("pause !");
    }


    @Override
    public void paint(Graphics g) {
        displayGrid(g);
    }

    public void updateScreen() {
        if (buffer == null) {
			/* First time we get called with all windows initialized */
            buffer = new BufferedImage(Globals.SIZE_TETRIS_X,
                    Globals.SIZE_TETRIS_X,
                    BufferedImage.TYPE_INT_RGB);

            if (buffer == null)
                throw new RuntimeException("Could not instanciate graphics");
            else
                graphicContext = buffer.getGraphics();
        }
		/* Fill the area with orange */
        graphicContext.setColor(backgroundColor);
        graphicContext.fillRect(0, 0, Globals.SIZE_TETRIS_X, Globals.SIZE_TETRIS_Y);

        this.repaint();
    }

    public void animate() {
        if (changeTetris) {
            initTetri();
        }
        if ((timeGame + gridGame.getSpeedDown()) < System.currentTimeMillis()) {
            timeGame = System.currentTimeMillis();
            moveDown();
        }

        gridGame.updateGrid();
        updateScreen();
    }

    public void initTetri(){
        changeTetris = false;
        numTetri=(int)(Math.random()*7);
        posI = 0;
        posJ = gridGame.getWidth()/2-2;
    }
    /**
     * Affiche la grille, le contour et le tetrimino
     * @param g
     */
    public void displayGrid(Graphics g){
        // Affiche le fond noir sous la grille
        g.fillRect(Globals.POS_X_GRID,
                Globals.POS_Y_GRID,
                gridGame.getWidth() * Globals.SIZE_BLOC,
                gridGame.getHeight() * Globals.SIZE_BLOC);

        // Affiche le tetrimino
        for (int i = 0; i < Globals.NB_BLOCS; i++){
            g.drawImage(getTetri().getSpriteBloc(),
                    Globals.POS_X_GRID + (posJ + getTetri().getJ(i)) * Globals.SIZE_BLOC,
                    Globals.POS_Y_GRID + (posI + getTetri().getI(i)) * Globals.SIZE_BLOC,
                    this);
        }

        // Affiche les blocs et le contour
        for (int i = 0; i < gridGame.getHeight(); i++){
            for (int j = 0; j < gridGame.getWidth(); j++){
                if(gridGame.getElemTabGrid(i, j) != -1){
                    g.drawImage(
                            tabTetri.getElemTabTetri(gridGame.getElemTabGrid(i,j)).getSpriteBloc(),
                            Globals.POS_X_GRID + j*Globals.SIZE_BLOC, Globals.POS_Y_GRID + i*Globals.SIZE_BLOC,
                            this);
                }
            }
        }
    }
     public boolean gameOver(){
        for (int j = 1; j < gridGame.getWidth() - 1; j++){
            if (gridGame.getElemTabGrid(1, j) != -1) {
                System.out.println("Game Over");
                return true;
            }
        }
        return false;
    }


}
