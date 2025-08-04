final class Queen {
  int row;
  int col;

  Queen(int this.row, int this.col) {
    assert(row >= 0, 'row not positive');
    assert(row <= 7, 'row not on board');
    assert(col >= 0, 'column not positive');
    assert(col <= 7, 'column not on board');
  }

  bool canAttack(Queen other) {
    return row == other.row ||
        col == other.col ||
        (row - other.row).abs() == (col - other.col).abs();
  }
}
