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
	err = http.ListenAndServeTLS(":9082", "cert.pem", "key.pem", nil)
	if err != nil {
		log.Fatal(err)
	}
}
