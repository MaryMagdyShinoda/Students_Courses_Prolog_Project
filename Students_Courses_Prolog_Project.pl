%
student(stud01, 'Programming 1', 90).
student(stud01, 'Math 1', 78).
student(stud01, 'Statistics 1', 94).
student(stud01, 'Electronics 1', 81).
student(stud01, 'Management', 66).
student(stud01, 'English', 83).
student(stud02, 'OS 1', 65).
student(stud02, 'Math 1', 50).
student(stud02, 'Data Communication', 76).
student(stud03, 'OOP', 68).
student(stud03, 'Math 1', 63).
student(stud03, 'Statistics 1', 98).
student(stud03, 'Electronics 2', 72).
student(stud04, 'Database', 59).
student(stud04, 'Math 3', 67).
student(stud04, 'Data Structures', 79).
student(stud05, 'Programming 1', 88).
student(stud05, 'Math 1', 75).
student(stud05, 'Statistics 1', 96).
student(stud05, 'Electronics 1', 89).
student(stud05, 'Management', 84).
student(stud06, 'Robotics', 62).
student(stud07, 'Programming 1', 50).
student(stud07, 'Math 2', 8).
student(stud07, 'Statistics 2', 70).
student(stud07, 'Electronics 1', 47).
student(stud08, 'OS 1', 71).
student(stud09, 'Robotics', 29).
student(stud09, 'Database', 57).
student(stud10, 'Data Structures', 82).
student(stud10, 'Math 2', 64).
student(stud10, 'Data Communication', 85).
student(stud10, 'Database', 46).
student(stud10, 'Electronics 2', 58).
student(stud10, 'Statistics 2', 97).
%
prerequisite('Programming 1', 'OOP').
prerequisite('OOP', 'OS 1').
prerequisite('OS 1', 'OS 2').
prerequisite('OOP', 'Data Structures').
prerequisite('Data Structures', 'Algorithms').
prerequisite('Algorithms', 'Advanced Algorithms').
prerequisite('Math 1', 'Math 2').
prerequisite('Math 2', 'Math 3').
prerequisite('Math 3', 'Math 4').
prerequisite('Statistics 1', 'Statistics 2').
prerequisite('Electronics 1', 'Electronics 2').
prerequisite('Electronics 2', 'Computer Architecture').
prerequisite('Computer Architecture', 'Microprocessors').
prerequisite('Data Communication', 'Networks').
prerequisite('Database', 'Data Warehouses').


add2Lists([],L2,L2).

add2Lists([H|T],L2,[H|R]):-
       add2Lists(T,L2,R).

ismember(M,[M|T]).

ismember(M,[_|T]):-
       ismember(M,T).

len([],0).
len([_|T],NewN):-
       len(T,N),
       NewN  is N+1.


studentsInCourse(C,L):-
       studentsInCourse(C,[],L).

studentsInCourse(C,TL,L):-
       student(X,C,Z),
       not(ismember([X|Z],TL)), !,
       add2Lists([[X|Z]],TL,NL),
       studentsInCourse(C,NL,L).

studentsInCourse(C,L,L).


numStudents(C,Count) :-
       studentsInCourse(C, CL),
       len(CL,Count).


maxlist([H|[]], M) :-
	M is H, !.

maxlist([H|T], M) :-
	maxlist(T, M1),
	M1 > H,
	M is M1, !.

maxlist([H|T], M) :-
	maxlist(T,M1),
	M1 < H,
	M is H, !.


studentsID(X,L):-
       studentsID(X,[],L).

studentsID(X,TL,L):-
       student(X,C,Z),
       not(ismember(Z,TL)), !,
       add2Lists([Z],TL,NewL),
       studentsID(X,NewL,L).

studentsID(X,L,L).


maxStudentGrade(X,MG):-
       studentsID(X,L),
       maxlist(L,MG).


word(N,C):-
       N =:= 0,
       C = 'zero'.
word(N,C):-
       N =:= 1,
       C = 'one'.
word(N,C):-
       N=:=2,
       C ='two'.
word(N,C):-
       N=:=3,
       C = 'three'.
word(N,C):-
       N=:=4,
       C = 'four'.
word(N,C):-
       N=:=5,
       C = 'five'.
word(N,C):-
       N=:=6,
       C = 'six'.
word(N,C):-
       N=:=7,
       C = 'seven'.
word(N,C):-
       N=:=8,
       C = 'eight'.
word(N,C):-
       N=:=9,
       C = 'nine'.

check(N,Nums):-
       N >= 10,
       NDiv is N // 10,
       NMod is N mod 10,
       word(NDiv,C1),
       H = C1,
       word(NMod,C2),
       T = C2,
       Nums = [H,T].

check(N,Nums):-
       N < 10,
       word(N,C),
       H = C,
       Nums = [H].

gradeInWords(X,C,Nums):-
    student(X,C,Z),
    check(Z,Nums).


passcourses(X,L):-
       passcourses(X,[],L).

passcourses(X,TL,L):-
       student(X,C,Z),
       Z>=50,
       not(ismember(C,TL)), !,
       add2Lists([C],TL,NewL),
       passcourses(X,NewL,L).

passcourses(X,L,L).


pre(D,L):-
       pre(D,[],L).

pre(D,TL,L):-
       prerequisite(C,D),
       not(ismember(C,TL)), !,
       add2Lists([C],TL,NewL),
       pre(C,NewL,L).

pre(D,L,L).

join2([],S,S).
join2([H|S],T,[H|W]):-
       join2(S,T,W).

revers([],[]).
revers([S|T],L):-
       revers(T,V),
       join2(V,[S],L).

compare2Lists(L1,L2,L):-
       compare2Lists(L1,L2,[],L).

compare2Lists(PC,[H|PR],TL,L):-
       not(ismember(H,PC)), !,
       add2Lists([H],TL,NewL),
       compare2Lists(PC,PR,NewL,L).

compare2Lists(L1,L2,L,L).

check2(N1,N2):-
       N1=:=N2.

remainingCourses(X,D,L):-
       remainingCourses(X,D,[],L).

remainingCourses(X,D,TL,L):-
       passcourses(X,PC),
       pre(D,PR),
       len(PR,N1),
       revers(PR,NPR),
       compare2Lists(PC,NPR,TL,L),
       len(L,N2),
       check2(N1,N2),!,fail;
       passcourses(X,PC),
       pre(D,PR),
       revers(PR,NPR),
       compare2Lists(PC,NPR,TL,L).

remainingCourses(X,C,L,L).



%studentsInCourse('Robotics', Students).
%studentsInCourse('Algorithms', Students).
%
%numStudents('Algorithms', Num).
%numStudents('Math 1', Num).
%
%maxStudentGrade(stud10, MaxGrade).
%maxStudentGrade(stud08, MaxGrade).
%
%gradeInWords(stud04, 'Database', DigitsWords).
%gradeInWords(stud07, 'Math 2', DigitsWords).
%gradeInWords(stud01, 'Programming 1', DigitsWords).
%
%remainingCourses(stud01, 'Advanced Algorithms', Courses).
%remainingCourses(stud07, 'Electronics 2', Courses).
%remainingCourses(stud05, 'Computer Architecture', Courses).
%remainingCourses(stud08, 'Data Warehouses', Courses).
%remainingCourses(stud02, 'Networks', Courses).

