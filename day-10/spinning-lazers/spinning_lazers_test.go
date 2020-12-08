package spinning_lazers_test

import (
	"fmt"
	"io/ioutil"

	. "github.com/onsi/ginkgo"
	. "github.com/onsi/gomega"

	. "github.com/tjarratt/advent-of-code/2019/day-10/spinning-lazers"
)

var _ = Describe("Spinning Lazer Solver", func() {
	It("can find the first asteroid to demolish", func() {
		input := fixtureNamed("1.txt")
		point := Point{X: 8, Y: 3}

		subject := SpinningLazerSolver(input, point)

		Expect(subject.Solve(1)).To(Equal(Point{X: 8, Y: 1}))
	})

	It("can find the last asteroid to demolish", func() {
		input := fixtureNamed("1.txt")
		point := Point{X: 8, Y: 3}

		subject := SpinningLazerSolver(input, point)

		Expect(subject.Solve(9)).To(Equal(Point{X: 15, Y: 1}))
	})

	It("can find all the asteroids to demolish", func() {
		input := fixtureNamed("1.txt")
		point := Point{X: 8, Y: 3}

		subject := SpinningLazerSolver(input, point)

		asteroids := []Point{}
		for i := 1; i < 10; i++ {
			asteroids = append(asteroids, subject.Solve(i))
		}

		Expect(asteroids).To(Equal([]Point{
			Point{X: 8, Y: 1},
			Point{X: 9, Y: 0},
			Point{X: 9, Y: 1},
			Point{X: 10, Y: 0},
			Point{X: 9, Y: 2},
			Point{X: 11, Y: 1},
			Point{X: 12, Y: 1},
			Point{X: 11, Y: 2},
			Point{X: 15, Y: 1},
		}))
	})

	It("handles a larger case with ease", func() {
		input := fixtureNamed("large.txt")
		point := Point{X: 11, Y: 13}

		subject := SpinningLazerSolver(input, point)

		asteroids := []Point{}
		for i := 1; i < 300; i++ {
			asteroids = append(asteroids, subject.Solve(i))
		}

		Expect(asteroids[0]).To(Equal(Point{X: 11, Y: 12}))
		Expect(asteroids[1]).To(Equal(Point{X: 12, Y: 1}))
		Expect(asteroids[2]).To(Equal(Point{X: 12, Y: 2}))

		Expect(asteroids[9]).To(Equal(Point{X: 12, Y: 8}))
		Expect(asteroids[19]).To(Equal(Point{X: 16, Y: 0}))
		Expect(asteroids[49]).To(Equal(Point{X: 16, Y: 9}))

		Expect(asteroids[99]).To(Equal(Point{X: 10, Y: 16}))
		Expect(asteroids[198]).To(Equal(Point{X: 9, Y: 6}))
		Expect(asteroids[199]).To(Equal(Point{X: 8, Y: 2}))
		Expect(asteroids[200]).To(Equal(Point{X: 10, Y: 9}))
		Expect(asteroids[298]).To(Equal(Point{X: 11, Y: 1}))
	})
})

func fixtureNamed(name string) string {
	bytes, err := ioutil.ReadFile(fmt.Sprintf("fixtures/%s", name))
	if err != nil {
		panic(err)
	}

	return string(bytes)
}
