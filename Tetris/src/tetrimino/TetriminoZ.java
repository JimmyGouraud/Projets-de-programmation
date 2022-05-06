package tetrimino;

import javax.imageio.ImageIO;
import java.io.File;
import java.io.IOException;

/**
 * Created by Jimmy on 29/09/2015.
 */
public class TetriminoZ extends AbstractTetrimino {
    /** tetrimino Z
     *     [][]
     *       [][]
     */

    public TetriminoZ() throws IOException{
        super(2, 2, ImageIO.read(new File("images\\sprite\\vert.png")));
    }

    public void updateCoor(){
        switch (getNumPos()) {
            case 0:
                setElemTabCoor(0, 1, 1);
                setElemTabCoor(1, 2, 1);
                setElemTabCoor(2, 1, 2);
                setElemTabCoor(3, 0, 2);
                break;
            case 1:
                setElemTabCoor(0, 0, 0);
                setElemTabCoor(1, 0, 1);
                setElemTabCoor(2, 1, 1);
                setElemTabCoor(3, 1, 2);
                break;
        }
    }
}