package pong.network;

import pong.gui.Pong;
import pong.item.Ball;
import pong.item.Bonus;
import pong.item.PongItem;
import pong.item.Racket;
import pong.util.Globals;

import java.io.*;
import java.net.InetSocketAddress;
import java.net.ServerSocket;
import java.net.Socket;
import java.nio.channels.ServerSocketChannel;
import java.util.ArrayList;
import java.util.Arrays;

/**
 * Created by Jimmy on 13/11/2015.
 */

public class Player {
    private int _numPlayer = 1;
    private int _port = 7777;
    private ArrayList<SocketPlayer> _tabSocket = new ArrayList<>();
    private ServerSocketChannel _serverChannel;
    private Pong _pong;
    private boolean _firstTime = true;
    private boolean _connectionPlayer = true;

    /* ================= *
     * == Constructor == *
     * ================= */

    public Player(Pong pong) {
        this._pong = pong;
    }

    /* ===================== *
     * == Getter & Setter == *
     * ===================== */

    public ServerSocketChannel getServerChannel() {
        return _serverChannel;
    }

    public Pong getPong() {
        return _pong;
    }

    public int getPort() {
        return this._port;
    }

    public void endConnectionPlayer() {
        this._connectionPlayer = false;
    }

    /* ====================================== *
     * == Fonctions de creation du serveur == *
     * ====================================== */

    /**
     * Creer le ServerSocketChannel
     * @throws IOException
     */
    public void createServer() throws IOException {
        InetSocketAddress address = new InetSocketAddress(searchPort());
        this._serverChannel = ServerSocketChannel.open();
        this._serverChannel.socket().bind(address); // acquisition de l'adresse sur laquelle ecouter
        this._serverChannel.configureBlocking(false); // non-bloquant
    }

    /**
     * Cherche un port disponible (a partir de _port)
     * @return le port disponible
     */
    public int searchPort() {
        ServerSocket testServeur;
        try {
            testServeur = new ServerSocket(_port);
        } catch(Exception ignored) {
            _port++;
            return searchPort();
        }

        try {
            testServeur.close();
        } catch (IOException ignored) { }

        return _port;
    }



    /* ====================================================== *
     * == Fonctions de connexion et d'accepte de connexion == *
     * ====================================================== */

    /**
     * Effectue la connection du cote serveur :<br>
     *   - recupere le port du serveur de l'autre client<br>
     *   - si c'est la 1ere fois que le client se connecte, on envoie toutes les sockets du tabSocket du player<br>
     *   - stocke la socket passee en parametre, ainsi que le port recu, dans le tabSocket du player<br>
     * @param socket {Socket}
     * @throws IOException
     */
    public void connectionAccept(Socket socket) throws IOException {
        InputStream is = socket.getInputStream();
        BufferedReader br = new BufferedReader(new InputStreamReader(is, "utf-8"));
        String strReceived = br.readLine();

        sendConnectionAccept(socket, strReceived);

        updateConnectionAccept(socket, strReceived);
    }

    /**
     * Met a jour le pong
     * @param socket {Socket} de connexion
     * @param strReceived {String} message recu
     * @throws IOException
     */
    public void updateConnectionAccept(Socket socket, String strReceived) throws IOException {
        String[] protocol =  strReceived.split(":");

        if (protocol[0].compareTo("debut") != 0 &&
                protocol[protocol.length - 1].compareTo("fin") != 0)
            return;

        int port = Integer.parseInt(protocol[1]);

        // On verifie que c'est la 1ere connection
        if (!protocol[2].equals("true")) {
            // On recupere la raquette de l'autre joueur
            Globals.nbPlayer += 1;

            updateTabPongItem(protocol[3]);
        }

        // Ajoute la socketPlayer
        this._tabSocket.add(new SocketPlayer(socket, port, Globals.nbPlayer));
    }

    /**
     * Envoie des informations au joueurs qui s'est connecte
     * @param socket {Socket} de connexion
     * @param strReceived {String} message recu
     * @throws IOException
     */
    public void sendConnectionAccept(Socket socket, String strReceived) throws IOException {
        OutputStream os = socket.getOutputStream();
        PrintStream ps = new PrintStream(os, false, "utf-8");
        String[] protocol = strReceived.split(":");

        String str = strConnectionAccept(protocol[2]);
        ps.println(str);
        ps.flush();
    }

