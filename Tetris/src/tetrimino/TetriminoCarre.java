package tetrimino;

import javax.imageio.ImageIO;
import java.awt.*;
import java.io.File;
import java.io.IOException;

/**
 * Created by Jimmy on 29/09/2015.
 */
public class TetriminoCarre extends AbstractTetrimino {
    /** tetrimino carre
     *     [][]
     *     [][]
     */

    public TetriminoCarre() throws IOException{
        super(1, 0, ImageIO.read(new File("images\\sprite\\jaune.png")));
        setElemTabCoor(0, 1, 1);
        setElemTabCoor(1, 2, 1);
        setElemTabCoor(2, 1, 2);
        setElemTabCoor(3, 2, 2);
    }
}
