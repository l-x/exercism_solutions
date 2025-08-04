package queenattack

import (
	"errors"
	"fmt"
	"strings"
)

const cols = "abcdefgh"

type Position struct {
	row, col uint8
}

func (p Position) CanAttack(o Position) bool {
	return p.col == o.col || p.row == p.row
}

func CanQueenAttack(whitePosition, blackPosition string) (bool, error) {
	if whitePosition == blackPosition {
		return false, errors.New("")
	}

	wp, err := numericPosition(whitePosition)
	if err != nil {
		return false, err
	}

	bp, err := numericPosition(blackPosition)
	if err != nil {
		return false, err
	}

	canAttack := wp.col == bp.col || wp.row == bp.row || diff(wp.row, bp.row) == diff(wp.col, bp.col)

	return canAttack, nil
}

func diff(a, b uint8) uint8 {
	if a < b {
		return b - a
	}

	return a - b
}

func numericPosition(position string) (*Position, error) {
	var colV rune
	var rowV uint8

	_, err := fmt.Sscanf(position, "%c%d", &colV, &rowV)
	if err != nil {
		return nil, err
	}

	row := rowV - 1
	if row < 0 || row > 7 {
		return nil, errors.New("")
	}

	col := uint8(strings.Index(cols, string(colV)))
	if col < 0 || col > 7 {
		return nil, errors.New("")
	}

	return &Position{col, row}, nil
}
