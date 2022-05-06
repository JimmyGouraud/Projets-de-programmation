package Item;

import gui.Map;
import util.Globals;

import java.awt.*;
import java.util.ArrayList;

/**
 * Created by Jimmy on 13/11/2015.
 */
public abstract class Person extends Item {
    Point _speed;
    private int _hp;
    ArrayList<Image> _tabImage = new ArrayList<Image>();
    int _numImage = 0;
    int _indice = 0;
    protected int jmp = 0;

    public ArrayList<Image> getTabImage() {
        return _tabImage;
    }

    public void setTabImage(ArrayList<Image> tabImage) {
        this._tabImage = tabImage;
    }

    public int getNumImage() {
        return _numImage;
    }

    public void setIndice(int indice) {
        this._indice = indice;
    }

    public void setNumImage(int numImage) {
        this._numImage = numImage;
    }

    public int getJmp() {
        return this.jmp;
    }

    public void setJmp(int jmp) {
        this.jmp = jmp;
    }

    public Image getImageIndice(int indice) {
        return this._tabImage.get(indice);
    }

    public Image getImage() {
        return this._tabImage.get(_numImage);
    }

    public void setImage(int indice, Image image) {
        this.getTabImage().set(indice, image);
    }

    public int getHp() {
        return _hp;
    }

    public void setHp(int hp) {
        this._hp = hp;
    }

    public Point getSpeed() {
        return _speed;
    }

    public void setSpeed(Point speed) {
        this._speed = (Point) speed.clone();
    }

    public void setSpeed(int x, int y) {
        this._speed = new Point(x, y);
    }

    public void animateAll(ArrayList<Person> tabPerson) {
        for (Person aTabPerson : tabPerson) {
            if (aTabPerson != null) {
                aTabPerson.animate();
            }
        }
    }

    public abstract void animate();

    // Retourne true si le personnage a fait une collision
//    public boolean collisionDecor(Map map) {
//        for (int y = map.getYscroll(); y <  map.getHauteur_fen() + map.getYscroll(); y++){
//            for (int x = map.getXscroll(); x < map.getLargeur_fen() + map.getXscroll(); x++) {
//                if((this.getSurface().intersects(map.getSurface(x, y)))){
//                    int i = map.getTile(x ,y);
//                    if(i == 2 || i == 3 || i == 4 || i == 5 || i == 6 || i == 7 || i > 10){
//                        return true;
//                    }
//                }
//            }
//        }
//        return false;
//    }
//
    public boolean collision(Map map){
        for (int y = 0; y < map.getNbtilesY(); y++) {
            for (int x = 0; x < map.getNbtilesX(); x++) {

                if (this.getSurface().intersects(map.getSurface(x, y)) && (map.getTile(x , y ) != 0 && map.getTile(x, y) != 1 && map.getTile( x ,y) != 9
                        && map.getTile(x, y) != 11 && map.getTile(x, y) !=12))
                    return true;
            }
        }

        return false;
}

    public boolean collisionLadder(Map map) {
        for (int y = 0; y < map.getNbtilesY(); y++) {
            for (int x = 0; x < map.getNbtilesX(); x++) {
                if (this.getSurface().intersects(map.getSurface(x , y ))){
                    if (map.getTile(x, y) == 9 || map.getTile(x, y) == 10){
                        //System.out.println("true ladder");
                        return  true;
                    }
                }
            }
        }
        return false;
    }

    // Applique la gravité
    private boolean cannotGravitation(Map map){
        if(this.getSurface().getMaxY() == 1800)
            return false;
        this.getSurface().setLocation((int) getSurface().getX(), (int) getSurface().getY() + Globals.GRAVITATION);
        boolean b = collision(map);
        this.getSurface().setLocation((int) getSurface().getX(), (int) getSurface().getY() - Globals.GRAVITATION);
        return b;
    }

    private void doGravitation() {
        this.getSurface().setLocation((int) getSurface().getX(), (int) getSurface().getY() + Globals.GRAVITATION);
        System.out.println("je descend");
    }