    /**
     * Effectue la connection du cote client :<br>
     *   - on envoie le port de notre serveur<br>
     *   - si c'est la 1ere fois que l'on se connecte, on recoit toutes les sockets du tabSocket (par le biais de la socket) <br>
     *   - stocke la socket passee en parametre, ainsi que le port recu, dans le tabSocket du player<br>
     * @param socket {Socket}
     * @throws IOException
     */
    public void connection(Socket socket) throws IOException {
        sendConnection(socket);
        updateConnection(socket);
    }

    /**
     * Affiche les elements relatifs a la gestion du pong (reseau inclus)
     * Cette fonction permet de voir l'etat d'un pong, et permet donc de verifier si les donnees ont bien ete echange
     * @param socket {Socket} de connexion
     */
    public void displayDataPong(Socket socket) {
        System.out.println();
        System.out.println("--- debut ---");
        System.out.println("connection : " + socket.getInetAddress()  + " " + socket.getPort());
        System.out.println("tabSocket : ");
        for (SocketPlayer sp : this._tabSocket) {
            System.out.println("   " + sp.getsocket().getInetAddress() + " " + sp.getsocket().getPort() + " " +
                    sp.getPort() + " " + sp.getNumPlayer());
        }
        System.out.println("tabPongItem : ");
        for (PongItem pongItem : this._pong.getTabPongItem()) {
            System.out.println("   " + pongItem.getClass().getSimpleName() + " " + pongItem.getNum() + " " +
                    pongItem.getPosX() + " " + pongItem.getPosY() + " " + pongItem.getSpeedX() + " " + pongItem.getSpeedY());
        }
        System.out.println("--- fin ---");
        System.out.println();
    }


    public void sendConnection(Socket socket) throws IOException {
        OutputStream os = socket.getOutputStream();
        PrintStream ps = new PrintStream(os, false, "utf-8");

        // Envoie le message de connection
        String str = strConnection();
        ps.println(str);
        ps.flush();
    }


    public void updateConnection(Socket socket) throws IOException {
        InputStream is = socket.getInputStream();
        BufferedReader br = new BufferedReader(new InputStreamReader(is, "utf-8"));

        String strReceived = br.readLine();

        String[] protocol = strReceived.split(":");

        // Verification du protocol
        if (protocol[0].compareTo("debut") != 0 &&
                protocol[protocol.length - 1].compareTo("fin") != 0)
            return;

        // Ajoute la socketPlayer
        this._tabSocket.add(new SocketPlayer(socket, socket.getPort(), Integer.parseInt(protocol[1])));

        if(this._firstTime) {
            this._firstTime = false;

            Globals.NB_PLAYER_MAX = Integer.parseInt(protocol[2]);
            // Modifie la raquette
            updateRacketPlayer(protocol[3]);

            // On update la position des pongs items et on ajoute les nouveaux pongItem
            updateTabPongItem(protocol[4]);

            // Ajoute les connections des autres joueurs
            updateTabSocket(protocol[5]);
        } else {
            // On recupere la raquette de l'autre joueur
            addNewPongItem(protocol[2]);
        }
    }


    /* =============================================== *
     * == Fonctions creant les chaines de caractere == *
     * ==  qui serviront a envoyer des informations == *
     * =============================================== */

    /**
     * Creer le message que l'on va envoye au client, il contient : <br>
     *     - le numero du joueur<br>
     *     - la racket du client (avec numero, position et speed)<br>
     *     - tous les pongItems (leur classe, leur numero, leur position)<br>
     *     - toutes les sockets de tabSocket du player
     * @return le message
     * @throws IOException
     */
    public String strConnectionAccept(String strFirstTime) throws IOException {
        if (strFirstTime.equals("true"))
            return strProtocol(
                    String.valueOf(this._numPlayer),
                    String.valueOf(Globals.NB_PLAYER_MAX),
                    strPlayer(),
                    strTabPongItem(),
                    strSockets());
        return strProtocol(
                String.valueOf(this._numPlayer),
                strPongItem(this._pong.getPongItem(0)));
    }


    /**
     * Convertit le message en parametre pour qu'il soit conforme au protocol definit
     * @param messages {liste de String}
     * @return message
     */
    public String strProtocol (String... messages) {
        StringBuilder str = new StringBuilder();
        str.append("debut:");
        for (String msg: messages)
            str.append(msg).append(":");
        str.append("fin");
        return str.toString();
    }


