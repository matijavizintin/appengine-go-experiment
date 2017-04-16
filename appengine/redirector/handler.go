package redirector

import (
	"encoding/json"
	"golang.org/x/net/context"
	"google.golang.org/appengine"
	"google.golang.org/appengine/datastore"
	"google.golang.org/appengine/log"
	"google.golang.org/appengine/memcache"
	"math/rand"
	"net/http"
	"time"
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
	redirects, err := getRedirects(ctx)
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

func getRedirects(ctx context.Context) ([]Redirect, error) {
	redirects := []Redirect{}

	item, err := memcache.Get(ctx, "redirect")
	if err == memcache.ErrCacheMiss {
		_, err := datastore.NewQuery("redirect").GetAll(ctx, &redirects)
		if err != nil {
			return nil, err
		}

		bytes, err := json.Marshal(&redirects)
		if err != nil {
			return nil, err
		}

		item := &memcache.Item{
			Key:        "redirect",
			Expiration: time.Duration(time.Hour),
			Value:      bytes,
		}

		err = memcache.Set(ctx, item)
		if err != nil {
			return nil, err
		}

		return redirects, nil
	} else if err != nil {
		return nil, err
	}

	err = json.Unmarshal(item.Value, &redirects)
	if err != nil {
		return nil, err
	}

	return redirects, nil
}
