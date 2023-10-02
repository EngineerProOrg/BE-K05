create database be05;

create table be05.professor(
	prof_id int not null,
    prof_lname varchar(50),
    prof_fname varchar(50),
    primary key (prof_id)
);

create table be05.student(
	stud_id int not null,
    stud_fname varchar(50),
    stud_lname varchar(50),
    stud_street varchar(255),
    stud_city varchar(50),
    stud_zip varchar(10),
    primary key (stud_id)
);

create table be05.course(
	course_id int not null,
    course_name varchar(255),
    primary key(course_id)
);

create table be05.room(
	room_id int not null,
    room_loc varchar(50),
    room_cap varchar(50),
    class_id int,
    primary key (room_id)
    -- foreign key (class_id) references class(class_id)
);

create table be05.class(
	class_id int not null,
    class_name varchar(255),
    prof_id int,
    course_id int,
    room_id int,
    primary key (class_id),
    foreign key (prof_id) references professor(prof_id),
    foreign key (course_id) references course(course_id),
    foreign key (room_id) references room(room_id)
);

alter table be05.room
add foreign key (class_id) references class(class_id);

create table be05.enroll(
	stud_id int not null,
    class_id int not null,
    grade varchar(3),
    primary key (stud_id, class_id),
    foreign key (stud_id) references student(stud_id),
    foreign key (class_id) references class(class_id)
);

