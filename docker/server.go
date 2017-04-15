package main

import "net/http"

func main() {
	http.Handle("/", &indexHandler{})

	http.ListenAndServe(":8080", nil)
}

type indexHandler struct{}

func (i indexHandler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	w.WriteHeader(http.StatusOK)

	w.Write([]byte("Hello"))
}
