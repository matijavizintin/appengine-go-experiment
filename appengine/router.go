package main

import (
	"math/rand"
	"net/http"
	"random"
	"redirector"
	"secure"
	"time"
)

func init() {
	rand.Seed(time.Now().Unix())

	secureRandom := func(w http.ResponseWriter, r *http.Request) {
		secureWrapper(w, r, random.GenerateRandomHandler)
	}
	secureListRandoms := func(w http.ResponseWriter, r *http.Request) {
		secureWrapper(w, r, random.ListRandomsHandler)
	}
	secureRedirect := func(w http.ResponseWriter, r *http.Request) {
		secureWrapper(w, r, redirector.RedirectHandler)
	}

	http.HandleFunc("/random", secureRandom)
	http.HandleFunc("/random/", secureRandom)

	http.HandleFunc("/list-randoms", secureListRandoms)
	http.HandleFunc("/list-randoms/", secureListRandoms)

	http.HandleFunc("/redirect", secureRedirect)
	http.HandleFunc("/redirect/", secureRedirect)
}

func secureWrapper(w http.ResponseWriter, r *http.Request, fn func(w http.ResponseWriter, r *http.Request)) {
	if !secure.IsAllowed(r) {
		secure.NotAllowed(w, r)
		return
	}

	fn(w, r)
}
