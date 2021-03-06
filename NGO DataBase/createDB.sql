
--- DROP EXISTING TABLES ---------------------------------------

drop table "DEPARTMENTS" cascade constraints;
drop table "PROJECTS" cascade constraints;
drop table "PARTNERS" cascade constraints;
drop table "POSITIONS" cascade constraints;
drop table "POSITION_HISTORY" cascade constraints;
drop table "HUMAN_RESOURCES" cascade constraints;
drop table "FUNDS" cascade constraints;


---CREATE TABLES--------------------------------------------------

CREATE TABLE "HUMAN_RESOURCES"
(
    "EMPLOYEE_ID" NUMBER(6,0),
    "FIRST_NAME" VARCHAR2(20), 
	"LAST_NAME" VARCHAR2(25), 
	"EMAIL" VARCHAR2(25), 
	"PHONE_NUMBER" VARCHAR2(20), 
	"HIRE_DATE" DATE, 
	"POSITION_ID" VARCHAR2(10), 
	"SALARY" NUMBER(8,2), 
	"COORDINATOR_ID" NUMBER(6,0), 
	"DEPARTMENT_ID" NUMBER(4,0),
    "PROJECT_ID" NUMBER(6,0)  );

CREATE TABLE  "POSITION_HISTORY" 
   (	
   "EMPLOYEE_ID" NUMBER(6,0), 
	"START_DATE" DATE, 
	"END_DATE" DATE, 
	"POSITION_ID" VARCHAR2(10)
    ) ;
   
   
    CREATE TABLE  "POSITIONS" 
   (	
   "POSITION_ID" VARCHAR2(10), 
	"POSITION_TITLE" VARCHAR2(35),
       "DEPARTMENT_ID" NUMBER(4,0) 

   ) ;
   
   CREATE TABLE  "PROJECTS" 
    (	"PROJECT_ID" NUMBER(6,0), 
	"PROJECT_TITLE" VARCHAR2(35), 
	--"MANAGER_ID" NUMBER(6,0),
    "START_DATE" DATE, 
	"END_DATE" DATE    
   ) ;
   
   CREATE TABLE "FUNDS"
   (
   "PARTNER_ID" NUMBER(6,0), 
   "PROJECT_ID" NUMBER(6,0),
   "ALLOCATED_FUNDS" NUMBER(8,2)

   );
 
    CREATE TABLE  "PARTNERS" 
   (	
   "PARTNER_ID" NUMBER(6,0), 
	"PARTNER_NAME" VARCHAR2(20), 
	"PARTNER_PHONE_NUMBER" VARCHAR2(30), 
	"PARTNER_EMAIL" VARCHAR2(30)
    ) ;

     CREATE TABLE  "DEPARTMENTS" 
   (	
   "DEPARTMENT_ID" NUMBER(4,0), 
	"DEPARTMENT_NAME" VARCHAR2(30)
    ) ;
 








--------------------------------------CONSTRAINTS-------------------------------------------------------
------------------------------------------------------------------------------------------------------------------

ALTER TABLE "HUMAN_RESOURCES" ADD CONSTRAINT "EMP_ID_PK" PRIMARY KEY ("EMPLOYEE_ID") ENABLE;
ALTER TABLE "DEPARTMENTS" ADD CONSTRAINT "DEP_ID_PK" PRIMARY KEY ("DEPARTMENT_ID") ENABLE;
ALTER TABLE "POSITIONS" ADD CONSTRAINT "POS_ID_PK" PRIMARY KEY ("POSITION_ID") ENABLE;
ALTER TABLE "PARTNERS" ADD CONSTRAINT "PART_ID_PK" PRIMARY KEY ("PARTNER_ID") ENABLE;
ALTER TABLE "POSITION_HISTORY" ADD CONSTRAINT "JOB_HS_ID_PK" PRIMARY KEY ("EMPLOYEE_ID", "START_DATE") ENABLE;
ALTER TABLE "PROJECTS" ADD CONSTRAINT "PROJECT_ID_PK" PRIMARY KEY ("PROJECT_ID") ENABLE;
ALTER TABLE "FUNDS" ADD CONSTRAINT "FUNDS_PK" PRIMARY KEY ("PARTNER_ID","PROJECT_ID") ENABLE;

