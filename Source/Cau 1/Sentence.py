class Sentence:
    def __init__(self):
        self.content = []

    def add_word(self, word):
        if not self.is_exist(word):
            self.content.append(word)
            self.content.sort()

    def resolution(self, other):
        sentences = []
        for i in self.content:
            nega = i.get_nega()
            if other.is_exist(nega):
                sen = Sentence()
                for j in self.content:
                    if j == i:
                        continue
                    sen.add_word(j)
                for j in other.content:
                    if j == nega:
                        continue
                    sen.add_word(j)

                if sen.is_make_sense():
                    sentences.append(sen)
        return sentences

    def to_string(self):
        if len(self.content) == 0:
            return "{}"
        else:
            string = self.content[0].to_string()
        for i in range(1, len(self.content)):
            string += " OR " + self.content[i].to_string()
        return string

    def get_nega_to_sentence(self, i):
        word = self.content[i].get_nega()
        sentence = Sentence()
        sentence.add_word(word)
        return sentence

    def get_len(self):
        return len(self.content)

    def is_make_sense(self):
        for i in range(len(self.content) - 1):
            if self.content[i].isEqualInCharacter(self.content[i + 1]):
                return False
        return True

    def is_empty(self):
        return len(self.content) == 0

    def __eq__(self, other):
        if len(self.content) != len(other.content):
            return False
        for i in range(len(self.content)):
            if not self.content[i] == other.content[i]:
                return False
        return True

    def is_exist(self, word):
        for i in self.content:
            if i == word:
                return True
        return False

    def get_index(self, word):
        for i in range(len(self.content)):
            if self.content[i] == word:
                return i
        return -1