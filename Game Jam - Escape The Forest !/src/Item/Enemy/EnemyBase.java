package Item.Enemy;

import util.Globals;

import java.awt.*;

/**
 * Created by Jimmy on 13/11/2015.
 */
public class EnemyBase extends Enemy{

    public EnemyBase(int x, int y, int hp, Point speed) {
        super(x, y, hp, speed, Globals.imEnemyBase, 300);
    }
}
