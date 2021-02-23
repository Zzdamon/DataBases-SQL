
---------------------------------------------- EXERCISES -----------------------------------------------------------


--Display all the people with the 'Project manager' position 

SELECT e.EMPLOYEE_ID, e.first_name
FROM human_resources e, POSITIONS p
WHERE e.position_id=p.position_id AND p.position_title= 'Project manager';


--Change the salary of everyone with the 'Project manager' position 

UPDATE HUMAN_RESOURCES
SET salary=salary+100
WHERE position_id= (select position_id
from positions 
where position_title ='Project manager');
SELECT * FROM HUMAN_RESOURCES;

--Display how many months are left to finish 'Bucharest Pride 2020' project

SELECT round(MONTHS_BETWEEN(end_date,sysdate)) months
FROM projects
WHERE project_title='Bucharest Pride 2020';


--Display the id and name of all the partners that funded project 1 and how much money they donated

SELECT p.partner_id,p.partner_name, f.allocated_funds
FROM funds f, partners p
WHERE p.partner_id=f.partner_id AND f.project_id=1;
--Display project id and title and how many ppl are involved in each project. Order by project_id

SELECT p.project_id, p.project_title, COUNT(employee_id)
FROM projects p, human_resources h
WHERE p.project_id=h.project_id
GROUP BY p.project_id, p.project_title 
ORDER BY p.project_id;

--Display project id and title only for the projects that have more than 1 person involved in it. Order by project_id

SELECT p.project_id, p.project_title, COUNT(employee_id) PEOPLE_INVOLVED
FROM projects p, human_resources h
WHERE p.project_id=h.project_id
GROUP BY p.project_id, p.project_title 
HAVING  COUNT(employee_id)>1
ORDER BY p.project_id;


--Make a view to show all the projects id and name, with their total allocated funds. If it is null, show 0.

CREATE OR REPLACE VIEW v_project_funds
AS SELECT p.project_id, p.project_title, SUM(NVL(f.allocated_funds,0)) funds FROM projects p, funds f
WHERE p.project_id=f.project_id(+)
GROUP BY  p.project_id, p.project_title;



--We need more funds for project 1. Display all the partner names, except for the ones who already donated to project 1.
SELECT partner_id, partner_name
FROM partners 
MINUS
SELECT p.partner_id,  p.partner_name
FROM partners p, funds f
WHERE p.partner_id = f.partner_id AND f.project_id=1;



--Make a virtual table(view) with all the volunteers

CREATE OR REPLACE VIEW v_volunteers
AS SELECT * FROM human_resources
WHERE position_id IN (SELECT position_id FROM positions WHERE upper(position_title) LIKE '%VOLUNTEER%');
 

-- We need more volunteers for project 2. Assign all the available volunteers and the volunteers working on project 1 on project 2, and let all the volunteers working on project 3 on project 3

SELECT * FROM human_resources;

UPDATE human_resources
UPDATE human_resources
SET project_id=
CASE WHEN project_id = 1 THEN 2
WHEN project_id =3 THEN 3
ELSE 2 END ; 
SELECT * FROM human_resources;
 

-- We need more volunteers for project 2. Assign all the available volunteers and the volunteers working on project 1 on project 2, and let all the volunteers working on project 3 on project 3(using DECODE func)
SELECT * FROM HUMAN_RESOURCES;
UPDATE HUMAN_RESOURCES
SET project_id=
DECODE(project_id,1,2, 3, 3,2);
SELECT * FROM HUMAN_RESOURCES ;


--Create the synonim "people" for the human_resources table
CREATE SYNONYM people FOR human_resources;

--Delete the synonim for human_resources table
DROP SYNONYM people;


--Display the id, first name, coordinator and hyerarchical level of the employees, starting with the person with id=1

SELECT employee_id, first_name, coordinator_id, LEVEL FROM human_resources
CONNECT BY PRIOR employee_id= coordinator_id
START WITH employee_id = 1;


-- display all the people who don't get paid 
SELECT *
FROM human_resources
WHERE salary IS NULL;


-- Create an index on Human_resources table, on first_name column

CREATE INDEX idx_upper_name ON human_resources(UPPER(first_name));




--Make a sequance to assure the uniqness of the primary key in human_resources table

CREATE SEQUENCE seq_empid
START WITH 500 INCREMENT BY 10
MAXVALUE 1000 NOCYCLE;

INSERT INTO human_resources(EMPLOYEE_ID,FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, POSITION_ID, DEPARTMENT_ID) 
VALUES (seq_empid.NEXTVAL, 'Mike', 'Mikerson','miker@gmail.ro','0738888899',to_date('28-11-2019','DD-MM-RRRR'),22,20); 
 

--Select the employees who have the position of "Facilitators Volunteer Coordinator" and "Organisers Volunteer Coordinator"
SELECT h.employee_id, h.first_name,p.position_id
FROM human_resources h, positions p
WHERE h.position_id=p.position_id
AND p.position_title ='Organisers Volunteer Coordinator'
UNION
SELECT h.employee_id, h.first_name,p.position_id
FROM human_resources h, positions p
WHERE h.position_id=p.position_id
AND p.position_title ='Facilitators Volunteer Coordinator'; 

