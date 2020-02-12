from Sentence import Sentence
from Word import Word

KB = []  # array of Sentence
a = Sentence()
nega_of_a = []  # array of Sentence


def read_input():
    input_file = open("input.txt", "r")
    line1 = input_file.readline().rstrip("\n").split("OR")
    for i in line1:
        a.add_word(Word(i.strip()))

    num = int(input_file.readline())
    for i in range(num):
        line = input_file.readline().rstrip("\n").split("OR")
        new_sen = Sentence()
        for j in line:
            new_sen.add_word(Word(j.strip()))
        KB.append(new_sen)


def get_nega_of_a():
    for i in range(a.get_len()):
        nega_of_a.append(a.get_nega_to_sentence(i))


def is_contain(sentence, sentences):
    for i in sentences:
        if i == sentence:
            return True
    return False


def is_child(new_sentences, sentences):
    for i in new_sentences:
        if not is_contain(i, sentences):
            return False
    return True


def PL_resolution():
    sentences = KB + nega_of_a
    new_sentences = []
    f = open("output.txt", "w")

    while True:
        printed_sentences = []
        for i in range(len(sentences)):
            for j in range(i + 1, len(sentences)):
                result_resolution = sentences[i].resolution(sentences[j])

                for k in result_resolution:
                    if not is_contain(k, sentences) and not is_contain(k, new_sentences):
                        printed_sentences.append(k)
                        new_sentences.append(k)

                # if result_resolution contains any empty sentence, return True
                for k in result_resolution:
                    if k.is_empty():
                        print(len(printed_sentences))
                        f.write(str(len(printed_sentences)) + "\n")
                        for p in printed_sentences:
                            print(p.to_string())
                            f.write(p.to_string() + "\n")
                        f.write("YES\n")
                        f.close()
                        return True

        print(len(printed_sentences))
        f.write(str(len(printed_sentences)) + "\n")
        for k in printed_sentences:
            print(k.to_string())
            f.write(k.to_string() + "\n")

        # if new_sentences is child of sentences, return False
        if is_child(new_sentences, sentences):
            f.write("NO\n")
            f.close()
            return False

        for i in new_sentences:
            if not is_contain(i, sentences):
                sentences.append(i)


if __name__ == "__main__":
    read_input()

    print(a.to_string())
    for i in KB:
        print(i.to_string())
    print("______________")

    get_nega_of_a()
    if PL_resolution():
        print("YES")
    else:
        print("NO")