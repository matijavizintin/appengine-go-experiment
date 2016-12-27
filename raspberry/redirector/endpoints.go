package redirector

import (
	"bufio"
	"io"
	"os"
)

const ENDPOINTS_FILE_PATH = "endpoints"

// this will be loaded in the init func
var ENDPOINTS = []string{}

func Init() error {
	f, err := os.Open(ENDPOINTS_FILE_PATH)
	if err != nil {
		return err
	}
	defer f.Close()

	endpoints := make([]string, 0)
	br := bufio.NewReader(f)
	for {
		line, err := br.ReadString('\n')
		if err == io.EOF {
			break
		}
		if err != nil {
			return err
		}

		endpoints = append(endpoints, line)
	}

	ENDPOINTS = endpoints
	return nil
}
