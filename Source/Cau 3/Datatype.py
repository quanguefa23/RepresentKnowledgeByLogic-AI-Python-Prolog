import copy
import itertools
from functools import reduce

import Database
from Parsing import Parsing

# married(x, y)
# married
# married('A', 'B')
class Term:
    def __init__(self, s):
        self.functor = Parsing.getFunctor(s)
        self.arguments = Parsing.getArguments(s)
        self.vars = set(Parsing.getVars(s))
        Database.terms.append(self)
        self.delegable_rules = [
            rule for rule in Database.rules.values() if Parsing.delegable(self, rule)
        ]
        self.locked = False

    def __repr__(self):
        return f"<RULE {self.functor} {self.arguments}"

    def __str__(self):
        return (
            str(self.functor)
            if len(self.arguments) == 0
            else str(self.functor)
            + "("
            + ", ".join(
                str(argument) if Parsing.isVariable(argument) else "'" + str(argument) + "'"
                for argument in self.arguments
            )
            + ")"
        )

    def __eq__(self, other):
        if (self.functor == other.functor) and (self.arguments == other.arguments):
            return True
        else:
            return False

    def sub(self, sub_map):
        term = copy.deepcopy(self)
        term.arguments = [sub_map.get(arg, arg) for arg in self.arguments]
        term.vars = [arg for arg in term.arguments if Parsing.isVariable(arg)]
        Database.terms.append(term)
        term.delegable_rules = [
            rule for rule in Database.rules.values() if Parsing.delegable(term, rule)
        ]
        return term

    def check(self, subs):
        return tuple(subs.get(arg, arg) for arg in self.arguments) in self.getSubs()

    def getSubsInFacts(self):
        subs = set()
        for val in Database.facts[self.functor]:
            if all(Parsing.isVariable(arg) or arg == v for arg, v in zip(self.arguments, val)):
                subs.add(val)
        return subs

    def tempRule(self, rule):
        new_rule = copy.deepcopy(rule)
        sub_map = {
            x: y
            for x, y in zip(rule.arguments, self.arguments)
            if Parsing.isVariable(x) and not Parsing.isVariable(y)
        }
        new_rule.arguments = [sub_map.get(arg, arg) for arg in rule.arguments]
        new_rule.terms = [term.sub(sub_map) for term in new_rule.terms]
        new_rule.vars = rule.vars - set(sub_map.keys())
        new_rule.arg_vars = set(new_rule.arguments) & set(new_rule.vars)
        id = Parsing.getNormId(new_rule)
        if id not in Database.rules:
            Database.rules[id] = new_rule
        else:
            return Database.rules[id]

        for term in Database.terms:
            if Parsing.delegable(term, new_rule):
                term.delegable_rules.append(new_rule)

        return new_rule

    def getSubsInRules(self):
        subs = set()
        for rule in self.delegable_rules:
            rule_sub = self.tempRule(rule).getSubs()
            for sub in rule_sub:
                if all(Parsing.isVariable(p) or p == s for p, s in zip(self.arguments, sub)):
                    subs.add(sub)
        return subs

    def getSubs(self):
        if self.locked:
            return self.getSubsInFacts()
        self.locked = True
        id = Parsing.getNormId(self)
        if id not in Database.subs:
            Database.subs[id] = self.getSubsInFacts() | self.getSubsInRules()
        self.locked = False
        return Database.subs[id]


# husband(X, Y) :- married(X, Y), female(Y).
class Rule:
    def __init__(self, s):
        self.functor = Parsing.getFunctor(s)
        self.terms = Parsing.getTerm(s)
        self.arguments = Parsing.getArguments(s)
        self.vars = set(
            var
            for var in self.arguments + list(itertools.chain(*[term.vars for term in self.terms]))
            if Parsing.isVariable(var)
        )
        self.arg_vars = set(self.arguments) & set(self.vars)
        Database.rules[Parsing.getNormId(self)] = self
        for term in Database.terms:
            if Parsing.delegable(term, self):
                term.delegable_rules.append(self)
        self.locked = False

    def __repr__(self):
        return f"<RULE {self.functor} {self.arguments} {self.vars} {self.terms}>"

    # return set of tuples of subtitutes
    def getSubsInFacts(self):
        subs = set()
        for val in Database.facts[self.functor]:
            if all(Parsing.isVariable(arg) or arg == v for arg, v in zip(self.arguments, val)):
                subs.add(val)
        return subs

    def check(self, sub_map):
        return all(term.check(sub_map) for term in self.terms)

    # return set of submaps
    def getSubsByTerms(self):
        term_subs = [term.getSubs() for term in self.terms]

        subs = set()
        for term_sub in itertools.product(*term_subs):
            var_subs = set(
                list(
                    itertools.chain(
                        *[
                            [(x, y) for x, y in zip(term.arguments, sub) if Parsing.isVariable(x)]
                            for term, sub in zip(self.terms, term_sub)
                        ]
                    )
                )
            )
            if len(var_subs) == len(self.vars):
                sub_map = {x: y for x, y in var_subs}
                subs.add(tuple(sub_map.get(arg, arg) for arg in self.arguments))
        return subs

    def getSubs(self):
        if self.locked:
            return self.getSubsInFacts()
        self.locked = True
        id = Parsing.getNormId(self)
        if id not in Database.subs:
            Database.subs[id] = self.getSubsInFacts() | self.getSubsByTerms()
        self.locked = False
        return Database.subs[id]


class Fact:
    def __init__(self, fact):
        self.functor = Parsing.getFunctor(fact)
        self.arguments = Parsing.getArguments(fact)
        self.vars = set(arg for arg in self.arguments if Parsing.isVariable(arg))
        self.insts = set(arg for arg in self.arguments if not Parsing.isVariable(arg))

    def __str__(self):
        return (
            str(self.functor)
            + "("
            + ", ".join(
                str(argument) if Parsing.isVariable(argument) else "'" + str(argument) + "'"
                for argument in self.arguments
            )
            + ") :- TRUE"
        )

    def activate(self):
        for sub in itertools.product(Database.universe, repeat=len(self.vars)):
            sub_map = {x: y for x, y in zip(self.vars, sub)}
            v = tuple(sub_map.get(arg, arg) for arg in self.arguments)
            Database.facts[self.functor].add(v)
