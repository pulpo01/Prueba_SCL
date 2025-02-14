CREATE OR REPLACE PACKAGE BODY PF_DESC_CONCEPTOS_PG

AS

FUNCTION PF_TIPO_VENDEDOR_FN( EN_VENDEDOR     IN NUMBER,
						  	  SN_TIPOVENDEDOR OUT NOCOPY NUMBER,
		 				  	  SN_cod_retorno  OUT NOCOPY ge_errores_pg.coderror,
						  	  SV_mens_retorno OUT NOCOPY ge_errores_pg.msgerror,
						  	  SN_num_evento   OUT NOCOPY ge_errores_pg.evento) RETURN BOOLEAN is
/*
<Documentación
  TipoDoc = "Procedure">
   <Elemento
      Nombre = "PF_TIPO_VENDEDOR_FN"
      Lenguaje="PL/SQL"
      Fecha="10-08-2008"
      Versión="La del package"
      Diseñador="Andrés Osorio"
      Programador="Andrés Osorio"
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripción>Devuelve el Tipo de Vendedor</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_VENDEDOR" Tipo="NUMERICO">Código de Vendedor</param>
         </Entrada>
         <Salida>
            <param nom="SN_TIPOVENDEDOR" Tipo="NUMERICO">Tipo de Vendedor/param>
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

	LV_sSql := 'SELECT IND_INTERNO';
	LV_sSql := LV_sSql || 'FROM VE_VENDEDORES';
	LV_sSql := LV_sSql || 'WHERE COD_VENDEDOR =' || EN_VENDEDOR;

	SELECT IND_INTERNO
	INTO SN_TIPOVENDEDOR
	FROM VE_VENDEDORES
	WHERE COD_VENDEDOR = EN_VENDEDOR;

	RETURN TRUE;

EXCEPTION
	WHEN NO_DATA_FOUND THEN
	      SN_cod_retorno := 476;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'Error al intentar obtener tipo de vendedor - '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_DESC_CONCEPTOS_PG .PF_TIPO_VENDEDOR_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
		  RETURN FALSE;

	WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'Error al intentar obtener tipo de vendedor - '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_DESC_CONCEPTOS_PG .PF_TIPO_VENDEDOR_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
		  RETURN FALSE;
END PF_TIPO_VENDEDOR_FN;


PROCEDURE PF_DESCUENTO_S_PR(EO_DESC_CONCEPT  IN  		PF_DESC_CONCEPTOS_TD_QT,
					  SO_DESC_CONCEPT OUT NOCOPY	refCursor,
					  SN_cod_retorno      OUT NOCOPY    ge_errores_pg.coderror,
					  SV_mens_retorno     OUT NOCOPY    ge_errores_pg.msgerror,
					  SN_num_evento       OUT NOCOPY	ge_errores_pg.evento)
IS
/*
<Documentación
  TipoDoc = "Procedure">>
   <Elemento
      Nombre = "PF_CANAL_S_PR"
      Lenguaje="PL/SQL"
      Fecha="10-08-2008"
      Versión="La del package"
      Diseñador="Andrés Osorio"
      Programador="Andrés Osorio"
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
l_IndVendedorInterno NUMBER;
LV_COUNT NUMBER;

BEGIN
	SN_cod_retorno 	:= 0;
	SV_mens_retorno := ' ';
	SN_num_evento 	:= 0;

	IF EO_DESC_CONCEPT IS NULL THEN
		RAISE ERROR_PARAMETROS;
	ELSE

		LV_sSql := 'PF_TIPO_VENDEDOR_FN('||EO_DESC_CONCEPT.COD_VENDEDOR||')';
		IF NOT (PF_TIPO_VENDEDOR_FN( EO_DESC_CONCEPT.COD_VENDEDOR,
						  	  		 l_IndVendedorInterno,
		 				  	  		 SN_cod_retorno,
						  	  		 SV_mens_retorno,
						  	  		 SN_num_evento))
		THEN
			RAISE ERROR_FUNCION;
		END IF;



		IF (l_IndVendedorInterno = 0) THEN

			LV_sSql := ' SELECT A.COD_CONCEPTO, A.COD_CONCEPTO_DESCTO, f.des_concepto, ';
			LV_sSql := LV_sSql || ' A.COD_CANAL, A.TIPO_VENDEDOR, A.COD_VENDEDOR, ';
			LV_sSql := LV_sSql || ' A.FEC_INICIO_VIGENCIA, A.FEC_TERMINO_VIGENCIA, A.TIPO_DESCUENTO, ';
			LV_sSql := LV_sSql || ' A.VALOR_DESCUENTO, A.COD_MONEDA, A.COD_DESCUENTO ';
			LV_sSql := LV_sSql || ' FROM   PF_DESCUENTOS_CONCEPTOS_TD A , ';
			LV_sSql := LV_sSql || ' FA_CONCEPTOS f ';
			LV_sSql := LV_sSql || ' WHERE  A.COD_CONCEPTO = ' ||EO_DESC_CONCEPT.COD_CONCEPTO;
			LV_sSql := LV_sSql || ' AND    A.COD_CANAL = ' ||EO_DESC_CONCEPT.COD_CANAL;
			LV_sSql := LV_sSql || ' AND    A.FEC_INICIO_VIGENCIA <= '||EO_DESC_CONCEPT.FEC_INICIO_VIGENCIA;
			LV_sSql := LV_sSql || ' AND    A.COD_VENDEDOR = '|| EO_DESC_CONCEPT.COD_VENDEDOR;
			LV_sSql := LV_sSql || ' AND    A.TIPO_VENDEDOR = '|| CV_EXTERNO;
			LV_sSql := LV_sSql || ' AND    A.COD_CONCEPTO_DESCTO = f.COD_CONCEPTO';

            IF EO_DESC_CONCEPT.COD_CANAL ='VT' THEN
			   SELECT COUNT(1)
               INTO LV_COUNT
               FROM   PF_DESCUENTOS_CONCEPTOS_TD A,
					  FA_CONCEPTOS f
			   WHERE  A.COD_CONCEPTO = EO_DESC_CONCEPT.COD_CONCEPTO
			   AND    A.COD_CANAL =EO_DESC_CONCEPT.COD_CANAL
			   AND    A.FEC_INICIO_VIGENCIA <= EO_DESC_CONCEPT.FEC_INICIO_VIGENCIA
			   AND    A.COD_VENDEDOR = EO_DESC_CONCEPT.COD_VENDEDOR
			   AND    A.TIPO_VENDEDOR = CV_EXTERNO
			   AND	   A.COD_CONCEPTO_DESCTO = f.COD_CONCEPTO;
               
            END IF;   
            
            
            OPEN SO_DESC_CONCEPT FOR
				SELECT A.COD_CONCEPTO,
				A.COD_CONCEPTO_DESCTO,
				f.des_concepto,
				A.COD_CANAL,
				A.TIPO_VENDEDOR,
				A.COD_VENDEDOR,
				A.FEC_INICIO_VIGENCIA,
				A.FEC_TERMINO_VIGENCIA,
				A.TIPO_DESCUENTO,
				A.VALOR_DESCUENTO,
				A.COD_MONEDA,
				A.COD_DESCUENTO
				FROM   PF_DESCUENTOS_CONCEPTOS_TD A,
					   FA_CONCEPTOS f
				WHERE  A.COD_CONCEPTO = EO_DESC_CONCEPT.COD_CONCEPTO
				AND    A.COD_CANAL =EO_DESC_CONCEPT.COD_CANAL
				AND    A.FEC_INICIO_VIGENCIA <= EO_DESC_CONCEPT.FEC_INICIO_VIGENCIA
				AND    A.COD_VENDEDOR = EO_DESC_CONCEPT.COD_VENDEDOR
				AND    A.TIPO_VENDEDOR = CV_EXTERNO
				AND	   A.COD_CONCEPTO_DESCTO = f.COD_CONCEPTO;

		ELSE

			LV_sSql := ' SELECT A.COD_CONCEPTO, A.COD_CONCEPTO_DESCTO, f.des_concepto, ';
			LV_sSql := LV_sSql || ' A.COD_CANAL, A.TIPO_VENDEDOR, A.COD_VENDEDOR, ';
			LV_sSql := LV_sSql || ' A.FEC_INICIO_VIGENCIA, A.FEC_TERMINO_VIGENCIA, A.TIPO_DESCUENTO, ';
			LV_sSql := LV_sSql || ' A.VALOR_DESCUENTO, A.COD_MONEDA, A.COD_DESCUENTO ';
			LV_sSql := LV_sSql || ' FROM   PF_DESCUENTOS_CONCEPTOS_TD A , ';
			LV_sSql := LV_sSql || ' FA_CONCEPTOS f ';
			LV_sSql := LV_sSql || ' WHERE  A.COD_CONCEPTO = ' ||EO_DESC_CONCEPT.COD_CONCEPTO;
			LV_sSql := LV_sSql || ' AND    A.COD_CANAL = ' ||EO_DESC_CONCEPT.COD_CANAL;
			LV_sSql := LV_sSql || ' AND    A.FEC_INICIO_VIGENCIA <= '||EO_DESC_CONCEPT.FEC_INICIO_VIGENCIA;
			LV_sSql := LV_sSql || ' AND    A.TIPO_VENDEDOR = '|| CV_INTERNO;
			LV_sSql := LV_sSql || ' AND    A.COD_CONCEPTO_DESCTO = f.COD_CONCEPTO';

			
            IF EO_DESC_CONCEPT.COD_CANAL ='VT' THEN
               SELECT COUNT(1)
               INTO LV_COUNT
               FROM   PF_DESCUENTOS_CONCEPTOS_TD A,
			   FA_CONCEPTOS f
			   WHERE  A.COD_CONCEPTO = EO_DESC_CONCEPT.COD_CONCEPTO
			   AND    A.COD_CANAL =EO_DESC_CONCEPT.COD_CANAL
			   AND    A.FEC_INICIO_VIGENCIA <= EO_DESC_CONCEPT.FEC_INICIO_VIGENCIA
			   AND    A.TIPO_VENDEDOR = CV_INTERNO
			   AND	   A.COD_CONCEPTO_DESCTO = f.COD_CONCEPTO;
            END IF;   
               
            
            OPEN SO_DESC_CONCEPT FOR
				SELECT A.COD_CONCEPTO,
				A.COD_CONCEPTO_DESCTO,
				f.des_concepto,
				A.COD_CANAL,
				A.TIPO_VENDEDOR,
				A.COD_VENDEDOR,
				A.FEC_INICIO_VIGENCIA,
				A.FEC_TERMINO_VIGENCIA,
				A.TIPO_DESCUENTO,
				A.VALOR_DESCUENTO,
				A.COD_MONEDA,
				A.COD_DESCUENTO
				FROM   PF_DESCUENTOS_CONCEPTOS_TD A,
				FA_CONCEPTOS f
				WHERE  A.COD_CONCEPTO = EO_DESC_CONCEPT.COD_CONCEPTO
				AND    A.COD_CANAL =EO_DESC_CONCEPT.COD_CANAL
				AND    A.FEC_INICIO_VIGENCIA <= EO_DESC_CONCEPT.FEC_INICIO_VIGENCIA
				AND    A.TIPO_VENDEDOR = CV_INTERNO
				AND	   A.COD_CONCEPTO_DESCTO = f.COD_CONCEPTO;

		END IF;
        
        IF EO_DESC_CONCEPT.COD_CANAL ='VT' THEN
           IF LV_COUNT = 0 THEN 
              
              OPEN SO_DESC_CONCEPT FOR
              SELECT A.COD_CONCEPTO,
			         A.COD_CONCEPTO_DESCTO,
				     f.des_concepto,
				     A.COD_CANAL,
				A.TIPO_VENDEDOR,
				A.COD_VENDEDOR,
				A.FEC_INICIO_VIGENCIA,
				A.FEC_TERMINO_VIGENCIA,
				A.TIPO_DESCUENTO,
				A.VALOR_DESCUENTO,
				A.COD_MONEDA,
				A.COD_DESCUENTO
				FROM   PF_DESCUENTOS_CONCEPTOS_TD A,
				FA_CONCEPTOS f
				WHERE  A.COD_CONCEPTO = EO_DESC_CONCEPT.COD_CONCEPTO
				AND    A.COD_CANAL =EO_DESC_CONCEPT.COD_CANAL
				AND    A.FEC_INICIO_VIGENCIA <= EO_DESC_CONCEPT.FEC_INICIO_VIGENCIA
				AND    A.TIPO_VENDEDOR = 'T'
				AND	   A.COD_CONCEPTO_DESCTO = f.COD_CONCEPTO
                AND ROWNUM=1;
                  
           END IF;
        END IF;

	END IF;

EXCEPTION
   WHEN ERROR_PARAMETROS THEN
	      SN_cod_retorno := 98;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'PF_DESCUENTO_S_PR('
		  				 	||EO_DESC_CONCEPT.COD_CONCEPTO||', '
							||EO_DESC_CONCEPT.COD_CANAL||', '
							||EO_DESC_CONCEPT.FEC_INICIO_VIGENCIA||', '
							||EO_DESC_CONCEPT.COD_VENDEDOR||'); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_DESC_CONCEPTOS_PG.PF_DESCUENTO_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

   WHEN ERROR_FUNCION THEN
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'PF_DESCUENTO_S_PR('
		  				 	||EO_DESC_CONCEPT.COD_CONCEPTO||', '
							||EO_DESC_CONCEPT.COD_CANAL||', '
							||EO_DESC_CONCEPT.FEC_INICIO_VIGENCIA||', '
							||EO_DESC_CONCEPT.COD_VENDEDOR||'); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_DESC_CONCEPTOS_PG.PF_DESCUENTO_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

	WHEN NO_DATA_FOUND THEN
	      SN_cod_retorno := 1398;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'PF_DESCUENTO_S_PR('
		  				 	||EO_DESC_CONCEPT.COD_CONCEPTO||', '
							||EO_DESC_CONCEPT.COD_CANAL||', '
							||EO_DESC_CONCEPT.FEC_INICIO_VIGENCIA||', '
							||EO_DESC_CONCEPT.COD_VENDEDOR||'); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_DESC_CONCEPTOS_PG.PF_DESCUENTO_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
	WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'PF_DESCUENTO_S_PR('
		  				 	||EO_DESC_CONCEPT.COD_CONCEPTO||', '
							||EO_DESC_CONCEPT.COD_CANAL||', '
							||EO_DESC_CONCEPT.FEC_INICIO_VIGENCIA||', '
							||EO_DESC_CONCEPT.COD_VENDEDOR||'); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_DESC_CONCEPTOS_PG.PF_DESCUENTO_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

	END PF_DESCUENTO_S_PR;

END PF_DESC_CONCEPTOS_PG; 
/
SHOW ERRORS