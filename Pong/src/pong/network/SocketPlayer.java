package pong.network;

import java.io.*;
import java.net.Socket;

/**
 * Created by Jimmy on 20/11/2015.
 */
public class SocketPlayer {
    private int _numPlayer = 0;
    private int _portServer;
    private Socket _socket;
    private PrintStream _printStream;
    private BufferedReader _bufferedReader;

    SocketPlayer(Socket socket, int portServer, int numPlayer) throws IOException {
        _numPlayer = numPlayer;
        _socket = socket;
        _portServer = portServer;

        _socket.setTcpNoDelay(true);
        OutputStream os = _socket.getOutputStream();
        InputStream is = _socket.getInputStream();
        _printStream = new PrintStream(os, false, "utf-8");
        _bufferedReader = new BufferedReader(new InputStreamReader(is, "utf-8"));
    }

    public int getNumPlayer(){
        return _numPlayer;
    }
    public int getPort() {
        return _portServer;
    }
    public Socket getsocket() {
        return _socket;
    }
    public BufferedReader getBufferedReader() {
        return _bufferedReader;
    }
    public PrintStream getPrintStream() {
        return _printStream;
    }
}
