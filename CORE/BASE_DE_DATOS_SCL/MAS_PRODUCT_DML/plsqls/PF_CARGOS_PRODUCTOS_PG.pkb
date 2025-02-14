CREATE OR REPLACE PACKAGE BODY PF_CARGOS_PRODUCTOS_PG

AS

  PROCEDURE PF_CARGO_S_PR(EO_CARG_PROD	  IN  		PF_CARGOS_PROD_TD_LISTA_QT,
						  SO_CARG_PROD OUT NOCOPY	refCursor,
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

			IF EO_CARG_PROD IS NULL THEN
			   RAISE ERROR_PARAMETROS;
			ELSE
				LV_sSql := 'SELECT A.COD_CARGO, A.ID_CARGO, A.COD_MONEDA, A.MONTO_IMPORTE ';
				LV_sSql := LV_sSql || 'FROM PF_CARGOS_PRODUCTOS_TD a ';
				LV_sSql := LV_sSql || 'WHERE a.COD_CARGO IN (SELECT COD_CARGO FROM TABLE (EO_CARG_PROD))';

				OPEN SO_CARG_PROD FOR
				SELECT A.COD_CARGO, A.ID_CARGO, A.COD_MONEDA, A.MONTO_IMPORTE
				FROM PF_CARGOS_PRODUCTOS_TD a
				WHERE a.COD_CARGO IN (SELECT COD_CARGO FROM TABLE (EO_CARG_PROD));

			END IF;

EXCEPTION
    WHEN ERROR_PARAMETROS THEN
	      SN_cod_retorno := 98;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'PF_CARGO_S_PR(Lista Cargos); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_CARGOS_PRODUCTOS_PG.PF_CARGO_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
	WHEN NO_DATA_FOUND THEN
	      SN_cod_retorno := 0;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'PF_CARGO_S_PR(Lista Cargos); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_CARGOS_PRODUCTOS_PG.PF_CARGO_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
	WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'PF_CARGO_S_PR(Lista Cargos); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_CARGOS_PRODUCTOS_PG.PF_CARGO_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

	END PF_CARGO_S_PR;
    
    
    PROCEDURE PF_CARGO_PRODUCTO_S_PR(EV_COD_PROD_OFERTADO   IN pf_catalogo_ofertado_td.cod_prod_ofertado%type,
                                        EV_COD_CANAL        IN pf_catalogo_ofertado_td.cod_canal%type, 
                					    SO_CARGOS_PROD      OUT NOCOPY	refCursor,
						                SN_cod_retorno      OUT NOCOPY  ge_errores_pg.coderror,
						                SV_mens_retorno     OUT NOCOPY  ge_errores_pg.msgerror,
						                SN_num_evento       OUT NOCOPY	ge_errores_pg.evento)
	IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "PF_CARGO_PRODUCTO_S_PR"
	      Lenguaje="PL/SQL"
	      Fecha="22-06-2010
	      Versión="La del package"
	      Diseñador="Elizabeth Vera"
	      Programador="Elizabeth Vera"
	      Ambiente Desarrollo="BD">
	      <Retorno>N/A</Retorno>>
	      <Descripción>Obtiene lista de cargos por producto</Descripción>>
	      <Parámetros>
	         <Entrada>
	            <param nom="EV_COD_PROD_OFERTADO" Tipo="CARACTER">Código de Producto ofertado</param>>
                <param nom="EV_COD_CANAL" Tipo="CARACTER">Codigo Canal </param>>
	         </Entrada>
	         <Salida>
	            <param nom="SO_CARGOS_PROD Tipo="Cursor">Lista de Cargos</param>>
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

	ERROR_PARAMETROS EXCEPTION;

		BEGIN
        
	        SN_cod_retorno 	:= 0;
        	SV_mens_retorno := ' ';
        	SN_num_evento 	:= 0;
            
            OPEN SO_CARGOS_PROD FOR
            SELECT  a.cod_cargo, a.cod_concepto, b.monto_importe, b.cod_moneda, c.tipo_cargo
            FROM    pf_catalogo_ofertado_td  a,
                    pf_cargos_productos_td b,
                    pf_conceptos_prod_td c,
                    pf_productos_ofertados_td d,
                    ge_monedas e,
                    fa_conceptos f
            WHERE   a.cod_canal = EV_COD_CANAL
            AND     sysdate >= a.fec_inicio_vigencia
            AND     a.fec_termino_vigencia <= to_date('31-12-3000 23:59:59', 'DD-MM-YYYY HH24:MI:SS')
            AND     a.cod_prod_ofertado = EV_COD_PROD_OFERTADO
            AND	  a.COD_PROD_OFERTADO = d.cod_prod_ofertado
            AND	  a.cod_cargo = b.cod_cargo
            AND	  a.cod_concepto = c.cod_concepto
            AND	  d.COD_PROD_OFERTADO = c.COD_PROD_OFERTADO
            AND	  b.COD_MONEDA = e.COD_MONEDA
            AND	  c.COD_CONCEPTO = f.COD_CONCEPTO;
                  
    END PF_CARGO_PRODUCTO_S_PR;

END PF_CARGOS_PRODUCTOS_PG;
/
SHOW ERRORS