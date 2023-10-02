-- student, professor, class with class in common
SELECT
	CONCAT(pr.prof_fname, '', pr.prof_lname) AS professor,
	CONCAT(st.stud_fname, '', st.stud_lname) AS student,
	cl.class_name
FROM
	Professor pr
	JOIN Class cl ON pr.prof_id = cl.prof_id
	JOIN Enroll en ON cl.class_id = en.class_id
	JOIN Student st ON st.stud_id = en.stud_id;
	
-- courses that 1 professor is teaching	
SELECT DISTINCT
	c.course_name,
	CONCAT(pr.prof_fname, '', pr.prof_lname) AS professor
FROM
	Professor pr
	JOIN Class cl USING (prof_id)
	JOIN Course c USING (course_id)

-- courses that 1 student is enrolling
SELECT DISTINCT
	c.course_name,
	CONCAT(st.stud_fname, '', st.stud_lname) AS student
FROM
	Student st
	JOIN Enroll e USING (stud_id)
	JOIN Class cl USING (class_id)
	JOIN Course c USING (course_id);


-- match grade in number with CHARACTER
DROP VIEW IF EXISTS grade_in_number;
CREATE VIEW grade_in_number AS
SELECT
	(
		CASE WHEN grade = 'A' THEN
			10
		WHEN grade = 'B' THEN
			8
		WHEN grade = 'C' THEN
			6
		WHEN grade = 'D' THEN
			4
		WHEN grade = 'E' THEN
			2
		WHEN grade = 'F' THEN
			0
		END) AS grade_number, stud_id, class_id, grade
FROM
	Enroll;

SELECT *
FROM grade_in_number

SELECT st.stud_fname, gd.grade_number, e.class_id
FROM 
	Student st 
	JOIN Enroll e USING (stud_id)
	JOIN grade_in_number gd USING (stud_id)

-- avg grade in CHARACTER of 1 student
SELECT
	CONCAT(stud_fname, " ", stud_lname) as stud_name,
	ROUND(AVG(
	CASE
		WHEN grade = 'A' THEN 10
		WHEN grade = 'B' THEN 8
		WHEN grade = 'C' THEN 6
		WHEN grade = 'D' THEN 4
		WHEN grade = 'E' THEN 2
        WHEN grade = 'F' THEN 0
	END
	), 2) as academic_ability
FROM Enroll en
JOIN Student st
	ON st.stud_id = en.stud_id
GROUP BY CONCAT(stud_fname, " ", stud_lname);
	
-- avg grade of a class
SELECT
	class_name,
	ROUND(AVG(
		CASE WHEN grade = 'A' THEN
			10
		WHEN grade = 'B' THEN
			8
		WHEN grade = 'C' THEN
			6
		WHEN grade = 'D' THEN
			4
		WHEN grade = 'E' THEN
			2
		WHEN grade = 'F' THEN
			0
		END), 2) AS grade
FROM
	Enroll en
	JOIN Class cl USING (class_id)
GROUP BY
	class_name;

-- avg grade of course
SELECT
	cr.course_name,
	ROUND(AVG(
			CASE WHEN grade = 'A' THEN
				10
			WHEN grade = 'B' THEN
				8
			WHEN grade = 'C' THEN
				6
			WHEN grade = 'D' THEN
				4
			WHEN grade = 'E' THEN
				2
			WHEN grade = 'F' THEN
				0
			END), 2) AS grade
FROM
	Enroll en
	JOIN Class cl USING (class_id)
	JOIN Course cr USING (course_id)
GROUP BY
	course_name;


