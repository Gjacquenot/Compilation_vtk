DOCKER_IMAGE=compilation-vtk
DOCKER_WORKING_DIRECTORY=/work

DOCKER_RUN:=\
	docker run --rm \
	-u $(shell id -u):$(shell id -g) \
	-v $(shell pwd):${DOCKER_WORKING_DIRECTORY} \
	-w ${DOCKER_WORKING_DIRECTORY} \
	${DOCKER_IMAGE} \
	/bin/bash -c

docker_build_pdf:
	docker build . -t ${DOCKER_IMAGE}