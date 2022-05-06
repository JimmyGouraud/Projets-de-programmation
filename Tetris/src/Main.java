import GUITetris.Tetris;
import GUITetris.Window;

import java.io.IOException;

/**
 * Created by Jimmy on 28/10/2015.
 */
public class Main {

    public static void main (String args[]) throws IOException {
        Tetris tetris = new Tetris();
        Window window = new Window(tetris);
        window.displayOnscreen();
    }
}
