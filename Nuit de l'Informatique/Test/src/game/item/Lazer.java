package game.item;

import javax.swing.*;
import java.awt.*;

/**
 * Created by Jimmy on 03/12/2015.
 */
public class Lazer {
    private int _numLazer;
    private Image _imageLazer;
    private int _lazerWidth;
    private int _lazerHeight;
    private String _lazerColor;

    public Lazer(int num, String lazerColor) {
        this._numLazer = num;
        this._lazerColor = lazerColor;
        this._imageLazer = Toolkit.getDefaultToolkit().createImage(
                ClassLoader.getSystemResource("image/eclair" + this._lazerColor + "" + this._numLazer + ".png"));
        ImageIcon icon = new ImageIcon(this._imageLazer);
        this._lazerWidth = icon.getIconWidth();
        this._lazerHeight = icon.getIconHeight();
    }

    public int getNumLazer() {
        return _numLazer;
    }
    public void setNumLazer(int numLazer) {
        this._numLazer = numLazer;
    }

    public Image getImageLazer() {
        return _imageLazer;
    }
    public void setImageLazer(Image imageLazer) {
        this._imageLazer = imageLazer;
    }

    public int getLazerWidth() {
        return _lazerWidth;
    }
    public void setlazerWidth(int lazerWidth) {
        this._lazerWidth = lazerWidth;
    }

    public int getLazerHeight() {
        return _lazerHeight;
    }
    public void setLazerHeight(int lazerHeight) {
        this._lazerHeight = lazerHeight;
    }

    public String getLazerColor() {
        return _lazerColor;
    }
    public void setLazerColor(String lazerColor) {
        this._lazerColor = lazerColor;
    }
}
