% Facts: defining relationships between students, teachers, and courses
enrolled(john, math).         % John is enrolled in Math
enrolled(mary, math).         % Mary is enrolled in Math
enrolled(john, science).     % John is enrolled in Science
enrolled(alice, biology).    % Alice is enrolled in Biology

teaches(mr_smith, math).     % Mr. Smith teaches Math
teaches(mrs_jones, science). % Mrs. Jones teaches Science
teaches(dr_white, biology).  % Dr. White teaches Biology

% Rule: A teacher teaches a student if the student is enrolled in the teacher's subject
teaches_student(Teacher, Student) :-
    teaches(Teacher, Subject),
    enrolled(Student, Subject).
