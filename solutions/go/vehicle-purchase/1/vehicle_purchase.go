package purchase

func NeedsLicense(kind string) bool {
	return kind == "car" || kind == "truck"
}

func ChooseVehicle(option1, option2 string) string {
	var choice string

	if option1 <= option2 {
		choice = option1
	} else {
		choice = option2
	}

	return choice + " is clearly the better choice."
}

func CalculateResellPrice(originalPrice, age float64) float64 {
	var mul float64

	if age >= 10 {
		mul = 0.5
	} else if age >= 3 {
		mul = 0.7
	} else {
		mul = 0.8
	}

	return originalPrice * mul
}
