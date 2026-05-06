Enter password: ********
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 29
Server version: 8.0.44 MySQL Community Server - GPL

Copyright (c) 2000, 2025, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> create database hospital;
Query OK, 1 row affected (0.01 sec)

mysql> use hospital;
Database changed
mysql> -- Staff
mysql> --enum is a data type that allows you to restrict a column to a predefined set of values only.

mysql> create table Staff (staff_id int primary key , first_name varchar(20) not null , middle_name varchar (20) , last_name varchar (20) , address varchar(50) , phone varchar(20) unique ,role varchar (50) ,salary decimal(10,2)check (salary >0) , gender enum ('Male','Female') , birth_date date);
Query OK, 0 rows affected (0.06 sec)
 
mysql> -- Patient
mysql> create table Patient (patient_id int primary key , first_name varchar(20) not null , middle_name varchar(20) , last_name varchar (20) , age int check (age btween 0 and  120) , birth_date date , gender enum ('Male','Female') , address varchar (50) , phone varchar(20) , first_visit_date date );
Query OK, 0 rows affected (0.05 sec)

mysql> -- Surgery
mysql> create table Surgery ( surgery_id int primary key , date date , type varchar (50) , start_time time , end_time time , notes varchar(100), room_id int , patient_id  int, foreign key (patient_id) references Patient(patient_id) on delete cascade on update cascade);
Query OK, 0 rows affected (0.06 sec)

mysql> -- staff surgery
mysql> create table Staff_Surgery(staff_id int , surgery_id int , primary key(staff_id , surgery_id),foreign key (staff_id) references Staff(staff_id) on delete cascade on update cascade , foreign key (surgery_id) references Surgery(surgery_id) on delete  cascade on update cascade);
Query OK, 0 rows affected (0.07 sec)

mysql> -- Bed
mysql> create table Bed(bed_id int primary key , status enum ('Available','Occupied','Maintenance') not null , bed_number int , room_id int );
Query OK, 0 rows affected (0.03 sec)

mysql> -- Patient Bed
mysql> create table Patient_Bed ( patient_id int , bed_id int ,start_date date,end_date date , primary key (patient_id,bed_id) , foreign key (patient_id ) references Patient (patient_id) on delete cascade on update cascade , foreign key(bed_id) references Bed(bed_id) on delete cascade on update cascade);
Query OK, 0 rows affected (0.06 sec)

mysql> -- Medical_Record
mysql> create table Medical_Record ( record_id int primary key , allergies varchar (50) , attribute varchar (50) , chronic_diseases varchar (50) , patient_id int , foreign key (patient_id ) references Patient(patient_id) on delete cascade on update cascade);
Query OK, 0 rows affected (0.12 sec)

mysql> -- Bill
mysql> create table Bill (bill_id int primary key , issue_date date , payment_status varchar (15) , total_amount decimal(10,2) , patient_id int , foreign key (patient_id) references Patient(patient_id) on delete cascade on update cascade);
Query OK, 0 rows affected (0.06 sec)

mysql> -- Department
mysql> create table Department (dept_id int primary key , dept_name varchar(20) not null , phone varchar (20) , location varchar(50) , headDoctor_id int );
Query OK, 0 rows affected (0.03 sec)

mysql> -- Doctor
mysql> create table Doctor (doctor_id int primary key , first_name varchar(20) not null , middle_name varchar(20) , last_name varchar(20) , gender enum('Male','Female') , phone varchar(20) , address varchar(50) , specialty varchar(50) , salary decimal(10,2) check (salary >0) , hire_date date , supervisor_id int , dept_id int , foreign key (supervisor_id) references Doctor(doctor_id ) on delete cascade on update cascade , foreign key (dept_id) references Department(dept_id) on delete cascade on update cascade);
Query OK, 0 rows affected (0.07 sec)

mysql> -- Appointment
mysql> create table Appointment(appointment_id int primary key ,date date ,time time , status varchar(20) , reason varchar(50) , patient_id int , doctor_id int , foreign key (patient_id) references Patient(patient_id) on delete cascade on update cascade , foreign key (doctor_id) references Doctor(doctor_id) on delete cascade on update cascade);
Query OK, 0 rows affected (0.07 sec)

mysql> -- Medicine
mysql> create table Medicine ( med_code int primary key , unit_price decimal(10,2) , name varchar(30));
Query OK, 0 rows affected (0.21 sec)

mysql> -- Medicine_Appointment
mysql> create table Medicine_Appointment(med_code int , appointment_id int ,primary key (med_code,appointment_id) , foreign key (appointment_id) references Appointment(appointment_id) on delete cascade on update cascade , foreign key (med_code) references Medicine(med_code) on delete cascade on update cascade);
Query OK, 0 rows affected (0.06 sec)

mysql> alter table Medicine_Appointment add constraint foreign key (med_code) references Medicine (med_code) on delete cascade on update cascade;

mysql> -- insert data
mysql> insert into Patient values(1,'Mahammed','Ali','Saad',45,'1980-02-10','Male','Nablus','0599000001','2025-01-10');
Query OK, 1 row affected (0.01 sec)

mysql> insert into Patient values(2,'Aisha','Khaled','Odeh',30,'1995-06-25','Female','Ramallah','0599000002','2025-02-15');
Query OK, 1 row affected (0.01 sec)

mysql> insert into Patient values(3,'Fadi','Ibrahim','Hamed',60,'1965-11-05','Male','Hebron','0599000003','2025-03-01');
Query OK, 1 row affected (0.01 sec)

mysql> insert into Patient values(4,'Lina','Ahmad','Barghouti',27,'1998-08-14','female','Nablus','0599000004','2025-03-10');
Query OK, 1 row affected (0.10 sec)

