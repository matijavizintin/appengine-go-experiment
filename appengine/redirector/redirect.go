package redirector

type Redirect struct {
	Endpoint string `datastore:"endpoint,noindex"`
}
