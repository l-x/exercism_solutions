package sorting

import (
	"fmt"
	"strconv"
)

func DescribeNumber(f float64) string {
	return fmt.Sprintf("This is the number %.1f", f)
}

type NumberBox interface {
	Number() int
}

func DescribeNumberBox(nb NumberBox) string {
	return fmt.Sprintf("This is a box containing the number %d.0", nb.Number())
}

type FancyNumber struct {
	n string
}

func (i FancyNumber) Value() string {
	return i.n
}

type FancyNumberBox interface {
	Value() string
}

func ExtractFancyNumber(fnb FancyNumberBox) int {
	fn, ok := fnb.(FancyNumber)
	if !ok {
		return 0
	}

	x, err := strconv.Atoi(fn.Value())
	if err != nil {
		return 0
	}

	return x
}

func DescribeFancyNumberBox(fnb FancyNumberBox) string {
	return fmt.Sprintf("This is a fancy box containing the number %d.0", ExtractFancyNumber(fnb))
}

func DescribeAnything(i any) string {
	switch x := i.(type) {
	case float64:
		return DescribeNumber(x)
	case int:
		return DescribeNumber(float64(x))
	case NumberBox:
		return DescribeNumberBox(x)
	case FancyNumberBox:
		return DescribeFancyNumberBox(x)
	}

	return "Return to sender"
}