mysql> insert into Patient values(5,'Omar','Yousef','Khalil',50,'1975-04-20','Male','Jenin','0599000005','2025-03-18');
Query OK, 1 row affected (0.01 sec)

mysql> insert into Patient values(6,'Sara','Mahmoud','Nasser',33,'1992-12-30','Female','Tulkarm','0599000006','2025-03-22');
Query OK, 1 row affected (0.01 sec)

mysql> insert into Patient values(7,'Hassan','Adel','Saleh',70,'1955-06-11','Male','Ramallah','0599000007','2025-03-25');
Query OK, 1 row affected (0.01 sec)

mysql> insert into Patient values(8,'Maya','kareem','Odel',22,'2003-09-09','Female','Hebron','0599000008','2025-03-28');
Query OK, 1 row affected (0.01 sec)

mysql> insert into Patient values(9,'Yousef','Tariq','Hamad',41,'1984-01-17','Male','Nablus','0599000009','2025-04-01');
Query OK, 1 row affected (0.01 sec)

mysql> insert into Patient values(10,'Reem','Salem','Abu Zaid',36,'1989-07-07','Female','Jenin','0599000010','2025-04-03');
Query OK, 1 row affected (0.01 sec)

mysql> select * from Patient;
+------------+------------+-------------+-----------+------+------------+--------+----------+------------+------------------+
| patient_id | first_name | middle_name | last_name | age  | birth_date | gender | address  | phone      | first_visit_date |
+------------+------------+-------------+-----------+------+------------+--------+----------+------------+------------------+
|          1 | Mahammed   | Ali         | Saad      |   45 | 1980-02-10 | Male   | Nablus   | 0599000001 | 2025-01-10       |
|          2 | Aisha      | Khaled      | Odeh      |   30 | 1995-06-25 | Female | Ramallah | 0599000002 | 2025-02-15       |
|          3 | Fadi       | Ibrahim     | Hamed     |   60 | 1965-11-05 | Male   | Hebron   | 0599000003 | 2025-03-01       |
|          4 | Lina       | Ahmad       | Barghouti |   27 | 1998-08-14 | Female | Nablus   | 0599000004 | 2025-03-10       |
|          5 | Omar       | Yousef      | Khalil    |   50 | 1975-04-20 | Male   | Jenin    | 0599000005 | 2025-03-18       |
|          6 | Sara       | Mahmoud     | Nasser    |   33 | 1992-12-30 | Female | Tulkarm  | 0599000006 | 2025-03-22       |
|          7 | Hassan     | Adel        | Saleh     |   70 | 1955-06-11 | Male   | Ramallah | 0599000007 | 2025-03-25       |
|          8 | Maya       | kareem      | Odel      |   22 | 2003-09-09 | Female | Hebron   | 0599000008 | 2025-03-28       |
|          9 | Yousef     | Tariq       | Hamad     |   41 | 1984-01-17 | Male   | Nablus   | 0599000009 | 2025-04-01       |
|         10 | Reem       | Salem       | Abu Zaid  |   36 | 1989-07-07 | Female | Jenin    | 0599000010 | 2025-04-03       |
+------------+------------+-------------+-----------+------+------------+--------+----------+------------+------------------+
10 rows in set (0.00 sec)

mysql> insert into Medicine values (101,5.50 , 'Paracetamol');
Query OK, 1 row affected (0.08 sec)

mysql> insert into Medicine values (102,8.75 , 'Ibuprofen');
Query OK, 1 row affected (0.01 sec)

mysql> insert into Medicine values (103,12.00 , 'Amoxicillin');
Query OK, 1 row affected (0.01 sec)

mysql> insert into Medicine values (104,15.25 , 'Augmentin');
Query OK, 1 row affected (0.01 sec)

mysql> insert into Medicine values (105,6.40 , 'Aspirin');
Query OK, 1 row affected (0.01 sec)

mysql> insert into Medicine values (106,20.00 , 'Insulin');
Query OK, 1 row affected (0.01 sec)

mysql> insert into Medicine values (107,9.30 , 'Cough Syrup');
Query OK, 1 row affected (0.01 sec)

mysql> insert into Medicine values (108,18.60 , 'Vitamin D');
Query OK, 1 row affected (0.01 sec)

mysql> insert into Medicine values (109,7.80 , 'Antacid');
Query OK, 1 row affected (0.01 sec)

mysql> insert into Medicine values (110,25.00 , 'Blood Pressure Tablets');
Query OK, 1 row affected (0.07 sec)

mysql> select * from Medicine;
+----------+------------+------------------------+
| med_code | unit_price | name                   |
+----------+------------+------------------------+
|      101 |       5.50 | Paracetamol            |
|      102 |       8.75 | Ibuprofen              |
|      103 |      12.00 | Amoxicillin            |
|      104 |      15.25 | Augmentin              |
|      105 |       6.40 | Aspirin                |
|      106 |      20.00 | Insulin                |
|      107 |       9.30 | Cough Syrup            |
|      108 |      18.60 | Vitamin D              |
|      109 |       7.80 | Antacid                |
|      110 |      25.00 | Blood Pressure Tablets |
+----------+------------+------------------------+
10 rows in set (0.01 sec)

mysql> insert into Department values (1,'Cardiology','059901111','Building A - Floor 2',null);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Department values (2,'Neurology','059902222','Building B- Floor ',null);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Department values (3,'Orthopedics','059903333','BuildingC - Floor 3',null);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Department values (4,'Padiatrics','059904444','Building D - Floor 2',null);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Department values (5,'Emergency','059905555','Building E- Ground Floor',null);
Query OK, 1 row affected (0.01 sec)

