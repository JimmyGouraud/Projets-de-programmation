#-*- coding:Utf-8 -*-
 
import pygame
from pygame.locals import *
 
pygame.init()
 
class perso:
     
    def __init__(self):
         
        self.playerD = pygame.image.load('dk_gauche.png').convert_alpha()
        self.playerG = pygame.image.load('dk_droite.png').convert_alpha()
        self.direct = self.playerD
        self.rect = self.direct.get_rect()
        self.X = 10
        self.Y = 470
     
    def update (self):                      #=== Ajout d'une fonction Update 
         
        self.position = (self.X,self.Y) 
        self.rect = pygame.Rect(self.position, (30,30))      #=== Mise a jour du Rect par rapport a sa nouvel position
 
         
    def bouge (self, direction):
             
            if direction == 'droite':                
                self.direct = self.playerD
                self.X += 10
            if direction == 'gauche':
                self.direct = self.playerG
                self.X -= 10
 
 
screen = pygame.display.set_mode((500,500))
background = pygame.image.load('arrivee.png').convert()
joueur = perso()
 
mur = pygame.image.load('mur.png').convert()
mur_pos = mur.get_rect()
mur_pos = pygame.Rect((200,470) ,(30,30))           #== la je ne comprend pas vraiment le pourquoi du comment mais sans sa , sa ne marche pas
 
loop = True
while loop:
    for event in pygame.event.get():
        if event.type == QUIT:
            loop = False
        if event.type == KEYDOWN:
            if event.key == K_LEFT:
                joueur.update()                         #=== mise a jour du Rect avant de tester la collision
                if joueur.rect.colliderect(mur_pos):
                    print('collide')
                else:
                    joueur.bouge('gauche')
            if event.key == K_RIGHT:
                joueur.update()                         #=== mise a jour du Rect avant de tester la collision
                if joueur.rect.colliderect(mur_pos):
                    print('collide')
                else:
                    joueur.bouge('droite')
                 
                 
    screen.blit(background, (0,0))
    screen.blit(mur, (200,470))            
    screen.blit(joueur.direct , (joueur.X, joueur.Y))
     
    pygame.display.flip()
