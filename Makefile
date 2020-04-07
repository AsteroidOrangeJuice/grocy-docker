.PHONY: build pod grocy nginx

GROCY_VERSION = v2.6.2
IMAGE_COMMIT := $(shell git rev-parse --short HEAD)
IMAGE_TAG := $(strip $(if $(shell git status --porcelain --untracked-files=no), "${IMAGE_COMMIT}-dirty", "${IMAGE_COMMIT}"))

build: pod grocy nginx
	podman run \
        --add-host grocy:127.0.0.1 \
        --detach \
        --env-file grocy.env \
        --name grocy \
        --pod grocy-pod \
        --read-only \
        --volume /var/log/php7 \
        --volume app-db:/var/www/data \
        grocy:${IMAGE_TAG}
	podman run \
        --add-host grocy:127.0.0.1 \
        --detach \
        --name nginx \
        --pod grocy-pod \
        --read-only \
        --tmpfs /tmp \
        --volume /var/log/nginx \
        nginx:${IMAGE_TAG}

pod:
	podman pod rm -f grocy-pod || true
	podman pod create --name grocy-pod --publish 127.0.0.1:8080:8080

grocy:
	podman image exists $@:${IMAGE_TAG} || buildah bud --build-arg GITHUB_API_TOKEN=${GITHUB_API_TOKEN} --build-arg GROCY_VERSION=${GROCY_VERSION} -f Dockerfile-grocy -t $@:${IMAGE_TAG} .
	podman tag $@:${IMAGE_TAG} $@:latest

nginx:
	podman image exists $@:${IMAGE_TAG} || buildah bud --build-arg GROCY_VERSION=${GROCY_VERSION} -f Dockerfile-grocy-nginx -t $@:${IMAGE_TAG} .
	podman tag $@:${IMAGE_TAG} $@:latest
