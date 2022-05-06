"""
Jeu Donkey Kong Labyrinthe
Jeu dans lequel on doit déplacer DK jusqu'aux bananes à travers un labyrinthe.

Script Python
Fichier : dklabyrinthe.py, classes.py, constantes.py, n1, n2 + images
"""

import pygame, sys
from pygame.locals import *
pygame.init()

class perso:
    def __init__(self):
        self.playerDroite = pygame.image.load('dk_gauche.png').convert_alpha()
        self.playerGauche = pygame.image.load('dk_droite.png').convert_alpha()
        self.playerHaut = pygame.image.load('dk_haut.png').convert_alpha()
        self.playerBas = pygame.image.load('dk_bas.png').convert_alpha()
        self.direct = self.playerBas #vue du personnage au départ
        self.rect = self.direct.get_rect()
    def update(self):
        self.position = (self.X, self.Y)
        self.rect = pygame.Rect(self.position,(30,30))
    def bouge(self, direction):
            if direction == 'droite':                
                self.direct = self.playerDroite
                self.X += 10
            if direction == 'gauche':
                self.direct = self.playerGauche
                self.X -= 10
            if direction == 'haut':    
                self.direct = self.playerHaut
                self.Y += 10
            if direction == 'bas':
                self.direct = self.playerBas
                self.Y -= 10

fenetre = pygame.display.set_mode((450,450))
icone = pygame.image.load("accueil DK.png")
fenetre.blit(icone, (0,0))
pygame.display.set_icon(icone) #Fond de la fenêtre Pygame
pygame.display.set_caption("Accueil DK") #Titre de la fenêtre Pygame
pygame.display.flip() #Rafraîchissement de l'écran

#Niveau/Menu
niveau = 0
menu = 0
niveau1 = 1
niveau2 = 2

#personnage et position
perso = pygame.image.load("dk_bas.png")
fenetre.blit(perso, (0,0))
position_perso = perso.get_rect()
#Le premier argument défini le retard en milliseconde avant le lancement de
#la répétition et le deuxième défini la vitesse de répétition en milliseconde
pygame.key.set_repeat(1, 20)

#Boucle infinie
while 1:
    #Limitation de vitesse de la boucle
    #30 frames par secondes suffisent
    pygame.time.Clock().tick(30)
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
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
        #Niveau 1 et niveau 2 du Jeu
        #Niveau 1
        if niveau == niveau1:
            #Décor du niveau 1
            fenetre = pygame.display.set_mode((450,500))
            icone = pygame.image.load("fond.jpg")
            fenetre.blit(icone, (0,0))
            with open("niveau1.txt", "r") as fichier:
                l = 0
                for ligne in fichier:
                    c = 0 
                    for sprite in ligne :
                        if sprite == "D":
                            depart = pygame.image.load("depart.png")
                            fenetre.blit(depart, (c,l))
                        if sprite == "A":
                            arrivee = pygame.image.load("arrivee.png")
                            fenetre.blit(arrivee, (c,l))
                        if sprite == "M":
                            mur = pygame.image.load("mur.png")
                            fenetre.blit(mur, (c,l))
                            mur_position = pygame.Rect((c,l),(30,30))
                        c = c + 30
                    l = l + 30
            pygame.display.flip()
        #Niveau 2
        if niveau == niveau2:
            #Décor du niveau 2
            fenetre = pygame.display.set_mode((450,500))
            icone = pygame.image.load("fond.jpg")
            fenetre.blit(icone, (0,0)) 
            with open("niveau2.txt", "r") as fichier:
                l = 0
                for ligne in fichier:
                    c = 0
                    for sprite in ligne :
                        if sprite == "D":
                            depart = pygame.image.load("depart.png")
                            fenetre.blit(depart, (c,l))
                            position_depart = depart.get_rect()
                        if sprite == "A":
                            arrivee = pygame.image.load("arrivee.png")
                            fenetre.blit(arrivee, (c,l))
                            position_arrivee = arrivee.get_rect()
                        if sprite == "M":
                            mur = pygame.image.load("mur.png")
                            fenetre.blit(mur, (c,l))
                            position_mur = mur.get_rect()
                        c = c + 30
                    l = l + 30
            #Déplacement du personnage
            if event.type == KEYDOWN:
                if event.key == K_DOWN:
                    perso = pygame.image.load("dk_bas.png")
                    with open("niveau2.txt", "r") as fichier:    
                        l = 0
                        for ligne in fichier:
                            c = 0
                            for sprite in ligne :
                                if sprite == "M":
                                    mur = pygame.image.load("mur.png")
                                    fenetre.blit(mur, (c,l))
                                    position_mur = mur.get_rect()
                                if (position_perso.move(0,30)) != position_mur:
                                    position_perso = position_perso.move(0,30)
                                c = c + 30
                            l = l + 30
                if event.key == K_UP:
                    perso = pygame.image.load("dk_haut.png")
                    position_perso = position_perso.move(0,-30)
                if event.key == K_RIGHT:
                    perso = pygame.image.load("dk_droite.png")
                    position_perso = position_perso.move(30,0)
                if event.key == K_LEFT:
                    perso = pygame.image.load("dk_gauche.png")
                    position_perso = position_perso.move(-30,0)
            fenetre.blit(perso, position_perso)
            pygame.display.flip()

