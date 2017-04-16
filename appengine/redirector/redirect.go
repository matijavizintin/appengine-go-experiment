package redirector

type Redirect struct {
	Endpoint string `datastore:"endpoint,noindex"`
}

type RedirectWrapper struct {
	Redirect []Redirect `json:"redirect"`
}
