CREATE OR REPLACE PACKAGE BODY AL_INGRESOMERCADERIA_CLS_PG IS

PROCEDURE P_TRATA_INGRESO_PR (
IN_Ordening IN al_cabecera_ordenes.num_orden%TYPE,
IN_NumLinea IN al_lineas_ordenes.num_linea%TYPE,
IN_OrdenGsm IN gsm_cabsol_simcard_to.num_seq_solicitud%TYPE DEFAULT NULL,
IN_Flag     IN PLS_INTEGER DEFAULT 1)IS


     Error_Proceso_General  EXCEPTION;
     V_GLOSA_ERROR          VARCHAR2(70);
     izCod_Articulo            AL_LINEAS_ORDENES.COD_ARTICULO%TYPE;
     izTip_Orden            AL_LINEAS_ORDENES.TIP_ORDEN%TYPE;
     izNum_Linea            AL_LINEAS_ORDENES.NUM_LINEA%TYPE;
     szTipo_terminal        AL_ARTICULOS.TIP_TERMINAL%TYPE;
     izCod_Producto            AL_ARTICULOS.COD_PRODUCTO%TYPE;
     szhind_equiacc         AL_ARTICULOS.IND_EQUIACC%TYPE;
     izhind_seriado            AL_ARTICULOS.IND_SERIADO%TYPE;
     szColumnas                GED_PARAMETROS.VAL_PARAMETRO%TYPE;
     bzSalida               PLS_INTEGER;
     szSerie                AL_SERIES_ORDENES.NUM_SERIE%TYPE;
     szAKEy                 AL_SERIES_ORDENES.A_KEY%TYPE;
     szChkDigits             AL_SERIES_ORDENES.CHK_DIGITS%TYPE;
     szNumSecLoca             AL_SERIES_ORDENES.NUM_SEC_LOCA%TYPE;
     izError                AL_ERRORES_TEMP_TO.COD_ERROR%TYPE;
     sError                 AL_ERRORES_TEMP_TO.COD_ERROR%TYPE;
     SerieError             AL_SERIES.NUM_SERIE%TYPE;
     TI_Ind_Telefono         AL_SERIES_ORDENES2.ind_telefono%TYPE:=0;
     sTelefonoFic             AL_SERIES.NUM_TELEFONO%TYPE;
     sTelefonoTemp             AL_SERIES.NUM_TELEFONO%TYPE;
     TN_Central               AL_SERIES_ORDENES2.cod_central%TYPE;
     TN_Subalm                AL_SERIES_ORDENES2.cod_subalm%TYPE;
     TN_CodCat                AL_SERIES_ORDENES2.cod_cat%TYPE;
     bRet                      boolean:=FALSE;


---------------------------------------------------------------------------------------------
-- Cursor
---------------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------------
-- INICIO DEL PROCESO
---------------------------------------------------------------------------------------------
BEGIN
    IF IN_NumLinea IS NULL OR IN_NumLinea = '' THEN
            SerieError := szSinError;
            izError := 3;
            V_GLOSA_ERROR := 'ERROR Ingreso de Mercaderia: Parametro de entrada, numero de linea';
            RAISE ERROR_PROCESO_GENERAL;
    END IF;
    IF IN_Ordening IS NULL OR IN_Ordening = '' THEN
            SerieError := szSinError;
            izError := 4;
            V_GLOSA_ERROR := 'ERROR Ingreso de Mercaderia: Parametro de entrada, Orden de Compra';
            RAISE ERROR_PROCESO_GENERAL;
    END IF;
---------------------------------------------------------------------------------------------
-- Se obtiene NUM_ORDEN_REF
---------------------------------------------------------------------------------------------
        V_GLOSA_ERROR := 'No existen Orden ';
        SerieError := szSinError;
        izError := 6;
        SELECT  COD_ARTICULO , TIP_ORDEN
        INTO izCod_Articulo, izTip_Orden
        FROM AL_VLINEAS_ORDENES
        WHERE   NUM_ORDEN = IN_Ordening
        AND     NUM_LINEA = IN_NumLinea
        AND TIP_ORDEN = 2;
---------------------------------------------------------------------------------------------
-- Se obtiene NUM_ORDEN_REF
---------------------------------------------------------------------------------------------

        V_GLOSA_ERROR := 'Error en  SELECT que rescata NUM_ORDEN_REF ';
        SerieError := szSinError;
        izError := 7;
        SELECT A.NUM_ORDEN_REF,
               A.TIP_ORDEN_REF,
                  B.NUM_LINEA_REF
        INTO   izNum_Orden_Ref,  izhTipOrdenRef , izhNumLineaRef
        FROM   AL_VCABECERA_ORDENES A, AL_VLINEAS_ORDENES B
        WHERE  A.NUM_ORDEN = IN_Ordening
        AND    A.TIP_ORDEN = 2
        AND    B.NUM_LINEA = IN_NumLinea
        AND    A.TIP_ORDEN = B.TIP_ORDEN
        AND    A.NUM_ORDEN = B.NUM_ORDEN ;


