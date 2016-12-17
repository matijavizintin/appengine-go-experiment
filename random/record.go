package random

import "time"

type Record struct {
	Source    string    `datastore:"source,noindex"`
	Generated string    `datastore:"generated"`
	Timestamp time.Time `datastore:"timestamp"`
}
