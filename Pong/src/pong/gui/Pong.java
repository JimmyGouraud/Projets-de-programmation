package pong.gui;


import pong.item.*;
import pong.util.Globals;

import javax.swing.*;
import java.awt.*;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.awt.image.BufferedImage;
import java.util.ArrayList;


/**
 * An Pong is a Java graphical container that extends the JPanel class in
 * order to display graphical elements.
 */
public class Pong extends JPanel implements KeyListener{

    private static final long serialVersionUID = 1L;

    /**
     * Time step of the simulation (in ms)
     */
    public static final int timestep = 10;

    /**
     * Pixel data buffer for the Pong rendering
     */
    private BufferedImage buffer = null;

    /**
     * Graphic component context derived from buffer Image
     */
    private Graphics2D graphicContext = null;

    /**
     * Donnees relatives aux mouvements (depend du numero du joueur)
     */
    private boolean moveUp = false;
    private boolean moveDown = false;
    private boolean moveLeft = false;
    private boolean moveRight = false;

    /**
     * Etat du jeu
     */
    public static final int PLAY = 1;
    public static final int WON = 2;

    private int status = PLAY;


    /**
     * Donnees relatives au pong
     */
    private ArrayList<PongItem> _tabPongItem;
    private int[] _tabScore;
    private Point[] _tabScorePosition;
    int _loser = -1; // numero du dernier joueur qui vient de perdre le poids
    int _numBallLost = -1; // numero de la balle qui a fait le point

    /**
     * Constructor
     */
    public Pong() {
        this._tabPongItem = new ArrayList<>();

        this._tabPongItem.add(new Racket(1));

        this._tabPongItem.add(new Ball());

        this.setPreferredSize(new Dimension(Globals.SIZE_WINDOW_X, Globals.SIZE_WINDOW_Y));
        this.addKeyListener(this);
    }

    public void createBonus(){
        this._tabPongItem.add(new Bonus());
    }

    public void initPong(){
        initTabScore();
        initTabScorePosition();
    }

    /**
     * Initializing Score Array to 0 for all
     */
    public void initTabScore(){
        this._tabScore = new int [Globals.nbPlayer];
        for (int i = 0; i < this._tabScore.length; i++){
            this._tabScore[i] = 0;
        }
    }


    /**
     * Initializing the display position of every score
     */
    public void initTabScorePosition(){
        this._tabScorePosition = new Point[4];
        this._tabScorePosition[0] = new Point(Globals.SIZE_WINDOW_X - 700, Globals.SIZE_WINDOW_Y - 130);
        this._tabScorePosition[1] = new Point(Globals.SIZE_WINDOW_X - 350, Globals.SIZE_WINDOW_Y - 130);
        this._tabScorePosition[2] = new Point(Globals.SIZE_WINDOW_X - 700, Globals.SIZE_WINDOW_Y - 50);
        this._tabScorePosition[3] = new Point(Globals.SIZE_WINDOW_X - 350, Globals.SIZE_WINDOW_Y - 50);
    }


    /** Getters & Setters */

    public ArrayList<PongItem> getTabPongItem() {
        return this._tabPongItem;
    }
    public void setTabPongItem(ArrayList<PongItem> tabPongItem) {
        this._tabPongItem = tabPongItem;
    }

    public PongItem getPongItem(int indice){
        return this._tabPongItem.get(indice);
    }
    public void setPongItem(int indice, PongItem pongItem){
        this._tabPongItem.set(indice, pongItem);
    }

    public int getPointPlayer(int numPlayer){
        return this._tabScore[numPlayer - 1];
    }
    public void setPointPlayer(int numPlayer, int pointPlayer){
        this._tabScore[numPlayer -1] = pointPlayer;
    }

    public int getLoser(){
        return this._loser;
    }
    public void initLoser(){
        this._loser = -1;
    }

    public int getNumBallLost(){
        return this._numBallLost;
    }
    public void initBallLost(){
        this._numBallLost = -1;
    }

    public void removePongItem(int indice){
        this._tabPongItem.remove(indice);
    }

    /**
     * Proceeds to the movement of the ball and updates the screen
     */

    public void animate() {
        if (status != WON){
            PongItem.animateAll(_tabPongItem);
            /* And update output */
        }
        updateTabScore();
        updateScreen();
    }


    /**
     * Checks upon all the collisions
     */
    public void collision() {
        PongItem.collisionAll(_tabPongItem);
    }