---------------------------------------------------------------------------------------------
-- Se obtiene  TIP_ORDEN, NUM_LINEA de  AL_VLINEAS_ORDENES
---------------------------------------------------------------------------------------------
    /*
        V_GLOSA_ERROR := 'Error en  SELECT que rescata el tipo de Orden';
        SerieError := szSinError;
        izError := 8;
        SELECT TIP_ORDEN, NUM_LINEA
        INTO   izTip_Orden, izNum_Linea
        FROM   AL_VLINEAS_ORDENES
        WHERE  NUM_ORDEN = izNum_Orden_Ref
        AND    COD_ARTICULO = izCod_Articulo;
        */
---------------------------------------------------------------------------------------------
-- Se obtiene Terminal
---------------------------------------------------------------------------------------------
        V_GLOSA_ERROR := 'Error en Select que obtiene tipo de terminal';
        SerieError := szSinError;
        izError := 9;
        SELECT NVL(TIP_TERMINAL, 'N'), COD_PRODUCTO, IND_EQUIACC, IND_SERIADO
        INTO szTipo_terminal, izCod_Producto, szhind_equiacc, izhind_seriado
        FROM AL_ARTICULOS
        WHERE COD_ARTICULO = izCod_Articulo;

        IF  szTipo_terminal     = 'G' THEN
            IF IN_OrdenGsm IS NULL OR IN_OrdenGsm = '' THEN
                    V_GLOSA_ERROR := 'ERROR Ingreso de Mercaderia: Parametro de entrada, Orden GSM';
                    SerieError := szSinError;
                    izError := 5;
                    RAISE ERROR_PROCESO_GENERAL;
            END IF;

        ELSE
             IF NOT (szTipo_terminal     = 'N' OR szTipo_terminal = 'T' OR szTipo_terminal = 'R' OR szTipo_terminal = 'D') THEN
                     V_GLOSA_ERROR := 'Error en  Tipo de Tecnologia del Articulo ';
                    SerieError := szSinError;
                    izError := 11;
                    RAISE ERROR_PROCESO_GENERAL;
             END IF;
        END IF;


--***************************************************************
--PRIMERO OBTENEMOS LAS CANTIDAD DE SERIES DE LA ORDEN DE COMPRA.
--***************************************************************
/*
dSeriesTotalOC     al_lineas_ordenes2.can_orden%type;
dSeriesServidas    al_lineas_ordenes1.can_servida%type;
dSeriesIngresadas  al_lineas_ordenes2.can_orden%type;
dIngresadasAsp     al_lineas_ordenes2.can_orden%type;
dPendientesAsp     al_lineas_ordenes2.can_orden%type;
dNuevasPermitidas  al_lineas_ordenes2.can_orden%type;
*/
dbms_output.put_line('p0');
P_CANTIDADES_ORDENCOMPRA_PR(izNum_Orden_Ref, izhNumLineaRef);
dbms_output.put_line('p1');
---------------------------------------------------------------------------------------------
-- Obtiene Datos del Cursor    ,
---------------------------------------------------------------------------------------------
FOR rReg IN c_series_temp(izNum_Orden_Ref, IN_Ordening,IN_NumLinea)
 LOOP
 EXIT WHEN c_series_temp%NOTFOUND;

--       szAKEy := rReg.A_KEY;
--       szChkDigits := rReg.CHK_DIGITS;
--       szNumSecLoca := rReg.NUM_SEC_LOCA;
      szSerie := rReg.NUM_SERIE;
      TI_Ind_Telefono  :=rReg.Ind_Telefono;
      sTelefonoFic     :=rReg.TelefonoFic;
      sTelefonoTemp    :=rReg.TelefonoTemp;
      TN_Central       :=rReg.Cod_Central;
      TN_Subalm        :=rReg.Cod_Subalm;
      TN_CodCat           :=rReg.Cod_Cat;
      IF  sTelefonoFic <> sTelefonoTemp THEN
            P_INSERTA_ERROR_PR(IN_Ordening,IN_NumLinea,szSerie,11);
      ELSE
          BEGIN
              V_GLOSA_ERROR := 'Llamada al PL Valida_Tipo_Serie ';
              SerieError := szSerie;
              P_VALIDA_SERIE_PR (IN_Ordening,IN_NumLinea,szSerie, szTipo_terminal, szCod_Hlr, bzSalida, izError,IN_OrdenGsm);
          END;
      END IF;
 END LOOP;
--******************************************************************************************************************
-- AL SALIR DEL CURSOR VERIFICO QUE LAS SERIES NO TENGAN ERROR ... VEO LO SIGUIENTE. --->
-- PRIMERO  REVISO SI EXISTEN ERRORES, SI NO HAY DEVUELVE BRET = FALSE, SI ES ASI INGRESA TODAS LAS SERIE,
-- SI DEVUELVE BRET  =TRUE ES QUE ENCONTRO ERRORES, HAY QUE VOLVER AL USUARIO A PREGUNTAR QUE DESEA HACER
--  Solo si IN_Flag = 1 hago la validacion de errores y el ingreso cantidades ..



