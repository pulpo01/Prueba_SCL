CREATE OR REPLACE PACKAGE BODY VE_VALIDAVENDEDOR_PG IS

/*
<Documentación
  TipoDoc = "Package">
   <Elemento
      Nombre="VE_VALIDAVENDEDOR_PG"
      Lenguaje="PL/SQL"
      Fecha creación="31-05-2005"
      Creado por="Héctor Pérez Guzmán."
      Fecha modificación=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>package que valida que el vendedor no tenga ventas impagas y no tenga ventas no legalizadas</Descripción>
      <Parámetros>
         <Entrada>NA</Entrada>
         <Salida>NA</Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/


CV_error_no_clasif  VARCHAR2(50):= 'No es posible clasificar el error';
CV_nom_tabla        CONSTANT ged_codigos.nom_tabla%TYPE:='DESBLOQUEO_PREPAGO';
CV_nom_columna      CONSTANT ged_codigos.nom_columna%TYPE:='PROCESO_EXITOSO';
CV_codmodulo        CONSTANT VARCHAR2(2):='GA';

--------------------------------------------------------------------------------------------------------

FUNCTION ga_seq_transacabo_fn (SV_numtransaccion   OUT     NOCOPY ga_transacabo.num_transaccion%TYPE,
                               SN_cod_retorno      OUT     NOCOPY ge_errores_td.cod_msgerror%TYPE,
                               SV_mens_retorno     OUT     NOCOPY ge_errores_td.det_msgerror%TYPE,
                               SN_num_evento       OUT     NOCOPY ge_errores_pg.Evento
) RETURN BOOLEAN
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "ga_seq_transacabo_fn""
      Lenguaje="PL/SQL"
      Fecha="31-08-2005"
      Versión="1.0"
      Diseñador="Héctor Pérez Guzmán"
      Programador="Héctor Pérez Guzmán"
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción></Descripción>
      <Parámetros>
         <Entrada>
         </Entrada>
         <Salida>
            <param nom="SV_numtransaccion" Tipo="CARACTER">Numero de secuencia transaccion</param>
            <param nom="SN_cod_retorno   " Tipo="NUMERICO">Codigo de Retorno              </param>
            <param nom="SV_mens_retorno  " Tipo="CARACTER">Mensaje de Retorno             </param>
            <param nom="SN_num_evento    " Tipo="NUMERICO">Numero de Evento               </param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS

        V_des_error    ge_errores_pg.DesEvent;
        LV_sql         ge_errores_pg.vQuery;

BEGIN

    SN_cod_retorno := 0;
    SN_num_evento  := 0;
    SV_mens_retorno:= '0';

    LV_sql := 'SELECT ga_seq_transacabo.NEXTVAL';
    LV_sql := LV_sql || ' INTO SV_numtransaccion';
    LV_sql := LV_sql || ' FROM dual';

        SELECT ga_seq_transacabo.NEXTVAL
        INTO SV_numtransaccion
        FROM dual;

    RETURN TRUE;

EXCEPTION

        WHEN OTHERS THEN
                SN_cod_retorno := 156; -- 'Error al obtener secuencia de transacciones;--
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := CV_error_no_clasif;
                END IF;
                V_des_error := 'ga_seq_transacabo_fn(obtiene secuencia); - ' || SQLERRM;
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.0', USER,
'VE_VALIDAVENDEDOR_PG.ga_seq_transacabo_fn', LV_sql, SQLCODE, V_des_error );
                RETURN FALSE;

END ga_seq_transacabo_FN;

--------------------------------------------------------------------------------------------------------
FUNCTION ga_tip_comis_fn (EV_codvendealer  IN      ve_vendealer.cod_vendealer%TYPE,
                          EV_canalvendedor IN      VARCHAR2,
                          SV_codvendedor   OUT     NOCOPY ve_vendedores.cod_vendedor%TYPE,
                          SV_codtipcomis   OUT     NOCOPY ve_tipcomis.cod_tipcomis%TYPE,
                          SN_cod_retorno   OUT     NOCOPY ge_errores_td.cod_msgerror%TYPE,
                          SV_mens_retorno  OUT     NOCOPY ge_errores_td.det_msgerror%TYPE,
                          SN_num_evento    OUT     NOCOPY ge_errores_pg.Evento
) RETURN BOOLEAN
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "ga_tip_comis_fn""
      Lenguaje="PL/SQL"
      Fecha="31-08-2005"
      Versión="1.0"
      Diseñador="Héctor Pérez Guzmán"
      Programador="Héctor Pérez Guzmán"
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción></Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EV_codvendealer " Tipo="CARACTER">Codigo vendedor dealer</param>
            <param nom="EV_canalvendedor" Tipo="CARACTER">canal de venta        </param>
         </Entrada>
         <Salida>
            <param nom="SV_codvendedor  " Tipo="CARACTER">Codigo vendedor         </param>
            <param nom="SV_codtipcomis  " Tipo="CARACTER">Codigo tipo comisionista</param>
            <param nom="SN_cod_retorno  " Tipo="NUMERICO">Codigo de Retorno       </param>
            <param nom="SV_mens_retorno " Tipo="CARACTER">Mensaje de Retorno      </param>
            <param nom="SN_num_evento   " Tipo="NUMERICO">Numero de Evento        </param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS

        V_des_error    ge_errores_pg.DesEvent;
        LV_sql         ge_errores_pg.vQuery;

BEGIN

    SN_cod_retorno := 0;
    SN_num_evento  := 0;
    SV_mens_retorno:= '0';

        IF TRIM(UPPER(EV_canalvendedor))='D' THEN

            LV_sql := 'SELECT cod_vendedor, cod_tipcomis';
            LV_sql := LV_sql || ' INTO   LV_codvendedor, LV_codtipcomis';
            LV_sql := LV_sql || ' FROM   ve_vendedores';
            LV_sql := LV_sql || ' WHERE  cod_vendedor = '|| EV_codvendealer;

            SELECT cod_vendedor, cod_tipcomis
            INTO   SV_codvendedor, SV_codtipcomis
            FROM   ve_vendedores
            WHERE  cod_vendedor = EV_codvendealer;


        ELSIF TRIM(UPPER(EV_canalvendedor))='I' THEN

            LV_sql := 'SELECT cod_vendedor, cod_tipcomis';
            LV_sql := LV_sql || ' INTO   LV_codvendedor, LV_codtipcomis';
            LV_sql := LV_sql || ' FROM   ve_vendealer';
            LV_sql := LV_sql || ' WHERE  cod_vendealer = '|| EV_codvendealer;

            SELECT cod_vendedor, cod_tipcomis
            INTO   SV_codvendedor, SV_codtipcomis
            FROM   ve_vendealer
            WHERE  cod_vendealer = EV_codvendealer;

        END IF;

    RETURN TRUE;

EXCEPTION

        WHEN NO_DATA_FOUND THEN
                SN_cod_retorno := 476; --'Vendedor no existe'--
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := CV_error_no_clasif;
                END IF;
                V_des_error := 'ga_recupera_parametros_fn('||EV_codvendealer||', '||EV_canalvendedor||'); - ' || SQLERRM;
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.0', USER,
'VE_VALIDAVENDEDOR_PG.ga_tip_comis_FN', LV_sql, SQLCODE, V_des_error );
                RETURN FALSE;


        WHEN OTHERS THEN
                SN_cod_retorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := CV_error_no_clasif;
                END IF;
                V_des_error := 'ga_recupera_parametros_fn('||EV_codvendealer||', '||EV_canalvendedor||'); - ' || SQLERRM;
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.0', USER,
'VE_VALIDAVENDEDOR_PG.ga_tip_comis_FN', LV_sql, SQLCODE, V_des_error );
                RETURN FALSE;

END ga_tip_comis_fn;

--------------------------------------------------------------------------------------------------------

FUNCTION ga_ret_transababo_fn (EN_numtransaccion  IN    ga_transacabo.num_transaccion%TYPE,
                               SN_retorno         OUT   NOCOPY ga_transacabo.cod_retorno%TYPE,
                               SV_cadena          OUT   NOCOPY ga_transacabo.des_cadena%TYPE,
                               SN_cod_retorno     OUT   NOCOPY ge_errores_td.cod_msgerror%TYPE,
                               SV_mens_retorno    OUT   NOCOPY ge_errores_td.det_msgerror%TYPE,
                               SN_num_evento      OUT   NOCOPY ge_errores_pg.Evento
) RETURN BOOLEAN
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "ga_ret_transababo_fn""
      Lenguaje="PL/SQL"
      Fecha="31-08-2005"
      Versión="1.0"
      Diseñador="Héctor Pérez Guzmán"
      Programador="Héctor Pérez Guzmán"
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción></Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_numtransaccion" Tipo="NUMERICO">Numero transaccion</param>
         </Entrada>
         <Salida>
            <param nom="SN_retorno       " Tipo="NUMERICO">Codigo Retorno ransaccion    </param>
            <param nom="SV_cadena        " Tipo="CARACTER">Resultado retorno transaccion</param>
            <param nom="SN_cod_retorno   " Tipo="NUMERICO">Codigo de Retorno            </param>
            <param nom="SV_mens_retorno  " Tipo="CARACTER">Mensaje de Retorno           </param>
            <param nom="SN_num_evento    " Tipo="NUMERICO">Numero de Evento             </param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS

        V_des_error    ge_errores_pg.DesEvent;
        LV_sql         ge_errores_pg.vQuery;

BEGIN

    SN_cod_retorno := 0;
    SN_num_evento  := 0;
    SV_mens_retorno:= '0';

        LV_sql := 'SELECT cod_retorno, des_cadena';
        LV_sql := LV_sql || ' INTO   SV_retorno, SV_cadena';
        LV_sql := LV_sql || ' FROM   ga_transacabo';
        LV_sql := LV_sql || ' WHERE  num_transaccion = = '|| EN_numtransaccion;

        SELECT cod_retorno, des_cadena
        INTO   SN_retorno, SV_cadena
        FROM   ga_transacabo
        WHERE  num_transaccion = EN_numtransaccion;

    RETURN TRUE;

EXCEPTION

        WHEN NO_DATA_FOUND THEN
            SN_cod_retorno := 156; --'No existe transaccion';
            IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
               SV_mens_retorno := CV_error_no_clasif;
            END IF;
            V_des_error := 'ga_ret_transababo_fn('||EN_numtransaccion||'); - ' || SQLERRM;
            SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.0', USER,
'VE_VALIDAVENDEDOR_PG.ga_ret_transababo_fn', LV_sql, SQLCODE, V_des_error );
            RETURN FALSE;


        WHEN OTHERS THEN
            SN_cod_retorno := 156; -- 'Error al obtener retorno de transaccion';
            IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
               SV_mens_retorno := CV_error_no_clasif;
            END IF;
            V_des_error := 'ga_ret_transababo_fn('||EN_numtransaccion||'); - ' || SQLERRM;
            SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.0', USER,
'VE_VALIDAVENDEDOR_PG.ga_ret_transababo_fn', LV_sql, SQLCODE, V_des_error );
            RETURN FALSE;

END ga_ret_transababo_fn;

--------------------------------------------------------------------------------------------------------

PROCEDURE ve_valida_pr(EV_codvendealer  IN ve_vendealer.cod_vendealer%TYPE,
                       EV_canalvendedor IN VARCHAR2,
                       sn_cod_retorno   OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                       sv_mens_retorno  OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                       sn_num_evento    OUT NOCOPY      ge_errores_pg.evento
)
IS
        /*
        <Documentación
          TipoDoc = "Procedimiento">
           <Elemento
              Nombre = "ve_valida_pr"
              Lenguaje="PL/SQL"
              Fecha creación="31-08-2005".
              Creado por="Héctor Pérez Guzmán".
              Fecha modificacion=""
              Modificado por=""
              Ambiente Desarrollo="BD">
              <Retorno>NA</Retorno>
              <Descripción>Mostrar a que Operadora pertenece número de celular</Descripción>
              <Parámetros>
                 <Entrada>
                    <param nom="EV_codvendealer " Tipo="CARACTER">Codigo Vendedor</param>
                                <param nom="EV_canalvendedor" Tipo="CARACTER">Canal Vendedor </param>
                 </Entrada>
                 <Salida>
                    <param nom="SN_cod_retorno  " Tipo="NUMERICO">Codigo de Retorno</param>
                    <param nom="SV_mens_retorno " Tipo="CARACTER">Mensaje de Retorno</param>
                    <param nom="SN_num_evento   " Tipo="NUMERICO">Numero de Evento</param>
                 </Salida>
              </Parámetros>
           </Elemento>
        </Documentación>
        */

        exception_codvendealer   EXCEPTION;
        exception_ejecucion      EXCEPTION;
        exception_vtavencida     EXCEPTION;
        exception_vtalegalizadas EXCEPTION;

        SN_indvtaext             ve_tipcomis.ind_vta_externa%TYPE;
        SV_codvendedor           ve_vendealer.cod_vendedor%TYPE;
        SN_retorno               ga_transacabo.cod_retorno%TYPE;
        SV_cadena                ga_transacabo.des_cadena%TYPE;
        SV_codtipcomis           ve_vendealer.cod_tipcomis%TYPE;
        SN_numtransaccion        ga_transacabo.num_transaccion%TYPE;

        LV_sql                   ge_errores_pg.vQuery;
        V_des_error              ge_errores_pg.DesEvent;
		LV_ind_valida_venta      ve_estados_td.ind_invalida_venta%TYPE;
		LV_vendedor_vigente		 NUMBER;
		LN_existevendedor        NUMBER;

