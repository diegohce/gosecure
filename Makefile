GOOS=linux
GOFILES=gosecure.go
VERSION=1.0.0
VERSION_NAME=Horatio
BINARY_NAME=gosecure$(VERSION)

LDFLAGS=-ldflags '-X main.VERSION=$(VERSION) -X "main.VERSION_NAME=$(VERSION_NAME)"'

ifeq ($(GOOS), windows)
	EXE=.exe
endif

all: build

build:
	@GOOS=$(GOOS) CGO_ENABLED=0 go build -o $(BINARY_NAME)$(EXE) $(LDFLAGS) $(GOFILES)

run:
	@GOOS=$(GOOS) go run $(LDFLAGS) $(GOFILES)

.PHONY clean:
	@rm -f $(BINARY_NAME) $(BINARY_NAME).exe

deb: build
	cp man/gosecure.1 deb/$(BINARY_NAME)_$(VERSION)_amd64/usr/share/man/man1 && \
	cp $(BINARY_NAME) deb/$(BINARY_NAME)_$(VERSION)_amd64/opt/gosecure/bin && \
	cd deb && \
	dpkg-deb --build $(BINARY_NAME)_$(VERSION)_amd64 ; \
	cd -
