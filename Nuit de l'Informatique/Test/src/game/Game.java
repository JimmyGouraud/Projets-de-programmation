package game;

import game.item.BallLightning;

import javax.swing.*;
import java.awt.*;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.awt.image.BufferedImage;

/**
 * Created by Jimmy on 03/12/2015.
 */
public class Game extends JPanel implements KeyListener{

    public static final int MENU = 0;
    public static final int GAME = 1;
    public static final int WIN = 2;
    public static final int LOST = 3;
    public static final int CREDIT = 4;
    public static final int INFO = 3;

    private static final long serialVersionUID = 1L;
    public static int timestep = 10;
    long _timeGame;
    boolean _contact = false;
    private static final Color backgroundColor = new Color(63, 113, 202);

    private BufferedImage buffer = null;
    private Graphics2D graphicContext = null;

    private BallLightning _BallLightning;

    private Image _imageBackground;
    private Image _imageMenu;
    private Image _imageGameWin;
    private Image _imageGameOver;

    private Font font = new Font("Arial", 1, 30);
    private Font fontTitle = new Font("Arial", 1, 50);

    private Rectangle gameover;
    private Rectangle gamewin;

    private int _numPlayer = 1;
    int status = MENU;
    private Player _player1;
    private Player _player2;

    public Game(){
        initGame();
        _BallLightning = new BallLightning();
        _player1 = new Player(1, "Bleu");
        _player2 = new Player(2, "Rouge");
        _timeGame = System.currentTimeMillis();
        this.setPreferredSize(new Dimension(Globals.SIZE_GAME_X, Globals.SIZE_GAME_Y));
    }

    public void initGame(){
        this._imageBackground = Toolkit.getDefaultToolkit().createImage(
                ClassLoader.getSystemResource("image/background.png"));
        this._imageMenu = Toolkit.getDefaultToolkit().createImage(
                ClassLoader.getSystemResource("image/menu.jpg"));
        this._imageGameOver = Toolkit.getDefaultToolkit().createImage(
                ClassLoader.getSystemResource("image/gameOver.jpg"));
        ImageIcon icon = new ImageIcon(_imageGameOver);
        this.gameover = new Rectangle(0,0,icon.getIconWidth(), icon.getIconHeight());
        this._imageGameWin = Toolkit.getDefaultToolkit().createImage(
                ClassLoader.getSystemResource("image/gameWin.jpg"));
        icon = new ImageIcon(_imageGameWin);
        this.gamewin = new Rectangle(0,0,icon.getIconWidth(), icon.getIconHeight());
    }


    public void paint(Graphics g) {
        g.drawImage(buffer, 0, 0, this);
    }

