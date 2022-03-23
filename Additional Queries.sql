-- Adds student
CALL addstudent (38, 'Peyton', 'Tuck', 'Fr', 'Mathematics', '2001-10-10');

-- Adds course and section
CALL addcourse(12, 'Algebra II', 'MATH', 'Lect');

CALL addsection(12, 1, 'Fall');

-- Adds exam for previously added coursee
CALL addexam(1, 12,'Unit','2019-09-20');

CALL addexam(2, 12,'Midterm','2019-11-01');

CALL addexam(3, 12,'Final','2019-12-09');

-- Adds grades on exams from previously added student
CALL addexamgrade(38, 1, 12, 90, '2019-09-21', 'Y', 'N');

CALL addexamgrade(38, 2, 12, 94, '2019-11-01', 'N', 'Y');

CALL addexamgrade(38, 3, 12, 92, '2019-12-09', 'N', 'N');

-- Updates students average
CALL updateaverage(38, 'Fall');

-- Shows courses this student has taken exams
CALL studentcourse(38);

-- Lists all exam grades of student in course 12
	CALL examgrades(38, 12);
    
    -- Shows average exam grade of student
    CALL averageexamgradeof(38);