CREATE OR REPLACE PACKAGE BODY VE_valcodcliente_PG IS

        /*
		<Documentación TipoDoc = "VE_valcodcliente_PG
		<Elemento Nombre = "Package" Lenguaje="PL/SQL" Fecha="16-06-2005" Versión="1.0.0" Diseñador="Rayen Ceballos" Programador="Roberto Pérez" Ambiente="BD">
		<Retorno>NA</Retorno>
		<Descripción> Body de VE_valcodcliente_PG /Descripción>
		<Parámetros>
		<Entrada>
		<param nom="" Tipo="STRING">Descripción Parametro1</param>
		</Entrada>
		<Salida>
		<param nom="" Tipo="STRING">Descripción Parametro4</param>
		</Salida>
		</Parámetros>
		</Elemento>
		</Documentación>
		*/


        PROCEDURE VE_valida_PR(EV_tipident IN ge_clientes.cod_tipident%TYPE,
				              EV_numident IN ge_clientes.num_ident%TYPE,
							  SN_coderror OUT NOCOPY NUMBER,
							  SV_error    OUT NOCOPY VARCHAR2
	   	  		  		   	 ) IS

        /*
		<Documentación TipoDoc = "VE_valcodcliente_FN
		<Elemento Nombre = "PROCEDURE" Lenguaje="PL/SQL" Fecha="16-06-2005" Versión="1.0.0" Diseñador="Rayen Ceballos" Programador="Roberto Pérez" Ambiente="BD">
		<Retorno>PLS_INTEGER</Retorno>
		<Descripción> Determina si un cliente existe en la tabla de clientes ventaos o lista negra /Descripción>
		<Parámetros>
		<Entrada>
		<param nom="EV_NUMIDENT" Tipo="STRING">Numero de identidad del cliente a verificar</param>
		<param nom="EV_TIPIDENT" Tipo="STRING">Tipo identidad del cliente a verificar</param>
		</Entrada>
		<Salida>
		<param nom="SN_coderror Tipo="STRING">codigo de error parametrico</param>
		<param nom="SV_ERROR" Tipo="STRING">Descripcion de un error si es que se produce</param>
		</Salida>
		</Parámetros>
		</Elemento>
		</Documentación>
		*/

        LE_fin EXCEPTION;
		LN_record NUMBER(4);
		LN_total  NUMBER(15);
		LV_codcliente ge_clientes.cod_cliente%TYPE;
		LN_suma NUMBER(15):=0;
		LV_coderror VARCHAR2(64);
		-- Inicio modificacion by SAQL/Soporte 10/10/2005 - XO-200510070819
		LN_CANTIDAD NUMBER;
		LE_SINERROR EXCEPTION;
		-- Fin modificacion by SAQL/Soporte 10/10/2005 - XO-200510070819

		CURSOR cursor_clientes IS
		SELECT c.cod_cliente
			   FROM   ge_clientes c
			   WHERE  c.num_ident=EV_numident
			   		  AND c.cod_tipident=EV_tipident;
        BEGIN
		       SN_coderror:=0;
		       -- Inicio modificacion by SAQL/Soporte 10/10/2005 - XO-200510070819
		       BEGIN
		          SELECT COUNT(1) INTO LN_CANTIDAD
		          FROM ERD_EXCEPCION
		          WHERE COD_TIPIDENT = EV_tipident
		          AND NUM_IDENT = EV_numident
		          AND TRUNC(SYSDATE) BETWEEN FEC_DESDE_H AND FEC_HASTA_H;
		          IF LN_CANTIDAD > 0 THEN
		             RAISE LE_SINERROR;
		          END IF;
		       EXCEPTION
		          WHEN NO_DATA_FOUND THEN
		             SN_coderror:=0;
		       END;

		       -- Fin modificacion by SAQL/Soporte 10/10/2005 - XO-200510070819



	               BEGIN

			   SELECT COUNT(1)
			   INTO   LN_record
			   FROM   erd_clientes_vetados ve
			   WHERE  ve.num_ident_cliente = EV_numident
			   		  AND ve.cod_tipident = EV_tipident
			   		  AND SYSDATE BETWEEN ve.fec_modi_h AND NVL(ve.fec_hasta,SYSDATE);

			   IF LN_record>0 THEN
			      LV_coderror:='ERROR_CLIENTE_VETADO';
			      RAISE LE_fin;--XO-200509260738: German Espinoza Z; 05/10/2005
			   END IF;

	               END;

            -- Inicio Modificacion RA-2005103110010
		       OPEN cursor_clientes;
			   LOOP
				   FETCH cursor_clientes INTO LV_codcliente;
				   EXIT WHEN cursor_clientes%NOTFOUND;

				   SELECT
				         NVL(SUM(ca.importe_debe - ca.importe_haber),0) total
				   INTO  LN_total
				   FROM  co_cartera ca
				   WHERE ca.cod_cliente = LV_codcliente
				         AND   ca.ind_facturado = 1
				         AND   ca.fec_vencimie  < TRUNC(SYSDATE)
				         AND   ca.cod_tipdocum NOT IN (SELECT TO_NUMBER(co.cod_valor)
				                                       FROM   co_codigos co
				                                       WHERE  co.nom_tabla   = 'CO_CARTERA'
				                                              AND co.nom_columna = 'COD_TIPDOCUM'
												      );
				   LN_suma:=LN_suma + LN_total;

				   IF LN_suma>0 THEN
				      CLOSE cursor_clientes;
					  LV_coderror:='ERROR_CLIENTE_MOROSO';
					  RAISE LE_fin;
				   END IF;

			   END LOOP;
			   CLOSE cursor_clientes;
	    -- FIn Modificacion RA-2005103110010
	   EXCEPTION
		          WHEN LE_fin THEN
				     SN_coderror:=VE_retornacoderror_PG.VE_RETORNACODERROR_FN(LV_coderror, SV_error);
			-- Inicio modificacion by SAQL/Soporte 11/10/2005 - XO-200510070819
			  WHEN LE_SINERROR THEN
			     SN_CODERROR := 0;
			     SV_ERROR := '';
			-- Fin modificacion by SAQL/Soporte 11/10/2005 - XO-200510070819
			      WHEN OTHERS THEN
					 SN_coderror:=VE_retornacoderror_PG.VE_RETORNACODERROR_FN('ERROR_INTERNO', SV_error);



	END VE_valida_PR;
END VE_valcodcliente_PG;
/
SHOW ERRORS
