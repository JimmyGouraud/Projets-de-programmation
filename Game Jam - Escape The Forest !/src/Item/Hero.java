package Item;

import gui.Map;
import util.Globals;

import javax.swing.*;
import java.awt.*;

/**
 * Created by Jimmy on 13/11/2015.
 */
public class Hero extends Person {

    private long time = System.currentTimeMillis();

    public static int hp = 8; //8 mouvements à perdre
    private boolean sense[] = new boolean[8]; //7 fire 6 couleur 5 musique 4 accroupis 3 reculer 2 saut 1 vue 0 avancer

    protected int indiceWalkRight = 0;
    protected int indiceWalkLeft = 0;
    protected int indiceWalkUp = 0;

    public Hero(){
        this.setHp(hp);
        this.setIndice(0);
        ImageIcon icon;
        for (int i = 0; i < this.getHp(); i++) {
            this.sense[i] = true;
        }
        for (int i = 0; i < 9; i++) {
            this.getTabImage().add(Toolkit.getDefaultToolkit().createImage(
                    ClassLoader.getSystemResource(Globals.imHero[i])));
            icon = new ImageIcon(this.getImage());

            this.setSpeed(new Point(0, 0));
            this.setSurface(new Rectangle(300, 200,
                    icon.getIconWidth(),
                    icon.getIconHeight()));
        }
    }

    public boolean getSense(int indice) {
        return sense[indice];
    }

    public void setSense(boolean sense, int indice) {
        this.sense[indice] = sense;
    }


    @Override
    public void animate() {
        this.getSurface().setLocation(
                (int) (this.getSurface().getX() + this.getSpeed().getX()),
                (int) (this.getSurface().getY() + this.getSpeed().getY()));
    }

    public void animateRight(){
        if (time + 100 < System.currentTimeMillis()) {
            time = System.currentTimeMillis();

            switch (this.indiceWalkRight){
                case 0:
                    this.setNumImage(1);
                    this.indiceWalkRight = 1;
                    break;
                case 1:
                    this.setNumImage(2);
                    this.indiceWalkRight = 0;
                    break;
            }
        }
    }

    public void animateLeft(){
        if (time + 100 < System.currentTimeMillis()) {
            time = System.currentTimeMillis();
            switch (this.indiceWalkLeft){
                case 0:
                    this.setNumImage(4);
                    this.indiceWalkLeft = 1;
                    break;
                case 1:
                    this.setNumImage(5);
                    this.indiceWalkLeft = 0;
                    break;
            }
        }
    }

    public void animateUp(){
        if (time + 100 < System.currentTimeMillis()) {
            time = System.currentTimeMillis();
            switch (this.indiceWalkUp){
                case 0:
                    this.setNumImage(6);
                    this.indiceWalkUp = 1;
                    break;
                case 1:
                    this.setNumImage(7);
                    this.indiceWalkUp = 0;
                    break;
            }
        }
    }

    public void Idle(int cote){
        if(time + 10 < System.currentTimeMillis()) {
            time = System.currentTimeMillis();
            this.setNumImage(cote);
        }
    }
}