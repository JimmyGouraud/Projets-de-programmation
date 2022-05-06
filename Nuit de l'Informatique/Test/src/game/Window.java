package game;

import javax.swing.*;

/**
 * Created by Jimmy on 03/12/2015.
 */
public class Window extends JFrame{
    Game _game;

    public Window(){
        initWindow();
        initGame();
    }

    public void initWindow(){
        this.setTitle("Star Wars Strength");
        this.setSize(Globals.SIZE_GAME_X, Globals.SIZE_GAME_Y);
        this.setLocationRelativeTo(null);
        this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        this.setVisible(true);
    }

    public void initGame(){
        _game = new Game();
        this.add(_game);
        this.pack();
        this.addKeyListener(_game);
    }


    public void displayGame(){
        while (!_game.gameOver() && !_game.gameWin()){
            _game.updateScreen();
            try {
                Thread.sleep(Game.timestep);
            } catch (InterruptedException ignored) {}
        }
        _game.updateScreen();

    }
}
