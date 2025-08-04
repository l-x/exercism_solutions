bool isValid(String isbn) {
  final pattern = RegExp(r'^\d-?\d{3}-?\d{5}-?[\d|X]$', caseSensitive: false);

  if (!pattern.hasMatch(isbn)) {
    return false;
  }

  final digits = isbn
      .replaceAll(RegExp(r'-'), '')
      .runes
      .map((i) => switch (i) { 88 => 10, int c => c - 48 })
      .indexed;

  var sum = 0;

  for (var digit in digits) {
    sum += (digit.$1 - 10).abs() * digit.$2;
  }

  return sum % 11 == 0;
}
