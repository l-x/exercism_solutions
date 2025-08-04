package blackjack

func ParseCard(card string) int {
	switch card {
	case "ace":
		return 11
	case "ten", "jack", "queen", "king":
		return 10
	case "nine":
		return 9
	case "eight":
		return 8
	case "seven":
		return 7
	case "six":
		return 6
	case "five":
		return 5
	case "four":
		return 4
	case "three":
		return 3
	case "two":
		return 2
	default:
		return 0
	}
}

func FirstTurn(card1, card2, dealerCard string) string {
	value1 := ParseCard(card1)
	value2 := ParseCard(card2)
	totalValue := value1 + value2
	dealerValue := ParseCard(dealerCard)

	if card1 == card2 && card1 == "ace" {
		return "P"
	}

	if totalValue == 21 {
		if dealerValue < 10 {
			return "W"
		} else {
			return "S"
		}
	}

	if totalValue >= 17 && totalValue <= 20 {
		return "S"
	}

	if totalValue >= 12 && totalValue <= 16 && dealerValue < 7 {
		return "S"
	}

	return "H"
}
