package Item.Enemy;

import Item.*;
import util.Globals;

import javax.swing.*;
import java.awt.*;
import java.util.ArrayList;

/**
 * Created by Jimmy on 13/11/2015.
 */
public abstract class Enemy extends Person{

    private int _patternLength;
    private int _patternBegin;

    public Enemy(int x, int y, int hp, Point speed, String imagePath, int pattern){
        ImageIcon icon;
        this.getTabImage().add(Toolkit.getDefaultToolkit().createImage(
                ClassLoader.getSystemResource(imagePath)));
        icon = new ImageIcon(this.getImage());
        this.setSpeed(speed);
        this.setSurface(new Rectangle(x, y,
                icon.getIconWidth(),
                icon.getIconHeight()));
        this.setHp(hp);
        this._patternLength = (int)this.getSurface().getX() + pattern;
        this._patternBegin = (int)this.getSurface().getX();
    }

    public void animate(){
        if (getSurface().getWidth() > this._patternLength || getSurface().getX() < this._patternBegin)
            this.setSpeed((int) -this.getSpeed().getX(), (int)this.getSpeed().getY());
    }

    public void collisionAll(ArrayList<Person> tabPerso){
        for (Person aTabPerso : tabPerso) {
            if (aTabPerso.getClass().getSimpleName() == "Hero") {
                collisionCharacter((Hero) aTabPerso);
            }
        }
    }

    public void collisionCharacter(Hero hero){
//        hero.setHp(hero.getHp - 1);
//        hero.invulnerable();
    }
}
