package util;

import java.awt.*;

/**
 * Created by Jimmy on 13/11/2015.
 */
public class Globals {

    // Chemin images Item
    public static final String imEnemyBase = "image/EnemyBase.png";
    public static final String imEnemyForest = "image/EnemyForest.png";
    public static final String imEnemyInverse = "image/EnemyInverse.png";
    public static final String imEnemyView = "image/EnemyView.png";


    public static final String[] imHero = {"image/droite_idle.png" ,"image/droite_run.png", "image/droite_run2.png", "image/gauche_idle.png",
            "image/gauche_run1.png","image/gauche_run2.png","image/heros_dos.png", "image/heros_dos2.png",
            "image/idle.png"};


    public static final String[] tileSetS = {"image/background.png", "image/background.png" , "image/plateforme3.png" ,"image/block-sol.png", "image/plateforme2.png"
            , "image/high_floor.png", "image/platform.png", "image/floor.png","image/hole.png", "image/ladder-1.png", "image/ladder-2.png"
            , "image/camion-300-1.png", "image/camion-300-2.png", "image/camion-300-3.png", "image/camion-300-4.png"
            , "image/camion-300-4.png", "image/camion-300-5.png", "image/camion-300-6.png", "image/camion-400-1.png", "image/camion-400-2.png"
            , "image/camion-400-3.png", "image/camion-400-4.png", "image/camion-400-5.png", "image/camion-400-6.png", "image/camion-400-7.png"
            , "image/camion-400-8.png"};

    public static final String[] essence = {"image/Monster-plante-R1.png", "image/Monster-plante-R2.png"};

    public static final String level = "src/level/level1.txt";
    public static final String imItem = "image/Item.png";

    // Variable globales
    public static int SPEED_CHARAC = 20;
    public static int SPEED_JUMP = 10;
    public static final int SIZE_LEVEL_X = 1000;
    public static final int SIZE_LEVEL_Y = 800;
    public static final int GRAVITATION = 5;
    public static final int SPEED_ESSENCE = 10;

    // Autres
    public static final Color backgroundColor = new Color(24, 184, 209);
    public static final int timestep = 10;

}
