package spinning_lazers

import (
	"fmt"
	"math"
	"sort"
	"strings"
)

type Point struct {
	X int
	Y int
}

type Vector struct {
	X  int
	Y  int
	oX int
	oY int
}

type solver struct {
	input string
	lazer Point
}

func SpinningLazerSolver(input string, lazercoords Point) solver {
	return solver{input: input, lazer: lazercoords}
}

func (solver solver) Solve(max_iterations int) Point {
	asteroids := map[float64][]Vector{}

	lines := strings.Split(solver.input, "\n")
	graphics := make([][]string, len(lines))

	for y, line := range lines {
		for x, location := range strings.Split(line, "") {
			if location == "." {
				graphics[y] = append(graphics[y], ".")
				continue
			}
			if x == solver.lazer.X && y == solver.lazer.Y {
				graphics[y] = append(graphics[y], "O")
				continue
			}

			graphics[y] = append(graphics[y], "#")

			asteroid := makeVector(solver.lazer, x, y)
			degrees := vec_to_degrees(asteroid)

			asteroids[degrees] = append(asteroids[degrees], asteroid)

			sort.Slice(asteroids[degrees], func(i, j int) bool {
				return vec_to_length(asteroids[degrees][i]) < vec_to_length(asteroids[degrees][j])
			})
		}
	}

	// take each point in the input
	// calculate its vector from our lazer coordinates
	// sort these vectors into a slice of slices
	seen_degrees := []float64{}
	for deg := range asteroids {
		seen_degrees = append(seen_degrees, deg)
	}
	sort.Slice(seen_degrees, func(i, j int) bool {
		return seen_degrees[i] < seen_degrees[j]
	})

	var blasted Vector

	for iteration := 0; iteration < max_iterations; {
		for _, degrees := range seen_degrees {
			slice := asteroids[degrees]

			if len(slice) == 0 {
				delete(asteroids, degrees)
				continue
			}

			head, tail := slice[0], slice[1:]
			asteroids[degrees] = tail

			p := head.toPoint()

			graphics[p.Y][p.X] = "."

			blasted = head
			iteration += 1
			if iteration >= max_iterations {
				break
			}
		}
	}
	// while iterations > 0
	// iterate through the asteroids
	// take that one out
	// return the last one we blasted (so I started blastin')
	return blasted.toPoint()
}

// pragma mark - debug
func prettyprint(grid [][]string, iteration int, degrees float64, vec Vector) {
	// fmt.Printf("\033[0;0H")

	point := vec.toPoint()
	println(fmt.Sprintf("iteration %d | asteroid (%d, %d) | degrees %v | length %v", iteration, point.X, point.Y, degrees, vec_to_length(vec)))
	return

	for _, row := range grid {
		for _, col := range row {
			print(col)
		}
		println()
	}
}

// pragma mark - private

func makeVector(origin Point, x, y int) Vector {
	return Vector{
		oX: x,
		oY: y,
		X:  x - origin.X,
		Y:  origin.Y - y,
	}
}

func vec_to_degrees(vector Vector) float64 {
	result := math.Atan2(float64(vector.X), float64(vector.Y)) * 180 / math.Pi

	if vector.X < 0 {
		return result + 360
	} else {
		return result
	}
}

func vec_to_length(vector Vector) float64 {
	return math.Sqrt(math.Pow(float64(vector.X), 2) + math.Pow(float64(vector.Y), 2))
}

func (v Vector) toPoint() Point {
	return Point{X: v.oX, Y: v.oY}
}
