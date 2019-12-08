package main

import (
	"fmt"
	"io/ioutil"
	"os"
	"strconv"
	"strings"
)

type Input []string
type Point struct {
	x int
	y int
}

func main() {
	// read in the input
	input_1, input_2 := read_input_from("input.txt")

	// follow the input of wire1, add points to a "set"
	visited_points := make(map[Point]bool)
	current_location := Point{x: 0, y: 0}
	for _, point := range input_1 {
		dir, steps_as_string := string(point[0]), point[1:]
		num_steps, err := strconv.Atoi(steps_as_string)
		if err != nil {
			panic(err)
		}

		current_location = travel_in_direction(dir, num_steps, current_location, visited_points)
	}

	// follow the input of wire2, add intersections to an array
	current_location = Point{x: 0, y: 0}
	intersections := make([]Point, 0)
	for _, point := range input_2 {
		dir, steps_as_string := string(point[0]), point[1:]
		num_steps, err := strconv.Atoi(steps_as_string)
		if err != nil {
			panic(err)
		}

		location, new_intersections := travel_and_collect_intersections(dir, num_steps, current_location, visited_points)

		current_location = location
		intersections = append(intersections, new_intersections...)
	}

	var winning_distance int = 9999999999
	println(fmt.Sprintf("We found %d intersections, first one is '(%#v)'", len(intersections), intersections[0]))

	for _, point := range intersections {
		distance := calculate_manhattan_distance(point)
		if distance < winning_distance {
			winning_distance = distance
		}
	}

	println(winning_distance)
}

func calculate_manhattan_distance(point Point) int {
	return absolute_value(point.x) + absolute_value(point.y)
}

func absolute_value(x int) int {
	if x < 0 {
		return -x
	}

	return x
}

func travel_and_collect_intersections(dir string, num_steps int, current_location Point, visited_points map[Point]bool) (Point, []Point) {
	var next_point Point
	intersections := make([]Point, 0)

	switch {
	case dir == "U":
		for i := 1; i <= num_steps; i++ {
			next_point = Point{
				x: current_location.x,
				y: current_location.y + i,
			}

			if visited_points[next_point] {
				intersections = append(intersections, next_point)
			}
		}
	case dir == "D":
		for i := 1; i <= num_steps; i++ {
			next_point = Point{
				x: current_location.x,
				y: current_location.y - i,
			}

			if visited_points[next_point] {
				intersections = append(intersections, next_point)
			}
		}
	case dir == "L":
		for i := 1; i <= num_steps; i++ {
			next_point = Point{
				x: current_location.x - i,
				y: current_location.y,
			}

			if visited_points[next_point] {
				intersections = append(intersections, next_point)
			}
		}
	case dir == "R":
		for i := 1; i <= num_steps; i++ {
			next_point = Point{
				x: current_location.x + i,
				y: current_location.y,
			}

			if visited_points[next_point] {
				intersections = append(intersections, next_point)
			}
		}
	default:
		panic(fmt.Sprintf("unknown direction : '%s'", dir))
	}

	return next_point, intersections
}

func travel_in_direction(dir string, num_steps int, current_location Point, visited_points map[Point]bool) Point {
	var next_point Point

	switch {
	case dir == "U":
		for i := 1; i <= num_steps; i++ {
			next_point = Point{
				x: current_location.x,
				y: current_location.y + i,
			}

			visited_points[next_point] = true
		}
	case dir == "D":
		for i := 1; i <= num_steps; i++ {
			next_point = Point{
				x: current_location.x,
				y: current_location.y - i,
			}

			visited_points[next_point] = true
		}
	case dir == "L":
		for i := 1; i <= num_steps; i++ {
			next_point = Point{
				x: current_location.x - i,
				y: current_location.y,
			}

			visited_points[next_point] = true
		}
	case dir == "R":
		for i := 1; i <= num_steps; i++ {
			next_point = Point{
				x: current_location.x + i,
				y: current_location.y,
			}

			visited_points[next_point] = true
		}
	default:
		panic(fmt.Sprintf("unknown direction : '%s'", dir))
	}

	return next_point
}

func read_input_from(filename string) (Input, Input) {
	file, err := os.Open(filename)
	if err != nil {
		panic(err)
	}

	bytes, err := ioutil.ReadAll(file)
	if err != nil {
		panic(err)
	}

	str := string(bytes)
	lines := strings.Split(str, "\n")

	first := strings.Split(lines[0], ",")
	second := strings.Split(lines[1], ",")

	return first, second
}
