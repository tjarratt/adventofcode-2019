package main

import (
	"io/ioutil"

	. "github.com/tjarratt/advent-of-code/2019/day-10/spinning-lazers"
)

func main() {
	point := Point{X: 30, Y: 34}
	solver := SpinningLazerSolver(input(), point)

	last_asteroid_exploded := solver.Solve(200)

	println(last_asteroid_exploded.X*100 + last_asteroid_exploded.Y)
}

func input() string {
	bytes, err := ioutil.ReadFile("input.txt")
	if err != nil {
		panic(err)
	}

	return string(bytes)
}
