package main

import (
	"fmt"
	"os"
    "log"
    "crypto/tls"
    "net"
	"io"
	"flag"
	"sync"
)

type Config struct {
	certfile string
	keyfile  string
	local    string
	remote   string
}

var (
	BINARY_NAME= "gosecure"
	VERSION = "v0.0.1"
	VERSION_NAME = "Tunelito"
)

var CONFIG Config

func main() {
    //log.SetFlags(log.Lshortfile)


	flag.StringVar(&CONFIG.certfile, "cert", "", "Certificate file")
	flag.StringVar(&CONFIG.keyfile , "key", "", "Key file")
	flag.StringVar(&CONFIG.local   , "local", "", "Where to listen on this machine [ip_address]:port")
	flag.StringVar(&CONFIG.remote  , "remote", "", "Where to connect to {ip_address | hostname}:port")

	flag.Parse()

	if CONFIG.certfile == "" || CONFIG.keyfile == "" || CONFIG.local == "" || CONFIG.remote == "" {
		fmt.Printf("%s v%s (%s)\n\n", BINARY_NAME, VERSION, VERSION_NAME)
		flag.PrintDefaults()
		os.Exit(1)
	}

	log.Printf("Starting %s v%s (%s)\n", BINARY_NAME, VERSION, VERSION_NAME)

    cer, err := tls.LoadX509KeyPair(CONFIG.certfile, CONFIG.keyfile)
    if err != nil {
        log.Println(err)
        return
    }

    config := &tls.Config{Certificates: []tls.Certificate{cer}}
    ln, err := tls.Listen("tcp", CONFIG.local, config)
    if err != nil {
        log.Println(err)
        return
    }
    defer ln.Close()

    for {
        conn, err := ln.Accept()
        if err != nil {
            log.Println(err)
            continue
        }
        go handleConnection(conn)
    }
}

func handleConnection(iconn net.Conn) {
    defer iconn.Close()

	logprefix := fmt.Sprintf("%s -> %s ::", iconn.RemoteAddr(), CONFIG.remote)

	log.Println(logprefix, "Starting tunnel")

	log.Println(logprefix, "Connecting to", CONFIG.remote)

	oconn, err := net.Dial("tcp", CONFIG.remote)
	if err != nil {
		log.Println(logprefix, err)
		return
	}
	defer oconn.Close()

	log.Println(logprefix, "Connected to", CONFIG.remote)


	wg := &sync.WaitGroup{}
	wg.Add(2)

	log.Println(logprefix, "Connecting wires")

	go cp(oconn, iconn, wg)
	go cp(iconn, oconn, wg)

	log.Println(logprefix, "Waiting wires to cut")
	wg.Wait()
	log.Println(logprefix, "Wires cut")

}


func cp(from, to net.Conn, wg *sync.WaitGroup) {
	defer wg.Done()

	logprefix := fmt.Sprintf("%s -> %s ::", from.RemoteAddr(), to.RemoteAddr())

	log.Println(logprefix, "Starting cp")
	bc, err := io.Copy(to, from)
	if err != nil {
		log.Println(logprefix, err)
	}
	log.Println(logprefix, "::", bc, "bytes")
	to.Close()
	log.Println(logprefix+"::Exiting cp")
}