IF IN_Flag = 1 THEN

        --dbms_output.put_line('p4 IN_Ordening:'||IN_Ordening);
        P_EXISTEN_ERRORES_PR(IN_Ordening, izhNumLineaRef, bRet );
        -- dbms_output.put_line('p5  dNuevasPermitidas:'||dNuevasPermitidas );
        -- dbms_output.put_line('p6  dPendientesAsp:'||dPendientesAsp);
        -- dbms_output.put_line('p7  dIngresadasAsp:'||dIngresadasAsp);
        -- dbms_output.put_line('p8  dSeriesIngresadas:'||dSeriesIngresadas);
        -- dbms_output.put_line('p9  dSeriesServidas:'||dSeriesServidas);
        -- dbms_output.put_line('p10 dSeriesTotalOC:'||dSeriesTotalOC);
        v_tipo_archivo :=1; -- revisar.

        --******************************************************************************************************************
        IF NOT bRet THEN --  Entonces no existen errores, vamos con el ingreso.
           P_INGRESA_SERIES_PR(IN_Ordening, IN_NumLinea,IN_OrdenGsm);
        ELSE
            RETURN;
        END IF;
ELSE
    RETURN;
END IF;

-- llamar pl de ingreso con oc, linea compra y solicitud simcard

-- EXCEPTION
--      WHEN ERROR_PROCESO_GENERAL THEN
--         --  Inserta_Error(IN_Ordening, IN_NumLinea, SerieError, izError);
--           RAISE_APPLICATION_ERROR (-20001,V_GLOSA_ERROR );
--      WHEN NO_DATA_FOUND THEN
--           -- Inserta_Error(IN_Ordening, IN_NumLinea, SerieError, izError);
--           RAISE_APPLICATION_ERROR (-20001,V_GLOSA_ERROR );
--      WHEN OTHERS THEN
--         --  Inserta_Error(IN_Ordening, IN_NumLinea, SerieError, izError);
--           RAISE_APPLICATION_ERROR (-20002,'IngresoMercaderia '||'-'||SQLERRM,TRUE);

END P_TRATA_INGRESO_PR;
--
PROCEDURE P_INSERTA_ERROR_PR(
IN_Ordening IN al_cabecera_ordenes.num_orden%TYPE,
IN_NumLinea   IN AL_LINEAS_ORDENES.NUM_LINEA%TYPE,
IV_NumSerie    IN AL_SERIES_ORDENES2.NUM_SERIE%TYPE,
iError        IN NUMBER  ) IS

Error_Proceso_General  EXCEPTION;
V_GLOSA_ERROR          VARCHAR2(70);
iCodTransaccion integer :=1;


BEGIN

            UPDATE al_ingresoseriestemp_to a
            SET    a.cod_error = iError
            WHERE  a.cod_transaccion = iCodTransaccion
            AND    a.num_subproceso =   IN_Ordening
            AND    a.num_linea =   IN_NumLinea
            AND    a.num_serie =   IV_NumSerie;



EXCEPTION
     WHEN NO_DATA_FOUND THEN
          RAISE_APPLICATION_ERROR (-20001,V_GLOSA_ERROR );
     WHEN OTHERS THEN
          RAISE_APPLICATION_ERROR (-20002,'INSERTA_ERROR '||'-'||SQLERRM,TRUE);
END P_INSERTA_ERROR_PR;
--

PROCEDURE P_INSERTA_SERIES_PR (
IN_Ordening     IN al_cabecera_ordenes.num_orden%TYPE,
IN_NumLinea     IN AL_LINEAS_ORDENES.num_linea%TYPE,
IV_NumSerie     IN AL_SERIES_ORDENES2.num_serie%TYPE,
IV_Hlr             IN AL_SERIES_ORDENES2.cod_hlr%TYPE,
IV_aKey         IN AL_SERIES_ORDENES2.a_key%TYPE,
IV_ChkDigits    IN AL_SERIES_ORDENES2.chk_digits%TYPE,
IV_NumSublock   IN AL_SERIES_ORDENES2.num_sublock%TYPE,
IN_Ind_Telefono IN AL_SERIES_ORDENES2.ind_telefono%TYPE,
IN_NumTelefono  IN AL_SERIES_ORDENES2.num_telefono%TYPE,
TN_Central      IN AL_SERIES_ORDENES2.cod_central%TYPE,
TN_Subalm       IN AL_SERIES_ORDENES2.cod_subalm%TYPE,
TN_CodCat       IN AL_SERIES_ORDENES2.cod_cat%TYPE,
IN_tipo_archivo IN AL_INGRESOSERIESTEMP_TO.hexadecimal%TYPE)
IS

     Error_Proceso_General  EXCEPTION;
     V_GLOSA_ERROR          VARCHAR2(70);
     szv_serie_hex            AL_SERIES_ORDENES2.NUM_SERIE%TYPE;
     szSinError             VARCHAR2(2) := '0';
     iTipo                     INTEGER :=2;
 -- inicio

