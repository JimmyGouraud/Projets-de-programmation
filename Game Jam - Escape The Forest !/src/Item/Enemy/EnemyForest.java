package Item.Enemy;

import util.Globals;
import Item.*;

import java.awt.*;

/**
 * Created by Jimmy on 13/11/2015.
 */
public class EnemyForest extends Enemy{

    public EnemyForest(int x, int y, int hp, Point speed) {
        super(x, y, hp, speed, Globals.imEnemyForest, 10000);
    }

    public void collisionCharacter(Hero hero){
//        hero.lostSense();
        this.getSurface().setLocation((int)this.getSurface().getX() - 500, (int)this.getSurface().getY());
    }
}
