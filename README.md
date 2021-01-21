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
is a foreign key for course. (each course is taught by only 1 instructor,
an instructor can teach many courses)

Department and Instructor have a 1-N relationship, meaning dept_id
is a foreign key for instructor. (each instructor belongs to only 1 dept,
a department employs various instructors)

Dept and Course have an 1-N relationship, meaning dept_id is a foreign
key for course. (each course belongs to 1 dept and each dept offers many
courses)

Course and Student have a M-N relationship. I named relationship table
"takes". Table takes has a two foreign keys that make up its primary key.
course_id and student_id are the foreign keys and primary key is the combination
of course_id and student_id. For each takes relationship, there is a grade
associated with it.


INSTRUCTIONS:

Install MySQL from their website. Import this file into MySQL using command line client. 
I've inputted sample observations and sample queries that can be run. User can enter his or her own
observations and queries as well.