BEGIN
    IF IV_NumSerie IS NULL OR IV_NumSerie = '' THEN
            V_GLOSA_ERROR := 'ERROR Ingreso de Mercaderia: Parametro de entrada, serie';
            RAISE ERROR_PROCESO_GENERAL;
    END IF;

    IF IN_tipo_archivo IS NULL  THEN
            V_GLOSA_ERROR := 'ERROR Ingreso de Mercaderia: Parametro de entrada, tipo archivo';
            RAISE ERROR_PROCESO_GENERAL;
    END IF;


        IF (IN_tipo_archivo = 0) THEN




               INSERT INTO al_series_ordenes2 (
                    num_orden, tip_orden, num_linea,
                    num_serie, cod_producto, cod_hlr, ind_telefono,
                    a_key, chk_digits, num_sublock,
                    num_telefono, cod_central, cod_subalm, cod_cat)
            VALUES (IN_Ordening, iTipo, IN_NumLinea,
                    IV_NumSerie, 1, IV_Hlr, IN_Ind_Telefono,
                    IV_aKey, IV_ChkDigits, IV_NumSublock,
                    IN_NumTelefono, TN_Central, TN_Subalm, TN_CodCat);

            IF IV_aKey IS NULL OR IV_aKey = '' THEN

                    P_TRANSFORMA_HEXA(IV_NumSerie, szv_serie_hex);
                    IF szv_serie_hex IS NULL OR szv_serie_hex = '' THEN
                       V_GLOSA_ERROR := 'ERROR Error en transformar serie a hexadecimal';
                       RAISE ERROR_PROCESO_GENERAL;
                    END IF;


                    BEGIN
                        INSERT INTO ICT_AKEYS(
                                       NUM_ESN, COD_CLAVE, A_KEY_CRYP,
                                    CHK_DIGITS, PRIMER_CODIGO, SEGUNDO_CODIGO,
                                    ID_CARGA, FEC_ACTUALIZACION, COD_ESTADO, NUM_ESN_HEX)
                        VALUES (IV_NumSerie, NULL,IV_aKey,
                                IV_ChkDigits, IV_NumSublock, NULL,-1,  SYSDATE, 2,szv_serie_hex);
                    EXCEPTION
                        WHEN DUP_VAL_ON_INDEX THEN
                             --v_salida := 1;
                              P_INSERTA_ERROR_PR(IN_Ordening,IN_NumLinea,IV_NumSerie,9);
                             RETURN;
                         WHEN OTHERS THEN
                             --v_salida := 1;
                              P_INSERTA_ERROR_PR(IN_Ordening,IN_NumLinea,IV_NumSerie,10);
                             RETURN;
                    END;

            END IF;

        ELSE


                    INSERT INTO al_series_ordenes2 (
                                   num_orden, tip_orden, num_linea,
                                num_serie, cod_producto, cod_hlr, ind_telefono,
                                a_key, chk_digits, num_sublock,
                                num_telefono, cod_central, cod_subalm, cod_cat)
                    VALUES (IN_Ordening, 2, IN_NumLinea,
                            IV_NumSerie, 1, IV_Hlr,IN_Ind_Telefono,
                            IV_aKey, IV_ChkDigits, IV_NumSublock,
                            IN_NumTelefono, TN_Central, TN_Subalm, TN_CodCat);

                    IF length(IV_NumSerie) > 18   THEN
                              V_GLOSA_ERROR := 'Error en Update que cambia de estado a PI de la Simcard';
                            UPDATE GSM_SIMCARD_TO
                            SET COD_MODULO    = 'AL',
                                COD_ESTADO    = 'PI',
                                FEC_ACTUALIZACION = SYSDATE
                            WHERE NUM_SIMCARD = IV_NumSerie;
                    END IF;

--                     v_tipo_archivo := 0;
--                   IF NOT(szAKEy IS NULL OR szAKEy = '') THEN
--                      v_tipo_archivo := 1;
--                   END IF;
--
--                   bzSalida := 0;
--                   IF szCod_Hlr = '' THEN
--                         szCod_Hlr:= NULL;
--                   END IF;
          -- revisar


        END IF;

        BEGIN
            UPDATE al_fic_series  a
               SET   a.num_orden_ing = IN_Ordening,
                     a.num_linea_ing = IN_NumLinea
               WHERE a.num_orden = izNum_Orden_Ref
            and   a.num_linea = izhNumLineaRef
            AND   a.num_serie = IV_NumSerie;
        EXCEPTION
                  WHEN NO_DATA_FOUND THEN
                  NULL;
        END;


 EXCEPTION
     WHEN ERROR_PROCESO_GENERAL THEN
          RAISE_APPLICATION_ERROR (-20001,V_GLOSA_ERROR );
     WHEN NO_DATA_FOUND THEN

          RAISE_APPLICATION_ERROR (-20001,V_GLOSA_ERROR );
     WHEN OTHERS THEN
          RAISE_APPLICATION_ERROR (-20002,'IngresoMercaderia '||'-'||SQLERRM,TRUE);
END P_INSERTA_SERIES_PR;
--
PROCEDURE P_VALIDA_SERIE_PR
(
IN_Ordening IN al_cabecera_ordenes.num_orden%TYPE,
IN_NumLinea IN al_lineas_ordenes.num_linea%TYPE,
v_Serie     IN AL_SERIES_ORDENES2.NUM_SERIE%TYPE,
v_Terminal  IN AL_ARTICULOS.TIP_TERMINAL%TYPE,
szCod_Hlr   OUT GSM_SIMCARD_TO.COD_HLR%TYPE,
v_salida    OUT PLS_INTEGER,
izError     OUT AL_ERRORES_TEMP_TO.COD_ERROR%TYPE,
IN_OrdenGsm IN gsm_cabsol_simcard_to.num_seq_solicitud%TYPE DEFAULT NULL)IS

-- INICIO
     Error_Proceso_General  EXCEPTION;
     V_GLOSA_ERROR          VARCHAR2(70);
     szNumSinDigito          AL_SERIES_ORDENES2.NUM_SERIE%TYPE;
     izNumDigito            NUMBER(3);
     izfinal1               NUMBER(3);
     szOutTmp               VARCHAR2(3);
     iz3Dig                 NUMBER(4);
     iz8Dig                 NUMBER(10);
     ilargo                 NUMBER(10);
     iExiste                PLS_INTEGER;

