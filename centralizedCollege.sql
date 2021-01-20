drop table takes;
drop table student;
drop table course;
drop table instructor;
drop table department;
CREATE TABLE department(
    numInstructors INT,
    name VARCHAR(20),
    dept_id INT PRIMARY KEY
);CREATE TABLE instructor(
    name VARCHAR(20),
    instructor_id INT PRIMARY KEY,
    age INT,
    dept_id int,
    FOREIGN KEY (dept_id) REFERENCES department(dept_id) on delete
    set
        null
);CREATE TABLE course(
    name VARCHAR(20),
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    dept_id INT,
    instructor_id INT,
    FOREIGN KEY (instructor_id) REFERENCES instructor(instructor_id) on delete
    set
        null,
        FOREIGN KEY (dept_id) REFERENCES department(dept_id) on delete
    set
        null
);CREATE TABLE student(
    name VARCHAR(20),
    student_id INT PRIMARY KEY
);
CREATE TABLE takes(
    grade VARCHAR(2),
    course_id int,
    student_id int,
    FOREIGN KEY (course_id) REFERENCES course(course_id) on delete cascade,
    FOREIGN KEY (student_id) REFERENCES student(student_id) on delete cascade,
    PRIMARY KEY(course_id, student_id)
);

/*
Rules:
Each instructor is part of only one department,
A department can have multiple instructors,
Each instructor teaches atleast one course,
each course is taught by 1 instructor,
Each course is offered by 1 department,
A department offers multiple courses,
Each student takes multiple courses,
each course is taken by multiple students,
each instructor instructs multiple students,
each student has many instructors

CONSTRUCTED USING ER DIAGRAM

Instructor and course have a 1-N relationship, meaning instructor_id
is a foreign key for course. (each course is taught by only 1 instructor)
Department and Instructor have a 1-N relationship, meaning dept_id
is a foreign key for instructor. (each instructor belongs to only 1 dept)
Dept and Course have an 1-N relationship, meaning dept_id is a foreign
key for course. (each course belongs to 1 dept and each dept offers many
courses)
Course and Student have a M-N relationship. I named relationship table
"takes". Table takes has a two foreign keys that make up its primary key.
course_id and student_id are the foreign keys and primary key is the combination
of course_id and student_id. For each takes relationship, there is a grade
associated with it.

*/
/*Insert abritrary values:
*/
Insert into department VALUES(3, 'History', 1);
Insert into department VALUES(3, 'Math', 2);
Insert into department VALUES(3, 'English', 3);

Insert into student VALUES ('Arvind', 1);
insert into student values ('Jack', 2);
Insert into student values ('Jill', 3);
Insert into student VALUES('John', 4);
Insert into student VALUES('John', 5);
Insert into student VALUES('Ryan', 6);
Insert into student VALUES('Frank', 7);

Insert into Instructor VALUES('Shareshian', 1, 68, 2);
Insert into Instructor VALUES('Krantz', 2, 28, 2);
Insert into Instructor VALUES('Kurenok', 3, 58, 2);

Insert into Instructor VALUES('Rees', 4, 49, 1);
Insert into Instructor VALUES('Janda', 5, 43, 1);
Insert into Instructor VALUES('Green', 6, 43, 1);

Insert into Instructor VALUES('Hurshman', 7, 51, 3);
Insert into Instructor VALUES('Barth', 8, 42, 3);
Insert into Instructor VALUES('Shuttleworth', 9, 47, 3);

Insert into course VALUES('Intro Combinatorics', 1, 2, 1);
Insert into course VALUES('Stochastic Processes', 2, 2, 3);
Insert into course VALUES('U.S. History', 3, 1, 4);
Insert into course VALUES('Shakespeare', 4, 3, 9);
Insert into course VALUES('English Lit', 5, 3, 8);
Insert into course VALUES('World History', 6, 1, 5);
Insert into course VALUES('Discrete Math', 7, 2, 2);
Insert into course VALUES('US Gov', 8, 1, 6);
Insert into course VALUES('British Lit', 9, 3, 7);
Insert into course VALUES('French Hist', 10, 1, 7);
Insert into course VALUES('Calculus', 11, 2, 8);

Insert into takes VALUES('A', 1, 1);
Insert into takes VALUES('A', 2, 1);
Insert into takes VALUES('B+', 3, 1);
Insert into takes VALUES('A', 4, 1);
Insert into takes VALUES('A', 10, 1);
Insert into takes VALUES('A', 7, 1);

Insert into takes VALUES('A-', 5, 2);
Insert into takes VALUES('A', 11, 2);
Insert into takes VALUES('C', 3, 2);
Insert into takes VALUES('A', 1, 2);
Insert into takes VALUES('A', 10, 2);

Insert into takes VALUES('B+', 7, 3);
Insert into takes VALUES('A', 8, 3);
Insert into takes VALUES('A', 2, 3);
Insert into takes VALUES('A', 3, 3);
Insert into takes VALUES('A', 5, 3);
Insert into takes VALUES('A', 6, 3);

Insert into takes VALUES('C', 2, 4);
Insert into takes VALUES('A', 11, 4);
Insert into takes VALUES('A-', 4, 4);
Insert into takes VALUES('A', 6, 4);
Insert into takes VALUES('D', 10, 4);

