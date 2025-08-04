package expenses

import "errors"

// Record represents an expense record.
type Record struct {
	Day      int
	Amount   float64
	Category string
}

// DaysPeriod represents a period of days for expenses.
type DaysPeriod struct {
	From int
	To   int
}

func Filter(in []Record, predicate func(Record) bool) (result []Record) {
	for _, r := range in {
		if predicate(r) {
			result = append(result, r)
		}
	}

	return
}

func ByDaysPeriod(p DaysPeriod) func(Record) bool {
	return func(r Record) bool {
		return r.Day >= p.From && r.Day <= p.To
	}
}

func ByCategory(c string) func(Record) bool {
	return func(r Record) bool {
		return r.Category == c
	}
}

func TotalByPeriod(in []Record, p DaysPeriod) (total float64) {
	for _, r := range Filter(in, ByDaysPeriod(p)) {
		total += r.Amount
	}

	return
}

func CategoryExpenses(in []Record, p DaysPeriod, c string) (float64, error) {
	in = Filter(in, ByCategory(c))
	if len(in) == 0 {
		return 0, errors.New("WRONG!")
	}

	return TotalByPeriod(in, p), nil
}
