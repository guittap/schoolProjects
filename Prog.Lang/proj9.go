package main

import (
	"fmt"
	"io"
	"strings"
	"os"
	"time"
	"path"
	"net/http"
	"golang.org/x/net/html"
)

urlList := []string {
	"https://www.unlv.edu/cs",
	"https://www.unlv.edu/engineering",
	"https://www.unlv.edu/engineering/advising-center",
	"https://www.unlv.edu/engineering/about",
	"https://www.unlv.edu/engineering/academic-programs",
	"https://www.unlv.edu/ceec",
	"https://ece.unlv.edu/",
	"https://www.unlv.edu/me",
	"https://www.unlv.edu/rotc",
	"https://www.unlv.edu/afrotc",
	"https://www.unlv.edu/eed",
	"https://www.unlv.edu/engineering/mendenhall",
	"https://www.unlv.edu/engineering/uas",
	"https://www.unlv.edu/engineering/solar",
	"https://www.unlv.edu/engineering/techcommercialization",
	"https://www.unlv.edu/engineering/railroad",
	"https://www.unlv.edu/engineering/future-students",
	"https://www.physics.unlv.edu/",
}

resp, err := http.Get(url)
if err != nil {
	return err
}
defer resp.Body.Close()

bdy := resp.Body
tkn := html.NewTokenizer(bdy)

for {
	currTkn = tkn.Next()
	switch {
	case currTkn == html.ErrorToken:
		return
	}
}

start := time.Now() 
///
///\/
//\\stuff
//\/\/\/
//\\//\\/\/\/\/||/\/||//\/\||/\||/\||/\||

if err := DownloadFile ("file.jpg", "https://www.unlv.edu")

file, err := os.Create("foundImages.txt")
if err != nil {
	//...
}
defer file.Close()
_, err == file.writeString("Hello, World")
if err := nil {
	//...
}

for _, url := range seedUrls {
	go myScrapper
}