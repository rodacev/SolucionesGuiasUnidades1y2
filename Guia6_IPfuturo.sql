--GUIA 6
-- QUERY 1

select a.carreraid "CODIGO CARRERA",
       upper(b.descripcion) as "NOMBRE CARRERA",
       a.nombre||' '||a.apaterno||' '||a.amaterno as "NOMBRE ALUMNO"
from
       alumno a inner join carrera b
       on b.carreraid = a.carreraid
order by 
      b.descripcion, a.apaterno;
      
-- QUERY 2

select upper(b.descripcion) as "ESCUELA",
       count(a.carreraid) as "CARRERAS IMPARTIDAS"
from 
       carrera a inner join escuela b
       on b.escuelaid = a.escuelaid
group by
       a.escuelaid,b.descripcion
order by 
       count(a.carreraid)desc, b.descripcion;
       
-- QUERY 3

select b.descripcion as "CARRERA",
       count(a.alumnoid) as "TOTAL ALUMNOS MATRICULADOS"
from alumno a inner join carrera b
on b.carreraid = a.carreraid
group by b.descripcion
having count(alumnoid) = (select max(cantidad) 
                          from (select count(alumnoid)as cantidad 
                                from alumno 
                                group by carreraid));
                                
-- QUERY 4

select 
       b.nombre||' '||b.apaterno||' '||b.amaterno as "NOMBRE ALUMNO",
       a.fecha_ini_prestamo as "FECHA INICIO PRESTAMO",
       a.fecha_ter_prestamo as "FECHA TERMINO PRESTAMO",
       a.fecha_devolucion as "FECHA DEVOLUCION",
       CASE 
          WHEN (a.fecha_devolucion - a.fecha_ter_prestamo) < 0 THEN 0
          ELSE (a.fecha_devolucion - a.fecha_ter_prestamo) END "DIAS DE ATRASO",
       TO_CHAR((a.fecha_devolucion - a.fecha_ter_prestamo)*1000,'$999g999g999') "VALOR MULTA" 
from
       prestamo a inner join alumno b
         on b.alumnoid = a.alumnoid
where  a.fecha_devolucion between (last_day(add_months(sysdate,-2)))+1 and last_day(add_months(sysdate,-1)) 
             and (a.fecha_devolucion - a.fecha_ter_prestamo) > 0 
order by b.apaterno, "VALOR MULTA" desc;

-- para consultar vista de la guia:
-- where  a.fecha_devolucion between (last_day(add_months(sysdate,-15)))+1 and last_day(add_months(sysdate,-14))





-- QUERY 5

select b.titulo,
       'Se solicitó '||count(*)||' una vez el año '||(extract(year from sysdate)-2)as "VECES SOLICITADO"
from prestamo a inner join titulo b
on b.tituloid = a.tituloid
where extract(year from a.fecha_ini_prestamo) = extract(year from sysdate)-1
group by b.titulo
order by b.titulo;

--para consultar vista de la guia:
-- where extract(year from a.fecha_ini_prestamo) = extract(year from sysdate)-2


-- QUERY 6

select
       b.nombre||' '||b.apaterno||' '||b.amaterno as "ALUMNO",
       lower(substr(b.nombre,1,3)||substr(b.apaterno,-3)
          ||extract(year from b.fecha_nacimiento)
          ||'@alumnoiptf.cl') as "CORREO ALUMNO",
       count(*) as "LIBROS SOLICITADOS"
from prestamo a inner join alumno b
on b.alumnoid = a.alumnoid
group by b.nombre,b.apaterno,b.amaterno,b.fecha_nacimiento
order by "LIBROS SOLICITADOS"desc,b.apaterno;

--QUERY 7

select substr(a.run_emp,1,2)||'.'
           ||substr(a.run_emp,3,3)||'.'
           ||substr(a.run_emp,6,3)||'-'
           ||b.dv_run as "RUT EMPLEADO",
       to_char(b.salario,'$999g999g999') as salario,
       count(*) as "TOTAL PRESTAMOS ATENDIDOS",
       TO_CHAR(count(*)*10000,'$999g999g999') as "ASIGNACION POR PRESTAMOS" 
from prestamo a inner join empleado b
on b.run_emp = a.run_emp
where a.fecha_ini_prestamo between (last_day(add_months(sysdate,-15)))+1 and last_day(add_months(sysdate,-14))
group by a.run_emp,b.dv_run,b.salario
having COUNT(*)>2
order by count(*)desc,a.run_emp;

--para consultar vista de la guia:
-- where  a.fecha_devolucion between (last_day(add_months(sysdate,-15)))+1 and last_day(add_months(sysdate,-14))













       
       

     


