--ACTIVIDAD 2 
--TRABAJANDO EN LA EMPRESA DE ASESORÍAS
--RODRIGO ACEVEDO

--QUERY 1
select rut,apellidos||' '||nombres EMPLEADO,email as CORREO,FECINGRESO,PUNTAJE 
FROM empleado 
where puntaje>450 
order by puntaje desc;

--QUERY 2
select rut,apellidos||' '||nombres EMPLEADO,email,zona,sueldo
from empleado
where (zona='Centro' or zona='Oriente') and sueldo>1500000;

--QUERY 3
select rut,apellidos||' '||nombres EMPLEADO,email,fecnac NACIMIENTO,sueldo 
from empleado
where to_char(fecnac,'mm')=06
order by apellidos;

--QUERY 4
select rut,apellidos||' '||nombres empleado,zona,rutempresa,sueldo,(sueldo*1.20)sueldo_aumentado from empleado
where zona<>'Centro' and rutempresa is not null
order by empleado;

--QUERY 5
select rut,apellidos||' '||nombres empleado,zona,numproyectos,sueldo from empleado
where numproyectos
between 8 and 12
order by numproyectos desc;

--QUERY 6
select rut,apellidos||' '||nombres empleado,email,fecingreso ingreso,sueldo from empleado
where apellidos like '%ch%';

--QUERY 7
select rut, apellidos||' '||nombres empleado,email,rutempresa empresa,zona,sueldo from empleado
where (zona<>'Centro' and zona<>'Norte' and zona<>'Poniente') or rutempresa is null
order by zona;





