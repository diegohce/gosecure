GOOS=linux
GOFILES=gosecure.go
VERSION=0.1.1
VERSION_NAME=Ugly Logger
BINARY_NAME=gosecure

LDFLAGS=-ldflags '-X main.VERSION=$(VERSION) -X "main.VERSION_NAME=$(VERSION_NAME)"'

ifeq ($(GOOS), windows)
	EXE=.exe
endif

#all: deps build
all: build

build:
	@GOOS=$(GOOS) go build -o $(BINARY_NAME)$(EXE) $(LDFLAGS) $(GOFILES)

run:
	@GOOS=$(GOOS) go run $(LDFLAGS) $(GOFILES)

.PHONY clean:
	@rm -f $(BINARY_NAME) $(BINARY_NAME).exe

#deps:
#	@go get github.com/julienschmidt/httprouter
#	@go get github.com/creamdog/gonfig
