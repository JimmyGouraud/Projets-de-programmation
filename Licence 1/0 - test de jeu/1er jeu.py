#Importation des bibliothèques nécessaires
import sys, pygame
from pygame.locals import *


pygame.init()

#Création de la fenêtre
fenetre = pygame.display.set_mode((640, 480)) #peut-etre pygame.RESIZABLE

#Chargement et collage du fond
fond = pygame.image.load("background.jpg").convert()
fenetre.blit(fond, (0,0))

#Chargement et collage du personnage
perso = pygame.image.load("perso.png").convert_alpha()
position_perso = perso.get_rect()
fenetre.blit(perso, (200,300))

#Rafraîchissement de l'écran
pygame.display.flip()

#Le premier argument défini le retard en milliseconde avant le lancement de
#la répétition et le deuxième défini la vitesse de répétition en milliseconde
pygame.key.set_repeat(1, 20)

#Boucle infinie
while 1:
    for event in pygame.event.get(): 
        if event.type == pygame.QUIT:
            pygame.quit()
            sys.exit()
        if event.type == KEYDOWN:
            if event.key == K_SPACE:
                print("Espace")
            if event.key == K_RIGHT:
                position_perso = position_perso.move(3,0)
            if event.key == K_LEFT:
                position_perso = position_perso.move(-3,0)
            if event.key == K_UP:
                position_perso = position_perso.move(0,-3)
            if event.key == K_DOWN:
                position_perso = position_perso.move(0,3)
    #Re-collage
    fenetre.blit(fond, (0,0))	
    fenetre.blit(perso, position_perso)
    #Rafraichissement
    pygame.display.flip()

