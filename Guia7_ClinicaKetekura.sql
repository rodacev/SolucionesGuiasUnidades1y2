select * from medico;--a
select * from medico;--b

-- QUERY 1

select SUBSTR(a.med_rut,1,1)||'.'||SUBSTR(a.med_rut,2,3)||'.'||SUBSTR(a.med_rut,5,3)||'-'||a.dv_rut as "RUT JEFE",
       a.pnombre||' '||a.snombre||' '||a.apaterno||' '||a.amaterno as "NOMBRE JEFE",
       a.sueldo_base as "SUELDO BASE",
       count(*) as "TOTAL MEDICOS A SU CARGO",
       round(a.sueldo_base*1/100)*count(*) as "ASIGNACION JEFE"
from medico a join medico b
on b.jefe_rut = a.med_rut
group by a.med_rut,a.dv_rut,a.pnombre,a.snombre,a.apaterno,a.amaterno,a.sueldo_base
order by a.apaterno;


-- QUERY 2

select * from atencion;--a
select * from medico;--b

select substr(lpad(a.med_rut,8,'0'),1,2)||'.'||
              substr(lpad(a.med_rut,8,'0'),3,3)||'.'||
              substr(lpad(a.med_rut,8,'0'),6)as "RUT MEDICO",
       b.pnombre||' '||b.snombre||' '||b.apaterno||' '||b.amaterno as "MEDICO",       
       lpad(extract(month from a.fecha_atencion)||'/'||
              extract(year from a.fecha_atencion),7,'0')as "MES ATENCIONES MEDICAS",
       ltrim(TO_CHAR(ROUND((count(a.fecha_atencion)*b.sueldo_base)/100),'$999g999g999')) as "BONF. POR ATENCIONES MEDICAS"
from atencion a join medico b
on b.med_rut = a.med_rut
where extract(month from a.fecha_atencion) = extract(month from sysdate)-1
group by a.med_rut,
         extract(month from a.fecha_atencion),
         extract(year from a.fecha_atencion),
         b.sueldo_base,b.pnombre,
         b.snombre,
         b.apaterno,
         b.amaterno
having count(a.fecha_atencion)>=2;

select extract(month from sysdate)-1 from dual;

-- query 3


select * from atencion;--a
select * from unidad;--b
select * from cargo;--c
select * from medico;--d

select 
       lower(b.nombre) as "UNIDAD",
       upper(c.nombre) as "CARGO",
       count(a.ate_id) as "TOTAL DE ATENCIONES"

from atencion a  right join medico d on d.med_rut = a.med_rut
                 join unidad b on d.uni_id = b.uni_id 
                 join cargo c on d.car_id = c.car_id
group by b.nombre,c.nombre
order by b.nombre,"CARGO", count(a.med_rut)desc;

-- query 4

select * from atencion;--a
select * from paciente;--b
select * from salud;--c
select * from tipo_salud;--d

select a.ate_id as atencion,
       a.fecha_atencion||' '||a.hr_atencion as fecha_hora_atencion,
       a.pac_rut as run_paciente,
       d.descripcion||','||c.descripcion
from atencion a join paciente b on b.pac_rut = a.pac_rut
                join salud c on c.sal_id = b.sal_id
                join tipo_salud d on d.tipo_sal_id = c.tipo_sal_id
where a.fecha_atencion between last_day(add_months(sysdate,-2))+1 
                         and last_day(add_months(sysdate,-1))
order by a.fecha_atencion,a.hr_atencion,b.apaterno;


-- query 5

select * from atencion;--a
select * from medico;--b
select * from unidad;--c

select 
       b.pnombre||' '||b.snombre||' '||b.apaterno||' '||b.amaterno as medico,
       c.nombre,
       substr(c.nombre,1,2)||substr(b.apaterno,-3,2)
                           ||substr(b.telefono,1,3)
                           ||extract(year from b.fecha_contrato)
                           ||'@medicocktk.cl' as "CORREO MEDICO",
       count(a.ate_id)as "ATENCIONES MEDICAS"
from atencion a right join medico b on b.med_rut = a.med_rut
                      join unidad c on c.uni_id = b.uni_id
group by a.med_rut,b.pnombre,b.snombre,b.apaterno,b.amaterno,c.nombre,b.telefono,b.fecha_contrato
having count(*)<15
order by count(a.ate_id),b.apaterno;


-- query 6

select * from atencion;--a
select * from paciente;--b

select b.pnombre||' '||b.snombre||' '||b.apaterno||' '||b.amaterno as "NOMBRE DEL PACIENTE",
       CASE 
         when count(a.ate_id) = 0 then 'No posee atenciones durante el año '||to_char(extract(year from sysdate)-1)||', no le corresponde reembolso'
         when count(a.ate_id) = 1 then 'Posee '||count(a.ate_id)||' atenciones durante el año '||to_char(extract(year from sysdate)-1)||', le corresponde 5% de reembolso de su entidad de salud'                                   
         when count(a.ate_id) between 2 and 3 then 'Posee '||count(a.ate_id)||' atenciones durante el año '||to_char(extract(year from sysdate)-1)||', le corresponde 10% de reembolso de su entidad de salud' 
         when count(a.ate_id) between 4 and 5 then 'Posee '||count(a.ate_id)||' atenciones durante el año '||to_char(extract(year from sysdate)-1)||', le corresponde 20% de reembolso de su entidad de salud' 
         ELSE 'Posee '||count(a.ate_id)||' atenciones durante el año '||to_char(extract(year from sysdate)-1)||', le corresponde 35% de reembolso de su entidad de salud'  
       END "OBS.REEMBOLSO AL PACIENTE"
from atencion a right join paciente b on b.pac_rut = a.pac_rut
where extract(year from a.fecha_atencion) = extract(year from sysdate)-1 or a.fecha_atencion is null
group by b.pnombre,b.snombre,b.apaterno,b.amaterno
order by b.apaterno,b.pnombre;

-- query 7

select * from atencion;--a
select * from paciente;--b
select * from porc_descto_3ra_edad;--c

select to_char(a.pac_rut,'09g999g999')||'-'||b.dv_rut as "RUT PACIENTE",
       b.pnombre||' '||b.snombre||' '||b.apaterno||' '||b.amaterno as "NOMBRE PACIENTE",
       extract(year from sysdate) - extract(year from b.fecha_nacimiento) as "AÑOS",
       a.fecha_atencion||' '||a.hr_atencion as "FECHA Y HORA ATENCION",
       lpad((to_char(a.costo,'$999g999g999')),20,' ') as "COSTO ATENCION S/DESCUENTO",
       lpad(to_char(round(a.costo - (a.costo*(c.porcentaje_descto*1/100))),'$999g999g999'),20,' ') as "COSTO ATENCION C/DESCUENTO",
       to_char(round((a.costo*(c.porcentaje_descto*1/100))),'$999g999g999') as "MONTO A DEVOLVER"
from atencion a join paciente b on b.pac_rut = a.pac_rut
                join porc_descto_3ra_edad c on (extract(year from sysdate) - extract(year from b.fecha_nacimiento))
                     between c.anno_ini and c.anno_ter
where extract(year from sysdate) - extract(year from b.fecha_nacimiento) >= 65
order by a.fecha_atencion,a.hr_atencion;






















