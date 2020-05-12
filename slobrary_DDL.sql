CREATE DATABASE `slo` DEFAULT CHARACTER SET utf8 ;

use slo;


create table admin_info(
	id varchar(20) primary key,
    passwd varchar(20) not null,
    name varchar(15) not null,
    phone char(11) not null UNIQUE,
    add_date TIMESTAMP DEFAULT NOW(),
    a_rank varchar(10) not null
);

alter table admin_info modify passwd longtext not null;
alter table admin_info modify a_rank varchar(10);
alter table admin_info modify passwd varchar(512) not null;

create table member(
	mem_id varchar(20) primary key,
    RFID longtext,
    passwd longtext not null,
    name varchar(15) not null,
	gender char(1) not null,
    phone char(11) not null UNIQUE,
    birth date not null,
    adress longtext not null,
    email varchar(20) not null UNIQUE,
    loan_status char(3) not null,
    add_date timestamp default now()
);

alter table member modify column withdrawal timestamp;
alter table member modify passwd varchar(512) not null;
alter table member change adress address varchar(100) not null;
alter table member modify loan_status varchar(15) default '대출가능';

create table main_class(
	m_id char(1) primary key,
    m_name varchar(15) not null unique
);



create table sub_class(
	s_id char(3) primary key,
    s_name longtext not null,
    m_id char(1) not null,
    constraint fk_class foreign key(m_id) references main_class(m_id)
);

alter table sub_class modify s_name varchar(100) not null;

create table book_info(
	id_num varchar(20) primary key,
    type varchar(10),
    name longtext not null,
    author longtext not null,
    publisher varchar(15) not null,
    issue longtext not null,
    form longtext not null,
    ISBN bigint not null unique,
    class_id char(3) not null,
    language varchar(10) not null,
    collector text not null,
    sign varchar(20) not null unique,
    status char(5) not null,
    image longblob,
    constraint fk_classid foreign key(class_id) references sub_class(s_id)
);

alter table book_info modify name varchar(100) not null;
alter table book_info modify author varchar(100) not null;
alter table book_info modify issue varchar(200) not null;
alter table book_info modify form varchar(200) not null;
alter table book_info modify image varchar(20) default "noimage.png";
alter table book_info modify ISBN bigint not null;



create table book_loan(
	loan_id int NOT NULL AUTO_INCREMENT,
	mem_id varchar(20) not null,
    id_num varchar(20) not null,
    loan_date timestamp default now(),
    ex_num int not null,
    return_date date not null,
    return_type varchar(10),
    constraint fk_memid foreign key(mem_id) references member(mem_id),
    constraint fk_idnum foreign key(id_num) references book_info(id_num),
    primary key(loan_id)
);

create table wish_list(
	wish_id int NOT NULL AUTO_INCREMENT,
    mem_id varchar(40) not null,
    book_name varchar(40) not null,
    book_author varchar(20) not null,
    publish varchar(20) not null,
    wish_date timestamp default now(),
    status varchar(15) not null,
    primary key(wish_id),
    constraint fk_wishmem foreign key(mem_id) references member(mem_id)
);
alter table wish_list modify column status varchar(15) default "신청중";

create table watch_list(
	watch_id int not null auto_increment,
	mem_id varchar(20) not null,
    book_id varchar(40) not null,
    watch_date timestamp default now(),
    primary key(watch_id),
    constraint fk_watchmem foreign key(mem_id) references member(mem_id),
    constraint fk_bookatch foreign key(book_id) references book_info(id_num)
);


create table recommend(
	reco_id int not null auto_increment,
    book_id varchar(40) not null,
    reco_date timestamp default now(),
    primary key(reco_id),
    constraint fk_reco foreign key(book_id) references book_info(id_num)
);

create table notice(
	num int not null auto_increment,
    admin_id varchar(20),
    date timestamp default now(),
    name varchar(50) not null,
    content mediumtext not null,
    primary key(num),
    constraint fk_notice foreign key(admin_id) references admin_info(id)
);



