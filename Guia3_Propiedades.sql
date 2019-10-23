--ACTIVIDAD 3
--PROPIEDADES
--RODRIGO ACEVEDO

select * from empleado order by paterno;
select * from categoria;
select * from propietario;
select * from propiedad;
select * from cliente;

--QUERY 1
select rutemp run_empledo,paterno||' '||materno||' '||nombre nombre,direccion,fono1,
nvl(fono2, 'NO POSEE FONO')fono2
from empleado
order by paterno;

--QUERY 2
select substr(rutemp,1,8)||'-'||substr(rutemp,-1,1) run_empleado,
sueldo,rpad(trunc(sueldo/100000),3,'%')porcentaje
from
empleado
where idcategoria=2;

--QUERY 3
select rpad(initcap(paterno||' '||materno||' '||nombre),30,' ') empleado,
    lower((SUBSTR(nombre,1,2)||'.'||paterno))nom_usuario,
    lower(SUBSTR(ecivil,1,1))||'*'||substr(rutemp,1,4)||''||
    lower(substr(direccion,1,1))||'_'||substr(direccion,2,1)contraseña
from empleado
order by nom_usuario;

--QUERY 4
select substr(rutemp,1,8)||'-'||substr(rutemp,-1,1)run_empleado,paterno||' '||materno||' '||nombre nombre,sueldo,
   case
       when puntaje > 500 then round(sueldo*1.35)
       when puntaje between 401 and 500 then round(sueldo*1.25)
       when puntaje between 301 and 400 then round(sueldo*1.15)
       when puntaje between 100 and 300 then round(sueldo*1.10)
       else sueldo
   end sueldo_aumentado
from empleado
order by paterno;

--QUERY 5
select substr(rutpro,1,length(rutpro)-1)||'-'||substr(rutpro,-1,1)run,
paterno||' '||materno||' '||nombre nombre,
    case
       when direccion like '%D/%' then replace(direccion,'D/','DEPTO')
       when direccion like '%V/%' then replace(direccion,'V/','VILLA')
       when direccion like '%C/%' then replace(direccion,'C/','CASA')
       when direccion like '%P/%' then replace(direccion,'P/','POBLACION')
       else direccion
    end
from
propietario;

--QUERY 6
select numpropiedad,idtipo tipo,renta,NVL(gastocomun,0) "GASTOS COMUNES",
       (renta*1.062)"NUEVA RENTA",NVL((gastocomun*1.062),0)"GASTO COMUN REAJUSTADO"
from propiedad;

--QUERY7
select rutcli rut,INITCAP(nomcli) "NOMBRE CLIENTE",direccion,fono1 "FONO CLIENTE",
       NVL(fono2,'NO REGISTRA') "CELULAR O CONTACTO"
from cliente
where ecivil='Soltero'
order by nomcli desc;

--QUERY 8
select rutcli,
       SUBSTR(nomcli,1,INSTR(nomcli,' ',1)-1)paterno,
       SUBSTR(nomcli,INSTR(nomcli,' '),INSTR(nomcli,' ',INSTR(nomcli,' ')+1)-INSTR(nomcli,' '))materno,
       SUBSTR(nomcli,INSTR(nomcli,' ',INSTR(nomcli,' ',1)+1))nombre
from
cliente
order by paterno;

















