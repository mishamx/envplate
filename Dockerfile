FROM golang:1.11 as builder

WORKDIR /go/src/github.com/mishamx/envplate

RUN go get github.com/kreuzwerker/envplate \
    github.com/spf13/cobra \
    github.com/yawn/doubledash

COPY ./bin/ep.go .

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o ep .

FROM scratch

WORKDIR /app/

COPY --from=builder /go/src/github.com/mishamx/envplate/ep .

CMD ["./ep"]
