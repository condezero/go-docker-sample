FROM golang:1.16-alpine as builder

WORKDIR /app/go-docker/

# COPY go.mod, go.sum and download the dependencies
COPY go.* ./
RUN go mod download

# COPY All things inside the project and build
COPY . .
RUN go build -o /app/go-docker/build/myapp .

FROM alpine:latest
COPY --from=builder /app/go-docker/build/myapp /app/go-docker/build/myapp

EXPOSE 8080
ENTRYPOINT [ "/app/go-docker/build/myapp" ]