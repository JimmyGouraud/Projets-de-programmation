package GUITetris;

import javax.swing.*;
import java.awt.*;

/**
 * Created by Jimmy on 07/10/2015.
 */
public class Window extends JFrame {

    private final Tetris tetris;

    public Window(Tetris tetris){
        // cr�ation de la fen�tre
        ImageIcon tetrisIcon = new ImageIcon(Toolkit.getDefaultToolkit().createImage(
                ClassLoader.getSystemResource("images/tetris_icon.png")));
        this.setTitle("Tetris");
        this.setIconImage(tetrisIcon.getImage());
        this.setResizable(false);

        this.tetris = tetris;
        this.addKeyListener(tetris);
    }

    public void displayOnscreen() {
        add(tetris);
        pack();
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setVisible(true);

        while (!tetris.gameOver()) {
            tetris.animate();
            try {
                Thread.sleep(10);
            } catch (InterruptedException ignored) {}
        }
    }
}