package Item;

import sun.java2d.Surface;

import java.awt.*;

/**
 * Created by Jimmy on 14/11/2015.
 */
public class ElemDecor extends Item{
    private Image _image;
    private int mur = 0;

    public ElemDecor(Image image){
        this._image = image;
        Rectangle surface = new Rectangle(0, 0,
                this._image.getWidth(null), this._image.getHeight(null));
        this.setSurface(surface);
    }

    public Image getImage() {
            return _image;
        }
    public void setImage(Image image) {
            this._image = image;
        }
    public void setMur(int in){
        this.mur = in;
    }

    public int getMur(){
        return this.mur;
    }
}

