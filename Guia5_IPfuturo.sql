--EA5

--1
select to_char(max(salario),'$99g999g999')"SALARIO MAXIMO",
       to_char(min(salario),'$99g999g999')"SALARIO MINIMO",
       to_char(sum(salario),'$99g999g999')"SUMATORIA DE LOS SALARIOS",
       to_char(round(avg(salario)),'$99g999g999')"PROMEDIO SALARIOS"
from empleado;

--2
select tituloid "CODIGO DE LIBRO",
       count(ejemplarid)"TOTAL DE EJEMPLARES"
from ejemplar
group by tituloid
order by count(ejemplarid)asc,tituloid asc;

--3
select carreraid "IDENTIFICACION DE LA CARRERA",
       count(alumnoid) "TOTAL DE ALUMNOS"
from alumno
group by carreraid
having count(alumnoid)>4
order by count(alumnoid)desc,carreraid;

--4
select SUBSTR(LPAD(run_jefe,'8','0'),1,2)||'.'||
       SUBSTR(LPAD(run_jefe,'8','0'),3,3)||'.'||
       SUBSTR(LPAD(run_jefe,'8','0'),6)"RUN JEFE",
       count(run_emp) "CANTIDAD DE EMPLEADOS",
       MAX(SALARIO),
      (MAX(SALARIO)*1/100)*count(1) "BONIFICACIÓN"    
from
empleado
where run_jefe is not null
group by run_jefe;

--5
select a.id_escolaridad "ESCOLARIDAD",
       b.desc_escolaridad "DESCRIPCION ESCOLARIDAD",
       count(a.run_emp) "TOTAL DE EMPLEADOS",
       to_char(max(a.salario),'$99g999g999') "SALARIO MAXIMO",
       to_char(min(a.salario),'$99g999g999') "SALARIO MINIMO",
       to_char(sum(a.salario),'$99g999g999') "SALARIO TOTAL",
       to_char(round(avg(a.salario)),'$99g999g999') "SALARIO PROMEDIO"
from empleado a
join escolaridad_emp b
on a.id_escolaridad = b.id_escolaridad
group by a.id_escolaridad, b.desc_escolaridad
order by count(1)desc;

--6
select tituloid "CODIGO DEL LIBRO",
       count(prestamoid) "TOTAL DE VECES SOLICITADO",
       CASE WHEN count(prestamoid) = 1 THEN 'Se requiere comprar un nuevo ejemplar'
            WHEN count(prestamoid) between 2 and 3 THEN 'Se requiere comprar dos nuevos ejemplares'
            WHEN count(prestamoid) between 4 and 5 THEN 'Se requiere comprar cuatro nuevos ejemplares'
            WHEN count(prestamoid) > 5 THEN 'Se requiere comprar cinco nuevos ejemplares'
          ELSE 'Sin información' END "OBS.PRESUPUESTARIA"
from prestamo
where EXTRACT(year from fecha_ter_prestamo) = EXTRACT(year from sysdate)-1
group by tituloid
order by tituloid;


--7
select SUBSTR(LPAD(run_emp,'8','0'),1,2)||'.'||
       SUBSTR(LPAD(run_emp,'8','0'),3,3)||'.'||
       SUBSTR(LPAD(run_emp,'8','0'),6) "RUN EMPLEADOS",
       TO_CHAR(fecha_ini_prestamo,'mm-yyyy') "MES PRESTAMOS LIBROS",
       count(run_emp) "TOTAL DE PRESTAMOS ATENDIDOS",
       TO_CHAR(10000*count(run_emp),'$99,999,999')"ASIGNACION POR PRESTAMOS"
from
prestamo
where EXTRACT(year from fecha_ini_prestamo) = EXTRACT(year from sysdate)-1
group by TO_CHAR(fecha_ini_prestamo,'mm-yyyy'),run_emp
having count(run_emp)>2
order by TO_CHAR(fecha_ini_prestamo,'mm-yyyy'),count(run_emp)desc;



