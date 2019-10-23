--ACTIVIDAD 1
--TRABAJANDO EN EL CENTRO DE INVESTIGACIÓN
--RODRIGO ACEVEDO

--QUERY 1
select * from proyecto;

--QUERY 2
select DISTINCT zona from empleado;

--QUERY 3
select rut,apellidos,nombres,email,sueldo 
from empleado;

--QUIERY 4
select rut||'-'||dv as RUN,apellidos||' '||nombres NOMBRE,puntaje, sueldo 
FROM empleado 
order by NOMBRE;

--QUERY 5
select zona ZONA,puntaje PUNTAJE,apellidos||' '||nombres NOMBRE,sueldo SUELDO 
from empleado 
order by zona,puntaje desc,nombre desc;

--QUERY 6
select DISTINCT rutempresa EMPRESA 
from empleado;
select rutempresa,apellidos,nombres,zona,puntaje,sueldo 
from empleado 
order by rutempresa,apellidos desc;







