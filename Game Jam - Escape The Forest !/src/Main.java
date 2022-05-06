import gui.Level;
import gui.Windows;

/**
 * Created by Se Easy on 13/11/2015.
 */
public class Main {
    public static void main(String[] args) throws InterruptedException {
        Level level  = new Level();
        Windows window = new Windows(level);
        window.displayOnscreen();
    }
}

