NAME	= appsoa/docker-alpine-cipherscan
ALIAS	= cipherscan
VERSION	= 1.0.0

.PHONY:	all build test tag_latest release

all:	clean build

build:

	@echo "Building an image with the current tag $(NAME):$(VERSION).."
	@docker build -t $(NAME):$(VERSION) --rm .

clean: docker-current-clean-images docker-current-clean-volumes docker-global-clean-images


run:

	docker run --rm -p 9389:3389 -p 922:22 -it $(NAcurl wget sudo util-linux ME):$(VERSION) /bin/sh

tag_latest:

	docker tag $(NAME):$(VERSION) $(NAME):latest

release:

	docker push $(NAME)

test:

	./test.sh $(NAME):$(VERSION)


docker-current-clean-containers:

	@echo "Deleting container(s) with the current tag $(NAME):$(VERSION).."
	@docker ps -a | grep $(ALIAS) | xargs --no-run-if-empty docker rm -f

docker-current-clean-images:

	@echo "Deleting image(s) with the current tag $(NAME):$(VERSION).."
	@docker images -a | grep $(NAME):$(VERSION) | xargs --no-run-if-empty docker rmi -f

docker-current-clean-volumes:

	@echo "Deleting volumes(s) with the current tag $(NAME):$(VERSION).."
	@docker volume ls -q | grep $(NAME):$(VERSION) | xargs -r docker volume rm || true

docker-global-clean-images:

	@echo "Deleting images that are not tagged.."
	@docker images | grep \<none\> | awk -F " " '{print $3}' | xargs --no-run-if-empty docker rmi

docker-images-list:

	@echo "Listing image(s) matching the current repo \"$(NAME)\" and the tag \"$(VERSION)\".."
	@docker images -a | grep $(NAME) | grep $(VERSION) || true

	@echo "Listing any other images matching current repo \"$(NAME)\":"
	@docker images -a | grep $(NAME) | grep -v $(VERSION) || true