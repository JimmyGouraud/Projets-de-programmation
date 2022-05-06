package Item;

import gui.Map;
import util.Globals;

import javax.swing.*;
import java.awt.*;

/**
 * Created by Jimmy on 15/11/2015.
 */
public class Essence extends Person{

    protected int indiceWalk = 0;
    protected long time = System.currentTimeMillis();

    public Essence(){
        this.setIndice(0);
        ImageIcon icon;
        for (int i = 0; i < 2; i++) {
            this.getTabImage().add(Toolkit.getDefaultToolkit().createImage(
                    ClassLoader.getSystemResource(Globals.essence[i])));
            icon = new ImageIcon(this.getImage());

            this.setSpeed(new Point(0, 0));
            this.setSurface(new Rectangle(0, 100,
                    icon.getIconWidth(),
                    icon.getIconHeight()));
        }
    }

    public void animate() {
        this.getSurface().setLocation(
                (int) (this.getSurface().getX() + this.getSpeed().getX()),
                (int) (this.getSurface().getY() + this.getSpeed().getY()));
    }

    public void animateWalk(){
        if (time + 100 < System.currentTimeMillis()) {
            time = System.currentTimeMillis();

            switch (this.indiceWalk){
                case 0:
                    this.setNumImage(0);
                    this.indiceWalk = 1;
                    break;
                case 1:
                    this.setNumImage(1);
                    this.indiceWalk = 0;
                    break;
            }
        }
    }


}
