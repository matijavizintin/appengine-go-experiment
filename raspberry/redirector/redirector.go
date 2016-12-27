package redirector

import (
	"log"
	"math/rand"
	"net/http"
)

func RedirectorHandler(w http.ResponseWriter, r *http.Request) {
	log.Printf("Redirect request from %s\n", r.RequestURI)

	url := calculateRedirectUrl()
	if url == "" {
		w.WriteHeader(http.StatusOK)
		return
	}
	http.Redirect(w, r, url, http.StatusFound)
}

func calculateRedirectUrl() string {
	idx := rand.Intn(len(ENDPOINTS) + 1)
	if idx == len(ENDPOINTS) {
		return ""
	}
	return ENDPOINTS[idx]
}
