ROOT_PATH := ${PWD}
BUILD_DIR := ${ROOT_PATH}/build
HEADER_DIR := ${ROOT_PATH}/header
SOURCE_DIR := ${ROOT_PATH}/source
LIB_DIR := ${ROOT_PATH}/lib

all : wallwall

wallwall: main.o packet.o
	g++ -g -o ${BUILD_DIR}/wallwall ${BUILD_DIR}/main.o ${BUILD_DIR}/packet.o -lnetfilter_queue -ljson-c -L=${BUILD_DIR}/lib

main.o: makeBuildFolder
	g++ -g -c -o ${BUILD_DIR}/main.o ${SOURCE_DIR}/main.cpp

packet.o: makeBuildFolder
	g++ -g -c -o ${BUILD_DIR}/packet.o ${SOURCE_DIR}/protocol/packet.cpp

json: 
	cd ${LIB_DIR}/json-c && \
	sh autogen.sh && \
	./configure --libdir=${BUILD_DIR}/lib --includedir=${HEADER_DIR}/lib --enable-static=yes --enable-shared=no && \
	make && \
	make install

makeBuildFolder:
	mkdir -p ${BUILD_DIR}

clean:
	rm -f ${BUILD_DIR}/*

