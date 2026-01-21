package leap

// IsLeapYear determines if a given year is a leap year.
//
// A leap year occurs every 4 years, except for
// years divisible by 100 but not by 400.
func IsLeapYear(year int) bool {
	if year%400 == 0 {
		return true
	}

	if year%100 == 0 {
		return false
	}

	if year%4 == 0 {
		return true
	}

	return false
}
