# Gradebook Database

By Devin Griffin, Oluwayimika Adeyemi, and Manish Niure

## Problem Statement

You are asked to implement a grade book to keep track student grades for several couses that a professor teaches. Courses should have the information of department, course number, course name, semester, and year.  For each course, the grade is caculated on various categories, including course participations, homework, tests, projects, etc.  The total percentages of the categories should add to 100% and the total perfect grade should be 100. The number of assignments from each category is unspecified, and can change at any time.  For example, a course may be graded by the distribution: 10% participation, 20% homework, 50% tests, 20% projects. Please note that if there are 5 homework, each homework is worth 20%/5=4% of the grade.

## Tasks

1. Design the ER diagram;
2. Write the commands for creating tables and inserting values;
3. Show the tables with the contents that you have inserted;
4. Compute the average/highest/lowest score of an assignment;
5. List all of the students in a given course;
6. List all of the students in a course and all of their scores on every assignment;
7. Add an assignment to a course;
8. Change the percentages of the categories for a course;
9. Add 2 points to the score of each student on an assignment;
10. Add 2 points just to those students whose last name contains a ‘Q’.
11. Compute the grade for a student;
12. Compute the grade for a student, where the lowest score for a given category is dropped.

## ER Diagram

![image](https://github.com/dagrif1223/GradebookDatabase/assets/104702278/eb8dd536-3f63-47cd-8145-112ab23da375)

## Execution Instructions

Head to the free online environment dbfiddle.uk, select the "MySQL" engine from the list of engines, then paste the sql code from this repository onto the textbox(es) and hit run.
