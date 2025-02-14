CREATE OR REPLACE PACKAGE BODY SV_LISTA_CONTRATADA_PG
AS

FUNCTION SV_DELETE_TO_FN( EN_PRODUCTO     IN         NUMBER,
						  SN_cod_retorno  OUT NOCOPY ge_errores_pg.coderror,
						  SV_mens_retorno OUT NOCOPY ge_errores_pg.msgerror,
						  SN_num_evento   OUT NOCOPY ge_errores_pg.evento)
RETURN BOOLEAN IS
/*
<Documentación
  TipoDoc = "Procedure">>
   <Elemento
      Nombre = "SV_DELETE_TO_FN"
      Lenguaje="PL/SQL"
      Fecha="20-07-2007"
      Versión="La del package"
      Diseñador="Andrés Osorio"
      Programador="Andrés Osorio"
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>>
      <Descripción></Descripción>>
      <Parámetros>
         <Entrada>
            <param nom="EN_PRODUCTO" Tipo="NUMERICO">Código de Producto</param>>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
LV_des_error	   ge_errores_pg.DesEvent;
LV_sSql			   ge_errores_pg.vQuery;
v_contador		   number(9);
BEGIN
	SN_cod_retorno 	:= 0;
	SV_mens_retorno := ' ';
	SN_num_evento 	:= 0;

	LV_sSql := 'DELETE FROM SV_LISTA_CONTRATADA_TO A   ';
	LV_sSql := LV_sSql || '  WHERE  A.COD_PROD_CONTRATADO = '||EN_PRODUCTO;


	DELETE FROM SV_LISTA_CONTRATADA_TO A
	WHERE  A.COD_PROD_CONTRATADO = EN_PRODUCTO;

	RETURN TRUE;

EXCEPTION
	WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'Error al borrar numeros de la lista contratada - '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'SV_LISTA_CONTRATADA_PG.SV_DELETE_TO_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
		  RETURN FALSE;
END SV_DELETE_TO_FN;

FUNCTION SV_DELETE_VALOR_TO_FN( EN_PRODUCTO     IN         NUMBER,
		 						EN_VALOR		IN 		   NUMBER,
						  		SN_cod_retorno  OUT NOCOPY ge_errores_pg.coderror,
						  		SV_mens_retorno OUT NOCOPY ge_errores_pg.msgerror,
						  		SN_num_evento   OUT NOCOPY ge_errores_pg.evento)
RETURN BOOLEAN IS
/*
<Documentación
  TipoDoc = "Procedure">>
   <Elemento
      Nombre = "SV_DELETE_VALOR_TO_FN"
      Lenguaje="PL/SQL"
      Fecha="20-07-2007"
      Versión="La del package"
      Diseñador="Andrés Osorio"
      Programador="Andrés Osorio"
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>>
      <Descripción></Descripción>>
      <Parámetros>
         <Entrada>
            <param nom="EN_PRODUCTO" Tipo="NUMERICO">Código de Producto</param>>
            <param nom="EN_VALOR" Tipo="NUMERICO">Número de la lista</param>>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
LV_des_error	   ge_errores_pg.DesEvent;
LV_sSql			   ge_errores_pg.vQuery;
v_contador		   number(9);
BEGIN
	SN_cod_retorno 	:= 0;
	SV_mens_retorno := ' ';
	SN_num_evento 	:= 0;

	LV_sSql := 'DELETE FROM SV_LISTA_CONTRATADA_TO A   ';
	LV_sSql := LV_sSql || ' WHERE A.COD_PROD_CONTRATADO = '||EN_PRODUCTO;
	LV_sSql := LV_sSql || ' AND A.VALOR_ELEMENTO = '||EN_VALOR;

	DELETE FROM SV_LISTA_CONTRATADA_TO A
	WHERE  A.COD_PROD_CONTRATADO = EN_PRODUCTO
	AND	   A.VALOR_ELEMENTO = EN_VALOR;

	RETURN TRUE;

EXCEPTION
	WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'Error al borrar numero de la lista contratada - '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'SV_LISTA_CONTRATADA_PG.SV_DELETE_VALOR_TO_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
		  RETURN FALSE;
END SV_DELETE_VALOR_TO_FN;


FUNCTION SV_UPDATE_TO_FN( EN_PRODUCTO     IN         NUMBER,
						  SN_cod_retorno  OUT NOCOPY ge_errores_pg.coderror,
						  SV_mens_retorno OUT NOCOPY ge_errores_pg.msgerror,
						  SN_num_evento   OUT NOCOPY ge_errores_pg.evento)
RETURN BOOLEAN IS
/*
<Documentación
  TipoDoc = "Procedure">>
   <Elemento
      Nombre = "SV_UPDATE_VALOR_FN"
      Lenguaje="PL/SQL"
      Fecha="20-07-2007"
      Versión="La del package"
      Diseñador="Andrés Osorio"
      Programador="Andrés Osorio"
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>>
      <Descripción></Descripción>>
      <Parámetros>
         <Entrada>
            <param nom="EN_PRODUCTO" Tipo="NUMERICO">Producto Contratado</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
LV_des_error	   ge_errores_pg.DesEvent;
LV_sSql			   ge_errores_pg.vQuery;
v_contador		   number(9);
BEGIN
	SN_cod_retorno 	:= 0;
	SV_mens_retorno := ' ';
	SN_num_evento 	:= 0;

	LV_sSql := 'UPDATE SV_LISTA_CONTRATADA_TO';
	LV_sSql := LV_sSql || ' SET    FEC_TERMINO_VIGENCIA = SYSDATE ';
	LV_sSql := LV_sSql || 'WHERE  COD_PROD_CONTRATADO = '||EN_PRODUCTO;

	-- SE DA DE BAJA LA LISTA CONTRATADA
	UPDATE SV_LISTA_CONTRATADA_TO
	SET    FEC_TERMINO_VIGENCIA = SYSDATE
	WHERE  COD_PROD_CONTRATADO = EN_PRODUCTO;

	RETURN TRUE;

EXCEPTION
	WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'Error al actualizar estado de los numeros de la lista - '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'SV_LISTA_CONTRATADA_PG.SV_UPDATE_TO_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
		  RETURN FALSE;
END SV_UPDATE_TO_FN;

FUNCTION SV_UPDATE_TH_FN( EN_PRODUCTO     IN         NUMBER,
						  EV_PROCESO	  IN		 VARCHAR2,
						  EV_ORIGEN		  IN		 VARCHAR2,
						  SN_cod_retorno  OUT NOCOPY ge_errores_pg.coderror,
						  SV_mens_retorno OUT NOCOPY ge_errores_pg.msgerror,
						  SN_num_evento   OUT NOCOPY ge_errores_pg.evento)
RETURN BOOLEAN IS
/*
<Documentación
  TipoDoc = "Procedure">>
   <Elemento
      Nombre = "SV_UPDATE_VALOR_FN"
      Lenguaje="PL/SQL"
      Fecha="20-07-2007"
      Versión="La del package"
      Diseñador="Andrés Osorio"
      Programador="Andrés Osorio"
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>>
      <Descripción></Descripción>>
      <Parámetros>
         <Entrada>
            <param nom="EN_PRODUCTO" Tipo="NUMERICO">Producto Contratado</param>
            <param nom="EV_PROCESO" Tipo="CARACTER">Proceso de descontratacion</param>
            <param nom="EV_ORIGEN" Tipo="CARACTER">Origen de Descontratacion</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
LV_des_error	   ge_errores_pg.DesEvent;
LV_sSql			   ge_errores_pg.vQuery;
v_contador		   number(9);
BEGIN
	SN_cod_retorno 	:= 0;
	SV_mens_retorno := ' ';
	SN_num_evento 	:= 0;

	LV_sSql := 'UPDATE SV_LISTA_CONTRATADA_TH';
	LV_sSql := LV_sSql || ' SET    FEC_TERMINO_VIGENCIA = SYSDATE ';
	LV_sSql := LV_sSql || 'WHERE  COD_PROD_CONTRATADO = '||EN_PRODUCTO;

	-- SE DA DE BAJA LA LISTA CONTRATADA
	UPDATE SV_LISTA_CONTRATADA_TH
	SET    FEC_TERMINO_VIGENCIA = SYSDATE,
		   NUM_PROC_DESCONTRATA = EV_PROCESO,
		   ORIGEN_PROC_DESCONTRATA = EV_ORIGEN
	WHERE  COD_PROD_CONTRATADO = EN_PRODUCTO;

	RETURN TRUE;

EXCEPTION
	WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'Error al actualizar estado de los numeros de la lista - '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'SV_LISTA_CONTRATADA_PG.SV_UPDATE_TH_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
		  RETURN FALSE;
END SV_UPDATE_TH_FN;


FUNCTION SV_UPDATE_VALOR_FN( EN_PRODUCTO     IN         NUMBER,
		 					 EN_VALOR		 IN			NUMBER,
							 ED_FECHA		 IN			DATE,
							 SN_FILAS 		 OUT NOCOPY NUMBER,
						     SN_cod_retorno  OUT NOCOPY ge_errores_pg.coderror,
						     SV_mens_retorno OUT NOCOPY ge_errores_pg.msgerror,
						     SN_num_evento   OUT NOCOPY ge_errores_pg.evento)
RETURN BOOLEAN IS
/*
<Documentación
  TipoDoc = "Procedure">>
   <Elemento
      Nombre = "SV_UPDATE_VALOR_FN"
      Lenguaje="PL/SQL"
      Fecha="20-07-2007"
      Versión="La del package"
      Diseñador="Andrés Osorio"
      Programador="Andrés Osorio"
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>>
      <Descripción></Descripción>>
      <Parámetros>
         <Entrada>
            <param nom="EN_PRODUCTO" Tipo="NUMERICO">Producto Contratado</param>
            <param nom="EN_VALOR" Tipo="NUMERICO">Número de la lista a descontratar</param>
            <param nom="ED_FECHA" Tipo="FECHA">Fecha de termino de Vigencia</param>
         </Entrada>
         <Salida>
            <param nom="SN_FILAS" Tipo="NUMERICO">Indicador de número histórico</param>>
            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
LV_des_error	   ge_errores_pg.DesEvent;
LV_sSql			   ge_errores_pg.vQuery;
v_contador		   number(9);
BEGIN
	SN_cod_retorno 	:= 0;
	SV_mens_retorno := ' ';
	SN_num_evento 	:= 0;

	LV_sSql := 'UPDATE SV_LISTA_CONTRATADA_TO';
	LV_sSql := LV_sSql || ' SET    FEC_TERMINO_VIGENCIA = SYSDATE ';
	LV_sSql := LV_sSql || 'WHERE  COD_PROD_CONTRATADO = '||EN_PRODUCTO;
	LV_sSql := LV_sSql || 'AND	   VALOR_ELEMENTO = '||EN_VALOR;

	-- SE DA DE BAJA LA LISTA CONTRATADA
	UPDATE SV_LISTA_CONTRATADA_TO
	SET    FEC_TERMINO_VIGENCIA = NVL(ED_FECHA,SYSDATE)
	WHERE  COD_PROD_CONTRATADO = EN_PRODUCTO
	AND	   VALOR_ELEMENTO = EN_VALOR;

	SN_FILAS := SQL%ROWCOUNT;

	RETURN TRUE;

EXCEPTION
	WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'Error al actualizar estado del numero de la lista - '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'SV_LISTA_CONTRATADA_PG.SV_UPDATE_VALOR_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
		  RETURN FALSE;
END SV_UPDATE_VALOR_FN;

FUNCTION SV_UPDATE_VALOR_TH_FN( EN_PRODUCTO     IN         NUMBER,
		 					    EN_VALOR		IN		   NUMBER,
							 	ED_FECHA		IN		   DATE,
								EV_PROCESO		IN		   VARCHAR2,
								EV_ORIGEN		IN		   VARCHAR2,
						     	SN_cod_retorno  OUT NOCOPY ge_errores_pg.coderror,
						     	SV_mens_retorno OUT NOCOPY ge_errores_pg.msgerror,
						     	SN_num_evento   OUT NOCOPY ge_errores_pg.evento)
RETURN BOOLEAN IS
/*
<Documentación
  TipoDoc = "Procedure">>
   <Elemento
      Nombre = "SV_UPDATE_VALOR_FN"
      Lenguaje="PL/SQL"
      Fecha="20-07-2007"
      Versión="La del package"
      Diseñador="Andrés Osorio"
      Programador="Andrés Osorio"
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>>
      <Descripción></Descripción>>
      <Parámetros>
         <Entrada>
            <param nom="EN_PRODUCTO" Tipo="NUMERICO">Producto Contratado</param>
            <param nom="EN_VALOR" Tipo="NUMERICO">Número de la lista a descontratar</param>
            <param nom="ED_FECHA" Tipo="FECHA">Fecha de termino de Vigencia</param>
            <param nom="EV_PROCESO" Tipo="CARACTER">Proceso de Descontratación</param>
            <param nom="EV_ORIGEN" Tipo="CARACTER">Origen de Descontratación</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
LV_des_error	   ge_errores_pg.DesEvent;
LV_sSql			   ge_errores_pg.vQuery;
v_contador		   number(9);
BEGIN
	SN_cod_retorno 	:= 0;
	SV_mens_retorno := ' ';
	SN_num_evento 	:= 0;

	LV_sSql := 'UPDATE SV_LISTA_CONTRATADA_TO';
	LV_sSql := LV_sSql || ' SET FEC_TERMINO_VIGENCIA = '||NVL(ED_FECHA,SYSDATE);
	LV_sSql := LV_sSql || ' SET NUM_PROC_DESCONTRATA = '||EV_PROCESO;
	LV_sSql := LV_sSql || ' SET ORIGEN_PROC_DESCONTRATA = '||EV_ORIGEN;
	LV_sSql := LV_sSql || ' SET FEC_DESCONTRATA = '||SYSDATE;
	LV_sSql := LV_sSql || ' WHERE COD_PROD_CONTRATADO = '||EN_PRODUCTO;
	LV_sSql := LV_sSql || ' AND VALOR_ELEMENTO = '||EN_VALOR;

	-- SE DA DE BAJA LA LISTA CONTRATADA
	UPDATE SV_LISTA_CONTRATADA_TH
	SET    FEC_TERMINO_VIGENCIA    = NVL(ED_FECHA,SYSDATE),
		   NUM_PROC_DESCONTRATA    = EV_PROCESO,
		   ORIGEN_PROC_DESCONTRATA = EV_ORIGEN,
		   FEC_DESCONTRATA		   = SYSDATE
	WHERE  COD_PROD_CONTRATADO = EN_PRODUCTO
	AND	   VALOR_ELEMENTO = EN_VALOR;

	RETURN TRUE;

EXCEPTION
	WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'Error al actualizar estado del numero de la lista - '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'SV_LISTA_CONTRATADA_PG.SV_UPDATE_VALOR_TH_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
		  RETURN FALSE;
END SV_UPDATE_VALOR_TH_FN;

FUNCTION SV_INSERTA_TH_FN( EN_PRODUCTO     IN         NUMBER,
		 				   EN_VALOR		   IN		  NUMBER,
						   ED_FECHA		   IN		  DATE,
						   EV_PROCESO	   IN		  VARCHAR2,
						   EV_ORIGEN	   IN		  VARCHAR2,
						   SN_cod_retorno  OUT NOCOPY ge_errores_pg.coderror,
						   SV_mens_retorno OUT NOCOPY ge_errores_pg.msgerror,
						   SN_num_evento   OUT NOCOPY ge_errores_pg.evento)
RETURN BOOLEAN IS
/*
<Documentación
  TipoDoc = "Procedure">>
   <Elemento
      Nombre = "SV_UPDATE_VALOR_FN"
      Lenguaje="PL/SQL"
      Fecha="20-07-2007"
      Versión="La del package"
      Diseñador="Andrés Osorio"
      Programador="Andrés Osorio"
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>>
      <Descripción></Descripción>>
      <Parámetros>
         <Entrada>
            <param nom="EN_PRODUCTO" Tipo="NUMERICO">Producto Contratado</param>
            <param nom="EN_VALOR" Tipo="NUMERICO">Número de la lista a descontratar</param>
            <param nom="ED_FECHA" Tipo="FECHA">Fecha de termino de Vigencia</param>
            <param nom="EV_PROCESO" Tipo="CARACTER">Proceso de Descontratación</param>
            <param nom="EV_ORIGEN" Tipo="CARACTER">Origen de Descontratación</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
LV_des_error	   ge_errores_pg.DesEvent;
LV_sSql			   ge_errores_pg.vQuery;
v_contador		   number(9);
BEGIN
	SN_cod_retorno 	:= 0;
	SV_mens_retorno := ' ';
	SN_num_evento 	:= 0;

	LV_sSql := 'INSERT INTO SV_LISTA_CONTRATADA_TH a ';
	LV_sSql := LV_sSql || ' ( a.COD_PROD_CONTRATADO, a.VALOR_ELEMENTO, a.FEC_INICIO_VIGENCIA, ';
	LV_sSql := LV_sSql || ' a.FEC_TERMINO_VIGENCIA, a.COD_CATEGORIA_DESTINO, a.NUM_PROCESO, ';
	LV_sSql := LV_sSql || ' a.ORIGEN_PROCESO, a.FEC_PROCESO, a.NUM_PROC_DESCONTRATA, ';
	LV_sSql := LV_sSql || ' a.ORIGEN_PROC_DESCONTRATA, a.FEC_DESCONTRATA ) ';
	LV_sSql := LV_sSql || ' SELECT ';
	LV_sSql := LV_sSql || ' COD_PROD_CONTRATADO, VALOR_ELEMENTO, FEC_INICIO_VIGENCIA, ';
	LV_sSql := LV_sSql ||   NVL(ED_FECHA,SYSDATE)||', COD_CATEGORIA_DESTINO, NUM_PROCESO, ';
	LV_sSql := LV_sSql || ' ORIGEN_PROCESO, FEC_PROCESO, '||EV_PROCESO||', ';
	LV_sSql := LV_sSql ||   EV_ORIGEN||', '||SYSDATE;
	LV_sSql := LV_sSql || ' FROM SV_LISTA_CONTRATADA_TO b';
	LV_sSql := LV_sSql || ' WHERE b.COD_PROD_CONTRATADO = '||EN_PRODUCTO;
	LV_sSql := LV_sSql || ' AND b.VALOR_ELEMENTO = '||EN_VALOR;

	INSERT INTO SV_LISTA_CONTRATADA_TH a
	(
      a.COD_PROD_CONTRATADO, a.VALOR_ELEMENTO, a.FEC_INICIO_VIGENCIA,
   	  a.FEC_TERMINO_VIGENCIA, a.COD_CATEGORIA_DESTINO, a.NUM_PROCESO,
   	  a.ORIGEN_PROCESO, a.FEC_PROCESO, a.NUM_PROC_DESCONTRATA,
   	  a.ORIGEN_PROC_DESCONTRATA, a.FEC_DESCONTRATA
	)
	SELECT
	  b.COD_PROD_CONTRATADO, b.VALOR_ELEMENTO, b.FEC_INICIO_VIGENCIA,
   	  NVL(ED_FECHA,SYSDATE), COD_CATEGORIA_DESTINO, b.NUM_PROCESO,
   	  b.ORIGEN_PROCESO, b.FEC_PROCESO, EV_PROCESO,
	  EV_ORIGEN, SYSDATE
	FROM SV_LISTA_CONTRATADA_TO b
	WHERE b.COD_PROD_CONTRATADO = EN_PRODUCTO
	AND	  b.VALOR_ELEMENTO = EN_VALOR;

	RETURN TRUE;

EXCEPTION
	WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'Error al insertar en historico el numero de la lista - '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'SV_LISTA_CONTRATADA_PG.SV_INSERTA_TH_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
		  RETURN FALSE;
END SV_INSERTA_TH_FN;


PROCEDURE SV_PRODUCTO_D_PR(EO_lista_productos IN  SV_PROD_CONTR_LST_QT,
						  SN_cod_retorno      OUT NOCOPY    ge_errores_pg.coderror,
						  SV_mens_retorno     OUT NOCOPY    ge_errores_pg.msgerror,
						  SN_num_evento       OUT NOCOPY	ge_errores_pg.evento)
	IS
/*
<Documentación
  TipoDoc = "Procedure">>
   <Elemento
      Nombre = "PF_PRODUCTO_S_PR"
      Lenguaje="PL/SQL"
      Fecha="20-07-2007"
      Versión="La del package"
      Diseñador="Andrés Osorio"
      Programador="ALEJANDRO DIAZ"
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>>
      <Descripción></Descripción>>
      <Parámetros>
         <Entrada>
            <param nom="EO_prod_padre" Tipo="estructura">Código de Producto Padre</param>>
         </Entrada>
         <Salida>
            <param nom="SO_Lista_Productos" Tipo="Cursor">Lista de Productos</param>>
            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

LV_des_error	   ge_errores_pg.DesEvent;
LV_sSql			   ge_errores_pg.vQuery;
v_contador		   number(9);
ERROR_PARAMETROS EXCEPTION;
ERROR_FUNCION	 EXCEPTION;
LN_PRODUCTO		 NUMBER;
LO_cProducto	 refcursor;

BEGIN
	SN_cod_retorno 	:= 0;
	SV_mens_retorno := ' ';
	SN_num_evento 	:= 0;

	IF EO_lista_productos IS NULL THEN
		RAISE ERROR_PARAMETROS;
	ELSE
		OPEN LO_cProducto FOR
		SELECT COD_PROD_CONTRATADO
		FROM TABLE(CAST(EO_lista_productos as SV_PROD_CONTR_LST_QT));

		LOOP

			FETCH LO_cProducto INTO LN_PRODUCTO;

			EXIT WHEN LO_cProducto%NOTFOUND;

			LV_sSql := 'SV_DELETE_TO_FN('||LN_PRODUCTO||')';
			IF (NOT SV_DELETE_TO_FN(LN_PRODUCTO,SN_cod_retorno,SV_mens_retorno,SN_num_evento)) THEN
			   RAISE ERROR_FUNCION;
			END IF;

		END LOOP;

	END IF;

EXCEPTION
   WHEN ERROR_PARAMETROS THEN
	      SN_cod_retorno := 98;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'SV_LISTA_CONTRATADA_PG.SV_PRODUCTO_D_PR(Lista Productos); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'SV_LISTA_CONTRATADA_PG.SV_PRODUCTO_D_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN ERROR_FUNCION THEN
	      SN_cod_retorno := 98;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'SV_LISTA_CONTRATADA_PG.SV_PRODUCTO_D_PR(Lista Productos); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'SV_LISTA_CONTRATADA_PG.SV_PRODUCTO_D_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

	WHEN NO_DATA_FOUND THEN
	      SN_cod_retorno := 1407;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'SV_LISTA_CONTRATADA_PG.SV_PRODUCTO_D_PR(Lista Perfil); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'SV_LISTA_CONTRATADA_PG.SV_PRODUCTO_D_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
	WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'SV_LISTA_CONTRATADA_PG.SV_PRODUCTO_D_PR(Lista Perfil); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'SV_LISTA_CONTRATADA_PG.SV_PRODUCTO_D_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

	END SV_PRODUCTO_D_PR;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE SV_PRODUCTO_S_FS_PR(EN_COD_PROD_CONTRATADO   IN NUMBER,
						      SO_PERFIL_LISTA_CUR  	OUT NOCOPY	refCursor,
						      SV_mens_retorno     	OUT NOCOPY  ge_errores_pg.msgerror)
	IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "SV_PRODUCTO_S_FS_PR"
	      Lenguaje="PL/SQL"
	      Fecha="03-11-2008"
	      Versión="La del package"
	      Diseñador="Andrés Osorio"
	      Programador="Jorge Marín"
	      Ambiente Desarrollo="BD">
	      <Retorno>N/A</Retorno>>
	      <Descripción>Procedimiento fachada para ser invocado desde VB</Descripción>>
	      <Parámetros>
	         <Entrada>
	            <param nom="COD_PROD_CONTRATADO" Tipo="NUMBER">Cliente contratante</param>>
	         </Entrada>
	         <Salida>
	            <param nom="SO_PERFIL_LISTA_CUR" Tipo="Cursor">Lista de Productos</param>>
	            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
	         </Salida>
	      </Parámetros>
	   </Elemento>
	</Documentación>
	*/

