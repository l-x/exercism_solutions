package logs

import "unicode/utf8"

func Application(log string) string {
	for _, r := range log {
		if r == '❗' {
			return "recommendation"
		}
		if r == '🔍' {
			return "search"
		}
		if r == '☀' {
			return "weather"
		}
	}

	return "default"
}

func Replace(log string, oldRune, newRune rune) string {
	var result string

	for _, rune := range log {
		if rune == oldRune {
			result += string(newRune)
		} else {
			result += string(rune)
		}
	}

	return result
}

func WithinLimit(log string, limit int) bool {
	return utf8.RuneCountInString(log) <= limit
}
