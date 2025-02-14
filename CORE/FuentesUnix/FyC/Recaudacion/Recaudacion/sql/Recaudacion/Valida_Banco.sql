-- Archivo Sql usado por :
-- new_pac.sh para validar el codigo de banco.
-- G.A.C.  
-- Abril del 2003

set timing off;                                                
set head off;                                                  
set echo off;                                                  
set heading on;                                                
set tab off;                                                   
set TRIMS off;                                                 
set trimout on;                                                
set wrap off;                                                  
set pages 0;                                                   
set serverout on;                                              
set verify off;                                                
set feedback off;    

select count(*) from ge_bancos where cod_banco = '&1';

exit;
