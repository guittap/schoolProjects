//Wargen Guittap
//CS 326

package main

import (
	"fmt"
	"io"

	//"strings"
	"os"
	"time"
	// "path"
	// "net/http"
	//"golang.org/x/net/html"
)

func myScrapper() {

}

func main() {
	start := time.Now()
	urlList := []string{
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
	urlFile, err := os.Create("foundUrls.txt")
	if err != nil {
		panic(err)
	}
	defer urlFile.Close()

	imgFile, err := os.Create("foundImages.txt")
	if err != nil {
		panic(err)
	}
	defer imgFile.Close()

	i := 0
	for i < len(urlList) {
		go myScrapper()
		_, err := io.WriteString(urlFile, urlList[i]+"\n")
		if err != nil {
			panic(err)
		}
		i++
	}
	elapsed := time.Since(start)
	fmt.Printf("Downloads completed in %s \n", elapsed)
}
