CREATE OR REPLACE PACKAGE BODY PS_CATEGORIAS_BASICO_PG

AS
 ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  FUNCTION PS_ABONADO_S_FN(EO_Cat_Carg  IN  		PF_CLIEN_ABO_QT,
						  SO_Lista_Cat_Carg  OUT NOCOPY	refCursor,
						  SN_cod_retorno      OUT NOCOPY    ge_errores_pg.coderror,
						  SV_mens_retorno     OUT NOCOPY    ge_errores_pg.msgerror,
						  SN_num_evento       OUT NOCOPY	ge_errores_pg.evento) RETURN BOOLEAN
	IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "PF_PRODUCTO_S_PR"
	      Lenguaje="PL/SQL"
	      Fecha="26-07-2007"
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

BEGIN
	SN_cod_retorno 	:= 0;
	SV_mens_retorno := ' ';
	SN_num_evento 	:= 0;

	select count(1) into v_contador from ga_abocel where num_abonado = EO_Cat_Carg.num_abonado;

	IF EO_Cat_Carg IS NULL THEN
		RAISE ERROR_PARAMETROS;
	ELSIF   v_contador= 0 then
		LV_sSql := ' SELECT A.COD_CATEGORIA, ';
		LV_sSql := LV_sSql || ' A.MIN_CARGO_REQUERIDO, ';
		LV_sSql := LV_sSql || ' A.DES_CATEGORIA, ';
		LV_sSql := LV_sSql || ' A.ID_CATEGORIA ';
		LV_sSql := LV_sSql || ' FROM GA_ABOAMIST D, PS_CATEGORIAS_CARGO_TD A, ta_plantarif B, TA_CARGOSBASICO C ';
		LV_sSql := LV_sSql || ' WHERE D.NUM_ABONADO = '||EO_Cat_Carg.num_abonado;
		LV_sSql := LV_sSql || ' AND D.COD_CLIENTE = '||EO_Cat_Carg.cod_cliente;
		LV_sSql := LV_sSql || ' AND D.COD_PLANTARIF = B.COD_PLANTARIF ';
		LV_sSql := LV_sSql || ' AND B.COD_CARGOBASICO = C.COD_CARGOBASICO ';
		LV_sSql := LV_sSql || ' AND A.MIN_CARGO_REQUERIDO = 0';

		OPEN SO_Lista_Cat_Carg FOR
		SELECT A.COD_CATEGORIA,
			   A.MIN_CARGO_REQUERIDO,
			   A.DES_CATEGORIA,
			   A.ID_CATEGORIA
		FROM   GA_ABOAMIST D, PS_CATEGORIAS_CARGO_TD A, ta_plantarif B, TA_CARGOSBASICO C
		WHERE  D.NUM_ABONADO = EO_Cat_Carg.num_abonado
		AND	   D.COD_CLIENTE = EO_Cat_Carg.cod_cliente
		AND    D.COD_PLANTARIF = B.COD_PLANTARIF
		AND	   B.COD_CARGOBASICO = C.COD_CARGOBASICO
		AND    A.MIN_CARGO_REQUERIDO = 0;

	ELSE
		LV_sSql := ' SELECT A.COD_CATEGORIA, ';
		LV_sSql := LV_sSql || ' A.MIN_CARGO_REQUERIDO, ';
		LV_sSql := LV_sSql || ' A.DES_CATEGORIA, ';
		LV_sSql := LV_sSql || ' A.ID_CATEGORIA ';
		LV_sSql := LV_sSql || ' FROM GA_ABOCEL D, PS_CATEGORIAS_CARGO_TD A, ta_plantarif B, TA_CARGOSBASICO C ';
		LV_sSql := LV_sSql || ' WHERE D.NUM_ABONADO = '|| EO_Cat_Carg.num_abonado;
		LV_sSql := LV_sSql || ' AND D.COD_CLIENTE = '|| EO_Cat_Carg.cod_cliente;
		LV_sSql := LV_sSql || ' AND D.COD_PLANTARIF = B.COD_PLANTARIF ';
		LV_sSql := LV_sSql || ' AND B.COD_CARGOBASICO = C.COD_CARGOBASICO ';
		LV_sSql := LV_sSql || ' AND A.MIN_CARGO_REQUERIDO <= C.IMP_CARGOBASICO';

		OPEN   SO_Lista_Cat_Carg FOR
		SELECT A.COD_CATEGORIA,
			   A.MIN_CARGO_REQUERIDO,
			   A.DES_CATEGORIA,
			   A.ID_CATEGORIA
		FROM   GA_ABOCEL D, PS_CATEGORIAS_CARGO_TD A, ta_plantarif B, TA_CARGOSBASICO C
		WHERE  D.NUM_ABONADO = EO_Cat_Carg.num_abonado
		AND	   D.COD_CLIENTE = EO_Cat_Carg.cod_cliente
		AND    D.COD_PLANTARIF = B.COD_PLANTARIF
		AND	   B.COD_CARGOBASICO = C.COD_CARGOBASICO
		AND    A.MIN_CARGO_REQUERIDO <=  C.IMP_CARGOBASICO;
	END IF;

	RETURN TRUE;


