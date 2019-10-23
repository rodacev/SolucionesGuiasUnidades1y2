
alter session 
set nls_date_format="dd-mm-yyyy";
select * from asesoria;
describe asesoria;

--QUERY 1
select SUBSTR(rutprof,1,length(rutprof)-1)||'-'||SUBSTR(rutprof,-1) run_profesional,
       idempresa emepresa,
       concat('$',SUBSTR(honorario,1,3)||'.'||SUBSTR(honorario,4)) honorario,
       inicio inicio_asesoria,
       fin termino_asesoria
from asesoria
where fin = '30072017'
order by inicio;

--QUERY 2
select SUBSTR(rutprof,1,length(rutprof)-1)||'-'||SUBSTR(rutprof,-1) run_profesional,
       idempresa empresa,
       concat('$',SUBSTR(honorario,1,3)||'.'||SUBSTR(honorario,4)) honorario,
       inicio inicio_asesoria,
       fin termino_asesoria
from asesoria
where fin = sysdate-1;

--QUERY 3
select SUBSTR(rutprof,1,length(rutprof)-1)||'-'||SUBSTR(rutprof,-1) run_profesional,
       idempresa empresa,
       concat('$',SUBSTR(honorario,1,3)||'.'||SUBSTR(honorario,4)) honorario,
       inicio inicio_asesoria,
       fin termino_asesoria     
from asesoria
where fin between '30-07-2017' and '06-08-2017'
order by fin;










