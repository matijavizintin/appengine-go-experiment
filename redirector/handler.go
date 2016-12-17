package redirector

import "net/http"

func RedirectHandler(w http.ResponseWriter, r *http.Request) {
	http.Redirect(w, r, r.URL.String(), http.StatusFound)
}
