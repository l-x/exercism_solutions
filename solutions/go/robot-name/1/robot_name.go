package robotname

import (
	"errors"
	"fmt"
	"math/rand"
)

var randomNames = make(chan string, 26*26*1000)

type Robot struct {
	name string
	err  error
}

func (r *Robot) Name() (string, error) {
	if r.name == "" {
		r.Reset()
	}

	return r.name, r.err
}

func (r *Robot) Reset() {
	var ok bool

	r.name, ok = <-randomNames
	if !ok {
		r.err = errors.New("no names left")
	}
}

func init() {
	go func() {
		defer close(randomNames)
		names := [26 * 26 * 1000]string{}
		i := 0
		for a1 := 0; a1 < 26; a1++ {
			v1 := rune('A' + a1)
			for a2 := 0; a2 < 26; a2++ {
				v2 := rune('A' + a2)
				for nr := 0; nr < 1000; nr++ {
					names[i] = fmt.Sprintf("%c%c%03d", v1, v2, nr)
					i++
				}
			}
		}

		rand.Shuffle(len(names), func(i, j int) {
			names[i], names[j] = names[j], names[i]
		})

		for _, name := range names {
			randomNames <- name
		}
	}()
}