    public void updateScreen() {
        System.out.println(status);
        if (buffer == null) {
			/* First time we get called with all windows initialized */
            buffer = new BufferedImage(Globals.SIZE_GAME_X, Globals.SIZE_GAME_Y, BufferedImage.TYPE_INT_RGB);

            if (buffer == null)
                throw new RuntimeException("Could not instanciate graphics");
            else
                graphicContext = (Graphics2D) buffer.getGraphics();
        }

        switch (status){
            case MENU:
                graphicContext.drawImage(_imageMenu, 0, 0, Globals.SIZE_GAME_X, Globals.SIZE_GAME_Y, null);
                graphicContext.setColor(Color.BLACK);
                graphicContext.setFont(font);
                graphicContext.drawString("F1", 513, 483);
                graphicContext.setColor(Color.BLACK);
                graphicContext.setFont(font);
                graphicContext.drawString("F2", 513, 550);
                graphicContext.setColor(Color.BLACK);
                graphicContext.setFont(font);
                graphicContext.drawString("F3", 513, 620);
                break;
            case GAME:
                if (_timeGame + 150 < System.currentTimeMillis()) {
                    _timeGame = System.currentTimeMillis();
                    IAMove();
                }
                /* Fill the area with a color */
                graphicContext.drawImage(_imageBackground, 0, 0, Globals.SIZE_GAME_X, Globals.SIZE_GAME_Y, null);

                graphicContext.drawImage(_player1.getLazer().getImageLazer(), -_player1.getLazer().getLazerWidth() + _player1.getLengthLazer() + _player1.getPlayerWidth(),
                        (Globals.SIZE_GAME_Y - _player1.getLazer().getLazerHeight()) / 2, _player1.getLazer().getLazerWidth(), _player1.getLazer().getLazerHeight(), null);
                graphicContext.drawImage(_player2.getLazer().getImageLazer(), Globals.SIZE_GAME_X - _player2.getLengthLazer() - _player2.getPlayerWidth(),
                        (Globals.SIZE_GAME_Y - _player2.getLazer().getLazerHeight()) / 2, _player2.getLazer().getLazerWidth(), _player2.getLazer().getLazerHeight(), null);

                graphicContext.drawImage(_player1.getImagePlayer(), 0, (Globals.SIZE_GAME_Y - _player1.getPlayerHeight()) / 2 - 30,
                        _player1.getPlayerWidth(), _player1.getPlayerHeight(), null);
                graphicContext.drawImage(_player2.getImagePlayer(), (Globals.SIZE_GAME_X - _player2.getPlayerWidth()),
                        (Globals.SIZE_GAME_Y - _player2.getPlayerHeight()) / 2 - 30, _player2.getPlayerWidth(), _player2.getPlayerHeight(), null);

                if (_contact) {
                    graphicContext.drawImage(_BallLightning.getImageBL(), _player1.getLengthLazer() + _player1.getPlayerWidth() - _BallLightning.getBLWidth() / 2,
                            (Globals.SIZE_GAME_Y - _BallLightning.getBLHeight()) / 2, _BallLightning.getBLWidth(), _BallLightning.getBLHeight(), null);
                }
                break;
            case WIN:
                graphicContext.drawImage(_imageGameWin, 0, 0, (int)gamewin.getWidth(), (int)gamewin.getHeight(), null);
                break;
            case LOST:
                graphicContext.drawImage(_imageGameOver, 0, 0, (int)gameover.getWidth(), (int)gameover.getHeight(), null);
                break;
            case CREDIT:
                graphicContext.setColor(backgroundColor);
                graphicContext.fillRect(0, 0, Globals.SIZE_GAME_X, Globals.SIZE_GAME_Y);
                graphicContext.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
                graphicContext.setColor(Color.BLACK);
                graphicContext.setFont(fontTitle);
                graphicContext.drawString("Créer pendant la Nuit de l'Informatique 2015", 50, 250);
                graphicContext.setFont(font);
                graphicContext.drawString("Graphiste : Nicolas Palard", 180, 380);
                graphicContext.drawString("Programmeur : Jimmy Gouraud", 180, 420);
                graphicContext.drawString("Débuggeuse : Ysabelle Emery", 180, 460);
                graphicContext.drawString("Soutien mental : Sébastien Pouteau feat Laétitia", 180, 500);
                graphicContext.drawString("Bulgare : Yordan Kirov", 180, 540);
            default:
                break;
        }

        this.repaint();
    }

    public boolean contact(){
        if((_player1.getLengthLazer() + _player1.getPlayerWidth()) >= (Globals.SIZE_GAME_X -_player2.getLengthLazer() - _player2.getPlayerWidth())){
            _contact = true;
        }
        return _contact;
    }

    public boolean gameOver(){
        if((_numPlayer == 1 && this._player1.getLengthLazer() < -30) ||
                (_numPlayer == 2 && this._player2.getLengthLazer() < -30)) {
            status = LOST;
            return true;
        }
        return false;
    }

    public boolean gameWin(){
        if((_numPlayer == 1 && this._player2.getLengthLazer() < -30) ||
                (_numPlayer == 2 && this._player1.getLengthLazer() < -30)){
            status = WIN;
            return true;
        }
        return false;
    }

    public void updatePos(){
        if(_numPlayer == 1)
            this._player2.setLengthLazer(this._player2.getLengthLazer() - 20);
        else
            this._player1.setLengthLazer(this._player1.getLengthLazer() - 20);
    }

    public void IAMove(){
        this._player2.setLengthLazer(this._player2.getLengthLazer() + 20);
        if (contact()) {
            this._player1.setLengthLazer(this._player1.getLengthLazer() - 20);
        }
    }

    @Override
    public void keyReleased(KeyEvent e) {
        switch (e.getKeyCode()){
            case KeyEvent.VK_SPACE:
                if(_numPlayer == 1)
                    this._player1.setLengthLazer(this._player1.getLengthLazer() + 20);
                else
                    this._player2.setLengthLazer(this._player2.getLengthLazer() + 20);
                if (contact()) {
                    updatePos();
                }
                break;
            case KeyEvent.VK_F1:
                if (status == MENU)
                    status = GAME;
                break;
            case KeyEvent.VK_F2:
                if (status == MENU)
                    status = CREDIT;
                break;
            case KeyEvent.VK_F3:
                if (status == MENU)
                    status = INFO;
                break;
            default:
                break;
        }
    }

    @Override
    public void keyPressed(KeyEvent e) {}

    @Override
    public void keyTyped(KeyEvent e) {}
}
