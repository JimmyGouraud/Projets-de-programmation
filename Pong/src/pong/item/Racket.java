package pong.item;

import pong.util.Globals;

import java.awt.*;

public class Racket extends PongItem {

    private int speed = Globals.RACKET_SPEED;

    /**
     * Array of the Racket Positions
     */
    private Point[] _tabRacket;

    /**
     * Constructors
     * @param numRacket Number of player 1-4
     */

    public Racket(int numRacket) {
        super(numRacket);
        initTabRacket();
        initRacket();
    }

    public Racket(int numRacket, int x, int y) {
        super(numRacket, x, y);
        initTabRacket();
        initRacket();
    }

    public int getSpeed() {
        return speed;
    }

    public void setSpeed(int speed) {
        this.speed = speed;
    }


    /**
     * Initialize the racket position array
     */
    public void initTabRacket() {
        _tabRacket = new Point[4];
        _tabRacket[0] = new Point(0, (Globals.SIZE_PONG - Globals.SIZE_RACKET_Y) / 2);
        _tabRacket[1] = new Point(Globals.SIZE_PONG - Globals.SIZE_RACKET_X, (Globals.SIZE_PONG - Globals.SIZE_RACKET_Y) / 2);
        _tabRacket[2] = new Point((Globals.SIZE_PONG - Globals.SIZE_RACKET_Y) / 2, Globals.SIZE_PONG - Globals.SIZE_RACKET_X);
        _tabRacket[3] = new Point((Globals.SIZE_PONG - Globals.SIZE_RACKET_Y) / 2, 0);
    }


    /**
     * Initialize a Racket object with it‘s position,
     * rectangle  and number
     */
    private void initRacket() {
        if (this.getNum() == 1 || this.getNum() == 2) {
            this.setWidth(Globals.SIZE_RACKET_X);
            this.setHeight(Globals.SIZE_RACKET_Y);
        } else {
            this.setWidth(Globals.SIZE_RACKET_Y);
            this.setHeight(Globals.SIZE_RACKET_X);
        }
        this.setPosition(_tabRacket[this.getNum() - 1].x, _tabRacket[this.getNum() - 1].y);
        this.setSpeed(0, 0);
    }

    /**
     * Executes the movement of a Racket
     * depending on its position
     */
    @Override
    public void animate() {
        /* Update racket position */
        if (this.getNum() == 1 || this.getNum() == 2) {
            this.setPosY(this.getPosY() + this.getSpeedY());
            if (this.getPosY() < 0)
                this.setPosY(0);
            if (this.getPosY() > (Globals.SIZE_PONG - this.getHeight()))
                this.setPosY(Globals.SIZE_PONG - this.getHeight());
        } else {
            this.setPosX(this.getPosX() + this.getSpeedX());
            if (this.getPosX() < 0)
                this.setPosX(0);
            if (this.getPosX() + this.getWidth() > (Globals.SIZE_PONG))
                this.setPosX(Globals.SIZE_PONG - this.getWidth());
        }
    }

    public void collision(PongItem pongItem) {
        if (pongItem instanceof Bonus &&
                pongItem.getSurface().intersects(this.getSurface())) {
            ((Bonus) pongItem).getBonus(this);
        }
    }
}