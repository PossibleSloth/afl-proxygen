testcase = httptime
working_dir = $(dir $(realpath $(firstword $(MAKEFILE_LIST))))

help:
	@echo "Available commands:"
	@echo "  docker:          Build the docker container"

folly:
	git clone https://github.com/facebook/folly

wangle: folly
	git clone https://github.com/facebook/wangle.git

proxygen: wangle folly
	git clone https://github.com/facebook/proxygen.git 

build: proxygen Dockerfile
	docker build -t proxygen .

docker:
	docker run --privileged -it proxygen /bin/sh

run:
	docker run \
	--privileged \
	-it \
	-v $(working_dir)/results/$(testcase):/opt/proxygen/results \
	-w /opt/proxygen/cases/$(testcase) \
	proxygen /opt/proxygen/cases/$(testcase)/run_afl.sh
