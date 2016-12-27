package redirector

import (
	"golang.org/x/net/context"
	"google.golang.org/appengine"
	"google.golang.org/appengine/datastore"
	"google.golang.org/appengine/log"
	"math/rand"
	"net/http"
)

func RedirectHandler(w http.ResponseWriter, r *http.Request) {
	ctx := appengine.NewContext(r)

	url, err := calculateRedirectUrl(ctx)
	if err != nil {
		w.WriteHeader(http.StatusInternalServerError)
		return
	}
	if url == "" {
		w.WriteHeader(http.StatusOK)
		return
	}
	http.Redirect(w, r, url, http.StatusFound)
}

func calculateRedirectUrl(ctx context.Context) (string, error) {
	redirects := []Redirect{}
	_, err := datastore.NewQuery("redirect").GetAll(ctx, &redirects)
	if err != nil {
		log.Errorf(ctx, "%v", err)
		return "", err
	}

	idx := rand.Intn(len(redirects) + 1)
	if idx == len(redirects) {
		return "", nil
	}
	return redirects[idx].Endpoint, nil
}
