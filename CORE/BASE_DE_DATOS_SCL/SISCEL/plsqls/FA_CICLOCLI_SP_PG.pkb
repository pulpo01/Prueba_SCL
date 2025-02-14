CREATE OR REPLACE PACKAGE BODY FA_CICLOCLI_SP_PG AS

SN_cod_retornoau   ge_errores_td.cod_msgerror%TYPE;
SV_mens_retornoau  ge_errores_td.det_msgerror%TYPE;
SN_num_eventoau    ge_errores_pg.Evento;
SN_num_transaccion NUMBER(16);--ge_auditoria_to.num_ticket%TYPE;
ERR_MOAUDITORIA    EXCEPTION;
ERR_AGAUDITORIA    EXCEPTION;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE FA_INS_FA_CICLOCLI_PR (       Reg_Fa_CicloCli         IN FA_CICLOCLI%ROWTYPE,
									    SN_Cod_retorno      	OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                        SV_Mens_retorno     	OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                        SN_Num_evento       	OUT NOCOPY ge_errores_pg.evento
							            ) IS
/*
<Documentacion TipoDoc = "Procedure">
   <Elemento
      Nombre = "FA_INS_FA_CICLOCLI_PR"
      Fecha modificacion=" "
      Fecha creacion="20-03-2007"
      Programador="Javier Garcia"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Realiza un insert a la tabla FA_CICLOCLI</Descripcion>
      <Parametros>
         <Entrada>
			 <param nom="Reg_Fa_CicloCli" Tipo="Registro">Registro de la tabla FA_CICLOCLI</param>
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


	INSERT INTO FA_CICLOCLI
	(
	COD_CLIENTE    ,
    COD_CICLO      ,
    COD_PRODUCTO   ,
    NUM_ABONADO    ,
    NUM_PROCESO    ,
    COD_CALCLIEN   ,
    IND_CAMBIO     ,
    NOM_USUARIO    ,
    NOM_APELLIDO1  ,
    NOM_APELLIDO2  ,
    COD_CREDMOR    ,
    IND_DEBITO     ,
    COD_CICLONUE   ,
    FEC_ALTA       ,
    NUM_TERMINAL   ,
    FEC_ULTFACT    ,
    IND_MASCARA    ,
    COD_DESPACHO   ,
    COD_PRIORIDAD  ,
    COD_COURRIER   ,
    COD_ZONACOURRIER
	)
	VALUES
	(
	Reg_Fa_CicloCli.COD_CLIENTE    ,
    Reg_Fa_CicloCli.COD_CICLO      ,
    Reg_Fa_CicloCli.COD_PRODUCTO   ,
    Reg_Fa_CicloCli.NUM_ABONADO    ,
    Reg_Fa_CicloCli.NUM_PROCESO    ,
    Reg_Fa_CicloCli.COD_CALCLIEN   ,
    Reg_Fa_CicloCli.IND_CAMBIO     ,
    Reg_Fa_CicloCli.NOM_USUARIO    ,
    Reg_Fa_CicloCli.NOM_APELLIDO1  ,
    Reg_Fa_CicloCli.NOM_APELLIDO2  ,
    Reg_Fa_CicloCli.COD_CREDMOR    ,
    Reg_Fa_CicloCli.IND_DEBITO     ,
    Reg_Fa_CicloCli.COD_CICLONUE   ,
    Reg_Fa_CicloCli.FEC_ALTA       ,
    Reg_Fa_CicloCli.NUM_TERMINAL   ,
    Reg_Fa_CicloCli.FEC_ULTFACT    ,
    Reg_Fa_CicloCli.IND_MASCARA    ,
    Reg_Fa_CicloCli.COD_DESPACHO   ,
    Reg_Fa_CicloCli.COD_PRIORIDAD  ,
    Reg_Fa_CicloCli.COD_COURRIER   ,
    Reg_Fa_CicloCli.COD_ZONACOURRIER);


EXCEPTION
  WHEN OTHERS THEN
  	  SN_Cod_retorno:=4;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
	  SV_mens_retorno:=SV_mens_retorno || ' Tabla FA_CICLOCLI ';
	  LV_des_error   := 'FA_INS_FA_CICLOCLI_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, CV_version, USER, ' FA_CICLOCLI_SP_PG.FA_INS_FA_CICLOCLI_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END FA_INS_FA_CICLOCLI_PR;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE FA_SEL_FA_CICLOCLI_PR (
   			 							EN_Cod_Cliente          IN         FA_CICLOCLI.COD_CLIENTE%TYPE,
										EN_Cod_Ciclo            IN 		   FA_CICLOCLI.COD_CICLO%TYPE,
										EN_Cod_Producto         IN 		   FA_CICLOCLI.COD_PRODUCTO%TYPE,
										EN_Num_Abonado			IN 		   FA_CICLOCLI.NUM_ABONADO%TYPE,
   			 							Reg_Fa_CicloCli         OUT NOCOPY FA_CICLOCLI%ROWTYPE,
   			 					  		SN_Cod_retorno      	OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                  		SV_Mens_retorno     	OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                  		SN_Num_evento       	OUT NOCOPY ge_errores_pg.evento)
IS
/*
<Documentacion TipoDoc = "Procedure">
   <Elemento
      Nombre = "FA_SEL_FA_CICLOCLI_PR"
      Fecha modificacion=" "
      Fecha creacion="20-03-2007"
      Programador="Javier Garcia"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Lee un registro de la tabla FA_CICLOCLI</Descripcion>
      <Parametros>
         <Entrada>
		     <param nom="EN_Cod_Cliente" Tipo="NUMERICO">Código del cliente</param>
			 <param nom="EN_Cod_Ciclo" Tipo="NUMERICO">Código del Ciclo</param>
			 <param nom="EN_Cod_Producto" Tipo="NUMERICO">Código del producto</param>
			 <param nom="EN_Num_Abonado" Tipo="NUMERICO">Número del Abonado</param>
         </Entrada>
         <Salida>
		    <param nom="Reg_Fa_CicloCli" Tipo="Registro">Registro de la tabla FA_CICLOCLI</param>
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


	SELECT 	 COD_CLIENTE
			,COD_CICLO
			,COD_PRODUCTO
			,NUM_ABONADO
			,NUM_PROCESO
			,COD_CALCLIEN
			,IND_CAMBIO
			,NOM_USUARIO
			,NOM_APELLIDO1
			,NOM_APELLIDO2
			,COD_CREDMOR
			,IND_DEBITO
			,COD_CICLONUE
			,FEC_ALTA
			,NUM_TERMINAL
			,FEC_ULTFACT
			,IND_MASCARA
			,COD_DESPACHO
			,COD_PRIORIDAD
            ,COD_COURRIER   
            ,COD_ZONACOURRIER            
	INTO Reg_Fa_CicloCli
  	FROM FA_CICLOCLI A
	WHERE  A.Cod_Cliente       = EN_Cod_Cliente
		   AND A.Cod_Ciclo     = EN_Cod_Ciclo
		   AND A.Cod_Producto  = EN_Cod_Producto
		   AND A.Num_Abonado   = EN_Num_Abonado;


EXCEPTION
   WHEN NO_DATA_FOUND THEN

      SN_cod_retorno := 1091; -- Cliente no pertenece al ciclo indicado
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
	  LV_des_error   := 'FA_SEL_FA_CICLOCLI_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, CV_version, USER, 'FA_CICLOCLI_SP_PG.FA_SEL_FA_CICLOCLI_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

   WHEN OTHERS THEN
   	  SN_Cod_retorno := 1;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
	  SV_mens_retorno:=SV_mens_retorno || ' Tabla FA_CICLOCLI ';
	  LV_des_error   := 'FA_SEL_FA_CICLOCLI_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, CV_version, USER, ' FA_CICLOCLI_SP_PG.FA_SEL_FA_CICLOCLI_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END FA_SEL_FA_CICLOCLI_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE FA_UPD_FA_CICLOCLI_PR (   	EN_Cod_Cliente          IN         FA_CICLOCLI.COD_CLIENTE%TYPE,
										EN_Cod_Ciclo            IN 		   FA_CICLOCLI.COD_CICLO%TYPE,
										EN_Cod_Producto         IN 		   FA_CICLOCLI.COD_PRODUCTO%TYPE,
										EN_Num_Abonado			IN 		   FA_CICLOCLI.NUM_ABONADO%TYPE,
   			 							Reg_Fa_CicloCli         IN 		   FA_CICLOCLI%ROWTYPE,
   			 					  		SN_Cod_retorno      	OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                  		SV_Mens_retorno     	OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                  		SN_Num_evento       	OUT NOCOPY ge_errores_pg.evento
										)
IS
/*
<Documentacion TipoDoc = "Procedure">
   <Elemento
      Nombre = "FA_UPD_FA_CICLOCLI_PR"
      Fecha modificacion=" "
      Fecha creacion="20-03-2007"
      Programador="Javier Garcia"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Actualización de la tabla FA_CICLOCLI</Descripcion>
      <Parametros>
         <Entrada>
			 <param nom="EN_Cod_Cliente" Tipo="NUMERICO">Código del cliente</param>
			 <param nom="EN_Cod_Ciclo" Tipo="NUMERICO">Código del Ciclo</param>
			 <param nom="EN_Cod_Producto" Tipo="NUMERICO">Código del producto</param>
			 <param nom="EN_Num_Abonado" Tipo="NUMERICO">Número del Abonado</param>
         </Entrada>
         <Salida>
		    <param nom="Reg_Fa_CicloCli" Tipo="Registro">Registro de la tabla FA_CICLOCLI</param>
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

	UPDATE FA_CICLOCLI A
	SET
    NUM_PROCESO				 = Reg_Fa_CicloCli.NUM_PROCESO    ,
    COD_CALCLIEN			 = Reg_Fa_CicloCli.COD_CALCLIEN   ,
    IND_CAMBIO				 = Reg_Fa_CicloCli.IND_CAMBIO     ,
    NOM_USUARIO				 = Reg_Fa_CicloCli.NOM_USUARIO    ,
    NOM_APELLIDO1			 = Reg_Fa_CicloCli.NOM_APELLIDO1  ,
    NOM_APELLIDO2			 = Reg_Fa_CicloCli.NOM_APELLIDO2  ,
    COD_CREDMOR				 = Reg_Fa_CicloCli.COD_CREDMOR    ,
    IND_DEBITO				 = Reg_Fa_CicloCli.IND_DEBITO     ,
    COD_CICLONUE			 = Reg_Fa_CicloCli.COD_CICLONUE   ,
    FEC_ALTA				 = Reg_Fa_CicloCli.FEC_ALTA       ,
    NUM_TERMINAL			 = Reg_Fa_CicloCli.NUM_TERMINAL   ,
    FEC_ULTFACT				 = Reg_Fa_CicloCli.FEC_ULTFACT    ,
    IND_MASCARA				 = Reg_Fa_CicloCli.IND_MASCARA    ,
    COD_DESPACHO			 = Reg_Fa_CicloCli.COD_DESPACHO   ,
    COD_PRIORIDAD			 = Reg_Fa_CicloCli.COD_PRIORIDAD  ,
    COD_COURRIER             = Reg_Fa_CicloCli.COD_COURRIER   ,
    COD_ZONACOURRIER         = Reg_Fa_CicloCli.COD_ZONACOURRIER
	WHERE  A.Cod_Cliente       = EN_Cod_Cliente
		   AND A.Cod_Ciclo     = EN_Cod_Ciclo
		   AND A.Cod_Producto  = EN_Cod_Producto
		   AND A.Num_Abonado   = EN_Num_Abonado;
	IF SQL%ROWCOUNT=0 THEN
	   RAISE NO_DATA_FOUND;
	END IF;

EXCEPTION
   WHEN NO_DATA_FOUND THEN

      SN_cod_retorno := 200; -- No se pudo actualizar datos.
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
	  LV_des_error   := 'FA_UPD_FA_CICLOCLI_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, CV_version, USER, 'FA_CICLFACT_SP_PG.FA_UPD_FA_CICLOCLI_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

   WHEN OTHERS THEN
   	  SN_Cod_retorno := 2;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
	  SV_mens_retorno:=SV_mens_retorno || ' Tabla FA_CICLOCLI ';
	  LV_des_error   := 'FA_UPD_FA_CICLOCLI_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, CV_version, USER, ' FA_CICLOCLI_SP_PG.FA_UPD_FA_CICLOCLI_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END FA_UPD_FA_CICLOCLI_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE FA_DEL_FA_CICLOCLI_PR (       EN_Cod_Cliente          IN         FA_CICLOCLI.COD_CLIENTE%TYPE,
										EN_Cod_Ciclo            IN 		   FA_CICLOCLI.COD_CICLO%TYPE,
										EN_Cod_Producto         IN 		   FA_CICLOCLI.COD_PRODUCTO%TYPE,
										EN_Num_Abonado			IN 		   FA_CICLOCLI.NUM_ABONADO%TYPE,
   			 					  		SN_Cod_retorno      	OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                  		SV_Mens_retorno     	OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                  		SN_Num_evento       	OUT NOCOPY ge_errores_pg.evento)
IS
/*
<Documentacion TipoDoc = "Procedure">
   <Elemento
      Nombre = "FA_DEL_FA_CICLOCLI_PR"
      Fecha modificacion=" "
      Fecha creacion="20-03-2007"
      Programador="Javier Garcia"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Elimina físicamente un registro de la tabla FA_CICLOCLI</Descripcion>
      <Parametros>
         <Entrada>
			 <param nom="EN_Cod_Cliente" Tipo="NUMERICO">Código del cliente</param>
			 <param nom="EN_Cod_Ciclo" Tipo="NUMERICO">Código del Ciclo</param>
			 <param nom="EN_Cod_Producto" Tipo="NUMERICO">Código del producto</param>
			 <param nom="EN_Num_Abonado" Tipo="NUMERICO">Número del Abonado</param>
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

  	DELETE FROM FA_CICLOCLI A
	WHERE  A.Cod_Cliente       = EN_Cod_Cliente
		   AND A.Cod_Ciclo     = EN_Cod_Ciclo
		   AND A.Cod_Producto  = EN_Cod_Producto
		   AND A.Num_Abonado   = EN_Num_Abonado;
    IF SQL%ROWCOUNT=0 THEN
	   RAISE NO_DATA_FOUND;
	END IF;

EXCEPTION
   WHEN NO_DATA_FOUND THEN

      SN_cod_retorno := 200; -- Ciclo de facturación no encontrado.
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
	  LV_des_error   := 'FA_DEL_FA_CICLOCLI_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, CV_version, USER, 'FA_CICLOCLI_SP_PG.FA_DEL_FA_CICLOCLI_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN OTHERS THEN
      SN_Cod_retorno:=3;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
	  SV_mens_retorno:=SV_mens_retorno || ' Tabla FA_CICLOCLI ';
	  LV_des_error   := 'FA_DEL_FA_CICLOCLI_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, CV_version, USER, ' FA_CICLOCLI_SP_PG.FA_DEL_FA_CICLOCLI_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END FA_DEL_FA_CICLOCLI_PR;


END FA_CICLOCLI_SP_PG;
/
SHOW ERROR