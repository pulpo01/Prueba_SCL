set pages 0
set pause off
set veri off
set head off
set line 2000
set feedback off
set termout on
select cod_parametro         ||'|'||
       nvl(val_numerico,0)   ||'|'||
       nvl(val_caracter,' ') ||'|'  
  from fad_parametros
 where cod_modulo = 'FA'
   and (cod_parametro in (11,12,13)
    or  cod_parametro between 22 and 52);

exit;