EO_producto	   	   SV_PROD_CONTRA_QT;
LV_des_error	   ge_errores_pg.DesEvent;
LV_sSql			   ge_errores_pg.vQuery;
SN_cod_retorno     ge_errores_pg.coderror;
SN_num_evento      ge_errores_pg.evento;
v_contador		   number(9);
ERROR_PARAMETROS EXCEPTION;

BEGIN
	SN_cod_retorno 	:= 0;
	SV_mens_retorno := ' ';
	SN_num_evento 	:= 0;

    EO_producto := SV_PROD_CONTRA_QT	('','','','','','');

	EO_producto.COD_PROD_CONTRATADO := EN_COD_PROD_CONTRATADO;
	SV_PRODUCTO_S_PR(EO_producto,SO_PERFIL_LISTA_CUR,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
EXCEPTION
	WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  SV_mens_retorno := SQLERRM;
		  LV_des_error   := 'SV_LISTA_CONTRATADA_PG(Lista Productos); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'SV_LISTA_CONTRATADA_PG.SV_PRODUCTO_S_FS_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
END SV_PRODUCTO_S_FS_PR;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE SV_PRODUCTO_S_PR(EO_producto IN  SV_PROD_CONTRA_QT,
						  SO_PERFIL_LISTA_CUR  	OUT NOCOPY	refCursor,
						  SN_cod_retorno      OUT NOCOPY    ge_errores_pg.coderror,
						  SV_mens_retorno     OUT NOCOPY    ge_errores_pg.msgerror,
						  SN_num_evento       OUT NOCOPY	ge_errores_pg.evento)
	IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "PF_PRODUCTO_S_PR"
	      Lenguaje="PL/SQL"
	      Fecha="20-07-2007"
	      Versión="La del package"
	      Diseñador="Andrés Osorio"
	      Programador="Hilda Quezada"
	      Ambiente Desarrollo="BD">
	      <Retorno>N/A</Retorno>>
	      <Descripción></Descripción>>
	      <Parámetros>
	         <Entrada>
	            <param nom="EO_prod_padre" Tipo="estructura">Código de Producto Padre</param>>
	         </Entrada>
	         <Salida>
	            <param nom="SO_Lista_Productos" Tipo="Cursor">Lista de Productos</param>>
	            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
	            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
	            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
	         </Salida>
	      </Parámetros>
	   </Elemento>
	</Documentación>
	*/

	LV_des_error	   ge_errores_pg.DesEvent;
	LV_sSql			   ge_errores_pg.vQuery;
	v_contador		   number(9);
    ERROR_PARAMETROS EXCEPTION;
BEGIN
	 SN_cod_retorno 	:= 0;
     SV_mens_retorno := ' ';
     SN_num_evento 	:= 0;

	IF EO_producto IS NULL THEN
			   RAISE ERROR_PARAMETROS;
	ELSE
		LV_sSql := 'SELECT A.COD_PROD_CONTRATADO, A.VALOR_ELEMENTO, A.FEC_INICIO_VIGENCIA, A.FEC_TERMINO_VIGENCIA,';
		LV_sSql := LV_sSql || ' NVL(A.COD_CATEGORIA_DESTINO,) AS COD_CATEGORIA_DESTINO,';
		LV_sSql := LV_sSql || ' A.NUM_PROCESO, A.ORIGEN_PROCESO, A.FEC_PROCESO';
		LV_sSql := LV_sSql || ' FROM   SV_LISTA_CONTRATADA_TO A';
		LV_sSql := LV_sSql || ' WHERE  A.COD_PROD_CONTRATADO = '||EO_producto.COD_PROD_CONTRATADO;
		LV_sSql := LV_sSql || ' UNION';
		LV_sSql := LV_sSql || ' SELECT B.COD_PROD_CONTRATADO, B.VALOR_ELEMENTO, B.FEC_INICIO_VIGENCIA, B.FEC_TERMINO_VIGENCIA,';
		LV_sSql := LV_sSql || ' NVL(B.COD_CATEGORIA_DESTINO,) AS COD_CATEGORIA_DESTINO,';
		LV_sSql := LV_sSql || ' B.NUM_PROCESO, B.ORIGEN_PROCESO, B.FEC_PROCESO';
		LV_sSql := LV_sSql || ' FROM   SV_LISTA_CONTRATADA_TH B';
		LV_sSql := LV_sSql || ' WHERE  B.COD_PROD_CONTRATADO = '||EO_producto.COD_PROD_CONTRATADO;
		LV_sSql := LV_sSql || ' AND    SYSDATE BETWEEN B.FEC_INICIO_VIGENCIA AND B.FEC_TERMINO_VIGENCIA';

		OPEN   SO_PERFIL_LISTA_CUR FOR
		SELECT A.COD_PROD_CONTRATADO, A.VALOR_ELEMENTO, TO_CHAR(A.FEC_INICIO_VIGENCIA,'DD/MM/YYYY HH24:MI:SS') AS FEC_INICIO_VIGENCIA, --A.FEC_INICIO_VIGENCIA, 
               TO_CHAR(A.FEC_TERMINO_VIGENCIA,'DD/MM/YYYY HH24:MI:SS') AS FEC_TERMINO_VIGENCIA,--A.FEC_TERMINO_VIGENCIA,
			   NVL(A.COD_CATEGORIA_DESTINO,' ') AS COD_CATEGORIA_DESTINO,
			   A.NUM_PROCESO, A.ORIGEN_PROCESO, A.FEC_PROCESO
		FROM   SV_LISTA_CONTRATADA_TO A
		WHERE  A.COD_PROD_CONTRATADO = EO_producto.COD_PROD_CONTRATADO
		UNION
		SELECT B.COD_PROD_CONTRATADO, B.VALOR_ELEMENTO, TO_CHAR(B.FEC_INICIO_VIGENCIA,'DD/MM/YYYY HH24:MI:SS') AS FEC_INICIO_VIGENCIA,--B.FEC_INICIO_VIGENCIA, 
               TO_CHAR(B.FEC_TERMINO_VIGENCIA,'DD/MM/YYYY HH24:MI:SS') AS FEC_TERMINO_VIGENCIA, --B.FEC_TERMINO_VIGENCIA,
			   NVL(B.COD_CATEGORIA_DESTINO,' ') AS COD_CATEGORIA_DESTINO,
			   B.NUM_PROCESO, B.ORIGEN_PROCESO, B.FEC_PROCESO
		FROM   SV_LISTA_CONTRATADA_TH B
		WHERE  B.COD_PROD_CONTRATADO = EO_producto.COD_PROD_CONTRATADO
		AND    SYSDATE BETWEEN B.FEC_INICIO_VIGENCIA AND B.FEC_TERMINO_VIGENCIA;
	END IF;

EXCEPTION
   WHEN ERROR_PARAMETROS THEN
	      SN_cod_retorno := 98;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'SV_LISTA_CONTRATADA_PG.SV_PRODUCTO_S_PR(Lista Productos); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'SV_LISTA_CONTRATADA_PG.SV_PRODUCTO_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

	WHEN NO_DATA_FOUND THEN
	      SN_cod_retorno := 1407;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'SV_LISTA_CONTRATADA_PG.SV_PRODUCTO_S_PR(Lista Perfil); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'SV_LISTA_CONTRATADA_PG.SV_PRODUCTO_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
	WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'SV_LISTA_CONTRATADA_PG.SV_PRODUCTO_S_PR(Lista Perfil); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'SV_LISTA_CONTRATADA_PG.SV_PRODUCTO_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END	SV_PRODUCTO_S_PR;

PROCEDURE SV_CONTRATA_I_PR(EO_LIST_CONTRAT    IN  SV_LISTA_CONTRA_TO_LST_QT,
						                    	 SN_cod_retorno      OUT NOCOPY    ge_errores_pg.coderror,
						                         SV_mens_retorno     OUT NOCOPY    ge_errores_pg.msgerror,
						                        SN_num_evento       OUT NOCOPY	ge_errores_pg.evento)
	IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "PF_PRODUCTO_S_PR"
	      Lenguaje="PL/SQL"
	      Fecha="20-07-2007"
	      Versión="La del package"
	      Diseñador="Andrés Osorio"
	      Programador="Hilda Quezada"
	      Ambiente Desarrollo="BD">
	      <Retorno>N/A</Retorno>>
	      <Descripción></Descripción>>
	      <Parámetros>
	         <Entrada>
	            <param nom="EO_prod_padre" Tipo="estructura">Código de Producto Padre</param>>
	         </Entrada>
	         <Salida>
	            <param nom="SO_Lista_Productos" Tipo="Cursor">Lista de Productos</param>>
	            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
	            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
	            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
	         </Salida>
	      </Parámetros>
	   </Elemento>
	</Documentación>
	*/

	LV_des_error	   ge_errores_pg.DesEvent;
	LV_sSql			   ge_errores_pg.vQuery;
	v_contador		   number(9);
    ERROR_PARAMETROS EXCEPTION;
BEGIN
	 SN_cod_retorno 	:= 0;
     SV_mens_retorno := ' ';
     SN_num_evento 	:= 0;

	IF EO_LIST_CONTRAT IS NULL THEN
			   RAISE ERROR_PARAMETROS;
	ELSE
	            LV_sSql := 'INSERT 	INTO SV_LISTA_CONTRATADA_TO ( COD_PROD_CONTRATADO, VALOR_ELEMENTO, FEC_INICIO_VIGENCIA, FEC_TERMINO_VIGENCIA, COD_CATEGORIA_DESTINO,NUM_PROCESO, ORIGEN_PROCESO, FEC_PROCESO)';
				LV_sSql := LV_sSql || '  ( SELECT B.COD_PROD_CONTRATADO, B.VALOR_ELEMENTO, B.FEC_INICIO_VIGENCIA, B.FEC_TERMINO_VIGENCIA, B.COD_CATEGORIA_DESTINO, B.NUM_PROCESO, B.ORIGEN_PROCESO,	 B.FEC_PROCESO ';
 				LV_sSql := LV_sSql || 'FROM TABLE(CAST(EO_LIST_CONTRAT as SV_LISTA_CONTRA_TO_LST_QT)) B)';

		INSERT
		INTO SV_LISTA_CONTRATADA_TO (
			 						COD_PROD_CONTRATADO,
									VALOR_ELEMENTO,
									FEC_INICIO_VIGENCIA,
									FEC_TERMINO_VIGENCIA,
									COD_CATEGORIA_DESTINO,
									NUM_PROCESO,
									ORIGEN_PROCESO,
									FEC_PROCESO
									)
		( SELECT B.COD_PROD_CONTRATADO,
		  		 B.VALOR_ELEMENTO,
				 B.FEC_INICIO_VIGENCIA,
				 B.FEC_TERMINO_VIGENCIA,
				 B.COD_CATEGORIA_DESTINO,
				 B.NUM_PROCESO,
				 B.ORIGEN_PROCESO,
				 B.FEC_PROCESO
		  FROM TABLE(CAST(EO_LIST_CONTRAT as SV_LISTA_CONTRA_TO_LST_QT)) B);
	END IF;

EXCEPTION
   WHEN ERROR_PARAMETROS THEN
	      SN_cod_retorno := 98;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'SV_LISTA_CONTRATADA_PG.SV_CONTRATA_I_PR(Lista Productos); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'SV_LISTA_CONTRATADA_PG.SV_CONTRATA_I_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

	WHEN NO_DATA_FOUND THEN
	      SN_cod_retorno := 1407;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'SV_LISTA_CONTRATADA_PG.SV_CONTRATA_I_PR(Lista Perfil); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'SV_LISTA_CONTRATADA_PG.SV_CONTRATA_I_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
	WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'SV_LISTA_CONTRATADA_PG.SV_CONTRATA_I_PR(Lista Perfil); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'SV_LISTA_CONTRATADA_PG.SV_CONTRATA_I_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END	SV_CONTRATA_I_PR;
	--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


PROCEDURE SV_CONTRATA_U_PR(EO_Lista_Cont  IN            SV_LISTA_CONTRA_TO_QT,
						  SN_cod_retorno  OUT NOCOPY    ge_errores_pg.coderror,
						  SV_mens_retorno OUT NOCOPY    ge_errores_pg.msgerror,
						  SN_num_evento   OUT NOCOPY	ge_errores_pg.evento)
						  IS
/*
<Documentación
  TipoDoc = "Procedure">>
   <Elemento
      Nombre = "PF_PRODUCTO_S_PR"
      Lenguaje="PL/SQL"
      Fecha="20-07-2007"
      Versión="La del package"
      Diseñador="Andrés Osorio"
      Programador="Alejandro Díaz"
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>>
      <Descripción></Descripción>>
      <Parámetros>
         <Entrada>
            <param nom="EO_prod_padre" Tipo="estructura">Código de Producto Padre</param>>
         </Entrada>
         <Salida>
            <param nom="SO_Lista_Productos" Tipo="Cursor">Lista de Productos</param>>
            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

LV_des_error	   ge_errores_pg.DesEvent;
LV_sSql			   ge_errores_pg.vQuery;
v_contador		   number(9);
ERROR_PARAMETROS EXCEPTION;
ERROR_FUNCION EXCEPTION;
EO_LISTA_TMP SV_LISTA_CONTRA_TO_QT:= EO_Lista_Cont;
LN_indHistorico NUMBER;

BEGIN
		SN_cod_retorno 	:= 0;
       	SV_mens_retorno := ' ';
       	SN_num_evento 	:= 0;

		IF EO_LISTA_TMP IS NULL THEN
		   RAISE ERROR_PARAMETROS;
		ELSE
			-- Se actualiza la fecha de vigencia del numero de la lista en la tabla operativa
			LV_sSql := 'SV_UPDATE_VALOR_FN('||EO_LISTA_TMP.COD_PROD_CONTRATADO||', '||EO_LISTA_TMP.VALOR_ELEMENTO||')';
			IF (NOT SV_UPDATE_VALOR_FN(EO_LISTA_TMP.COD_PROD_CONTRATADO, EO_LISTA_TMP.VALOR_ELEMENTO,
			                       EO_LISTA_TMP.FEC_TERMINO_VIGENCIA, LN_indHistorico,
			                       SN_cod_retorno, SV_mens_retorno, SN_num_evento))
			THEN
				RAISE ERROR_FUNCION;
			END IF;

			IF (LN_indHistorico > 0) THEN --Si el registro se encontraba en la tabla operativa
			    --Se pasa a historico el número de la lista
			    LV_sSql := 'SV_INSERTA_TH_FN(' ||EO_LISTA_TMP.COD_PROD_CONTRATADO||', '||EO_LISTA_TMP.VALOR_ELEMENTO
						   					   ||EO_LISTA_TMP.FEC_TERMINO_VIGENCIA||', '||EO_LISTA_TMP.NUM_PROC_DESCONTRATA
											   ||', '||EO_LISTA_TMP.ORIGEN_PROC_DESCONTRATA||')';
			    IF (NOT SV_INSERTA_TH_FN( EO_LISTA_TMP.COD_PROD_CONTRATADO, EO_LISTA_TMP.VALOR_ELEMENTO, EO_LISTA_TMP.FEC_TERMINO_VIGENCIA,
				   						  EO_LISTA_TMP.NUM_PROC_DESCONTRATA, EO_LISTA_TMP.ORIGEN_PROC_DESCONTRATA,
				                       	  SN_cod_retorno, SV_mens_retorno, SN_num_evento))
				THEN
					RAISE ERROR_FUNCION;
				END IF;
				-- SE BORRA DE LA TABLA DE LISTA CONTRATADA
				LV_sSql := 'SV_DELETE_VALOR_TO_FN(' ||EO_LISTA_TMP.COD_PROD_CONTRATADO||', '||EO_LISTA_TMP.VALOR_ELEMENTO||')';
			    IF (NOT SV_DELETE_VALOR_TO_FN( EO_LISTA_TMP.COD_PROD_CONTRATADO, EO_LISTA_TMP.VALOR_ELEMENTO,
				                       	  SN_cod_retorno, SV_mens_retorno, SN_num_evento))
				THEN
					RAISE ERROR_FUNCION;
				END IF;
			ELSE--Si el registro se encuentra en la tabla historica
			-- Se actualiza la fecha de vigencia del numero de la lista en la tabla historica
				LV_sSql := 'SV_UPDATE_VALOR_TH_FN('||EO_LISTA_TMP.COD_PROD_CONTRATADO||', '||EO_LISTA_TMP.VALOR_ELEMENTO
						   						   ||EO_LISTA_TMP.FEC_TERMINO_VIGENCIA||', '||EO_LISTA_TMP.NUM_PROC_DESCONTRATA
												   ||', '||EO_LISTA_TMP.ORIGEN_PROC_DESCONTRATA||')';
				IF (NOT SV_UPDATE_VALOR_TH_FN(EO_LISTA_TMP.COD_PROD_CONTRATADO, EO_LISTA_TMP.VALOR_ELEMENTO, EO_LISTA_TMP.FEC_TERMINO_VIGENCIA,
				   						  EO_LISTA_TMP.NUM_PROC_DESCONTRATA, EO_LISTA_TMP.ORIGEN_PROC_DESCONTRATA,
				                       	  SN_cod_retorno, SV_mens_retorno, SN_num_evento))
				THEN
					RAISE ERROR_FUNCION;
				END IF;
			END IF;

		END IF;

EXCEPTION
    WHEN ERROR_PARAMETROS THEN
	      SN_cod_retorno := 98;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'SV_LISTA_CONTRATADA_PG.SV_CONTRATA_U_PR(Lista Productos); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'SV_LISTA_CONTRATADA_PG.SV_CONTRATA_U_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
    WHEN ERROR_FUNCION THEN
	      SN_cod_retorno := 1407;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'SV_LISTA_CONTRATADA_PG.SV_CONTRATA_U_PR(Lista Productos); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'SV_LISTA_CONTRATADA_PG.SV_CONTRATA_U_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
	WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'SV_LISTA_CONTRATADA_PG.SV_CONTRATA_U_PR(Lista Perfil); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'SV_LISTA_CONTRATADA_PG.SV_CONTRATA_U_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
END SV_CONTRATA_U_PR;

------------------------------------------------------------------------------------------------------------------------------
PROCEDURE SV_PRODUCTO_U_PR(EO_Lista_Cont  IN SV_PROD_CONTR_LST_QT,
						  SN_cod_retorno      OUT NOCOPY    ge_errores_pg.coderror,
						  SV_mens_retorno     OUT NOCOPY    ge_errores_pg.msgerror,
						  SN_num_evento       OUT NOCOPY	ge_errores_pg.evento)
						  IS
/*
<Documentación
  TipoDoc = "Procedure">>
   <Elemento
      Nombre = "PF_PRODUCTO_S_PR"
      Lenguaje="PL/SQL"
      Fecha="20-07-2007"
      Versión="La del package"
      Diseñador="Andrés Osorio"
      Programador="Alejandro Díaz"
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>>
      <Descripción></Descripción>>
      <Parámetros>
         <Entrada>
            <param nom="EO_prod_padre" Tipo="estructura">Código de Producto Padre</param>>
         </Entrada>
         <Salida>
            <param nom="SO_Lista_Productos" Tipo="Cursor">Lista de Productos</param>>
            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

LV_des_error	   ge_errores_pg.DesEvent;
LV_sSql			   ge_errores_pg.vQuery;
v_contador		   number(9);
LN_PRODUCTO		   NUMBER;
LN_VALOR		   NUMBER;
LV_PROCESO		   VARCHAR2(10);
LV_ORIGEN 		   VARCHAR2(5);
ERROR_PARAMETROS EXCEPTION;
ERROR_FUNCION EXCEPTION;
LO_cProducto refcursor;
LN_indHistorico NUMBER;
LN_flag			NUMBER;


BEGIN
	SN_cod_retorno 	:= 0;
	SV_mens_retorno := ' ';
	SN_num_evento 	:= 0;

	IF EO_Lista_Cont IS NULL THEN
		RAISE ERROR_PARAMETROS;
	ELSE
		--SE RECUPERA EL NUMERO Y ORIGEN DEL PROCESO DE DESCONTRATACION
		OPEN LO_cProducto FOR
		SELECT c.COD_PROD_CONTRATADO, a.VALOR_ELEMENTO, c.NUM_PROC_DESCONTRATA,
			   c.ORIGEN_PROC_DESCONTRATA, 1 as indHistorico
		FROM   TABLE(CAST(EO_Lista_Cont as SV_PROD_CONTR_LST_QT)) c, SV_LISTA_CONTRATADA_TO a
		WHERE c.COD_PROD_CONTRATADO = a.COD_PROD_CONTRATADO
		UNION
		SELECT c.COD_PROD_CONTRATADO, b.VALOR_ELEMENTO, c.NUM_PROC_DESCONTRATA,
			   c.ORIGEN_PROC_DESCONTRATA, 0 as indHistorico
		FROM   TABLE(CAST(EO_Lista_Cont as SV_PROD_CONTR_LST_QT)) c, SV_LISTA_CONTRATADA_TH b
		WHERE c.COD_PROD_CONTRATADO = b.COD_PROD_CONTRATADO
		AND	  SYSDATE BETWEEN b.FEC_INICIO_VIGENCIA AND b.FEC_TERMINO_VIGENCIA;

		LOOP

			FETCH LO_cProducto INTO LN_PRODUCTO, LN_VALOR, LV_PROCESO, LV_ORIGEN, LN_indHistorico;

			EXIT WHEN LO_cProducto%NOTFOUND;

			IF (LN_indHistorico > 0) THEN --El registro se encuentra en tabla operativa
				-- Se actualiza la fecha de vigencia del numero de la lista en la tabla operativa
				LV_sSql := 'SV_UPDATE_VALOR_FN('||LN_PRODUCTO||', '||LN_VALOR||')';
				IF (NOT SV_UPDATE_VALOR_FN(LN_PRODUCTO, LN_VALOR,
				                       SYSDATE, LN_flag,
				                       SN_cod_retorno, SV_mens_retorno, SN_num_evento))
				THEN
					RAISE ERROR_FUNCION;
				END IF;

			    LV_sSql := 'SV_INSERTA_TH_FN(' ||LN_PRODUCTO||', '||LN_VALOR||', '||SYSDATE||', '
						   					  ||LV_PROCESO||', '||LV_ORIGEN||')';
			    IF (NOT SV_INSERTA_TH_FN( LN_PRODUCTO, LN_VALOR, SYSDATE, LV_PROCESO, LV_ORIGEN,
				                       	  SN_cod_retorno, SV_mens_retorno, SN_num_evento))
				THEN
					RAISE ERROR_FUNCION;
				END IF;

				-- SE BORRA DE LA TABLA DE LISTA CONTRATADA
				LV_sSql := 'SV_DELETE_VALOR_TO_FN(' ||LN_PRODUCTO||', '||LN_VALOR||')';
			    IF (NOT SV_DELETE_VALOR_TO_FN( LN_PRODUCTO, LN_VALOR,
				                       	  SN_cod_retorno, SV_mens_retorno, SN_num_evento))
				THEN
					RAISE ERROR_FUNCION;
				END IF;


			ELSE--El registro se encuentra en tabla historica
				--Se actualñiza el estado de los numeros de la lista en la tabla historica
			    LV_sSql := 'SV_UPDATE_VALOR_TH_FN('||LN_PRODUCTO||', '||LN_VALOR||', '||LV_PROCESO||', '||LV_ORIGEN||')';
				IF (NOT SV_UPDATE_VALOR_TH_FN(LN_PRODUCTO, LN_VALOR, SYSDATE, LV_PROCESO, LV_ORIGEN, SN_cod_retorno, SV_mens_retorno, SN_num_evento))
				THEN
					RAISE ERROR_FUNCION;
				END IF;
			END IF;

		END LOOP;

	END IF;

EXCEPTION
    WHEN ERROR_PARAMETROS THEN
	      SN_cod_retorno := 98;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'SV_LISTA_CONTRATADA_PG.SV_PRODUCTO_U_PR(Lista Productos); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'SV_LISTA_CONTRATADA_PG.SV_PRODUCTO_U_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
    WHEN ERROR_FUNCION THEN
	      SN_cod_retorno := 1407;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'SV_LISTA_CONTRATADA_PG.SV_PRODUCTO_U_PR(Lista Productos); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'SV_LISTA_CONTRATADA_PG.SV_PRODUCTO_U_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
	WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'SV_LISTA_CONTRATADA_PG.SV_PRODUCTO_U_PR(Lista Perfil); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'SV_LISTA_CONTRATADA_PG.SV_PRODUCTO_U_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
END SV_PRODUCTO_U_PR;
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE SV_PRODUCTO_CANT_PR(EO_producto              IN   SV_PROD_CONTRA_QT,
										  	   			 CANT_PROD_CONT   OUT NUMBER,
														 SN_cod_retorno      OUT NOCOPY    ge_errores_pg.coderror,
						                                 SV_mens_retorno     OUT NOCOPY    ge_errores_pg.msgerror,
						                                 SN_num_evento       OUT NOCOPY	ge_errores_pg.evento)
	IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "SV_PRODUCTO_CANT_PR"
	      Lenguaje="PL/SQL"
	      Fecha="20-07-2007"
	      Versión="La del package"
	      Diseñador="Andrés Osorio"
	      Programador="Alejandro Díaz"
	      Ambiente Desarrollo="BD">
	      <Retorno>N/A</Retorno>>
	      <Descripción></Descripción>>
	      <Parámetros>
	         <Entrada>
	            <param nom="EO_prod_padre" Tipo="estructura">Código de Producto Padre</param>>
	         </Entrada>
	         <Salida>
	            <param nom="SO_Lista_Productos" Tipo="Cursor">Lista de Productos</param>>
	            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
	            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
	            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
	         </Salida>
	      </Parámetros>
	   </Elemento>
	</Documentación>
	*/

	LV_des_error	   ge_errores_pg.DesEvent;
	LV_sSql			   ge_errores_pg.vQuery;
	lv_contador		   number(9);
	lV_CONTADOR_TO  number(9);
	lV_CONTADOR_TH   number(9);

	LV_COD_CICLO		   GE_CLIENTES.COD_CICLO%TYPE;
    ERROR_PARAMETROS EXCEPTION;
	NO_EXISTE_CICLO  EXCEPTION;


    LV_FEC_DESDLLAM DATE;
    LV_FEC_HASTALLAM DATE;
BEGIN
	 SN_cod_retorno   := 0;
     SV_mens_retorno := ' ';
     SN_num_evento 	:= 0;

	IF EO_producto IS NULL THEN
			   RAISE ERROR_PARAMETROS;
	ELSE
		--IF  EO_PRODUCTO.NUM_ABONADO IS NULL THEN 07-07-2011 171447
		IF  (EO_PRODUCTO.NUM_ABONADO IS NULL OR EO_PRODUCTO.NUM_ABONADO = 0) THEN -- 07-07-2011 171447
			LV_sSql := ' SELECT FEC_DESDELLAM,  FEC_HASTALLAM ';
			LV_sSql := LV_sSql || '  FROM GE_CLIENTES A ,  FA_CICLFACT B ';
			LV_sSql := LV_sSql || ' WHEREA.COD_CICLO= B.COD_CICLO';
			LV_sSql := LV_sSql || ' WHERE A.COD_CLIENTE =' ||EO_PRODUCTO.COD_CLIENTE;

			SELECT B.FEC_DESDELLAM,  B.FEC_HASTALLAM
			INTO   LV_FEC_DESDLLAM,  LV_FEC_HASTALLAM
			FROM   GE_CLIENTES A ,  FA_CICLFACT B
			WHERE  A.COD_CICLO= B.COD_CICLO
			AND    SYSDATE BETWEEN FEC_DESDELLAM AND FEC_HASTALLAM
			AND	   A.COD_CLIENTE = EO_PRODUCTO.COD_CLIENTE;
		ELSE
			LV_sSql := ' SELECT B.FEC_DESDELLAM,  B.FEC_HASTALLAM ';
			LV_sSql := LV_sSql || '  FROM GA_ABOAMIST A ,  FA_CICLFACT B ';
			LV_sSql := LV_sSql || ' WHERE A.COD_CICLO= B.COD_CICLO';
			LV_sSql := LV_sSql || '  AND SYSDATE BETWEEN FEC_DESDELLAM  AND FEC_HASTALLAM';
			LV_sSql := LV_sSql || ' AND A.NUM_ABONADO =' ||EO_PRODUCTO.NUM_ABONADO;
			LV_sSql := LV_sSql || ' AND A.COD_CLIENTE =' ||EO_PRODUCTO.COD_CLIENTE;

			SELECT B.FEC_DESDELLAM,  B.FEC_HASTALLAM
			INTO   LV_FEC_DESDLLAM,  LV_FEC_HASTALLAM
			FROM   GA_ABOAMIST A ,  FA_CICLFACT B
			WHERE  A.COD_CICLO= B.COD_CICLO
			AND	   SYSDATE BETWEEN FEC_DESDELLAM AND FEC_HASTALLAM
			AND	   A.NUM_ABONADO =EO_PRODUCTO.NUM_ABONADO
			AND	   A.COD_CLIENTE = EO_PRODUCTO.COD_CLIENTE
			UNION ALL
			SELECT B.FEC_DESDELLAM,  B.FEC_HASTALLAM
			FROM   GA_ABOCEL A ,  FA_CICLFACT B
			WHERE  A.COD_CICLO= B.COD_CICLO
			AND	   SYSDATE BETWEEN FEC_DESDELLAM AND FEC_HASTALLAM
			AND	   A.NUM_ABONADO =EO_PRODUCTO.NUM_ABONADO
			AND	   A.COD_CLIENTE = EO_PRODUCTO.COD_CLIENTE;
		END IF;

		IF LV_FEC_DESDLLAM= NULL  and LV_FEC_HASTALLAM = NULL THEN
			RAISE NO_EXISTE_CICLO;
		END IF;

		LV_sSql := ' SELECT COUNT(1)';
		LV_sSql := LV_sSql || ' SV_LISTA_CONTRATADA_TO A ';
		LV_sSql := LV_sSql || ' WHERE A.COD_PROD_CONTRATADO = EO_PRODUCTO.COD_PROD_CONTRATADO';
		LV_sSql := LV_sSql || ' AND FEC_INICIO_VIGENCIA >= LV_FEC_DESDLLAM';
		LV_sSql := LV_sSql || ' AND  FEC_TERMINO_VIGENCIA <= LV_FEC_HASTALLAM';

		SELECT COUNT(1)
		INTO   LV_CONTADOR_TO
		FROM   SV_LISTA_CONTRATADA_TO A
		WHERE  A.COD_PROD_CONTRATADO = EO_PRODUCTO.COD_PROD_CONTRATADO
		AND    FEC_INICIO_VIGENCIA BETWEEN LV_FEC_DESDLLAM AND LV_FEC_HASTALLAM;

		LV_sSql := ' SELECT COUNT(1)';
		LV_sSql := LV_sSql || ' SV_LISTA_CONTRATADA_TH A ';
		LV_sSql := LV_sSql || ' WHERE A.COD_PROD_CONTRATADO = EO_PRODUCTO.COD_PROD_CONTRATADO';
		LV_sSql := LV_sSql || ' AND FEC_INICIO_VIGENCIA >= LV_FEC_DESDLLAM';
		LV_sSql := LV_sSql || ' AND  FEC_TERMINO_VIGENCIA <= LV_FEC_HASTALLAM';

		SELECT COUNT(1)
		INTO   LV_CONTADOR_TH
		FROM   SV_LISTA_CONTRATADA_TH A
		WHERE  A.COD_PROD_CONTRATADO = EO_PRODUCTO.COD_PROD_CONTRATADO
		AND    FEC_TERMINO_VIGENCIA BETWEEN LV_FEC_DESDLLAM AND LV_FEC_HASTALLAM;

		lv_contador:= LV_CONTADOR_TO + LV_CONTADOR_TH;

		CANT_PROD_CONT:= lv_contador;
	END IF;

EXCEPTION
   WHEN ERROR_PARAMETROS THEN
	      SN_cod_retorno := 98;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'SV_PRODUCTO_CANT_PR(Lista Productos); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PS_DET_ESPEC_PROD_PG.SV_PRODUCTO_CANT_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
 WHEN NO_EXISTE_CICLO THEN
	      SN_cod_retorno := 254;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'SV_PRODUCTO_CANT_PR(Lista Productos); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PS_DET_ESPEC_PROD_PG.SV_PRODUCTO_CANT_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

	WHEN NO_DATA_FOUND THEN
	      SN_cod_retorno := 1407;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'SV_PRODUCTO_CANT_PR(Lista Perfil); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'SE_PERFIL_LISTA_PG.SV_PRODUCTO_CANT_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
	WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'SV_PRODUCTO_CANT_PR(Lista Perfil); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'SE_PERFIL_LISTA_PG.SV_PRODUCTO_CANT_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END	SV_PRODUCTO_CANT_PR;
END SV_LISTA_CONTRATADA_PG;
/
SHOW ERRORS