FROM golang:1.10-alpine

RUN apk add --no-cache git && \
    go get -v github.com/golang/dep/cmd/dep && \
    go get -v github.com/mitchellh/gox && \
    go get -v github.com/tcnksm/ghr && \
    go get -v github.com/mattn/goveralls

ONBUILD RUN if [ -z "$GH_USER" ]; then echo "Build with '--build-arg GH_USER'" && exit -1; fi
ONBUILD RUN if [ -z "$GH_PROJECT" ]; then echo "Build with '--build-arg GH_PROJECT'" && exit -1; fi
ONBUILD RUN mkdir -p ${GOPATH}/src/github.com/${GH_USER}/${GH_PROJECT}
ONBUILD WORKDIR ${GOPATH}/src/github.com/${GH_USER}/${GH_PROJECT}

ONBUILD COPY . .
