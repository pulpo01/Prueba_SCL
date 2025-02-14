CREATE OR REPLACE PACKAGE BODY GE_SEG_USUARIO_MOD_PG AS

CV_error_no_clasif VARCHAR2(100) := 'Error no clasificado';

 PROCEDURE GE_EXISTE_PR (EV_nom_usuario IN VARCHAR2, SN_cantidad OUT NOCOPY NUMBER, SN_COD_RETORNO OUT NOCOPY NUMBER, SV_MENS_RETORNO OUT NOCOPY VARCHAR2, SN_NUM_EVENTO OUT NOCOPY NUMBER)
  AS
/*
<Documentacion
  TipoDoc = Procedimiento">
   <Elemento
      Nombre = "GE_EXISTE_PR"
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
	 lv_sql := LV_SQL || ' FROM GE_SEG_USUARIO A';
	 lv_sql := LV_SQL || ' WHERE A.NOM_USUARIO =' || EV_nom_usuario;

     SELECT COUNT(1)
	 INTO SN_cantidad
	  FROM GE_SEG_USUARIO A
	 WHERE A.NOM_USUARIO = EV_nom_usuario;

  EXCEPTION
    WHEN OTHERS THEN
	    SN_COD_RETORNO := 901; -- -80 Error al recuperar usuario SCL
  	    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
  	         SV_mens_retorno := CV_error_no_clasif;
 	    END IF;

  	    SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GE', SV_mens_retorno, 1.0, USER, 'GE_SEG_USUARIO_MOD_PG.GE_EXISTE_PR', lv_sql, SQLCODE, SQLERRM );
  END;


END;
/
SHOW ERRORS
