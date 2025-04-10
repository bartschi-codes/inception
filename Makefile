NAME = incpetion

COMPOSE_FILE = src/docker-compose.yml

all: $(NAME)

$(NAME):
	docker-compose -f $(COMPOSE_FILE) up --build

clean:
	docker-compose -f $(COMPOSE_FILE) down

fclean: clean
	docker system prune -a --volumes

re: fclean all

.PHONY: all inception clean fclean re
