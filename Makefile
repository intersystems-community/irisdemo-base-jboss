
include .env

build:
	docker build -t ${DOCKER_REPOSITORY}:irishibernate-version-${TAG} -f hibernate.Dockerfile .
	docker build --build-arg SOURCE_BRANCH=${TAG} -t ${DOCKER_REPOSITORY}:irisjboss-version-${TAG} .

clean:
	-docker rmi ${DOCKER_REPOSITORY}:irishibernate-version-${TAG}
	-docker rmi ${DOCKER_REPOSITORY}:irisjboss-version-${TAG}

push:
	-docker push ${DOCKER_REPOSITORY}:irishibernate-version-${TAG}
	-docker push ${DOCKER_REPOSITORY}:irisjboss-version-${TAG}

run:
	docker run --rm -it  \
    -p 8080:8080  \
    -p 9990:9990  \
    -e IRIS_MASTER_USERNAME=SuperUser \
    -e IRIS_MASTER_PASSWORD=sys \
    -e IRIS_MASTER_HOST=localhost \
    -e IRIS_MASTER_PORT=51773 \
    -e IRIS_MASTER_NAMESPACE=APP \
    --name jboss \
    ${DOCKER_REPOSITORY}:irisjboss-version-${TAG}