    public void gravitation(Map map){
        System.out.println("gravitation " + cannotGravitation(map));
        System.out.println("lader " + collisionLadder(map));
        if(!cannotGravitation(map) && !collisionLadder(map)){
            doGravitation();
        }
    }

    //Jump
    private boolean cannotJump(Map map) {
        this.getSurface().setLocation((int) getSurface().getX(), (int) getSurface().getY() - Globals.SPEED_JUMP);
        boolean b = collision(map);
        this.getSurface().setLocation((int) getSurface().getX(), (int) getSurface().getY() + Globals.SPEED_JUMP);
        return b;
    }

    public boolean canJump(Map map) {
        this.getSurface().setLocation((int) getSurface().getX(), (int) getSurface().getY() + Globals.SPEED_JUMP);
        boolean b = !collision(map);
        this.getSurface().setLocation((int) getSurface().getX(), (int) getSurface().getY() - Globals.SPEED_JUMP);
        return b;
    }

    private void doJump() {
        this.getSurface().setLocation((int) getSurface().getX(), (int) getSurface().getY() - Globals.SPEED_JUMP);
    }

    public void moveJump(Map map){
        if(!cannotJump(map)){
            doJump();
        }
    }

    // move Right
    private boolean cannotMoveRight(Map map){
        this.getSurface().setLocation((int) getSurface().getX() + Globals.SPEED_CHARAC, (int) getSurface().getY());
        boolean b = collision(map);
        this.getSurface().setLocation((int) getSurface().getX() - Globals.SPEED_CHARAC, (int) getSurface().getY());
        return b;
    }


    private void doMoveRight () {
        this.getSurface().setLocation((int) getSurface().getX() + Globals.SPEED_CHARAC, (int) getSurface().getY());
    }

    public void moveRight (Map map){
        if(!cannotMoveRight(map)){
            doMoveRight();
        }
    }

    // move Up
    /*private boolean canMoveUp(Map map){
        int tile map.getTile((int) getSurface().getX() / 100, (int) getSurface().getY());
        return tile == 9 || tile == 10;
    }*/


    private void doMoveUp () {
        this.getSurface().setLocation((int) getSurface().getX(), (int) getSurface().getY() - Globals.SPEED_CHARAC);
    }

    private void doMoveDown () {
        this.getSurface().setLocation((int) getSurface().getX(), (int) getSurface().getY() + Globals.SPEED_CHARAC);
    }

    private boolean cannotMoveUp(Map map){
        this.getSurface().setLocation((int) getSurface().getX(), (int) getSurface().getY() - Globals.SPEED_CHARAC);
        boolean b = collision(map);
        this.getSurface().setLocation((int) getSurface().getX(), (int) getSurface().getY() + Globals.SPEED_CHARAC);
        return b;
    }

    private boolean cannotMoveDown(Map map){
        this.getSurface().setLocation((int) getSurface().getX(), (int) getSurface().getY() + Globals.SPEED_CHARAC);
        boolean b = collision(map);
        this.getSurface().setLocation((int) getSurface().getX(), (int) getSurface().getY() - Globals.SPEED_CHARAC);
        return b;
    }

    public void moveUp (Map map){
        if(collisionLadder(map) && !cannotMoveUp(map)){
            doMoveUp();
        }
    }

    public  void moveDown(Map map){
        if(collisionLadder(map) && !cannotMoveDown(map)){
            doMoveDown();
        }
    }

    // move left
    private boolean cannotMoveLeft(Map map){
        this.getSurface().setLocation((int) getSurface().getX() - Globals.SPEED_CHARAC, (int) getSurface().getY());
        boolean b = collision(map);
        this.getSurface().setLocation((int) getSurface().getX() + Globals.SPEED_CHARAC, (int) getSurface().getY());
        return b;
    }

    private void doMoveLeft () {
        this.getSurface().setLocation((int) getSurface().getX() - Globals.SPEED_CHARAC, (int) getSurface().getY());
    }

    public void moveLeft (Map map){
        if(!cannotMoveLeft(map)){
            doMoveLeft();
        }
    }

}

