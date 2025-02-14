CREATE OR REPLACE PACKAGE BODY FA_TRAZAFACT_CLIE_SP_PG AS

SN_cod_retornoau   ge_errores_td.cod_msgerror%TYPE;
SV_mens_retornoau  ge_errores_td.det_msgerror%TYPE;
SN_num_eventoau    ge_errores_pg.Evento;
SN_num_transaccion NUMBER(16);--ge_auditoria_to.num_ticket%TYPE;
ERR_MOAUDITORIA    EXCEPTION;
ERR_AGAUDITORIA    EXCEPTION;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE FA_INS_FA_TRAZAFACT_CLIE_PR ( Reg_Fa_TrazaFact_clie   IN         FA_TRAZAFACT_CLIE_TO%ROWTYPE,
										SN_Cod_retorno      	OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                        SV_Mens_retorno     	OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                        SN_Num_evento       	OUT NOCOPY ge_errores_pg.evento
							            ) IS
/*
<Documentacion TipoDoc = "Procedure">
   <Elemento
      Nombre = "FA_INS_FA_TRAZAFACT_CLIE_PR"
      Fecha modificacion=" "
      Fecha creacion="20-03-2007"
      Programador="Javier Garcia"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Realiza un insert a la tabla FA_TRAZAFACT_CLIE_TO</Descripcion>
      <Parametros>
         <Entrada>
			 <param nom="Reg_Fa_TrazaFact_clie" Tipo="Registro">Registro de la tabla FA_TRAZAFACT_CLIE_TO</param>
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


	INSERT INTO FA_TRAZAFACT_CLIE_TO
	(
	COD_CLIENTE  ,
	COD_CICLO    ,
	ANO_CICLO    ,
	COD_CICLFACT ,
	COD_PROCESO  ,
	COD_ESTAPROC ,
	FEC_INICIO   ,
	FEC_TERMINO  ,
	HOST_ID      ,
	FEC_ULTMOD   ,
	NOM_USUARIO
	)
	VALUES
	(
	Reg_Fa_TrazaFact_clie.COD_CLIENTE  ,
	Reg_Fa_TrazaFact_clie.COD_CICLO    ,
	Reg_Fa_TrazaFact_clie.ANO_CICLO    ,
	Reg_Fa_TrazaFact_clie.COD_CICLFACT ,
	Reg_Fa_TrazaFact_clie.COD_PROCESO  ,
	Reg_Fa_TrazaFact_clie.COD_ESTAPROC ,
	Reg_Fa_TrazaFact_clie.FEC_INICIO   ,
	Reg_Fa_TrazaFact_clie.FEC_TERMINO  ,
	Reg_Fa_TrazaFact_clie.HOST_ID      ,
	Reg_Fa_TrazaFact_clie.FEC_ULTMOD   ,
	Reg_Fa_TrazaFact_clie.NOM_USUARIO	);


EXCEPTION
  WHEN OTHERS THEN
  	  SV_mens_retorno:=4;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
	  SV_mens_retorno:=SV_mens_retorno || ' Tabla FA_TRAZAFACT_CLIE_TO ';
	  LV_des_error   := 'FA_INS_FA_TRAZAFACT_CLIE_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, CV_version, USER, ' FA_TRAZAFACT_CLIE_SP_PG.FA_INS_FA_TRAZAFACT_CLIE_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END FA_INS_FA_TRAZAFACT_CLIE_PR;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE FA_SEL_FA_TRAZAFACT_CLIE_PR ( EN_Cod_Cliente          IN         FA_TRAZAFACT_CLIE_TO.COD_CLIENTE%TYPE,
										EN_Cod_Ciclo            IN 		   FA_TRAZAFACT_CLIE_TO.COD_CICLO%TYPE,
										EN_Ano                  IN 		   FA_TRAZAFACT_CLIE_TO.ANO_CICLO%TYPE,
										EN_Cod_Ciclfact         IN 		   FA_TRAZAFACT_CLIE_TO.COD_CICLFACT%TYPE,
										EN_Cod_Proceso			IN 		   FA_TRAZAFACT_CLIE_TO.COD_PROCESO%TYPE,
										Reg_Fa_TrazaFact_clie   OUT NOCOPY FA_TRAZAFACT_CLIE_TO%ROWTYPE,
										SN_Cod_retorno      	OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                        SV_Mens_retorno     	OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                        SN_Num_evento       	OUT NOCOPY ge_errores_pg.evento
							            ) IS
/*
<Documentacion TipoDoc = "Procedure">
   <Elemento
      Nombre = "FA_SEL_FA_TRAZAFACT_CLIE_PR"
      Fecha modificacion=" "
      Fecha creacion="20-03-2007"
      Programador="Javier Garcia"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Lee un registro de la tabla FA_TRAZAFACT_CLIE_TO</Descripcion>
      <Parametros>
         <Entrada>
		 	 <param nom="EN_Cod_cliente"        Tipo="numerico">Código de cliente</param>
			 <param nom="EN_Cod_Ciclo"          Tipo="numerico">Código de ciclo</param>
			 <param nom="EN_Ano"                Tipo="numerico">Año</param>
			 <param nom="EN_Cod_Ciclfact"       Tipo="numerico">Código período de ciclo facturación</param>
			 <param nom="EN_Cod_Proceso"        Tipo="numerico">Código de Proceso</param>
         </Entrada>
         <Salida>
		    <param nom="Reg_Fa_TrazaFact_clie" Tipo="Registro">Registro de la tabla FA_TRAZAFACT_CLIE_TO</param>
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
	COD_CLIENTE  ,
	COD_CICLO    ,
	ANO_CICLO    ,
	COD_CICLFACT ,
	COD_PROCESO  ,
	COD_ESTAPROC ,
	FEC_INICIO   ,
	FEC_TERMINO  ,
	HOST_ID      ,
	FEC_ULTMOD   ,
	NOM_USUARIO
	INTO Reg_Fa_TrazaFact_clie
  	FROM FA_TRAZAFACT_CLIE_TO A
	WHERE  A.Cod_cliente       = EN_Cod_cliente
		   AND A.Cod_ciclo     = EN_Cod_ciclo
		   AND A.Ano_CICLO     = EN_Ano
		   AND A.Cod_ciclfact  = EN_Cod_ciclfact
		   AND A.Cod_Proceso   = EN_Cod_Proceso;



EXCEPTION

  WHEN NO_DATA_FOUND THEN
      SN_cod_retorno := 1102; -- No existe traza del cliente

      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
	  LV_des_error   := 'FA_SEL_FA_TRAZAFACT_CLIE_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_Num_evento, 'FA', SV_mens_retorno, CV_version, USER, ' FA_TRAZAFACT_CLIE_SP_PG.FA_SEL_FA_TRAZAFACT_CLIE_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

  WHEN OTHERS THEN
      SV_mens_retorno:=1;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
	  SV_mens_retorno:=SV_mens_retorno || ' Tabla FA_TRAZAFACT_CLIE ';
	  LV_des_error   := 'FA_SEL_FA_TRAZAFACT_CLIE_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, CV_version, USER, ' FA_TRAZAFACT_CLIE_SP_PG.FA_SEL_FA_TRAZAFACT_CLIE_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END FA_SEL_FA_TRAZAFACT_CLIE_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE FA_UPD_FA_TRAZAFACT_CLIE_PR ( EN_Cod_cliente          IN         FA_TRAZAFACT_CLIE_TO.COD_CLIENTE%TYPE,
										EN_Cod_ciclo            IN 		   FA_TRAZAFACT_CLIE_TO.COD_CICLO%TYPE,
										EN_Ano                  IN 		   FA_TRAZAFACT_CLIE_TO.ANO_CICLO%TYPE,
										EN_Cod_ciclfact         IN 		   FA_TRAZAFACT_CLIE_TO.COD_CICLFACT%TYPE,
										EN_Cod_Proceso			IN 		   FA_TRAZAFACT_CLIE_TO.COD_PROCESO%TYPE,
		  							  	Reg_Fa_TrazaFact_clie   IN 		   FA_TRAZAFACT_CLIE_TO%ROWTYPE,
										SN_Cod_retorno      	OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                        SV_Mens_retorno     	OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                        SN_Num_evento       	OUT NOCOPY ge_errores_pg.evento
							            ) IS
/*
<Documentacion TipoDoc = "Procedure">
   <Elemento
      Nombre = "FA_UPD_FA_TRAZAFACT_CLIE_PR"
      Fecha modificacion=" "
      Fecha creacion="20-03-2007"
      Programador="Javier Garcia"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Actualiza la tabla FA_TRAZAFACT_CLIE_TO</Descripcion>
      <Parametros>
         <Entrada>
			 <param nom="EN_Cod_Cliente"        Tipo="numerico">Código de cliente</param>
			 <param nom="EN_Cod_Ciclo"          Tipo="numerico">Código de ciclo</param>
			 <param nom="EN_Ano"                Tipo="numerico">Año</param>
			 <param nom="EN_Cod_Ciclfact"       Tipo="numerico">Código período de ciclo facturación</param>
			 <param nom="EN_Cod_Proceso"        Tipo="numerico">Código de Proceso</param>
			 <param nom="Reg_Fa_TrazaFact_clie" Tipo="Registro">Registro de la tabla FA_TRAZAFACT_CLIE</param>
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

	UPDATE FA_TRAZAFACT_CLIE_TO A
	SET
	COD_PROCESO  = Reg_Fa_TrazaFact_clie.COD_PROCESO,
	COD_ESTAPROC = Reg_Fa_TrazaFact_clie.COD_ESTAPROC,
	FEC_INICIO   = Reg_Fa_TrazaFact_clie.FEC_INICIO,
	FEC_TERMINO  = Reg_Fa_TrazaFact_clie.FEC_TERMINO,
	HOST_ID      = Reg_Fa_TrazaFact_clie.HOST_ID,
	FEC_ULTMOD   = Reg_Fa_TrazaFact_clie.FEC_ULTMOD,
	NOM_USUARIO  = Reg_Fa_TrazaFact_clie.NOM_USUARIO
	WHERE  A.Cod_cliente       = EN_Cod_cliente
		   AND A.Cod_ciclo     = EN_Cod_ciclo
		   AND A.Ano_CICLO 	       = EN_Ano
		   AND A.Cod_ciclfact  = EN_Cod_ciclfact
		   AND A.Cod_Proceso   = EN_Cod_Proceso;

	IF SQL%ROWCOUNT = 0 THEN
	   RAISE NO_DATA_FOUND;
	END IF;
EXCEPTION

 WHEN NO_DATA_FOUND THEN

      SN_cod_retorno := 1108; -- No se encontraron registros para actualizar traza del cliente
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
	  LV_des_error   := 'FA_UPD_FA_TRAZAFACT_CLIE_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, CV_version, USER, ' FA_TRAZAFACT_CLIE_SP_PG.FA_UPD_FA_TRAZAFACT_CLIE_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

  WHEN OTHERS THEN
      SV_mens_retorno:=2;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
	  SV_mens_retorno:=SV_mens_retorno || ' Tabla FA_TRAZAFACT_CLIE ';
	  LV_des_error   := 'FA_UPD_FA_TRAZAFACT_CLIE_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, CV_version, USER, ' FA_TRAZAFACT_CLIE_SP_PG.FA_UPD_FA_TRAZAFACT_CLIE_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END FA_UPD_FA_TRAZAFACT_CLIE_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE FA_DEL_FA_TRAZAFACT_CLIE_PR ( EN_Cod_cliente          IN         FA_TRAZAFACT_CLIE_TO.COD_CLIENTE%TYPE,
										EN_Cod_ciclo            IN 		   FA_TRAZAFACT_CLIE_TO.COD_CICLO%TYPE,
										EN_Ano                  IN 		   FA_TRAZAFACT_CLIE_TO.ANO_CICLO%TYPE,
										EN_Cod_ciclfact         IN 		   FA_TRAZAFACT_CLIE_TO.COD_CICLFACT%TYPE,
										EN_Cod_Proceso			IN 		   FA_TRAZAFACT_CLIE_TO.COD_PROCESO%TYPE,
										SN_Cod_retorno      	OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                        SV_Mens_retorno     	OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                        SN_Num_evento       	OUT NOCOPY ge_errores_pg.evento
							            ) IS
/*
<Documentacion TipoDoc = "Procedure">
   <Elemento
      Nombre = "FA_DEL_FA_TRAZAFACT_CLIE_PR"
      Fecha modificacion=" "
      Fecha creacion="20-03-2007"
      Programador="Javier Garcia"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Elimina un registro fisicamente de la tabla FA_TRAZAFACT_CLIE</Descripcion>
      <Parametros>
         <Entrada>
			 <param nom="EN_Cod_Cliente"        Tipo="numerico">Código de cliente</param>
			 <param nom="EN_Cod_Ciclo"          Tipo="numerico">Código de ciclo</param>
			 <param nom="EN_Ano"                Tipo="numerico">Año</param>
			 <param nom="EN_Cod_Ciclfact"       Tipo="numerico">Código período de ciclo facturación</param>
			 <param nom="EN_Cod_Proceso"        Tipo="numerico">Código de Proceso</param>
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

  	DELETE FROM FA_TRAZAFACT_CLIE_TO A
	WHERE  A.Cod_cliente       = EN_Cod_cliente
		   AND A.Cod_ciclo     = EN_Cod_ciclo
		   AND A.Ano_Ciclo     = EN_Ano
		   AND A.Cod_ciclfact  = EN_Cod_ciclfact
		   AND A.Cod_Proceso   = EN_Cod_Proceso;

	IF SQL%ROWCOUNT = 0 THEN
	   RAISE NO_DATA_FOUND;
	END IF;

EXCEPTION
  WHEN NO_DATA_FOUND THEN

      SN_cod_retorno := 1109; -- No se encontraron registros para eliminar traza del cliente
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
	  LV_des_error   := 'FA_DEL_FA_TRAZAFACT_CLIE_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, CV_version, USER, ' FA_TRAZAFACT_CLIE_SP_PG.FA_DEL_FA_TRAZAFACT_CLIE_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

  WHEN OTHERS THEN
      SV_mens_retorno:=3;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
	  SV_mens_retorno:=SV_mens_retorno || ' Tabla FA_TRAZAFACT_CLIE_TO ';
	  LV_des_error   := 'FA_DEL_FA_TRAZAFACT_CLIE_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, CV_version, USER, ' FA_TRAZAFACT_CLIE_SP_PG.FA_DEL_FA_TRAZAFACT_CLIE_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END FA_DEL_FA_TRAZAFACT_CLIE_PR;


END FA_TRAZAFACT_CLIE_SP_PG;
/
SHOW ERRORS
