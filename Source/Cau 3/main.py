import Database
import argparse
from Datatype import Rule, Fact
from Query import Query

def readFile(fileName):
    factsTemp = []
    with open(fileName) as f:
        lines = ''.join(f.readlines())
        lines = lines.replace('\n', '').replace(' ', '').replace('.', ' ').split()
        for line in lines:
            if ':-' in line:
                try:
                    Rule(line)
                except:
                    print('Error: parse ', line, ' into Rule')
            else:
                try:
                    fact = Fact(line)
                    Database.universe.update(fact.insts)
                    factsTemp.append(fact)
                except:
                    print('Error: parse ', line, ' into Fact')
    for fact in factsTemp:
        fact.activate()

def runCMD():
    while True:
        question = input('?- ')
        if question == 'halt':
            break
        try:
            question = Query(question)
            subs = question.getAns()
            if subs:
                print(*subs, sep = '\n')
            print(len(subs) > 0)
        except:
            print('Wrong query')

def parse_args():
    parser = argparse.ArgumentParser("Prolog in Python")
    parser.add_argument("--input", help="Input file path ", default="input.pl")
    args = parser.parse_args()
    return args

if __name__ == "__main__":
    args = parse_args()
    input_path = args.input
    readFile(input_path)
    runCMD()