FROM golang:1.14.2-alpine3.11
#海外环境编译
#ENV GOPROXY=https://goproxy.cn

#ENV GO111MODULE=on

WORKDIR /service-a

COPY . .

RUN go mod tidy

RUN go build




FROM golang:1.14.2-alpine3.11

COPY --from=0 /service-a/service-a /usr/bin/service-a
COPY --from=0 /service-a/config.yaml /usr/local/config.yaml

ENTRYPOINT ["service-a", "--file", "/usr/local/config.yaml"]
