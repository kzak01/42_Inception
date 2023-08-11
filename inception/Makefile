NAME = inception

all:
	sudo mkdir -p /home/$USERNAME/data/mariadb
	sudo mkdir -p /home/$USERNAME/data/wordpress
	sudo docker-compose -f srcs/docker-compose.yaml up --build

stop:
	sudo docker-compose -f srcs/docker-compose.yaml down

clean:
	sudo docker-compose -f srcs/docker-compose.yaml down --volumes

prune: clean
	sudo docker system prune -a

re: prune all

.PHONY: all stop clean prune re