mysql> select * from Department;
+---------+-------------+-----------+---------------------------+---------------+
| dept_id | dept_name   | phone     | location                  | headDoctor_id |
+---------+-------------+-----------+---------------------------+---------------+
|       1 | Cardiology  | 059901111 | Building A - Floor 2      |          NULL |
|       2 | Neurology   | 059902222 | Building B - Floor        |          NULL |
|       3 | Orthopedics | 059903333 | Building C - Floor 3      |          NULL |
|       4 | Padiatrics  | 059904444 | Building D - Floor 2      |          NULL |
|       5 | Emergency   | 059905555 | Building E - Ground Floor |          NULL |
+---------+-------------+-----------+---------------------------+---------------+
5 rows in set (0.00 sec)

mysql> insert into Doctor values (1,'Ahmad', 'Ali','Khalil','Male','0599111111','Nablus','Cardiologist',12000,'2020-01-10', null,1);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Doctor values (2,'Sara', 'Omar','Hassan','Female','0599222222','Ramallah','Neurologist',11000,'2019-03-15', 1,2);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Doctor values (3,'Yousef', 'Mahmoud','Nasser','Male','0599333333','Hebron','Orthopedic',10000,'2021-07-01', 1,3);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Doctor values (4,'Lina', 'Ayman','Barghouti','Female','0599444444','Nablus','Pediartrician',10500,'2022-02-10', 2,4);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Doctor values (5,'Omar', 'Fadi','Yasin','Male','0599555555','Jenin','Emergency',11500,'2021-11-20', 2,5);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Doctor values (6,'Maya', 'Kareem','Odeh','Female','0599666666','Tulkarm','Cardiologist',9800,'2020-06-18', 1,1);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Doctor values (7,'Hassan', 'adel','Saleh','Male','0599777777','Ramallah','Neurologist',10200,'2018-09-25', 2,2);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Doctor values (8,'Reem', 'Salem','Abu Zaid','Female','0599888888','Hebron','Orthopedic',9900,'2023-01-05', 3,3);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Doctor values (9,'Fadi', 'Ibrahim','Hamed','Male','0599999999','Nablus','Pediartrician',9700,'2022-08-14', 4,4);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Doctor values (10,'Noor', 'sami','Khalil','Female','0599000010','Jenin','Emergency',12000,'2021-04-30', 5,5);
Query OK, 1 row affected (0.03 sec)

mysql> select * from Doctor;
+-----------+------------+-------------+-----------+--------+------------+----------+---------------+----------+------------+---------------+---------+
| doctor_id | first_name | middle_name | last_name | gender | phone      | address  | specialty     | salary   | hire_date  | supervisor_id | dept_id |
+-----------+------------+-------------+-----------+--------+------------+----------+---------------+----------+------------+---------------+---------+
|         1 | Ahmad      | Ali         | Khalil    | Male   | 0599111111 | Nablus   | Cardiologist  | 12000.00 | 2020-01-10 |          NULL |       1 |
|         2 | Sara       | Omar        | Hassan    | Female | 0599222222 | Ramallah | Neurologist   | 11000.00 | 2019-03-15 |             1 |       2 |
|         3 | Yousef     | Mahmoud     | Nasser    | Male   | 0599333333 | Hebron   | Orthopedic    | 10000.00 | 2021-07-01 |             1 |       3 |
|         4 | Lina       | Ayman       | Barghouti | Female | 0599444444 | Nablus   | Pediartrician | 10500.00 | 2022-02-10 |             2 |       4 |
|         5 | Omar       | Fadi        | Yasin     | Male   | 0599555555 | Jenin    | Emergency     | 11500.00 | 2021-11-20 |             2 |       5 |
|         6 | Maya       | Kareem      | Odeh      | Female | 0599666666 | Tulkarm  | Cardiologist  |  9800.00 | 2020-06-18 |             1 |       1 |
|         7 | Hassan     | adel        | Saleh     | Male   | 0599777777 | Ramallah | Neurologist   | 10200.00 | 2018-09-25 |             2 |       2 |
|         8 | Reem       | Salem       | Abu Zaid  | Female | 0599888888 | Hebron   | Orthopedic    |  9900.00 | 2023-01-05 |             3 |       3 |
|         9 | Fadi       | Ibrahim     | Hamed     | Male   | 0599999999 | Nablus   | Pediartrician |  9700.00 | 2022-08-14 |             4 |       4 |
|        10 | Noor       | sami        | Khalil    | Female | 0599000010 | Jenin    | Emergency     | 12000.00 | 2021-04-30 |             5 |       5 |
+-----------+------------+-------------+-----------+--------+------------+----------+---------------+----------+------------+---------------+---------+
10 rows in set (0.00 sec)

mysql> insert into Staff values (1,'Lina','Mohammad','Saleh','Nablus','0599000101','Nurse',3000,'Female' ,'1999-04-11' );
Query OK, 1 row affected (0.01 sec)

mysql> insert into Staff values (2,'omar','Fadi','Yasin','Jenin','0599000102','Technician',2800,'Male' , '2000-02-20');
Query OK, 1 row affected (0.01 sec)

mysql> insert into Staff values (3,'Ali','Khaled','Nasser','ramallah','0599000103','Nurse',3200,'Male', '1995-11-23');
Query OK, 1 row affected (0.01 sec)

mysql> insert into Staff values (4,'Huda','Samir','Barghouti','Tulkarm','0599000104','Receptionist',2500,'Female', '2001-10-02');
Query OK, 1 row affected (0.01 sec)

