package gui;

import util.Globals;
import Item.*;
import javax.swing.*;
import java.awt.*;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.util.ArrayList;

import static java.awt.event.KeyEvent.*;

public class Level extends JPanel implements KeyListener{

    private static final long serialVersionUID = 1L;

    private Image buffer = null;
    private Graphics graphicContext = null;
    long time1 = System.currentTimeMillis();
    long time2 = System.currentTimeMillis();
    long invulnerable;

    public ArrayList<Person> PersonList;
    public ArrayList<ElemDecor> elemDecorList;
    public Hero player;
    public Essence essence;
    public Map map;

    public Level() {
        player = new Hero();
        essence = new Essence();
        map = new Map();

        PersonList = new ArrayList<Person>();
        elemDecorList = new ArrayList<ElemDecor>();

        PersonList.add(player);
        PersonList.add(essence);

        this.setPreferredSize(new Dimension(Globals.SIZE_LEVEL_X, Globals.SIZE_LEVEL_Y));
        this.addKeyListener(this);
    }

    public void animate() {
        if (time1 + 200 < System.currentTimeMillis()) {
            time1 = System.currentTimeMillis();
            essence.getSurface().setLocation((int) essence.getSurface().getX() + Globals.SPEED_CHARAC, (int) essence.getSurface().getY());
            essence.animateWalk();
        }
        for (Person aPersonList : PersonList) {
            aPersonList.animate();
            aPersonList.gravitation(map);
        }
        collisionEnnemy();
        //System.out.println(player.getHp());
        if(player.getHp() <= 0){
            //System.out.println("Game Over");
        }
        this.updateScreen();
    }

    public void collisionEnnemy(){
        if(time2 + 150 < System.currentTimeMillis() && invulnerable > 0){
            time2 = System.currentTimeMillis();
            invulnerable--;
        }
        if(essence.getSurface().getX() + essence.getSurface().getWidth() > player.getSurface().getX() && player.getHp() > 0 && invulnerable <= 0){
            //player.setHp(player.getHp() - 1);
            invulnerable = 2;
        }
        //player.setSense(false, player.getHp());
    }

    public void paint(Graphics g) {
        g.drawImage(buffer, 0, 0, this);
    }
public void updateScroll(){
    int scrollX = (int) this.player.getSurface().getX() + map.getLargeur_fen()*100 ;
    int scrollY  = (int) this.player.getSurface().getY() + map.getHauteur_fen()*100;
    if (scrollY > Globals.SIZE_LEVEL_Y - map.getHauteur_fen())
        scrollY = Globals.SIZE_LEVEL_Y - map.getHauteur_fen();
    if(scrollY < 0)
        scrollY = 0;
    if (scrollX > Globals.SIZE_LEVEL_X - map.getLargeur_fen())
        scrollX = Globals.SIZE_LEVEL_X - map.getLargeur_fen();
    if(scrollX < 0)
        scrollX = 0;
    map.setYscroll(scrollY);
    map.setXscroll(scrollX);
}

    public void updateScreen() {

      //  updateScroll();
        if (buffer == null) {
			/* First time we get called with all windows initialized */
            buffer = createImage(Globals.SIZE_LEVEL_X, Globals.SIZE_LEVEL_Y);
            if (buffer == null)
                throw new RuntimeException("Could not instanciate graphics");
            else
                graphicContext = buffer.getGraphics();
        }

		/* Fill the area with blue */
        graphicContext.setColor(Globals.backgroundColor);
        graphicContext.fillRect(0, 0, Globals.SIZE_LEVEL_X, Globals.SIZE_LEVEL_Y);

		/* Draw items */
        for (int i = map.getYscroll()/100; i < map.getHauteur_fen()/2+ map.getYscroll()/100 ; i++) {
            for (int j = map.getXscroll()/100; j < map.getLargeur_fen()/2 + map.getXscroll()/100 ; j++) {

                graphicContext.drawImage(map.getImageIndice(map.getTile(j, i)),(j - map.getXscroll()) / 100, (i - map.getYscroll()) / 100, 100,  100, null);
            }
        }

        for (Person aPersonList : PersonList) {
//            if(aPersonList.getSurface().getX() > map.getXscroll()
//                    && aPersonList.getSurface().getX() < (map.getXscroll() + map.getLargeur_fen()) * 100
//                    && aPersonList.getSurface().getY() > map.getYscroll()
//                    && aPersonList.getSurface().getY() < (map.getYscroll() + map.getHauteur_fen()) * 100){

                graphicContext.drawImage(aPersonList.getImageIndice(aPersonList.getNumImage()),
                        (int) aPersonList.getSurface().getX(), (int) aPersonList.getSurface().getY(),
                        (int) aPersonList.getSurface().getWidth(), (int) aPersonList.getSurface().getHeight(),
                        null);
            //}
        }
        this.repaint();
    }