    /**
     * Creer le message contenant les caracteristiques de la raquette du player
     * @return le message
     */
    public String strPlayer() {
        Globals.nbPlayer += 1;
        Racket racket = new Racket(Globals.nbPlayer);
        this._pong.getTabPongItem().add(racket);
        return strPongItem(racket);
    }

    /**
     * Creer le message contenant les caracteristiques de tous les pongItems du tabPongItem du player
     * @return le message
     */
    public String strTabPongItem() {
        StringBuilder str = new StringBuilder();
        if (!this._connectionPlayer &&
                this._pong.allScore() % Globals.nbPlayer == 0 &&
                this._pong.getLoser() == this._numPlayer)
            str.append(strBonus());

        for (PongItem pongItem : this._pong.getTabPongItem()) {
            if (pongItem.getClass().getSimpleName().equals("Bonus"))
                continue;

            // Si ce n'est pas notre racket
            if (pongItem.getClass().getSimpleName().equals("Racket") &&
                    pongItem.getNum() != this._numPlayer)
                continue;

            // Si c'est la balle qui a perdu
            if (pongItem.getClass().getSimpleName().equals("Ball") &&
                    this._pong.getNumBallLost() == pongItem.getNum()) {
                if (this._pong.getLoser() == this._numPlayer) {
                    str.append(strPongItem(pongItem)).append(";");
                }
                continue;
            }

            // Si c'est notre raquette, ou que nous somme le maitre du pongItem, ou que c'est la connection
            if (pongItem.getClass().getSimpleName().equals("Racket") ||
                    isMasterPongItem(this._numPlayer, pongItem) ||
                    this._connectionPlayer)
                str.append(strPongItem(pongItem)).append(";");
            // Si c'est pas la connection, que le score est assez eleve, et que c'est nous qui perdons
        }
        return str.toString();
    }


    public String strBonus(){
        boolean createBonus = true;
        for (PongItem pongItem : this._pong.getTabPongItem()){
            if (pongItem instanceof Bonus)
                createBonus = false;
        }
        if (createBonus){
            this._pong.createBonus();
        }

        StringBuilder str = new StringBuilder();
        for (PongItem pongItem : this._pong.getTabPongItem()) {
            if (pongItem instanceof Bonus) {
                if (!createBonus)
                    ((Bonus) pongItem).changeEffect();
                str.append(strPongItem(pongItem)).append(";");
                return str.toString();
            }
        }
        return str.toString();
    }


    /**
     * Creer une chaine de caractere contenant les informations du pongItem passees en parametre
     * @param pongItem {PongItem}
     * @return la chaine de caractere
     */
    public String strPongItem(PongItem pongItem) {
        return pongItem.getClass().getSimpleName() + " " +
                pongItem.getNum() + " " +
                pongItem.getPosX() + " " +
                pongItem.getPosY() + " " +
                pongItem.getSpeedX() + " " +
                pongItem.getSpeedY();
    }

    /**
     * Creer le message contenant les sockets du tabSocket du player
     * @return le message
     */
    public String strSockets() {
        StringBuilder str = new StringBuilder();
        for (SocketPlayer socketPlayer : this._tabSocket) {
            str.append(socketPlayer.getsocket().getInetAddress()).append(" ");
            str.append(socketPlayer.getPort()).append(";");
        }
        return str.toString();
    }


    /**
     * Renvoie sous forme de string le port du serveur du player
     * @return le port
     * @throws IOException
     */
    public String strPortServer() throws IOException {
        String adressServer = this._serverChannel.getLocalAddress().toString();
        String[] portServer = adressServer.split(":");
        return portServer[portServer.length - 1];
    }

    /**
     * Creer le message que l'on va envoye au serveur, il contient : <br>
     *     - le port de son serveur<br>
     *     - si c'est la 1ere fois que l'on se connecte a un serveur
     *     - la raquette du player<br>
     * @return le message
     * @throws IOException
     */
    public String strConnection() throws IOException {
        StringBuilder str = new StringBuilder();
        str.append(strPortServer()).append(":");
        str.append(this._firstTime);
        if (!this._firstTime) {
            str.append(":").append(strPongItem(this._pong.getPongItem(0)));
        }
        return strProtocol(str.toString());
    }


    public String strPong() {
        return strProtocol(strPointPlayer(), strTabPongItem());
    }

