package tetrimino;

import javax.imageio.ImageIO;
import java.io.File;
import java.io.IOException;

/**
 * Created by Jimmy on 29/09/2015.
 */
public class TetriminoT extends AbstractTetrimino {
    /** tetrimino T
     *     [][][]
     *       []
     */

    public TetriminoT() throws IOException {
        super(3, 4, ImageIO.read(new File("images\\sprite\\violet.png")));
    }

    public void updateCoor(){
        switch (getNumPos()) {
            case 0:
                setElemTabCoor(0, 0, 1);
                setElemTabCoor(1, 1, 1);
                setElemTabCoor(2, 2, 1);
                setElemTabCoor(3, 1, 2);
                break;
            case 1:
                setElemTabCoor(0, 1, 0);
                setElemTabCoor(1, 1, 1);
                setElemTabCoor(2, 1, 2);
                setElemTabCoor(3, 0, 1);
                break;
            case 2:
                setElemTabCoor(0, 0, 1);
                setElemTabCoor(1, 1, 1);
                setElemTabCoor(2, 2, 1);
                setElemTabCoor(3, 1, 0);
                break;
            case 3:
                setElemTabCoor(0, 1, 0);
                setElemTabCoor(1, 1, 1);
                setElemTabCoor(2, 1, 2);
                setElemTabCoor(3, 2, 1);
                break;
        }
    }
}