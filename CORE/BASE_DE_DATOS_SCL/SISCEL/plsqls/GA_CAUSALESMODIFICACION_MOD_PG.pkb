CREATE OR REPLACE PACKAGE BODY GA_CAUSALESMODIFICACION_MOD_PG AS

CV_error_no_clasif VARCHAR2(100) := 'Error no clasificado';

 PROCEDURE GA_EXISTE_PR (EN_cod_causa IN NUMBER, LD_fecha IN  DATE, SN_cantidad OUT NOCOPY NUMBER, SN_COD_RETORNO OUT NOCOPY NUMBER, SV_MENS_RETORNO OUT NOCOPY VARCHAR2, SN_NUM_EVENTO OUT NOCOPY NUMBER)
  AS
/*
<Documentacion
  TipoDoc = Procedimiento">
   <Elemento
      Nombre = "GA_EXISTE_PR"
      Lenguaje="PL/SQL"
      Fecha creacion="01-07-2008"
      Creado por="nn"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripcion>recupera datos de cliente en facturacion</Descripcion>
      <Parámetros>
          <Entrada>
         </Entrada>
         <Salida>
		 </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
  Lv_SQL VARCHAR2(1000);
  BEGIN
     SN_COD_RETORNO := 0;
	 SV_mens_retorno := NULL;
     SN_num_evento := 0;
     SN_cantidad  := 0;

     lv_sql := 'SELECT COUNT(1)';
	 lv_sql := LV_SQL || ' FROM GA_CAUSALESMODIFICACION_TO A';
	 lv_sql := LV_SQL || ' WHERE A.COD_CAUSA = ' || EN_cod_causa;
	 lv_sql := LV_SQL || ' AND ' || LD_fecha || ' BETWEEN TRUNC(FECHA_DESDE)  AND NVL(FECHA_HASTA, SYSDATE);';

     SELECT COUNT(1)
	 INTO SN_cantidad
	  FROM GA_CAUSALESMODIFICACION_TO A
	 WHERE A.COD_CAUSA = EN_cod_causa
	   AND trunc(LD_fecha) BETWEEN TRUNC(FECHA_DESDE) AND NVL(FECHA_HASTA, SYSDATE);

  EXCEPTION
    WHEN OTHERS THEN
	    SN_COD_RETORNO := 1952; -- -91 No se pudo recuperar información de la causa de modificación
  	    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
  	         SV_mens_retorno := CV_error_no_clasif;
 	    END IF;

  	    SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, 1.0, USER, 'GA_CAUSALESMODIFICACION_MOD_PG.GE_EXISTE_PR', lv_sql, SQLCODE, SQLERRM );
  END;


END;
/
SHOW ERRORS
