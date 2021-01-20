# CentralizedCollege
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
