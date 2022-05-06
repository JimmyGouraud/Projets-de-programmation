"""
Jeu Donkey Kong Labyrinthe
Jeu dans lequel on doit déplacer DK jusqu'aux bananes à travers un labyrinthe.

Script Python
Fichier : dklabyrinthe.py, classes.py, constantes.py, n1, n2 + images
"""

#Importation des bibliothèques nécessaires
import pygame, sys
from pygame.locals import *
#Initialisation de la bibliothèque Pygame
pygame.init()

#Ouverture de la fenêtre Pygame
fenetre = pygame.display.set_mode((450,450))
#Icone
icone = pygame.image.load("accueil DK.png")
fenetre.blit(icone, (0,0))
#Fond de la fenêtre Pygame
pygame.display.set_icon(icone)
#Titre
pygame.display.set_caption("Jeu de labyrinthe Donkey Kong !")

#Rafraîchissement de l'écran
pygame.display.flip()
#Niveau/Menu
niveau = 0
menu = 0
niveau1 = 1
niveau2 = 2
fin = 3
#personnage et position
perso = pygame.image.load("dk_bas.png")
fenetre.blit(perso, (0,0))
###position_perso = perso.get_rect()
position_perso = pygame.Rect((0,0),(30,30))
#Le premier argument défini le retard en milliseconde avant le lancement de
#la répétition et le deuxième défini la vitesse de répétition en milliseconde
pygame.key.set_repeat(1, 20)
#Initialisation de la position du perso
deplacement_persoX = 0
deplacement_persoY = 0

#Boucle infinie
continuer = 1
while continuer:
    #Limitation de vitesse de la boucle
    #30 frames par secondes suffisent
    pygame.time.Clock().tick(30)
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            pygame.quit()
            sys.exit()
        if event.type == KEYDOWN:
            if event.key == K_ESCAPE:
                pygame.quit()
                sys.exit()
        #MENU du Jeu
        if niveau == menu:
            if event.type == MOUSEBUTTONDOWN:
                if event.button == 1:
                    if 385<event.pos[1]<451:
                        if 110<event.pos[0]<350:
                            niveau = niveau1
                    if 415<event.pos[1]<440:
                        if 110<event.pos[0]<350:
                            niveau = niveau2
            if event.type == KEYDOWN:
                if event.key == K_F1:
                    niveau = 1
                if event.key == K_F2:
                    niveau = 2
            perso = pygame.image.load("dk_bas.png")
            fenetre.blit(perso, (0,0))
            position_perso = pygame.Rect((0,0),(30,30))
            pygame.key.set_repeat(1, 20)
            deplacement_persoX = 0
            deplacement_persoY = 0

        if niveau != 0 :
            #Déplacement du personnage
            if event.type == KEYDOWN:
                if event.key == K_DOWN:
                    perso = pygame.image.load("dk_bas.png")
                    deplacement_persoY += 30
                    if not(deplacement_persoX,deplacement_persoY) in coordonnee_mur:
                        position_perso = position_perso.move(0,30)
                    else:
                        deplacement_persoY -=30
                if event.key == K_UP:
                    perso = pygame.image.load("dk_haut.png")
                    deplacement_persoY -= 30
                    if not (deplacement_persoX,deplacement_persoY) in coordonnee_mur:
                        position_perso = position_perso.move(0,-30)
                    else:
                        deplacement_persoY += 30
                if event.key == K_RIGHT:
                    perso = pygame.image.load("dk_droite.png")
                    deplacement_persoX +=30
                    if not (deplacement_persoX,deplacement_persoY) in coordonnee_mur:
                        position_perso = position_perso.move(30,0)
                    else:
                        deplacement_persoX -=30
                    if (deplacement_persoX,deplacement_persoY) == coordonnee_arrivee:
                        niveau = menu
                        icone = pygame.image.load("accueil DK.png")
                        fenetre.blit(icone, (0,0))
                        pygame.display.set_icon(icone)
                        position_perso = pygame.Rect((-30,-30),(30,30))
                        pygame.display.flip()
                if event.key == K_LEFT:
                    perso = pygame.image.load("dk_gauche.png")
                    deplacement_persoX -= 30
                    if not (deplacement_persoX,deplacement_persoY) in coordonnee_mur:
                        position_perso = position_perso.move(-30,0)
                    else:
                        deplacement_persoX +=30
            fenetre.blit(perso, position_perso)
            pygame.display.flip()

        #Niveau 1 
        if niveau == niveau1:
            fenetre = pygame.display.set_mode((450,450))
            icone = pygame.image.load("fond.jpg")
            fenetre.blit(icone, (0,0))
            with open(("niveau1.txt"), "r") as fichier:
                l = 0
                coordonnee_mur = []
                for ligne in fichier:
                    c = 0
                    for sprite in ligne :
                        if sprite == "D":
                            depart = pygame.image.load("depart.png")
                            fenetre.blit(depart, (c,l))
                            coordonnee_depart = (c,l)
                        if sprite == "A":
                            arrivee = pygame.image.load("arrivee.png")
                            fenetre.blit(arrivee, (c,l))
                            coordonnee_arrivee = (c,l)
                        if sprite == "M":
                            mur = pygame.image.load("mur.png")
                            fenetre.blit(mur, (c,l))
                            coordonnee_mur += [(c,l)]
                        coordonnee_mur += [(c,450)] + [(c,-30)]
                        c += 30
                    coordonnee_mur += [(450,l)] + [(-30,l)]
                    l += 30

        #Niveau 2
        if niveau == niveau2:
            fenetre = pygame.display.set_mode((450,450))
            icone = pygame.image.load("fond.jpg")
            fenetre.blit(icone, (0,0))
            with open("niveau2.txt", "r") as fichier:
                l = 0
                coordonnee_mur = []
                for ligne in fichier:
                    c = 0
                    for sprite in ligne :
                        if sprite == "D":
                            depart = pygame.image.load("depart.png")
                            fenetre.blit(depart, (c,l))
                            coordonnee_depart = (c,l)
                        if sprite == "A":
                            arrivee = pygame.image.load("arrivee.png")
                            fenetre.blit(arrivee, (c,l))
                            coordonnee_arrivee = (c,l)
                        if sprite == "M":
                            mur = pygame.image.load("mur.png")
                            fenetre.blit(mur, (c,l))
                            coordonnee_mur += [(c,l)]
                        coordonnee_mur += [(c,450)] + [(c,-30)]
                        c += 30
                    coordonnee_mur += [(450,l)] + [(-30,l)]
                    l += 30
            
        #Fin du jeu
        if niveau == fin:
            continuer = 0

##fenetre = pygame.display.set_mode((960,540), pygame.RESIZABLE)
##icone = pygame.image.load("crysis 2 - Romain ;).jpg")
##fenetre.blit(icone, (0,0))
##pygame.display.update()
##continuer = 1
##while continuer:
##    pygame.time.Clock().tick(30)
##    for event in pygame.event.get():
##        if event.type == pygame.QUIT:
##            pygame.quit()
##            sys.exit()
##        if event.type == KEYDOWN:
##            if event.key == K_ESCAPE:
##                pygame.quit()
##                sys.exit()
