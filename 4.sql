-- View for data entry for STUDENT table
CREATE VIEW STUDENTVIEW
AS
SELECT StudentId, FirstName, LastName, Class, Major, DateOfBirth
FROM STUDENT;

INSERT INTO STUDENTVIEW
SELECT 20, 'Charles', 'Thorton', 'Fr', 'English', '2001-03-31';	

SELECT * FROM STUDENT;



-- View for data entry for COURSE table
CREATE VIEW COURSEVIEW
AS
SELECT CourseID, CourseName, Topic, CourseType
FROM COURSE;

INSERT INTO COURSEVIEW
SELECT 6, 'Intro to Psychology', 'PSYC', 'Lect';

SELECT * FROM COURSE;

-- View for data entry for SECTION table
CREATE VIEW SECTIONVIEW
AS
SELECT CourseID, SectionID, Semester
FROM SECTION;

INSERT INTO SECTIONVIEW
SELECT 6,1,'Spring';

SELECT * FROM SECTION;

-- View for data entry for EXAM table
CREATE VIEW EXAMVIEW
AS
SELECT ExamID, CourseID, ExamType, StartDate
FROM EXAM;

INSERT INTO EXAMVIEW
SELECT 1,2,'Unit','2000-02-02';

SELECT * FROM EXAM;

-- View for data entry for EXAM_GRADE table
CREATE VIEW EXAMGRADEVIEW
AS
SELECT StudentID, ExamID, CourseID, Grade, DateTaken, Retakeable, Curved
FROM EXAM_GRADE;

INSERT INTO EXAMGRADEVIEW
SELECT 1,1, 2, 92,'2019-12-16', 'N', 'N';

SELECT * FROM EXAM_GRADE;