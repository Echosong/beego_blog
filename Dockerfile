# beego_blog · 2017 年 beego v1 / GOPATH 工程的容器化
FROM golang:1.21-bullseye

# 旧工程依赖 GOPATH 模式
ENV GO111MODULE=off \
    GOPATH=/go \
    CGO_ENABLED=0

WORKDIR /go/src/github.com/Echosong/beego_blog

# 先拉依赖（利用镜像层缓存）
RUN go get github.com/astaxie/beego && \
    go get github.com/astaxie/beego/orm && \
    go get github.com/go-sql-driver/mysql

COPY . .

RUN go build -o /app/beego_blog .

EXPOSE 8099
CMD ["/app/beego_blog"]
