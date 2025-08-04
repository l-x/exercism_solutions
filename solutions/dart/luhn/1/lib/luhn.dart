final class Luhn {
  bool valid(String value) {
    value = value.replaceAll(RegExp(r' '), '');
    if (value == '0') {
      return false;
    }

    var sum = 0;

    for ((int, int) digit in value.runes.toList().reversed.indexed) {
      var v = digit.$2.toInt() - 48;

      if (v < 0 || v > 9) {
        return false;
      }

      if (digit.$1 % 2 == 0) {
        sum += v;
      } else if (v < 5) {
        sum += v * 2;
      } else {
        sum += v * 2 - 9;
      }
    }

    return sum % 10 == 0;
  }
}
