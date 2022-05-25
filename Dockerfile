FROM ubuntu:20.04

MAINTAINER <christoph.hahn@uni-graz.at>

WORKDIR /usr/src

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true
RUN apt update && apt install -y build-essential \
	git \ 
	bzip2 \
	cmake \
	gzip \
	g++ \
	libgomp1 \
	make \
	python \
	zlib1g-dev && \
	git clone https://github.com/voutcn/megahit.git && \
	cd megahit && \
	git reset --hard f8afe5dc565ca79dabb61e4f822135ef4926baac && \
	rm -rf build && mkdir -p build && \
	cd build && \
	cmake -DCMAKE_BUILD_TYPE=Release .. && \
	make -j4 install && \
	apt-get autoremove --purge -y \
	cmake \
	g++ \
	make \
	zlib1g-dev

RUN megahit --test && megahit --test --kmin-1pass
ENTRYPOINT ["megahit"]