mysql> insert into Staff values (5,'Sara','Ahmad','Odeh','Hebron','0599000105','Lab Assistant',2900,'Female', '1987-01-30');
Query OK, 1 row affected (0.01 sec)

mysql> insert into Staff values (6,'Yousef','Ibrahim','Hamed','Nablus','0599000106','Cleaner',2000,'Male','1997-08-09');
Query OK, 1 row affected (0.01 sec)

mysql> insert into Staff values (7,'Mona','Kareem','Saleh','Jenin','0599000107','Nurse',3100,'Female', '2002-04-12');
Query OK, 1 row affected (0.01 sec)

mysql> insert into Staff values (8,'Tariq','Adel','Hassan','Tulkarm','0599000108','Technician',2700,'Male','1989-11-07');
Query OK, 1 row affected (0.09 sec)

mysql> insert into Staff values (9,'Reem','Salem','Barghouti','Ramallah','0599000109','Receptionist',2600,'Female','1999-09-09');
Query OK, 1 row affected (0.01 sec)

mysql> insert into Staff values (10,'Fadi','Omar','Khalil','Hebron','0599000110','Security',2400,'Male', '1993-10-16');
Query OK, 1 row affected (0.01 sec)

mysql> select * from Staff;
+----------+------------+-------------+-----------+----------+------------+---------------+---------+--------+-----------+
| staff_id | first_name | middle_name | last_name | address  | phone      |role          | salary  | gender | birth_date |
+----------+------------+-------------+-----------+----------+------------+---------------+---------+--------+-----------|
|        1 | Lina       | Mohammad    | Saleh     | Nablus   | 0599000101 |Nurse         | 3000.00 | Female | 1999-04-11 |
|        2 | omar       | Fadi        | Yasin     | Jenin    | 0599000102 |Technician    | 2800.00 | Male   | 2000-02-20 |
|        3 | Ali        | Khaled      | Nasser    | ramallah | 0599000103 |Nurse         | 3200.00 | Male   | 1995-11-23 |
|        4 | Huda       | Samir       | Barghouti | Tulkarm  | 0599000104 |Receptionist  | 2500.00 | Female | 2001-10-02 |
|        5 | Sara       | Ahmad       | Odeh      | Hebron   | 0599000105 |Lab Assistant | 2900.00 | Female | 1987-01-30 |
|        6 | Yousef     | Ibrahim     | Hamed     | Nablus   | 0599000106 |Cleaner       | 2000.00 | Male   | 1997-08-09 |
|        7 | Mona       | Kareem      | Saleh     | Jenin    | 0599000107 |Nurse         | 3100.00 | Female | 2002-04-12 |
|        8 | Tariq      | Adel        | Hassan    | Tulkarm  | 0599000108 |Technician    | 2700.00 | Male   | 1989-11-07 |
|        9 | Reem       | Salem       | Barghouti | Ramallah | 0599000109 |Receptionist  | 2600.00 | Female | 1999-09-09 |
|       10 | Fadi       | Omar        | Khalil    | Hebron   | 0599000110 |Security      | 2400.00 | Male   | 1993-10-16 |
+----------+------------+-------------+-----------+----------+------------+---------------+---------+--------+-----------+
10 rows in set (0.00 sec)

mysql> insert into Surgery values (1,'2025-04-01','Heart Bypass','08:00','11:00','Successful',101,1);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Surgery values (2,'2025-04-02','Brain Tumor','09:00','13:00','Stable',102,2);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Surgery values (3,'2025-04-03','Keen Replacement','10:00','12:30','Good',103,3);
Query OK, 1 row affected (0.04 sec)

mysql> insert into Surgery values (4,'2025-04-04','Appendectomy','08:30','10:00','Success',104,4);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Surgery values (5,'2025-04-05','Gallbladder Removal','09:15','11:00','OK',105,5);
Query OK, 1 row affected (0.05 sec)

mysql> insert into Surgery values (6,'2025-04-06','Heart Valve','08:00','12:00','Critical',106,6);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Surgery values (7,'2025-04-07','Spine Surgery','10:00','14:00','Stable',107,7);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Surgery values (8,'2025-04-08','Fracture Fix','11:00','12:30','Good',108,8);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Surgery values (9,'2025-04-09','Tonsil Removal','09:00','10:00','Success',109,9);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Surgery values (10,'2025-04-10','Emergency','07:00','10:30','Critical',110,10);
Query OK, 1 row affected (0.01 sec)

mysql> select * from Surgery;
+------------+------------+---------------------+------------+----------+------------+---------+------------+
| surgery_id | date       | type                | start_time | end_time | notes      | room_id | patient_id |
+------------+------------+---------------------+------------+----------+------------+---------+------------+
|          1 | 2025-04-01 | Heart Bypass        | 08:00:00   | 11:00:00 | Successful |     101 |          1 |
|          2 | 2025-04-02 | Brain Tumor         | 09:00:00   | 13:00:00 | Stable     |     102 |          2 |
|          3 | 2025-04-03 | Keen Replacement    | 10:00:00   | 12:30:00 | Good       |     103 |          3 |
|          4 | 2025-04-04 | Appendectomy        | 08:30:00   | 10:00:00 | Success    |     104 |          4 |
|          5 | 2025-04-05 | Gallbladder Removal | 09:15:00   | 11:00:00 | OK         |     105 |          5 |
|          6 | 2025-04-06 | Heart Valve         | 08:00:00   | 12:00:00 | Critical   |     106 |          6 |
|          7 | 2025-04-07 | Spine Surgery       | 10:00:00   | 14:00:00 | Stable     |     107 |          7 |
|          8 | 2025-04-08 | Fracture Fix        | 11:00:00   | 12:30:00 | Good       |     108 |          8 |
|          9 | 2025-04-09 | Tonsil Removal      | 09:00:00   | 10:00:00 | Success    |     109 |          9 |
|         10 | 2025-04-10 | Emergency           | 07:00:00   | 10:30:00 | Critical   |     110 |         10 |
+------------+------------+---------------------+------------+----------+------------+---------+------------+
10 rows in set (0.00 sec)

