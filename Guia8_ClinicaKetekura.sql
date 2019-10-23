--GUIA 8

--query 1

CREATE TABLE MEDICOS_SERVICIO_COMUNIDAD AS 

(

select c.nombre as unidad,
       b.pnombre||' '||b.apaterno||' '||b.amaterno as medico,
       substr(c.nombre,1,2)||substr(b.apaterno,-3,2)||substr(b.telefono,1,3)||extract(year from b.fecha_contrato)||'@medicocktk.cl' as "CORREO MEDICO",
       count(a.ate_id) as "ATENCIONES MEDICAS"
from atencion a right join medico b on b.med_rut = a.med_rut
                join unidad c on c.uni_id = b.uni_id
where extract(year from fecha_atencion) = extract(year from sysdate)-1 or fecha_atencion is null ---
group by c.nombre, b.pnombre,b.apaterno,b.amaterno,b.telefono,b.fecha_contrato,a.med_rut
HAVING count(a.ate_id) < (
select max(total_atencion) 
from(
    select med_rut,
           count(ate_id)as total_atencion
    from atencion
    where extract(year from fecha_atencion) = extract(year from sysdate)-1
    group by med_rut
    ))); 
--order by c.nombre,b.apaterno;
SELECT * FROM MEDICOS_SERVICIO_COMUNIDAD
ORDER BY UNIDAD
;


-- query 2.1


select 
       to_char(fecha_atencion,'mm/yyyy') as "MES Y AÑO",
       count(ate_id) as "TOTAL DE ATENCIONES",
       lpad(to_char(sum(costo),'$999g999g999'),23,' ') as "VALOR TOTAL DE LAS ATENCIONES"
from atencion
where extract(year from fecha_atencion) = extract(year from sysdate)-1
group by to_char(fecha_atencion,'mm/yyyy')
having count(ate_id) > (

          select round(avg(cuenta_atenciones)) as prom_aten
          from (

               select extract(month from fecha_atencion), 
               count(ate_id) as cuenta_atenciones
               from atencion
               where extract(year from fecha_atencion) = extract(year from sysdate)-1
               group by extract(month from fecha_atencion)))
order by to_char(fecha_atencion,'mm/yyyy')
;


--query 2.2

select a.pac_rut||'-'||a.dv_rut as "RUT PACIENTE",
       a.pnombre||' '||a.snombre||' '||a.apaterno as "NOMBRE PACIENTE",
       b.ate_id as "ID ATENCION",
       c.fecha_venc_pago "FECHA VENCIMIENTO PAGO",
       c.fecha_pago as "FECHA PAGO",
       c.fecha_pago - c.fecha_venc_pago as "DIAS MOROSIDAD",
       to_char((c.fecha_pago - c.fecha_venc_pago)*2000,'$999g999g999') as "VALOR MULTA"
from paciente a join atencion b on b.pac_rut = a.pac_rut
                join pago_atencion c on c.ate_id = b.ate_id
where (c.fecha_pago - c.fecha_venc_pago) > (
               select trunc(avg(dias_atraso))
               from (
                    select a.ate_id,
                    a.fecha_pago - a.fecha_venc_pago as dias_atraso
                    from pago_atencion a join atencion b on b.ate_id = a.ate_id
                    where a.fecha_pago > a.fecha_venc_pago and extract(year from b.fecha_atencion) = extract(year from sysdate)))
                    order by c.fecha_venc_pago, "DIAS MOROSIDAD" desc

;

--query 3

CREATE TABLE RESUMEN1 AS (

select d.descripcion||','||c.descripcion as sistema_salud,
       count(a.ate_id) as total_atenciones
from atencion a join paciente b on b.pac_rut = a.pac_rut
                join salud c on c.sal_id = b.sal_id
                join tipo_salud d on d.tipo_sal_id = c.tipo_sal_id 
where a.fecha_atencion between last_day(add_months(sysdate,-2))+1 and last_day(add_months(sysdate,-1))
group by c.descripcion,d.descripcion
having count(a.ate_id) >
                        (select round(avg(total_aten)) as prom_aten_diaria
                         from (
                               select fecha_atencion,
                               count(ate_id) as total_aten
                               from atencion
                               where fecha_atencion between last_day(add_months(sysdate,-2))+1 and last_day(add_months(sysdate,-1))
                               group by fecha_atencion)))
;

SELECT * FROM RESUMEN_ATENCIONES_ENTSALUD
ORDER BY SISTEMA_SALUD
;


--query 4 


select d.nombre as especialidad,
       to_char(lpad(b.med_rut,8,'0'),'09g999g999')||'-'||b.dv_rut as rut,
       upper(b.pnombre||' '||b.snombre||' '||b.apaterno||' '||b.amaterno) as medico
from atencion a right join medico b on b.med_rut = a.med_rut
                join especialidad_medico c on c.med_rut = b.med_rut
                right join especialidad d on d.esp_id = c.esp_id 
where extract(year from a.fecha_atencion) = extract(year from sysdate)-1 or a.fecha_atencion is null
group by d.nombre,b.med_rut,b.dv_rut,b.pnombre,b.snombre,b.apaterno,b.amaterno
having count(a.ate_id) < 10
order by especialidad,b.apaterno
;






















    
