CREATE OR REPLACE PROCEDURE AL_GENERAARCHIVO_PR(p_orden al_cab_numeracion.num_numeracion%type)
IS


CURSOR c_parejas(p_orden al_cab_numeracion.num_numeracion%type)
IS
     SELECT num_serie, num_telefono
	 FROM al_ser_numeracion
	 WHERE num_numeracion=p_orden
	 AND lin_numeracion=1
	 ;
	 
 v_archivo      utl_file.file_type;	
 v_path         VARCHAR2(100);
 v_nombre_arch  VARCHAR2(100);
 v_fecha        DATE;
 v_registro     VARCHAR2(40);
 v_prob         exception;
	 
BEGIN
   v_fecha:= sysdate;
   v_nombre_arch:='SERIES_'||to_char(v_fecha,'dd-mm-yyy')||'_ORDEN'||to_char(p_orden)||'.dat';
--   SELECT val_caracter
--   INTO v_path 
--   FROM fad_parametros 
--   WHERE cod_parametro = 3 
--   AND cod_modulo = 'FA'
--   ;
--   v_path:='/produccion/explotacion/xpalmace/carga_numeracion/archivos/archivo_parejas/';
--   v_path:='/produccion/explotacion/xpalmace/';
   v_path:='/samba/ready';   

   v_archivo:= utl_file.fopen(v_path,v_nombre_arch,'w'); 

   FOR v_parejas IN c_parejas(p_orden) LOOP
       v_registro:=v_parejas.num_telefono||'   '||v_parejas.num_serie;
	   utl_file.put_line(v_archivo,v_registro);
   END LOOP;
   utl_file.fclose_all;
EXCEPTION
 WHEN OTHERS THEN
     raise_application_error (-20100,'Problemas Generacion Fichero: '||to_char(SQLCODE)||' - '||SQLERRM);   
END;
/
SHOW ERRORS
