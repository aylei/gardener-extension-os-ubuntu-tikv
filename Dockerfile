############# builder
FROM golang:1.13.8 AS builder

WORKDIR /go/src/github.com/gardener/gardener-extension-os-ubuntu-tikv
COPY . .
RUN make install-requirements && make VERIFY=true all

############# gardener-extension-os-ubuntu-tikv
FROM alpine:3.11.3 AS gardener-extension-os-ubuntu-tikv

COPY --from=builder /go/bin/gardener-extension-os-ubuntu-tikv /gardener-extension-os-ubuntu-tikv
ENTRYPOINT ["/gardener-extension-os-ubuntu-tikv"]
