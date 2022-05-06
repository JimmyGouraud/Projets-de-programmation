package tetrimino;

import javax.imageio.ImageIO;
import java.io.File;
import java.io.IOException;

/**
 * Created by Jimmy on 29/09/2015.
 */
public class TetriminoS extends AbstractTetrimino {
    /** tetrimino S
     *       [][]
     *     [][]
     */
    public TetriminoS() throws IOException {
        super(6, 2, ImageIO.read(new File("images\\sprite\\rouge.png")));
    }

    public void updateCoor(){
        switch (getNumPos()) {
            case 0:
                setElemTabCoor(0, 1, 1);
                setElemTabCoor(1, 0, 1);
                setElemTabCoor(2, 2, 2);
                setElemTabCoor(3, 1, 2);
                break;
            case 1:
                setElemTabCoor(0, 0, 2);
                setElemTabCoor(1, 0, 1);
                setElemTabCoor(2, 1, 1);
                setElemTabCoor(3, 1, 0);
                break;
        }
    }
}