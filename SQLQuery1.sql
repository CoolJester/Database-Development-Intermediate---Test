create schema N19342975;

create table N19342975.Employees(
	Employee_ID varchar(5) not null primary key,
	Employee_Name varchar(30) not null,
	Employee_Surname varchar(30) not null,
	Date_Of_Birth Date not null
);

create table N19342975.Doctors(
	Doctor_ID varchar(5) not null primary key,
	Doctor_Name varchar(30) not null
);

create table N19342975.Employee_Sickleave(
	Employee_ID varchar(5) not null foreign key references N19342975.Employees(Employee_ID),
	Doctor_ID varchar(5) not null foreign key references N19342975.Doctors(Doctor_ID),
	Start_Date Date not null,
	Number_Of_Days smallint not null,
	primary key(Employee_ID, Doctor_ID, Start_Date)
);

insert into N19342975.Employees
values	('I0001', 'Dominique', 'Woolridge', '1993-04-19'),
		('I0002', 'Nico', 'Baird', '1991-11-19'),
		('I0003', 'Derek', 'Moore', '1992-06-24'),
		('I0004', 'Neo', 'Petlele', '1993-12-29'),
		('I0005', 'Andrew', 'Crouch', '1994-01-30');

select * from N19342975.Employees;

insert into N19342975.Doctors
values	('D0001', 'Thabo Ntlali'),
		('D0002', 'Deon Coetzee'),
		('D0003', 'Kwezi Mbete'),
		('D0004', 'Trevor January'),
		('D0005', 'Julia Robins');

select * from N19342975.Doctors;

insert into N19342975.Employee_Sickleave
values	('I0001', 'D0004', '2019-01-25', 2),
		('I0002', 'D0001', '2019-05-14', 1),
		('I0003', 'D0003', '2019-06-07', 5),
		('I0003', 'D0002', '2019-06-29', 15),
		('I0004', 'D0001', '2019-08-01', 3),
		('I0005', 'D0004', '2019-10-22', 9),
		('I0005', 'D0001', '2019-12-28', 4);
		
select * from N19342975.Employee_Sickleave;

alter table N19342975.Employees
add Age smallint;

select D.Doctor_Name
from N19342975.Doctors As D
left join N19342975.Employee_Sickleave As SL
on D.Doctor_ID = SL.Doctor_ID
where SL.Doctor_ID is null;

select E.Employee_Name, E.Employee_Surname, SUM(SL.Number_Of_Days) AS 'Total Sick Leave Days'
from N19342975.Employee_Sickleave As SL
inner join N19342975.Employees As E
on E.Employee_ID = SL.Employee_ID
group by E.Employee_Name, E.Employee_Surname
order by 'Total Sick Leave Days' DESC;

select E.Employee_Name, E.Employee_Surname, COUNT(E.Employee_ID)
from N19342975.Employees As E
inner join N19342975.Employee_Sickleave As SL
on E.Employee_ID = SL.Employee_ID
where SL.Doctor_ID = 'D0001'
Group by E.Employee_Name, E.Employee_Surname