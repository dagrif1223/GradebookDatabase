# schema
DROP DATABASE IF EXISTS Gradebook;
CREATE DATABASE Gradebook;
# part 1 
DROP TABLE IF EXISTS Course;
CREATE TABLE Course (
    course_id INT PRIMARY KEY,
    department VARCHAR(50),
    course_number INT,
    course_name VARCHAR(100),
    course_semester VARCHAR(20),
    course_year INT,
  	course_homework FLOAT,
  	course_project FLOAT,
  	course_test FLOAT,
  	course_participation FLOAT
);

CREATE TABLE Assignment (
    assignment_id INT PRIMARY KEY,
    assignment_name VARCHAR(100),
  	assignment_type VARCHAR(100),
  	course_id INT,
    FOREIGN KEY (course_id) REFERENCES Course(course_id)
  	
);

CREATE TABLE Student (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);

CREATE TABLE Grade (
    grade_id INT PRIMARY KEY,
    score FLOAT,
    student_id INT,
    assignment_id INT,
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (assignment_id) REFERENCES Assignment(assignment_id)
);

CREATE TABLE EnrolledList (
  course_id INT,
  student_id INT,
  FOREIGN KEY (course_id) REFERENCES Course(course_id),
  FOREIGN KEY (student_id) REFERENCES Student(student_id)
  );

INSERT INTO Course (course_id, department, course_number, course_name, course_semester, course_year, course_homework, course_project, course_test, course_participation) 
VALUES 
(1, 'Computer Science', 101, 'Introduction to Computer Science', 'Fall', 2024, .20, .25, .40, .15),
(2, 'Computer Science', 102, 'Software Engineering', 'Fall', 2024, .25, .20, .45, .5),
(3, 'Computer Science', 103, 'Operating Systems', 'Spring', 2024, .20, .20, .25, .35);       

INSERT INTO Assignment (assignment_id, assignment_name, assignment_type, course_id)
VALUES (1, 'Participation', 'Participation', 1),
       (2, 'Homework 1', 'Homework', 1),
       (3, 'Homework 2', 'Homework', 1),
       (4, 'Test 1', 'Test', 1),
       (5, 'Test 2', 'Test', 1),
       (6, 'Project', 'Project', 1),
       (7, 'Participation', 'Participation', 2),
       (8, 'Homework 1', 'Homework', 2),
       (9, 'Homework 2', 'Homework', 2),
       (10, 'Test 1', 'Test', 2),
       (11, 'Project', 'Project', 2),
       (12, 'Participation', 'Participation', 3),
       (13, 'Homework 1', 'Homework', 3),
       (14, 'Project 1', 'Project', 3),
       (15, 'Test 1', 'Test', 3);

INSERT INTO Student (student_id, first_name, last_name)
VALUES (1, 'John', 'Quincy'),
       (2, 'Jane', 'Smith'),
       (3, 'Devin', 'Griffin'),
       (4, 'Yinka', 'Adeyemi'),
       (5, 'Peter', 'Parker'),
       (6, 'Bruce', 'Wayne');
       
INSERT INTO EnrolledList (course_id, student_id)
VALUES (1, 1),
       (1, 2),
       (2, 3),
       (2, 4),
       (3, 5),
       (3, 6);

INSERT INTO Grade (grade_id, score, student_id, assignment_id)
VALUES 
(1, 0.80, 1, 1),
(2, 0.90, 2, 1),
(3, 0.79, 1, 2),
(4, 0.89, 2, 2),
(5, 0.92, 1, 3),
(6, 0.86, 2, 3),
(7, 0.70, 1, 4),
(8, 0.74, 2, 4),
(9, 0.90, 1, 5),
(10, 0.92, 2, 5),
(11, 0.97, 1, 6),
(12, 0.94, 2, 6);

-- task 7
INSERT INTO Assignment (assignment_id, assignment_name, assignment_type, course_id)
VALUE (16, 'Test 2', 'Test', 3);

-- task 8
UPDATE Course
SET course_homework = 20, course_project = 40, course_test = 30, course_participation = 10
WHERE course_id = 3;

-- task 9
UPDATE Grade
SET score = score + .02 
WHERE assignment_id = 1;

-- task 10
UPDATE Grade
JOIN Student ON Grade.student_id = Student.student_id
SET score = score + .02
WHERE Student.last_name LIKE '%Q%';


# commands

# commands

-- Display contents of the Course table (3)
SELECT * FROM Course;

-- Display contents of the Assignment table
SELECT * FROM Assignment;

-- Display contents of the Student table
SELECT * FROM Student;

-- Display contents of the Grade table
SELECT * FROM Grade;

-- Display enrolled list
SELECT * FROM EnrolledList;

-- Display every student from a course (task 5, query 6)
SELECT EnrolledList.student_id, Student.first_name, Student.last_name, Course.course_name
FROM Student, Course, EnrolledList
WHERE EnrolledList.student_id = Student.student_id AND EnrolledList.course_id = Course.course_id AND Course.course_id = 2;

-- Display average/highest/lowest of an assignment (task 4, query 7, 8, 9)
SELECT AVG(Grade.score * 100)
FROM Grade
WHERE Grade.assignment_id = 1;

SELECT MAX(Grade.score * 100)
FROM Grade
WHERE Grade.assignment_id = 1;

SELECT MIN(Grade.score * 100)
FROM Grade
WHERE Grade.assignment_id = 1;

-- List all students in a course and their scores on every assignment (task 6, query 10)
 
 SELECT Grade.student_id, Student.first_name, Student.last_name, Assignment.assignment_name, Grade.score
