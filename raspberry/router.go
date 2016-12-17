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

	http.HandleFunc("/redirect", redirector.RedirectorHandler)

	log.Println("Starting server")
	err := http.ListenAndServe(":9082", nil)
	if err != nil {
		log.Fatal(err)
	}
}
