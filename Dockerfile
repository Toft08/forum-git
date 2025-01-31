FROM golang:1.22.4 AS builder

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN go build -o forum

FROM debian:bookworm-slim

WORKDIR /app

# Metadata
LABEL project="Forum"
LABEL description="A simple forum web application"

# Set up necessary directories
RUN mkdir -p /app/forum-git /app/templates /app/assets /app/database

COPY --from=builder /app/forum /app/forum
COPY ./assets /app/assets
COPY ./templates /app/templates
COPY ./web /app/web
COPY ./database /app/database

# Expose port 8080 to allow the app to be accessible from outside the container
EXPOSE 8080

CMD ["/app/forum"]