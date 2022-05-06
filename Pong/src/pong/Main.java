package pong;

import pong.gui.Menu;
import pong.gui.Pong;
import pong.gui.Window;
import pong.network.Player;
import pong.util.Globals;

import java.io.IOException;


/**
 * Created by Jimmy on 30/11/2015.
 */
public class Main {
    public static void main(String[] args) throws IOException {
        Pong pong = new Pong();
        Player player = new Player(pong);

        player.createServer();

        menu_display(player);

        pong.initPong();

        Window window = new Window(player.getPong());
        window.displayOnscreen();


        // loop game
        while (true) {
            player.sendDataPong();
            player.receiveDataPong();

            window.displayOnscreen();

            try {
                Thread.sleep(Pong.timestep);
            } catch (InterruptedException ignored) {}
        }
    }

    public static void menu_display(Player player){
        Menu menu = new Menu(player);

        menu.displayOnscreen();
        while (!menu.allPlayerConnected){
            try {
                Thread.sleep(Pong.timestep);
            } catch (InterruptedException ignored) {}
        }

        player.endConnectionPlayer();
        menu.dispose();
    }
}