mysql> insert into Staff_Surgery values (1,1);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Staff_Surgery values (2,2);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Staff_Surgery values (3,3);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Staff_Surgery values (4,4);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Staff_Surgery values (5,5);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Staff_Surgery values (6,6);
Query OK, 1 row affected (0.10 sec)

mysql> insert into Staff_Surgery values (7,7);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Staff_Surgery values (8,8);
Query OK, 1 row affected (0.07 sec)

mysql> insert into Staff_Surgery values (9,9);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Staff_Surgery values (10,10);
Query OK, 1 row affected (0.07 sec)

mysql> insert into Bed values (1,'Occupied',101,1);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Bed values (2,'Occupied',102,2);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Bed values (3,'Available',103,3);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Bed values (4,'Occupied',104,1);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Bed values (5,'Maintenance',105,5);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Bed values (6,'Available',106,3);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Bed values (7,'Occupied',107,4);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Bed values (8,'Available',108,5);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Bed values (9,'Occupied',109,1);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Bed values (10,'Available',110,2);
Query OK, 1 row affected (0.01 sec)

mysql> select * from Bed;
+--------+-------------+------------+---------+
| bed_id | status      | bed_number | room_id |
+--------+-------------+------------+---------+
|      1 | Occupied    |        101 |       1 |
|      2 | Occupied    |        102 |       2 |
|      3 | Available   |        103 |       3 |
|      4 | Occupied    |        104 |       1 |
|      5 | Maintenance |        105 |       5 |
|      6 | Available   |        106 |       3 |
|      7 | Occupied    |        107 |       4 |
|      8 | Available   |        108 |       5 |
|      9 | Occupied    |        109 |       1 |
|     10 | Available   |        110 |       2 |
+--------+-------------+------------+---------+
10 rows in set (0.00 sec)

mysql> insert into Patient_Bed values (1,1,'2025-04-01','2025-04-05');
Query OK, 1 row affected (0.01 sec)

mysql> insert into Patient_Bed values (2,2,'2025-04-02',null);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Patient_Bed values (3,3,'2025-04-03',null);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Patient_Bed values (4,4,'2025-04-04',null);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Patient_Bed values (5,5,'2025-04-05',null);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Patient_Bed values (6,6,'2025-04-06',null);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Patient_Bed values (7,7,'2025-04-07',null);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Patient_Bed values (8,8,'2025-04-08',null);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Patient_Bed values (9,9,'2025-04-09',null);
Query OK, 1 row affected (0.07 sec)

mysql> insert into Patient_Bed values (10,10,'2025-04-10',null);
Query OK, 1 row affected (0.01 sec)

mysql> select * from Patient_Bed;
+------------+--------+------------+------------+
| patient_id | bed_id | start_date | end_date   |
+------------+--------+------------+------------+
|          1 |      1 | 2025-04-01 | 2025-04-05 |
|          2 |      2 | 2025-04-02 | NULL       |
|          3 |      3 | 2025-04-03 | NULL       |
|          4 |      4 | 2025-04-04 | NULL       |
|          5 |      5 | 2025-04-05 | NULL       |
|          6 |      6 | 2025-04-06 | NULL       |
|          7 |      7 | 2025-04-07 | NULL       |
|          8 |      8 | 2025-04-08 | NULL       |
|          9 |      9 | 2025-04-09 | NULL       |
|         10 |     10 | 2025-04-10 | NULL       |
+------------+--------+------------+------------+
10 rows in set (0.00 sec)

mysql> insert into Medical_Record values (1,'Penicillin','BP','Hypertension',1);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Medical_Record values (2,'None','MRI','Migraine',2);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Medical_Record values (3,'Ibuprofen','X_Ray','Arthritis',3);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Medical_Record values (4,'None','Blood Test','Anemia',4);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Medical_Record values (5,'Aspirin','Ultrasound','Gallstones',5);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Medical_Record values (6,'None','ECG','Heart Disease',6);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Medical_Record values (7,'Penicillin','CT','Spine Tssue',7);
Query OK, 1 row affected (0.07 sec)

mysql> insert into Medical_Record values (8,'None','X_Ray','Fracture',8);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Medical_Record values (9,'Dust','Throat Exam','Tonsillitis',9);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Medical_Record values (10,'None','CT','Trauma',10);
Query OK, 1 row affected (0.01 sec)

mysql> select * from Medical_Record;
+-----------+------------+-------------+------------------+------------+
| record_id | allergies  | attribute   | chronic_diseases | patient_id |
+-----------+------------+-------------+------------------+------------+
|         1 | Penicillin | BP          | Hypertension     |          1 |
|         2 | None       | MRI         | Migraine         |          2 |
|         3 | Ibuprofen  | X_Ray       | Arthritis        |          3 |
|         4 | None       | Blood Test  | Anemia           |          4 |
|         5 | Aspirin    | Ultrasound  | Gallstones       |          5 |
|         6 | None       | ECG         | Heart Disease    |          6 |
|         7 | Penicillin | CT          | Spine Tssue      |          7 |
|         8 | None       | X_Ray       | Fracture         |          8 |
|         9 | Dust       | Throat Exam | Tonsillitis      |          9 |
|        10 | None       | CT          | Trauma           |         10 |
+-----------+------------+-------------+------------------+------------+
10 rows in set (0.00 sec)