    @Override
    public void keyPressed(KeyEvent e) {
        switch (e.getKeyCode()) {
            case VK_UP:
            case VK_KP_UP:
                this.player.moveUp(map);
                this.player.animateUp();
                break;
            case VK_LEFT:
            case VK_KP_LEFT:
                if(this.player.getSense(3)){
                    this.player.moveLeft(map);
                    this.player.animateLeft();
                }
                break;
            case VK_RIGHT:
            case VK_KP_RIGHT:
                if(this.player.getSense(0)){
                    //map.xscroll = map.xscroll + 1;
                    this.player.moveRight(map);
                    this.player.animateRight();
                }
                break;
            case VK_DOWN:
            case VK_KP_DOWN:
                this.player.moveDown(map);
                this.player.animateUp();
                break;
            case VK_ALT:
                break;
            case VK_SPACE:
                if(this.player.getSense(2)){
                    /*if(time + 200 < System.currentTimeMillis()) {
                        time = System.currentTimeMillis();
                        if(this.player.getJmp() == 0){
                            this.player.setJmp(1);
                        }
                        if (this.player.getJmp() == 0) {
                            this.player.moveJump(map);
                        }
                    }*/
                    this.player.moveJump(map);
                    this.player.setSpeed((int) this.player.getSpeed().getX(), -Globals.SPEED_JUMP );
                    //}
                }
                break;
            default:
                break;
        }

    }

    @Override
    public void keyReleased(KeyEvent e) {
        switch (e.getKeyCode()) {
            case VK_UP:
            case VK_KP_UP:
                this.player.Idle(0);
                this.player.setSpeed((int)this.player.getSpeed().getX(), 0);
                break;
            case VK_DOWN:
            case VK_KP_DOWN:
                this.player.setSpeed((int) this.player.getSpeed().getX(), 0);
                break;
            case VK_LEFT:
            case VK_KP_LEFT:
                this.player.Idle(3);
                this.player.setSpeed(0, (int) this.player.getSpeed().getY());
                break;
            case VK_RIGHT:
            case VK_KP_RIGHT:
                this.player.Idle(0);
                this.player.setSpeed(0, (int) this.player.getSpeed().getY());
                break;
            case VK_SPACE:
                this.player.setSpeed((int) this.player.getSpeed().getX(), 0);
                break;
            default:
                break;
        }
    }


//
//    @Override
//    public void keyPressed(KeyEvent e) {
//        switch (e.getKeyCode()) {
//            case VK_UP:
//            case VK_KP_UP:
//                this.player.upLadder();
//                this.player.setSpeed((int)this.player.getSpeed().getX(), -Globals.SPEED_CHARAC);
//                break;
//            case VK_LEFT:
//            case VK_KP_LEFT:
//                if(this.player.getSense(4)){
//                    this.player.moveLeft();
//                    this.player.setSpeed(-Globals.SPEED_CHARAC, (int) this.player.getSpeed().getY());
//                }
//                break;
//            case VK_RIGHT:
//            case VK_KP_RIGHT:
//                if(this.player.getSense(7)){
//                    this.player.walkRight();
//                    this.player.setSpeed(Globals.SPEED_CHARAC, (int) this.player.getSpeed().getY());
//                }
//                break;
//            case VK_DOWN:
//            case VK_KP_DOWN:
//                if(this.player.getSense(3)){
//                    //this.squat();
//                }
//                //this.player.setSpeed((int)this.player.getSpeed().getX()/2, (int)this.player.getSpeed().getY());
//                break;
//            case VK_ALT:
//                if(this.player.getSense(0)){
//                    //this.fire();
//                }
//                break;
//            case VK_SPACE:
//                if(this.player.getSense(5)){
////                    if(time1 + 200 < System.currentTimeMillis()) {
////                        time1 = System.currentTimeMillis();
//                        this.player.setSpeed((int) this.player.getSpeed().getX(), -Globals.SPEED_CHARAC * 2);
////                    }
////                    if(time2 + 200 < System.currentTimeMillis()){
////                        time2 = System.currentTimeMillis();
////                        this.player.setSpeed((int) this.player.getSpeed().getX(), Globals.SPEED_CHARAC * 2);
////                    }
//                }
//                break;
//            default:
//                break;
//        }
//    }
//
//    @Override
//    public void keyReleased(KeyEvent e) {
//        switch (e.getKeyCode()) {
//            case VK_UP:
//            case VK_KP_UP:
//                this.player.Idle(0);
//                this.player.setSpeed((int)this.player.getSpeed().getX(), 0);
//                break;
//            case VK_DOWN:
//            case VK_KP_DOWN:
//                this.player.setSpeed((int) this.player.getSpeed().getX(), 0);
//                break;
//            case VK_LEFT:
//            case VK_KP_LEFT:
//                this.player.Idle(3);
//                this.player.setSpeed(0, (int) this.player.getSpeed().getY());
//                break;
//            case VK_RIGHT:
//            case VK_KP_RIGHT:
//                this.player.Idle(0);
//                this.player.setSpeed(0, (int) this.player.getSpeed().getY());
//                break;
//            case VK_SPACE:
//                this.player.setSpeed((int) this.player.getSpeed().getX(), 0);
//                break;
//            default:
//                break;
//        }
//    }


    @Override
    public void keyTyped(KeyEvent e) {}

}

//Animation tous les cote, tileMapping