ln_maxmov           al_movimientos.num_movimiento%type;
ln_bodegao          AL_cabecera_ordenes.cod_bodega%type;
ln_articuloo        AL_LINEAS_ORDENES.cod_articulo%type;
ln_tipstocko        AL_LINEAS_ORDENES.tip_stock%type;
ln_codusoo          AL_LINEAS_ORDENES.cod_uso%type;
ln_cod_bodega       al_movimientos.cod_bodega%type;
ln_cod_articulo     al_movimientos.cod_articulo%TYPE;
ln_tip_stock        al_movimientos.tip_stock%type;
ln_cod_uso          al_movimientos.cod_uso%type;
lv_valparam         ged_parametros.val_parametro%type;


---------------------------------------------------------------------------------------------
-- INICIO DEL PROCESO
---------------------------------------------------------------------------------------------

BEGIN

   v_salida := 0;

   lv_valparam:='N';
   begin 
      select trim(val_parametro) into lv_valparam 
        from ged_parametros 
        where nom_parametro='VALIDA_ATRIBINGMERC' and 
              cod_modulo='AL' and cod_producto=1;
   exception
   when others then
        lv_valparam:='N';
   end;   
               
--***********************************************************
-- VALIDACIONES DE CANTIDADES DE SERIES
--***********************************************************
 IF dNuevasPermitidas > 0 THEN
     IF dPendientesASP > 0 THEN
       IF bExisteALFICSERIES(izNum_Orden_Ref,izhNumLineaRef, v_serie ) THEN
             -- Serie buena , restar dPendientesASP  = dPendientesASP  -1
          dPendientesASP  := dPendientesASP  -1;
       ELSE
       --***********************************************************
       -- INICIO VALIDACIONES POR EXISTENCIA
       --***********************************************************
           BEGIN
                   P_AL_COMPSERIES (v_serie,'FRMCREAORDING');
                   EXCEPTION
                        WHEN OTHERS THEN
                     -- GRABA ERROR "SERIE EXISTE EN EL SISTEMA"
                     P_INSERTA_ERROR_PR(IN_Ordening,IN_NumLinea,v_serie,1);
                     RETURN;
           END;
              BEGIN
            --*********************************************
            --INICIO VALIDACIONES POR FORMATO,LARGO , ETC.
            --*********************************************
                IF  v_Terminal = 'G' THEN
                        -- Debo validar que pertenezcan a la solicitud ingresada ..
                           BEGIN
                              SELECT 1
                            INTO   iExiste
                            FROM   gsm_simcard_to b
                            WHERE  b.num_simcard = v_serie
                            AND    b.num_seq_solicitud =IN_OrdenGsm;
                        EXCEPTION
                            WHEN NO_DATA_FOUND THEN
                                P_INSERTA_ERROR_PR(IN_Ordening,IN_NumLinea, v_serie, 5);
                                v_salida := 1;
                                RETURN;
                            WHEN TOO_MANY_ROWS THEN
                                P_INSERTA_ERROR_PR(IN_Ordening,IN_NumLinea, v_serie, 6);
                                v_salida := 1;
                                RETURN;
                            WHEN OTHERS THEN
                                P_INSERTA_ERROR_PR(IN_Ordening,IN_NumLinea, v_serie, 7);
                                v_salida := 1;
                                RETURN;
                        END;
                --
                        BEGIN
                            SELECT b.cod_hlr
                            INTO   szCod_Hlr
                            FROM   gsm_simcard_to b
                            WHERE  b.num_simcard = v_serie
                            AND    b.num_seq_solicitud =IN_OrdenGsm;
                        EXCEPTION
                            WHEN OTHERS THEN
                                P_INSERTA_ERROR_PR(IN_Ordening,IN_NumLinea, v_serie, 8);
                                v_salida := 1;
                                RETURN;
                        END;
            -- Fin validaciones para terminales "G"
                END IF;

                IF  v_Terminal = 'T' THEN

                        szNumSinDigito := substr(v_serie, 0, length(v_Serie) - 1);
                        izfinal1 := length(v_Serie);
                        izNumDigito := to_number(substr(v_serie, izfinal1, length(v_Serie)));

                        izError := 7;
                        SELECT  ge_fn_luhn(szNumSinDigito)
                        INTO szOutTmp
                        FROM dual;
                        IF     izNumDigito <> to_number(szOutTmp) THEN
                            P_INSERTA_ERROR_PR(IN_Ordening,IN_NumLinea, v_serie, 3);
                            v_salida := 1;
                            RETURN;
                        END IF;
                END IF;


                IF  v_Terminal = 'D' THEN

                    iz3Dig := to_number(substr(v_serie, 0, 3));
                    IF (iz3Dig < 256) THEN
                        ilargo := length(v_Serie) - 7;
                        iz8Dig := to_number(substr(v_serie, ilargo, 8));
                        IF (iz8Dig > 16777216) THEN
                            P_INSERTA_ERROR_PR(IN_Ordening,IN_NumLinea, v_serie, 4);
                            v_salida := 1;
                            RETURN;
                        END IF;
                    END IF;
                END IF;
                --*********************************************
                -- FIN VALIDACION DE FORMATO LARGO Y EXISTENCIA
                --*********************************************
               if lv_valparam='S' then
                   --atributos de la orden de ingreso...... .
                    ln_bodegao:=null;
                    ln_articuloo:=null;
                    ln_tipstocko:=null;
                    ln_codusoo:=null;
                    begin
                        select b.cod_bodega,a.cod_articulo,a.tip_stock, a.cod_uso
                          into ln_bodegao,ln_articuloo,ln_tipstocko,ln_codusoo
                          from AL_VLINEAS_ORDENES a, AL_VCABECERA_ORDENES b
                        where a.num_orden =IN_Ordening
                          and a.tip_orden = 2
                          and a.num_orden = b.num_orden
                          and a.tip_orden = b.tip_orden
                          and a.num_linea = IN_NumLinea;
                   exception
                   when others then
                        null;
                   end;

                   --ultimo movimiento de inventario para la serie....
                   ln_maxmov:=0;
                   select max(a.num_movimiento) into  ln_maxmov from al_movimientos a
                    where a.num_movimiento > 0  and a.num_serie = v_serie;

                   if ln_maxmov <>0 then
                      ln_cod_bodega:=NULL;
                      ln_cod_articulo:=NULL;
                      ln_tip_stock:=null;
                      ln_cod_uso:=null;
                      begin
                          select a.cod_bodega, a.cod_articulo,a.tip_stock,a.cod_uso
                            into ln_cod_bodega, ln_cod_articulo, ln_tip_stock, ln_cod_uso
                            from al_movimientos a
                           where a.num_movimiento = ln_maxmov;
                      exception
                      when others then
                              null;
                      end;

                      if ln_cod_bodega <> ln_bodegao OR
                         ln_cod_articulo <>  ln_articuloo OR
                         ln_tip_stock <> ln_tipstocko OR
                         ln_cod_uso <> ln_codusoo then

                         P_INSERTA_ERROR_PR(IN_Ordening,IN_NumLinea, v_serie, 13);
                         v_salida := 1;
                         RETURN;
                      end if;
                   end if;
                 end if;
               dNuevasPermitidas  := dNuevasPermitidas  -1;
            END;
       END IF;
    ELSE
                -- kkk
       --***********************************************************
       -- INICIO VALIDACIONES POR EXISTENCIA
       --***********************************************************
           BEGIN
                   P_AL_COMPSERIES (v_serie,'FRMCREAORDING');
                   EXCEPTION
                        WHEN OTHERS THEN
                     -- GRABA ERROR "SERIE EXISTE EN EL SISTEMA"
                     P_INSERTA_ERROR_PR(IN_Ordening,IN_NumLinea,v_serie,1);
                     RETURN;
           END;
        --*********************************************
            --INICIO VALIDACIONES POR FORMATO,LARGO , ETC.
            --*********************************************
                IF  v_Terminal = 'G' THEN
                        -- Debo validar que pertenezcan a la solicitud ingresada ..
                           BEGIN
                              SELECT 1
                            INTO   iExiste
                            FROM   gsm_simcard_to b
                            WHERE  b.num_simcard = v_serie
                            AND    b.num_seq_solicitud =IN_OrdenGsm;
                        EXCEPTION
                            WHEN NO_DATA_FOUND THEN
                                P_INSERTA_ERROR_PR(IN_Ordening,IN_NumLinea, v_serie, 5);
                                v_salida := 1;
                                RETURN;
                            WHEN TOO_MANY_ROWS THEN
                                P_INSERTA_ERROR_PR(IN_Ordening,IN_NumLinea, v_serie, 6);
                                v_salida := 1;
                                RETURN;
                            WHEN OTHERS THEN
                                P_INSERTA_ERROR_PR(IN_Ordening,IN_NumLinea, v_serie, 7);
                                v_salida := 1;
                                RETURN;
                        END;
                --
                        BEGIN
                            SELECT b.cod_hlr
                            INTO   szCod_Hlr
                            FROM   gsm_simcard_to b
                            WHERE  b.num_simcard = v_serie
                            AND    b.num_seq_solicitud =IN_OrdenGsm;
                        EXCEPTION
                            WHEN OTHERS THEN
                                P_INSERTA_ERROR_PR(IN_Ordening,IN_NumLinea, v_serie, 8);
                                v_salida := 1;
                                RETURN;
                        END;
            -- Fin validaciones para terminales "G"
                END IF;

                IF  v_Terminal = 'T' THEN

                        szNumSinDigito := substr(v_serie, 0, length(v_Serie) - 1);
                        izfinal1 := length(v_Serie);
                        izNumDigito := to_number(substr(v_serie, izfinal1, length(v_Serie)));

                        izError := 7;
                        SELECT  ge_fn_luhn(szNumSinDigito)
                        INTO szOutTmp
                        FROM dual;
                        IF     izNumDigito <> to_number(szOutTmp) THEN
                            P_INSERTA_ERROR_PR(IN_Ordening,IN_NumLinea, v_serie, 3);
                            v_salida := 1;
                            RETURN;
                        END IF;
                END IF;


                IF  v_Terminal = 'N' THEN

                    iz3Dig := to_number(substr(v_serie, 0, 2));
                    IF (iz3Dig < 256) THEN
                        ilargo := length(v_Serie) - 8;
                        iz8Dig := to_number(substr(v_serie, ilargo, 8));
                        IF (iz8Dig > 16777216) THEN
                            P_INSERTA_ERROR_PR(IN_Ordening,IN_NumLinea, v_serie, 4);
                            v_salida := 1;
                            RETURN;
                        END IF;
                    END IF;
                END IF;
                --*********************************************
                -- FIN VALIDACION DE FORMATO LARGO Y EXISTENCIA
                --*********************************************

        
               
               if lv_valparam='S' then
                --validar artributos ultimo movimiento de inventario...
               --atributos de la orden de ingreso...... .
                ln_bodegao:=null;
                ln_articuloo:=null;
                ln_tipstocko:=null;
                ln_codusoo:=null;
                begin
                    select b.cod_bodega,a.cod_articulo,a.tip_stock, a.cod_uso
                      into ln_bodegao,ln_articuloo,ln_tipstocko,ln_codusoo
                      from AL_VLINEAS_ORDENES a, AL_VCABECERA_ORDENES b
                    where a.num_orden =IN_Ordening
                      and a.tip_orden = 2
                      and a.num_orden = b.num_orden
                      and a.tip_orden = b.tip_orden
                      and a.num_linea = IN_NumLinea;
               exception
               when others then
                    null;
               end;

               --ultimo movimiento de inventario para la serie....
               ln_maxmov:=0;
               select max(a.num_movimiento) into  ln_maxmov from al_movimientos a
                where a.num_movimiento > 0  and a.num_serie = v_serie;

               if ln_maxmov <>0 then
                  ln_cod_bodega:=NULL;
                  ln_cod_articulo:=NULL;
                  ln_tip_stock:=null;
                  ln_cod_uso:=null;
                  begin
                      select a.cod_bodega, a.cod_articulo,a.tip_stock,a.cod_uso
                        into ln_cod_bodega, ln_cod_articulo, ln_tip_stock, ln_cod_uso
                        from al_movimientos a
                       where a.num_movimiento = ln_maxmov;
                  exception
                  when others then
                          null;
                  end;

                  if ln_cod_bodega <> ln_bodegao OR
                     ln_cod_articulo <>  ln_articuloo OR
                     ln_tip_stock <> ln_tipstocko OR
                     ln_cod_uso <> ln_codusoo then

                     P_INSERTA_ERROR_PR(IN_Ordening,IN_NumLinea, v_serie, 13);
                     v_salida := 1;
                     RETURN;
                  end if;
               end if;

                ---
              END IF;
              dNuevasPermitidas  := dNuevasPermitidas  -1;
 
        NULL;
    END IF    ;

 ELSE
   IF dPendientesASP > 0 THEN
         IF  bExisteALFICSERIES(izNum_Orden_Ref,izhNumLineaRef, v_serie ) THEN
             -- Serie buena , restar dPendientesASP  = dPendientesASP  -1
          dPendientesASP  := dPendientesASP  -1 ;
      ELSE
              P_INSERTA_ERROR_PR(IN_Ordening,IN_NumLinea, v_serie, 12);
         v_salida := 1;
         RETURN;
      END IF;
   END IF;
 END IF;

