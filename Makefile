USER = endersonmaia
NAME = $(USER)/totvs-appserver64
VERSION = 700131227A-16-12-15

.PHONY: all build tag_latest release

all: build

build:
	docker build -t $(NAME):$(VERSION) --rm .

tag_latest:
	docker tag $(NAME):$(VERSION) $(NAME):latest
