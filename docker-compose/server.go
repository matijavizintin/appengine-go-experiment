package main

import (
	"fmt"
	"math"
	"net/http"
	"os"
	"sort"
)

func main() {
	http.Handle("/", &indexHandler{})
	http.Handle("/healthcheck/", &healthCheckHandler{})

	http.ListenAndServe(":8080", nil)
}

type indexHandler struct{}

func (i indexHandler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	doSomeCpuIntensiveWork()

	w.WriteHeader(http.StatusOK)

	hostname, _ := os.Hostname()
	w.Write([]byte(fmt.Sprintf("Hello from %s", hostname)))
}

func doSomeCpuIntensiveWork() {
	const loops = 100 * 1000

	slice := []int{}

	for i := 0; i < loops; i++ {
		slice = append(slice, loops-i)
	}
	sort.Ints(slice)

	sum := 0.
	for i := 0; i < loops; i++ {
		sqrt := math.Sqrt(float64(i))
		sum += sqrt
	}
}

type healthCheckHandler struct{}

func (i healthCheckHandler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	w.WriteHeader(http.StatusOK)
}
