package Item;

import java.awt.*;
import java.util.ArrayList;

/**
 * Created by Jimmy on 13/11/2015.
 */
public abstract class Item {
    Rectangle _surface;

    public Rectangle getSurface() {
        return _surface;
    }
    public void setSurface(Rectangle surface) {
        this._surface = surface;
    }

}