FROM Grade
JOIN Student ON Grade.student_id = Student.student_id
JOIN Assignment ON Grade.assignment_id = Assignment.assignment_id
WHERE Assignment.course_id = 1;

-- Compute the grade for a student (task 11)
SELECT 
    Student.first_name,
    Student.last_name,
    SUM(AssignmentWeightedScores.weighted_score) AS total_grade
FROM
    (SELECT 
        Grade.student_id,
        SUM(
            CASE
                WHEN Assignment.assignment_type = 'Homework' THEN 
                    Grade.score * (Course.course_homework / COALESCE(HomeworkCount.count, 1))
                WHEN Assignment.assignment_type = 'Project' THEN 
                    Grade.score * (Course.course_project / COALESCE(ProjectCount.count, 1))
                WHEN Assignment.assignment_type = 'Test' THEN 
                    Grade.score * (Course.course_test / COALESCE(TestCount.count, 1))
                WHEN Assignment.assignment_type = 'Participation' THEN 
                    Grade.score * (Course.course_participation / COALESCE(ParticipationCount.count, 1))
                ELSE 0
            END
        ) AS weighted_score
    FROM
        Grade
    INNER JOIN Assignment ON Grade.assignment_id = Assignment.assignment_id
    INNER JOIN Course ON Assignment.course_id = Course.course_id
    LEFT JOIN (
        SELECT course_id, COUNT(*) AS count
        FROM Assignment
        WHERE assignment_type = 'Homework'
        GROUP BY course_id
    ) AS HomeworkCount ON Course.course_id = HomeworkCount.course_id
    LEFT JOIN (
        SELECT course_id, COUNT(*) AS count
        FROM Assignment
        WHERE assignment_type = 'Project'
        GROUP BY course_id
    ) AS ProjectCount ON Course.course_id = ProjectCount.course_id
    LEFT JOIN (
        SELECT course_id, COUNT(*) AS count
        FROM Assignment
        WHERE assignment_type = 'Test'
        GROUP BY course_id
    ) AS TestCount ON Course.course_id = TestCount.course_id
    LEFT JOIN (
        SELECT course_id, COUNT(*) AS count
        FROM Assignment
        WHERE assignment_type = 'Participation'
        GROUP BY course_id
    ) AS ParticipationCount ON Course.course_id = ParticipationCount.course_id
    GROUP BY Grade.student_id
    ) AS AssignmentWeightedScores
INNER JOIN Student ON AssignmentWeightedScores.student_id = Student.student_id
WHERE
    Student.first_name = 'John' AND Student.last_name = 'Quincy';

-- task 12
SELECT 
    Student.first_name,
    Student.last_name,
    SUM(AssignmentWeightedScores.weighted_score) AS total_grade
FROM
    (SELECT 
        Grade.student_id,
        SUM(
            CASE
                WHEN Assignment.assignment_type = 'Homework' THEN 
                    CASE
                        WHEN Grade.score != LowestHomeworkGrade.lowest_score THEN
                            Grade.score * (Course.course_homework / (HomeworkCount.count - 1))
                        ELSE
                            0
                    END
                WHEN Assignment.assignment_type = 'Project' THEN 
                    Grade.score * (Course.course_project / COALESCE(ProjectCount.count, 1))
                WHEN Assignment.assignment_type = 'Test' THEN 
                    Grade.score * (Course.course_test / COALESCE(TestCount.count, 1))
                WHEN Assignment.assignment_type = 'Participation' THEN 
                    Grade.score * (Course.course_participation / COALESCE(ParticipationCount.count, 1))
                ELSE 0
            END
        ) AS weighted_score
    FROM
        Grade
    INNER JOIN Assignment ON Grade.assignment_id = Assignment.assignment_id
    INNER JOIN Course ON Assignment.course_id = Course.course_id
    LEFT JOIN (
        SELECT course_id, COUNT(*) AS count
        FROM Assignment
        WHERE assignment_type = 'Homework'
        GROUP BY course_id
    ) AS HomeworkCount ON Course.course_id = HomeworkCount.course_id
    LEFT JOIN (
        SELECT Assignment.course_id, MIN(Grade.score) AS lowest_score
        FROM Grade
        INNER JOIN Assignment ON Grade.assignment_id = Assignment.assignment_id
        WHERE Assignment.assignment_type = 'Homework'
        GROUP BY Assignment.course_id
    ) AS LowestHomeworkGrade ON Course.course_id = LowestHomeworkGrade.course_id
    LEFT JOIN (
        SELECT course_id, COUNT(*) AS count
        FROM Assignment
        WHERE assignment_type = 'Project'
        GROUP BY course_id
    ) AS ProjectCount ON Course.course_id = ProjectCount.course_id
    LEFT JOIN (
        SELECT course_id, COUNT(*) AS count
        FROM Assignment
        WHERE assignment_type = 'Test'
        GROUP BY course_id
    ) AS TestCount ON Course.course_id = TestCount.course_id
    LEFT JOIN (
        SELECT course_id, COUNT(*) AS count
        FROM Assignment
        WHERE assignment_type = 'Participation'
        GROUP BY course_id
    ) AS ParticipationCount ON Course.course_id = ParticipationCount.course_id
    GROUP BY Grade.student_id, Grade.assignment_id
    ) AS AssignmentWeightedScores
INNER JOIN Student ON AssignmentWeightedScores.student_id = Student.student_id
WHERE
    Student.first_name = 'John' AND Student.last_name = 'Quincy';
