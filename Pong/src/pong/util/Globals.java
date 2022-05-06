package pong.util;

import java.awt.*;

public class Globals {

    //Number of maximum players
    public static int NB_PLAYER_MAX = 4;
    public static int nbPlayer = 1;

    //Menu
    public static final int SIZE_MENU_X = 500;
    public static final int SIZE_MENU_Y = 400;

    // Pong
    public static final int SIZE_PONG = 800;

    //Window
    public static final int SIZE_WINDOW_X = 800;
    public static final int SIZE_WINDOW_Y = SIZE_PONG + 200;

    // Racket
    public static final int RACKET_SPEED = 6;
    public static final int SIZE_RACKET_X = 30;
    public static final int SIZE_RACKET_Y = 150;

    //Colors
    public static final Color cRacket = new Color(90, 2, 169);
    public static final Color backgroundColor = new Color(161, 20, 255);
    public static final Color cBall = new Color(202, 144, 9);

    //Fonts
    public static Font fTitle = new Font("Arial", Font.PLAIN, 50);
    public static Font fMenu = new Font("Arial", Font.PLAIN, 20);
    public static Font fScore = new Font("Arial", Font.PLAIN, 40);
    public static Font fWin = new Font("Arial", Font.PLAIN, 60);

    // Ball
    public static final int BALL_SPEED = 5;
    public static final int RANGE_BALL_SPEED = BALL_SPEED/2; // différence de fluctuation de la vitesse de la balle
    public static final int SIZE_BALL = 20;

    // Bonus
    public static final int BONUS_SPEED = 2;
    public static final int SIZE_BONUS = 84;
}
