package pong.gui;

import pong.network.Player;
import pong.util.Globals;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.IOException;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.Socket;
import java.net.SocketException;
import java.nio.channels.SocketChannel;
import java.util.Enumeration;

/**
 * Created by Jimmy on 06/12/2015.
 */
public class Menu extends JFrame implements ActionListener{
    private Player _player;
    public boolean allPlayerConnected = false;

    private JPanel container = new JPanel();
    private JLabel title = new JLabel("Jeu Pong");
    private JLabel author = new JLabel("Creer par Yordan Kirov & Jimmy Gouraud");
    private JButton buttonCreatePong = new JButton("Creer un Pong");
    private JButton buttonRejoinPong = new JButton("Rejoindre un pong");
    private JButton buttonLancePong = new JButton("Lancer le pong");
    private JButton buttonJoinPong = new JButton("Lancer le pong");
    private JTextField nbPlayer = new JTextField();
    private JTextField ipAddress = new JTextField();
    private JTextField port = new JTextField();

    public Menu(Player player) {
        this._player = player;

        this.setTitle("Menu Pong");
        this.setSize(Globals.SIZE_MENU_X, Globals.SIZE_MENU_Y);
        this.setLocationRelativeTo(null);
        this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        this.setResizable(false);
        container.setBackground(Color.ORANGE);
    }

    public void menuMain(){
        title.setFont(Globals.fTitle);
        title.setBounds(130, 0, 300, 70);
        container.add(title);

        author.setFont(Globals.fMenu);
        author.setBounds(40, 70, 500, 50);
        container.add(author);

        buttonCreatePong.setFont(Globals.fMenu);
        buttonCreatePong.setBounds(Globals.SIZE_MENU_X / 2 - 120, Globals.SIZE_MENU_Y / 3 + 10, 220, 50);
        container.add(buttonCreatePong);
        buttonCreatePong.addActionListener(this);
        buttonRejoinPong.setFont(Globals.fMenu);
        buttonRejoinPong.setBounds(Globals.SIZE_MENU_X/2 - 120, Globals.SIZE_MENU_Y/3 + 100, 220, 50);
        container.add(buttonRejoinPong);
        buttonRejoinPong.addActionListener(this);


        container.setLayout(null);

        this.getContentPane().add(container);
        this.setVisible(true);
    }


    public void menuCreatePong(){
        container.removeAll();
        JLabel jLabel = new JLabel("Nombre de joueur : ");
        jLabel.setFont(Globals.fMenu);
        jLabel.setBounds(140, 100, 200, 40);
        container.add(jLabel);

        nbPlayer.setFont(Globals.fMenu);
        nbPlayer.setBounds(330,105,40,30);
        container.add(nbPlayer);

        buttonLancePong.setFont(Globals.fMenu);
        buttonLancePong.setBounds(100,200,300,50);
        container.add(buttonLancePong);
        buttonLancePong.addActionListener(this);
    }


    public void menuJoinPong(){
        container.removeAll();
        JLabel jIP = new JLabel("IP adresse : ");
        jIP.setFont(Globals.fMenu);
        jIP.setBounds(100, 100, 200, 40);
        container.add(jIP);

        ipAddress.setFont(Globals.fMenu);
        ipAddress.setBounds(220,105,200,30);
        container.add(ipAddress);

        JLabel jPort = new JLabel("Port : ");
        jPort.setFont(Globals.fMenu);
        jPort.setBounds(150, 140, 140, 40);
        container.add(jPort);

        port.setFont(Globals.fMenu);
        port.setBounds(215,145,100,30);
        container.add(port);

        buttonJoinPong.setFont(Globals.fMenu);
        buttonJoinPong.setBounds(100,200,300,50);
        container.add(buttonJoinPong);
        buttonJoinPong.addActionListener(this);
    }

    public void checkIpPort() {
        Socket socket;
        try {
            socket = new Socket(ipAddress.getText(), Integer.parseInt(port.getText()));
            socket.setTcpNoDelay(true);
            _player.connection(socket);
        } catch (IOException ignored) { }

        displayWaitPlayer();
    }

    public void checkNbPlayer(){
        try {
            if (nbPlayer.getText().length() == 1) {
                int value = Integer.parseInt(nbPlayer.getText());
                if (value > 0 && value < 5) {
                    Globals.NB_PLAYER_MAX = value;
                    displayWaitPlayer();
                }
            }
        } catch (NumberFormatException ignored) {}
    }

    public void waitPlayer(){
        SocketChannel socketChannel;
        while (Globals.nbPlayer != Globals.NB_PLAYER_MAX) {
            try {
                if ((socketChannel = _player.getServerChannel().accept()) != null) {
                    Socket socket = socketChannel.socket();
                    socket.setTcpNoDelay(true);
                    _player.connectionAccept(socket);
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        allPlayerConnected = true;
    }


    public void displayWaitPlayer(){
        container.removeAll();
        JLabel jLabel = new JLabel("En attente des joueurs ...\n");
        jLabel.setFont(Globals.fMenu);
        jLabel.setBounds(140, 130, 250, 40);
        container.add(jLabel);
        JLabel ip = new JLabel("votre adresse IP : " + adressIP());
        ip.setFont(Globals.fMenu);
        ip.setBounds(119, 190, 350, 40);
        container.add(ip);
        JLabel port = new JLabel("votre port : " + _player.getPort());
        port.setFont(Globals.fMenu);
        port.setBounds(180, 220, 250, 40);
        container.add(port);
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        if (e.getSource() == buttonCreatePong){
            menuCreatePong();
        }

        if (e.getSource() == buttonRejoinPong){
            menuJoinPong();
        }

        if (e.getSource() == buttonLancePong){
            checkNbPlayer();
        }

        if (e.getSource() == buttonJoinPong){
            checkIpPort();
        }
        repaint();
    }

    public String adressIP() {
        Enumeration<NetworkInterface> interfaces = null;
        try {
            interfaces = NetworkInterface.getNetworkInterfaces();
        } catch (SocketException e) {
            e.printStackTrace();
        }

        String adress = "";
        assert interfaces != null;
        while (interfaces.hasMoreElements()) {
            NetworkInterface interfaceN = interfaces.nextElement();
            Enumeration<InetAddress> ienum = interfaceN.getInetAddresses();
            while (ienum.hasMoreElements()) {
                InetAddress ia = ienum.nextElement();
                adress = ia.getHostAddress();

                if (adress.length() < 16) {
                    if (!(adress.startsWith("127") || adress.startsWith("0"))) {
                        return adress;
                    }
                }
            }
        }
        return adress;
    }

    /**
     * Displays the Window using the defined margins, and call the
     * {@link Pong#animate()} method of the {@link Pong} every 100ms
     */
    public void displayOnscreen() {
        menuMain();
        waitPlayer();
    }
}

