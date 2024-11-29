# this allows us to use code from
# the open-source pygame library
# throughout this file
import pygame
from constants import *
from player import *

def main():
    pygame.init()
    updatable = pygame.sprite.Group()
    drawable = pygame.sprite.Group()
    Player.containers = (updatable, drawable)
    player = Player(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2)
    clock = pygame.time.Clock()
    dt = 0
    print("Starting asteroids!")
    print(f"Screen width: {SCREEN_WIDTH}")
    print(f"Screen height: {SCREEN_HEIGHT}")
    screen = pygame.display.set_mode((SCREEN_WIDTH, SCREEN_HEIGHT))
    while(True):
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                return

        for i in updatable:
            i.update(dt)
            
        screen.fill(pygame.Color("black"))
        
        for j in drawable:
            j.draw(screen)
            
        pygame.display.flip()
        dt = clock.tick(60)/1000

if __name__ == "__main__":
    main()
