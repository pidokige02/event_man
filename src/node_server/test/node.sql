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


출처: https://sungwookkang.com/1214 [Data Science Lab]
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
