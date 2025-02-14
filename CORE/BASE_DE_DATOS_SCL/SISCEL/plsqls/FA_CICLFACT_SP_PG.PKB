CREATE OR REPLACE PACKAGE BODY FA_CICLFACT_SP_PG AS

SN_cod_retornoau   ge_errores_td.cod_msgerror%TYPE;
SV_mens_retornoau  ge_errores_td.det_msgerror%TYPE;
SN_num_eventoau    ge_errores_pg.Evento;
SN_num_transaccion NUMBER(16);--ge_auditoria_to.num_ticket%TYPE;
ERR_MOAUDITORIA    EXCEPTION;
ERR_AGAUDITORIA    EXCEPTION;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE FA_INS_FA_CICLFACT_PR (       Reg_Fa_CiclFact         IN         FA_CICLFACT%ROWTYPE,
										SN_Cod_retorno      	OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                        SV_Mens_retorno     	OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                        SN_Num_evento       	OUT NOCOPY ge_errores_pg.evento
							            )
IS
/*
<Documentacion TipoDoc = "Procedure">
   <Elemento
      Nombre = "FA_INS_FA_CICLFACT_PR"
      Fecha modificacion=" "
      Fecha creacion="20-03-2007"
      Programador="Javier Garcia"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Realiza un insert a la tabla FA_CICLFACT</Descripcion>
      <Parametros>
         <Entrada>
			 <param nom="Reg_Fa_CiclFact" Tipo="Registro">Registro de la tabla FA_CICLFACT</param>
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


	INSERT INTO FA_CICLFACT
	(
	COD_CICLO        ,
	ANO        ,
	COD_CICLFACT     ,
	FEC_VENCIMIE     ,
	FEC_EMISION      ,
	FEC_CADUCIDA     ,
    FEC_PROXVENC     ,
    FEC_DESDELLAM    ,
    FEC_HASTALLAM    ,
    DIA_PERIODO      ,
    FEC_DESDECFIJOS  ,
    FEC_HASTACFIJOS  ,
    FEC_DESDEOCARGOS ,
    FEC_HASTAOCARGOS ,
    FEC_DESDEROA     ,
    FEC_HASTAROA     ,
    IND_FACTURACION  ,
    DIR_LOGS         ,
    DIR_SPOOL        ,
    DES_LEYEN1       ,
    DES_LEYEN2       ,
    DES_LEYEN3       ,
    DES_LEYEN4       ,
    DES_LEYEN5       ,
    IND_TASADOR
	)
	VALUES
	(
	Reg_Fa_CiclFact.COD_CICLO        ,
	Reg_Fa_CiclFact.ANO        ,
	Reg_Fa_CiclFact.COD_CICLFACT     ,
	Reg_Fa_CiclFact.FEC_VENCIMIE     ,
	Reg_Fa_CiclFact.FEC_EMISION      ,
	Reg_Fa_CiclFact.FEC_CADUCIDA     ,
    Reg_Fa_CiclFact.FEC_PROXVENC     ,
    Reg_Fa_CiclFact.FEC_DESDELLAM    ,
    Reg_Fa_CiclFact.FEC_HASTALLAM    ,
    Reg_Fa_CiclFact.DIA_PERIODO      ,
    Reg_Fa_CiclFact.FEC_DESDECFIJOS  ,
    Reg_Fa_CiclFact.FEC_HASTACFIJOS  ,
    Reg_Fa_CiclFact.FEC_DESDEOCARGOS ,
    Reg_Fa_CiclFact.FEC_HASTAOCARGOS ,
    Reg_Fa_CiclFact.FEC_DESDEROA     ,
    Reg_Fa_CiclFact.FEC_HASTAROA     ,
    Reg_Fa_CiclFact.IND_FACTURACION  ,
    Reg_Fa_CiclFact.DIR_LOGS         ,
    Reg_Fa_CiclFact.DIR_SPOOL        ,
    Reg_Fa_CiclFact.DES_LEYEN1       ,
    Reg_Fa_CiclFact.DES_LEYEN2       ,
    Reg_Fa_CiclFact.DES_LEYEN3       ,
    Reg_Fa_CiclFact.DES_LEYEN4       ,
    Reg_Fa_CiclFact.DES_LEYEN5       ,
    Reg_Fa_CiclFact.IND_TASADOR);


EXCEPTION

  WHEN OTHERS THEN
      SN_Cod_retorno:=4;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
	  SV_mens_retorno:=SV_mens_retorno || ' Tabla FA_CICLFACT ';
	  LV_des_error   := 'FA_INS_FA_CICLFACT_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, CV_version, USER, ' FA_CICLFACT_SP_PG.FA_INS_FA_CICLFACT_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END FA_INS_FA_CICLFACT_PR;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE FA_SEL_FA_CICLFACT_PR (       EN_Cod_Ciclo            IN         FA_CICLFACT.COD_CICLO%TYPE,
										EN_Ano         			IN 		   FA_CICLFACT.ANO%TYPE,
										EN_Cod_CiclFact    		IN 		   FA_CICLFACT.COD_CICLFACT%TYPE,
   			 							Reg_Fa_CiclFact         OUT NOCOPY FA_CICLFACT%ROWTYPE,
   			 					  		SN_Cod_retorno      	OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                  		SV_Mens_retorno     	OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                  		SN_Num_evento       	OUT NOCOPY ge_errores_pg.evento)
IS
/*
<Documentacion TipoDoc = "Procedure">
   <Elemento
      Nombre = "FA_SEL_FA_CICLFACT_PR"
      Fecha modificacion=" "
      Fecha creacion="20-03-2007"
      Programador="Javier Garcia"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Lee un registro de la tabla FA_CICLFACT</Descripcion>
      <Parametros>
         <Entrada>
		 	 <param nom="EN_Cod_Ciclo" Tipo="NUMERICO">Registro de la tabla FA_CICLFACT</param>
			 <param nom="EN_Ano" Tipo="NUMERICO">Año</param>
			 <param nom="EN_Cod_CiclFact" Tipo="NUMERICO">Código del período del ciclo</param>
         </Entrada>
         <Salida>
		    <param nom="Reg_Fa_CiclFact" Tipo="Registro">Registro de la tabla FA_CICLFACT</param>
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


	SELECT   COD_CICLO
			,ANO
			,COD_CICLFACT
			,FEC_VENCIMIE
			,FEC_EMISION
			,FEC_CADUCIDA
			,FEC_PROXVENC
			,FEC_DESDELLAM
			,FEC_HASTALLAM
			,DIA_PERIODO
			,FEC_DESDECFIJOS
			,FEC_HASTACFIJOS
			,FEC_DESDEOCARGOS
			,FEC_HASTAOCARGOS
			,FEC_DESDEROA
			,FEC_HASTAROA
			,IND_FACTURACION
			,DIR_LOGS
			,DIR_SPOOL
			,DES_LEYEN1
			,DES_LEYEN2
			,DES_LEYEN3
			,DES_LEYEN4
			,DES_LEYEN5
			,IND_TASADOR
	INTO Reg_Fa_CiclFact
  	FROM FA_CICLFACT A
	WHERE  A.Cod_ciclo         = EN_Cod_ciclo
		   AND A.Ano 	       = EN_Ano
		   AND A.Cod_ciclfact  = EN_Cod_ciclfact;


EXCEPTION

  WHEN NO_DATA_FOUND THEN

      SN_cod_retorno := 200; -- Ciclo de facturación no encontrado.
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
	  LV_des_error   := 'FA_SEL_FA_CICLFACT_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, CV_version, USER, 'FA_CICLFACT_SP_PG.FA_SEL_FA_CICLFACT_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

  WHEN OTHERS THEN
  	  SN_Cod_retorno:=1;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
	  SV_mens_retorno:=SV_mens_retorno || ' Tabla FA_CICLFACT ';
	  LV_des_error   := 'FA_SEL_FA_CICLFACT_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, CV_version, USER, ' FA_CICLFACT_SP_PG.FA_SEL_FA_CICLFACT_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END FA_SEL_FA_CICLFACT_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE FA_UPD_FA_CICLFACT_PR (       EN_Cod_Ciclo            IN         FA_CICLFACT.COD_CICLO%TYPE,
										EN_Ano         			IN 		   FA_CICLFACT.ANO%TYPE,
										EN_Cod_CiclFact 		IN 		   FA_CICLFACT.COD_CICLFACT%TYPE,
   			 							Reg_Fa_CiclFact         IN 		   FA_CICLFACT%ROWTYPE,
   			 					  		SN_Cod_retorno      	OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                  		SV_Mens_retorno     	OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                  		SN_Num_evento       	OUT NOCOPY ge_errores_pg.evento)
IS
/*
<Documentacion TipoDoc = "Procedure">
   <Elemento
      Nombre = "FA_UPD_FA_CICLFACT_PR"
      Fecha modificacion=" "
      Fecha creacion="20-03-2007"
      Programador="Javier Garcia"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Actualiza la tabla FA_CICLFACT</Descripcion>
      <Parametros>
         <Entrada>
		 	 <param nom="EN_Cod_Ciclo" Tipo="NUMERICO">Registro de la tabla FA_CICLFACT</param>
			 <param nom="EN_Ano" Tipo="NUMERICO">Año</param>
			 <param nom="EN_Cod_CiclFact" Tipo="NUMERICO">Código del período del ciclo</param>
			 <param nom="Reg_Fa_CiclFact" Tipo="Registro">Registro de la tabla FA_CICLFACT</param>
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

	UPDATE FA_CICLFACT A
	SET
	COD_CICLO		   = Reg_Fa_CiclFact.COD_CICLO        ,
	ANO				   = Reg_Fa_CiclFact.ANO        ,
	COD_CICLFACT	   = Reg_Fa_CiclFact.COD_CICLFACT     ,
	FEC_VENCIMIE	   = Reg_Fa_CiclFact.FEC_VENCIMIE     ,
	FEC_EMISION		   = Reg_Fa_CiclFact.FEC_EMISION      ,
	FEC_CADUCIDA	   = Reg_Fa_CiclFact.FEC_CADUCIDA     ,
    FEC_PROXVENC	   = Reg_Fa_CiclFact.FEC_PROXVENC     ,
    FEC_DESDELLAM	   = Reg_Fa_CiclFact.FEC_DESDELLAM    ,
    FEC_HASTALLAM	   = Reg_Fa_CiclFact.FEC_HASTALLAM    ,
    DIA_PERIODO		   = Reg_Fa_CiclFact.DIA_PERIODO      ,
    FEC_DESDECFIJOS	   = Reg_Fa_CiclFact.FEC_DESDECFIJOS  ,
    FEC_HASTACFIJOS	   = Reg_Fa_CiclFact.FEC_HASTACFIJOS  ,
    FEC_DESDEOCARGOS   = Reg_Fa_CiclFact.FEC_DESDEOCARGOS ,
    FEC_HASTAOCARGOS   = Reg_Fa_CiclFact.FEC_HASTAOCARGOS ,
    FEC_DESDEROA	   = Reg_Fa_CiclFact.FEC_DESDEROA     ,
    FEC_HASTAROA	   = Reg_Fa_CiclFact.FEC_HASTAROA     ,
    IND_FACTURACION	   = Reg_Fa_CiclFact.IND_FACTURACION  ,
    DIR_LOGS		   = Reg_Fa_CiclFact.DIR_LOGS         ,
    DIR_SPOOL		   = Reg_Fa_CiclFact.DIR_SPOOL        ,
    DES_LEYEN1		   = Reg_Fa_CiclFact.DES_LEYEN1       ,
    DES_LEYEN2		   = Reg_Fa_CiclFact.DES_LEYEN2       ,
    DES_LEYEN3		   = Reg_Fa_CiclFact.DES_LEYEN3       ,
    DES_LEYEN4		   = Reg_Fa_CiclFact.DES_LEYEN4       ,
    DES_LEYEN5		   = Reg_Fa_CiclFact.DES_LEYEN5       ,
    IND_TASADOR		   = Reg_Fa_CiclFact.IND_TASADOR
	WHERE  A.Cod_ciclo         = EN_Cod_ciclo
		   AND A.Ano 	       = EN_Ano
		   AND A.Cod_ciclfact  = EN_Cod_ciclfact;
	IF SQL%ROWCOUNT = 0 THEN
	   RAISE NO_DATA_FOUND;
	END IF;

EXCEPTION

   WHEN NO_DATA_FOUND THEN

      SN_cod_retorno := 2; -- No se pudo actualizar datos.
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
	  LV_des_error   := 'FA_UPD_FA_CICLFACT_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, CV_version, USER, 'FA_CICLFACT_SP_PG.FA_UPD_FA_CICLFACT_PR', LV_sSQL, SN_cod_retorno, LV_des_error );


  WHEN OTHERS THEN
  	  SN_Cod_retorno := 2;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
	  SV_mens_retorno:=SV_mens_retorno || ' Tabla FA_CICLFACT ';
	  LV_des_error   := 'FA_UPD_FA_CICLFACT_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, CV_version, USER, ' FA_CICLFACT_SP_PG.FA_UPD_FA_CICLFACT_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END FA_UPD_FA_CICLFACT_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE FA_DEL_FA_CICLFACT_PR (       EN_Cod_Ciclo            IN         FA_CICLFACT.COD_CICLO%TYPE,
										EN_Ano         			IN 		   FA_CICLFACT.ANO%TYPE,
										EN_Cod_CiclFact    		IN 		   FA_CICLFACT.COD_CICLFACT%TYPE,
   			 							SN_Cod_retorno      	OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                  		SV_Mens_retorno     	OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                  		SN_Num_evento       	OUT NOCOPY ge_errores_pg.evento)
IS
/*
<Documentacion TipoDoc = "Procedure">
   <Elemento
      Nombre = "FA_DEL_FA_CICLFACT_PR"
      Fecha modificacion=" "
      Fecha creacion="20-03-2007"
      Programador="Javier Garcia"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Elimina físicamente un registro de la tabla FA_CICLFACT</Descripcion>
      <Parametros>
         <Entrada>
		     <param nom="EN_Cod_Ciclo" Tipo="NUMERICO">Registro de la tabla FA_CICLFACT</param>
			 <param nom="EN_Ano" Tipo="NUMERICO">Año</param>
			 <param nom="EN_Cod_CiclFact" Tipo="NUMERICO">Código del período del ciclo</param>
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

  	DELETE FROM FA_CICLFACT A
	WHERE  A.Cod_ciclo         = EN_Cod_ciclo
		   AND A.Ano 	       = EN_Ano
		   AND A.Cod_ciclfact  = EN_Cod_ciclfact;
	IF SQL%ROWCOUNT = 0 THEN
	   RAISE NO_DATA_FOUND;
	END IF;


EXCEPTION
  WHEN NO_DATA_FOUND THEN

      SN_cod_retorno := 200; -- Ciclo de facturación no encontrado.
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
	  LV_des_error   := 'FA_DEL_FA_CICLFACT_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, CV_version, USER, 'FA_CICLFACT_SP_PG.FA_DEL_FA_CICLFACT_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

  WHEN OTHERS THEN
  	  SN_Cod_retorno := 3;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
	  SV_mens_retorno:=SV_mens_retorno || ' Tabla FA_CICLFACT ';
	  LV_des_error   := 'FA_DEL_FA_CICLFACT_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, CV_version, USER, ' FA_CICLFACT_SP_PG.FA_DEL_FA_CICLFACT_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END FA_DEL_FA_CICLFACT_PR;


END FA_CICLFACT_SP_PG;
/
SHOW ERRORS
