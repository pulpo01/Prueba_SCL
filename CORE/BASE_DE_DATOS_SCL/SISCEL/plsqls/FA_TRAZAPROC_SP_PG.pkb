CREATE OR REPLACE PACKAGE BODY FA_TRAZAPROC_SP_PG AS

SN_cod_retornoau   ge_errores_td.cod_msgerror%TYPE;
SV_mens_retornoau  ge_errores_td.det_msgerror%TYPE;
SN_num_eventoau    ge_errores_pg.Evento;
SN_num_transaccion NUMBER(16);--ge_auditoria_to.num_ticket%TYPE;
ERR_MOAUDITORIA    EXCEPTION;
ERR_AGAUDITORIA    EXCEPTION;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE FA_INS_FA_TRAZAPROC_PR (      Reg_Fa_TrazaProc        IN         FA_TRAZAPROC%ROWTYPE,
										SN_Cod_retorno      	OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                        SV_Mens_retorno     	OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                        SN_Num_evento       	OUT NOCOPY ge_errores_pg.evento
							            )
 IS
/*
<Documentacion TipoDoc = "Procedure">
   <Elemento
      Nombre = "FA_INS_FA_TRAZAPROC_PR"
      Fecha modificacion=" "
      Fecha creacion="20-03-2007"
      Programador="Javier Garcia"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Realiza un insert a la tabla FA_TRAZAPROC</Descripcion>
      <Parametros>
         <Entrada>
			 <param nom="Reg_Fa_TrazaProc" Tipo="Registro">Registro de la tabla FA_TRAZAPROC</param>
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




	INSERT INTO FA_TRAZAPROC
	(
	COD_CICLFACT ,
  	COD_PROCESO  ,
    COD_ESTAPROC ,
    FEC_INICIO   ,
    FEC_TERMINO  ,
    GLS_PROCESO  ,
    COD_CLIENTE  ,
    NUM_ABONADO  ,
    NUM_REGISTROS,
    HOST_ID
	)
	VALUES
	(
	Reg_Fa_TrazaProc.COD_CICLFACT  ,
    Reg_Fa_TrazaProc.COD_PROCESO   ,
    Reg_Fa_TrazaProc.COD_ESTAPROC  ,
    Reg_Fa_TrazaProc.FEC_INICIO    ,
    Reg_Fa_TrazaProc.FEC_TERMINO   ,
    Reg_Fa_TrazaProc.GLS_PROCESO   ,
    Reg_Fa_TrazaProc.COD_CLIENTE   ,
    Reg_Fa_TrazaProc.NUM_ABONADO   ,
    Reg_Fa_TrazaProc.NUM_REGISTROS ,
    Reg_Fa_TrazaProc.HOST_ID
    );


EXCEPTION
  WHEN OTHERS THEN
  	  SN_Cod_retorno:=4;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
	  SV_mens_retorno:=SV_mens_retorno || ' Tabla FA_TRAZAPROC ';
	  LV_des_error   := 'FA_INS_FA_TRAZAPROC_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, CV_version, USER, ' FA_TRAZAPROC_SP_PG.FA_INS_FA_TRAZAPROC_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END FA_INS_FA_TRAZAPROC_PR;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE FA_SEL_FA_TRAZAPROC_PR (   	EN_Cod_Ciclfact         IN         FA_TRAZAPROC.COD_CICLFACT%TYPE,
										EN_Cod_Proceso          IN 		   FA_TRAZAPROC.COD_PROCESO%TYPE,
										EV_Host_id              IN 		   FA_TRAZAPROC.HOST_ID%TYPE,
   			 							Reg_Fa_TrazaProc        OUT NOCOPY FA_TRAZAPROC%ROWTYPE,
   			 					  		SN_Cod_retorno      	OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                  		SV_Mens_retorno     	OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                  		SN_Num_evento       	OUT NOCOPY ge_errores_pg.evento)
IS
/*
<Documentacion TipoDoc = "Procedure">
   <Elemento
      Nombre = "FA_SEL_FA_TRAZAPROC_PR"
      Fecha modificacion=" "
      Fecha creacion="20-03-2007"
      Programador="Javier Garcia"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Lee un registro de la FA_TRAZAPROC</Descripcion>
      <Parametros>
         <Entrada>
		     <param nom="EN_Cod_Ciclfact"       Tipo="numerico">Código de ciclo de facturación</param>
			 <param nom="EN_Cod_Proceso"        Tipo="numerico">Código Proceso</param>
			 <param nom="EV_Host_id             Tipo="caracter">Host Id</param>
         </Entrada>
         <Salida>
		    <param nom="Reg_Fa_TrazaProc" Tipo="Registro">Registro de la tabla FA_TRAZAPROC</param>
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
	COD_CICLFACT ,
  	COD_PROCESO  ,
    COD_ESTAPROC ,
    FEC_INICIO   ,
    FEC_TERMINO  ,
    GLS_PROCESO  ,
    COD_CLIENTE  ,
    NUM_ABONADO  ,
    NUM_REGISTROS,
    HOST_ID
	INTO Reg_Fa_TrazaProc
  	FROM FA_TRAZAPROC A
	WHERE  A.Cod_ciclfact      = EN_Cod_ciclfact
		   AND A.Cod_proceso   = EN_Cod_proceso
		   AND NVL(A.Host_id,'0')       = NVL(EV_Host_id,'0');


EXCEPTION
   WHEN NO_DATA_FOUND THEN
      SN_cod_retorno := 1103;  -- No existe traza del proceso

      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
	  LV_des_error   := 'FA_SEL_FA_TRAZAPROC_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_Num_evento, 'FA', SV_mens_retorno, CV_version, USER, ' FA_TRAZAPROC_SP_PG.FA_SEL_FA_TRAZAPROC_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

   WHEN OTHERS THEN
      SN_Cod_retorno:=1;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
	  SV_mens_retorno:=SV_mens_retorno || ' Tabla FA_TRAZAPROC ';
	  LV_des_error   := 'FA_SEL_FA_TRAZAPROC_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, CV_version, USER, ' FA_TRAZAPROC_SP_PG.FA_SEL_FA_TRAZAPROC_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END FA_SEL_FA_TRAZAPROC_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE FA_UPD_FA_TRAZAPROC_PR (   	EN_Cod_Ciclfact         IN         FA_TRAZAPROC.COD_CICLFACT%TYPE,
										EN_Cod_Proceso          IN 		   FA_TRAZAPROC.COD_PROCESO%TYPE,
										EV_Host_id              IN 		   FA_TRAZAPROC.HOST_ID%TYPE,
   			 							Reg_Fa_TrazaProc        IN 		   FA_TRAZAPROC%ROWTYPE,
   			 					  		SN_Cod_retorno      	OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                  		SV_Mens_retorno     	OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                  		SN_Num_evento       	OUT NOCOPY ge_errores_pg.evento)
IS
/*
<Documentacion TipoDoc = "Procedure">
   <Elemento
      Nombre = "FA_UPD_FA_TRAZAPROC_PR"
      Fecha modificacion=" "
      Fecha creacion="20-03-2007"
      Programador="Javier Garcia"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Actualiza un registro de la tabla FA_TRAZAPROC</Descripcion>
      <Parametros>
         <Entrada>
			 <param nom="EN_Cod_Ciclfact"       Tipo="numerico">Código de ciclo de facturación</param>
			 <param nom="EN_Cod_Proceso"        Tipo="numerico">Código Proceso</param>
			 <param nom="EV_Host_id             Tipo="caracter">Host Id</param>
			 <param nom="Reg_Fa_TrazaProc"      Tipo="Registro">Registro de la tabla FA_TRAZAPROC</param>
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

	UPDATE FA_TRAZAPROC A
	SET
    COD_ESTAPROC 		= Reg_Fa_TrazaProc.COD_ESTAPROC,
    FEC_INICIO   		= Reg_Fa_TrazaProc.FEC_INICIO,
    FEC_TERMINO  		= Reg_Fa_TrazaProc.FEC_TERMINO,
    GLS_PROCESO  		= Reg_Fa_TrazaProc.GLS_PROCESO,
    COD_CLIENTE  		= Reg_Fa_TrazaProc.COD_CLIENTE,
    NUM_ABONADO  		= Reg_Fa_TrazaProc.NUM_ABONADO,
    NUM_REGISTROS		= Reg_Fa_TrazaProc.NUM_REGISTROS
	WHERE  A.Cod_ciclfact      = EN_Cod_ciclfact
		   AND A.Cod_proceso   = EN_Cod_proceso
		   AND NVL(A.Host_id,'0')       = NVL(EV_Host_id,'0');

	IF SQL%ROWCOUNT=0 THEN
	   RAISE NO_DATA_FOUND;
    END IF;

EXCEPTION
  WHEN NO_DATA_FOUND THEN

      SN_cod_retorno := 1104;  -- No existen registros de traza de procesos para actualizar
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
	  LV_des_error   := 'FA_UPD_FA_TRAZAPROC_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, CV_version, USER, ' FA_TRAZAPROC_SP_PG.FA_UPD_FA_TRAZAPROC_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

  WHEN OTHERS THEN
      SN_Cod_retorno:=2;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
	  SV_mens_retorno:=SV_mens_retorno || ' Tabla FA_TRAZAPROC ';
	  LV_des_error   := 'FA_UPD_FA_TRAZAPROC_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, CV_version, USER, '  FA_TRAZAPROC_SP_PG.FA_UPD_FA_TRAZAPROC_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END FA_UPD_FA_TRAZAPROC_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE FA_DEL_FA_TRAZAPROC_PR (      EN_Cod_ciclfact         IN FA_TRAZAPROC.COD_CICLFACT%TYPE,
										EN_Cod_proceso          IN FA_TRAZAPROC.COD_PROCESO%TYPE,
										EV_host_id              IN FA_TRAZAPROC.HOST_ID%TYPE,
   			 					  		SN_Cod_retorno      	OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                  		SV_Mens_retorno     	OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                  		SN_Num_evento       	OUT NOCOPY ge_errores_pg.evento
								 )
IS
/*
<Documentacion TipoDoc = "Procedure">
   <Elemento
      Nombre = "FA_DEL_FA_TRAZAPROC_PR"
      Fecha modificacion=" "
      Fecha creacion="20-03-2007"
      Programador="Javier Garcia"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Elimina fisicamente un registro de la tabla FA_TRAZAPROC</Descripcion>
      <Parametros>
         <Entrada>
			 <param nom="EN_Cod_Ciclfact"       Tipo="numerico">Código de ciclo de facturación</param>
			 <param nom="EN_Cod_Proceso"        Tipo="numerico">Código Proceso</param>
			 <param nom="EV_Host_id             Tipo="caracter">Host Id</param>
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

  	DELETE FROM FA_TRAZAPROC A
    WHERE  A.Cod_ciclfact      = EN_Cod_ciclfact
		   AND A.Cod_proceso   = EN_Cod_proceso
		   AND NVL(A.Host_id,'0')       = NVL(EV_Host_id,'0');

	IF SQL%ROWCOUNT=0 THEN
	   RAISE NO_DATA_FOUND;
	END IF;


EXCEPTION
 WHEN NO_DATA_FOUND THEN
      SN_cod_retorno := 1105;  -- No existen registros de traza de procesos para eliminar

      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
	  LV_des_error   := 'FA_DEL_FA_TRAZAPROC_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_Num_evento, 'FA', SV_mens_retorno, CV_version, USER, ' FA_TRAZAPROC_SP_PG.FA_DEL_FA_TRAZAPROC_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

  WHEN OTHERS THEN
      SN_Cod_retorno:=3;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
	  SV_mens_retorno:=SV_mens_retorno || ' Tabla FA_TRAZAPROC ';
	  LV_des_error   := 'FA_DEL_FA_TRAZAPROC_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, CV_version, USER, ' FA_TRAZAPROC_SP_PG.FA_DEL_FA_TRAZAPROC_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END FA_DEL_FA_TRAZAPROC_PR;


END FA_TRAZAPROC_SP_PG;
/
SHOW ERRORS
