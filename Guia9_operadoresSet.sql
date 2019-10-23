

--GUIA 9

--QUERY 1

select to_char(a.numrun_prof,'09g999g999')||'-'||a.dvrun_prof as "RUN PROFESIONAL",
       a.nombre||' '||a.appaterno||' '||a.apmaterno as "NOMBRE PROFESIONAL",
       b.nombre_profesion as profesion
from profesional a join profesion b on b.cod_profesion = a.cod_profesion 
where a.cod_profesion in (5,6)
union 
select to_char(a.numrun_prof,'09g999g999')||'-'||a.dvrun_prof,
       a.nombre||' '||a.appaterno||' '||a.apmaterno as nombre,
       b.nombre_profesion
from otros_profesionales a join profesion b on b.cod_profesion = a.cod_profesion
where a.cod_profesion in (5,6);


-- QUERY 2

select to_char(a.numrun_prof,'09g999g999')||' '||b.dvrun_prof as "RUN PROFESIONAL",
       b.nombre||' '||b.appaterno||' '||b.apmaterno as "NOMBRE PROFESIONAL",
       c.nombre_profesion as profesion
from asesoria a join contador_auditor b on b.numrun_prof = a.numrun_prof
                join profesion c on c.cod_profesion = b.cod_profesion
intersect           
select to_char(a.numrun_prof,'09g999g999')||' '||b.dvrun_prof,
       b.nombre||' '||b.appaterno||' '||b.apmaterno,
       c.nombre_profesion
from asesoria a join contador_general b on b.numrun_prof = a.numrun_prof
                join profesion c on c.cod_profesion = b.cod_profesion;


-- QUERY 3

select * from profesional;
select * from otros_profesionales;
select * from profesion;

select to_char(a.numrun_prof,'09g999g999')||' '||a.dvrun_prof as "RUN PROFESIONAL",
       a.nombre||' '||a.appaterno||' '||a.apmaterno as "NOMBRE PROFESIONAL",
       b.nombre_profesion as "PROFESION"
from otros_profesionales a join profesion b on b.cod_profesion = a.cod_profesion 
intersect
select to_char(a.numrun_prof,'09g999g999')||' '||a.dvrun_prof,
       a.nombre||' '||a.appaterno||' '||a.apmaterno,
       b.nombre_profesion
from profesional a join profesion b on b.cod_profesion = a.cod_profesion
where a.cod_profesion = 4;


-- QUERY 4

select * from contador_general;
select * from contador_auditor;
select * from profesion;
select * from otros_profesionales;


--a)	Jefe área consultoría Contable:

select 'NUEVA TABLA' as "ORIGEN DE LOS DATOS",
       'Contador General' as nombre_profesion,
        count(numrun_prof) as "TOTAL DE EMPLEADOS"
from contador_general
group by cod_profesion
union all
select 'TABLA ORIGINAL',
       'Contador General',
        count(numrun_prof)
from profesional
where cod_profesion = 2
group by cod_profesion;


select 'NUEVA TABLA' as "ORIGEN DE LOS DATOS",
       'Contador Auditor' as nombre_profesion,
        count(numrun_prof) as "TOTAL DE EMPLEADOS"
from contador_auditor
where cod_profesion = 1
group by cod_profesion
union
select 'TABLA ORIGINAL',
       'Contador Auditor',
        count(numrun_prof)
from profesional
where cod_profesion = 1
group by cod_profesion;

--b)	Jefe área consultoría Informática:

select 'NUEVA TABLA' as "ORIGEN DE LOS DATOS",
       'Ingeniero Informatico' as nombre_profesion,
        count(numrun_prof) as "TOTAL DE EMPLEADOS"
from informatico
where cod_profesion = 3
group by cod_profesion
union all
select 'TABLA ORIGINAL',
       'Ingeniero Informatico',
        count(numrun_prof)
from profesional
where cod_profesion = 3
group by cod_profesion;


--c)	Jefe área consultoría Prevención:

select 'NUEVA TABLA' as "ORIGEN DE LOS DATOS",
       'Ingeniero Prevencionista' as nombre_profesion,
        count(numrun_prof) as "TOTAL DE EMPLEADOS"
from prevencionista
where cod_profesion = 4
group by cod_profesion
union all
select 'TABLA ORIGINAL',
       'Ingeniero Prevencionista',
        count(numrun_prof)
from profesional
where cod_profesion = 4
group by cod_profesion;


--d)	Jefe área consultoría Negocios:

select 'NUEVA TABLA' as "ORIGEN DE LOS DATOS",
        b.nombre_profesion,
        count(a.numrun_prof) as "TOTAL DE EMPLEADOS"
from otros_profesionales a right join profesion b on b.cod_profesion = a.cod_profesion
where b.cod_profesion = 5
group by b.nombre_profesion
union all
select 'TABLA ORIGINAL',
        b.nombre_profesion,
        count(numrun_prof)
from profesional a join profesion b on b.cod_profesion = a.cod_profesion
where a.cod_profesion = 5
group by b.nombre_profesion;


--e)	Jefe área consultoría Optimización de Procesos Industriales:

select 'NUEVA TABLA' as "ORIGEN DE LOS DATOS",
        b.nombre_profesion,
        count(a.numrun_prof) as "TOTAL DE EMPLEADOS"
from otros_profesionales a right join profesion b on b.cod_profesion = a.cod_profesion
where b.cod_profesion = 6
group by b.nombre_profesion
union all
select 'TABLA ORIGINAL',
        b.nombre_profesion,
        count(numrun_prof)
from profesional a join profesion b on b.cod_profesion = a.cod_profesion
where a.cod_profesion = 6
group by b.nombre_profesion;

select * from profesional;
select * from contador_auditor;

-- QUERY 5


   select to_char(a.numrun_prof,'09g999g999')||' '||a.dvrun_prof as run,
       a.nombre as nombre,
       a.appaterno as apellido_paterno,
       a.apmaterno as apellido_materno,
       b.nombre_profesion as profesion
   from profesional a join profesion b on b.cod_profesion = a.cod_profesion
   where a.cod_profesion = 1
      minus
   select to_char(a.numrun_prof,'09g999g999')||' '||a.dvrun_prof,
       a.nombre as nombre,
       a.appaterno as apellido_paterno,
       a.apmaterno as apellido_materno,
       b.nombre_profesion as profesion
   from contador_auditor a join profesion b on b.cod_profesion = a.cod_profesion
   where a.cod_profesion = 1
UNION ALL
   select to_char(a.numrun_prof,'09g999g999')||' '||a.dvrun_prof,
       a.nombre as nombre,
       a.appaterno as apellido_paterno,
       a.apmaterno as apellido_materno,
       b.nombre_profesion as profesion
   from profesional a join profesion b on b.cod_profesion = a.cod_profesion
   where a.cod_profesion = 2
      minus
   select to_char(a.numrun_prof,'09g999g999')||' '||a.dvrun_prof,
       a.nombre as nombre,
       a.appaterno as apellido_paterno,
       a.apmaterno as apellido_materno,
       b.nombre_profesion as profesion
   from contador_general a join profesion b on b.cod_profesion = a.cod_profesion
order by apellido_paterno,apellido_materno;














