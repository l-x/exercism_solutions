package parsinglogfiles

import (
	"fmt"
	"regexp"
	"strings"
)

func IsValidLine(text string) bool {
	return regexp.
		MustCompile(`^\[(ERR|INF)\]\s(.*)$`).
		MatchString(text)
}

func SplitLogLine(text string) []string {
	return regexp.
		MustCompile(`<[=\-\*~]*>`).
		Split(text, -1)
}

func CountQuotedPasswords(lines []string) int {
	return len(regexp.
		MustCompile(`".*?password.*?"`).
		FindStringIndex(strings.Join(lines, "")),
	)
}

func RemoveEndOfLineText(text string) string {
	return regexp.
		MustCompile(`end-of-line\d+`).
		ReplaceAllString(text, "")
}

func TagWithUserName(lines []string) (result []string) {
	pattern := regexp.MustCompile(`User\s+(\w+)`)

	for _, line := range lines {
		result = append(result, tagWithUserName(line, pattern))
	}

	return
}

func tagWithUserName(line string, pattern *regexp.Regexp) string {
	if user := pattern.FindStringSubmatch(line); user != nil {
		return fmt.Sprintf("[USR] %s %s", user[1], line)
	} else {
		return line
	}
}
