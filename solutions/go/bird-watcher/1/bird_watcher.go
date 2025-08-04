package birdwatcher

func TotalBirdCount(birdsPerDay []int) int {
	var count int

	for _, birds := range birdsPerDay {
		count += birds
	}

	return count
}

func BirdsInWeek(birdsPerDay []int, week int) int {
	var count int

	for _, birds := range birdsPerDay[(week-1)*7 : week*7] {
		count += birds
	}

	return count
}

func FixBirdCountLog(birdsPerDay []int) []int {
	for i, _ := range birdsPerDay {
		if i%2 == 0 {
			birdsPerDay[i]++
		}
	}

	return birdsPerDay
}
