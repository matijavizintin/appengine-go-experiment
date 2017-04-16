package secure

import "net/http"

func IsAllowed(req *http.Request) bool {
	return req.RemoteAddr == allowedIP
}

func NotAllowed(w http.ResponseWriter, _ *http.Request) {
	w.WriteHeader(http.StatusForbidden)
}
