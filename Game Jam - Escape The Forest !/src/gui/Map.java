package gui;

import Item.ElemDecor;
import sun.java2d.Surface;
import util.Globals;

import javax.swing.*;
import java.io.*;
import java.awt.*;
import java.io.BufferedReader;
import java.io.FileReader;
import java.util.ArrayList;
import java.io.IOException;
import java.util.Scanner;

/**
 * Created by ugo on 14/11/15.
 */
public class Map{

    protected int nbtilesX,nbtilesY;
    protected int indiceX = 0, indiceY = 0;
    protected ArrayList<ElemDecor> elemsDecor = new ArrayList<>();
    int _numImage = 0;
    protected int[][] tabLevel;
    protected Rectangle[][] tabSurface;

    protected int xscroll, yscroll;
    protected int hauteur_fen, largeur_fen;

    public ArrayList<ElemDecor> getElemsDecor() {
        return elemsDecor;
    }
    public void setElemsDecor(ArrayList<ElemDecor> elemsDecor) {
        this.elemsDecor = elemsDecor;
    }

    public ElemDecor getElemDecor(int indice){
        return elemsDecor.get(indice);
    }
    public void setElemDecor(ElemDecor elemDecor, int indice){
        this.elemsDecor.set(indice, elemDecor);
    }

    public Rectangle[][] getTabSurface(){
        return this.tabSurface;
    }

    public Rectangle getSurface(int indiceX, int indiceY){
        return this.tabSurface[indiceX][indiceY];
    }

    public void setTabSurface(int indiceX, int indiceY, Rectangle surface){
        this.tabSurface[indiceX][indiceY] = surface;
    }

    public int getYscroll() {
        return yscroll;
    }

    public int getXscroll() {
        return xscroll;
    }

    public int getHauteur_fen() {
        return hauteur_fen;
    }

    public int getLargeur_fen() {
        return largeur_fen;
    }

    public void setXscroll(int xscroll) {
        this.xscroll = xscroll;
    }

    public void setYscroll(int yscroll) {
        this.yscroll = yscroll;
    }

    public void setHauteur_fen(int hauteur_fen) {
        this.hauteur_fen = hauteur_fen;
    }

    public void setLargeur_fen(int largeur_fen) {
        this.largeur_fen = largeur_fen;
    }

    public Map(){
        try {
            this.read();
        } catch (IOException e) {
            e.printStackTrace();
        }
        this.xscroll = 0;
        this.yscroll = Globals.SIZE_LEVEL_Y ;
        this.largeur_fen = 12;
        this.hauteur_fen = 8;
        this.tabSurface = new Rectangle[this.nbtilesX][this.nbtilesY];
        for(int k = 0; k < this.nbtilesY; k++){
            for(int j = 0; j < this.nbtilesX; j++){
                this.setTabSurface(j, k, new Rectangle(j * 100, k * 100, 100, 100));
            }
        }
        try {
            for (int i = 0; i < Globals.tileSetS.length; i++) {
                ElemDecor elemDecor = new ElemDecor(Toolkit.getDefaultToolkit().createImage(
                        ClassLoader.getSystemResource(Globals.tileSetS[i])));
                this.getElemsDecor().add(elemDecor);
                if(i == 2 || i == 3 || i == 4 || i == 5 || i == 6 || i == 7 || i > 10){
                    elemDecor.setMur(1);
                }
            }
        } catch(StackOverflowError e){
            e.printStackTrace();
        }
    }

    public int getNumImage(){
        return _numImage;
    }

    public Image getImageIndice(int indice){
        return this.elemsDecor.get(indice).getImage();
    }

    public int getTile(int indiceX, int indiceY){
        return this.tabLevel[indiceX][indiceY];
    }

    public void setTile(int indiceX, int indiceY, int tile){
        this.tabLevel[indiceX][indiceY] = tile;
    }

    public int getNbtilesX(){
        return this.nbtilesX;
    }

    public int getNbtilesY(){
        return this.nbtilesY;
    }

    public void read() throws java.io.IOException{
        Scanner lecteur;
        File fichier = new File(Globals.level);
        lecteur = new Scanner(fichier);
        this.nbtilesX = lecteur.nextInt();
        this.nbtilesY = lecteur.nextInt();
        this.tabLevel = new int[this.nbtilesX][this.nbtilesY];
        while(lecteur.hasNextInt()) {
            setTile(this.indiceX, this.indiceY, lecteur.nextInt());
            this.indiceX = this.indiceX + 1;
            if(this.indiceX >= this.nbtilesX){
                this.indiceY = this.indiceY + 1;
                this.indiceX = 0;
            }
        }
    }

}
