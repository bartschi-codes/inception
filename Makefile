NAME = incpetion

COMPOSE_FILE = src/docker-compose.yml

all: $(NAME)

$(NAME):
	mkdir -p src/data/wordpress
	mkdir -p src/data/mariadb
	docker-compose -f $(COMPOSE_FILE) up -d --build


down: clean

clean:
	docker-compose -f $(COMPOSE_FILE) down

fclean: clean
	docker system prune -a --volumes
	rm -rf src/data/*

re: fclean all

.PHONY: all inception clean fclean re
