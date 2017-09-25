LOCAL_IMAGE="$(USER)/base-notebook"
WAIT_TIME=10

.PHONY: build clean run test

build:
	docker build -t $(LOCAL_IMAGE) .

clean:
	docker rmi -f $(LOCAL_IMAGE)

run:
	docker run -ti --rm -p 8888:8888 -e JUPYTER_NOTEBOOK_DISABLE_TOKEN=true $(USER)/base-notebook

test:
	-docker rm -f test-base-notebook || true
	docker run -d --name test-base-notebook -p 8888:8888 -e JUPYTER_NOTEBOOK_DISABLE_TOKEN=true $(USER)/base-notebook
	sleep $(WAIT_TIME)
	./ready.sh && echo "Test completed successfully!"
	-docker rm -f test-base-notebook || true
