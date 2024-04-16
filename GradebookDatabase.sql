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
(2, 'Computer Science', 102, 'Software Engineering', 'Fall', 2024, .25, .20, .45, .10),
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
(12, 0.94, 2, 6),
(13, 0.92, 3, 7),
(14, 0.98, 4, 7),
(15, 0.65, 3, 8),
(16, 0.84, 4, 8),
(17, 0.93, 3, 9),
(18, 0.89, 4, 9),
(19, 0.84, 3, 10),
(20, 0.84, 4, 10),
(21, 0.96, 3, 11),
(22, 0.75, 4, 11),
(23, 0.89, 5, 12),
(24, 0.73, 6, 12),
(25, 0.80, 5, 13),
(26, 0.68, 6, 13),
(27, 0.91, 5, 14),
(28, 0.77, 6, 14),
(29, 0.59, 5, 15),
(30, 0.85, 6, 15);

-- (task 3)
-- Display contents of the Course table
SELECT * FROM Course;

-- Display contents of the Assignment table
SELECT * FROM Assignment;

-- Display contents of the Student table
SELECT * FROM Student;

-- Display contents of the Grade table
SELECT * FROM Grade;

-- Display enrolled list
SELECT * FROM EnrolledList;

-- Display average/highest/lowest of an assignment (task 4)
SELECT AVG(Grade.score * 100)
FROM Grade
WHERE Grade.assignment_id = 1;

SELECT MAX(Grade.score * 100)
FROM Grade
WHERE Grade.assignment_id = 1;

SELECT MIN(Grade.score * 100)
FROM Grade
WHERE Grade.assignment_id = 1;

-- Display every student from a course (task 5)
SELECT EnrolledList.student_id, Student.first_name, Student.last_name, Course.course_name
FROM Student, Course, EnrolledList
WHERE EnrolledList.student_id = Student.student_id AND EnrolledList.course_id = Course.course_id AND Course.course_id = 2;

-- List all students in a course and their scores on every assignment (task 6)
SELECT Grade.student_id, Student.first_name, Student.last_name, Assignment.assignment_name, Grade.score
FROM Grade
JOIN Student ON Grade.student_id = Student.student_id
JOIN Assignment ON Grade.assignment_id = Assignment.assignment_id
WHERE Assignment.course_id = 1;

-- Add an assignment to a course (task 7)
INSERT INTO Assignment (assignment_id, assignment_name, assignment_type, course_id)
VALUE (16, 'Test 2', 'Test', 3);
SELECT * FROM Assignment

-- Change the percentages of the categories for a course (task 8)
UPDATE Course
SET course_homework = .20, course_project = .40, course_test = .30, course_participation = .10
WHERE course_id = 3;
SELECT * FROM Course

-- Add 2 points to the score of each student on an assignment (task 9)
UPDATE Grade
SET score = score + .02 
WHERE assignment_id = 1;
SELECT * FROM Grade

-- Add 2 points just to those students whose last name contains a ‘Q’ (task 10)
UPDATE Grade
JOIN Student ON Grade.student_id = Student.student_id
SET score = score + .02
WHERE Student.last_name LIKE '%Q%';

SELECT Grade.*, Student.first_name, Student.last_name
FROM Grade, Student
WHERE Grade.student_id = Student.student_id

-- Compute the grade for a student (task 11)
WITH AssignmentWeights AS (
    SELECT 
        c.course_id,
        c.course_homework,
        c.course_project,
        c.course_test,
        c.course_participation
    FROM Course c
),
StudentScores AS (
    SELECT 
        g.student_id,
        a.assignment_type,
        AVG(g.score) as avg_score,
        a.course_id,
        st.first_name,
        st.last_name
    FROM Grade g
    JOIN Assignment a ON g.assignment_id = a.assignment_id
    JOIN Student st ON g.student_id = st.student_id
    WHERE g.student_id = 4
    GROUP BY g.student_id, a.assignment_type, a.course_id, st.first_name, st.last_name
)
SELECT 
    s.student_id,
    s.first_name,
    s.last_name,
    aw.course_id,
    COALESCE(SUM(CASE WHEN s.assignment_type = 'Homework' THEN s.avg_score * aw.course_homework END), 0) +
    COALESCE(SUM(CASE WHEN s.assignment_type = 'Project' THEN s.avg_score * aw.course_project END), 0) +
    COALESCE(SUM(CASE WHEN s.assignment_type = 'Test' THEN s.avg_score * aw.course_test END), 0) +
    COALESCE(SUM(CASE WHEN s.assignment_type = 'Participation' THEN s.avg_score * aw.course_participation END), 0) as final_grade
FROM StudentScores s
JOIN AssignmentWeights aw ON s.course_id = aw.course_id
GROUP BY s.student_id, s.first_name, s.last_name, aw.course_id;

-- Compute the grade for a student, where the lowest score for a given category is dropped (task 12)
WITH LowestHomeworkScore AS (
    SELECT 
        g.student_id,
        MIN(g.score) as lowest_homework_score
    FROM Grade g
    JOIN Assignment a ON g.assignment_id = a.assignment_id
    WHERE a.assignment_type = 'Homework'
    GROUP BY g.student_id
),
FilteredGrades AS (
    SELECT 
        g.student_id,
        g.assignment_id,
        g.score
    FROM Grade g
    JOIN LowestHomeworkScore lhs ON g.student_id = lhs.student_id
    WHERE g.score > lhs.lowest_homework_score OR g.assignment_id <> (
        SELECT assignment_id
        FROM Grade
        WHERE student_id = g.student_id AND score = lhs.lowest_homework_score AND assignment_id IN (
            SELECT assignment_id
            FROM Assignment
            WHERE assignment_type = 'Homework'
        )
    )
),
AssignmentWeights AS (
    SELECT 
        c.course_id,
        c.course_homework,
        c.course_project,
        c.course_test,
        c.course_participation
    FROM Course c
),
StudentScores AS (
    SELECT 
        f.student_id,
        a.assignment_type,
        AVG(f.score) as avg_score,
        a.course_id,
        st.first_name,
        st.last_name
    FROM FilteredGrades f
    JOIN Assignment a ON f.assignment_id = a.assignment_id
    JOIN Student st ON f.student_id = st.student_id
    GROUP BY f.student_id, a.assignment_type, a.course_id, st.first_name, st.last_name
),
FinalGrade AS (
    SELECT 
        s.student_id,
        s.first_name,
        s.last_name,
        aw.course_id,
        (COALESCE(SUM(CASE WHEN s.assignment_type = 'Homework' THEN s.avg_score * aw.course_homework END), 0) +
         COALESCE(SUM(CASE WHEN s.assignment_type = 'Project' THEN s.avg_score * aw.course_project END), 0) +
         COALESCE(SUM(CASE WHEN s.assignment_type = 'Test' THEN s.avg_score * aw.course_test END), 0) +
         COALESCE(SUM(CASE WHEN s.assignment_type = 'Participation' THEN s.avg_score * aw.course_participation END), 0)) as final_grade
    FROM StudentScores s
    CROSS JOIN AssignmentWeights aw
    GROUP BY s.student_id, s.first_name, s.last_name, aw.course_id
)
SELECT 
    f.student_id,
    f.first_name,
    f.last_name,
    f.course_id,
    f.final_grade
FROM FinalGrade f
JOIN EnrolledList el ON f.student_id = el.student_id AND f.course_id = el.course_id
WHERE f.student_id = 3;
