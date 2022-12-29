drop table Event;

create table Event(
id tinyint unsigned not null auto_increment,
title varchar(31) not null,
date DATE NOT NULL DEFAULT '2022-05-11',
time TIME NOT NULL DEFAULT "23:59:59",
location varchar(64) not null,
description varchar(128) not null,
organizer varchar(31) not null,
category varchar(64) not null,
PRIMARY KEY(id)
);

insert into Event(title, location, description, organizer, category)
values ('Beach Cleanup','Daytona Beach','Let\'s clean up this beach','Adam Jahr','sustainability'),
('Park Cleanup','132 N Magnolia Street, Orlando, Florida','We\'re going to clean up this park.','Adam Jahr','sustainability' ),
('Pet Adoption Day','132 N Magnolia Street, Orlando, Florida','Help animals find new homes.','Gregg Pollack', 'animal welfare'),
('Disco Party','Daytona Beach','Let\'s clean up this beach','Adam Jahr','sustainability'),
('Vue Users Group','132 N Magnolia Street, Orlando, Florida','We\'re going to clean up this park','Adam Jahr','nature');


select * from Event;

select * from Event where id='2';

select * from Event LIMIT 3 3; -- get 3 records beginning with row 4

SELECT COUNT(*) FROM Event;

insert into Event(title, location, description, organizer, category) value( "Church Event1", "YongIn", "worship the God on Sunday", "Adam", "sustainability" );

delete from Event where id=10;

delete from Event where id=11;

delete from Event where id=12;


create table Attendees(
id varchar(31) not null,
name varchar(31) not null,
id tinyint unsigned not null
);


create table category(
id tinyint unsigned not null,
title varchar(31) not null
);

insert into category (id, title)
value ('0','sustainability'),
('1','nature'),
('2','animal welfare'),
('3','housing'),
('4','education'),
('5','food'),
('6','community');


create table User(
id tinyint unsigned not null auto_increment,
uid varchar(31) not null,
upw varchar(31) not null,
uname varchar(31) not null,
PRIMARY KEY(id)
);

create table User(
id tinyint unsigned not null auto_increment,
lastlogin DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
uid varchar(31) not null,
upw varchar(31) not null,
uname varchar(31) not null,
PRIMARY KEY(id)
);

ALTER TABLE User ADD COLUMN lastlogin DATETIME;

insert into User(uid, upw, uname) values ('go','0','황규성'), ('google','0','황규영'), ('gosang','0','황진하'), ('naver','0','권소현');

insert into User(uid, upw, uname) values ('user1','0','김일수'), ('user2','0','김이수');

update User set lastlogin=now() where uid='user1';
update User set lastlogin=now() where uid='user2';

select * from User where uid='user2';

select * from User;

select uid, lastlogin from User where uid in ('user1', 'user2');  -- js test\mysqltest2.js 의 유효성 검증에 사용한 code 임.

select * from User where uid='user1';

-- test script for phase 2  update
create table Event2(
id int unsigned not null PRIMARY KEY auto_increment COMMENT 'primary Key',
event_id int unsigned not null ,
category varchar(64) not null,
organizer varchar(31) not null,
title varchar(31) not null,
description varchar(128) not null,
location varchar(64) not null,
date DATE NOT NULL DEFAULT '2022-05-11',
time TIME NOT NULL DEFAULT "23:59:59"
);

SHOW TABLE STATUS LIKE 'Event2';
SELECT * FROM   INFORMATION_SCHEMA.COLUMNS WHERE  TABLE_NAME = 'Event2';

create table Attendees(
person_id varchar(31) not null ,
name varchar(31) not null COMMENT 'attendee name',
event_id int unsigned,
FOREIGN KEY(event_id) REFERENCES Event2(id) ON DELETE SET NULL
);

SELECT * FROM  INFORMATION_SCHEMA.COLUMNS WHERE  TABLE_NAME = 'Attendees';

insert into Event2(event_id, title, date, time, location, description, organizer, category)
values (1,'Beach Cleanup','2018-8-28','12:10:30','Daytona Beach','Let\'s clean up this beach','Adam Jahr','sustainability'),
(2,'Park Cleanup','2018-11-28','13:00:00','132 N Magnolia Street, Orlando, Florida','We\'re going to clean up this park.','Adam Jahr','sustainability' ),
(3,'Pet Adoption Day','2018-12-02','14:30:00','132 N Magnolia Street, Orlando, Florida','Help animals find new homes.','Gregg Pollack', 'animal welfare'),
(4,'Disco Party','2018-08-28','14:10:10','Daytona Beach','Let\'s clean up this beach','Adam Jahr','sustainability'),
(5,'Vue Users Group','2018-11-12','15:00:00','132 N Magnolia Street, Orlando, Florida','We\'re going to clean up this park','Adam Jahr','nature');

insert into Attendees(person_id, name, event_id)
values 	("abc123", "Adam Jahr", 1),
		("def456", "Gregg Pollack", 1),
        ("ghi789", "Beth Swanson", 1),
        ("jkl101", "Mary Gordon", 1),
		("ghi789", "Beth Swanson",2),
        ("jkl101", "Mary Gordon", 2),
        ("abc123", "Adam Jahr", 3),
        ("ghi789", "Beth Swanson", 3),
        ("jkl101", "Mary Gordon", 3),
		("abc123", "Adam Jahr", 4),
		("def456", "Gregg Pollack", 4),
		("ghi789", "Beth Swanson", 4),
		("jkl101", "Mary Gordon",4),
        ("ghi789", "Beth Swanson", 5 ),
        ("jkl101", "Mary Gordon", 5);

SELECT * FROM Event2;
SELECT * FROM Attendees;

DROP TABLE Attendees;
select COUNT(*) from Event2