--***********************************************************
-- FIN VALIDACIONES DE CANTIDADES DE SERIES
--***********************************************************


EXCEPTION
    WHEN ERROR_PROCESO_GENERAL THEN
         v_salida := 1;
         RAISE_APPLICATION_ERROR (-20001,V_GLOSA_ERROR );
    WHEN NO_DATA_FOUND THEN
         v_salida := 1;
         RAISE_APPLICATION_ERROR (-20001,V_GLOSA_ERROR );
    WHEN OTHERS THEN
         v_salida := 1;
         RAISE_APPLICATION_ERROR (-20002,'IngresoMercaderia '||'-'||SQLERRM,TRUE);

END P_VALIDA_SERIE_PR;
--
PROCEDURE P_EXISTEN_ERRORES_PR
(
IN_Ordening IN al_cabecera_ordenes.num_orden%TYPE,
IN_NumLinea IN al_lineas_ordenes.num_linea%TYPE,
bRet          IN OUT  boolean) IS
dCountError number ;
BEGIN

bRet          := FALSE ;

--**************************************
-- CUENTO LOS ERRORES DE LA TABLA
--**************************************
SELECT count(1)
INTO   dCountError
FROM   al_ingresoseriestemp_to temp
WHERE  temp.num_subproceso =   IN_Ordening
AND    temp.num_linea = IN_NumLinea
AND    temp.cod_error <> 0;

