-- Inserting new field to exam table
INSERT INTO EXAM
VALUES (1, 0, 'Final', '2019-12-16');

SELECT * FROM EXAM;



-- Deleting a student
DELETE FROM STUDENT WHERE StudentID = 20;

SELECT * FROM STUDENT;



-- Creating a relationship between tables
INSERT INTO EXAM_GRADE
VALUES(0, 1, 2, 92, '2019-12-16', 'N', 'N');
 
 -- Call examgrades procedure to see student 0's grades on exams from course 2
CALL examgrades(0, 2);