mysql> insert into Bill values (1,'2025-04-01','Paid',5000,1);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Bill values (2,'2025-04-02','Pending',7000,2);
Query OK, 1 row affected (0.07 sec)

mysql> insert into Bill values (3,'2025-04-03','Paid',4500,3);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Bill values (4,'2025-04-04','Paid',3000,4);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Bill values (5,'2025-04-05','Pending',6000,5);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Bill values (6,'2025-04-06','Paid',8000,6);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Bill values (7,'2025-04-07','Pending',9000,7);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Bill values (8,'2025-04-08','Paid',3500,8);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Bill values (9,'2025-04-09','Paid',4000,9);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Bill values (10,'2025-04-10','Pending',9900,10);
Query OK, 1 row affected (0.01 sec)

mysql> select * from Bill;
+---------+------------+----------------+--------------+------------+
| bill_id | issue_date | payment_status | total_amount | patient_id |
+---------+------------+----------------+--------------+------------+
|       1 | 2025-04-01 | Paid           |      5000.00 |          1 |
|       2 | 2025-04-02 | Pending        |      7000.00 |          2 |
|       3 | 2025-04-03 | Paid           |      4500.00 |          3 |
|       4 | 2025-04-04 | Paid           |      3000.00 |          4 |
|       5 | 2025-04-05 | Pending        |      6000.00 |          5 |
|       6 | 2025-04-06 | Paid           |      8000.00 |          6 |
|       7 | 2025-04-07 | Pending        |      9000.00 |          7 |
|       8 | 2025-04-08 | Paid           |      3500.00 |          8 |
|       9 | 2025-04-09 | Paid           |      4000.00 |          9 |
|      10 | 2025-04-10 | Pending        |      9900.00 |         10 |
+---------+------------+----------------+--------------+------------+
10 rows in set (0.00 sec)

mysql> insert into Appointment values (1,'2025-03-01','09:00','Completed','Checkup',1,1);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Appointment values (2,'2025-03-02','10:00','Scheduled','Headache',2,2);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Appointment values (3,'2025-03-03','11:00','Completed','knee pain',3,3);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Appointment values (4,'2025-03-04','09:30','Completed','Fever',4,4);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Appointment values (5,'2025-03-05','10:30','Scheduled','Stomach pain',5,5);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Appointment values (6,'2025-03-06','08:30','Completed','Heart Check',6,6);
Query OK, 1 row affected (0.07 sec)

mysql> insert into Appointment values (7,'2025-03-07','12:00','Scheduled','Back pain',7,7);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Appointment values (8,'2025-03-08','11:30','Completed','Fracture',8,8);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Appointment values (9,'2025-03-09','09:15','Completed','Throat',9,9);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Appointment values (10,'2025-03-10','10:45','Scheduled','Accident',10,10);
Query OK, 1 row affected (0.01 sec)

mysql> select * from Appointment;
+----------------+------------+----------+-----------+--------------+------------+-----------+
| appointment_id | date       | time     | status    | reason       | patient_id | doctor_id |
+----------------+------------+----------+-----------+--------------+------------+-----------+
|              1 | 2025-03-01 | 09:00:00 | Completed | Checkup      |          1 |         1 |
|              2 | 2025-03-02 | 10:00:00 | Scheduled | Headache     |          2 |         2 |
|              3 | 2025-03-03 | 11:00:00 | Completed | knee pain    |          3 |         3 |
|              4 | 2025-03-04 | 09:30:00 | Completed | Fever        |          4 |         4 |
|              5 | 2025-03-05 | 10:30:00 | Scheduled | Stomach pain |          5 |         5 |
|              6 | 2025-03-06 | 08:30:00 | Completed | Heart Check  |          6 |         6 |
|              7 | 2025-03-07 | 12:00:00 | Scheduled | Back pain    |          7 |         7 |
|              8 | 2025-03-08 | 11:30:00 | Completed | Fracture     |          8 |         8 |
|              9 | 2025-03-09 | 09:15:00 | Completed | Throat       |          9 |         9 |
|             10 | 2025-03-10 | 10:45:00 | Scheduled | Accident     |         10 |        10 |
+----------------+------------+----------+-----------+--------------+------------+-----------+
10 rows in set (0.00 sec)

mysql> insert into Medicine_Appointment values (101,1);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Medicine_Appointment values (102,2);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Medicine_Appointment values (103,3);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Medicine_Appointment values (104,4);
Query OK, 1 row affected (0.05 sec)

mysql> insert into Medicine_Appointment values (105,5);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Medicine_Appointment values (106,6);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Medicine_Appointment values (107,7);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Medicine_Appointment values (108,8);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Medicine_Appointment values (109,9);
Query OK, 1 row affected (0.08 sec)

mysql> insert into Medicine_Appointment values (110,10);
Query OK, 1 row affected (0.01 sec)

mysql> select * from Patient where age > 40;
+------------+------------+-------------+-----------+------+------------+--------+----------+------------+------------------+
| patient_id | first_name | middle_name | last_name | age  | birth_date | gender | address  | phone      | first_visit_date |
+------------+------------+-------------+-----------+------+------------+--------+----------+------------+------------------+
|          1 | Mahammed   | Ali         | Saad      |   45 | 1980-02-10 | Male   | Nablus   | 0599000001 | 2025-01-10       |
|          3 | Fadi       | Ibrahim     | Hamed     |   60 | 1965-11-05 | Male   | Hebron   | 0599000003 | 2025-03-01       |
|          5 | Omar       | Yousef      | Khalil    |   50 | 1975-04-20 | Male   | Jenin    | 0599000005 | 2025-03-18       |
|          7 | Hassan     | Adel        | Saleh     |   70 | 1955-06-11 | Male   | Ramallah | 0599000007 | 2025-03-25       |
|          9 | Yousef     | Tariq       | Hamad     |   41 | 1984-01-17 | Male   | Nablus   | 0599000009 | 2025-04-01       |
+------------+------------+-------------+-----------+------+------------+--------+----------+------------+------------------+
5 rows in set (0.00 sec)

