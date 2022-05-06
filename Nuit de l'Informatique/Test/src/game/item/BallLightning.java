package game.item;

import javax.swing.*;
import java.awt.*;

/**
 * Created by Jimmy on 03/12/2015.
 */
public class BallLightning {
    private Image _imageBL;
    private int _BLHeight;
    private int _BLWidth;

    public BallLightning() {
        this._imageBL = Toolkit.getDefaultToolkit().createImage(
                ClassLoader.getSystemResource("image/bouleFoudre.png"));
        ImageIcon icon = new ImageIcon(this._imageBL);
        this._BLWidth = icon.getIconWidth();
        this._BLHeight = icon.getIconHeight();
    }

    public Image getImageBL() {
        return _imageBL;
    }
    public void setImageBL(Image imageBL) {
        this._imageBL = imageBL;
    }

    public int getBLHeight() {
        return _BLHeight;
    }
    public void setBLHeight(int BLHeight) {
        this._BLHeight = BLHeight;
    }

    public int getBLWidth() {
        return _BLWidth;
    }
    public void set_BLWidth(int _BLWidth) {
        this._BLWidth = _BLWidth;
    }
}
