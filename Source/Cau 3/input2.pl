schoolyear('2016', '16CTT1').
schoolyear('2016', '16CTT2').
schoolyear('2016', '16CNTN').
schoolyear('2016', '16CSH1').
schoolyear('2016', '16CSH2').
schoolyear('2016', '16HOH1').
schoolyear('2016', '16HOH2').

schoolyear('2017', '17CTT1').
schoolyear('2017', '17CTT2').
schoolyear('2017', '17CNTN').
schoolyear('2017', '17CSH1').
schoolyear('2017', '17CSH2').
schoolyear('2017', '17HOH1').
schoolyear('2017', '17HOH2').

schoolyear('2018', '18CTT1').
schoolyear('2018', '18CTT2').
schoolyear('2018', '18CNTN').
schoolyear('2018', '18CSH1').
schoolyear('2018', '18CSH2').
schoolyear('2018', '18HOH1').
schoolyear('2018', '18HOH2').

faculty('Infomation Technology', '16CTT1').
faculty('Infomation Technology', '16CTT2').
faculty('Infomation Technology', '16CNTN').
faculty('Infomation Technology', '17CTT1').
faculty('Infomation Technology', '17CTT2').
faculty('Infomation Technology', '17CNTN').
faculty('Infomation Technology', '18CTT1').
faculty('Infomation Technology', '18CTT2').
faculty('Infomation Technology', '18CNTN').

faculty('Biotechnology', '16CSH1').
faculty('Biotechnology', '16CSH2').
faculty('Biotechnology', '17CSH1').
faculty('Biotechnology', '17CSH2').
faculty('Biotechnology', '18CSH1').
faculty('Biotechnology', '18CSH2').

faculty('Chemistry', '16HOH1').
faculty('Chemistry', '16HOH2').
faculty('Chemistry', '17HOH1').
faculty('Chemistry', '17HOH2').
faculty('Chemistry', '18HOH1').
faculty('Chemistry', '18HOH2').

student('1612001', '16CTT1').
student('1612002', '16CTT1').
student('1612003', '16CTT1').
student('1612004', '16CTT2').
student('1612005', '16CTT2').
student('1612006', '16CTT2').
student('1612007', '16CNTN').
student('1612008', '16CNTN').
student('1612009', '16CNTN').
student('1618001', '16CSH1').
student('1618002', '16CSH1').
student('1618003', '16CSH1').
student('1618004', '16CSH2').
student('1618005', '16CSH2').
student('1618006', '16CSH2').
student('1614001', '16HOH1').
student('1614002', '16HOH1').
student('1614003', '16HOH1').
student('1614004', '16HOH2').
student('1614005', '16HOH2').
student('1614006', '16HOH2').

student('1712001', '17CTT1').
student('1712002', '17CTT1').
student('1712003', '17CTT1').
student('1712004', '17CTT2').
student('1712005', '17CTT2').
student('1712006', '17CTT2').
student('1712007', '17CNTN').
student('1712008', '17CNTN').
student('1712009', '17CNTN').
student('1718001', '17CSH1').
student('1718002', '17CSH1').
student('1718003', '17CSH1').
student('1718004', '17CSH2').
student('1718005', '17CSH2').
student('1718006', '17CSH2').
student('1714001', '17HOH1').
student('1714002', '17HOH1').
student('1714003', '17HOH1').
student('1714004', '17HOH2').
student('1714005', '17HOH2').
student('1714006', '17HOH2').

student('1812001', '18CTT1').
student('1812002', '18CTT1').
student('1812003', '18CTT1').
student('1812004', '18CTT2').
student('1812005', '18CTT2').
student('1812006', '18CTT2').
student('1812007', '18CNTN').
student('1812008', '18CNTN').
student('1812009', '18CNTN').
student('1818001', '18CSH1').
student('1818002', '18CSH1').
student('1818003', '18CSH1').
student('1818004', '18CSH2').
student('1818005', '18CSH2').
student('1818006', '18CSH2').
student('1814001', '18HOH1').
student('1814002', '18HOH1').
student('1814003', '18HOH1').
student('1814004', '18HOH2').
student('1814005', '18HOH2').
student('1814006', '18HOH2').

facultyOfStudent(X, Y) :- 
  student(Y, Z),
  faculty(X, Z).

friend(X, Y) :- student(X, Z), schoolyear(M, Z), student(Y, P), schoolyear(M, P).