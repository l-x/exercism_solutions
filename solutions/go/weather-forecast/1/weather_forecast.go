// Package weather, whatever.
package weather

// CurrentCondition guess what.
var CurrentCondition string

// CurrentLocation oh c'mon.
var CurrentLocation string

// Forecast yeah.
func Forecast(city, condition string) string {
	CurrentLocation, CurrentCondition = city, condition
	return CurrentLocation + " - current weather condition: " + CurrentCondition
}
