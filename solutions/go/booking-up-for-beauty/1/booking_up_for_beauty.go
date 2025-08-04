package booking

import "time"

func parseDate(date, layout string) time.Time {
	t, err := time.Parse(layout, date)

	if err != nil {
		panic(err)
	}

	return t
}

func Schedule(date string) time.Time {
	return parseDate(date, "1/02/2006 15:04:05")
}

func HasPassed(date string) bool {
	return parseDate(date, "January 2, 2006 15:04:05").Before(time.Now())
}

func IsAfternoonAppointment(date string) bool {
	hour := parseDate(date, "Monday, January 2, 2006 15:04:05").Hour()

	return hour >= 12 && hour < 18
}

func Description(date string) string {
	return parseDate(date, "1/2/2006 15:04:05").Format("You have an appointment on Monday, January 2, 2006, at 15:04.")
}

func AnniversaryDate() time.Time {
	return time.Date(time.Now().Year(), time.September, 15, 0, 0, 0, 0, time.UTC)
}
