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

divorced('Diana', 'Prince Charles').
divorced('Prince Charles', 'Diana').
divorced('Mark Phillips', 'Princess Anne').
divorced('Princess Anne', 'Mark Phillips').

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

husband(Person, Wife) :-
    male(Person),
    female(Wife),
    married(Person, Wife),
    married(Wife, Person).

wife(Person, Husband) :-
    female(Person),
    male(Husband),
    married(Person, Husband),
    married(Husband, Person).

father(Parent, Child) :-
    parent(Parent, Child),
    male(Parent).

mother(Parent, Child) :-
    parent(Parent, Child),
    female(Parent).

child(Child, Parent) :-
    parent(Parent, Child).

son(Child, Parent) :-
    parent(Parent, Child),
    male(Child).

daughter(Child, Parent) :-
    parent(Parent, Child),
    female(Child).

grandparent(GrandParent, GrandChild) :-
    parent(GrandParent, Parent),
    parent(Parent, GrandChild).

grandmother(GrandMother, GrandChild) :-
    female(GrandMother),
    mother(GrandMother, Mother),
    mother(Mother, GrandChild).

grandfather(GrandFather, GrandChild) :-
    male(GrandFather),
    father(GrandFather, Father),
    father(Father, GrandChild).

grandchild(GrandChild, GrandParent):-
    grandparent(GrandParent, GrandChild).

grandson(GrandSon, GrandParent) :-
    grandparent(GrandParent, GrandSon),
    male(GrandSon).

granddaughter(GrandDaughter, GrandParent) :-
    grandparent(GrandParent, GrandDaughter),
    female(GrandDaughter).

sibling(Person1, Person2):-
    father(Father, Person1),
    father(Father, Person2),
    mother(Mother, Person1),
    mother(Mother, Person2).

brother(Person, Sibling):-
    male(Person),
    sibling(Person, Sibling).

sister(Person, Sibling):-
    female(Person),
    sibling(Person, Sibling).
    
aunt(Person, NieceNewphew):-
    parent(Parent, NieceNewphew),
    sister(Person, Parent).

aunt(Person, NieceNewphew):-
    parent(Parent, NieceNewphew),
    brother(Husband, Parent),
    husband(Husband, Person).

uncle(Person, NieceNewphew):-
    parent(Parent, NieceNewphew),
    brother(Person, Parent).

niece(Person, AuntUncle) :-
    female(Person),
    aunt(AuntUncle, Person).

niece(Person, AuntUncle) :-
    female(Person),
    uncle(AuntUncle, Person).
            
nephew(Person, AuntUncle) :-
    male(Person), 
    aunt(AuntUncle, Person).

nephew(Person, AuntUncle) :-
    male(Person), 
    uncle(AuntUncle, Person).