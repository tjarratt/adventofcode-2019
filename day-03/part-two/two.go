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

type Intersection struct {
	point           Point
	line_1_distance int
	line_2_distance int
}

func main() {
	// read in the input
	input_1, input_2 := read_input_from("../input.txt")
	println(fmt.Sprintf("%#v", input_1))
	println(fmt.Sprintf("%#v", input_2))

	// follow the input of wire1, add points to a "set"
	visited_points := make(map[Point]int)
	current_location := Point{x: 0, y: 0}
	travelled_steps := 0
	for _, point := range input_1 {
		dir, steps_as_string := string(point[0]), point[1:]
		num_steps, err := strconv.Atoi(steps_as_string)
		if err != nil {
			panic(err)
		}

		current_location = travel_in_direction(dir, num_steps, travelled_steps, current_location, visited_points)
		travelled_steps += num_steps
	}

	// DEBUG
	for point, distance := range visited_points {
		println(fmt.Sprintf("line 1 got to point %#v in a distance of %d", point, distance))
	}

	// follow the input of wire2, add intersections to an array
	current_location = Point{x: 0, y: 0}
	intersections := make([]Intersection, 0)
	previous_steps := 0
	for _, point := range input_2 {
		dir, steps_as_string := string(point[0]), point[1:]
		num_steps, err := strconv.Atoi(steps_as_string)
		if err != nil {
			panic(err)
		}

		location, new_intersections := travel_and_collect_intersections(dir, num_steps, previous_steps, current_location, visited_points)

		current_location = location
		previous_steps += num_steps
		intersections = append(intersections, new_intersections...)
	}

	// change : winning intersection is now the one that minimizes
	// the sum of the steps necessary for each wire to reach that point
	// if a wire crosses the same point multiple times, use the first
	// the answer will be the number of combined steps
	var winning_distance int = 9999999999

	println(fmt.Sprintf("we found %d intersections, first one is '(%#v)'", len(intersections), intersections[0]))
	for _, intersection := range intersections {
		distance := calculate_combined_steps(intersection)

		if distance < winning_distance {
			winning_distance = distance

			println(fmt.Sprintf("Found new winning intersection (distance %d) %#v", distance, intersection))
		}
	}

	println("what is going on here")
	println(fmt.Sprintf("winning distance is %d", winning_distance))
}

func calculate_combined_steps(intersection Intersection) int {
	return intersection.line_1_distance + intersection.line_2_distance
}

func absolute_value(x int) int {
	if x < 0 {
		return -x
	}

	return x
}

func travel_and_collect_intersections(dir string, num_steps int, previous_steps int, current_location Point, visited_points map[Point]int) (Point, []Intersection) {
	var next_point Point
	intersections := make([]Intersection, 0)

	switch {
	case dir == "U":
		for i := 1; i <= num_steps; i++ {
			next_point = Point{
				x: current_location.x,
				y: current_location.y + i,
			}

			println(fmt.Sprintf("line two has travelled to %#v after %d steps", next_point, i+previous_steps))

			if distance, ok := visited_points[next_point]; ok {
				intersection := Intersection{point: next_point, line_1_distance: distance, line_2_distance: i + previous_steps}
				intersections = append(intersections, intersection)
			}
		}
	case dir == "D":
		for i := 1; i <= num_steps; i++ {
			next_point = Point{
				x: current_location.x,
				y: current_location.y - i,
			}

			println(fmt.Sprintf("line two has travelled to %#v after %d steps", next_point, i+previous_steps))

			if distance, ok := visited_points[next_point]; ok {
				intersection := Intersection{point: next_point, line_1_distance: distance, line_2_distance: i + previous_steps}
				intersections = append(intersections, intersection)
			}
		}
	case dir == "L":
		for i := 1; i <= num_steps; i++ {
			next_point = Point{
				x: current_location.x - i,
				y: current_location.y,
			}

			println(fmt.Sprintf("line two has travelled to %#v after %d steps", next_point, i+previous_steps))

			if distance, ok := visited_points[next_point]; ok {
				intersection := Intersection{point: next_point, line_1_distance: distance, line_2_distance: i + previous_steps}
				intersections = append(intersections, intersection)
			}
		}
	case dir == "R":
		for i := 1; i <= num_steps; i++ {
			next_point = Point{
				x: current_location.x + i,
				y: current_location.y,
			}

			println(fmt.Sprintf("line two has travelled to %#v after %d steps", next_point, i+previous_steps))

			if distance, ok := visited_points[next_point]; ok {
				intersection := Intersection{point: next_point, line_1_distance: distance, line_2_distance: i + previous_steps}
				intersections = append(intersections, intersection)
			}
		}
	default:
		panic(fmt.Sprintf("unknown direction : '%s'", dir))
	}

	return next_point, intersections
}

func travel_in_direction(dir string, num_steps int, previous_steps int, current_location Point, visited_points map[Point]int) Point {
	var next_point Point

	switch {
	case dir == "U":
		for i := 1; i <= num_steps; i++ {
			next_point = Point{
				x: current_location.x,
				y: current_location.y + i,
			}
			println(fmt.Sprintf("line one has travelled to %#v", next_point))

			if _, ok := visited_points[next_point]; ok == false {
				visited_points[next_point] = i + previous_steps
				println(fmt.Sprintf("stored distance of %d for line 1 at (%d, %d)", i+previous_steps, next_point.x, next_point.y))
			}
		}
	case dir == "D":
		for i := 1; i <= num_steps; i++ {
			next_point = Point{
				x: current_location.x,
				y: current_location.y - i,
			}

			println(fmt.Sprintf("line one has travelled to %#v", next_point))

			if _, ok := visited_points[next_point]; ok == false {
				visited_points[next_point] = i + previous_steps
			}
		}
	case dir == "L":
		for i := 1; i <= num_steps; i++ {
			next_point = Point{
				x: current_location.x - i,
				y: current_location.y,
			}

			println(fmt.Sprintf("line one has travelled to %#v", next_point))

			if _, ok := visited_points[next_point]; ok == false {
				visited_points[next_point] = i + previous_steps
			}
		}
	case dir == "R":
		for i := 1; i <= num_steps; i++ {
			next_point = Point{
				x: current_location.x + i,
				y: current_location.y,
			}

			println(fmt.Sprintf("line one has travelled to %#v", next_point))

			if _, ok := visited_points[next_point]; ok == false {
				visited_points[next_point] = i + previous_steps
			}
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
