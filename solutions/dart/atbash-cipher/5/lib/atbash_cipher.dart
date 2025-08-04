extension AtbashCipherExtension on String {
  Map<String, String> get _cipherMap {
    return {
      'a': 'z',
      'b': 'y',
      'c': 'x',
      'd': 'w',
      'e': 'v',
      'f': 'u',
      'g': 't',
      'h': 's',
      'i': 'r',
      'j': 'q',
      'k': 'p',
      'l': 'o',
      'm': 'n',
      'n': 'm',
      'o': 'l',
      'p': 'k',
      'q': 'j',
      'r': 'i',
      's': 'h',
      't': 'g',
      'u': 'f',
      'v': 'e',
      'w': 'd',
      'x': 'c',
      'y': 'b',
      'z': 'a'
    };
  }

  String atbashDecode() {
    return this
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9]'), '')
        .replaceAllMapped(RegExp(r'[a-z]'), (m) => _cipherMap[m.group(0)]!);
  }

  String atbashEncode() {
    return atbashDecode()
        .splitMapJoin(RegExp(r'.{5}'), onMatch: (m) => '${m.group(0)} ')
        .trim();
  }
}

final class AtbashCipher {
  String encode(String plainText) => plainText.atbashEncode();
  String decode(String cipherText) => cipherText.atbashDecode();
}
