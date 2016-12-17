package main

import (
	"time"
	"random"
	"math/rand"
	"net/http"
	"redirector"
)

func init() {
	rand.Seed(time.Now().Unix())

	http.HandleFunc("/random", random.GenerateRandomHandler)
	http.HandleFunc("/list-randoms", random.ListRandomsHandler)
	http.HandleFunc("/redirect", redirector.RedirectHandler)
}
