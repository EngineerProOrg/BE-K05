-- những cặp student-professor có dạy học nhau và số lớp mà họ có liên quan
select p.prof_id, e.stud_id, count(*) as 'no_of_class'
from professor as p join class as c on p.prof_id = c.prof_id
join enroll as e on e.class_id
group by p.prof_id, e.stud_id;

-- những course (distinct) mà 1 professor cụ thể đang dạy
select distinct c.course_id, c.course_name, p.prof_id, p.prof_fname, p.prof_lname
from professor as p join class as cl on p.prof_id = cl.prof_id
join course as c on cl.course_id = c.course_id;

-- những course (distinct) mà 1 student cụ thể đang học
select distinct c.course_id, c.course_name, s.stud_id, s.stud_fname, s.stud_lname
from student as s join enroll as e on s.stud_id = e.stud_id
join class as cl on e.class_id = cl.class_id
join course as c on c.course_id = cl.course_id;

-- điểm số là A, B, C, D, E, F tương đương với 10, 8, 6, 4, 2, 0

-- điểm số trung bình của 1 học sinh cụ thể (quy ra lại theo chữ cái, và xếp loại học lực (weak nếu avg < 5, average nếu >=5 < 8, good nếu >=8 )
select t.stud_id, t.stud_fname, t.stud_lname,
case when t.avg_grade_num < 5 then 'Weak'
	 when t.avg_grade_num >= 8 then 'Good'
	 else 'Average'
	end as classification,
case when t.avg_grade_num = 10 then 'A'
	 when t.avg_grade_num = 8 then 'B'
     when t.avg_grade_num = 6 then 'C'
     when t.avg_grade_num = 4 then 'D'
     when t.avg_grade_num = 2 then 'E'
     when t.avg_grade_num = 0 then 'F'
end as avg_grade_letter
from (
	select s.stud_id, s.stud_fname, s.stud_lname, avg(e.grade_num) as 'avg_grade_num'
    from (
		select * , case when grade = 'A' then 10
						when grade = 'B' then 8
						when grade = 'C' then 6
						when grade = 'D' then 4
						when grade = 'E' then 2
						when grade = 'F' then 0
					end as grade_num
		from enroll
	) as e join student as s on s.stud_id = e.stud_id 
    group by s.stud_id
) as t;

-- điểm số trung bình của các class (quy ra lại theo chữ cái)
select t.class_id, t.class_name,
case when t.avg_grade_num = 10 then 'A'
	 when t.avg_grade_num = 8 then 'B'
     when t.avg_grade_num = 6 then 'C'
     when t.avg_grade_num = 4 then 'D'
     when t.avg_grade_num = 2 then 'E'
     when t.avg_grade_num = 0 then 'F'
end as avg_grade_letter
from (
	select cl.class_id, cl.class_name, avg(e.grade_num) as 'avg_grade_num'
    from (
		select * , case when grade = 'A' then 10
						when grade = 'B' then 8
						when grade = 'C' then 6
						when grade = 'D' then 4
						when grade = 'E' then 2
						when grade = 'F' then 0
					end as grade_num
		from enroll
	) as e join class as cl on cl.class_id = e.class_id 
    group by cl.class_id
) as t;

-- điểm số trung bình của các course (quy ra lại theo chữ cái)
select t.course_id, t.course_name,
case when t.avg_grade_num = 10 then 'A'
	 when t.avg_grade_num = 8 then 'B'
     when t.avg_grade_num = 6 then 'C'
     when t.avg_grade_num = 4 then 'D'
     when t.avg_grade_num = 2 then 'E'
     when t.avg_grade_num = 0 then 'F'
end as avg_grade_letter
from (
	select c.course_id, c.course_name, avg(e.grade_num) as 'avg_grade_num'
    from (
		select * , case when grade = 'A' then 10
						when grade = 'B' then 8
						when grade = 'C' then 6
						when grade = 'D' then 4
						when grade = 'E' then 2
						when grade = 'F' then 0
					end as grade_num
		from enroll
	) as e join class as cl on cl.class_id = e.class_id 
    join course as c on c.course_id = cl.course_id
    group by c.course_id
) as t