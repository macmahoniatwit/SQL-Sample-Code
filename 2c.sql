-- Normalize by creating separate table for section

CREATE TABLE IF NOT EXISTS `StudentExamManagementDB`.`Section` (
  `CourseID` INT NOT NULL,
  `SectionID` INT NOT NULL,
  `Semester` VARCHAR(6) NULL,
  PRIMARY KEY (`CourseID`, `SectionID`),
   FOREIGN KEY (`CourseID`)
    REFERENCES `StudentExamManagementDB`.`Course` (`CourseID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

 ALTER TABLE SECTION
 ADD CHECK (Semester = 'Fall' OR Semester = 'Spring' OR Semester = 'Summer');

-- Empties course table in order to reformat table
DELETE FROM COURSE;

-- Drops columns from Course that will now be in Section

ALTER TABLE COURSE
DROP COLUMN Section;

ALTER TABLE COURSE
DROP COLUMN Semester;

ALTER TABLE COURSE
ADD UNIQUE (CourseID);



-- Replaces info in course and section  tables

INSERT INTO COURSE
VALUES(0, 'Algebra', 'MATH', 'Lect');

INSERT INTO SECTION
VALUES (0, 1, 'Fall');

INSERT INTO SECTION
VALUES (0, 2, 'Fall');

INSERT INTO COURSE
VALUES(1, 'English I', 'ENGL', 'Lect');

INSERT INTO SECTION
VALUES (1, 1, 'Fall');

INSERT INTO SECTION
VALUES (1, 2, 'Fall');

INSERT INTO COURSE
VALUES(2, 'Chemistry', 'SCIE', 'Lab');

INSERT INTO SECTION
VALUES (2, 1, 'Spring');

INSERT INTO SECTION
VALUES (2, 2, 'Spring');

INSERT INTO COURSE
VALUES(3, 'History', 'HIST', 'Lect');

INSERT INTO SECTION
VALUES (3, 1, 'Fall');

INSERT INTO SECTION
VALUES (3, 2, 'Fall');

INSERT INTO COURSE
VALUES(4, 'Calculus I', 'MATH', 'Lect');

INSERT INTO SECTION
VALUES (4, 1, 'Summer');

INSERT INTO SECTION
VALUES (4, 2, 'Summer');

INSERT INTO COURSE
VALUES(5, 'Computer Science I', 'COMP', 'Lab');

INSERT INTO SECTION
VALUES (5, 1, 'Fall');

INSERT INTO SECTION
VALUES (5, 2, 'Fall');

SELECT * FROM SECTION;

SELECT * FROM COURSE;

