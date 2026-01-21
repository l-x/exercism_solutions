package stringset

import (
	"fmt"
	"strings"
)

type Set map[string]struct{}

func New() Set {
	return Set{}
}

func NewFromSlice(l []string) Set {
	set := New()
	for _, elem := range l {
		set.Add(elem)
	}
	return set
}

func (s Set) String() string {
	elems := make([]string, 0, len(s))

	for elem := range s {
		elems = append(elems, fmt.Sprintf("\"%s\"", elem))
	}

	return fmt.Sprintf("{%s}", strings.Join(elems, ", "))
}

func (s Set) IsEmpty() bool {
	return len(s) == 0
}

func (s Set) Has(elem string) bool {
	_, ok := s[elem]

	return ok
}

func (s Set) Add(elem string) {
	s[elem] = struct{}{}
}

func Subset(s1, s2 Set) bool {
	for elem := range s1 {
		if !s2.Has(elem) {
			return false
		}
	}

	return true
}

func Disjoint(s1, s2 Set) bool {
	for elem := range s1 {
		if s2.Has(elem) {
			return false
		}
	}

	return true
}

func Equal(s1, s2 Set) bool {
	if len(s1) != len(s2) {
		return false
	}

	for elem := range s1 {
		if !s2.Has(elem) {
			return false
		}
	}

	return true
}

func Intersection(s1, s2 Set) Set {
	set := New()

	for elem := range s1 {
		if s2.Has(elem) {
			set.Add(elem)
		}
	}

	return set
}

func Difference(s1, s2 Set) Set {
	set := New()

	for elem := range s1 {
		if !s2.Has(elem) {
			set.Add(elem)
		}
	}

	return set
}

func Union(s1, s2 Set) Set {
	set := New()

	for elem := range s1 {
		set.Add(elem)
	}

	for elem := range s2 {
		set.Add(elem)
	}

	return set
}