mysql> select Doctor.first_name , Doctor.last_name , Department.dept_name from Doctor join Department on Doctor.dept_id = Department.dept_id;
+------------+-----------+-------------+
| first_name | last_name | dept_name   |
+------------+-----------+-------------+
| Ahmad      | Khalil    | Cardiology  |
| Maya       | Odeh      | Cardiology  |
| Sara       | Hassan    | Neurology   |
| Hassan     | Saleh     | Neurology   |
| Yousef     | Nasser    | Orthopedics |
| Reem       | Abu Zaid  | Orthopedics |
| Lina       | Barghouti | Padiatrics  |
| Fadi       | Hamed     | Padiatrics  |
| Omar       | Yasin     | Emergency   |
| Noor       | Khalil    | Emergency   |
+------------+-----------+-------------+
10 rows in set (0.00 sec)

mysql> select Surgery.surgery_id, Surgery.type , Patient.first_name,Surgery.date from Surgery join Patient on Surgery.patient_id = Patient_id;
ERROR 1052 (23000): Column 'Patient_id' in on clause is ambiguous
mysql> select Surgery.surgery_id, Surgery.type , Patient.first_name,Surgery.date from Surgery join Patient on Surgery.patient_id = Patient.patient_id;
+------------+---------------------+------------+------------+
| surgery_id | type                | first_name | date       |
+------------+---------------------+------------+------------+
|          1 | Heart Bypass        | Mahammed   | 2025-04-01 |
|          2 | Brain Tumor         | Aisha      | 2025-04-02 |
|          3 | Keen Replacement    | Fadi       | 2025-04-03 |
|          4 | Appendectomy        | Lina       | 2025-04-04 |
|          5 | Gallbladder Removal | Omar       | 2025-04-05 |
|          6 | Heart Valve         | Sara       | 2025-04-06 |
|          7 | Spine Surgery       | Hassan     | 2025-04-07 |
|          8 | Fracture Fix        | Maya       | 2025-04-08 |
|          9 | Tonsil Removal      | Yousef     | 2025-04-09 |
|         10 | Emergency           | Reem       | 2025-04-10 |
+------------+---------------------+------------+------------+
10 rows in set (0.00 sec)

mysql> select * from Doctor where salary = (select max(salary) from Doctor);
+-----------+------------+-------------+-----------+--------+------------+---------+--------------+----------+------------+---------------+---------+
| doctor_id | first_name | middle_name | last_name | gender | phone      | address | specialty    | salary   | hire_date  | supervisor_id | dept_id |
+-----------+------------+-------------+-----------+--------+------------+---------+--------------+----------+------------+---------------+---------+
|         1 | Ahmad      | Ali         | Khalil    | Male   | 0599111111 | Nablus  | Cardiologist | 12000.00 | 2020-01-10 |          NULL |       1 |
|        10 | Noor       | sami        | Khalil    | Female | 0599000010 | Jenin   | Emergency    | 12000.00 | 2021-04-30 |             5 |       5 |
+-----------+------------+-------------+-----------+--------+------------+---------+--------------+----------+------------+---------------+---------+
2 rows in set (0.01 sec)

mysql> -- increse salary 10% to Doctor
mysql> select doctor_id , first_name , salary from Doctor ;
+-----------+------------+----------+
| doctor_id | first_name | salary   |
+-----------+------------+----------+
|         1 | Ahmad      | 12000.00 |
|         2 | Sara       | 11000.00 |
|         3 | Yousef     | 10000.00 |
|         4 | Lina       | 10500.00 |
|         5 | Omar       | 11500.00 |
|         6 | Maya       |  9800.00 |
|         7 | Hassan     | 10200.00 |
|         8 | Reem       |  9900.00 |
|         9 | Fadi       |  9700.00 |
|        10 | Noor       | 12000.00 |
+-----------+------------+----------+
10 rows in set (0.00 sec)

mysql> update Doctor set salary = salary * 1.10  ;
Query OK, 10 rows affected (0.01 sec)
Rows matched: 10  Changed: 10  Warnings: 0

mysql> select doctor_id , first_name , salary from Doctor ;
+-----------+------------+----------+
| doctor_id | first_name | salary   |
+-----------+------------+----------+
|         1 | Ahmad      | 13200.00 |
|         2 | Sara       | 12100.00 |
|         3 | Yousef     | 11000.00 |
|         4 | Lina       | 11550.00 |
|         5 | Omar       | 12650.00 |
|         6 | Maya       | 10780.00 |
|         7 | Hassan     | 11220.00 |
|         8 | Reem       | 10890.00 |
|         9 | Fadi       | 10670.00 |
|        10 | Noor       | 13200.00 |
+-----------+------------+----------+
10 rows in set (0.00 sec)

mysql> select * from Bed where bed_id = 3;
+--------+-----------+------------+---------+
| bed_id | status    | bed_number | room_id |
+--------+-----------+------------+---------+
|      3 | Available |        103 |       3 |
+--------+-----------+------------+---------+
1 row in set (0.00 sec)

