.PHONY: run build

MEMTIER_VERSION=1.2.8
BUILD_VERSION=build-$(shell git rev-parse --short HEAD)
UBUNTU_VERSION=ubuntu-$(shell grep '^FROM ubuntu' Dockerfile  | cut -d ':' -f 2)

ifndef TAG
	TAG := $(MEMTIER_VERSION)_$(UBUNTU_VERSION)_$(BUILD_VERSION)
endif

REPO=wattpad/docker-memtier_benchmark
IMAGE=$(REPO):$(TAG)

build:
	docker build -t $(IMAGE) --build-arg MEMTIER_VERSION=$(MEMTIER_VERSION) .
	docker tag $(IMAGE) $(REPO):latest

push: build
	docker push $(IMAGE)

run: build
	docker run -ti --rm $(IMAGE) bash
