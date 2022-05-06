package game;

import game.item.Lazer;

import javax.swing.*;
import java.awt.*;

/**
 * Created by Jimmy on 03/12/2015.
 */
public class Player {
    private int _numPlayer;

    private Image _imagePlayer;
    private int _playerWidth;
    private int _playerHeight;

    private Lazer _lazer;

    private Image _imageBoule;
    private int _bouleWidth;
    private int _bouleHeight;

    private int _lengthLazer = 0;
    private int _strenght = 0;


    public Player(int numPlayer, String lazerColor){
        ImageIcon icon;
        this._numPlayer = numPlayer;

        this._imagePlayer = Toolkit.getDefaultToolkit().createImage(
                ClassLoader.getSystemResource("image/ImageHand" + numPlayer + ".png"));
        icon = new ImageIcon(this._imagePlayer);
        this._playerWidth = icon.getIconWidth();
        this._playerHeight = icon.getIconHeight();

        this._lazer = new Lazer(_numPlayer, lazerColor);
    }

    public Lazer getLazer() {
        return _lazer;
    }
    public void setLazer(Lazer lazer) {
        this._lazer = lazer;
    }

    public int getPlayerWidth() {
        return _playerWidth;
    }
    public void setPlayerWidth(int _playerWidth) {
        this._playerWidth = _playerWidth;
    }

    public int getPlayerHeight() {
        return _playerHeight;
    }
    public void setPlayerHeight(int _playerHeight) {
        this._playerHeight = _playerHeight;
    }

    public int getBouleWidth() {
        return _bouleWidth;
    }
    public void setBouleWidth(int _bouleWidth) {
        this._bouleWidth = _bouleWidth;
    }

    public int getNumPlayer() {
        return _numPlayer;
    }
    public void setNumPlayer(int numPlayer) {
        this._numPlayer = numPlayer;
    }

    public Image getImagePlayer() {
        return _imagePlayer;
    }
    public void setImagePlayer(Image imagePlayer) {
        this._imagePlayer = imagePlayer;
    }

    public Image getImageBoule() {
        return _imageBoule;
    }
    public void setImageBoule(Image imageBoule) {
        this._imageBoule = imageBoule;
    }

    public int getLengthLazer() {
        return _lengthLazer;
    }
    public void setLengthLazer(int lengthLazer) {
        this._lengthLazer = lengthLazer;
    }

    public int getStrenght() {
        return _strenght;
    }
    public void setStrenght(int strenght) {
        this._strenght = strenght;
    }

}
