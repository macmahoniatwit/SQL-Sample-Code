-- Simple Query 1: lists all students
CREATE PROCEDURE liststudents ( )
	SELECT * FROM STUDENT;

CALL liststudents();

-- Simple Query 2: lists all courses
CREATE PROCEDURE listcourses ( )
	SELECT * FROM COURSE;

CALL listcourses();

-- Simple Query 3: lists average exam grades of all students
CREATE PROCEDURE listaveragegrades ( ) 
	SELECT * FROM AVERAGE_EXAM_GRADE;
    
CALL listaveragegrades();
    
-- Simple Query 4: lists all sections of all courses
CREATE PROCEDURE listsections ( ) 
	SELECT * FROM SECTION;
    
CALL listsections();

-- Simple Query 5: counts number of students
CREATE PROCEDURE countstudents ( )
	SELECT COUNT(StudentID) FROM STUDENT;
    
CALL countstudents();

-- Intermediate Query 1: find average exam grade of specific student
CREATE PROCEDURE averageexamgradeof( IN sid INT )
	SELECT AverageExamGrade FROM AVERAGE_EXAM_GRADE
	WHERE StudentID = sid;

CALL averageexamgradeof(0);

-- Intermediate Query 2: list all types of exams given in course
CREATE PROCEDURE examtypesgivenin ( IN cid INT )
	SELECT ExamType FROM EXAM 
	WHERE CourseID = cid;
    
CALL examtypesgivenin(0);

-- Intermediate Query 3: list of all courses running in specific semester
CREATE PROCEDURE coursesrunningin ( IN s VARCHAR(6))
	SELECT CourseName FROM COURSE
	WHERE CourseID = (SELECT CourseID FROM SECTION 
    WHERE SectionID = 1 AND Semester = s);

CALL coursesrunningin('Summer');

-- Advanced Query 1: lists all exam grades of student in specific course
CREATE PROCEDURE examgrades( IN sid INT, IN cid INT)
	SELECT Grade FROM Exam_Grade
	WHERE StudentID = sid AND CourseID = cid;
    
	CALL examgrades(0, 2);

-- Advanced Query 2: finds names of students achieving 90 or above on an exam
CREATE PROCEDURE examOver90( IN eid INT)
	SELECT FirstName, LastName FROM STUDENT
    WHERE StudentID = (SELECT StudentID FROM EXAM_GRADE WHERE ExamID = eid
    AND Grade >= 90);
    
CALL examOver90(0);

-- Advanced Query 3: lists the names of the courses a student is taking exams in
CREATE PROCEDURE studentcourse ( IN sid INT)
	SELECT CourseName FROM COURSE
    WHERE CourseID = (SELECT DISTINCT CourseID FROM EXAM_GRADE WHERE StudentID = sid);

CALL studentcourse(1);

-- ***********************************************************
-- SQL SCRIPT 4 MUST BE RUN PRIOR TO CREATING BELOW PROCEDURES
-- ***********************************************************



-- Advanced Query 4: adds a student
CREATE PROCEDURE addstudent ( IN id INT, IN firstna VARCHAR(20), IN lastna VARCHAR(20), 
IN class VARCHAR(2), IN major VARCHAR(45), IN dob DATE )
	INSERT INTO STUDENTVIEW
	SELECT id, firstna, lastna, class, major, dob;
    
CALL addstudent (21, 'Michael', 'Kuhn', 'Sr', 'Computer Engineering', '1997-09-22');

SELECT * FROM STUDENT;
    
-- Advanced Query 5: adds a course
CREATE PROCEDURE addcourse( IN id INT, IN coursename VARCHAR(45), IN topic VARCHAR(4), IN coursetype VARCHAR(4) )
	INSERT INTO COURSEVIEW
	SELECT id, coursename, topic, coursetype;
	
CALL addcourse(7, 'Calculus II', 'MATH', 'Lab');

SELECT * FROM COURSE;
    
-- Advanced Query 6: adds a section
CREATE PROCEDURE addsection(IN courseid INT, IN sectionid VARCHAR(45), IN semester VARCHAR(6))
	INSERT INTO SECTIONVIEW
	SELECT courseid, sectionid, semester;
	
CALL addsection(4, 3, 'Spring');

SELECT * FROM SECTION;

-- Advanced Query 7: adds an exam
CREATE PROCEDURE addexam(IN examid INT, IN courseid INT, IN examtype VARCHAR(7), IN startdate DATE)
	INSERT INTO EXAMVIEW
	SELECT examid, courseid, examtype, startdate;
	
CALL addexam(5,3,'Midterm','2001-10-11');

SELECT * FROM EXAM;

-- Advanced Query 8: adds an exam grade
CREATE PROCEDURE addexamgrade(IN studentid INT, IN examid INT, IN courseid INT, IN grade INT, IN datetaken DATE, IN retake VARCHAR(1), IN curve VARCHAR(1))
    INSERT INTO EXAMGRADEVIEW
    SELECT studentid, examid, courseid, grade, datetaken, retake, curve;

CALL addexamgrade(3, 1, 2, 86, '2019-12-16', 'N', 'N');

SELECT * FROM EXAM_GRADE;

-- Advanced Query 9: updates a students average exam grade
CREATE PROCEDURE updateaverage(IN sid INT, IN semester VARCHAR(6))
	REPLACE INTO AVERAGE_EXAM_GRADE
    SELECT sid,
    (SELECT AVG(Grade) FROM EXAM_GRADE WHERE StudentID = sid), 
    (SELECT SUM(Grade) FROM EXAM_GRADE WHERE StudentID = sid), 
    (SELECT COUNT(Grade) FROM EXAM_GRADE WHERE StudentID = sid), 
    semester;
    
CALL updateaverage(1, 'Fall');

SELECT * FROM AVERAGE_EXAM_GRADE;
    