package pong.item;

import pong.util.Globals;
import pong.util.RandomNumber;
import sun.java2d.Surface;

import javax.security.auth.DestroyFailedException;
import javax.security.auth.Destroyable;

import java.awt.*;

import static pong.util.RandomNumber.randomValue;


public class Bonus extends PongItem{

    private long time_start_bonus; // moment où on a lance le bonus
    private int duration_effect = 5000; // Duree de l'effet du bonus en ms
    private Image image_bonus;

    private boolean running; // le bonus est-il affiche a l'ecran et fonctionnel
    private boolean touched; // le bonus a t'il etait attrape par une raquette
    private boolean effecting; // le bonus est-il en train de faire effet sur une raquette.
    private Racket racket;

    public static final int LARGE = 1;
    public static final int SMALL = 2;
    public static final int FAST = 3;
    public static final int SLOW = 4;

    /**
     * Constructor
     */
    public Bonus (){
        super(randomValue(LARGE,SMALL));
        initBonus();
        image_bonus = Toolkit.getDefaultToolkit().createImage(
                ClassLoader.getSystemResource("image/bonus_pong.png"));
    }

    public Bonus(int numBall, int x, int y){
        super(numBall, x, y);
        initBonus();
        image_bonus = Toolkit.getDefaultToolkit().createImage(
                ClassLoader.getSystemResource("image/bonus_pong.png"));
    }

    /**
     * Initializing the Bonus with Speed and Rectangle
     */
    public void initBonus() {
        this.running = true;
        this.touched = false;
        this.effecting = false;
        this.setPosition((Globals.SIZE_PONG - Globals.SIZE_BONUS) / 2,
                (Globals.SIZE_PONG - Globals.SIZE_BONUS) / 2);
        this.setWidth(Globals.SIZE_BONUS);
        this.setHeight(Globals.SIZE_BONUS);
    }


    public Image getImageBonus() {
        return image_bonus;
    }

    /**
     * Getter & setter
     */

    public boolean isRunning(){
        return this.running;
    }

    public void isTouched(){
        this.touched = true;
    }

    /**
     * Change le numero du Bonus, ce qui influence sur ton effet
     */
    public void changeEffect(){
        this.setNum(randomValue(LARGE, SLOW));
    }

    /**
     * Animation du Bonus
     */
    static double angle = 0;
    public void animate (){
        int x;
        int y;
        if (this.touched){
            x = this.getPosX() + this.getSpeedX();
            y = this.getPosY() + this.getSpeedY();
        } else {
            if (angle > 360)
                angle = 0;
            int rayon = 100;
            x = (int) (Globals.SIZE_PONG/2 + rayon * Math.cos(angle));
            y = (int) (Globals.SIZE_PONG/2 + rayon * Math.sin(angle));
            angle += 0.03;
        }
        this.setPosition(x, y);

        if (this.getPosX() < 0 ||
                this.getPosY() < 0 ||
                this.getPosX() > (Globals.SIZE_PONG - this.getWidth()) ||
                this.getPosY() > (Globals.SIZE_PONG - this.getHeight())){
            initBonus();
        }
    }

    /**
     * Met a jour le Bonus :
     *   - enleve les effets a la raquette au bout de *duration_effect* secondes
     *   - remet un bonus au bout de *duration_effet* apres que la raquette soit redevenue normale
     */
    public void updateBonus(){
        if (this.effecting) {
            long time = System.currentTimeMillis();
            if (time > (this.time_start_bonus + this.duration_effect)) {
                removeEffect();
                if (time > (this.time_start_bonus + 2*this.duration_effect)) {
                    initBonus();
                }
            }
        }
    }

    /**
     * Modifie les caracteristiques de la raquette (augmente/diminiue sa taille/vitesse
     * @param racket {Racket}
     */
    public void getBonus(Racket racket){
        if (this.touched) {
            this.racket = racket;
            this.running = false;
            this.touched = false;
            this.effecting = true;
            this.time_start_bonus = System.currentTimeMillis();

            switch (this.getNum()) {
                case LARGE:
                    if (racket.getNum() == 1 || racket.getNum() == 2)
                        racket.setHeight(racket.getWidth()*2);
                    else
                        racket.setWidth(racket.getWidth()*2);
                    break;
                case SMALL:
                    if (racket.getNum() == 1 || racket.getNum() == 2)
                        racket.setHeight(racket.getHeight()/2);
                    else
                        racket.setWidth(racket.getWidth()/2);
                    break;
                case FAST:
                        racket.setSpeed(racket.getSpeed() * 2);
                    break;
                case SLOW:
                        racket.setSpeed(racket.getSpeed() / 2);
                    break;
                default:
                    break;
            }

        }
    }

    /**
     * Supprime les effets du Bonus sur la raquette (qui est memorise en donnee membre)
     */
    public void removeEffect(){
        this.racket.setSpeed(Globals.BALL_SPEED);
        if (racket.getNum() == 1 || racket.getNum() == 2) {
            this.racket.setHeight(Globals.SIZE_RACKET_Y);
        } else {
            this.racket.setWidth(Globals.SIZE_RACKET_Y);
        }
    }
}