Insert into takes VALUES('B+', 9, 5);
Insert into takes VALUES('A', 6, 5);
Insert into takes VALUES('B-', 7, 5);
Insert into takes VALUES('A', 11, 5);
Insert into takes VALUES('A', 10, 5);
Insert into takes VALUES('C', 8, 5);

Insert into takes VALUES('A', 8, 6);
Insert into takes VALUES('A-', 9, 6);
Insert into takes VALUES('A', 1, 6);
Insert into takes VALUES('C+', 5, 6);

Insert into takes VALUES('A', 9, 7);
Insert into takes VALUES('B-', 5, 7);
Insert into takes VALUES('C+', 3, 7);
Insert into takes VALUES('A-', 6, 7);
Insert into takes VALUES('A', 10, 7);




/* Sample Queries:
List all classes that hurshman teaches: Basic
*/
Select course.name
FROM course
WHERE instructor_id = 7;
/*
List all classes that Jack is taking: Nested Query
*/
SELECT course.name
FROM course
WHERE course_id IN (
    Select takes.course_id
    From takes
    where student_id = 2
);
/*
List all classes that Jack is taking where Hurshman is the teacher:
*/
SELECT course.name
FROM course
WHERE instructor_id = 7 AND course_id IN (
    Select takes.course_id
    From takes
    where student_id = 2
);
/*
What classes does the english department offer?
*/
SELECT course.name
FROM course
WHERE dept_id = (
    SELECT dept_id
    FROM department
    WHERE department.name = 'English'
);
/*
List all math classes taught by Shareshian:
*/
Select course.name
FROM course
WHERE instructor_id = (
    SELECT instructor_id
    FROM instructor
    WHERE instructor.name = 'Shareshian'
) AND course.dept_id = (
    SELECT dept_id
    FROM department
    WHERE department.name = 'Math'
);
/*
List all students names:
*/
Select student.name
FROM student;
/*
List the grades that students got in Intro to Combinatorics:
*/
Select takes.grade
FROM takes
WHERE takes.course_id = (
    Select course_id
    FROM course
    WHERE course.name = 'Intro Combinatorics'
);

/*
Compute GPA of students in Stochastic Processes.
*/
SELECT AVG(
CASE
    WHEN(takes.grade = 'A' or takes.grade = 'A+')
    THEN 4.0
    WHEN(takes.grade = 'A-')
    THEN 3.7
    WHEN(takes.grade = 'B+')
    THEN 3.3
    WHEN(takes.grade = 'B')
    THEN 3.0
    WHEN(takes.grade = 'B-')
    THEN 2.7
    WHEN(takes.grade = 'C+')
    THEN 2.3
    WHEN(takes.grade = 'C')
    THEN 2.0
    WHEN(takes.grade = 'C-')
    THEN 1.7
    WHEN(takes.grade = 'D+')
    THEN 1.3
    WHEN(takes.grade = 'D')
    THEN 1.0
    WHEN(takes.grade = 'D-')
    THEN 0.7
    ELSE 0
END
)
FROM takes
WHERE course_id = (
    SELECT course_id
    FROM course
    WHERE course.name = 'Stochastic Processes'
);

/*
Compute Avg GPA of All Students
*/
SELECT AVG(
CASE
    WHEN(takes.grade = 'A' or takes.grade = 'A+')
    THEN 4.0
    WHEN(takes.grade = 'A-')
    THEN 3.7
    WHEN(takes.grade = 'B+')
    THEN 3.3
    WHEN(takes.grade = 'B')
    THEN 3.0
    WHEN(takes.grade = 'B-')
    THEN 2.7
    WHEN(takes.grade = 'C+')
    THEN 2.3
    WHEN(takes.grade = 'C')
    THEN 2.0
    WHEN(takes.grade = 'C-')
    THEN 1.7
    WHEN(takes.grade = 'D+')
    THEN 1.3
    WHEN(takes.grade = 'D')
    THEN 1.0
    WHEN(takes.grade = 'D-')
    THEN 0.7
    ELSE 0
END
)
FROM takes;

/*
Compute GPA of all of Barth's students in both classes
*/
SELECT AVG(
CASE
    WHEN(takes.grade = 'A' or takes.grade = 'A+')
    THEN 4.0
    WHEN(takes.grade = 'A-')
    THEN 3.7
    WHEN(takes.grade = 'B+')
    THEN 3.3
    WHEN(takes.grade = 'B')
    THEN 3.0
    WHEN(takes.grade = 'B-')
    THEN 2.7
    WHEN(takes.grade = 'C+')
    THEN 2.3
    WHEN(takes.grade = 'C')
    THEN 2.0
    WHEN(takes.grade = 'C-')
    THEN 1.7
    WHEN(takes.grade = 'D+')
    THEN 1.3
    WHEN(takes.grade = 'D')
    THEN 1.0
    WHEN(takes.grade = 'D-')
    THEN 0.7
    ELSE 0
END
)
FROM takes
WHERE course_id IN (
    SELECT course_id
    FROM course
    WHERE instructor_id = (
        SELECT instructor_id
        FROM instructor
        WHERE instructor.name = 'Barth'
    )
);
