CREATE OR REPLACE PACKAGE BODY FA_PROCFACTPREC_SP_PG AS

SN_cod_retornoau   ge_errores_td.cod_msgerror%TYPE;
SV_mens_retornoau  ge_errores_td.det_msgerror%TYPE;
SN_num_eventoau    ge_errores_pg.Evento;
SN_num_transaccion NUMBER(16);--ge_auditoria_to.num_ticket%TYPE;
ERR_MOAUDITORIA    EXCEPTION;
ERR_AGAUDITORIA    EXCEPTION;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE FA_INS_FA_PROCFACTPREC_PR (   Reg_Fa_Proc             IN         FA_PROCFACTPREC%ROWTYPE,
										SN_Cod_retorno      	OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                        SV_Mens_retorno     	OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                        SN_Num_evento       	OUT NOCOPY ge_errores_pg.evento
							            )
IS
/*
<Documentacion TipoDoc = "Procedure">
   <Elemento
      Nombre = "FA_INS_FA_PROCFACTPREC_PR"
      Fecha modificacion=" "
      Fecha creacion="20-03-2007"
      Programador="Javier Garcia"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Realiza un insert a la tabla FA_PROCFACTPREC</Descripcion>
      <Parametros>
         <Entrada>
			 <param nom="Reg_Fa_Proc" Tipo="Registro">Registro de la tabla FA_PROCFACTPREC</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"       Tipo="NUMERICO">Codigo de retorno</param>
            <param nom="SV_mens_retorno"      Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"        Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
LV_des_error      ge_errores_pg.DesEvent;
LV_sSql           ge_errores_pg.vQuery;

BEGIN

    SN_Cod_retorno 	:= 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento 	:= 0;


	INSERT INTO FA_PROCFACTPREC
	(
	COD_PROCESO   ,
    COD_PROCPREC  ,
    COD_ESTAPREC
	)
	VALUES
	(
	Reg_Fa_Proc.COD_PROCESO  ,
	Reg_Fa_Proc.COD_PROCPREC ,
	Reg_Fa_Proc.COD_ESTAPREC);


EXCEPTION
  WHEN OTHERS THEN
  	  SN_Cod_retorno:=4;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
	  SV_mens_retorno:=SV_mens_retorno || ' Tabla FA_PROCFACTPREC ';
	  LV_des_error   := 'FA_INS_FA_PROCFACTPREC_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, CV_version, USER, ' FA_PROCFACTPREC_SP_PG.FA_INS_FA_PROCFACTPREC_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END FA_INS_FA_PROCFACTPREC_PR;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE FA_SEL_FA_PROCFACTPREC_PR (   EN_Cod_Proceso          IN         FA_PROCFACTPREC.COD_PROCESO%TYPE,
										EN_Cod_Procprec         IN  	   FA_PROCFACTPREC.COD_PROCPREC%TYPE,
   			 							Reg_Fa_Proc             OUT NOCOPY FA_PROCFACTPREC%ROWTYPE,
   			 					  		SN_Cod_retorno      	OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                  		SV_Mens_retorno     	OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                  		SN_Num_evento       	OUT NOCOPY ge_errores_pg.evento)
IS
/*
<Documentacion TipoDoc = "Procedure">
   <Elemento
      Nombre = "FA_SEL_FA_PROCFACTPREC_PR"
      Fecha modificacion=" "
      Fecha creacion="20-03-2007"
      Programador="Javier Garcia"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Lee un registro de la tabla FA_PROCFACTPREC</Descripcion>
      <Parametros>
         <Entrada>
 		     <param nom="EN_Cod_Proceso" Tipo="Numerico">Código del proceso</param>
		     <param nom="EN_Cod_Procprec" Tipo="Numerico">Código del proceso anterior</param>
         </Entrada>
         <Salida>
		    <param nom="Reg_Fa_Proc" Tipo="Registro">Registro de la tabla FA_PROCFACTPREC</param>
            <param nom="SN_cod_retorno"       Tipo="NUMERICO">Codigo de retorno</param>
            <param nom="SV_mens_retorno"      Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"        Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
LV_des_error      ge_errores_pg.DesEvent;
LV_sSql           ge_errores_pg.vQuery;

BEGIN

    SN_Cod_retorno 	:= 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento 	:= 0;


	SELECT
	COD_PROCESO,
  	COD_PROCPREC,
    COD_ESTAPREC
	INTO Reg_Fa_Proc
  	FROM FA_PROCFACTPREC A
	WHERE  A.Cod_Proceso       = EN_Cod_Proceso
		   AND A.Cod_ProcPrec  = EN_Cod_ProcPrec;


EXCEPTION

WHEN NO_DATA_FOUND THEN

      SN_cod_retorno := 1110; -- Proceso de facturacion no tiene procesos precedentes
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
	  LV_des_error   := 'FA_SEL_FA_PROCFACTPREC_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, CV_version, USER, 'FA_PROCFACTPREC_SP_PG.FA_SEL_FA_PROCFACTPREC_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

  WHEN OTHERS THEN
  	  SN_Cod_retorno:=1;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
	  SV_mens_retorno:=SV_mens_retorno || ' Tabla FA_PROCFACTPREC ';
	  LV_des_error   := 'FA_SEL_FA_PROCFACTPREC_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, CV_version, USER, ' FA_PROCFACTPREC_SP_PG.FA_SEL_FA_PROCFACTPREC_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END FA_SEL_FA_PROCFACTPREC_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE FA_UPD_FA_PROCFACTPREC_PR (   EN_Cod_Proceso          IN FA_PROCFACTPREC.COD_PROCESO%TYPE,
										EN_Cod_Procprec         IN FA_PROCFACTPREC.COD_PROCPREC%TYPE,
   			 							Reg_Fa_Proc             IN FA_PROCFACTPREC%ROWTYPE,
   			 					  		SN_Cod_retorno      	OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                  		SV_Mens_retorno     	OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                  		SN_Num_evento       	OUT NOCOPY ge_errores_pg.evento)
IS
/*
<Documentacion TipoDoc = "Procedure">
   <Elemento
      Nombre = "FA_UPD_FA_PROCFACTPREC_PR"
      Fecha modificacion=" "
      Fecha creacion="20-03-2007"
      Programador="Javier Garcia"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Actualiza la tabla FA_PROCFACTPREC</Descripcion>
      <Parametros>
         <Entrada>
		     <param nom="EN_Cod_Proceso" Tipo="Numerico">Código del proceso</param>
		     <param nom="EN_Cod_Procprec" Tipo="Numerico">Código del proceso anterior</param>
			 <param nom="Reg_Fa_Proc" Tipo="Registro">Registro de la tabla FA_PROCFACTPREC</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"       Tipo="NUMERICO">Codigo de retorno</param>
            <param nom="SV_mens_retorno"      Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"        Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
LV_des_error      ge_errores_pg.DesEvent;
LV_sSql           ge_errores_pg.vQuery;

BEGIN

    SN_Cod_retorno 	:= 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento 	:= 0;

	UPDATE FA_PROCFACTPREC A
	SET
	COD_ESTAPREC 		       = Reg_Fa_Proc.COD_ESTAPREC
	WHERE  A.Cod_Proceso       = EN_Cod_Proceso
		   AND A.Cod_ProcPrec  = EN_Cod_ProcPrec;

	IF SQL%ROWCOUNT = 0 THEN
	   RAISE NO_DATA_FOUND;
	END IF;

EXCEPTION

  WHEN NO_DATA_FOUND THEN

      SN_cod_retorno := 1106; -- No se encontraron procesos para actualizar
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
	  LV_des_error   := 'FA_UPD_FA_PROCFACTPREC_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, CV_version, USER, 'FA_PROCFACTPREC_SP_PG.FA_UPD_FA_PROCFACTPREC_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

  WHEN OTHERS THEN
  	  SN_Cod_retorno:=2;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
	  SV_mens_retorno:=SV_mens_retorno || ' Tabla FA_PROCFACTPREC ';
	  LV_des_error   := 'FA_UPD_FA_PROCFACTPREC_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, CV_version, USER, ' FA_PROCFACTPREC_SP_PG.FA_UPD_FA_PROCFACTPREC_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END FA_UPD_FA_PROCFACTPREC_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE FA_DEL_FA_PROCFACTPREC_PR (   EN_Cod_proceso          IN FA_PROCFACTPREC.COD_PROCESO%TYPE,
										EN_Cod_procprec         IN FA_PROCFACTPREC.COD_PROCPREC%TYPE,
   			 					  		SN_Cod_retorno      	OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                  		SV_Mens_retorno     	OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                  		SN_Num_evento       	OUT NOCOPY ge_errores_pg.evento)
IS
/*
<Documentacion TipoDoc = "Procedure">
   <Elemento
      Nombre = "FA_DEL_FA_PROCFACTPREC_PR"
      Fecha modificacion=" "
      Fecha creacion="20-03-2007"
      Programador="Javier Garcia"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Elimina fisicamente un registro de la tabla FA_PROCFACTPREC</Descripcion>
      <Parametros>
         <Entrada>
		     <param nom="EN_Cod_Proceso" Tipo="Numerico">Código del proceso</param>
		     <param nom="EN_Cod_Procprec" Tipo="Numerico">Código del proceso anterior</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"       Tipo="NUMERICO">Codigo de retorno</param>
            <param nom="SV_mens_retorno"      Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"        Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
LV_des_error      ge_errores_pg.DesEvent;
LV_sSql           ge_errores_pg.vQuery;

BEGIN

    SN_Cod_retorno 	:= 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento 	:= 0;

  	DELETE FROM FA_PROCFACTPREC A
	WHERE  A.Cod_Proceso       = EN_Cod_Proceso
		   AND A.Cod_ProcPrec  = EN_Cod_ProcPrec;

	IF SQL%ROWCOUNT = 0 THEN
	   RAISE NO_DATA_FOUND;
	END IF;

EXCEPTION

  WHEN NO_DATA_FOUND THEN

      SN_cod_retorno := 1107; -- No se encontraron procesos para eliminar
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
	  LV_des_error   := 'FA_DEL_FA_PROCFACTPREC_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, CV_version, USER, 'FA_PROCFACTPREC_SP_PG.FA_DEL_FA_PROCFACTPREC_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

  WHEN OTHERS THEN
  	  SN_Cod_retorno:=3;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
	  SV_mens_retorno:=SV_mens_retorno || ' Tabla FA_PROCFACTPREC ';
	  LV_des_error   := 'FA_DEL_FA_PROCFACTPREC_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, CV_version, USER, ' FA_PROCFACTPREC_SP_PG.FA_DEL_FA_PROCFACTPREC_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END FA_DEL_FA_PROCFACTPREC_PR;


END FA_PROCFACTPREC_SP_PG;
/
SHOW ERRORS