alter table HUMAN_RESOURCES
  add constraint POS_ID_FK foreign key (POSITION_ID)
  references POSITIONS (POSITION_ID);

alter table HUMAN_RESOURCES
  add constraint DEP_ID_FK foreign key (DEPARTMENT_ID)
  references DEPARTMENTS (DEPARTMENT_ID);
  
  alter table HUMAN_RESOURCES
  add constraint PROJ_ID_FK foreign key (PROJECT_ID)
  references PROJECTS (PROJECT_ID);
  
  alter table POSITION_HISTORY
  add constraint POSITION_ID_FK foreign key (POSITION_ID)
  references POSITIONS (POSITION_ID);
 
  
--------------------------------------INSERT DATA-------------------------------------------------------
--------------------------------------------------------------------------------------------------------

--DEPARTMENTS-------------------------------------------------------------------------
INSERT INTO DEPARTMENTS (DEPARTMENT_ID, DEPARTMENT_NAME) VALUES (10, 'ORGANISERS');
INSERT INTO DEPARTMENTS (DEPARTMENT_ID, DEPARTMENT_NAME) VALUES (20, 'FACILITATORS');
INSERT INTO DEPARTMENTS (DEPARTMENT_ID, DEPARTMENT_NAME) VALUES (30, 'MANAGEMENT');
INSERT INTO DEPARTMENTS (DEPARTMENT_ID, DEPARTMENT_NAME) VALUES (40,'FINANCE');
INSERT INTO DEPARTMENTS (DEPARTMENT_ID, DEPARTMENT_NAME) VALUES (50, 'LEGAL RESOURCES');

--POSITIONS-------------------------------------------------------------------------
INSERT INTO POSITIONS(POSITION_ID, POSITION_TITLE, DEPARTMENT_ID)VALUES (31, 'General Volunteer Coordinator', 30);
INSERT INTO POSITIONS(POSITION_ID, POSITION_TITLE, DEPARTMENT_ID)VALUES (32, 'President', 30);
INSERT INTO POSITIONS(POSITION_ID, POSITION_TITLE, DEPARTMENT_ID)VALUES (33, 'Project manager', 30);

INSERT INTO POSITIONS(POSITION_ID, POSITION_TITLE, DEPARTMENT_ID)VALUES (11, 'Organisers Volunteer', 10);
INSERT INTO POSITIONS(POSITION_ID, POSITION_TITLE, DEPARTMENT_ID)VALUES (12, 'Organisers Volunteer Coordinator', 10);

INSERT INTO POSITIONS(POSITION_ID, POSITION_TITLE, DEPARTMENT_ID)VALUES (21, 'Facilitators Volunteer', 20);
INSERT INTO POSITIONS(POSITION_ID, POSITION_TITLE, DEPARTMENT_ID)VALUES (22, 'Facilitators Volunteer Coordinator', 20);

INSERT INTO POSITIONS(POSITION_ID, POSITION_TITLE, DEPARTMENT_ID)VALUES (41, 'Accounting', 40);

INSERT INTO POSITIONS(POSITION_ID, POSITION_TITLE, DEPARTMENT_ID)VALUES (51, 'Attorney', 50);
INSERT INTO POSITIONS(POSITION_ID, POSITION_TITLE, DEPARTMENT_ID)VALUES (52, 'Lawyer', 50);

--PROJECTS----------------------------------------------------------------------------------------------------------

INSERT INTO PROJECTS(PROJECT_ID, PROJECT_TITLE, start_date,END_DATE) VALUES (1,'Legal gender recognition',to_date('10-12-2019','DD-MM-RRRR'), to_date('10-11-2020','DD-MM-RRRR'));
INSERT INTO PROJECTS(PROJECT_ID, PROJECT_TITLE,start_date,END_DATE) VALUES (3,'Bucharest Pride 2020',to_date('07-12-2019','DD-MM-RRRR'), to_date('30-06-2020','DD-MM-RRRR'));
INSERT INTO PROJECTS(PROJECT_ID, PROJECT_TITLE,start_date,END_DATE) VALUES (2,'Gay marriage legalisation',to_date('03-04-2019','DD-MM-RRRR'), to_date('12-10-2020','DD-MM-RRRR'));

