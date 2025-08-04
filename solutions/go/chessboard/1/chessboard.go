package chessboard

type File []bool

func (f File) Occupied() (count int) {
	for _, v := range f {
		if v {
			count++
		}
	}

	return
}

type Chessboard map[string]File

func CountInFile(cb Chessboard, file string) (count int) {
	for _, o := range cb[file] {
		if o == true {
			count++
		}
	}

	return
}

func CountInRank(cb Chessboard, rank int) (count int) {
	if rank < 1 || rank > 8 {
		return
	}

	for _, file := range cb {
		if file[rank-1] {
			count++
		}
	}

	return
}

func CountAll(cb Chessboard) (count int) {
	for _, file := range cb {
		count += len(file)
	}

	return
}

func CountOccupied(cb Chessboard) (count int) {
	for _, file := range cb {
		count += file.Occupied()
	}

	return
}