mysql> update Bed set status ='Occupied' where bed_id = 3;
Query OK, 1 row affected (0.01 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> update Bed set status ='Occupied' where bed_id = 3;
Query OK, 0 rows affected (0.00 sec)
Rows matched: 1  Changed: 0  Warnings: 0

mysql> select * from Bed where bed_id = 3;
+--------+----------+------------+---------+
| bed_id | status   | bed_number | room_id |
+--------+----------+------------+---------+
|      3 | Occupied |        103 |       3 |
+--------+----------+------------+---------+
1 row in set (0.00 sec)

mysql> -- Delete
mysql> select * from Appointment where status='Scheduled';
+----------------+------------+----------+-----------+--------------+------------+-----------+
| appointment_id | date       | time     | status    | reason       | patient_id | doctor_id |
+----------------+------------+----------+-----------+--------------+------------+-----------+
|              2 | 2025-03-02 | 10:00:00 | Scheduled | Headache     |   2 |         2 |
|              5 | 2025-03-05 | 10:30:00 | Scheduled | Stomach pain |   5 |         5 |
|              7 | 2025-03-07 | 12:00:00 | Scheduled | Back pain    |   7 |         7 |
|             10 | 2025-03-10 | 10:45:00 | Scheduled | Accident     |  10 |        10 |
+----------------+------------+----------+-----------+--------------+------------+-----------+
4 rows in set (0.00 sec)

mysql> delete from Appointment where status = 'Scheduled';
Query OK, 4 rows affected (0.01 sec)

mysql> delete from Appointment;
Query OK, 6 rows affected (0.01 sec)

mysql> select * from Appointment;
Empty set (0.00 sec)

mysql> rollback;
Query OK, 0 rows affected (0.00 sec)

mysql> select * from Appointment;
Empty set (0.00 sec)

mysql> select * from Bill where payment_status ='Pending';
+---------+------------+----------------+--------------+------------+
| bill_id | issue_date | payment_status | total_amount | patient_id |
+---------+------------+----------------+--------------+------------+
|       2 | 2025-04-02 | Pending        |      7000.00 |          2 |
|       5 | 2025-04-05 | Pending        |      6000.00 |          5 |
|       7 | 2025-04-07 | Pending        |      9000.00 |          7 |
|      10 | 2025-04-10 | Pending        |      9900.00 |         10 |
+---------+------------+----------------+--------------+------------+
4 rows in set (0.00 sec)

mysql> update  Bill  set payment_status = 'Paid'  where payment_status = 'Pending';
Query OK, 4 rows affected (0.01 sec)

mysql> select * from Bill ;
+---------+------------+----------------+--------------+------------+
| bill_id | issue_date | payment_status | total_amount | patient_id |
+---------+------------+----------------+--------------+------------+
|       1 | 2025-04-01 | Paid           |      5000.00 |          1 |
|       2 | 2025-04-02 | Paid           |      7000.00 |          2 |
|       3 | 2025-04-03 | Paid           |      4500.00 |          3 |
|       4 | 2025-04-04 | Paid           |      3000.00 |          4 |
|       5 | 2025-04-05 | Paid           |      6000.00 |          5 |
|       6 | 2025-04-06 | Paid           |      8000.00 |          6 |
|       7 | 2025-04-07 | Paid           |      9000.00 |          7 |
|       8 | 2025-04-08 | Paid           |      3500.00 |          8 |
|       9 | 2025-04-09 | Paid           |      4000.00 |          9 |
|      10 | 2025-04-10 |Paid            |      9900.00 |         10 |
+---------+------------+----------------+--------------+------------+
6 rows in set (0.00 sec)

mysql> create view V_Doctor_Department as select Doctor.first_name,Doctor.specialty,Department.dept_name from Doctor join Department on Doctor.dept_id = Department.dept_id;
Query OK, 0 rows affected (0.01 sec)

mysql> select * from V_Doctor_Department;
+------------+---------------+-------------+
| first_name | specialty     | dept_name   |
+------------+---------------+-------------+
| Ahmad      | Cardiologist  | Cardiology  |
| Maya       | Cardiologist  | Cardiology  |
| Sara       | Neurologist   | Neurology   |
| Hassan     | Neurologist   | Neurology   |
| Yousef     | Orthopedic    | Orthopedics |
| Reem       | Orthopedic    | Orthopedics |
| Lina       | Pediartrician | Padiatrics  |
| Fadi       | Pediartrician | Padiatrics  |
| Omar       | Emergency     | Emergency   |
| Noor       | Emergency     | Emergency   |
+------------+---------------+-------------+
10 rows in set (0.00 sec)
maysql> 
mysql> insert into Appointment values (1,'205-03-01','09:00','Completed','Checkup',1,1);
Query OK, 1 row affected (0.07 sec)

mysql> insert into Appointment values (2,'205-03-02','10:00','Scheduled','Headache',2,2);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Appointment values (3,'205-03-03','11:00','Completed','Knee pain',3,3);
Query OK, 1 row affected (0.03 sec)

mysql> insert into Appointment values (4,'205-03-04','09:30','Completed','Faver',4,4);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Appointment values (5,'205-03-05','10:30','Scheduled','Stomach pain',5,5);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Appointment values (6,'205-03-06','08:30','Completed','Heart check',6,6);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Appointment values (7,'205-03-07','12:00','Scheduled','Back pain',7,7);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Appointment values (8,'205-03-08','11:30','Completed','Fracture',8,8);
Query OK, 1 row affected (0.07 sec)

mysql> insert into Appointment values (9,'205-03-09','09:15','Completed','Throat',9,9);
Query OK, 1 row affected (0.01 sec)

mysql> insert into Appointment values (10,'205-03-10','10:45','Scheduled','Accident',10,10);
Query OK, 1 row affected (0.01 sec)
