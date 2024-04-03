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
  	course_quiz FLOAT,
  	course_midterm FLOAT,
  	course_final FLOAT,
  	course_participation FLOAT
);

CREATE TABLE Assignment (
    assignment_id INT PRIMARY KEY,
    assignment_name VARCHAR(100),
    max_score INT,
  	course_id INT,
  	
);

CREATE TABLE Student (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);

CREATE TABLE Grade (
    grade_id INT PRIMARY KEY,
    score INT,
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

INSERT INTO Course (course_id, department, course_number, course_name, course_semester, course_year, course_homework, course_project, course_quiz, course_midterm, course_final, course_participation) 
VALUES 
(1, 'Computer Science', 101, 'Introduction to Computer Science', 'Fall', 2024, 20, 25, 15, 20, 15, 5),
(2, 'Computer Science', 102, 'Software Engineering', 'Fall', 2024, 25, 20, 10, 25, 15, 5),
(3, 'Computer Science', 103, 'Operating Systems', 'Spring', 2024, 30, 20, 10, 20, 15, 5);       

INSERT INTO Assignment (assignment_id, assignment_name, max_score)
VALUES (1, 'Participation 1', 10),
       (2, 'Homework 1', 20),
       (3, 'Test 1', 100),
       (4, 'Project 1', 50);

INSERT INTO Student (student_id, first_name, last_name)
VALUES (1, 'John', 'Doe'),
       (2, 'Jane', 'Smith'),
       (3, 'Devin', 'Griffin'),
       (4, 'Yinka', 'Adeyemi'),
       (5, 'Peter', 'Parker'),
       (6, 'Bruce', 'Wayne');

INSERT INTO Grade (grade_id, score, student_id, assignment_id)
VALUES (1, 8, 1, 1),
       (2, 18, 1, 2),
       (3, 85, 1, 3),
       (4, 45, 1, 4),
       (5, 9, 2, 1),
       (6, 16, 2, 2),
       (7, 80, 2, 3),
       (8, 42, 2, 4);








# commands

-- Display contents of the Course table
SELECT * FROM Course;

-- Display contents of the Assignment table
SELECT * FROM Assignment;

-- Display contents of the Student table
SELECT * FROM Student;

-- Display contents of the Grade table
SELECT * FROM Grade;

# # task 4
# SELECT assignment_name, AVG(score) AS average_score
# FROM Grade
# JOIN Assignment ON Grade.assignment_id = Assignment.assignment_id
# GROUP BY assignment_name;

# SELECT assignment_name, MAX(score) AS highest_score
# FROM Grade
# JOIN Assignment ON Grade.assignment_id = Assignment.assignment_id
# GROUP BY assignment_name;

# SELECT assignment_name, MIN(score) AS lowest_score
# FROM Grade
# JOIN Assignment ON Grade.assignment_id = Assignment.assignment_id
# GROUP BY assignment_name;


-- Display everyone in Intro to Computer Science
-- SELECT Student.studentid, Student.first_name, Student.lastname
