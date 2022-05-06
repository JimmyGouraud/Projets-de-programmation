package Item.Enemy;

import util.Globals;
import Item.*;

import java.awt.*;

/**
 * Created by Jimmy on 13/11/2015.
 */
public class EnemyView extends Enemy {

    public EnemyView(int x, int y, int hp, Point speed) {
        super(x, y, hp, speed, Globals.imEnemyView, 300);
    }

    public void collisionCharacter(Hero hero){
//        hero.lostView();
    }
}
