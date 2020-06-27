# 1.Query the existence of 1 course
--我不是很明白该小题的意思，所以写了两种
select * from student 
where exists (
select * from student_course as sc
where sc.courseId=1
and student.id=sc.studentId
)

select * from student_course where courseId=1

# 2.Query the presence of both 1 and 2 courses
select * from 
(select * from student_course where courseId=1) as c1,
(select * from student_course where courseId=2) as c2
where c1.studentId=c2.studentId

# 3.Query the student number and student name and average score of students whose average score is 60 or higher.
select s.id,s.name,c.a
from student as s,
(select studentId, avg(score) as a from student_course
group by studentId
having avg(score)>=60) as c
where s.id=c.studentId

# 4.Query the SQL statement of student information that does not have grades in the student_course table
select * from student as s
where not exists (select * from student_course as c  where s.id=c.studentId)

# 5.Query all SQL with grades
SELECT * FROM student
where id=any (select studentId from student_course group by studentId)

# 6.Inquire about the information of classmates who have numbered 1 and also studied the course numbered 2
select distinct s1.id
from
(select a.id
from student as a
inner join student_course as b
on a.id=b.studentId
inner join student_course as c
on b.studentId=c.studentId and c.courseId=1) as s1 
inner join (select a.id
from student as a
inner join student_course as b
on a.id=b.studentId
inner join student_course as c
on b.studentId=c.studentId and c.courseId=2) as s2
on s1.id=s2.id

# 7.Retrieve 1 student score with less than 60 scores in descending order
select student.* from student,(
select * from student_course 
where score<60  and courseId=1
order by score desc) as c
where student.id=c.studentId

# 8.Query the average grade of each course. The results are ranked in descending order of average grade. When the average grades are the same, they are sorted in ascending order by course number.
select courseId,avg(score) from student_course 
group by courseId
order by avg(score) desc,courseId asc

# 9.Query the name and score of a student whose course name is "Math" and whose score is less than 60
select s.name,sc.score from
student as s,student_course as sc,course as c
where s.id=sc.studentId and sc.courseId=c.id and c.name="Math" and sc.score<60 
