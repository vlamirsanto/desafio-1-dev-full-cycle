FROM golang:1.16 AS stage

WORKDIR $GOPATH/src/app/

COPY ./golang ./

RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-w -s" -a -installsuffix cgo -o main main.go

ENTRYPOINT ["go", "run", "main.go"]


FROM scratch

WORKDIR /app

COPY --from=stage /go/src/app .

CMD [ "./main" ]
