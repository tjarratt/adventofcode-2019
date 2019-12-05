package main

import (
	"fmt"
	"io/ioutil"
	"os"
	"strconv"
	"strings"
)

type NounVerbPair struct {
	Noun int
	Verb int
}

type Result struct {
	Noun   int
	Verb   int
	Result int
}

type Program []int

func main() {
	result_chan := make(chan Result, 99*99)
	program := read_program_from("input.txt")

	for noun := 0; noun <= 99; noun++ {
		for verb := 0; verb <= 99; verb++ {
			pair := NounVerbPair{Noun: noun, Verb: verb}
			program_copy := make(Program, len(program))
			copy(program_copy, program)

			go evaluate_intcode(pair, program_copy, result_chan)
		}
	}

	for {
		result := <-result_chan
		if result.Result == 19690720 {
			println(fmt.Sprintf("HOLY SHIT WE FOUND IT BOIZ %#v", result))

			println("answer is :: ", result.Noun*100+result.Verb)
			os.Exit(0)
		}
	}
}

func evaluate_intcode(input NounVerbPair, program Program, channel chan<- Result) {
	eval_index := 0

	program[1] = input.Noun
	program[2] = input.Verb

	for {
		op := program[eval_index]

		switch {
		case op == 1:
			noun := program[eval_index+1]
			verb := program[eval_index+2]
			addr := program[eval_index+3]

			a := program[noun]
			b := program[verb]

			program[addr] = a + b

		case op == 2:
			noun := program[eval_index+1]
			verb := program[eval_index+2]
			addr := program[eval_index+3]

			x := program[noun]
			y := program[verb]

			program[addr] = x * y
		case op == 99:
			channel <- Result{
				Noun:   input.Noun,
				Verb:   input.Verb,
				Result: program[0],
			}

			return
		default:
			panic(fmt.Sprintf("unknown op code : %d", op))
		}

		eval_index += 4
	}
}

func read_program_from(filename string) Program {
	file, err := os.Open(filename)
	if err != nil {
		panic(err)
	}

	bytes, err := ioutil.ReadAll(file)
	if err != nil {
		panic(err)
	}

	str := string(bytes)
	codes := strings.Split(str, ",")

	program := make(Program, 0, len(codes))
	for _, code := range codes {
		i, err := strconv.Atoi(code)
		if err != nil {
			panic(err)
		}
		program = append(program, i)
	}

	return program
}
