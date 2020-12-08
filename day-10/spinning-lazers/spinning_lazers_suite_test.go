package spinning_lazers_test

import (
	"testing"

	. "github.com/onsi/ginkgo"
	. "github.com/onsi/gomega"
)

func TestSpinningLazers(t *testing.T) {
	RegisterFailHandler(Fail)
	RunSpecs(t, "SpinningLazers Suite")
}