BEGIN

        SN_cod_retorno  := 0;
        SV_mens_retorno := '0';
        SN_num_evento   := 0;

        IF EV_codvendealer IS NULL THEN
           RAISE exception_codvendealer;
        END IF;

		IF UPPER(TRIM(EV_canalvendedor))='I' THEN

			LV_sql:='SELECT COUNT(1) FROM ve_vendealer d WHERE d.cod_vendealer=' || EV_codvendealer;

			SELECT COUNT(1)
			INTO   LN_existevendedor
			FROM   ve_vendealer d
			WHERE  d.cod_vendealer=EV_codvendealer;

			IF LN_existevendedor=0 THEN
			   RAISE exception_codvendealer;
			END IF;

		    LV_sql := 'SELECT COUNT(1) FROM VE_VENDEDORES A, VE_VENDEALER B WHERE A.COD_VENDEDOR = B.COD_VENDEDOR ' ||
			          'AND SYSDATE BETWEEN A.FEC_CONTRATO AND NVL(A.FEC_FINCONTRATO, SYSDATE) AND SYSDATE ' ||
					  'BETWEEN B.FEC_CONTRATO AND NVL(B.FEC_FINCONTRATO, SYSDATE) AND B.COD_VENDEALER = ' || EV_codvendealer;

			SELECT COUNT(1)
			INTO LV_vendedor_vigente
			FROM ve_vendedores a, ve_vendealer b
			WHERE a.cod_vendedor = b.cod_vendedor
			AND SYSDATE BETWEEN a.fec_contrato AND NVL(a.fec_fincontrato, SYSDATE)
			AND SYSDATE BETWEEN b.fec_contrato AND NVL(b.fec_fincontrato, SYSDATE)
			AND b.cod_vendealer = EV_codvendealer;

			IF LV_vendedor_vigente = 0 THEN
		       SN_cod_retorno := 471; --Vendedor No Vigente
		       RAISE exception_vtalegalizadas;
		    END IF;

			LV_sql := 'SELECT b.ind_invalida FROM ve_estados_vendedor b, ve_vendealer a ' ||
			          'WHERE  a.cod_vendealer=' || EV_codvendealer || ' AND a.cod_estado=b.cod_estado';

			SELECT b.ind_invalida
			INTO   LV_ind_valida_venta
			FROM   ve_estados_vendedor b, ve_vendealer a
			WHERE  a.cod_vendealer=EV_codvendealer
				   AND a.cod_estado=b.cod_estado;

			IF LV_ind_valida_venta=1 THEN
			   SN_cod_retorno := 331; --Vendedor No hablitado para vender
		       RAISE exception_vtalegalizadas;
			END IF;

		 ELSIF UPPER(TRIM(EV_canalvendedor))='D' THEN

		    LV_sql := 'SELECT COUNT(1) FROM ve_vendedores WHERE cod_vendedor=' || EV_codvendealer;

			SELECT COUNT(1)
			INTO   LN_existevendedor
			FROM   ve_vendedores v
			WHERE  v.cod_vendedor=EV_codvendealer;

			IF LN_existevendedor=0 THEN
			   RAISE exception_codvendealer;
			END IF;

		    LV_sql := 'SELECT COUNT(1) FROM VE_VENDEDORES A WHERE A.COD_VENDEDOR = ' || EV_codvendealer ||
			          ' AND SYSDATE BETWEEN A.FEC_CONTRATO AND NVL(A.FEC_FINCONTRATO, SYSDATE)';

			SELECT COUNT(1)
			INTO LV_vendedor_vigente
 			FROM ve_vendedores a
			WHERE a.cod_vendedor = EV_codvendealer
			AND SYSDATE BETWEEN a.fec_contrato AND NVL(a.fec_fincontrato, SYSDATE);

			IF LV_vendedor_vigente = 0 THEN
		       SN_cod_retorno := 471; --Vendedor No Vigente
		       RAISE exception_vtalegalizadas;
		    END IF;

			LV_sql := 'SELECT b.ind_invalida_venta FROM ve_estados_td b, ve_vendedores a WHERE ' ||
			          'a.cod_vendedor=' || EV_codvendealer || ' AND a.cod_estado=b.cod_estado';

			SELECT b.ind_invalida_venta
			INTO   LV_ind_valida_venta
			FROM   ve_estados_td b, ve_vendedores a
			WHERE  a.cod_vendedor=EV_codvendealer
				   AND a.cod_estado=b.cod_estado;

			IF LV_ind_valida_venta=1 THEN
			   SN_cod_retorno := 331; --Vendedor No hablitado para vender
		       RAISE exception_vtalegalizadas;
			END IF;

	    END IF;

