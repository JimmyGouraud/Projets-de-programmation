package pong.gui;


import javax.swing.*;


public class Window extends JFrame {

    private final Pong _pong;


    /**
     * Constructor
     */
    public Window(Pong pong) {
        this._pong = pong;
        this.addKeyListener(_pong);
        this.setResizable(false);

        this.initScreen();
    }

    /** Getters & Setters */
    public Pong getPong(){
        return _pong;
    }


    /** Initializing the game screen and adding
     * the Pong in it
     */
    public void initScreen(){
        add(_pong);
        pack();
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setVisible(true);
    }



    /**
     * Displays the Window using the defined margins, and call the
     * {@link Pong#animate()} method of the {@link Pong} every 100ms
     */
    public void displayOnscreen(){
        _pong.collision();
        _pong.animate();
    }
}


