class AtbashCipher {
  Map<String, String> atbashCipherMap = {
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

  String encode(String plainText) {
    String cleanedText =
        plainText.toLowerCase().replaceAll(RegExp(r'[^a-z]'), '');

    List<String> encodedChars = [];
    for (var char in cleanedText.split('')) {
      if (atbashCipherMap.containsKey(char)) {
        encodedChars.add(atbashCipherMap[char]!);
      }
    }

    return encodedChars
        .join()
        .replaceAllMapped(RegExp(r'.{1,5}'), (match) => '${match.group(0)} ')
        .trim();
  }

  String decode(String cipherText) {
    String decodedChars = '';
    for (var char in cipherText.replaceAll(' ', '').split('')) {
      if (atbashCipherMap.containsKey(char)) {
        decodedChars += atbashCipherMap.keys
            .firstWhere((key) => atbashCipherMap[key] == char);
      }
    }

    return decodedChars;
  }
}
