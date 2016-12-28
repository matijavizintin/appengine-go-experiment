package main

import (
	"log"
	"math/rand"
	"net/http"
	"time"

	"cloud-experiment/raspberry/redirector"
)

func main() {
	rand.Seed(time.Now().Unix())

	// register and init redirector handler
	err := redirector.Init()
	if err != nil {
		log.Fatal(err)
	}
	http.HandleFunc("/redirect", redirector.RedirectorHandler)

	log.Println("Starting server")

	go runHTTPSServer()
	runHTTPServer()
}

func runHTTPServer() {
	err := http.ListenAndServe(":9082", nil)
	if err != nil {
		log.Fatal(err)
	}
}

func runHTTPSServer() {
	err := http.ListenAndServeTLS(":9083", "cert.pem", "key.pem", nil)
	if err != nil {
		log.Fatal(err)
	}
}