--****************************************************************************
--SI NO HAY ERRORES MANDO BRET EN TRUE , SI HAY ERRORES LO MANDO EN FALSE
--****************************************************************************

IF  dCountError = 0 THEN
     dbms_output.put_line('bRet := FALSE: '||dCountError||' Errores encontrados');
     bRet := FALSE;
ELSE
     bRet := TRUE;
     dbms_output.put_line('bRet := TRUE: '||dCountError||' Errores encontrados');
END IF;

EXCEPTION
         WHEN OTHERS THEN
               RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END P_EXISTEN_ERRORES_PR;
--
PROCEDURE P_CANTIDADES_ORDENCOMPRA_PR
(
IN_OrdenCompra IN al_cabecera_ordenes.num_orden%TYPE,
IN_NumLineaOC IN al_lineas_ordenes.num_linea%TYPE
) IS
/*
dSeriesTotalOC       al_lineas_ordenes2.can_orden%type;
dSeriesServidas  al_lineas_ordenes1.can_servida%type;
dSeriesIngresadas  al_lineas_ordenes2.can_orden%type;
dIngresadasAsp     al_lineas_ordenes2.can_orden%type;
dPendientesAsp     al_lineas_ordenes2.can_orden%type;
dNuevasPermitidas  al_lineas_ordenes2.can_orden%type;
*/
BEGIN
--**************************************************************************
--SERIES PENDIENTES DE INGRESO DE AL_FIC_SERIES
--**************************************************************************
SELECT COUNT (1) series_asp_pdtes
INTO   dPendientesASp
FROM   al_fic_series a
WHERE  a.num_orden =  IN_OrdenCompra
AND    a.num_linea = IN_NumLineaOC
AND    a.num_orden_ing IS  NULL
AND    a.num_linea_ing IS  NULL;
--**************************************************************************
--SERIES YA INGRESADAS DE AL_FIC_SERIES
--**************************************************************************
SELECT COUNT (1) series_asp_ingresadas
INTO   dIngresadasAsp
FROM   AL_FIC_SERIES a
WHERE  a.num_orden =  IN_OrdenCompra
AND    a.num_linea =  IN_NumLineaOC
AND    a.num_orden_ing IS NOT NULL
AND    a.num_linea_ing IS NOT NULL;
--**************************************************************************
-- SERIES PENDIENTES DE INGRESO EN ORDENES DE INGRESO PARA ORDENES DE COMPRA
--**************************************************************************
SELECT COUNT (a.num_serie) series_ingresadas
INTO   dSeriesIngresadas
FROM   AL_SERIES_ORDENES2 a, AL_CABECERA_ORDENES2 b
WHERE  b.num_orden_ref = IN_OrdenCompra
AND    a.num_linea = IN_NumLineaOC
AND    a.num_orden = b.num_orden
AND    b.cod_estado <> 'CE';
--**************************************************************************
-- SERIES SERIVIDAS (EN AL_SERIES) PARA ORDENES DE COMPRA
--**************************************************************************
SELECT NVL (a.can_servida, 0)
INTO   dSeriesServidas
FROM   AL_LINEAS_ORDENES1 a
WHERE  a.num_orden = IN_OrdenCompra
AND    a.num_linea = IN_NumLineaOC;
--**************************************************************************
-- SERIES TOTAL DE LA ORDENES DE COMPRA
--**************************************************************************
SELECT NVL (a.can_orden, 0)
INTO   dSeriesTotalOC
FROM   AL_LINEAS_ORDENES1 a
WHERE  a.num_orden = IN_OrdenCompra
AND    a.num_linea = IN_NumLineaOC;

