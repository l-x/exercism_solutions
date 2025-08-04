EAST = "e"
NORTH = "n"
WEST = "w"
SOUTH = "s"

def advance(coordinates, direction):
      match direction:
        case "e": 
            return (coordinates[0] + 1, coordinates[1])
        case "n": 
            return (coordinates[0], coordinates[1] + 1)        
        case "w": 
            return (coordinates[0] - 1, coordinates[1])
        case "s": 
            return (coordinates[0], coordinates[1] - 1)          

def turn_left(direction):
    match direction:
        case "e": 
            return NORTH
        case "n": 
            return WEST        
        case "w": 
            return SOUTH
        case "s": 
            return EAST

def turn_right(direction):
    match direction:
        case "e": 
            return SOUTH
        case "n": 
            return EAST        
        case "w": 
            return NORTH
        case "s": 
            return WEST


class Robot:
    def __init__(self, direction=NORTH, x_pos=0, y_pos=0):
        self.direction = direction
        self.coordinates = (x_pos, y_pos)

    def move(self, cmd):
        for c in cmd:
            self._move_one(c)
        

    def _move_one(self, cmd):
        match cmd:
            case "A": 
                self.coordinates = advance(self.coordinates, self.direction)
            case "L": 
                self.direction = turn_left(self.direction)
            case "R": 
                self.direction = turn_right(self.direction)
        