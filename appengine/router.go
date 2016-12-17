package main

import (
	"math/rand"
	"net/http"
	"random"
	"redirector"
	"time"
)

func init() {
	rand.Seed(time.Now().Unix())

	http.HandleFunc("/random", random.GenerateRandomHandler)
	http.HandleFunc("/list-randoms", random.ListRandomsHandler)
	http.HandleFunc("/redirect", redirector.RedirectHandler)
}
