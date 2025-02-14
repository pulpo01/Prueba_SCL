-- Archivo Sql usado por :
-- Traductor.sh para convertir a mayuscula empresa ingresada por parametro.
-- G.A.C.  
-- Julio del 2002

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

select upper('&1') from dual;

exit;
