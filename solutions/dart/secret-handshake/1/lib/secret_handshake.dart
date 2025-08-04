final class SecretHandshake {
  static const comand_list = [
    (1, 'wink'),
    (2, 'double blink'),
    (4, 'close your eyes'),
    (8, 'jump'),
  ];

  List<String> commands(int code) {
    List<String> cmds = [];

    for (var cmd_map in comand_list) {
      if (code & cmd_map.$1 != 0) {
        cmds.add(cmd_map.$2);
      }
    }

    if (code & 16 != 0) {
      cmds = cmds.reversed.toList();
    }

    return cmds;
  }
}
