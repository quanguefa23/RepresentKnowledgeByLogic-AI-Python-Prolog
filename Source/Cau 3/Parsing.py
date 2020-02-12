import re

import Datatype

# The following class implements a parser we use to parse our Prolog programs / queries.
class Parsing:
    @staticmethod
    def getFunctor(s):
        return s[: s.index("(")]

    @staticmethod
    def getRulesName(s):
        return s.split(":-")[0]

    @staticmethod
    def getArguments(s):
        s = s.replace(" ", "").replace(".", "").split(":-")[0]
        args = s[s.index("(") + 1 :].replace(")", "").replace(",", " ").split()
        return args

    @staticmethod
    def getTerm(s):
        s = s.replace(".", "").replace(" ", "").split(":-")[1]
        terms = s.split("),")
        terms[-1] = terms[-1].replace(")", "")
        terms = [term + ")" for term in terms]
        terms = [Datatype.Term(term) for term in terms]
        return terms

    @staticmethod
    def getVars(s):
        ls = s.replace("(", " ").replace(")", " ").replace(",", " ").split()
        return [var for var in ls[1:] if Parsing.isVariable(var)]

    @staticmethod
    def isVariable(s):
        return s[0] == "_" or s[0] != "'"

    @staticmethod
    def delegable(s, rule):
        if (
            s.functor == rule.functor
            and len(s.arguments) == len(rule.arguments)
            and all(
                not (not Parsing.isVariable(pa) and not Parsing.isVariable(ra) and pa != ra)
                for pa, ra in zip(s.arguments, rule.arguments)
            )
        ):
            return True
        return False

    @staticmethod
    def getNormId(s):
        c = 0
        id = [s.functor]
        for arg in s.arguments:
            if Parsing.isVariable(arg):
                id.append(f"X{c}")
                c += 1
            else:
                id.append(arg)
        return tuple(id)
