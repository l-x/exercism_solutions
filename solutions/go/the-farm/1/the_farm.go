package thefarm

import (
	"errors"
	"fmt"
)

func DivideFood(fodderCalculator FodderCalculator, numCows int) (float64, error) {
	if err := ValidateNumberOfCows(numCows); err != nil {
		return 0, err
	}

	totalFodder, err := fodderCalculator.FodderAmount(numCows)
	if err != nil {
		return 0, err
	}

	fatteningFactor, err := fodderCalculator.FatteningFactor()
	if err != nil {
		return 0, err
	}

	fodderPerCow := (totalFodder * fatteningFactor) / float64(numCows)
	return fodderPerCow, nil
}

func ValidateInputAndDivideFood(fodderCalculator FodderCalculator, numCows int) (float64, error) {
	err := ValidateNumberOfCows(numCows)
	if err != nil {
		return 0, errors.New("invalid number of cows")
	}

	return DivideFood(fodderCalculator, numCows)
}

type InvalidCowsError struct {
	CowCount int
	Message  string
}

func (e *InvalidCowsError) Error() string {
	return fmt.Sprintf("%d cows are invalid: %s", e.CowCount, e.Message)
}

func ValidateNumberOfCows(numCows int) error {
	switch {
	case numCows < 0:
		return &InvalidCowsError{CowCount: numCows, Message: "there are no negative cows"}
	case numCows == 0:
		return &InvalidCowsError{CowCount: numCows, Message: "no cows don't need food"}
	default:
		return nil
	}
}
