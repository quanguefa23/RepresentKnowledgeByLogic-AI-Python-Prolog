/*
Authors:
17CNTN, Student group:
1712441 - Tran Dinh Ton Hieu
1712702 - Nguyen Ha Quang
1712227 - Lam Thanh Loc
*/

/* KNOWLEDGE BASE DEFINITION */

/* Married */
married('Queen Elizabeth II', 'Prince Phillip').
married('Prince Phillip', 'Queen Elizabeth II').
married('Prince Charles', 'Camilla Parker Bowles').
married('Camilla Parker Bowles', 'Prince Charles').
married('Prince Andrew', 'Sarah Ferguson').
married('Sarah Ferguson', 'Prince Andrew').
married('Kate Middleton', 'Prince William').
married('Kate Middleton', 'Kate Middleton').
married('Prince Harry', 'Meghan Markle').
married('Meghan Markle', 'Prince Harry').
married('Princess Anne', 'Timothy Laurence').
married('Timothy Laurence', 'Princess Anne').
married('Prince Edward', 'Sophie Rhys-Jones').
married('Sophie Rhys-Jones', 'Prince Edward').
married('Peter Phillips', 'Autumn Phillips').
married('Autumn Phillips', 'Peter Phillips').
married('Zara Tindall', 'Mike Tindall').
married('Zara Tindall', 'Mike Tindall').

/* Divorced */
divorced('Diana', 'Prince Charles').
divorced('Prince Charles', 'Diana').
divorced('Mark Phillips', 'Princess Anne').
divorced('Princess Anne', 'Mark Phillips').

/* Parent */
parent('Queen Elizabeth II', 'Prince Charles').
parent('Prince Phillip', 'Prince Charles').
parent('Queen Elizabeth II', 'Prince Andrew').
parent('Prince Phillip', 'Prince Andrew').
parent('Queen Elizabeth II', 'Princess Anne').
parent('Prince Phillip', 'Princess Anne').
parent('Queen Elizabeth II', 'Prince Edward').
parent('Prince Phillip', 'Prince Edward').

parent('Prince Charles', 'Prince William').
parent('Diana', 'Prince William').
parent('Prince Charles', 'Prince Harry').
parent('Diana', 'Prince Harry').

parent('Prince Andrew', 'Princess Eugenie').
parent('Sarah Ferguson', 'Princess Eugenie').
parent('Prince Andrew', 'Princess Beatrice').
parent('Sarah Ferguson', 'Princess Beatrice').

parent('Mark Phillips', 'Peter Phillips').
parent('Princess Anne', 'Peter Phillips').
parent('Mark Phillips', 'Zara Tindall').
parent('Princess Anne', 'Zara Tindall').

parent('Prince Edward', 'Lady Louise Windsor').
parent('Sophie Rhys-Jones', 'Lady Louise Windsor').
parent('Prince Edward', 'James').
parent('Sophie Rhys-Jones', 'James').

parent('Prince William', 'Prince Geogre').
parent('Kate Middleton', 'Prince Geogre').
parent('Prince William', 'Princess Charlotte').
parent('Kate Middleton', 'Princess Charlotte').
parent('Prince William', 'Prince Louis').
parent('Kate Middleton', 'Prince Louis').

parent('Prince Harry', 'Archie Harrison').
parent('Meghan Markle', 'Archie Harrison').

/* Male */
male('Prince Phillip').
male('Prince Charles').
male('Prince Andrew').
male('Prince William').
male('Prince Harry').
male('Prince Geogre').
male('Prince Louis').
male('Archie Harrison').
male('Mark Phillips').
male('Timothy Laurence').
male('Prince Edward').
male('Peter Phillips').
male('Mike Tindall').
male('James').

/* Female */
female('Queen Elizabeth II').
female('Diana').
female('Camilla Parker Bowles').
female('Sarah Ferguson').
female('Kate Middleton').
female('Meghan Markle').
female('Princess Eugenie').
female('Princess Beatrice').
female('Princess Charlotte').
female('Princess Anne').
female('Sophie Rhys-Jones').
female('Autumn Phillips').
female('Zara Tindall').
female('Lady Louise Windsor').

/* RULES DEFINITION */

husband(X, Y) :- setof((X,Y), (married(X,Y), female(Y), \+X=Y), Husbands),
                member((X,Y), Husbands),
                \+ (Y@<X, member((Y,X), Husbands)).

wife(X, Y) :- setof((X,Y), (married(X,Y), male(Y), \+X=Y), Wifes),
            member((X,Y), Wifes),
            \+ (Y@<X, member((Y,X), Wifes)).