--HUMAN_RESOURCES-------------------------------------------------------------------------------------------

INSERT INTO HUMAN_RESOURCES (EMPLOYEE_ID,FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, POSITION_ID, DEPARTMENT_ID) VALUES (1,'Alex', 'Zorila','zorila@accept.ro','0729384234',
to_date('04-03-2015','DD-MM-RRRR'),31,30 );

INSERT INTO HUMAN_RESOURCES (EMPLOYEE_ID,FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, POSITION_ID, DEPARTMENT_ID, PROJECT_ID, SALARY) VALUES (2,'Teodora', 'Ion-Rotaru','teo@accept.ro','072342344',
to_date('08-03-2012','DD-MM-RRRR'),32,30, 2, 2000 );

INSERT INTO HUMAN_RESOURCES (EMPLOYEE_ID,FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, POSITION_ID, DEPARTMENT_ID, PROJECT_ID, SALARY) VALUES (3,'Damon', 'Lepirda','damon@accept.ro','0731289735',
to_date('28-11-2019','DD-MM-RRRR'),33,30, 1, 1600 );

																		      INSERT INTO HUMAN_RESOURCES (EMPLOYEE_ID,FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, POSITION_ID, DEPARTMENT_ID, COORDINATOR_ID) VALUES (4,'Dude', 'Duddery','dude@gmail.ro','0734544735',
to_date('28-11-2020','DD-MM-RRRR'),11,10, 5 );

INSERT INTO HUMAN_RESOURCES (EMPLOYEE_ID,FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, POSITION_ID, DEPARTMENT_ID, COORDINATOR_ID) VALUES (5,'Dudette', 'Duddettery','dudette@gmail.ro','073567635',
to_date('28-11-2020','DD-MM-RRRR'),12,10, 1 );

INSERT INTO HUMAN_RESOURCES (EMPLOYEE_ID,FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, POSITION_ID, DEPARTMENT_ID, PROJECT_ID, SALARY) VALUES (6,'Patrick', 'Braila','patrick@accept.ro','0721231234',
to_date('22-08-2018','DD-MM-RRRR'),32,30, 1, 2000 );

--PARTNERS---------------------------------------------------------------------------------------------------------

INSERT INTO PARTNERS (PARTNER_ID,PARTNER_NAME,partner_phone_number,partner_email) VALUES (1,'Google','032134562','google@gmail.com');
INSERT INTO PARTNERS (PARTNER_ID,PARTNER_NAME,partner_phone_number,partner_email) VALUES (2,'Mozaiq','032666476','mozaiq@gmail.com');
INSERT INTO PARTNERS (PARTNER_ID,PARTNER_NAME,partner_phone_number,partner_email) VALUES (3,'Microsoft','035234642','microsoft@gmail.com');



--FUNDS---------------------------------------------------------------------------------------------------------------

INSERT INTO FUNDS (PARTNER_ID,allocated_funds,project_id) VALUES (1,200,1);
INSERT INTO FUNDS (PARTNER_ID,allocated_funds,project_id) VALUES (2,300,1);

--POSITION_HISTORY---------------------------------------------------------------------------------------------

INSERT INTO POSITION_HISTORY(employee_id, START_DATE,END_DATE,POSITION_ID)VALUES(4, to_date('28-11-2019','DD-MM-RRRR'),to_date('28-11-2020','DD-MM-RRRR'),12 );
INSERT INTO POSITION_HISTORY(employee_id, START_DATE,END_DATE,POSITION_ID)VALUES(6, to_date('20-10-2018','DD-MM-RRRR'),to_date('28-11-2019','DD-MM-RRRR'),33 );
INSERT INTO POSITION_HISTORY(employee_id, START_DATE,END_DATE,POSITION_ID)VALUES(3, to_date('20-10-2017','DD-MM-RRRR'),to_date('28-11-2018','DD-MM-RRRR'),33 );
INSERT INTO POSITION_HISTORY(employee_id, START_DATE,END_DATE,POSITION_ID)VALUES(4, to_date('20-10-2018','DD-MM-RRRR'),to_date('28-11-2019','DD-MM-RRRR'),11 );

																		      
