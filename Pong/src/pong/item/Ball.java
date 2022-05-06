package pong.item;

import pong.util.Globals;
import pong.util.RandomNumber;

import java.awt.*;

public class Ball extends PongItem {
    int _numOwner;
    static int _numBall = 1;

    /**Constructors*/
    public Ball(){
        super(_numBall);
        initBall();
    }

    public Ball(int numBall, int x, int y){
        super(numBall, x, y);
        initBall();
    }



    /**
     *Initializing the ball
    */
    private void initBall(){
        this.setWidth(Globals.SIZE_BALL);
        this.setHeight(Globals.SIZE_BALL);
        this.init();
        _numBall++;
    }

    public void init(){
        _numOwner = -1;

        this.setPosition(Globals.SIZE_PONG/2, Globals.SIZE_PONG/2);

        // Genere une vitesse aleatoire (variant de -Globals.RANGE_BALL_SPEED a Globals.RANGE_BALL_SPEED)
        int speedX = (RandomNumber.randomValue(0,1) == 0)? -Globals.BALL_SPEED : Globals.BALL_SPEED;
        int speedY = (RandomNumber.randomValue(0,1) == 0)? -Globals.BALL_SPEED : Globals.BALL_SPEED;
        this.setSpeed(speedX + RandomNumber.randomValue(-Globals.RANGE_BALL_SPEED, Globals.RANGE_BALL_SPEED),
                speedY + RandomNumber.randomValue(-Globals.RANGE_BALL_SPEED, Globals.RANGE_BALL_SPEED));
    }

    /**Updates the ball speed after angle changes*/

    public void update(){
        if(this.getSpeedX() < 0)
            this.setSpeedX(this.getSpeedX() - 2);
        else
            this.setSpeedX(this.getSpeedX() + 2);

        if(this.getSpeedY() < 0)
            this.setSpeedY(this.getSpeedY() - 2);
        else
            this.setSpeedY(this.getSpeedY() + 2);
    }

    /**Calculate the good angle of a collision between a ball and a racket*/

    public void angle(PongItem pongItem) {
        double rInter = (pongItem.getPosY() + pongItem.getHeight() / 2) - (this.getPosY());
        double normRel = rInter / pongItem.getHeight();
        double bAngle = normRel * (5 * (Math.PI / 12));
        double angleX = Globals.BALL_SPEED * Math.cos(bAngle);
        double angleY = Globals.BALL_SPEED * (-Math.sin(bAngle));
        if (pongItem.getPosX() <= this.getPosX() + this.getWidth() &&
                this.getPosX() > Globals.SIZE_PONG/2)
            angleX = -angleX;
        this.setSpeed((int) angleX, (int) angleY);
    }


    /**Executes the change of directions based on the angle if a Ball
     * is colliding with a Racket
     * and changes the direction if hit by another Ball*/

    public void collision(PongItem pongItem) {
        if (checkCollisionBall(pongItem) == 1) {
            if(pongItem instanceof Ball) {
                if (this.getSurface().intersects(pongItem.getSurface())) {

                    if (this.getPosX() > pongItem.getPosX()) {
                        pongItem.setPosX(this.getPosX() - Globals.SIZE_BALL);
                    }
                    if (this.getPosY() > pongItem.getPosY()) {
                        pongItem.setPosY(this.getPosY() - Globals.SIZE_BALL);
                    }
                    if (this.getPosX() < pongItem.getPosX()) {
                        pongItem.setPosX(this.getPosX() + Globals.SIZE_BALL);
                    }
                    if (this.getPosY() < pongItem.getPosY()) {
                        pongItem.setPosY(this.getPosY() + Globals.SIZE_BALL);
                    }
                    if (this.getPosX() != pongItem.getPosX()) {
                        this.setSpeedX(-this.getSpeedX());
                        pongItem.setSpeedX(-pongItem.getSpeedX());
                    }
                    if (this.getPosY() != pongItem.getPosY()) {
                        this.setSpeedY(-this.getSpeedY());
                        pongItem.setSpeedY(-pongItem.getSpeedY());
                    }

                }
            }
            else if (pongItem instanceof Racket) {
                this._numOwner = pongItem.getNum();
                this.angle(pongItem);
                this.update();
            }
            else if (pongItem instanceof Bonus){
                Bonus bonus = (Bonus) pongItem;
                if (this._numOwner != -1){
                    if (this._numOwner == 1)
                        bonus.setSpeedX(-Globals.BONUS_SPEED);
                    if (this._numOwner == 2)
                        bonus.setSpeedX(Globals.BONUS_SPEED);
                    if (this._numOwner == 3)
                        bonus.setSpeedY(Globals.BONUS_SPEED);
                    if (this._numOwner == 4)
                        bonus.setSpeedY(-Globals.BONUS_SPEED);
                    bonus.isTouched();
                }
            }
        }

    }

    /**Checking for collisions of the ball
     * and another PongItem
     * @param pongItem
     * @return
     */
    public int checkCollisionBall(PongItem pongItem){
        boolean col = pongItem.getPosX() + pongItem.getWidth() >= this.getPosX();
        boolean col2 = pongItem.getPosX() <= this.getPosX() + this.getWidth();
        boolean col3 = pongItem.getPosY() + pongItem.getHeight() >= this.getPosY();
        boolean col4 = pongItem.getPosY() <= this.getPosY() + this.getHeight();
        if(col && col2 && (pongItem.getNum() == 1 || pongItem.getNum() == 2)){
            if(col3 && col4) {
                return 1;
            }
        }
        else if(col3 && col4 && (pongItem.getNum() == 3 || pongItem.getNum() == 4)){
            if(col && col2)
                return 1;
        }
        return 0;
    }


}