father(X, Y) :- setof((X,Y), (parent(X,Y), male(X), \+X=Y), Fathers),
            member((X,Y), Fathers),
            \+ (Y@<X, member((Y,X), Fathers)).

mother(X, Y) :- setof((X,Y), (mother(X,Y), female(X), \+X=Y), Mothers),
            member((X,Y), Mothers),
            \+ (Y@<X, member((Y,X), Mothers)).

child(X, Y) :- parent(Y, X).

son(X, Y) :- setof((X,Y), (parent(Y,X), male(X), \+X=Y), Sons),
            member((X,Y), Sons),
            \+ (Y@<X, member((Y,X), Sons)).

daughter(X, Y) :- setof((X,Y), (parent(Y,X), female(X), \+X=Y), Daughters),
            member((X,Y), Daughters),
            \+ (Y@<X, member((Y,X), Daughters)).

grandchild(X,Y) :- setof((X,Y), Z^(child(X, Z), child(Z, Y), \+X=Y), Gchilds),
                member((X,Y), Gchilds),
                \+ (Y@<X, member((Y,X), Gchilds)).

grandson(X,Y) :- setof((X,Y), (grandchild(X,Y), male(X)), Gsons),
                member((X,Y), Gsons),
                \+ (Y@<X, member((Y,X), Gsons)).

granddaughter(X, Y) :- setof((X,Y), (grandchild(X,Y), female(X), \+X=Y), Granddaughters),
            member((X,Y), Granddaughters),
            \+ (Y@<X, member((Y,X), Granddaughters)).

grandparent(X,Y) :- setof((X,Y), Z^(parent(X,Z), parent(Z, Y), \+X=Y), Gparents),
                member((X,Y), Gparents),
                \+ (Y@<X, member((Y,X), Gparents)).

grandfather(X, Y) :- setof((X,Y), (grandparent(X,Y), male(X), \+X=Y), Gfathers),
                member((X,Y), Gfathers),
                \+ (Y@<X, member((Y,X), Gfathers)).

grandmother(X, Y) :- setof((X,Y), (grandmother(X,Y), female(X), \+X=Y), Gmothers),
                member((X,Y), Gmothers),
                \+ (Y@<X, member((Y,X), Gmothers)).

sibling(X,Y) :- setof((X,Y), P^(parent(P,X),parent(P,Y), \+X=Y), Sibs),
               member((X,Y), Sibs),
               \+ (Y@<X, member((Y,X), Sibs)).

brother(X, Y) :- setof((X,Y), (sibling(X,Y), male(X), \+X=Y), Bros),
                member((X,Y), Bros),
                \+ (Y@<X, member((Y,X), Bros)).

sister(X, Y) :- setof((X,Y), (sibling(X,Y), female(X), \+X=Y), Siss),
                member((X,Y), Siss),
                \+ (Y@<X, member((Y,X), Siss)).

auntDirrect(X, Y) :- setof((X,Y), Z^(parent(Z,Y), sister(X,Z)), Aunts),
            member((X,Y), Aunts),
            \+ (Y@<X, member((Y,X), Aunts)).

auntMarry(X,Y) :- setof((X,Y), Z^(uncleDirrect(Z, Y), married(X, Z)), AuntsMarries),
                member((X,Y), AuntsMarries),
                \+ (Y@<X, member((Y,X), AuntsMarries)).

aunt(X,Y) :- auntDirrect(X,Y).
aunt(X,Y) :- auntMarry(X, Y).

uncleDirrect(X, Y) :- setof((X,Y), Z^(parent(Z,Y), brother(X,Z)), Uncles),
            member((X,Y), Uncles),
            \+ (Y@<X, member((Y,X), Uncles)).

uncleMarry(X, Y) :- setof((X,Y), Z^(auntDirrect(Z, Y), married(X, Z)), UncleMarries),
                member((X, Y), UncleMarries),
                \+ (Y@<X, member((Y,X), UncleMarries)).

uncle(X, Y) :- uncleDirrect(X,Y).
uncle(X, Y) :- uncleMarry(X, Y).

auntUncle(X,Y) :- aunt(X, Y).
auntUncle(X,Y) :- uncle(X, Y).

niece(X,Y) :- setof((X,Y), (auntUncle(Y, X), female(X)), Nieces),
            member((X,Y), Nieces),
            \+ (Y@<X, member((Y,X), Nieces)).

nephew(X,Y) :- setof((X,Y), (auntUncle(Y,X), male(X)), Nephews),
            member((X,Y), Nephews),
            \+ (Y@<X, member((Y,X), Nephews)).