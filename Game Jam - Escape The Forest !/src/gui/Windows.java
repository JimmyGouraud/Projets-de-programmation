package gui;

import javax.swing.*;
import java.awt.event.KeyListener;

/**
 * Created by Se Easy on 13/11/2015.
 */
public class Windows extends JFrame{

    private final Level _level;

    public Windows(Level level) {
        this._level = level;
        this.addKeyListener(_level);
    }

    public void displayOnscreen(){
        add(_level);
        pack();
        this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setFocusable(true);
        setVisible(true);
        _level.updateScreen();
        while(true) {
            _level.animate();
            try {
                Thread.sleep(10);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
}
