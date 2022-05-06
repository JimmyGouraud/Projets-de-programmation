package pong.item;


import pong.util.Globals;
import sun.java2d.Surface;

import javax.xml.bind.annotation.XmlElementDecl;
import java.awt.*;
import java.util.ArrayList;

public abstract class PongItem {

    // Number of pongItem
    private int _num;

    // Speed of pongItem
    private Point _speed = new Point(0,0);

    // Rectangle of pongItem (contient sa position, sa largeur, sa longueur)
    private Rectangle _surface = new Rectangle();

    /**
     * Constructors
     * @param num {int] (Number of PongItem or Player)
     */
    public PongItem(int num) {
        this._num = num;
        this._surface.setLocation(0,0);
    }

    public PongItem(int num, int x, int y) {
        this._num = num;
        this._surface.setLocation(x,y);
    }


    /** Getters & Setters */

    public int getNum() {
        return this._num;
    }
    public void setNum(int num) {
        this._num = num;
    }

    public int getWidth() {
        return (int)this._surface.getWidth();
    }
    public void setWidth(int width) {
        this._surface.setSize(width, (int)this._surface.getHeight());
    }

    public int getHeight() {
        return (int)this._surface.getHeight();
    }
    public void setHeight(int height) {
        this._surface.setSize((int)this._surface.getWidth(), height);
    }

    public int getSpeedX(){
        return (int)_speed.getX();
    }
    public int getSpeedY(){
        return (int)_speed.getY();
    }

    public void setSpeed(int x, int y) {
        this._speed.setLocation(x, y);
    }
    public void setSpeedX(int x) {
        this._speed.setLocation(x, this._speed.getY());
    }
    public void setSpeedY(int y) {
        this._speed.setLocation(this._speed.getX(), y);
    }

    public int getPosX(){
        return (int)this._surface.getX();
    }
    public int getPosY(){
        return (int)this._surface.getY();
    }

    public void setPosition(int x, int y) {
        this._surface.setLocation(x, y);
    }
    public void setPosX(int x) {
        this._surface.setLocation(x, (int) this._surface.getY());
    }
    public void setPosY(int y) {
        this._surface.setLocation((int) this._surface.getX(), y);
    }

    public Rectangle getSurface() {
        return (Rectangle) this._surface.clone();
    }
    public void setSurface(Rectangle surface) {
        this._surface = (Rectangle) surface.clone();
    }


    /** Fonctions */

    /**
     * Checks for collisions of all PongItems in the PongItem Array
     * @param tabPongItem {ArrayList<PongItem>}
     */
    public static void collisionAll(ArrayList<PongItem> tabPongItem) {
        for (int i = 0; i < tabPongItem.size(); i++) {
            for (int j = 0; j < tabPongItem.size(); j++) {
                if (i != j) {
                    tabPongItem.get(i).collision(tabPongItem.get(j));
                }
            }
        }
    }

    /**
     * Animates all the PongItems in the PongItem Array
     * @param tabPongItem {ArrayList<PongItem}
     */
    public static void animateAll(ArrayList<PongItem> tabPongItem) {
        for (PongItem pongItem : tabPongItem) {
            if (pongItem != null)
                pongItem.animate();
        }
    }

    /**
     * Deplacement de base des PongItems
     */
    public void animate (){
        this.setPosition(this.getPosX() + this.getSpeedX(), this.getPosY() + this.getSpeedY());

        if (this.getPosX() < 0){
            this.setPosX(0);
            this.setSpeedX(-this.getSpeedX());
        }
        if (this.getPosY() < 0){
            this.setPosY(0);
            this.setSpeedY(-this.getSpeedY());
        }
        if (this.getPosX() > (Globals.SIZE_PONG - this.getWidth())){
            this.setPosX(Globals.SIZE_PONG - this.getWidth());
            this.setSpeedX(-this.getSpeedX());
        }
        if (this.getPosY() > (Globals.SIZE_PONG - this.getHeight())){
            this.setPosY(Globals.SIZE_PONG - this.getHeight());
            this.setSpeedY(-this.getSpeedY());
        }
    }

    public void collision(PongItem pongItem) { }

}