--		IF NOT ga_seq_transacabo_FN(SN_numtransaccion, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
--           RAISE exception_ejecucion;
--        END IF;

--       LV_sql := 'ga_tip_comis_fn(' || EV_codvendealer||','||EV_canalvendedor||','||SV_codvendedor||','||SV_codtipcomis || ')';
--        IF ga_tip_comis_fn(EV_codvendealer,EV_canalvendedor, SV_codvendedor, SV_codtipcomis, SN_cod_retorno, SV_mens_retorno,
--SN_num_evento) THEN
--               LV_sql := 'VE_validacion_PG.VE_venta_vencidas_PR('||SN_numtransaccion||','||SV_codvendedor||')';-
--				IF UPPER(TRIM(EV_canalvendedor))='D' THEN
--                    VE_validacion_PG.VE_venta_vencidas_PR(SN_numtransaccion, EV_codvendealer,'V');  --RA-0642
--				else
--                     VE_validacion_PG.VE_venta_vencidas_PR(SN_numtransaccion, EV_codvendealer,'D');  --RA-0642
--				end if;
--        ELSE
--                RAISE exception_ejecucion;
--        END IF;
--        IF ga_ret_transababo_fn(SN_numtransaccion, SN_retorno, SV_cadena,SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
--           IF TRIM(SV_cadena) = '0'  THEN
--             SN_cod_retorno := 464; --"Ventas vencidas para el Vendedor"--
--            RAISE exception_vtavencida;
--        ELSIF SN_retorno = 4 THEN
--           SN_cod_retorno := 156;
--           LV_sql :=  SV_cadena;
--           RAISE exception_vtavencida;
--        END IF;
--   ELSE
--      RAISE exception_ejecucion;
--   END IF;

--        IF NOT ga_seq_transacabo_FN(SN_numtransaccion, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
--                RAISE exception_ejecucion;
--        END IF;

--        LV_sql :=
--'VE_validacion_pg.VE_venta_legalizadas_PR('||SN_numtransaccion||','||SV_codtipcomis||','||EV_codvendealer||','||SV_codvendedor||')';
--        VE_validacion_pg.VE_venta_legalizadas_PR (SN_numtransaccion, SV_codtipcomis, EV_codvendealer, SV_codvendedor);

--        IF ga_ret_transababo_fn(SN_numtransaccion, SN_retorno, SV_cadena,SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
--            IF TRIM(SV_cadena) = '0' THEN
--               SN_cod_retorno := 465; --"Ventas Pendientes de Legalización para el Vendedor"--
--               RAISE exception_vtalegalizadas;
--            ELSIF SN_retorno = 4 THEN
--               SN_cod_retorno := 156;
--               LV_sql :=  SV_cadena;
--               RAISE exception_vtalegalizadas;
--            END IF;
--        ELSE
--               RAISE exception_ejecucion;
--        END IF;

--        LV_sql := 've_recuperaparametros_sms_pg.VE_recupera_glosa_FN('||CV_codmodulo||','||CV_nom_tabla||','||CV_nom_columna||')';
--        IF NOT ve_recuperaparametros_sms_pg.VE_recupera_glosa_FN(CV_codmodulo,CV_nom_tabla,CV_nom_columna,
--           SV_mens_retorno,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
--           SN_cod_retorno:=0;
--           SV_mens_retorno:=NULL;
--           RAISE exception_ejecucion;
--        END IF;


EXCEPTION
    WHEN exception_ejecucion THEN
         V_des_error := 've_valida_pr('||EV_codvendealer||', '||EV_canalvendedor||'); - ' || SQLERRM;
         SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.0', USER, 'VE_VALIDAVENDEDOR_PG.ve_valida_pr',
LV_sql, SQLCODE, V_des_error );

    WHEN exception_codvendealer THEN
         SN_cod_retorno := 476; --"Ingrese Código de Vendedor Válido"--
         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasif;
         END IF;
         V_des_error := 've_valida_pr('||EV_codvendealer||', '||EV_canalvendedor||'); - ' || SQLERRM;
         SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.0', USER, 'VE_VALIDAVENDEDOR_PG.ve_valida_pr',
LV_sql, SQLCODE, V_des_error );

    WHEN exception_vtavencida THEN

         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := CV_error_no_clasif;
         END IF;
         V_des_error := 've_valida_pr('||EV_codvendealer||', '||EV_canalvendedor||'); - ' || SQLERRM;
         SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.0', USER, 'VE_VALIDAVENDEDOR_PG.ve_valida_pr',
LV_sql, SQLCODE, V_des_error );

    WHEN exception_vtalegalizadas THEN

         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := CV_error_no_clasif;
         END IF;
         V_des_error := 've_valida_pr('||EV_codvendealer||', '||EV_canalvendedor||'); - ' || SQLERRM;
         SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.0', USER, 'VE_VALIDAVENDEDOR_PG.ve_valida_pr',
LV_sql, SQLCODE, V_des_error );

    WHEN NO_DATA_FOUND THEN
         SN_cod_retorno := 156;
         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := CV_error_no_clasif;
         END IF;
         V_des_error := 've_valida_pr('||EV_codvendealer||', '||EV_canalvendedor||'); - ' || SQLERRM;
         SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.0', USER, 'VE_VALIDAVENDEDOR_PG.ve_valida_pr',
LV_sql, SQLCODE, V_des_error );

    WHEN OTHERS THEN
         SN_cod_retorno := 156;
         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := CV_error_no_clasif;
         END IF;
         V_des_error := 've_valida_pr('||EV_codvendealer||', '||EV_canalvendedor||'); - ' || SQLERRM;
         SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.0', USER, 'VE_VALIDAVENDEDOR_PG.ve_valida_pr',
LV_sql, SQLCODE, V_des_error );

END ve_valida_pr;

--------------------------------------------------------------------------------------------------------

END VE_VALIDAVENDEDOR_PG;
/
SHOW ERRORS