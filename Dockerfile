FROM alpine:3.20

ARG TARGETARCH

RUN apk add --no-cache ca-certificates tzdata

COPY build/${TARGETARCH}/nezha-agent /usr/local/bin/nezha-agent

ENTRYPOINT ["/usr/local/bin/nezha-agent"]