    public String strPointPlayer() {
        return String.valueOf(this._numPlayer) + " " +
                this._pong.getPointPlayer(this._numPlayer);
    }


    /* ============================================ *
     * == Fonctions permettant de mettre a jour  == *
     * ==     les elements relatifs aux pong     == *
     * ============================================ */

    /**
     * Met a jour la raquette du player
     * @param str {String} contient les informations sur la raquette du player
     */
    public void updateRacketPlayer(String str) {
        String[] split = str.split(";");
        String[] split1 = split[0].split(" ");
        Globals.nbPlayer = Integer.parseInt(split1[1]);
        this._numPlayer = Integer.parseInt(split1[1]);
        this._pong.setPongItem(0, new Racket(this._numPlayer,
                Integer.parseInt(split1[2]),
                Integer.parseInt(split1[3])));
    }


    public void addNewPongItem(String str) {
        ArrayList<PongItem> tabPongItem = this._pong.getTabPongItem();
        String[] split = str.split(" ");
        switch (split[0]) {
            case "Racket":
                tabPongItem.add(new Racket(Integer.parseInt(split[1]),
                        Integer.parseInt(split[2]),
                        Integer.parseInt(split[3])));
                break;
            case "Ball":
                tabPongItem.add(new Ball(Integer.parseInt(split[1]),
                        Integer.parseInt(split[2]),
                        Integer.parseInt(split[3])));
                break;
            case "Bonus":
                tabPongItem.add(new Bonus(Integer.parseInt(split[1]),
                        Integer.parseInt(split[2]),
                        Integer.parseInt(split[3])));
                break;
            default:
                break;
        }
    }

    /**
     * Met a jour le tabPongItem du player a partir de la string str
     * @param str {String}
     */
    public void updateTabPongItem(String str) {
        ArrayList<PongItem> tabPongItem = this._pong.getTabPongItem();
        String[] tabStrPongItem = str.split(";");
        String[] split;
        boolean addPongItem;

        for (String strPongItem : tabStrPongItem) {
            split = strPongItem.split(" ");
            addPongItem = true;
            for (PongItem pongItem : tabPongItem) {
                if (split[0].equals(pongItem.getClass().getSimpleName()) &&
                        (Integer.parseInt(split[1]) == pongItem.getNum() || split[0].equals("Bonus"))) {
                    if (split[0].equals("Bonus"))
                        pongItem.setNum(Integer.parseInt(split[1]));
                    addPongItem = false;
                    updatePongItem(pongItem, split);
                    break;
                }
            }
            if (addPongItem) {
                addNewPongItem(strPongItem);
            }
        }
    }

    /**
     * Met a jour le pongItem passe en parametre et verifie si il y a eu de la triche
     * @param pongItem {PongItem} que l'on va mettre a jour
     * @param str {String} contenant les informations recues sur le pongItem
     */
    public void updatePongItem(PongItem pongItem, String[] str){
        int x = Integer.parseInt(str[2]);
        int y = Integer.parseInt(str[3]);
        int speedX = Integer.parseInt(str[4]);
        int speedY = Integer.parseInt(str[5]);

        if (Cheating(pongItem, x, y, speedX, speedY))
            System.out.println("Player enemy cheat !");

        pongItem.setPosition(x, y);
        pongItem.setSpeed(speedX, speedY);
    }

    /**
     * verifie si les coordonnees recues concordent bien avec les positions du pongItem
     * @param pongItem {PongItem}
     * @param x {int}
     * @param y {int}
     * @return si le joueur triche
     */
    public boolean Cheating(PongItem pongItem, int x, int y, int speedX, int speedY) {
        boolean cheat = false;

        // Si c'est une raquette, on accepte de faire confiance a l'advesaire
        if (pongItem.getClass().getSimpleName().equals("Racket")){
            return false;
        }

        // Verifie que la vitesse envoye par le joueur n'est pas exagere (ne depasse pas la vitesse max)
        if (Math.abs(speedX) > Globals.BALL_SPEED + Globals.RANGE_BALL_SPEED ||
                Math.abs(speedY) > Globals.BALL_SPEED + Globals.RANGE_BALL_SPEED){
            System.out.println("cheat vitesse");
            cheat = true;
        }

        // Verifie que la position envoyee par le joueur est bien en lien avec la vitesse envoyee
        else if (x - pongItem.getPosX() > Math.abs(speedX) ||
                y - pongItem.getPosY() > Math.abs(speedY)) {
            System.out.println("cheat position");
            cheat = true;
        }
        return cheat;
    }

