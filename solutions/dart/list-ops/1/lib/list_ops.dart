extension ListOps on List {
  void append<T>(List<T> other) {
    for (var item in other) {
      this.add(item);
    }
  }

  List<T> concat<T>() {
    var result = <T>[];

    for (var item in this) {
      result.append(item);
    }

    return result;
  }

  List<T> filter<T>(bool Function(T elem) predicate) {
    var result = <T>[];

    for (var item in this) {
      if (predicate(item)) {
        result.add(item);
      }
    }

    return result;
  }

  int count() {
    var len = 0;

    for (var _ in this) {
      len++;
    }

    return len;
  }

  List<T> myMap<T>(T Function(T elem) fn) {
    var result = <T>[];

    for (var item in this) {
      result.add(fn(item));
    }

    return result;
  }

  U foldl<T, U>(U initial, U Function(U acc, T elem) fn) {
    for (var item in this) {
      initial = fn(initial, item);
    }

    return initial;
  }

  U foldr<T, U>(U initial, U Function(T elem, U acc) fn) {
    for (var item in this.reverse()) {
      initial = fn(item, initial);
    }

    return initial;
  }

  List<T> reverse<T>() {
    var result = <T>[];

    for (var i = this.count() - 1; i >= 0; i--) {
      result.add(this[i]);
    }

    return result;
  }
}
