import 'orientation.dart';
import 'position.dart';

class Robot {
  Position position;
  Orientation orientation;

  Robot(
    Position this.position,
    Orientation this.orientation,
  );

  void move(String cmds) {
    cmds.split('').forEach(this._move);
  }

  void _move(String cmd) {
    if (cmd == 'A') {
      _advance();
    } else if (cmd == 'L') {
      _turnLeft();
    } else if (cmd == 'R') {
      _turnRight();
    }
  }

  void _turnLeft() {
    this.orientation = switch (this.orientation) {
      Orientation.north => Orientation.west,
      Orientation.west => Orientation.south,
      Orientation.south => Orientation.east,
      Orientation.east => Orientation.north,
    };
  }

  void _turnRight() {
    this.orientation = switch (this.orientation) {
      Orientation.north => Orientation.east,
      Orientation.east => Orientation.south,
      Orientation.south => Orientation.west,
      Orientation.west => Orientation.north,
    };
  }

  void _advance() {
    this.position = switch (this.orientation) {
      Orientation.north => Position(this.position.x, this.position.y + 1),
      Orientation.east => Position(this.position.x + 1, this.position.y),
      Orientation.south => Position(this.position.x, this.position.y - 1),
      Orientation.west => Position(this.position.x - 1, this.position.y),
    };
  }
}
