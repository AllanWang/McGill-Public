# coding=utf-8
from nltk.grammar import CFG
from nltk.parse.chart import BottomUpChartParser

# Replace with your file name here
filename = "a2q2.txt"

with open(filename) as f:
    content = f.read()
    # Spent too long on this and gave up; I just manually converted accents within the grammar file
    content = content.replace('é', 'e').replace('è', 'e').replace('ê', 'e') \
        .replace('á', 'a').replace('à', 'a').replace('â', 'a') \
        .replace('ó', 'o').replace('ò', 'o').replace('ô', 'o')
    grammar = CFG.fromstring(content, encoding="utf-8")

parser = BottomUpChartParser(grammar)


def parse(sentence, nonempty):
    trees = parser.parse(sentence.lower().split())
    data = list(trees)
    if nonempty:
        print(data)
        assert len(data) > 0
    else:
        assert len(data) == 0


validSentences = [
    "Jackie mange",
    "Je regarde la television",
    "Tu regardes la television",
    "Il regarde la television",
    "Nous regardons la television",
    "Vous regardez la television",
    "Ils regardent la television",
    "Je le regarde",
    "Je les regarde",
    "Je la regarde",
    "le chat mange",
    "la television mange",
    "les chats mangent",
    "les televisions mangent",
    "Jackie mange",
    "Montreal mange",
    "les chats mangent le poisson"
]

invalidSentences = [
    "le chat",
    "je mangent le poisson",
    "les noirs chats mangent le poisson",
    "la poisson mangent les chats",
    "je mange les"
]

print("Testing valid sentences...\n\n\n")

for valid in validSentences:
    print(valid)
    parse(valid, True)

print("Testing invalid sentences...\n\n\n")

for invalid in invalidSentences:
    print(invalid)
    parse(invalid, False)
