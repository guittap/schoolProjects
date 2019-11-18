//Wargen Guittap
//CS 457 Project #8

package main
	
import (
    "fmt"
	"math/rand"
	"math"
	"time"
)

func getData(MIN int, MAX int) []int {
	var n int
	fmt.Print("please enter list size: ")
	fmt.Scan(&n)
	for n < MIN || n > MAX {
		fmt.Print("input not accepted. please try again: ")
		fmt.Scan(&n)
	}

	list := make([]int, n)
	for i := 0; i < n; i++ {
		seed := rand.NewSource(time.Now().UnixNano())
    	newRand := rand.New(seed)
		list[i] = newRand.Intn(10000)
	}
	fmt.Println()
	return list
}

func displayNums(list []int) {
	i := 0
	j := 0
	fmt.Println("***** printing list of numbers *****")
	for i < len(list) {
		for j < 10 && j + i < len(list) {
			fmt.Print(list[i + j], ", ")
			j++
		}
		j = 0
		i += 10
		if i < len(list) {
			fmt.Println()
		} else {
			fmt.Println("\b\b", " ")
		}
	}
	fmt.Println()
}

func quickSort(list []int, lo int, hi int) {
	// lo is the lower index, hi is the upper index
	// of the region of array a that is to be sorted
	i := lo
	j := hi
	h := 0
	x := list[(lo + hi) / 2]

	//partition
	for {
		for list[i] < x {
			i++
		}
		for list[j] > x {
			j--
		}
		if i <= j {
			h = list[i]
			list[i] = list[j]
			list[j] = h
			i++
			j--
 		}
		if i > j {
			break
		}
	}

	if lo < j {
		quickSort(list, lo, j)
	}

	if i < hi {
		quickSort(list, i, hi)
	}
}

//this function will get a given list and return ave, vari, stanDev
func stats(list []int) (ave float64, vari float64, stanDev float64){
	sum := 0
	for i := 0; i < len(list); i++ {
		sum += list[i]
	}
	
	ave = float64(sum) / float64(len(list))

	var variSum float64
	for i := 0; i < len(list); i++ {
		variSum += (float64(list[i]) - ave) * (float64(list[i]) - ave)
	}
	vari = variSum / float64(len(list) - 1)

	stanDev = math.Sqrt(vari)
	return
}

func displayData(list []int, ave float64, vari float64, stanDev float64) {
	fmt.Println("***** printing stats *****")
	fmt.Println("average = ", ave)
	fmt.Println("variance = ", vari)
	fmt.Println("standard deviation = ", stanDev)
	fmt.Println()
	displayNums(list)
}

func main() {
	const MIN = 10
	const MAX = 1000000
	list := getData(MIN, MAX)
	displayNums(list)
	quickSort(list, 0, len(list) - 1)
	ave, vari, stanDev := stats(list)
	displayData(list, ave, vari, stanDev)
}