EXCEPTION
    WHEN ERROR_PARAMETROS THEN
	      SN_cod_retorno := 98;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'PS_ABONADO_S_FN(Lista Abonados); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PS_CATEGORIAS_BASICO_PG.PS_ABONADO_S_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
		  RETURN FALSE;
	WHEN NO_DATA_FOUND THEN
	      SN_cod_retorno := 1401;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'PS_ABONADO_S_FN(Lista Abonados); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PS_CATEGORIAS_BASICO_PG.PS_ABONADO_S_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
		  RETURN FALSE;
	WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'PS_ABONADO_S_FN(Lista Abonados); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PS_CATEGORIAS_BASICO_PG.PS_ABONADO_S_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
		  RETURN FALSE;
END PS_ABONADO_S_FN;
 ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION PS_CLIENTE_I_FN(EO_Cat_Carg  IN  		PF_CLIEN_ABO_QT,
					  SO_Lista_Cat_Carg  OUT NOCOPY	refCursor,
					  SN_cod_retorno      OUT NOCOPY    ge_errores_pg.coderror,
					  SV_mens_retorno     OUT NOCOPY    ge_errores_pg.msgerror,
					  SN_num_evento       OUT NOCOPY	ge_errores_pg.evento) RETURN BOOLEAN
IS
/*
<Documentación
  TipoDoc = "Procedure">>
   <Elemento
      Nombre = "PF_PRODUCTO_S_PR"
      Lenguaje="PL/SQL"
      Fecha="26-07-2007"
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
SUM_IMPCARGBASIC		   number(9);

BEGIN
	SN_cod_retorno 	:= 0;
	SV_mens_retorno := ' ';
	SN_num_evento 	:= 0;

	IF EO_Cat_Carg IS NULL THEN
	   SN_cod_retorno 	:= CN_LISTA_NULA;
	   SV_mens_retorno  := 'Lista Aboando es nula';
	   RETURN FALSE;
	ELSE
		LV_sSql := ' SELECT  SUM(C.IMP_CARGOBASICO) ';
		LV_sSql := LV_sSql || ' FROM 	GA_ABOCEL D, PS_CATEGORIAS_CARGO_TD a, ta_plantarif B, TA_CARGOSBASICO C ';
		LV_sSql := LV_sSql || ' WHERE 	D.COD_PLANTARIF = B.COD_PLANTARIF ';
		LV_sSql := LV_sSql || ' AND 	A.MIN_CARGO_REQUERIDO = C.IMP_CARGOBASICO ';
		LV_sSql := LV_sSql || ' AND 	D.COD_CLIENTE = ' ||EO_Cat_Carg.COD_CLIENTE;

		SELECT  SUM(C.IMP_CARGOBASICO)
		INTO 	SUM_IMPCARGBASIC
		FROM 	GA_ABOCEL D, PS_CATEGORIAS_CARGO_TD a, ta_plantarif B, TA_CARGOSBASICO C
		WHERE 	D.COD_PLANTARIF = B.COD_PLANTARIF
		AND 	A.MIN_CARGO_REQUERIDO = C.IMP_CARGOBASICO
		AND 	D.COD_CLIENTE = EO_Cat_Carg.COD_CLIENTE;

		LV_sSql := ' SELECT A.COD_CATEGORIA, ';
		LV_sSql := LV_sSql || ' A.MIN_CARGO_REQUERIDO, ';
		LV_sSql := LV_sSql || ' A.DES_CATEGORIA, ';
		LV_sSql := LV_sSql || ' A.ID_CATEGORIA ';
		LV_sSql := LV_sSql || ' FROM   PS_CATEGORIAS_CARGO_TD A ';
		LV_sSql := LV_sSql || ' WHERE  A.MIN_CARGO_REQUERIDO <= ' ||SUM_IMPCARGBASIC;

		OPEN SO_Lista_Cat_Carg FOR
		SELECT A.COD_CATEGORIA,
			   A.MIN_CARGO_REQUERIDO,
			   A.DES_CATEGORIA,
			   A.ID_CATEGORIA
		FROM   PS_CATEGORIAS_CARGO_TD A
		WHERE  A.MIN_CARGO_REQUERIDO <=  SUM_IMPCARGBASIC;
	END IF;

	RETURN TRUE;

EXCEPTION
WHEN NO_DATA_FOUND THEN
      SN_cod_retorno := 149;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
return false;
      END IF;
	  LV_des_error   := 'PS_CLIENTE_I_FN(Lista Clientes); '||SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PS_CATEGORIAS_BASICO_PG.PS_CLIENTE_I_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
WHEN OTHERS THEN
      SN_cod_retorno := 156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
	  LV_des_error   := 'PS_CLIENTE_I_FN(Lista Clientes); '||SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PS_CATEGORIAS_BASICO_PG.PS_CLIENTE_I_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
		return false;
END PS_CLIENTE_I_FN;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION PS_CLIENTE_E_FN(EO_Cat_Carg  IN  		PF_CLIEN_ABO_QT,
 				  SO_Lista_Cat_Carg  OUT NOCOPY	refCursor,
 				  SN_cod_retorno      OUT NOCOPY    ge_errores_pg.coderror,
 				  SV_mens_retorno     OUT NOCOPY    ge_errores_pg.msgerror,
 				  SN_num_evento       OUT NOCOPY	ge_errores_pg.evento) RETURN BOOLEAN
IS
/*
<Documentación
  TipoDoc = "Procedure">>
   <Elemento
      Nombre = "PF_PRODUCTO_S_PR"
      Lenguaje="PL/SQL"
      Fecha="26-07-2007"
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
SUM_IMPCARGBASIC		   number(9);

BEGIN
	SN_cod_retorno 	:= 0;
	SV_mens_retorno := ' ';
	SN_num_evento 	:= 0;

	IF EO_Cat_Carg IS NULL THEN
		SN_cod_retorno 	:= CN_LISTA_NULA;
		SV_mens_retorno  := 'Lista Aboando es nula';
		RETURN FALSE;
	ELSE
		LV_sSql := ' SELECT A.COD_CATEGORIA, ';
		LV_sSql := LV_sSql || ' A.MIN_CARGO_REQUERIDO, ';
		LV_sSql := LV_sSql || ' A.DES_CATEGORIA, ';
		LV_sSql := LV_sSql || ' A.ID_CATEGORIA ';
		LV_sSql := LV_sSql || ' FROM GA_EMPRESA D, PS_CATEGORIAS_CARGO_TD A, ta_plantarif B, TA_CARGOSBASICO C ';
		LV_sSql := LV_sSql || ' WHERE D.COD_CLIENTE = '||EO_Cat_Carg.COD_CLIENTE;
		LV_sSql := LV_sSql || ' AND D.COD_PLANTARIF = B.COD_PLANTARIF ';
		LV_sSql := LV_sSql || ' AND B.COD_CARGOBASICO = C.COD_CARGOBASICO ';
		LV_sSql := LV_sSql || ' AND A.MIN_CARGO_REQUERIDO <= C.IMP_CARGOBASICO';

		OPEN SO_Lista_Cat_Carg FOR
		SELECT A.COD_CATEGORIA,
			   A.MIN_CARGO_REQUERIDO,
			   A.DES_CATEGORIA,
			   A.ID_CATEGORIA
		FROM   GA_EMPRESA D, PS_CATEGORIAS_CARGO_TD A, ta_plantarif B, TA_CARGOSBASICO C
		WHERE  D.COD_CLIENTE = EO_Cat_Carg.COD_CLIENTE
		AND    D.COD_PLANTARIF = B.COD_PLANTARIF
		AND	   B.COD_CARGOBASICO = C.COD_CARGOBASICO
		AND    A.MIN_CARGO_REQUERIDO <= C.IMP_CARGOBASICO;

		RETURN TRUE;
	END IF;


EXCEPTION
WHEN NO_DATA_FOUND THEN
      SN_cod_retorno := 149;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
return false;
      END IF;
   LV_des_error   := 'PS_CLIENTE_E_FN(Lista Clientes); '||SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PS_CATEGORIAS_BASICO_PG.PS_CLIENTE_E_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
WHEN OTHERS THEN
      SN_cod_retorno := 156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
   LV_des_error   := 'PS_CLIENTE_E_FN(Lista Clientes); '||SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PS_CATEGORIAS_BASICO_PG.PS_CLIENTE_E_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
 	return false;
END PS_CLIENTE_E_FN;
 ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PS_CATEGORIA_S_PR(EO_Cat_Carg  IN  		PF_CLIEN_ABO_QT,
					  SO_Lista_Cat_Carg  OUT NOCOPY	refCursor,
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
      Fecha="26-07-2007"
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
LV_ClienteEmpresa		   number(9);
LE_ERROR                     EXCEPTION;

BEGIN
	SN_cod_retorno 	:= 0;
	SV_mens_retorno := ' ';
	SN_num_evento 	:= 0;

	LV_sSql := ' SELECT COUNT(1) ';
	LV_sSql := LV_sSql || ' FROM   GA_EMPRESA ';
	LV_sSql := LV_sSql || ' WHERE  cod_cliente  = '||EO_Cat_Carg.COD_CLIENTE;

	SELECT COUNT(1)
	INTO   LV_ClienteEmpresa
	FROM   GA_EMPRESA
	WHERE  cod_cliente  = EO_Cat_Carg.COD_CLIENTE;

	IF (NVL(EO_CAT_CARG.NUM_ABONADO,0) = 0) THEN

		IF  LV_ClienteEmpresa = 0 THEN
			LV_sSql	:= 'PS_CLIENTE_I_FN(EO_Cat_Carg,SO_Lista_Cat_Carg,SN_cod_retorno, SV_mens_retorno, SN_num_evento)';
			IF  not PS_CLIENTE_I_FN(EO_Cat_Carg,SO_Lista_Cat_Carg,SN_cod_retorno, SV_mens_retorno, SN_num_evento)  THEN
				RAISE LE_ERROR;
			end if;
		ELSE
			LV_sSql	:= 'PS_CLIENTE_E_FN(EO_Cat_Carg,SO_Lista_Cat_Carg,SN_cod_retorno, SV_mens_retorno, SN_num_evento)';
			IF NOT PS_CLIENTE_E_FN(EO_Cat_Carg,SO_Lista_Cat_Carg,SN_cod_retorno, SV_mens_retorno, SN_num_evento)  THEN
			   RAISE LE_ERROR;
			end if;
		END IF;
	ELSE
		LV_sSql	:= 'PS_ABONADO_S_FN(EO_Cat_Carg,SO_Lista_Cat_Carg,SN_cod_retorno, SV_mens_retorno, SN_num_evento)';
		IF NOT PS_ABONADO_S_FN(EO_Cat_Carg,SO_Lista_Cat_Carg,SN_cod_retorno, SV_mens_retorno, SN_num_evento)  THEN
			RAISE LE_ERROR;
		END IF;
	END IF;

EXCEPTION
  WHEN LE_ERROR THEN
      SN_cod_retorno := 156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
	  LV_des_error   := 'PS_CATEGORIA_S_PR(Lista Categorias); '||SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PS_CATEGORIAS_BASICO_PG.PS_CATEGORIA_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

WHEN NO_DATA_FOUND THEN
      SN_cod_retorno := 149;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
	  LV_des_error   := 'PS_CATEGORIA_S_PR(Lista Categorias); '||SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PS_CATEGORIAS_BASICO_PG.PS_CATEGORIA_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
WHEN OTHERS THEN
      SN_cod_retorno := 156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
	  LV_des_error   := 'PS_CATEGORIA_S_PR(Lista Categorias); '||SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PS_CATEGORIAS_BASICO_PG.PS_CATEGORIA_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PS_CATEGORIA_S_PR;


END PS_CATEGORIAS_BASICO_PG;
/
SHOW ERRORS