    /**
     * Met a jour le tabSocket du player en ajoutant les sockets contenues dans le String str
     * @param str {String} contient les sockets recues
     * @throws IOException
     */
    public void updateTabSocket(String str) throws IOException {
        String[] split = str.split(";");
        String[] split1;
        if (!str.isEmpty()) {
            for (int i = 0; i < split.length; i++) {
                split1 = split[i].split(" ");
                int port = Integer.parseInt(split1[1]);
                split1 = split1[0].split("/");
                Socket socket = new Socket(split1[1], port);
                socket.setTcpNoDelay(true);
                connection(socket);
            }
        }
    }


    public void updatePong(String str) {
        String[] strSplit = str.split(":");
        updateTabPoint(strSplit[0]);
        updateTabPongItem(strSplit[1]);
    }


    public void updateTabPoint(String str) {
        String[] strSplit = str.split(" ");
        this._pong.setPointPlayer(Integer.parseInt(strSplit[0]), Integer.parseInt(strSplit[1]));
    }


    /**
     * Renvoie true si le numPlayer est le meme que le maitre du pongItem
     * @param numPlayer {int}
     * @param pongItem {PongItem}
     * @return un boolean
     */
    public boolean isMasterPongItem(int numPlayer, PongItem pongItem) {
        return numPlayer == masterPongItem(pongItem);
    }


    /**
     * Retourne true si le player est le "maitre" du pongItem (ce qui lui donne le droit d'envoyer les coordonnees du pongItem)
     * @param pongItem {PongItem}
     * @return le numero du player qui est maitre du pongItem
     */
    public int masterPongItem(PongItem pongItem) {
        int distance[] = {
                pongItem.getPosX(),
                Globals.SIZE_PONG - pongItem.getPosX(),
                Globals.SIZE_PONG - pongItem.getPosY(),
                pongItem.getPosY()};

        int distanceSort[] = distance.clone();
        Arrays.sort(distanceSort);

        int numPlayer = 0;
        for (int i = 0; i < distanceSort.length; i++) {
            for (int j = 0; j < distance.length; j++) {
                if (distanceSort[i] == distance[j]) {
                    numPlayer = j + 1;
                    break;
                }
            }
            if (this._pong.isPlaying(numPlayer)) {
                return numPlayer;
            }
        }
        return numPlayer;
    }


    /**
     * Retourne le String passe en parametre sans l'encapsulation du protocol (sans "debut:" et sans ":fin")
     * @param str {String}
     * @return le message
     */
    public String convertProtocol(String str) {
        String[] protocol = str.split(":");
        if (protocol[0].compareTo("debut") != 0 &&
                protocol[protocol.length -1].compareTo("fin") != 0) {
            return "";
        }
        return str.substring(6, str.length() - 4); // On eleve "debut:" et ":fin"
    }


    /**
     * Traite les informations recues des differents pongItems et les met a jour
     */
    public void receiveDataPong() {
        for (int i = 0; i < this._tabSocket.size(); i++) {
            BufferedReader br = this._tabSocket.get(i).getBufferedReader();
            try {
                String str = br.readLine();
                updatePong(convertProtocol(str));
            } catch (IOException e) {
                removePlayer(i);
            }

        }
        _pong.initLoser();
        _pong.initBallLost();
    }

    /**
     * Envoie les informations sur les differents pongItems
     */
    public void sendDataPong() {
        for (SocketPlayer socketPlayer : this._tabSocket) {
            PrintStream ps = socketPlayer.getPrintStream();
            ps.println(strPong());
            ps.flush();
        }
    }

    /**
     * supprime le joueur lie a la socket (indice de la socket passe en parametre)
     * @param indice {int} indice de la socket
     */
    public void removePlayer(int indice) {
        for (int i = 0; i < this._pong.getTabPongItem().size(); i++) {
            if(this._pong.getPongItem(i).getClass().getSimpleName().equals("Racket") &&
                    this._pong.getPongItem(i).getNum() == this._tabSocket.get(indice).getNumPlayer()) {
                this._pong.removePongItem(i);
                break;
            }
        }
        this._tabSocket.remove(indice);
        Globals.nbPlayer -= 1;
    }
}
