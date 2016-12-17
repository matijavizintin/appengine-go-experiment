package random

import (
	"time"
	"net/http"
	"math/rand"
	"fmt"

	"google.golang.org/appengine"
	"google.golang.org/appengine/datastore"
	"google.golang.org/appengine/log"
)

const chars = "abcdefghijklmnopqrstuvwxyz0123456789"

func GenerateRandomHandler(w http.ResponseWriter, r *http.Request) {
	s := make([]byte, 32)
	for i := 0; i < 32; i++ {
		s[i] = chars[rand.Intn(len(chars))]
	}
	generated := string(s)

	ctx := appengine.NewContext(r)
	results := []Record{}
	_, err := datastore.NewQuery("randoms").Filter("generated =", generated).GetAll(ctx, &results)
	if err != nil {
		log.Errorf(ctx, "%v", err)
		w.WriteHeader(http.StatusInternalServerError)
		return
	}

	if len(results) != 0 {
		w.Write([]byte("Boo ya!"))
		w.WriteHeader(http.StatusConflict)
		return
	}

	rec := &Record{
		Source: r.RemoteAddr,
		Generated: generated,
		Timestamp: time.Now(),
	}


	key := datastore.NewIncompleteKey(ctx, "randoms", nil)
	_, err = datastore.Put(ctx, key, rec)
	if err != nil {
		log.Errorf(ctx, "%v", err)
	}

	w.Write(s)
	w.WriteHeader(http.StatusOK)
}

func ListRandomsHandler(w http.ResponseWriter, r *http.Request) {
	ctx := appengine.NewContext(r)

	dest := []Record{}
	_, err := datastore.NewQuery("randoms").Limit(50).Order("-timestamp").GetAll(ctx, &dest)
	if err != nil {
		log.Errorf(ctx, "%v", err)
		w.WriteHeader(http.StatusInternalServerError)
		return
	}

	w.Write([]byte("<table><tr><th>Source</th><th>Generated random</th><th>Timestamp</th></tr>"))
	for _, record := range dest {
		w.Write([]byte(fmt.Sprintf("<tr><td>%s</td><td>%s</td><td>%v</td></tr>", record.Source, record.Generated, record.Timestamp)))
	}
	w.Write([]byte("</table>"))
	w.WriteHeader(http.StatusOK)
}
