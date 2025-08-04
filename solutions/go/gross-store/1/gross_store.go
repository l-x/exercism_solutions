package gross

var units = map[string]int{
	"quarter_of_a_dozen": 3,
	"half_of_a_dozen":    6,
	"dozen":              12,
	"small_gross":        120,
	"gross":              144,
	"great_gross":        1728,
}

func Units() map[string]int {
	return units
}

func NewBill() map[string]int {
	return make(map[string]int)
}

func AddItem(bill, units map[string]int, item, unit string) bool {
	if quantity, ok := units[unit]; ok {
		bill[item] += quantity
		return true
	}

	return false

}

func RemoveItem(bill, units map[string]int, item, unit string) bool {
	if _, ok := bill[item]; !ok {
		return false
	}

	quantity, ok := units[unit]
	if !ok {
		return false
	}

	if bill[item] < quantity {
		return false
	}

	bill[item] -= quantity

	if bill[item] == 0 {
		delete(bill, item)
	}

	return true
}

func GetItem(bill map[string]int, item string) (quantity int, ok bool) {
	quantity, ok = bill[item]
	return
}
