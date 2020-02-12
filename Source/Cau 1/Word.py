
class Word:
    def __init__(self, string):
        if len(string) == 1:
            self.character = string
            self.positive = True
        else:
            self.character = string[1]
            self.positive = False

    def to_string(self):
        if self.positive:
            return self.character
        else:
            return "-" + self.character

    def get_nega(self):
        if self.positive:
            nega = Word("-" + self.character)
        else:
            nega = Word(self.character)
        return nega

    def __lt__(self, other):
        if self.character == other.character:
            return self.positive
        else:
            return self.character < other.character

    def __eq__(self, other):
        return self.character == other.character and self.positive == other.positive

    def isEqualInCharacter(self, other):
        return self.character == other.character