package tetrimino;

import javax.imageio.ImageIO;
import java.awt.*;
import java.io.File;
import java.io.IOException;

/**
 * Created by Jimmy on 29/09/2015.
 */
public class TetriminoBar extends AbstractTetrimino {
    /**tetrimino barre
     *    [)[)[)[)
     */

    public TetriminoBar() throws IOException{
        super(0, 2, ImageIO.read(new File("images\\sprite\\bleuclair.png")));
    }

    public void updateCoor(){
        switch (getNumPos()){
            case 0:
                setElemTabCoor(0, 0, 1);
                setElemTabCoor(1, 1, 1);
                setElemTabCoor(2, 2, 1);
                setElemTabCoor(3, 3, 1);
                break;
            case 1:
                setElemTabCoor(0, 1, 0);
                setElemTabCoor(1, 1, 1);
                setElemTabCoor(2, 1, 2);
                setElemTabCoor(3, 1, 3);
                break;
        }
    }
}
