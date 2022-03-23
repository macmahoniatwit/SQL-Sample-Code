 -- Required fields already implemented with not null
 
 -- Default values
 ALTER TABLE STUDENT
 ALTER FirstName SET DEFAULT 'John';
 
  ALTER TABLE STUDENT
 ALTER LastName SET DEFAULT 'Doe';
 
 ALTER TABLE AVERAGE_EXAM_GRADE
 ALTER NumberOfExams SET DEFAULT 0;
 
   ALTER TABLE EXAM_GRADE
 ALTER Retakeable SET DEFAULT 'N';
 
    ALTER TABLE EXAM_GRADE
 ALTER Curved SET DEFAULT 'N';
 
 
 -- Range of allowed values
 
  ALTER TABLE AVERAGE_EXAM_GRADE
 ADD CHECK (AverageExamGrade > -1 AND AverageExamGrade < 101);
 
 ALTER TABLE Exam_Grade
 ADD CHECK (Grade > -1 AND Grade < 101);
 
 
  -- Collection of allowed values
  
   ALTER TABLE STUDENT
 ADD CHECK (Class = 'Fr' OR Class = 'So' OR Class = 'Jr' OR Class = 'Sr');
 
 ALTER TABLE COURSE
 ADD CHECK (Semester = 'Fall' OR Semester = 'Spring' OR Semester = 'Summer');
 
  ALTER TABLE COURSE
 ADD CHECK (CourseType = 'Onli' OR CourseType = 'Lect' OR CourseType = 'Lab');
 
  ALTER TABLE AVERAGE_EXAM_GRADE
 ADD CHECK (Semester = 'Fall' OR Semester = 'Spring' OR Semester = 'Summer');
 
 ALTER TABLE EXAM
 ADD CHECK (ExamType = 'Final' OR ExamType = 'Midterm' OR ExamType = 'Unit');
 
 
 -- Specific format implemented with dates
 
 