    public void paint(Graphics g) {
        g.drawImage(buffer, 0, 0, this);
    }

    /**
     * Draws each Pong item based on their positions
     * and inserts scores if status == PLAY
     */
    public void updateScreen() {
        if (buffer == null) {
			/* First time we get called with all windows initialized */
            buffer = new BufferedImage(Globals.SIZE_WINDOW_X,
                    Globals.SIZE_WINDOW_Y,
                    BufferedImage.TYPE_INT_RGB);

            graphicContext = (Graphics2D) buffer.getGraphics();
        }
		/* Fill the area with a color */
        graphicContext.setColor(Globals.backgroundColor);
        graphicContext.fillRect(0, 0, Globals.SIZE_PONG, Globals.SIZE_PONG);
        graphicContext.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);


		/* Draw items */
        if (status == PLAY) {
            for (PongItem pongItem : this._tabPongItem) {
                if (pongItem instanceof Racket) {
                    graphicContext.setColor(Globals.cRacket);
                    graphicContext.fillRoundRect(pongItem.getPosX(), pongItem.getPosY(),
                            pongItem.getWidth(), pongItem.getHeight(), 30, 30);
                }
                else if (pongItem instanceof Ball){
                    graphicContext.setColor(Globals.cBall);
                    graphicContext.fillOval(pongItem.getPosX(), pongItem.getPosY(),
                            pongItem.getWidth(), pongItem.getHeight());
                }
                else if(pongItem instanceof Bonus) {
                    Bonus bonus = (Bonus) pongItem;
                    bonus.updateBonus();

                    if (bonus.isRunning()) {
                        graphicContext.drawImage(bonus.getImageBonus(), bonus.getPosX(), bonus.getPosY(),
                                bonus.getWidth(), bonus.getHeight(), null);
                    }
                }
            }

            graphicContext.setColor(Color.BLACK);
            graphicContext.fillRect(0, Globals.SIZE_PONG, Globals.SIZE_PONG, Globals.SIZE_WINDOW_Y);
            graphicContext.setColor(Globals.cRacket);
            graphicContext.setFont(Globals.fScore);

            for (int i = 0; i < this._tabScore.length; i++){
                if (isPlaying(i+1)) {
                    StringBuffer s = new StringBuffer();
                    s.append("Player ");
                    s.append(i + 1);
                    s.append(": ");
                    s.append(_tabScore[i]);
                    graphicContext.drawString(String.valueOf(s), (int) this._tabScorePosition[i].getX(), (int) this._tabScorePosition[i].getY());
                }
            }
        }

        int winner = checkWinner();

        if(winner != 0) {
            status = WON;
        }

        if(status == WON) {
            if (_tabPongItem.get(0).getNum() == winner) {
                StringBuffer playerWon = new StringBuffer();
                playerWon.append("You Win Player ");
                playerWon.append(winner);
                playerWon.append("!");
                graphicContext.setColor(Color.BLACK);
                graphicContext.setFont(Globals.fWin);
                graphicContext.drawString(String.valueOf(playerWon), Globals.SIZE_PONG / 2 - 230, 200);
                graphicContext.drawString("Congratulations", Globals.SIZE_PONG / 2 - 210, 350);
            } else {
                StringBuffer playerLost = new StringBuffer();
                playerLost.append("You Lost Player ");
                playerLost.append(_tabPongItem.get(0).getNum());
                graphicContext.setColor(Color.BLACK);
                graphicContext.setFont(Globals.fWin);
                graphicContext.drawString(String.valueOf(playerLost), Globals.SIZE_PONG / 2 - 250, 200);
                graphicContext.drawString("Sorry ;(", Globals.SIZE_PONG / 2 - 100, 350);
            }
        }

