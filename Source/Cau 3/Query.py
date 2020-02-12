# ?- married('A','B')
# ?- married('A', X)
import Database
from Datatype import Rule
from Parsing import Parsing


class Query(Rule):
    def __init__(self, content):
        q = "q():-" + content
        import uuid
        q = str(uuid.uuid4()) + "(" + ",".join(Rule(q).vars) + "):-" + content
        self.cont = Rule(q)

    def getAns(self):
        return list(
            map(
                lambda sub: {x: y for x, y in zip(self.cont.arguments, sub) if Parsing.isVariable(x)},
                self.cont.getSubs(),
            )
        )

