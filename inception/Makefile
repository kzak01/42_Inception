NAME = inception

all:
	sudo mkdir -p ~/data/mariadb
	sudo mkdir -p ~/data/wordpress
	sudo docker-compose -f srcs/docker-compose.yaml up --build

# Target to run the container
up:
	sudo docker-compose -f srcs/docker-compose.yaml up

# Target to stop the container
stop:
	sudo docker-compose -f srcs/docker-compose.yaml down

# Target to clean up containers and volumes
clean:
	sudo docker-compose -f srcs/docker-compose.yaml down --volumes

# Target to clean up everything, including data and images
prune: clean
	sudo rm -rf ~/data/mariadb ~/data/wordpress
	sudo docker system prune -a

re: prune all

.PHONY: all stop clean prune re