        this.repaint();
    }

    public int checkWinner(){
        for(int i = 0; i< _tabScore.length;i++) {
            if (_tabScore[i] == 11)
                return i + 1;
        }
        return 0;
    }

    /**
     * Retourne true si le joueur *numPlayer* est en train de jouer
     * @param numPlayer {int}
     * @return un boolean
     */
    public boolean isPlaying(int numPlayer){
        for (PongItem pongItem: this._tabPongItem){
            if (pongItem.getClass().getSimpleName().equals("Racket") &&
                    pongItem.getNum() == numPlayer)
                return true;
        }
        return false;
    }

    /**
     * Calcul total des scores des joueurs
     * @return le total des scores
     */
    public int allScore(){
        int allScore = 0;
        for (int score : this._tabScore) {
            allScore += score;
        }
        return allScore;
    }


    public void updateTabScore() {
        for (PongItem pongItem : this._tabPongItem) {
            gameOver(pongItem);
        }
    }

    /**
     * Si le pongItem passe en parametre est une balle et qu'elle
     * touche le bord d'un joueur present, alors on memorise le numero
     * du joueur qui a perdu et la balle perdue et on met a jour les scores.
     * @param pongItem {PongItem}
     */
    public void gameOver(PongItem pongItem){
        if (pongItem instanceof Ball) {
            int playerLoser = 0;
            if (isPlaying(1) && pongItem.getPosX() == 0)
                playerLoser = 1;
            else if (isPlaying(2) && pongItem.getPosX() + pongItem.getWidth() == Globals.SIZE_PONG)
                playerLoser = 2;
            else if (isPlaying(3) && pongItem.getPosY() + pongItem.getHeight() == Globals.SIZE_PONG)
                playerLoser = 3;
            else if (isPlaying(4) && pongItem.getPosY() == 0)
                playerLoser = 4;

            if (playerLoser != 0){
                this._loser = playerLoser;
                this._numBallLost = pongItem.getNum();
                ((Ball) pongItem).init();

                this.setScore(playerLoser);
            }
        }
    }

    /**
     * Incremente de 1 tous les joueurs autres que le perdant
     * @param loser {int} numero du joueur qui vient de perdre le point
     */
    public void setScore(int loser){
        for (int i = 0; i < this._tabScore.length; i++){
            if (i != loser-1)
                this._tabScore[i]++;
        }
    }



    /**
     * Functions necessary for the KeyListener
     * allowing the keyboard to be used to move objects
     * or other features
     */
    @Override
    public void keyPressed(KeyEvent e) {
        if (_tabPongItem.get(0).getNum() == 1 || this._tabPongItem.get(0).getNum() == 2){
            switch (e.getKeyCode()) {
                case KeyEvent.VK_UP:
                case KeyEvent.VK_KP_UP:
                    moveUp = true;
                    break;
                case KeyEvent.VK_DOWN:
                case KeyEvent.VK_KP_DOWN:
                    moveDown = true;
                    break;
                default:
                    break;
            }
        }

        if(_tabPongItem.get(0).getNum() == 3 || this._tabPongItem.get(0).getNum() == 4){
            switch (e.getKeyCode()) {
                case KeyEvent.VK_LEFT:
                case KeyEvent.VK_KP_LEFT:
                    moveLeft = true;
                    break;
                case KeyEvent.VK_RIGHT:
                case KeyEvent.VK_KP_RIGHT:
                    moveRight = true;
                    break;
                default:
                    break;
            }
        }
        moveRacket();
    }

    @Override
    public void keyReleased(KeyEvent e) {
        if(_tabPongItem.get(0).getNum() == 1 || this._tabPongItem.get(0).getNum() == 2) {
            switch (e.getKeyCode()) {
                case KeyEvent.VK_UP:
                case KeyEvent.VK_KP_UP:
                    moveUp = false;
                    break;
                case KeyEvent.VK_DOWN:
                case KeyEvent.VK_KP_DOWN:
                    moveDown = false;
                    break;
                default:
                    break;
            }
        }

        if (_tabPongItem.get(0).getNum() == 3 || this._tabPongItem.get(0).getNum() == 4){
            switch (e.getKeyCode()) {
                case KeyEvent.VK_LEFT:
                case KeyEvent.VK_KP_LEFT:
                    moveLeft = false;
                    break;
                case KeyEvent.VK_RIGHT:
                case KeyEvent.VK_KP_RIGHT:
                    moveRight = false;
                    break;
                default:
                    break;
            }
        }
        moveRacket();
    }

    @Override
    public void keyTyped(KeyEvent e) { }

    public void moveRacket(){
        Racket racket = (Racket) this._tabPongItem.get(0);
        if (moveUp || moveDown) {
            if (moveUp)
                racket.setSpeedY(-racket.getSpeed());
            if (moveDown)
                racket.setSpeedY(racket.getSpeed());
        } else
            racket.setSpeedY(0);

        if (moveRight || moveLeft) {
            if (moveRight)
                racket.setSpeedX(racket.getSpeed());
            if (moveLeft)
                racket.setSpeedX(-racket.getSpeed());
        } else
            racket.setSpeedX(0);
    }
}