dNuevasPermitidas := dSeriesTotalOC - dPendientesASp -  dSeriesIngresadas - dSeriesServidas;

END P_CANTIDADES_ORDENCOMPRA_PR ;
--
FUNCTION bExisteALFICSERIES
(
IN_OrdenCompra IN al_cabecera_ordenes.num_orden%TYPE,
IN_NumLineaOC  IN al_lineas_ordenes.num_linea%TYPE,
IV_Num_serie   IN al_series_ordenes.num_serie%TYPE
) RETURN BOOLEAN IS
v_Serie al_fic_series.num_Serie%type;
BEGIN
--
  SELECT fic.num_Serie
  INTO   v_Serie
  FROM   al_fic_series fic
  WHERE  fic.num_orden   = IN_OrdenCompra
  AND    fic.num_linea = IN_NumLineaOC
  AND    fic.num_Serie = IV_Num_serie;

--***************************************
-- LA ENCONTRO, RETORNO VERDADERO
--***************************************
RETURN TRUE;

EXCEPTION
         WHEN NO_DATA_FOUND THEN
        --***************************************
        -- NO LA ENCONTRO, RETORNO FALSE
        --***************************************
               RETURN FALSE;
END bExisteALFICSERIES;
--
PROCEDURE P_INGRESA_SERIES_PR
(
IN_Ordening IN al_cabecera_ordenes.num_orden%TYPE,
IN_NumLinea IN al_lineas_ordenes.num_linea%TYPE,
IN_OrdenGsm IN gsm_cabsol_simcard_to.num_seq_solicitud%TYPE DEFAULT NULL,
IN_Flag     IN PLS_INTEGER DEFAULT 1)IS

BEGIN

   BEGIN
         FOR rReg IN c_series_ok(izNum_Orden_Ref, IN_Ordening,IN_NumLinea) --
         --******************************************************************************************************************
         -- OTRA VEZ ABRO EL MISMO CURSOR....REVISAR....
         --******************************************************************************************************************
         LOOP
         EXIT WHEN c_series_ok%NOTFOUND;

             P_INSERTA_SERIES_PR(IN_Ordening,  IN_NumLinea, rReg.NUM_SERIE, szCod_Hlr, NULL, NULL,NULL,
              rReg.Ind_Telefono, rReg.TelefonoFic,rReg.Cod_Central, rReg.Cod_Subalm, rReg.Cod_Cat ,v_tipo_archivo);

         END LOOP;
   END;




END P_INGRESA_SERIES_PR;
--
END AL_INGRESOMERCADERIA_CLS_PG;
/
SHOW ERRORS