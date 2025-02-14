CREATE OR REPLACE PACKAGE BODY Ic_Pkg_Parametros AS

/*
<NOMBRE>       : Ic_Pkg_Parametros</NOMBRE>
<FECHACREA>    : <FECHACREA/>
<MODULO >      : IC</MODULO >
<AUTOR >       : ANONIMO</AUTOR >
<VERSION >     : 1.0</VERSION >
<DESCRIPCION>  : Parametros Interfaz con Centrales</DESCRIPCION>
<FECHAMOD >    : 16/05/2006 </FECHAMOD >
<DESCMOD >     : Se modifica funcion FN_TMC_IMSI Incidencia CO-200605160139
                 Realizado por Maria Lorena Rojo</DESCMOD>
<VERSIONMOD >  : 1.1</VERSION >
<FECHAMOD >    : 12/10 /2006 </FECHAMOD >
<DESCMOD >     : Se realiza rectificación de código removiendo lo realizado en la Incidencia CO-200605160139
                 Realizado por Maria Lorena Rojo</DESCMOD>
<VERSIONMOD >  : 1.2</VERSION >
<FECHAMOD >    : 07/11/2006 </FECHAMOD >
<DESCMOD >     : Se crea función FN_COD_SUBALM Incidencia 34848
                 Realizado por Maria Lorena Rojo</DESCMOD>
<VERSIONMOD >  : 1.3</VERSION >
<FECHAMOD >    : 09/11/2006 </FECHAMOD >
<DESCMOD >     : Se modifica función FN_TMM_GE_PREFIJONIR Incidencia 34848
                 Realizado por Maria Lorena Rojo</DESCMOD>
<VERSIONMOD >  : 1.4</VERSION >
<FECHAMOD >    : 20/02/2007 </FECHAMOD >
<DESCMOD >     : Se modifica función IC_ValidaServicio_FN Incidencia 36689
                 Realizado por Maria Lorena Rojo</DESCMOD>

<VERSIONMOD >  : 1.5</VERSION >
<FECHAMOD >    : 15/05/2007 </FECHAMOD >
<DESCMOD >     : Se crea función FN_COL_MTONETBRUT_FN Incidencia 40572
                 Funcion que retorne monto neto o bruto del campo icc_movimiento.carga
                 Cuando el campo ICC_MOVIMIENTO.CARGA = 0 adopte el valor 1</DESCMOD>

<VERSIONMOD >  : 1.6</VERSION >
<FECHAMOD >    : 31/07/2007 </FECHAMOD >
<DESCMOD >     : Se modifica la función IC_ImporteRec_FN Inc 42590
                 Funcion encargada de obtener el valor del cargo básico para el servicio de recarga periodica
                 Se modifica la función IC_FechaEjec_FN Inc 42590
                 Funcion encargada de obtener la fecha de corte + 1 o de la primera ejecución
</DESCMOD>

<VERSIONMOD >  : 1.7</VERSION >
<FECHAMOD >    : 10/04/2008 </FECHAMOD >
<DESCMOD >     : Se modifica la función IC_ImporteRec_FN Inc 64502
                 Funcion encargada de obtener el valor del cargo básico para el servicio de recarga periodica
                 La modificacion consiste en identificar el movimiento generado como recarga de
                 Hibridos(por incidencia del Modulo de Post-Venta)
</DESCMOD>


<VERSIONMOD >  : 1.7</VERSION >
<FECHAMOD >    : 10/04/2008 </FECHAMOD >
<DESCMOD >     : Se crea nueva funcion IC_ImporteRec_Basic_FN
                 Funcion encargada de solo obtener el valor del cargo básico para el servicio de recarga periodica
</DESCMOD>



*/

----------------------------------------------------------------------------
-- F_GEN_GETMOV --
----------------------------------------------------------------------------
  FUNCTION FN_GEN_GETMOV(V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN ICC_MOVIMIENTO%ROWTYPE IS
    V_REG_MOV ICC_MOVIMIENTO%ROWTYPE;
    error_proceso EXCEPTION;
  BEGIN

        SELECT * INTO V_REG_MOV FROM ICC_MOVIMIENTO WHERE NUM_MOVIMIENTO=V_NUM_MOV;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        RETURN V_REG_MOV;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN V_REG_MOV;
    WHEN OTHERS THEN
      RETURN V_REG_MOV;
  END;

---------------------------------------------------------------------------
-- F_GEN_FVALDEF --
----------------------------------------------------------------------------
  FUNCTION FN_GEN_FVALDEF(v_par IN ICG_PARAMETRO.tip_parametro%TYPE, v_car IN CHAR, v_len IN NUMBER) RETURN STRING IS
    v_out STRING (512);
    error_proceso EXCEPTION;
        v_def_par ICG_PARAMETRO.def_parametro%TYPE;
  BEGIN

        SELECT def_parametro INTO v_def_par
        FROM ICG_PARAMETRO
        WHERE tip_parametro = v_par;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        IF SIGN(v_len) = -1 THEN
      v_out := LPAD(v_def_par, ABS(v_len), v_car);
        ELSE
          v_out := RPAD(v_def_par, v_len, v_car);
        END IF;

        RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_GEN_FDEFVAL, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_GEN_FDEFVAL, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
  END;

----------------------------------------------------------------------------
-- FN_RET_TRN --
----------------------------------------------------------------------------
  FUNCTION FN_RET_TRN(LN_num_trx IN ic_interfazsersupl_to.num_trx%TYPE, V_SERVTRN ic_interfazsersupl_to.cod_servicios%TYPE, V_SERVNUM icc_movimiento.cod_servicios%TYPE, V_nummov icc_movimiento.num_movimiento%TYPE) RETURN Varchar2 IS
    V_REG_MOV ICC_MOVIMIENTO%ROWTYPE;
    v_ser_tmp VARCHAR2(255);
    v_count int;
    v_cont int;
    v_len_ser int;
    v_ser_tmp2 VARCHAR2(255);
    v_cont2 int;
    v_len_ser2 int;
    v_transac ic_interfazsersupl_to.num_trx%TYPE;
    error_proceso EXCEPTION;
  BEGIN

   v_count:=0;

   select count(*)
   into v_count
   from icc_comproc
   where des_comando like '%BAJ%cadSec='||LN_num_trx||'%'
     and num_movimiento = V_nummov;

   IF SQLCODE <> 0 THEN
      RAISE error_proceso;
    END IF;

   v_len_ser := LENGTH(V_SERVNUM);
   v_cont:=1;
   WHILE v_cont < v_len_ser LOOP
      v_ser_tmp := SUBSTR(V_SERVNUM,v_cont,6);
               v_len_ser2:= LENGTH(V_SERVTRN);
               v_cont2:=1;
               WHILE v_cont2 < v_len_ser2 LOOP
               v_ser_tmp2 := SUBSTR(V_SERVTRN,v_cont2,6);
                 IF (SUBSTR(v_ser_tmp,3,4) = '0000') THEN
                   IF (SUBSTR(v_ser_tmp,1,2) = SUBSTR(v_ser_tmp2,1,2)) THEN
                        IF (v_count = 0) THEN
                            v_transac := LN_num_trx;
                        END IF;
                   END IF;
                 END IF;
                 v_cont2 := v_cont2+6;
               END LOOP;
      v_cont := v_cont+6;
   END LOOP;
   RETURN v_transac;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN v_transac;
    WHEN OTHERS THEN
      RETURN v_transac;
  END;



---------------------------------------------------------------------------
-- F_GEN_HEXTONUM --
----------------------------------------------------------------------------

FUNCTION FN_GEN_HexToNum(v_hex IN VARCHAR2) RETURN NUMBER IS
hex VARCHAR2(4);
num NUMBER;
num1 NUMBER;
num2 NUMBER;
num3 NUMBER;
num4 NUMBER;
num5 NUMBER;
num6 NUMBER;
iLargo NUMBER;

BEGIN

         hex := SUBSTRB(v_hex,1,1);
         iLargo := LENGTH(LTRIM(RTRIM(v_hex)));

         IF ( hex >= '0' AND hex <= '9' ) THEN
                num1 := TO_NUMBER(hex);
     END IF;
         IF hex = 'A' THEN num1 := 10; END IF;
         IF hex = 'B' THEN num1 := 11; END IF;
         IF hex = 'C' THEN num1 := 12; END IF;
         IF hex = 'D' THEN num1 := 13; END IF;
         IF hex = 'E' THEN num1 := 14; END IF;
         IF hex = 'F' THEN num1 := 15; END IF;
         hex := SUBSTRB(v_hex,2,1);
         IF ( hex >= '0' AND hex <= '9' ) THEN
                num2 := TO_NUMBER(hex);
         END IF;
         IF hex = 'A' THEN num2 := 10; END IF;
         IF hex = 'B' THEN num2 := 11; END IF;
         IF hex = 'C' THEN num2 := 12; END IF;
         IF hex = 'D' THEN num2 := 13; END IF;
         IF hex = 'E' THEN num2 := 14; END IF;
         IF hex = 'F' THEN num2 := 15; END IF;

         IF (iLargo =2) THEN
                 num := (num1*16)+num2;
             RETURN num;
         END IF;
         num1 := (num1*16*16*16*16*16);
         num2 := (num2*16*16*16*16);

         hex := SUBSTRB(v_hex,3,1);
         IF ( hex >= '0' AND hex <= '9' ) THEN
                num3 := TO_NUMBER(hex);
     END IF;
         IF hex = 'A' THEN num3 := 10; END IF;
         IF hex = 'B' THEN num3 := 11; END IF;
         IF hex = 'C' THEN num3 := 12; END IF;
         IF hex = 'D' THEN num3 := 13; END IF;
         IF hex = 'E' THEN num3 := 14; END IF;
         IF hex = 'F' THEN num3 := 15; END IF;

         num3 := (num3*16*16*16);

         hex := SUBSTRB(v_hex,4,1);
         IF ( hex >= '0' AND hex <= '9' ) THEN
                num4 := TO_NUMBER(hex);
         END IF;
         IF hex = 'A' THEN num4 := 10; END IF;
         IF hex = 'B' THEN num4 := 11; END IF;
         IF hex = 'C' THEN num4 := 12; END IF;
         IF hex = 'D' THEN num4 := 13; END IF;
         IF hex = 'E' THEN num4 := 14; END IF;
         IF hex = 'F' THEN num4 := 15; END IF;
         num4 := (num4*16*16);

         hex := SUBSTRB(v_hex,5,1);
         IF ( hex >= '0' AND hex <= '9' ) THEN
                num5 := TO_NUMBER(hex);
     END IF;
         IF hex = 'A' THEN num5 := 10; END IF;
         IF hex = 'B' THEN num5 := 11; END IF;
         IF hex = 'C' THEN num5 := 12; END IF;
         IF hex = 'D' THEN num5 := 13; END IF;
         IF hex = 'E' THEN num5 := 14; END IF;
         IF hex = 'F' THEN num5 := 15; END IF;
         num5 := (num5*16);

         hex := SUBSTRB(v_hex,6,1);
         IF ( hex >= '0' AND hex <= '9' ) THEN
                num6 := TO_NUMBER(hex);
         END IF;
         IF hex = 'A' THEN num6 := 10; END IF;
         IF hex = 'B' THEN num6 := 11; END IF;
         IF hex = 'C' THEN num6 := 12; END IF;
         IF hex = 'D' THEN num6 := 13; END IF;
         IF hex = 'E' THEN num6 := 14; END IF;
         IF hex = 'F' THEN num6 := 15; END IF;

         num := num1+num2+num3+num4+num5+num6;

         RETURN num;
END;

----------------------------------------------------------------------------
-- FN_EXTRA_TIEMPO --
----------------------------------------------------------------------------
FUNCTION FN_extra_tiempo (v_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING IS
        /* JGC 29/09/2006 MACOL-34287 */
        v_numcel VARCHAR2(100);
        v_codplan VARCHAR2(100);
        n_numabo NUMBER;

        n_cod_retorno NUMBER;
        v_men_retorno VARCHAR2(200);
        n_num_evento NUMBER;

        error_numcel EXCEPTION;
        error_codplan EXCEPTION;
        error_externo EXCEPTION;
/*
<Código de Incidencia>
   <Datos Incidencia="35369" Descripción="Se solicita eliminar prefijo 'EX' en busqueda de planes extra tiempo"></Datos>
   <Fecha Cambio="07/11/2006"></Fecha>
   <Programador Nombre="Robinson Andrés Soto Toloza"></Programador>
</Código de Incidencia>
*/
BEGIN
      -- INICIO incidencia 35468 María Lorena Rojo L. 13/11/2006 Se homologa función FN_extra_tiempo
        BEGIN
                SELECT num_celular, num_abonado
                INTO   v_numcel, n_numabo
                FROM   icc_movimiento
                WHERE  num_movimiento = v_num_mov;

        EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    RAISE error_numcel;
        END;

        BEGIN
                SELECT abo.cod_plantarif
                INTO   v_codplan
                FROM   ga_abocel abo
                WHERE  abo.num_abonado = n_numabo;

        EXCEPTION
                WHEN NO_DATA_FOUND THEN
                        BEGIN
                                SELECT abo.cod_plantarif
                                INTO   v_codplan
                                FROM   ga_aboamist abo
                                WHERE  abo.num_abonado = n_numabo;

                        EXCEPTION
                                WHEN NO_DATA_FOUND THEN
                                        RAISE error_codplan;
                        END;

                WHEN OTHERS THEN
                        RAISE error_codplan;
        END;

        -- v_codplan := 'EX' || v_codplan;  35369 -rast- 08/11/2006

        GA_Extra_Tiempo_PG.GA_Extratiempo_Contrato_PR(v_numcel, 0, v_codplan, n_cod_retorno, v_men_retorno, n_num_evento, 'IC');

        IF v_men_retorno <> '' THEN
            RAISE error_externo;
        END IF;

        RETURN 'OK';

EXCEPTION
        WHEN error_numcel THEN
                RETURN 'ERROR FN_EXTRA_TIEMPO: NO SE ENCONTRÓ NUM. CELULAR ASOCIADO AL MOVIMIENTO';

        WHEN error_codplan THEN
                RETURN 'ERROR FN_EXTRA_TIEMPO: NO SE ENCONTRÓ COD. PLAN ASOCIADO AL MOVIMIENTO';

        WHEN error_externo THEN
                RETURN 'ERROR GA_EXTRA_TIEMPO_PG.GA_EXTRATIEMPO_CONTRATO_PR ' || v_men_retorno;

        WHEN OTHERS THEN
                RETURN 'ERROR FN_EXTRA_TIEMPO, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
      -- FIN incidencia 35468 María Lorena Rojo L. 13/11/2006
END;

----------------------------------------------------------------------------
-- FN_TMC_NUMCEL --
----------------------------------------------------------------------------
  FUNCTION FN_TMC_numcel(v_num_mov IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
        v_num_cel VARCHAR2(512);
        v_num_cel_nue VARCHAR2(512);
    error_proceso EXCEPTION;
  BEGIN

    SELECT NVL(TO_CHAR(num_celular), CHR(0)), NVL(TO_CHAR(num_celular_nue),CHR(0))
        INTO v_num_cel, v_num_cel_nue
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        IF v_num_cel_nue = CHR(0) THEN
      v_out := v_num_cel || '|' || v_num_cel;
        ELSE
          v_out := v_num_cel || '|' || v_num_cel_nue;
        END IF;

    RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_numcel, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_numcel, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
  END;


----------------------------------------------------------------------------
-- FN_TMC_NUMCEL_NUE --
----------------------------------------------------------------------------
  FUNCTION FN_TMC_numcel_nue(v_num_mov IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
        v_num_cel VARCHAR2(512);
        v_num_cel_nue VARCHAR2(512);
    error_proceso EXCEPTION;
  BEGIN

    SELECT NVL(TO_CHAR(num_celular), CHR(0)), NVL(TO_CHAR(num_celular_nue), CHR(0))
        INTO v_num_cel, v_num_cel_nue
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        IF v_num_cel_nue = CHR(0) THEN
          v_out := v_num_cel;
        ELSE
          v_out := v_num_cel_nue;
        END IF;

    RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_TMC_numcel_nue, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_TMC_numcel_nue, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
  END;
----------------------------------------------------------------------------
-- FN_TMC_NUMPER --
----------------------------------------------------------------------------
  FUNCTION FN_TMC_numper(v_num_mov IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
        v_num_per VARCHAR(512);
        v_num_per_nue VARCHAR(512);
    error_proceso EXCEPTION;
--      v_mov ICC_MOVIMIENTO%ROWTYPE;
  BEGIN

    -- v_mov := FN_GEN_GETMOV(v_num_mov);

    SELECT NVL(NUM_PERSONAL, CHR(0)), NVL(num_personal_nue,CHR(0))
        INTO v_num_per, v_num_per_nue
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        IF v_num_per_nue = CHR(0) THEN
          v_out := v_num_per || '|' || v_num_per;
        ELSE
          v_out := v_num_per || '|' || v_num_per_nue;
        END IF;

    RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_TMC_numper, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_TMC_numper, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
  END;

----------------------------------------------------------------------------
-- FN_TMC_NUMPER_NUE --
----------------------------------------------------------------------------
  FUNCTION FN_TMC_numper_nue(v_num_mov IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
        v_num_per ICC_MOVIMIENTO.num_personal%TYPE;
        v_num_per_nue ICC_MOVIMIENTO.num_personal_nue%TYPE;
    error_proceso EXCEPTION;
        v_mov ICC_MOVIMIENTO%ROWTYPE;
  BEGIN

    -- v_mov := FN_GEN_GETMOV(v_num_mov);

    SELECT NVL(num_personal, CHR(0)), NVL(num_personal_nue, CHR(0))
        INTO v_num_per, v_num_per_nue
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

--      v_out := '|' || v_out || '|';
        IF v_num_per_nue = CHR(0) THEN
          v_out := v_num_per;
        ELSE
          v_out := v_num_per_nue;
        END IF;

  RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_numcel, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_numcel, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
  END;
----------------------------------------------------------------------------
-- FN_TMC_NUMSER --
----------------------------------------------------------------------------
  FUNCTION FN_TMC_numser(v_num_mov IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
        v_num_ser VARCHAR(512);
        v_num_ser_nue VARCHAR(512);
    error_proceso EXCEPTION;
--      v_mov ICC_MOVIMIENTO%ROWTYPE;
  BEGIN

    --v_mov := FN_GEN_GETMOV(v_num_mov);

    SELECT NVL(NUM_SERIE, CHR(0)), NVL(NUM_SERIE_nue, CHR(0))
        INTO v_num_ser, v_num_ser_nue
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;


        IF v_num_ser_nue = CHR(0) THEN
          v_out := v_num_ser || '|' || v_num_ser;
        ELSE
          v_out := v_num_ser || '|' || v_num_ser_nue;
        END IF;


    RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_TMC_numser, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_TMC_numser, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
  END;


----------------------------------------------------------------------------
-- FN_TMC_NUMSER_NUE --
----------------------------------------------------------------------------
  FUNCTION FN_TMC_numser_nue(v_num_mov IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
        v_num_ser ICC_MOVIMIENTO.num_serie%TYPE;
        v_num_ser_nue ICC_MOVIMIENTO.num_serie_nue%TYPE;
    error_proceso EXCEPTION;
        v_mov ICC_MOVIMIENTO%ROWTYPE;
  BEGIN

    SELECT NVL(num_serie, CHR(0)),NVL(num_serie_nue, CHR(0))
        INTO v_num_ser, v_num_ser_nue
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        IF v_num_ser_nue = CHR(0) THEN
          v_out := v_num_ser;
        ELSE
          v_out := v_num_ser_nue;
        END IF;

  RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_numcel, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_numcel, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
  END;

----------------------------------------------------------------------------
-- FN_TMC_NUMMSNB --
----------------------------------------------------------------------------
  FUNCTION FN_TMC_nummsnb(V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
        v_num_msnb VARCHAR(512);
    v_num_msnb_nue VARCHAR(512);
    error_proceso EXCEPTION;
  BEGIN

    SELECT NVL(num_msnb, CHR(0)),NVL(num_msnb_nue, CHR(0))
        INTO v_num_msnb, v_num_msnb_nue
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;


        IF v_num_msnb_nue = CHR(0) THEN
          v_out := v_num_msnb || '|' || v_num_msnb;
        ELSE
          v_out := v_num_msnb || '|' || v_num_msnb_nue;
        END IF;

    RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_TMC_msnb, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_TMC_msnb, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
  END;


----------------------------------------------------------------------------
-- FN_TMC_NUMMSNB_NUE --
----------------------------------------------------------------------------
  FUNCTION FN_TMC_nummsnb_nue(V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
        v_num_msnb ICC_MOVIMIENTO.num_msnb%TYPE;
        v_num_msnb_nue ICC_MOVIMIENTO.num_msnb_nue%TYPE;
    error_proceso EXCEPTION;
        v_mov ICC_MOVIMIENTO%ROWTYPE;
  BEGIN

    SELECT NVL(num_msnb, CHR(0)), NVL(num_msnb_nue, CHR(0))
        INTO v_num_msnb, v_num_msnb_nue
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        IF v_num_msnb_nue = CHR(0) THEN
          v_out := v_num_msnb;
        ELSE
          v_out := v_num_msnb_nue;
        END IF;

  RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_TMC_nummsnb_nue, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_TMC_nummsnb_nue, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
  END;

----------------------------------------------------------------------------
-- FN_TMC_IDVM --
----------------------------------------------------------------------------
  FUNCTION FN_TMC_idvm(V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
        v_cod_cen ICC_MOVIMIENTO.cod_central%TYPE;
    error_proceso EXCEPTION;
        v_mov ICC_MOVIMIENTO%ROWTYPE;
  BEGIN

    SELECT NVL(cod_central, 0) INTO v_cod_cen
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        SELECT NVL(nodocom, CHR(0)) INTO v_out
    FROM ICG_CENTRAL
    WHERE cod_central = v_cod_cen
    AND cod_producto = 1;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

    RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_TMC_idvm, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_TMC_idvm, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
  END;

----------------------------------------------------------------------------
-- FN_TMC_CODPIN --
----------------------------------------------------------------------------
  FUNCTION FN_TMC_codpin(V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
    error_proceso EXCEPTION;
  BEGIN

    SELECT NVL(cod_pin, CHR(0)) INTO v_out
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_codpin, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_codpin, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
  END;

----------------------------------------------------------------------------
-- FN_TMC_FECINGRESO --
----------------------------------------------------------------------------
  FUNCTION FN_TMC_fecingreso(V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    V_OUT STRING(512);
    error_proceso EXCEPTION;
  BEGIN

    SELECT NVL(TO_CHAR(fec_ingreso, 'YYYYMMDDHH24MISS'), CHR(0)) INTO v_out
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_TMC_fecingreso, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_TMC_fecingreso, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
  END;

----------------------------------------------------------------------------
-- FN_TMC_CODPLAN --
----------------------------------------------------------------------------
  FUNCTION FN_TMC_codplan(V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
    error_proceso EXCEPTION;
  BEGIN

    SELECT NVL(PLAN, CHR(0)) INTO v_out
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_TMC_codplan, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_TMC_codplan, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
  END;

----------------------------------------------------------------------------
-- FN_TMC_MTOCARGA --
----------------------------------------------------------------------------
  FUNCTION FN_TMC_mtocarga(V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
    error_proceso EXCEPTION;
  BEGIN

    SELECT NVL(TO_CHAR(carga), CHR(0)) INTO v_out
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_TMC_mtocarga, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_TMC_mtocarga, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
  END;

----------------------------------------------------------------------------
-- FN_TMC_VALPLAN --
----------------------------------------------------------------------------
  FUNCTION FN_TMC_valplan(V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    V_OUT STRING(512);
    error_proceso EXCEPTION;
  BEGIN

    SELECT NVL(TO_CHAR(valor_plan), CHR(0)) INTO v_out
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_TMC_valplan, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_TMC_valplan, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
  END;

----------------------------------------------------------------------------
-- FN_TMC_NUMOOSS --
----------------------------------------------------------------------------
  FUNCTION FN_TMC_numooss(V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
    error_proceso EXCEPTION;
  BEGIN


        SELECT TO_CHAR(icc_seq_numooss.NEXTVAL, 'FM0999999999') INTO v_out
        FROM dual;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_TMC_numooss, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_TMC_numooss, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
  END;

----------------------------------------------------------------------------
-- FN_TMC_CODAKEY --
----------------------------------------------------------------------------
  FUNCTION FN_TMC_numakey(V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
        v_out STRING(512);
    v_out_nue STRING(512);
        v_num_serie ICC_MOVIMIENTO.num_serie%TYPE;
        v_num_serie_nue ICC_MOVIMIENTO.num_serie%TYPE;
        v_num_serie1 ICC_MOVIMIENTO.num_serie%TYPE;
        v_num_serie2 ICC_MOVIMIENTO.num_serie%TYPE;
    v_num_serie3 ICC_MOVIMIENTO.num_serie%TYPE;
    v_num_serie4 ICC_MOVIMIENTO.num_serie%TYPE;
        v_hex GA_ABOCEL.num_seriehex%TYPE;
        v_dec GA_ABOCEL.num_serie%TYPE;
    v_hex_nue GA_ABOCEL.num_seriehex%TYPE;
        v_dec_nue GA_ABOCEL.num_serie%TYPE;

    error_proceso EXCEPTION;
  BEGIN


    SELECT TO_CHAR(FN_GEN_HexToNum(SUBSTR(NVL(num_serie, CHR('00')),1,2))), TO_CHAR(FN_GEN_HexToNum(SUBSTR(NVL(num_serie, CHR(0)),3)))
        INTO v_num_serie1, v_num_serie2
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

     SELECT TO_CHAR(FN_GEN_HexToNum(SUBSTR(NVL(num_serie_nue, CHR('00')),1,2))), TO_CHAR(FN_GEN_HexToNum(SUBSTR(NVL(num_serie_nue, CHR(0)),3))),num_serie_nue
        INTO v_num_serie3, v_num_serie4,v_num_serie_nue
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;


        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        v_dec := SUBSTR('000'||v_num_serie1, LENGTH(v_num_serie1)+1, 3)||SUBSTR('00000000'||v_num_serie2, LENGTH(v_num_serie2)+1, 8);

        v_dec_nue := SUBSTR('000'||v_num_serie3, LENGTH(v_num_serie3)+1, 3)||SUBSTR('00000000'||v_num_serie4, LENGTH(v_num_serie4)+1, 8);

        -- Se asume serie hexadecimal => hay que convertirla a decimal --

        SELECT NVL(TO_CHAR(cod_clave,'FM0999'), CHR(0)) || NVL(a_key_cryp, CHR(0)) || NVL(chk_digits, CHR(0))
        INTO v_out
        FROM ICT_AKEYS
        WHERE num_esn = v_dec;

    IF SQLCODE <> 0 THEN
              RAISE error_proceso;
        END IF;


    IF v_num_serie_nue IS NULL OR v_dec_nue IS NULL THEN
            v_out := v_out || '|' || v_out;
    ELSE
          SELECT NVL(TO_CHAR(cod_clave,'FM0999'), CHR(0)) || NVL(a_key_cryp, CHR(0)) || NVL(chk_digits, CHR(0))
              INTO v_out_nue
              FROM ICT_AKEYS
              WHERE num_esn = v_dec_nue;

          IF SQLCODE <> 0 THEN
                 RAISE error_proceso;
              END IF;


          IF v_out_nue IS NULL  THEN
                 v_out := v_out || '|' || v_out;
          ELSE
                 v_out := v_out || '|' || v_out_nue;
          END IF;
        END IF;

  RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_TMC_numakey, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_TMC_numakey, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
  END;

----------------------------------------------------------------------------
-- FN_TMC_FECEXPIRA --
----------------------------------------------------------------------------
  FUNCTION FN_TMC_fecexpira(v_num_mov IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
    error_proceso EXCEPTION;
  BEGIN

    SELECT NVL(TO_CHAR(fec_expira, 'DD-MM-YYYY'), CHR(0)) INTO v_out
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_TMC_fecexpira, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_TMC_fecexpira, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
  END;

----------------------------------------------------------------------------
-- FN_TMC_PASSWD2 --
----------------------------------------------------------------------------
  FUNCTION FN_TMC_passwd2(V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
        v_num_abonado ICC_MOVIMIENTO.NUM_ABONADO%TYPE;
    error_proceso EXCEPTION;
  BEGIN

    SELECT NVL(NUM_ABONADO, 0) INTO v_num_abonado
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        BEGIN
    SELECT NVL(SUBSTR(num_serie,8,4), CHR(0))
        INTO v_out
    FROM GA_ABOCEL
    WHERE NUM_ABONADO = v_num_abonado;

        EXCEPTION
        WHEN NO_DATA_FOUND THEN
       SELECT NVL(SUBSTR(num_serie,8,4), CHR(0))
           INTO v_out
       FROM GA_ABOAMIST
       WHERE NUM_ABONADO = v_num_abonado;
        END;

        RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_TMC_passwd2, SQLCODE:' || TO_CHAR(SQLCODE) || '-SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_TMC_passwd2, SQLCODE:' || TO_CHAR(SQLCODE) || '-SLQERRM:' || SQLERRM;
  END;

----------------------------------------------------------------------------
-- FN_TMC_PRIOFU --
----------------------------------------------------------------------------
  FUNCTION FN_TMC_priofu(V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    V_OUT STRING(512);
    error_proceso EXCEPTION;
  BEGIN

        v_out := SYSDATE;
        v_out := CHR(0);

        RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_TMC_priofu, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_TMC_priofu, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
  END;

----------------------------------------------------------------------------
-- FN_TMC_NUMFREC --
----------------------------------------------------------------------------
  FUNCTION FN_TMC_numfrec(V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
    v_fec_ing ICC_MOVIMIENTO.fec_ingreso%TYPE;
    v_num_abo ICC_MOVIMIENTO.NUM_ABONADO%TYPE;
    v_pos PPT_NUMEROFRECUENTE.num_posicion%TYPE;
    v_frec PPT_NUMEROFRECUENTE.num_frecuente%TYPE;
    error_proceso EXCEPTION;
  BEGIN

    SELECT fec_ingreso, NVL(NUM_ABONADO, 0)
        INTO v_fec_ing, v_num_abo
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

    SELECT num_posicion, LTRIM(RTRIM(num_frecuente))
    INTO v_pos, v_frec
    FROM   PPT_NUMEROFRECUENTE
    WHERE  TO_CHAR(fec_modificacion,'yyyymmddhh24miss') = TO_CHAR(v_fec_ing,'yyyymmddhh24miss')
    AND  NUM_ABONADO = v_num_abo;

    IF SQLCODE <> 0 THEN
      RAISE error_proceso;
    END IF;

    v_out := SUBSTR(v_frec|| '         ',1,9) || TO_CHAR(v_pos, 'FM09');

    RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_TMC_numfrec, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_TMC_numfrec, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
  END;

----------------------------------------------------------------------------
-- FN_TMC_VALPLANNF --
----------------------------------------------------------------------------
  FUNCTION FN_TMC_valplanNF(V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    V_OUT STRING(512);
    error_proceso EXCEPTION;
  BEGIN

    SELECT NVL(TO_CHAR(valor_plan, 'FM099999'), CHR(0)) INTO v_out
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        -- Aqui formatear valor plan para numero frecuente con ceros a la izq ---

        RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_TMC_valplanNF, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_TMC_valplanNF, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
  END;

----------------------------------------------------------------------------
-- FN_TMC_PASSWD --
----------------------------------------------------------------------------
  FUNCTION FN_TMC_passwd(V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    V_OUT STRING(512);
        v_num_abo ICC_MOVIMIENTO.NUM_ABONADO%TYPE;
        v_cod_pass GA_ABOCEL.cod_password%TYPE;
    error_proceso EXCEPTION;
  BEGIN

    SELECT NUM_ABONADO INTO v_num_abo
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

    BEGIN

    SELECT NVL(cod_password, CHR(0)) INTO v_cod_pass
        FROM GA_ABOCEL
        WHERE NUM_ABONADO = v_num_abo;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN

      SELECT NVL(cod_password, CHR(0)) INTO v_cod_pass
          FROM GA_ABOAMIST
      WHERE NUM_ABONADO = v_num_abo;

    END;

        v_out := v_cod_pass;

        RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_TMC_passwd, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_TMC_passwd, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
  END;


 ----------------------------------------------------------------------------
-- FN_TMC_PASSWD4 --
----------------------------------------------------------------------------
  FUNCTION FN_TMC_passwd4(V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
    v_serie1 STRING(512);
    v_serie2 STRING(512);
    v_serie STRING(512);
    v_num_abonado ICC_MOVIMIENTO.NUM_ABONADO%TYPE;
    error_proceso EXCEPTION;
  BEGIN

      SELECT NVL(SUBSTR(num_serie,1,2), CHR(0)), NVL(SUBSTR(num_serie,3,6), CHR(0))
      INTO v_serie1, v_serie2
      FROM ICC_MOVIMIENTO
      WHERE num_movimiento = v_num_mov;

      IF SQLCODE <> 0 THEN
         RAISE error_proceso;
      END IF;

      v_serie := NVL(REPLACE(RPAD(TO_CHAR(Ic_Pkg_Parametros.FN_GEN_HexToNum(v_serie1)),4),' ','0') ||
                 LTRIM(TO_CHAR(Ic_Pkg_Parametros.FN_GEN_HexToNum(v_serie2),'00000000')), CHR(0));

      v_out := NVL(SUBSTR(v_serie,LENGTH(v_serie)-3,4), CHR(0));

      RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_TMC_passwd4, SQLCODE:' || TO_CHAR(SQLCODE) || '-SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_TMC_passwd4, SQLCODE:' || TO_CHAR(SQLCODE) || '-SLQERRM:' || SQLERRM;
  END;



----------------------------------------------------------------------------
-- FN_TMC_PREF --
----------------------------------------------------------------------------
  FUNCTION FN_TMC_pref(V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
        v_num_cel ICC_MOVIMIENTO.num_celular%TYPE;
        v_num_min ICC_MOVIMIENTO.num_min%TYPE;
        v_num_min_nue ICC_MOVIMIENTO.num_min_nue%TYPE;
        v_var VARCHAR (100);
    error_proceso EXCEPTION;
  BEGIN

    SELECT NVL(num_celular, 0), NVL(num_min, CHR(0)), NVL(num_min_nue, CHR(0))
        INTO v_num_cel, v_num_min, v_num_min_nue
    FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
                RAISE error_proceso;
        END IF;

        IF v_num_min = CHR(0) THEN
           SELECT NVL(num_prefijo, CHR(0)) || NVL(num_inicial, CHR(0)) INTO v_num_min
           FROM ICG_PREFIJO
           WHERE num_inicial = SUBSTR(TO_CHAR(v_num_cel),1,1);

       IF SQLCODE <> 0 THEN
             RAISE error_proceso;
       END IF;
        END IF;

        IF v_num_min_nue = CHR(0) THEN
          v_out := v_num_min || '|' || v_num_min;
        ELSE
      v_out := v_num_min || '|' || v_num_min_nue;
        END IF;

        RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN FN_TMC_pref, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM: ' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN FN_TMC_pref, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM: ' || SQLERRM;
  END;

----------------------------------------------------------------------------
-- FN_TMC_PREF_NUE --
----------------------------------------------------------------------------
  FUNCTION FN_TMC_pref_nue(V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
        v_num_cel ICC_MOVIMIENTO.num_celular%TYPE;
        v_num_min ICC_MOVIMIENTO.num_min%TYPE;
    error_proceso EXCEPTION;
  BEGIN

    SELECT NVL(num_min_nue, CHR(0)) INTO v_num_min
    FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF v_num_min = CHR(0) THEN
      SELECT NVL(num_prefijo, CHR(0)) || NVL(num_inicial, CHR(0)) INTO v_out
          FROM ICG_PREFIJO
          WHERE num_inicial = SUBSTR(v_num_cel, 1);

      IF SQLCODE <> 0 THEN
            RAISE error_proceso;
      END IF;
        ELSE
          v_out := v_num_min;
        END IF;

        RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_TMC_pref_nue, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_TMC_pref_nue, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
  END;

----------------------------------------------------------------------------
-- FN_TMC_MENSAJE --
----------------------------------------------------------------------------
  FUNCTION FN_TMC_mensaje(v_num_mov IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
        v_cod_cen ICC_MOVIMIENTO.cod_central%TYPE;
        v_cod_men ICC_MOVIMIENTO.cod_mensaje%TYPE;
        v_p1 ICC_MOVIMIENTO.param1_mens%TYPE;
        v_p2 ICC_MOVIMIENTO.param2_mens%TYPE;
        v_p3 ICC_MOVIMIENTO.param3_mens%TYPE;
        v_des_men ICG_MENSAJE.des_mensaje%TYPE;
    error_proceso EXCEPTION;
  BEGIN

    SELECT NVL(cod_central, 0),
               NVL(cod_mensaje, 0),
               NVL(param1_mens, NULL),
                   NVL(param2_mens, NULL),
                   NVL(param3_mens, NULL)
    INTO v_cod_cen,v_cod_men,v_p1,v_p2,v_p3
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        SELECT des_mensaje INTO v_des_men
        FROM ICG_MENSAJE
        WHERE cod_mensaje = v_cod_men
        AND cod_central = v_cod_cen
        AND cod_producto = 1;

    IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        --- Aqui logica para reemplazar parametros en el mensaje (des_men) ---
        v_des_men := REPLACE(v_des_men, '<p1>', v_p1);
        v_des_men := REPLACE(v_des_men, '<p2>', v_p2);
        v_des_men := REPLACE(v_des_men, '<p3>', v_p3);

        v_out := v_des_men;

        RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_TMC_mensaje, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_TMC_mensaje, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
  END;

----------------------------------------------------------------------------
-- FN_TMC_LCOMANDO --
----------------------------------------------------------------------------
  FUNCTION FN_TMC_lcomando(v_num_mov IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
        v_num NUMBER;
        v_num_cel ICC_MOVIMIENTO.num_celular%TYPE;
        v_cod_cen ICC_MOVIMIENTO.cod_central%TYPE;
        v_cod_men ICC_MOVIMIENTO.cod_mensaje%TYPE;
        v_p1 ICC_MOVIMIENTO.param1_mens%TYPE;
        v_p2 ICC_MOVIMIENTO.param2_mens%TYPE;
        v_p3 ICC_MOVIMIENTO.param3_mens%TYPE;
        v_des_men ICG_MENSAJE.des_mensaje%TYPE;
    error_proceso EXCEPTION;
  BEGIN

    SELECT NVL(num_celular, 0),
               NVL(cod_central, 0),
               NVL(cod_mensaje, 0),
               NVL(param1_mens, NULL),
               NVL(param2_mens, NULL),
               NVL(param3_mens, NULL)

    INTO v_num_cel, v_cod_cen, v_cod_men, v_p1, v_p2, v_p3
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        SELECT des_mensaje INTO v_des_men
        FROM ICG_MENSAJE
        WHERE cod_mensaje = v_cod_men
        AND cod_central = v_cod_cen
        AND cod_producto = 1;

    IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        --- Aqui logica para reemplazar parametros en el mensaje (des_men) ---
        v_des_men := REPLACE(v_des_men, '<p1>', v_p1);
        v_des_men := REPLACE(v_des_men, '<p2>', v_p2);
        v_des_men := REPLACE(v_des_men, '<p3>', v_p3);

        v_num := 3 + LENGTH(TO_CHAR(v_num_cel)) + LENGTH(v_des_men);

        v_out := TO_CHAR(v_num, 'FM0999');

        RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_TMC_lcomando, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_TMC_lcomando, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
  END;

----------------------------------------------------------------------------
-- FN_TMC_STATUS --
----------------------------------------------------------------------------
  FUNCTION FN_TMC_status(v_num_mov IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
    error_proceso EXCEPTION;
  BEGIN

    SELECT NVL(sta, CHR(0)) INTO v_out
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_TMC_status, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_TMC_status, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
  END;


----------------------------------------------------------------------------
-- FN_TMC_TIPCUENTA --
----------------------------------------------------------------------------
  FUNCTION FN_TMC_tipcuenta(v_num_mov IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
        v_num_abo ICC_MOVIMIENTO.NUM_ABONADO%TYPE;
        v_num_cel ICC_MOVIMIENTO.num_celular%TYPE;
        v_cod_uso GA_ABOCEL.cod_uso%TYPE;
    error_proceso EXCEPTION;
  BEGIN

    SELECT NVL(NUM_ABONADO, 0), NVL(num_celular, 0)
        INTO v_num_abo, v_num_cel
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

    BEGIN

    SELECT NVL(cod_uso, 0) INTO v_cod_uso
    FROM GA_ABOCEL
    WHERE NUM_ABONADO = v_num_abo;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN

          BEGIN

          SELECT NVL(cod_uso, 0) INTO v_cod_uso
      FROM GA_ABOAMIST
      WHERE NUM_ABONADO = v_num_abo;

          EXCEPTION
          WHEN NO_DATA_FOUND THEN

                SELECT NVL(COD_USO, 0) INTO v_cod_uso
        FROM AL_SERIES
        WHERE NUM_TELEFONO = v_num_cel;

          END;

        END;

    IF v_cod_uso = 3 THEN
      v_out := '1';
    ELSE
      IF v_cod_uso = 10 OR v_cod_uso = 15 THEN
        v_out := '2';
      ELSE
        v_out := '0';
      END IF;
    END IF;

    RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_TMC_tipcuenta, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_TMC_tipcuenta, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
  END;

----------------------------------------------------------------------------
-- FN_TMC_MENSAJE2 --
----------------------------------------------------------------------------
  FUNCTION FN_TMC_mensaje2(v_num_mov IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
    error_proceso EXCEPTION;
  BEGIN

    SELECT NVL(des_mensaje, CHR(0)) INTO v_out
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_TMC_mensaje2, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_TMC_mensaje2, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
  END;

----------------------------------------------------------------------------
-- FN_TMC_LCOMANDO2 --
----------------------------------------------------------------------------
  FUNCTION FN_TMC_lcomando2(v_num_mov IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
        v_men ICC_MOVIMIENTO.des_mensaje%TYPE;
    error_proceso EXCEPTION;
  BEGIN

    SELECT NVL(des_mensaje, CHR(0)) INTO v_men
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

    v_out := TO_CHAR(10 + LENGTH(v_men), 'FM0999');

        RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_TMC_lcomando2, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_TMC_lcomando2, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
  END;

----------------------------------------------------------------------------
-- FN_TMC_CLINUMIDE --
----------------------------------------------------------------------------
  FUNCTION FN_TMC_clinumide(v_num_mov IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
        v_cod_cli GE_CLIENTES.cod_cliente%TYPE;
    error_proceso EXCEPTION;
  BEGIN

    SELECT cod_cliente INTO v_cod_cli
    FROM GA_ABOCEL
    WHERE NUM_ABONADO = (SELECT NUM_ABONADO FROM ICC_MOVIMIENTO WHERE num_movimiento = v_num_mov);

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

    SELECT SUBSTR(NUM_IDENT,1,INSTR(num_ident,'-',1,1)-1)||SUBSTR(NUM_IDENT,INSTR(num_ident,'-',1,1)+1)
        INTO v_out
    FROM GE_CLIENTES
    WHERE cod_cliente = v_cod_cli;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_TMC_clinumide, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_TMC_clinumide, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
  END;


----------------------------------------------------------------------------
-- FN_TMC_CLICODCLI --
----------------------------------------------------------------------------
  FUNCTION FN_TMC_clicodcli(v_num_mov IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
        v_cod_cli GE_CLIENTES.cod_cliente%TYPE;
    error_proceso EXCEPTION;
  BEGIN

    BEGIN
      SELECT cod_cliente INTO v_cod_cli
      FROM GA_ABOCEL
      WHERE NUM_ABONADO = (SELECT NUM_ABONADO FROM ICC_MOVIMIENTO WHERE num_movimiento = v_num_mov);
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        SELECT cod_cliente INTO v_cod_cli
        FROM GA_ABOAMIST
        WHERE NUM_ABONADO = (SELECT NUM_ABONADO FROM ICC_MOVIMIENTO WHERE num_movimiento = v_num_mov);
    END;

--        IF SQLCODE <> 0 THEN
--          RAISE error_proceso;
--        END IF;

        SELECT NVL(TO_CHAR(cod_cliente), CHR(0))
        INTO v_out
        FROM GE_CLIENTES
        WHERE cod_cliente = v_cod_cli;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_TMC_codcli, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_TMC_codcli, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
  END;

----------------------------------------------------------------------------
-- FN_TMC_CLINOMEMP                                                       --
----------------------------------------------------------------------------
FUNCTION FN_TMC_clinomemp(v_num_mov IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
   v_out STRING(512);
   v_cod_cli GE_CLIENTES.cod_cliente%TYPE;
   v_nom_cli GE_CLIENTES.nom_cliente%TYPE;
   v_apepa_cli  GE_CLIENTES.nom_apeclien1%TYPE;
   v_apema_cli GE_CLIENTES.nom_apeclien2%TYPE;
   iLen  NUMBER;
   error_proceso EXCEPTION;
  BEGIN

    SELECT cod_cliente INTO v_cod_cli
    FROM GA_ABOCEL
    WHERE NUM_ABONADO = (SELECT NUM_ABONADO FROM ICC_MOVIMIENTO WHERE num_movimiento = v_num_mov);

   IF SQLCODE <> 0 THEN
      RAISE error_proceso;
   END IF;

   SELECT LTRIM(RTRIM(NOM_CLIENTE)),LTRIM(RTRIM(NOM_APECLIEN1)),LTRIM(RTRIM(NOM_APECLIEN2))
   INTO v_nom_cli, v_apepa_cli, v_apema_cli
   FROM GE_CLIENTES
   WHERE cod_cliente = v_cod_cli;

   iLen := LENGTH(v_nom_cli);

   IF ilen > 20 THEN
      IF ilen > 40 THEN
        --si es mas de 40, pero como no puede ser mas de 50, tomamos el apepa_cli para completar 60
        v_out := v_nom_cli||' '||SUBSTR(v_apepa_cli,1,20-(iLen-40));
      ELSE
        --si es mayor de 20 y menor de 40, entonces, tomamos completo el apepa_cli y parte del apema_cli
        --completar el apepa_cli.
         v_out := v_nom_cli||' '||v_apepa_cli||' '||SUBSTR(v_apema_cli,1,20-(iLen-20));
      END IF;
   ELSE
      --si no es mayor que 20 e ntonces tomamos los 3 campos.
      v_out := v_nom_cli||' '||v_apepa_cli||' '||v_apema_cli;
   END IF;

   IF SQLCODE <> 0 THEN
      RAISE error_proceso;
   END IF;

   RETURN LTRIM(RTRIM(SUBSTR(v_out,1,60)));

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_TMC_clinomemp, SQLCODE:' || TO_CHAR(SQLCODE) || '-SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_TMC_clinomemp, SQLCODE:' || TO_CHAR(SQLCODE) || '-SLQERRM:' || SQLERRM;
  END;


----------------------------------------------------------------------------
-- FN_TMC_CLINUMTEL --
----------------------------------------------------------------------------
  FUNCTION FN_TMC_clinumtel(v_num_mov IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
        v_cod_cli GE_CLIENTES.cod_cliente%TYPE;
    error_proceso EXCEPTION;
  BEGIN

    SELECT cod_cliente INTO v_cod_cli
    FROM GA_ABOCEL
    WHERE NUM_ABONADO = (SELECT NUM_ABONADO FROM ICC_MOVIMIENTO WHERE num_movimiento = v_num_mov);

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

    SELECT NVL(TEF_CLIENTE1,NVL(TEF_CLIENTE2,CHR(0)))
        INTO v_out
    FROM GE_CLIENTES
    WHERE cod_cliente = v_cod_cli;

    IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_TMC_numtel, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_TMC_numtel, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
  END;


----------------------------------------------------------------------------
-- FN_TMC_CLICODCIC --
----------------------------------------------------------------------------
  FUNCTION FN_TMC_clicodcic(v_num_mov IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
    error_proceso EXCEPTION;
    LN_cod_ciclo_1  ga_abocel.cod_ciclo%type :=1;
    LN_cod_ciclo_5  ga_abocel.cod_ciclo%type :=5;
    LN_cod_ciclo_10 ga_abocel.cod_ciclo%type :=10;
    LN_cod_ciclo_13 ga_abocel.cod_ciclo%type :=13;
    LN_cod_ciclo_20 ga_abocel.cod_ciclo%type :=20;
    LV_cod_ciclo_1  VARCHAR2(2) :='28';
    LV_cod_ciclo_5  VARCHAR2(2) :='05';
    LV_cod_ciclo_10 VARCHAR2(2) :='09';
    LV_cod_ciclo_13 VARCHAR2(2) :='12';
    LV_cod_ciclo_20 VARCHAR2(2) :='19';
  BEGIN

        SELECT DECODE(COD_CICLO,LN_cod_ciclo_1 , LV_cod_ciclo_1 ,LN_cod_ciclo_5 ,LV_cod_ciclo_5
                               ,LN_cod_ciclo_10, LV_cod_ciclo_10,LN_cod_ciclo_13,LV_cod_ciclo_13
                               ,LN_cod_ciclo_20, LV_cod_ciclo_20)
        INTO v_out
        FROM GA_ABOCEL
        WHERE NUM_ABONADO = (SELECT NUM_ABONADO FROM ICC_MOVIMIENTO WHERE num_movimiento = v_num_mov);

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;


        RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_TMC_codcic, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_TMC_codcic, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
  END;


----------------------------------------------------------------------------
-- FN_TMC_FVALDEF --
----------------------------------------------------------------------------
  FUNCTION FN_TMC_fvaldef(v_num_mov IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
    error_proceso EXCEPTION;
  BEGIN
        -- Formato : [FMD0050 ] - Formato de relleno a la derecha con 50 espacios --
    v_out := 'FMD0050 ';

        RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_TMC_fvaldef, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_TMC_fvaldef, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
  END;

----------------------------------------------------------------------------
-- FN_TMC_ORIPIN --
----------------------------------------------------------------------------
  FUNCTION FN_TMC_oripin(V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
    error_proceso EXCEPTION;
  BEGIN

    SELECT NVL(des_origen_pin, CHR(0)) INTO v_out
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_TMC_oripin, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_TMC_oripin, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
  END;


----------------------------------------------------------------------------
-- FN_TMC_LOTPIN --
----------------------------------------------------------------------------
  FUNCTION FN_TMC_lotpin(V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
    error_proceso EXCEPTION;
  BEGIN

    SELECT NVL(TO_CHAR(num_lote_pin), CHR(0)) INTO v_out
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_TMC_lotpin, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_TMC_lotpin, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
  END;



----------------------------------------------------------------------------
-- FN_TMC_SERPIN --
----------------------------------------------------------------------------
  FUNCTION FN_TMC_serpin(V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
    error_proceso EXCEPTION;
  BEGIN

    SELECT NVL(num_serie_pin, CHR(0)) INTO v_out
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_TMC_serpin, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_RMC_serpin, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
  END;

  ----------------------------------------------------------------------------
  -- FN_TMC_NUMCEL2-- extrae siete digitos del numero celular
  ----------------------------------------------------------------------------
  FUNCTION FN_TMC_numcel2(v_num_mov IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
        v_num_cel VARCHAR2(512);
        v_num_cel_nue VARCHAR2(512);
    error_proceso EXCEPTION;
  BEGIN

     SELECT DECODE(LENGTH(TO_CHAR(NVL(num_celular,0))),8, SUBSTR(TO_CHAR(NVL(num_celular,0)),2),LTRIM(RTRIM(TO_CHAR(num_celular)))),
                DECODE(LENGTH(TO_CHAR(NVL(num_celular_nue,0))),8, SUBSTR(TO_CHAR(NVL(num_celular_nue,0)),2),NVL(TO_CHAR(num_celular_nue),CHR(0)))
     INTO v_num_cel, v_num_cel_nue
     FROM ICC_MOVIMIENTO
     WHERE num_movimiento = v_num_mov;

     IF SQLCODE <> 0 THEN
           RAISE error_proceso;
         END IF;

        IF v_num_cel_nue =CHR(0) THEN
      v_out := v_num_cel || '|' || v_num_cel;
        ELSE
          v_out := v_num_cel || '|' || v_num_cel_nue;
        END IF;

    RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_numcel2, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_numcel2, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
 END;

----------------------------------------------------------------------------
-- FN_TMC_PRIORIDAD--
----------------------------------------------------------------------------

  FUNCTION FN_TMC_prioridad(V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    V_OUT STRING(512);
    error_proceso EXCEPTION;

  BEGIN

    GV_nom_tabla    := 'ICG_ACTUACION';
      GV_nom_columna  := 'VAL_PRIORIDAD';
    GN_cod_producto := 1;
    GV_cod_modulo   := 'IC';

    SELECT C.DES_VALOR
    INTO v_out
    FROM ICC_MOVIMIENTO B, ICG_ACTUACION A, GED_CODIGOS C
    WHERE B.num_movimiento = v_num_mov
      AND A.COD_ACTUACION = B.COD_ACTUACION
      AND A.COD_PRODUCTO  = GN_cod_producto
          AND TO_NUMBER(C.COD_VALOR) = A.VAL_PRIORIDAD
          AND C.COD_MODULO = GV_cod_modulo
          AND C.NOM_TABLA  = GV_nom_tabla
          AND C.NOM_COLUMNA =GV_nom_columna;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_TMC_PRIORIDAD, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_TMC_PRIORIDAD, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
  END;

----------------------------------------------------------------------------
-- FN_TMC_LCOMANDO7 -- FROM TMC.PRODUCCION
----------------------------------------------------------------------------
  FUNCTION FN_TMC_lcomando7(v_num_mov IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
        v_num NUMBER;
        v_num_cel ICC_MOVIMIENTO.num_celular%TYPE;
        v_cod_cen ICC_MOVIMIENTO.cod_central%TYPE;
        v_cod_men ICC_MOVIMIENTO.cod_mensaje%TYPE;
        v_p1 ICC_MOVIMIENTO.param1_mens%TYPE;
        v_p2 ICC_MOVIMIENTO.param2_mens%TYPE;
        v_p3 ICC_MOVIMIENTO.param3_mens%TYPE;
        v_des_men ICG_MENSAJE.des_mensaje%TYPE;
    error_proceso EXCEPTION;
  BEGIN

    SELECT NVL(num_celular, 0),
               NVL(cod_central, 0),
               NVL(cod_mensaje, 0),
               NVL(param1_mens, NULL),
               NVL(param2_mens, NULL),
               NVL(param3_mens, NULL)

    INTO v_num_cel, v_cod_cen, v_cod_men, v_p1, v_p2, v_p3
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        SELECT des_mensaje INTO v_des_men
        FROM ICG_MENSAJE
        WHERE cod_mensaje = v_cod_men
        AND cod_central = v_cod_cen
        AND cod_producto = 1;

    IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        --- Aqui logica para reemplazar parametros en el mensaje (des_men) ---
        v_des_men := REPLACE(v_des_men, '<p1>', v_p1);
        v_des_men := REPLACE(v_des_men, '<p2>', v_p2);
        v_des_men := REPLACE(v_des_men, '<p3>', v_p3);

        v_num := 10 + LENGTH(v_des_men);

        v_out := TO_CHAR(v_num, 'FM0999');

        RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_TMC_lcomando7, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_TMC_lcomando7, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
  END;



----------------------------------------------------------------------------
-- FN_TMC_IMSI --
----------------------------------------------------------------------------
  FUNCTION FN_TMC_IMSI(V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
        v_icc VARCHAR2(512);
        v_icc_nue VARCHAR2(512);
        v_imsi VARCHAR2(512);
        v_imsi_nue VARCHAR2(512);
        v_comando_sql  VARCHAR2(200);
    error_proceso EXCEPTION;
  BEGIN

    SELECT NVL(ICC, CHR(0)), NVL(ICC_NUE, CHR(0))
        INTO v_icc, v_icc_nue
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        IF v_icc = CHR(0) THEN
          v_imsi := CHR(0);
        ELSE
     v_imsi := fRecuperSIMCARD_FN(v_icc,'IMSI');
        END IF;

        IF v_icc_nue = CHR(0) THEN
            v_imsi_nue := v_imsi;
        ELSE
            v_imsi_nue := fRecuperSIMCARD_FN(v_icc_nue,'IMSI');
        END IF;

        IF v_imsi = CHR(0) THEN
          v_imsi := v_imsi_nue;
        END IF;

        IF v_imsi = CHR(0) AND v_imsi_nue = CHR(0) THEN
           RAISE_APPLICATION_ERROR (-20002,'Numero de Serie no Valida');
        END IF;

        v_out := v_imsi || '|' || v_imsi_nue ;

        RETURN v_out;


  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_TMC_IMSI, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_TMC_IMSI, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
  END;



----------------------------------------------------------------------------
-- FN_TMC_IMEI --
----------------------------------------------------------------------------
  FUNCTION FN_TMC_IMEI(V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
        v_imei VARCHAR2(512);
        v_imei_nue VARCHAR2(512);
    error_proceso EXCEPTION;
  BEGIN

    SELECT NVL(IMEI, ''), NVL(IMEI_NUE, CHR(0))
        INTO v_imei, v_imei_nue
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        IF v_imei_nue = CHR(0) THEN
      v_out := v_imei || '|' || v_imei;
        ELSE
          v_out := v_imei || '|' || v_imei_nue;
        END IF;

    RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_TMC_IMEI, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_TMC_IMEI, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
  END;

----------------------------------------------------------------------------
-- FN_TMC_ICC --
----------------------------------------------------------------------------
  FUNCTION FN_TMC_ICC(V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
        v_icc VARCHAR2(512);
        v_icc_nue VARCHAR2(512);
    error_proceso EXCEPTION;
  BEGIN

    SELECT NVL(ICC, CHR(0)), NVL(ICC_NUE, CHR(0))
        INTO v_icc, v_icc_nue
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        v_out := '';

        IF (v_icc <> CHR(0)) THEN
           IF v_icc_nue = CHR(0) THEN
                      v_out := v_icc || '|' || v_icc;
           ELSE
                     v_out := v_icc || '|' || v_icc_nue;
           END IF;
        ELSE
          IF v_icc_nue <> CHR(0) THEN
               v_out := v_icc_nue || '|' || v_icc_nue;
          END IF;
        END IF;

    RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_TMC_ICC, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_TMC_ICC, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
  END;

----------------------------------------------------------------------------
-- FN_TMC_MSISDN --
-- Ejemplo: MSISDN=5691602110
----------------------------------------------------------------------------
FUNCTION FN_TMC_MSISDN(v_num_mov IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
        v_num_cel VARCHAR2(512);
        v_num_cel_nue VARCHAR2(512);
    error_proceso EXCEPTION;
  BEGIN

    SELECT NVL(TO_CHAR(num_celular), ''), NVL(TO_CHAR(num_celular_nue),CHR(0))
        INTO v_num_cel, v_num_cel_nue
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        IF v_num_cel_nue = CHR(0) THEN
      v_out := '56'||v_num_cel || '|' || '56'||v_num_cel;
        ELSE
          v_out := '56'||v_num_cel || '|' || '56'||v_num_cel_nue;
        END IF;

    RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_numcel, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_numcel, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
  END;


----------------------------------------------------------------------------
-- FN_TMC_CLAVE --
-- Desc: Paramatro KIC (clave) para AUC
----------------------------------------------------------------------------
FUNCTION FN_TMC_CLAVE (v_num_mov IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
       v_char_icc VARCHAR2(25);                -- Size according to iccMovimiento
        v_comando_sql  VARCHAR2(200);

    error_proceso EXCEPTION;
  BEGIN

        -- Get ICC
    SELECT NVL(icc, CHR(0))
        INTO v_char_icc
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        -- Get KIC
        v_out:= fRecuperSIMCARD_FN (v_char_icc,'KI');

    RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_numcel, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_numcel, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
  END;


----------------------------------------------------------------------------
-- FN_TMC_INDICE --
-- Desc: Paramatro KID (indice) para AUC
----------------------------------------------------------------------------
FUNCTION FN_TMC_INDICE (v_num_mov IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
        v_char_icc VARCHAR2(25);                -- Size according to iccMovimiento
        v_comando_sql  VARCHAR2(200);

    error_proceso EXCEPTION;
  BEGIN

        -- Get ICC
    SELECT NVL(icc, CHR(0))
        INTO v_char_icc
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        -- Get KID
        v_out:= fRecuperSIMCARD_FN (v_char_icc,'TPORT_KEY');

    RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_numcel, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_numcel, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
  END;


----------------------------------------------------------------------------
-- FN_TMC_ALGORITMO--
-- Desc: Paramatro KI (algoritmo) para AUC
----------------------------------------------------------------------------
FUNCTION FN_TMC_ALGORITMO (v_num_mov IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
        v_char_icc VARCHAR2(25);                -- Size according to iccMovimiento
        v_comando_sql  VARCHAR2(200);

    error_proceso EXCEPTION;
  BEGIN

        -- Get ICC
    SELECT NVL(icc, CHR(0))
        INTO v_char_icc
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        -- Get KI
        v_out:= fRecuperSIMCARD_FN (v_char_icc,'A3/A8_ALG');

    RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_numcel, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_numcel, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
  END;


----------------------------------------------------------------------------
-- FN_TMC_TT --
----------------------------------------------------------------------------
  FUNCTION FN_TMC_TT(V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
    error_proceso EXCEPTION;
  BEGIN

    SELECT NVL(TIP_TECNOLOGIA, CHR(0)) INTO v_out
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

    IF v_out = 'GSM' THEN v_out := 1 || '|' || 1;
        ELSE  v_out := 0 || '|' || 0;
        END IF;


        RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_TMC_TT, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_TMC_TT, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
  END;



---------------------------------------------------------------------------
-- FN_TMC_FNUM--
----------------------------------------------------------------------------
FUNCTION FN_TMC_FNUM (v_num_mov IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
        v_num_cel VARCHAR2(512);
        v_num_cel_nue VARCHAR2(512);
    error_proceso EXCEPTION;
  BEGIN

    SELECT NVL(TO_CHAR(num_celular), CHR(0)), NVL(TO_CHAR(num_celular_nue),CHR(0))
        INTO v_num_cel, v_num_cel_nue
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        IF v_num_cel_nue = CHR(0) THEN
      v_out := '56'||v_num_cel || '|' || '56'||v_num_cel;
        ELSE
          v_out := '56'||v_num_cel || '|' || '56'||v_num_cel_nue;
        END IF;

    RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_numcel, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_numcel, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
  END;


---------------------------------------------------------------------------
-- FN_TMC_passwd3
----------------------------------------------------------------------------
FUNCTION FN_TMC_passwd3 (NUM_MOVI  NUMBER) RETURN VARCHAR IS
        v_num_abonado  GA_ABOCEL.NUM_ABONADO%TYPE;
        v_out_serie STRING(512);
        v_out_imei  STRING(512);
        v_out STRING(512);
        larg_serie  NUMBER;
        larg_imei   NUMBER;
        sTabla      VARCHAR2(1);
        TIPO_TECNO  ICC_MOVIMIENTO.tip_tecnologia%TYPE;
        SVAL_CLAVE_SERIE  GED_PARAMETROS.VAL_PARAMETRO%TYPE;
        SVAL_TECNO_GSM GED_PARAMETROS.VAL_PARAMETRO%TYPE;
        LV_Tabla     VARCHAR2(1);
BEGIN
     GN_cod_producto  :=   1;
      GV_cod_modulo    :='GA';
     BEGIN
     GV_nom_parametro :='COD_CLAVE_SERIE';
     SELECT  TRIM(VAL_PARAMETRO)
     INTO  SVAL_CLAVE_SERIE
     FROM GED_PARAMETROS
     WHERE
     NOM_PARAMETRO = GV_nom_parametro AND
     COD_MODULO    = GV_cod_modulo    AND
     COD_PRODUCTO  = GN_cod_producto ;
     EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN 'ERROR '||'PARAMETRO DESDE QUE SERIE SACA CLAVE';
        WHEN OTHERS THEN
            RETURN 'ERROR '||SQLERRM;
      END;

     BEGIN
      GV_nom_parametro :='TECNOLOGIA_GSM';
     SELECT  TRIM(VAL_PARAMETRO)
     INTO  SVAL_TECNO_GSM
     FROM GED_PARAMETROS
     WHERE
     NOM_PARAMETRO = GV_nom_parametro AND
     COD_MODULO    = GV_cod_modulo    AND
     COD_PRODUCTO  = GN_cod_producto ;
     EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN 'ERROR '||'PARAMETRO PARA TECNLOGIA GSM';
        WHEN OTHERS THEN
            RETURN 'ERROR '||SQLERRM;
      END;

     BEGIN
        SELECT NUM_ABONADO, tip_tecnologia
        INTO v_num_abonado,TIPO_TECNO
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = NUM_MOVI;

        EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN 'ERROR'||' MOVIMIENTO NO EXISTE';
        WHEN OTHERS THEN
            RETURN 'ERROR|'||SQLERRM;
      END;

     BEGIN
         LV_Tabla := 'P';
        SELECT num_serie, num_imei,LV_Tabla
        INTO v_out_serie,v_out_imei, sTabla
        FROM GA_ABOCEL
        WHERE NUM_ABONADO = v_num_abonado;

        EXCEPTION
        WHEN NO_DATA_FOUND THEN
             LV_Tabla := 'A';
             SELECT num_serie, num_imei, LV_Tabla
             INTO v_out_serie,v_out_imei, sTabla
             FROM GA_ABOAMIST
             WHERE NUM_ABONADO = v_num_abonado;
         WHEN OTHERS THEN
            RETURN 'ERROR|'||SQLERRM;
       END;

      larg_serie := LENGTH(v_out_serie);
      v_out := SUBSTR(v_out_serie,(larg_serie - 3),4);

      IF TIPO_TECNO = SVAL_TECNO_GSM THEN

        IF SVAL_CLAVE_SERIE = '1' THEN --Se obtiene desde NUM_IMEI - TERMINAL GSM

           IF v_out_imei IS NULL THEN
                 RETURN 'ERROR'||' Abonado sin serie de terminal GSM';
           END IF;

             larg_imei  := LENGTH(v_out_imei);
           v_out := SUBSTR(v_out_imei,(larg_IMEI - 3),4);

        END IF;

      END IF;

      IF v_out <> ' ' THEN

           IF sTabla = 'P' THEN

            BEGIN
                 UPDATE GA_ABOCEL
                SET COD_PASSWORD = v_out
                WHERE NUM_ABONADO = v_num_abonado;
            EXCEPTION
                WHEN OTHERS THEN
                  --  ROLLBACK;
                    RETURN 'ERROR (P) '||SQLERRM;
            END;

         ELSE

            BEGIN
                 UPDATE GA_ABOAMIST
                SET COD_PASSWORD = v_out
                WHERE NUM_ABONADO = v_num_abonado;
            EXCEPTION
                WHEN OTHERS THEN
                  --  ROLLBACK;
                    RETURN 'ERROR (A) '||SQLERRM;
            END;

         END IF;

      END IF;

      RETURN v_out;

      EXCEPTION
          WHEN OTHERS THEN
             RETURN 'ERROR|'||SQLERRM;

END ;



----------------------------------------------------------------------------
-- FN_TMC_CICLO .- Funcion que retorna los valor ciclo (cambio de ciclo) y
-- codigo cliente destion (cambio cliente)
-- Domingo 3-Agosto-2003
----------------------------------------------------------------------------
FUNCTION FN_TMC_CICLO(V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN VARCHAR2 IS
    v_out STRING(512);
    v_comando_sql  VARCHAR2(200);

    error_proceso EXCEPTION;
  BEGIN
  v_out:= PV_REC_GESTORCENTRAL_FN(V_NUM_MOV);

    RETURN v_out ;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_TMC_CICLO, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_TMC_CICLO, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
  END;




----------------------------------------------------------------------------
----------------------------------------------------------------------------
-- MPR (Puerto Rico) --
----------------------------------------------------------------------------
----------------------------------------------------------------------------
----------------------------------------------------------------------------
-- FN_MPR_NUMCEL --
----------------------------------------------------------------------------
  FUNCTION FN_MPR_numcel(V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
        v_num_cel VARCHAR(512);
        v_num_cel_nue VARCHAR(512);
    error_proceso EXCEPTION;
  BEGIN

    SELECT NVL(TO_CHAR(num_celular), CHR(0)), NVL(TO_CHAR(num_celular_nue),CHR(0))
        INTO v_num_cel, v_num_cel_nue
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        IF v_num_cel_nue = CHR(0) THEN
      v_out := v_num_cel || '|' || v_num_cel;
        ELSE
          v_out := v_num_cel || '|' || v_num_cel_nue;
        END IF;

    RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_MPR_numcel, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_MPR_numcel, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
  END;

----------------------------------------------------------------------------
-- FN_MPR_NUMPER --
----------------------------------------------------------------------------
  FUNCTION FN_MPR_numper(V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
        v_num_per VARCHAR(512);
        v_num_per_nue VARCHAR(512);
    error_proceso EXCEPTION;
--      v_mov ICC_MOVIMIENTO%ROWTYPE;
  BEGIN

    SELECT NVL(NUM_PERSONAL, CHR(0)), NVL(num_personal_nue,CHR(0))
        INTO v_num_per, v_num_per_nue
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        IF v_num_per_nue = CHR(0) THEN
          v_out := v_num_per || '|' || v_num_per;
        ELSE
          v_out := v_num_per || '|' || v_num_per_nue;
        END IF;

    RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_MPR_numper, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_MPR_numper, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
  END;

----------------------------------------------------------------------------
-- FN_MPR_NUMSER --
----------------------------------------------------------------------------
  FUNCTION FN_MPR_numser(V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
        v_num_ser VARCHAR(512);
        v_num_ser_nue VARCHAR(512);
    error_proceso EXCEPTION;
  BEGIN

    SELECT NVL(NUM_SERIE, CHR(0)), NVL(NUM_SERIE_nue, CHR(0))
        INTO v_num_ser, v_num_ser_nue
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;


        IF v_num_ser_nue = CHR(0) THEN
          v_out := v_num_ser || '|' || v_num_ser;
        ELSE
          v_out := v_num_ser || '|' || v_num_ser_nue;
        END IF;

    RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_MPR_numser, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_MPR_numser, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
  END;

----------------------------------------------------------------------------
-- FN_MPR_NUMENRUT --
----------------------------------------------------------------------------
  FUNCTION FN_MPR_numenrut(V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
        v_cod_mod ICC_MOVIMIENTO.cod_modulo%TYPE;
        v_num_cel VARCHAR (512);
        v_cod_enrut ICC_MOVIMIENTO.cod_enrutamiento%TYPE;
    error_proceso EXCEPTION;
  BEGIN

    SELECT NVL(TO_CHAR(num_celular), CHR(0)), NVL(cod_modulo, CHR(0)), NVL(TO_CHAR(cod_enrutamiento),CHR(0))
        INTO v_num_cel, v_cod_mod, v_cod_enrut
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;


        SELECT NVL(TO_CHAR(num_enrutamiento), CHR(0))
        INTO v_out
        FROM GED_ENRUTAMIENTO
        WHERE cod_enrutamiento = v_cod_enrut
        AND cod_modulo = v_cod_mod;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

    RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_MPR_numenrut, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_MPR_numenrut, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
  END;

----------------------------------------------------------------------------
-- FN_MPR_TIPENRUT --
----------------------------------------------------------------------------
  FUNCTION FN_MPR_tipenrut(V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    V_OUT STRING(512);
    error_proceso EXCEPTION;
  BEGIN

    SELECT NVL(TO_CHAR(tip_enrutamiento), CHR(0)) INTO v_out
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_MPR_tipenrut, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_MPR_tipenrut, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
  END;

----------------------------------------------------------------------------
-- FN_MPR_IDVM --
----------------------------------------------------------------------------
FUNCTION FN_MPR_idvm(V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
    v_tabla STRING(512);
    v_num_cel icc_movimiento.num_celular%TYPE;
    v_num_cel_nue icc_movimiento.num_celular_nue%TYPE;
    v_num_min NUMBER(15);
    v_sqlcode NUMBER;
    v_numtabla NUMBER(1);

BEGIN
 /* Se cambia la función por incidencia CP-200405140372 */
 /* 18-05-2004 Germán Garrido Espinoza - Interfaz con Centrales */

    v_numtabla:=1;
    SELECT NVL(num_celular, 0), NVL(num_celular_nue,0) INTO v_num_cel, v_num_cel_nue
    FROM icc_movimiento
    WHERE num_movimiento = v_num_mov;

    v_numtabla:=2;
    SELECT val_id INTO v_out FROM icd_idvoicemail
    WHERE v_num_cel>=num_cel_desde AND v_num_cel<=num_cel_hasta;

    -- Si no encuentra el valor con el numero de celular, pruebo con el min si hay numero de celular nuevo
   RETURN v_out;

EXCEPTION
    WHEN OTHERS THEN
      BEGIN
          v_sqlcode := SQLCODE;
            IF v_sqlcode = 100 AND v_numtabla=2 THEN
                v_numtabla:=3;
                 SELECT NUM_MIN INTO v_num_min FROM ADN_PORTADO_IN_TO
                WHERE NUM_CELULAR=v_num_cel;

                  v_numtabla:=2;
                           SELECT val_id INTO v_out FROM icd_idvoicemail
                        WHERE v_num_min BETWEEN num_cel_desde AND num_cel_hasta;
          END IF;

          RETURN v_out;

          EXCEPTION
                WHEN OTHERS THEN
                IF v_numtabla = 3 THEN
                    v_out:='ERROR FN_MPR_idvm(ADN_PORTADO_IN_TO), SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
                END IF;
                IF v_numtabla = 2 THEN
                    v_out:='ERROR FN_MPR_idvm(icd_idvoicemail), SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
                END IF;
                RETURN v_out;

        END;

END;

----------------------------------------------------------------------------
-- FN_MPR_CODPIN --
----------------------------------------------------------------------------
  FUNCTION FN_MPR_codpin(V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    V_OUT STRING(512);
    error_proceso EXCEPTION;
  BEGIN

    SELECT NVL(cod_pin, CHR(0)) INTO v_out
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_MPR_codpin, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_MPR_codpin, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
  END;

----------------------------------------------------------------------------
-- FN_MPR_FECSYS --
----------------------------------------------------------------------------
  FUNCTION FN_MPR_fecsys(V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    V_OUT STRING(512);
    LV_formato VARCHAR2(10):='MM/DD/YYYY';
    error_proceso EXCEPTION;
  BEGIN

        v_out:= TO_CHAR(SYSDATE, LV_formato);
        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_MPR_fecsys, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_MPR_fecsys, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
  END;

----------------------------------------------------------------------------
-- FN_MPR_CODPLAN --
----------------------------------------------------------------------------
  FUNCTION FN_MPR_codplan(V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    V_OUT        STRING(512);
    V_CODE       STRING(5);
    V_PLAN       ICC_MOVIMIENTO.PLAN%TYPE;
    V_TIP_TECNO  ICC_MOVIMIENTO.tip_tecnologia%TYPE;
    error_proceso EXCEPTION;
    error_homologacion EXCEPTION;
  BEGIN

       SELECT NVL(PLAN, CHR(0)), NVL(TIP_TECNOLOGIA, CHR(0)) INTO v_plan, v_tip_tecno
       FROM ICC_MOVIMIENTO
       WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

       IF substr(v_tip_tecno,1,3) = 'CDM' THEN

          v_out := Pv_Homologacionplan_Fn(v_plan);

          v_code := SUBSTR(v_out,1,4);
          IF v_code = 'ORA-' THEN
             RAISE error_homologacion;
          END IF;
       ELSE
          v_out := v_plan;
       END IF;

       v_out := v_out || '|' || v_out;
       RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_MPR_codplan, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN error_homologacion THEN
      RETURN 'ERROR FN_MPR_codplan, SLQERRM:' || v_out;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_MPR_codplan, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
  END;

----------------------------------------------------------------------------
-- FN_MPR_MTOCARGA --
----------------------------------------------------------------------------
  FUNCTION FN_MPR_mtocarga(V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    V_OUT STRING(512);
    error_proceso EXCEPTION;
  BEGIN

    SELECT NVL(TO_CHAR(carga), CHR(0)) INTO v_out
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_MPR_mtocarga, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_MPR_mtocarga, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
  END;

----------------------------------------------------------------------------
-- FN_MPR_CODAKEY --
----------------------------------------------------------------------------
  FUNCTION FN_MPR_codakey(V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
        v_num_serie ICC_MOVIMIENTO.num_serie%TYPE;
        v_num_serie1 ICC_MOVIMIENTO.num_serie%TYPE;
        v_num_serie2 ICC_MOVIMIENTO.num_serie%TYPE;
        v_cod_act ICC_MOVIMIENTO.cod_actabo%TYPE;
        v_hex GA_ABOCEL.num_seriehex%TYPE;
        v_dec GA_ABOCEL.num_serie%TYPE;
    error_proceso EXCEPTION;
  BEGIN
    SELECT cod_actabo
        INTO v_cod_act
    FROM ICC_MOVIMIENTO
    WHERE num_movimiento = v_num_mov;
    IF SQLCODE <> 0 THEN
      RAISE error_proceso;
    END IF;
    IF v_cod_act = 'CE' THEN
        SELECT TO_CHAR(FN_GEN_HexToNum(SUBSTR(NVL(num_serie_nue, CHR('00')),1,2))), TO_CHAR(FN_GEN_HexToNum(SUBSTR(NVL(num_serie_nue, CHR(0)),3)))
        INTO v_num_serie1, v_num_serie2
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;
        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;
    ELSE
        SELECT TO_CHAR(FN_GEN_HexToNum(SUBSTR(NVL(num_serie, CHR('00')),1,2))), TO_CHAR(FN_GEN_HexToNum(SUBSTR(NVL(num_serie, CHR(0)),3)))
        INTO v_num_serie1, v_num_serie2
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;
        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;
    END IF;
        v_dec := SUBSTR('000'||v_num_serie1, LENGTH(v_num_serie1)+1, 3)||SUBSTR('00000000'||v_num_serie2, LENGTH(v_num_serie2)+1, 8);
    -- Se asume serie hexadecimal => hay que convertirla a decimal --
    SELECT NVL(a_key_cryp, CHR(0))
    INTO v_out
    FROM ICT_AKEYS
    WHERE num_esn = v_dec;
        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;
    RETURN v_out;
  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_MPR_codakey, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_MPR_codakey, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
  END;

----------------------------------------------------------------------------
-- FN_MPR_MENSAJE2 --
----------------------------------------------------------------------------
  FUNCTION FN_MPR_mensaje2(v_num_mov IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
    error_proceso EXCEPTION;
  BEGIN

    SELECT NVL(des_mensaje, CHR(0)) INTO v_out
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_MPR_mensaje2, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_MPR_mensaje2, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
  END;

----------------------------------------------------------------------------
-- FN_MPR_STATUS --
----------------------------------------------------------------------------

  FUNCTION FN_MPR_status(v_num_mov IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
    error_proceso EXCEPTION;
  BEGIN

    SELECT NVL(sta, CHR(0)) INTO v_out
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_MPR_status, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_MPR_status, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
  END;

----------------------------------------------------------------------------
-- FN_MPR_IDIOMA --
----------------------------------------------------------------------------
  FUNCTION FN_MPR_idiomaPP(v_num_mov IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
        v_cod_idi ICC_MOVIMIENTO.cod_idioma%TYPE;
        v_cod_cen ICC_MOVIMIENTO.cod_central%TYPE;
        v_cod_sis ICG_CENTRAL.cod_sistema%TYPE;
    error_proceso EXCEPTION;
  BEGIN

    SELECT NVL(cod_idioma, 0), NVL(cod_central, 0)
        INTO v_cod_idi, v_cod_cen
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        SELECT NVL(cod_sistema, 0)
        INTO v_cod_sis
        FROM ICG_CENTRAL
        WHERE cod_producto = 1
        AND cod_central = v_cod_cen;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        SELECT NVL(val_idioma_plat, CHR(0))
        INTO v_out
        FROM ICD_IDIOMAPLAT
        WHERE cod_sistema = v_cod_sis
        AND cod_idioma = v_cod_idi;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_MPR_idiomaPP, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_MPR_idiomaPP, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
  END;

----------------------------------------------------------------------------
-- FN_MPR_NUMCELNUE --
----------------------------------------------------------------------------
  FUNCTION FN_MPR_numcelnue(v_num_mov IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
    error_proceso EXCEPTION;
  BEGIN

    SELECT NVL(TO_CHAR(num_celular_nue), CHR(0))
        INTO v_out
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

    RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_MPR_numcelnue, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
          RAISE_APPLICATION_ERROR(-20000, 'ERROR OTHERS');
      RETURN 'ERROR FN_MPR_numcelnue, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
  END;

----------------------------------------------------------------------------
-- FN_MPR_NPA --
----------------------------------------------------------------------------
  FUNCTION FN_MPR_npa(V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
        v_num_cel VARCHAR(512);
        v_num_cel_nue VARCHAR(512);
    error_proceso EXCEPTION;
  BEGIN

    SELECT NVL(TO_CHAR(num_celular), CHR(0)), NVL(TO_CHAR(num_celular_nue),CHR(0))
        INTO v_num_cel, v_num_cel_nue
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        IF v_num_cel_nue = CHR(0) THEN
          v_out := SUBSTR(v_num_cel,1,3) || '|' || SUBSTR(v_num_cel,1,3);
        ELSE
          v_out := SUBSTR(v_num_cel,1,3) || '|' || SUBSTR(v_num_cel_nue,1,3);
        END IF;

    RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_MPR_npa, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_MPR_npa, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
  END;


----------------------------------------------------------------------------
-- FN_MPR_NXX --
----------------------------------------------------------------------------
  FUNCTION FN_MPR_nxx(V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
        v_num_cel VARCHAR(512);
        v_num_cel_nue VARCHAR(512);
    error_proceso EXCEPTION;
  BEGIN

    SELECT NVL(TO_CHAR(num_celular), CHR(0)), NVL(TO_CHAR(num_celular_nue),CHR(0))
        INTO v_num_cel, v_num_cel_nue
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        IF v_num_cel_nue = CHR(0) THEN
          v_out := SUBSTR(v_num_cel,4,3) || '|' || SUBSTR(v_num_cel,4,3);
        ELSE
          v_out := SUBSTR(v_num_cel,4,3) || '|' || SUBSTR(v_num_cel_nue,4,3);
        END IF;

    RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_MPR_nxx, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_MPR_nxx, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
  END;

----------------------------------------------------------------------------
-- FN_MPR_MDN --
----------------------------------------------------------------------------
  FUNCTION FN_MPR_mdn(V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
        v_num_cel VARCHAR(512);
        v_num_cel_nue VARCHAR(512);
    error_proceso EXCEPTION;
  BEGIN

    SELECT NVL(TO_CHAR(num_celular), CHR(0)), NVL(TO_CHAR(num_celular_nue),CHR(0))
        INTO v_num_cel, v_num_cel_nue
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        IF v_num_cel_nue = CHR(0) THEN
          v_out := SUBSTR(v_num_cel,7,4) || '|' || SUBSTR(v_num_cel,7,4);
        ELSE
          v_out := SUBSTR(v_num_cel,7,4) || '|' || SUBSTR(v_num_cel_nue,7,4);
        END IF;

    RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_MPR_mdn, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_MPR_mdn, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
  END;

----------------------------------------------------------------------------
-- FN_MPR_VM_CFW                               --
----------------------------------------------------------------------------
FUNCTION FN_MPR_vm_cfw(V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
        v_out STRING(512);
        v_num_abo ICC_MOVIMIENTO.NUM_ABONADO%TYPE;
        v_cod_ser ICC_MOVIMIENTO.cod_servicios%TYPE;
        v_cod_act ICC_MOVIMIENTO.cod_actuacion%TYPE;
        v_tip_ter ICC_MOVIMIENTO.tip_terminal%TYPE;
        v_cod_ser_act ICG_ACTUACION.cod_servicio%TYPE;
        v_cod_ser_act_ter_cen ICG_ACTUACIONTERCEN.cod_servicios%TYPE;
        v_ser_tot VARCHAR2(1024);
    v_ser_tot_m VARCHAR2(1024);
    v_num_vm NUMBER;
        v_num_cfw NUMBER;
        v_tmp VARCHAR2(100);
        v_cod_ser_abocel GA_ABOCEL.CLASE_SERVICIO%TYPE;
        v_cod_ser_aboamist GA_ABOAMIST.CLASE_SERVICIO%TYPE;
        v_cod_ser_vm GED_PARAMETROS.VAL_PARAMETRO%TYPE;
        v_cod_ser_cfw GED_PARAMETROS.VAL_PARAMETRO%TYPE;
        TYPE t_ser IS TABLE OF VARCHAR2(2) INDEX BY BINARY_INTEGER;
        TYPE t_niv IS TABLE OF VARCHAR2(4) INDEX BY BINARY_INTEGER;
        v_ser t_ser;
        v_niv t_niv;
    v_ser_m t_ser;
        v_niv_m t_niv;
        v_ser_tmp VARCHAR2(6);
        v_ind NUMBER;
    v_ser_tmp_m VARCHAR2(6);
        v_ind_m NUMBER;
        i     NUMBER;
        v_cont NUMBER DEFAULT 1;
        v_cont_m NUMBER DEFAULT 1;
        v_cel BOOLEAN;
        v_amist BOOLEAN;
        v_vm  BOOLEAN;
    v_vm_m  BOOLEAN;
        v_cfw BOOLEAN;
        v_len_ser NUMBER;
    v_len_ser_m NUMBER;
    error_proceso EXCEPTION;
  BEGIN

    v_tmp := '1';

    SELECT NVL(NUM_ABONADO, 0), cod_servicios, NVL(cod_actuacion, 0), NVL(tip_terminal,CHR(0))
        INTO v_num_abo, v_cod_ser, v_cod_act, v_tip_ter
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        -- Buscar servicios en : --

        -- ICG_ACTUACION --
        v_tmp := '2';

        SELECT cod_servicio
        INTO v_cod_ser_act
        FROM ICG_ACTUACION
        WHERE cod_producto = 1
        AND cod_actuacion = v_cod_act;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;


        -- ICG_ACTUACIONTERCEN --
        v_tmp := '3';

        BEGIN

        SELECT cod_servicios
        INTO v_cod_ser_act_ter_cen
        FROM ICG_ACTUACIONTERCEN
        WHERE cod_producto = 1
        AND cod_actuacion = v_cod_act
        AND tip_terminal = v_tip_ter;

        EXCEPTION
          WHEN NO_DATA_FOUND THEN NULL;
        END;

        v_tmp := '4';

        BEGIN
        SELECT clase_servicio
        INTO v_cod_ser_abocel
        FROM GA_ABOCEL
        WHERE NUM_ABONADO = v_num_abo;

        EXCEPTION
          WHEN NO_DATA_FOUND THEN
          BEGIN
                SELECT clase_servicio
        INTO v_cod_ser_aboamist
            FROM GA_ABOAMIST
        WHERE NUM_ABONADO = v_num_abo;

          EXCEPTION
          WHEN NO_DATA_FOUND THEN
             RAISE error_proceso;
          END;
        END;

        v_tmp := '5';

        v_ser_tot:= LTRIM(RTRIM(v_cod_ser)) || LTRIM(RTRIM(v_cod_ser_act)) || LTRIM(RTRIM(v_cod_ser_act_ter_cen)) || LTRIM(RTRIM(v_cod_ser_abocel)) || LTRIM(RTRIM(v_cod_ser_aboamist));

    v_ser_tot_m := LTRIM(RTRIM(v_cod_ser));

        v_ind := 1;
        v_len_ser := LENGTH(v_ser_tot);

        WHILE v_cont < v_len_ser LOOP
           v_ser_tmp := SUBSTR(v_ser_tot,v_cont,6);
           v_ser(v_ind) := SUBSTR(v_ser_tmp,1,2);
           v_niv(v_ind) := SUBSTR(v_ser_tmp,3,4);
           v_ind := v_ind + 1;
           v_cont := v_cont+6;
    END LOOP;

    v_tmp := '6';

    SELECT val_parametro
    INTO v_cod_ser_vm
    FROM GED_PARAMETROS
    WHERE cod_modulo = 'IC'
    AND nom_parametro = 'COD_SERV_VM';

    IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        v_tmp := '7';

    SELECT val_parametro
        INTO v_cod_ser_cfw
    FROM GED_PARAMETROS
    WHERE cod_modulo = 'IC';

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;


        v_ser_tot_m := LTRIM(RTRIM(v_cod_ser));

        v_ind_m := 1;
        v_len_ser_m := LENGTH(v_ser_tot_m);

    v_vm_m := FALSE;

    WHILE v_cont_m < v_len_ser_m LOOP
           v_ser_tmp_m := SUBSTR(v_ser_tot_m,v_cont_m,6);
           v_ser_m(v_ind_m) := SUBSTR(v_ser_tmp_m,1,2);
           v_niv_m(v_ind_m) := SUBSTR(v_ser_tmp_m,3,4);

       IF (v_ser(v_ind_m) = v_cod_ser_vm AND TO_NUMBER(v_niv_m(v_ind_m)) = 0 )  THEN
             v_vm_m := TRUE;
         v_cont_m := v_len_ser_m;
       END IF;
       v_ind_m := v_ind_m + 1;
           v_cont_m := v_cont_m+6;
      END LOOP;


      FOR i IN 1..v_ind-1 LOOP
      IF v_ser(i) = v_cod_ser_vm AND TO_NUMBER(v_niv(i)) > 0 THEN
             v_vm := TRUE;
          END IF;
      IF v_ser(i) = v_cod_ser_cfw AND TO_NUMBER(v_niv(i)) > 0 THEN
             v_cfw := TRUE;
          END IF;
          IF v_vm = TRUE AND v_cfw = TRUE THEN
             EXIT;
          END IF;
        END LOOP;


     IF v_vm_m = TRUE THEN
           v_vm := FALSE;
    ELSE
        v_vm := TRUE;
    END IF;


    IF v_vm = TRUE AND v_cfw = TRUE THEN
          v_out := 'icfbmrs=y ccfbbmrs=y ccfbmrs=y';
    ELSE
          v_out := 'icfbmrs=n ccfbbmrs=n ccfbmrs=n';
    END IF;


    RETURN v_out;

EXCEPTION
  WHEN error_proceso THEN
    RETURN 'ERROR FN_MPR_vm_cfw, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM || v_tmp;
  WHEN OTHERS THEN
    RETURN 'ERROR FN_MPR_vm_cfw, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM || v_tmp;
  END;


----------------------------------------------------------------------------
-- FN_TMC_PASSICC -- Password abonado ultimos 4 digitos num_movimiento
----------------------------------------------------------------------------
FUNCTION FN_TMC_PASSICC(V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
  v_num_pass STRING(4);
  error_proceso EXCEPTION;
 BEGIN

   SELECT NVL(SUBSTR(icc, LENGTH(icc) -3 ),CHR(0))
   INTO v_num_pass
   FROM ICC_MOVIMIENTO
   WHERE num_movimiento = v_num_mov;


   IF SQLCODE <> 0 THEN
      RAISE error_proceso;
   END IF;

   RETURN v_num_pass;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RETURN NULL;
    WHEN error_proceso THEN
      RETURN 'ERROR FN_TMC_passicc, SQLCODE:' || TO_CHAR(SQLCODE) || '-SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_TMC_passicc, SQLCODE:' || TO_CHAR(SQLCODE) || '-SLQERRM:' || SQLERRM;


 END;

----------------------------------------------------------------------------
-- GA_OBTIENE_SERIE                                                       --
----------------------------------------------------------------------------
FUNCTION GA_OBTIENE_SERIE (v_num_mov IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN VARCHAR2
IS

    nNumAbonado        ICC_MOVIMIENTO.NUM_ABONADO%TYPE;
    sParamTec        GED_PARAMETROS.VAL_PARAMETRO%TYPE;
    sNumSerieTec    GA_MODABOCEL.NUM_SERIEHEX%TYPE;
    LV_cod_tipmodi  ga_modabocel.cod_tipmodi%type;
BEGIN

    BEGIN
        SELECT NUM_ABONADO
        INTO nNumAbonado
        FROM ICC_MOVIMIENTO
        WHERE NUM_MOVIMIENTO = v_num_mov;

    EXCEPTION
                WHEN NO_DATA_FOUND THEN
                        RETURN 'FALSE'||'ABONADO NO EXISTE';
                WHEN OTHERS THEN
                        RETURN 'FALSE|'||SQLERRM;
        END;

    BEGIN
         GV_nom_parametro := 'TECNOLOGIA_TDMA';
         GV_cod_modulo    := 'GA';
         GN_cod_producto  := 1;

        SELECT VAL_PARAMETRO
        INTO sParamTec
        FROM GED_PARAMETROS
        WHERE NOM_PARAMETRO = GV_nom_parametro
          AND COD_MODULO    = GV_cod_modulo
          AND COD_PRODUCTO  = GN_cod_producto;

    EXCEPTION
                WHEN NO_DATA_FOUND THEN
                        RETURN 'FALSE'||'PARAMETRO NO EXISTE';
                WHEN OTHERS THEN
                        RETURN 'FALSE|'||SQLERRM;
        END;

    BEGIN
        LV_cod_tipmodi:='CE';
        SELECT NUM_SERIEHEX
        INTO sNumSerieTec
        FROM GA_MODABOCEL
        WHERE NUM_ABONADO = nNumAbonado
        AND COD_TIPMODI = LV_cod_tipmodi
        AND COD_TECNOLOGIA = sParamTec
        AND FEC_MODIFICA = (SELECT MAX(FEC_MODIFICA)
                        FROM GA_MODABOCEL
                    WHERE NUM_ABONADO = nNumAbonado
                    AND COD_TIPMODI = LV_cod_tipmodi
                    AND COD_TECNOLOGIA =sParamTec) ;

    EXCEPTION
                WHEN NO_DATA_FOUND THEN
                        RETURN 'FALSE'||'SERIE NO EXISTE';
                WHEN OTHERS THEN
                        RETURN 'FALSE|'||SQLERRM;
        END;

    RETURN sNumSerieTec;

EXCEPTION
        WHEN OTHERS THEN
             RETURN NULL;
END;

FUNCTION FN_MPR_nummin(V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
    v_num_cel VARCHAR(512);
    v_num_cel_nue VARCHAR(512);
    v_nummin VARCHAR2(512);
    v_nummin_n VARCHAR2(512);
    v_dummy NUMBER(20);
    v_dummy_n NUMBER(20);
    error_proceso EXCEPTION;
    error_negocio_0 EXCEPTION;
    error_negocio_1 EXCEPTION;
    error_negocio_2 EXCEPTION;
    error_negocio_3 EXCEPTION;
    error_GE_FN_MIN_DE_MDN EXCEPTION;
  BEGIN

    SELECT NVL(TO_CHAR(num_celular), CHR(0)), NVL(TO_CHAR(num_celular_nue),CHR(0))
        INTO v_num_cel, v_num_cel_nue
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;


        IF v_num_cel_nue = CHR(0) THEN
          v_dummy:=Ge_Fn_Min_De_Mdn(v_num_cel);

        ELSE
          v_dummy:=Ge_Fn_Min_De_Mdn(v_num_cel);
          v_dummy_n:=Ge_Fn_Min_De_Mdn(v_num_cel_nue);

        END IF;

        IF v_dummy=0 THEN
           RAISE error_negocio_0;
        ELSIF v_dummy=1 THEN
           RAISE error_negocio_1;
        ELSIF v_dummy=2 THEN
           RAISE error_negocio_2;
        ELSIF v_dummy=3 THEN
           RAISE error_negocio_3;
        ELSIF v_dummy<0 THEN
           RAISE error_GE_FN_MIN_DE_MDN;
        END IF;

        v_nummin:= TO_CHAR(v_dummy);
        v_nummin_n:= TO_CHAR(v_dummy_n);

        IF v_num_cel_nue = CHR(0) THEN
          v_out := v_nummin || '|' || v_nummin;
        ELSE
          v_out := v_nummin || '|' || v_nummin_n;
        END IF;

    RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_MPR_nummin, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN error_GE_FN_MIN_DE_MDN THEN
      RETURN 'ERROR DE PROCESO EN GE_FN_MIN_DE_MDN, SQLCODE:' || TO_CHAR(v_dummy) || ' SLQERRM:' || TO_CHAR(v_dummy);
    WHEN error_negocio_0 THEN
      RETURN 'ERROR DE NEGOCIO EN GE_FN_MIN_DE_MDN, SQLCODE:' || TO_CHAR(v_dummy) || ' SLQERRM: No existe el número de MDN';
    WHEN error_negocio_1 THEN
      RETURN 'ERROR DE NEGOCIO EN GE_FN_MIN_DE_MDN, SQLCODE:' || TO_CHAR(v_dummy) || ' SLQERRM: Error en el largo del MDN';
    WHEN error_negocio_2 THEN
      RETURN 'ERROR DE NEGOCIO EN GE_FN_MIN_DE_MDN, SQLCODE:' || TO_CHAR(v_dummy) || ' SLQERRM: Error de formato (contiene caracteres no númericos)';
    WHEN error_negocio_3 THEN
      RETURN 'ERROR DE NEGOCIO EN GE_FN_MIN_DE_MDN, SQLCODE:' || TO_CHAR(v_dummy) || ' SLQERRM: Error comienza con cero';
    WHEN OTHERS THEN
      RETURN 'ERROR FN_MPR_nummin, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;

END;


----------------------------------------------------------------------------
-- FN_TMM_CODCAUSA-- Codigo de la causa de Suspension Rehabilitacion
----------------------------------------------------------------------------
  FUNCTION FN_TMM_codcausa(V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    V_OUT STRING(512);
    error_proceso EXCEPTION;
  BEGIN

    SELECT NVL(COD_SUSPREHA, CHR(0)) INTO v_out
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_TMM_codcausa, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_TMM_codcausa, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
  END;


----------------------------------------------------------------------------
-- FN_TMM_CODCAUSA-- Codigo de la causa de Baja de Abonado
----------------------------------------------------------------------------
  FUNCTION FN_TMM_codcausabaja(V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS

    error_proceso EXCEPTION;
    v_num_abonado ICC_MOVIMIENTO.NUM_ABONADO%TYPE;
    v_out GA_ABOCEL.COD_CAUSABAJA%TYPE;
  BEGIN

      SELECT NVL(NUM_ABONADO, 0) INTO v_num_abonado
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

    IF SQLCODE <> 0 THEN
          RAISE error_proceso;
    END IF;

    v_out := CHR(0);

    BEGIN
       SELECT NVL(COD_CAUSABAJA, CHR(0))
       INTO v_out
       FROM GA_ABOCEL
       WHERE NUM_ABONADO = v_num_abonado;

    EXCEPTION
          WHEN NO_DATA_FOUND THEN

           SELECT NVL(COD_CAUSABAJA, CHR(0))
            INTO v_out
            FROM GA_ABOAMIST
            WHERE NUM_ABONADO = v_num_abonado;

    END;

    RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_TMM_codcausabaja, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;

    WHEN OTHERS THEN
      RETURN 'ERROR OTHER FN_TMM_codcausabaja, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
  END;

----------------------------------------------------------------------------
-- FN_TMM_clavegen-- Obtine clave generica
----------------------------------------------------------------------------
  FUNCTION FN_TMM_clavegen(V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS

    error_proceso EXCEPTION;
    v_num_abonado ICC_MOVIMIENTO.NUM_ABONADO%TYPE;
    SNUM_SERIE GA_ABOCEL.NUM_SERIE%TYPE;
    v_out  GA_ABOCEL.NUM_SERIE%TYPE;
    MAXI  INTEGER;

  BEGIN

    v_out := '';

      SELECT NVL(NUM_ABONADO, 0) INTO v_num_abonado
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

    IF SQLCODE <> 0 THEN
          RAISE error_proceso;
    END IF;


    SELECT NUM_SERIE
        INTO SNUM_SERIE
        FROM GA_ABOCEL
        WHERE NUM_ABONADO = v_num_abonado;


        IF SNUM_SERIE = CHR(0) THEN
            v_out := '';
        ELSE
            MAXI := LENGTH(RTRIM(LTRIM(SNUM_SERIE)));
            MAXI := (MAXI - 3);
            v_out := SUBSTR(SNUM_SERIE,MAXI ,4);
        END IF;


   RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_TMM_clavegen, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_TMM_clavegen, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
  END;

----------------------------------------------------------------------------
-- FN_TMM_CODLISTA-- Retorna codigo de la Lista y item a dar de baja o alta
----------------------------------------------------------------------------
  FUNCTION FN_TMM_codLista(V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS

       error_proceso EXCEPTION;
 v_num_abonado ICC_MOVIMIENTO.NUM_ABONADO%TYPE;
 v_fec_ingreso ICC_MOVIMIENTO.fec_ingreso%TYPE;
 SNUM_FRECUENTE_ANT  PPT_NUMEROFRECUENTE.NUM_FRECUENTE_ANT%TYPE;
 SNUM_FRECUENTE      PPT_NUMEROFRECUENTE.NUM_FRECUENTE%TYPE;
 SIND_LISTA          PPT_NUMEROFRECUENTE.IND_LISTA%TYPE;
    vVAL_PARAMETRO     GED_PARAMETROS.VAL_PARAMETRO%TYPE;
    CANTIDAD            INTEGER:=0;
 sCOD_SERVICIO  GA_SERVSUPLABO.COD_SERVICIO%TYPE;

 CURSOR LISTAS IS
    SELECT COD_VALOR,DES_VALOR
 FROM GED_CODIGOS
    WHERE NOM_TABLA='PPT_NUMEROFRECUENTE' AND NOM_COLUMNA ='IND_LISTA';


  BEGIN

   SELECT NVL(NUM_ABONADO, 0), fec_ingreso
  INTO v_num_abonado, v_fec_ingreso
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

    IF SQLCODE <> 0 THEN
          RAISE error_proceso;
    END IF;

 SELECT COUNT(1) INTO CANTIDAD
 FROM PPT_NUMEROFRECUENTE
   WHERE
       NUM_ABONADO      = v_num_abonado
   AND FEC_MODIFICACION = v_fec_ingreso;

 IF CANTIDAD = 0 THEN
         RAISE error_proceso;
    END IF;

 IF CANTIDAD = 1 THEN
    SELECT NUM_FRECUENTE_ANT,NUM_FRECUENTE
    INTO SNUM_FRECUENTE_ANT,SNUM_FRECUENTE
   FROM PPT_NUMEROFRECUENTE
   WHERE
       NUM_ABONADO      = v_num_abonado
   AND FEC_MODIFICACION = v_fec_ingreso;
    ELSE
    SELECT NUM_FRECUENTE_ANT,NUM_FRECUENTE
    INTO SNUM_FRECUENTE_ANT,SNUM_FRECUENTE
   FROM PPT_NUMEROFRECUENTE
   WHERE
       NUM_ABONADO      = v_num_abonado
   AND FEC_MODIFICACION = v_fec_ingreso
   AND NUM_FRECUENTE_ANT IS NOT NULL;
      END IF;

  IF SNUM_FRECUENTE_ANT = CHR(0) THEN
     SNUM_FRECUENTE_ANT := 'NULO';
  END IF;


  SELECT COD_SERVICIO
        INTO sCOD_SERVICIO
     FROM GA_SERVSUPLABO
        WHERE NUM_ABONADO = v_num_abonado AND IND_ESTADO<3 AND COD_SERVICIO IN (SELECT COD_VALOR FROM GED_CODIGOS
                                     WHERE nom_tabla='PPT_NUMEROFRECUENTE' AND NOM_COLUMNA ='IND_LISTA');

     FOR C1 IN LISTAS LOOP
         BEGIN
       IF C1.COD_VALOR =SCOD_SERVICIO THEN
          SIND_LISTA:=C1.DES_VALOR;
          END IF;

         END;
        END LOOP;




 RETURN SIND_LISTA ||',cadItem='|| SNUM_FRECUENTE || ',cadItemAnt=' || SNUM_FRECUENTE_ANT ;


  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_TMM_codLista, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'FN_TMM_codLista, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
  END;

----------------------------------------------------------------------------
-- FN_TMM_promreca -- Obtine codigo de promocion de recgarga
----------------------------------------------------------------------------
  FUNCTION FN_TMM_promreca(V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS

    error_proceso EXCEPTION;
    v_out  GED_PARAMETROS.VAL_PARAMETRO%TYPE;

  BEGIN

    v_out := '';

    SELECT VAL_PARAMETRO
         INTO v_out
         FROM GED_PARAMETROS
         WHERE
             NOM_PARAMETRO   = 'COD_PROMRECAR'
         AND COD_MODULO      = 'GA'
         AND COD_PRODUCTO    = 1;

    IF SQLCODE <> 0 THEN
          RAISE error_proceso;
    END IF;

   RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_TMM_promreca, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_TMM_promreca, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
  END;

 -----------------------------------------------------------------------------------------
 -- FN_TMM_ICCTYPE-- Retorna valor TYPE de la tarjeta en funciona al ICC
 ----------------------------------------------------------------------------------------
 FUNCTION FN_TMM_ICCTYPE (v_num_mov IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
    v_tmp STRING(512);
    v_icc VARCHAR2(25);                -- Size according to iccMovimiento
    v_icc_nue VARCHAR2(25);                -- Size according to iccMovimiento
    v_comando_sql  VARCHAR2(200);
    error_proceso EXCEPTION;

  BEGIN

   -- Get ICC
  SELECT NVL(ICC, ''), NVL(ICC_NUE, CHR(0))
        INTO v_icc, v_icc_nue
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        IF v_icc_nue = CHR(0) THEN
           v_icc_nue := v_icc;
        END IF;

    -- Get TYPE a partir ICC

    v_tmp:= fRecuperSIMCARD_FN (v_icc,'TYPE');
    v_out := v_tmp;

    -- Get TYPE a partir ICCNue
    v_tmp:= fRecuperSIMCARD_FN(v_icc_nue,'TYPE');

    v_out := v_out || '|' || v_tmp;

    RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_TMM_infoicc, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_TMM_infoicc, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
  END;

 -----------------------------------------------------------------------------------------
 -- FN_TMM_ICCPROFILE-- Retorna valor PROFILE de la tarjeta en funciona al ICC
 ----------------------------------------------------------------------------------------
 FUNCTION FN_TMM_ICCPROFILE (v_num_mov IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
    v_tmp STRING(512);
    v_icc VARCHAR2(25);                -- Size according to iccMovimiento
    v_icc_nue VARCHAR2(25);                -- Size according to iccMovimiento
    v_comando_sql  VARCHAR2(200);
    error_proceso EXCEPTION;

  BEGIN

   -- Get ICC
  SELECT NVL(ICC, ''), NVL(ICC_NUE, CHR(0))
        INTO v_icc, v_icc_nue
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        IF v_icc_nue = CHR(0) THEN
           v_icc_nue := v_icc;
        END IF;

    -- Get TYPE a partir ICC
    v_tmp:= fRecuperSIMCARD_FN (v_icc,'PROFILE');

    v_out := v_tmp;

    -- Get TYPE a partir ICCNue
    v_tmp:= fRecuperSIMCARD_FN(v_icc_nue,'PROFILE');

    v_out := v_out || '|' || v_tmp;

    RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_TMM_ICCPROFILE, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_TMM_ICCPROFILE, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
  END;


-----------------------------------------------------------------------------------------
 -- FN_TMM_ICCPUK-- Retorna valor PUK de la tarjeta en funciona al ICC
 ----------------------------------------------------------------------------------------
 FUNCTION FN_TMM_ICCPUK (v_num_mov IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
    v_tmp STRING(512);
    v_icc VARCHAR2(25);                -- Size according to iccMovimiento
    v_icc_nue VARCHAR2(25);                -- Size according to iccMovimiento
    v_comando_sql  VARCHAR2(200);
    error_proceso EXCEPTION;

  BEGIN

   -- Get ICC
  SELECT NVL(ICC, ''), NVL(ICC_NUE, CHR(0))
        INTO v_icc, v_icc_nue
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        IF v_icc_nue = CHR(0) THEN
           v_icc_nue := v_icc;
        END IF;

    -- Get TYPE a partir ICC
    v_tmp:= fRecuperSIMCARD_FN (v_icc,'PUK');

    v_out := v_tmp;

    -- Get TYPE a partir ICCNue
    v_tmp:= fRecuperSIMCARD_FN (v_icc_nue,'PUK');
    v_out := v_out || '|' || v_tmp;

    RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_TMM_ICCPUK, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_TMM_ICCPUK, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
  END;


-----------------------------------------------------------------------------------------
 -- FN_TMM_ICCPROFILE-- Retorna valor PROFILE de la tarjeta en funciona al ICC
 ----------------------------------------------------------------------------------------
 FUNCTION FN_TMM_ICCPUK2 (v_num_mov IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
    v_tmp STRING(512);
    v_icc VARCHAR2(25);                -- Size according to iccMovimiento
    v_icc_nue VARCHAR2(25);                -- Size according to iccMovimiento
    v_comando_sql  VARCHAR2(200);
    error_proceso EXCEPTION;

  BEGIN

   -- Get ICC
  SELECT NVL(ICC, ''), NVL(ICC_NUE, CHR(0))
        INTO v_icc, v_icc_nue
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        IF v_icc_nue = CHR(0) THEN
           v_icc_nue := v_icc;
        END IF;

    -- Get TYPE a partir ICC
    v_tmp:= fRecuperSIMCARD_FN (v_icc,'PUK2');

    v_out := v_tmp;

    -- Get TYPE a partir ICCNue
    v_tmp:= fRecuperSIMCARD_FN (v_icc_nue,'PUK2');

    v_out := v_out || '|' || v_tmp;

    RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_TMM_ICCPUK2, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_TMM_ICCPUK2, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
  END;

-----------------------------------------------------------------------------------------
-- FN_TMM_COD_HLR .-
----------------------------------------------------------------------------------------
FUNCTION FN_TMM_COD_HLR(v_num_mov IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN VARCHAR2
IS
   SCODIGO_HLR   VARCHAR(10);      -- GSM_SIMCARD_TO.CODIGO_HLR%TYPE;
   SCODIGO_central VARCHAR2(20); -- ICG_CENTRAL.COD_central%TYPE;
   SCODIGO_central_nue varchar2(20);
   VARIABLE       VARCHAR2(50);
   VARIABLE_NUE   VARCHAR2(50);
   v_celular ICC_MOVIMIENTO.NUM_CELULAR%TYPE;
   v_celular_nue ICC_MOVIMIENTO.NUM_CELULAR_NUE%TYPE;

BEGIN
   BEGIN

      SELECT NVL(num_celular, 0), NVL(num_celular_nue, 0)
      INTO v_celular, v_celular_nue
    FROM ICC_MOVIMIENTO
    WHERE num_movimiento = v_num_mov;

    IF v_celular <> 0 THEN
       SELECT NVL(B.COD_HLR,'0')
       INTO SCODIGO_central
       FROM GA_CELNUM_CENTRAL A, ICG_CENTRAL B
       WHERE v_celular BETWEEN NUM_DESDE AND NUM_HASTA
         AND A.cod_central=b.cod_central;
    ELSE
       SCODIGO_central := '';
    END IF;

    IF v_celular_nue <> 0 THEN
       SELECT NVL(B.COD_HLR,'0')
       INTO SCODIGO_central_nue
       FROM GA_CELNUM_CENTRAL A, ICG_CENTRAL B
       WHERE v_celular_nue BETWEEN NUM_DESDE AND NUM_HASTA
         AND A.cod_central=b.cod_central;
    ELSE
       SCODIGO_central_nue := '';
    END IF;

   EXCEPTION
     WHEN NO_DATA_FOUND THEN
        RETURN 'ERROR'||'SERIE  NO EXISTE';
     WHEN OTHERS THEN
        RETURN 'ERROR|'||SQLERRM;
   END;

   IF SCODIGO_central <> '0' THEN
      VARIABLE := Pv_Homolacion_Altamira_Fn ('10002',SCODIGO_central);
   ELSE
      VARIABLE := '0';
   END IF;

   IF SCODIGO_central_nue <> '0' THEN
      VARIABLE_NUE := Pv_Homolacion_Altamira_Fn ('10002',SCODIGO_central_nue);
   ELSE
      VARIABLE_NUE := '0';
   END IF;

   IF VARIABLE <> '0' THEN
       IF VARIABLE_NUE <> '0' THEN
          RETURN VARIABLE || '|' || VARIABLE_NUE;
       ELSE
         RETURN VARIABLE || '|' || VARIABLE;
       END IF;
   ELSE
       IF VARIABLE_NUE <> '0' THEN
          RETURN VARIABLE_NUE || '|' || VARIABLE_NUE;
       ELSE
         RETURN 'ERROR|'||SQLERRM;
       END IF;
   END IF;

EXCEPTION
  WHEN OTHERS THEN
     RETURN 'ERROR|'||SQLERRM;
END;

-----------------------------------------------------------------------------------------
-- FN_TMM_CAUSABAJAPREPA
----------------------------------------------------------------------------------------
FUNCTION FN_TMM_CAUSABAJAPREPA (NUM_MOVI  NUMBER)RETURN VARCHAR IS

     v_num_abonado  GA_ABOCEL.NUM_ABONADO%TYPE;
     scod_causabaja GA_ABOCEL.cod_causabaja%TYPE;
BEGIN

    BEGIN
        SELECT NVL(NUM_ABONADO, 0) INTO v_num_abonado
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = NUM_MOVI;

        EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN 'ERROR'||' MOVIMIENTO NO EXISTE';
        WHEN OTHERS THEN
            RETURN 'ERROR '||SQLERRM;
      END;

     BEGIN
        SELECT cod_causabaja
        INTO scod_causabaja
        FROM GA_ABOCEL
        WHERE NUM_ABONADO = v_num_abonado;

        EXCEPTION
        WHEN NO_DATA_FOUND THEN

           BEGIN
             SELECT cod_causabaja
             INTO scod_causabaja
             FROM GA_ABOAMIST
             WHERE NUM_ABONADO = v_num_abonado;
           EXCEPTION
           WHEN NO_DATA_FOUND THEN
                   RETURN 'ERROR '|| ' ABONADO NO EXISTE EN TABLAS DE POSTPAGO NI PREPAGO';
           WHEN OTHERS THEN
                RETURN 'ERROR '||SQLERRM;
           END;

         WHEN OTHERS THEN
            RETURN 'ERROR '||SQLERRM;
      END;

    RETURN SCOD_CAUSABAJA;

    EXCEPTION
    WHEN OTHERS THEN
             RETURN 'ERROR|'||SQLERRM;

END ;

-----------------------------------------------------------------------------------------
-- FN_TMM_COD_SUBALM
----------------------------------------------------------------------------------------
FUNCTION FN_TMM_COD_SUBALM (v_num_mov IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN VARCHAR2
IS
        SCOD_SUBALM          GA_CELNUM_SUBALM.COD_SUBALM%TYPE;
        SCOD_SUBALM_NUE    GA_CELNUM_SUBALM.COD_SUBALM%TYPE;
        VARIABLE              VARCHAR2(50);
        VARIABLE_NUE       VARCHAR2(50);
        v_num_cel               ICC_MOVIMIENTO.NUM_CELULAR%TYPE;
        v_num_cel_nue         ICC_MOVIMIENTO.NUM_CELULAR_NUE%TYPE;
BEGIN

        SELECT NVL(TO_CHAR(num_celular), 0), NVL(TO_CHAR(num_celular_nue), 0)
        INTO v_num_cel, v_num_cel_nue
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;


        BEGIN
              IF v_num_cel <> 0 THEN
/*
                SELECT nvl(COD_SUBALM,'0')
                INTO SCOD_SUBALM
                   FROM GA_CELNUM_SUBALM
                   WHERE v_num_cel BETWEEN  NUM_DESDE AND NUM_HASTA;
*/

                   SCOD_SUBALM := FN_COD_SUBALM;


             ELSE
                SCOD_SUBALM := '0';
             END IF;

             IF v_num_cel_nue <> 0 THEN
/*
                SELECT nvl(COD_SUBALM,'0')
                INTO SCOD_SUBALM_NUE
                   FROM GA_CELNUM_SUBALM
                   WHERE v_num_cel_nue BETWEEN  NUM_DESDE AND NUM_HASTA;
*/
                   SCOD_SUBALM_NUE := FN_COD_SUBALM;


             ELSE
                SCOD_SUBALM_NUE := '0';
             END IF;

        EXCEPTION
                WHEN NO_DATA_FOUND THEN
                        RETURN 'ERROR'||'ABONADO NO EXISTE';
                WHEN OTHERS THEN
                        RETURN 'ERROR|'||SQLERRM;
        END;

        IF SCOD_SUBALM <> '0' THEN
           VARIABLE := Pv_Homolacion_Altamira_Fn ('10001',SCOD_SUBALM);
        ELSE
           VARIABLE := '0';
        END IF;

        IF SCOD_SUBALM_NUE <> '0' THEN
           VARIABLE_NUE := Pv_Homolacion_Altamira_Fn ('10001',SCOD_SUBALM_NUE);
        ELSE
           VARIABLE_NUE := '0';
        END IF;



        IF VARIABLE <> '0' THEN
              IF VARIABLE_NUE <> '0' THEN
                 RETURN VARIABLE || '|' || VARIABLE_NUE;
              ELSE
                 RETURN VARIABLE || '|' || VARIABLE;
           END IF;
        ELSE
               IF VARIABLE_NUE <> '0' THEN
                     RETURN VARIABLE_NUE || '|' || VARIABLE_NUE;
               ELSE
                 RETURN 'ERROR|'||SQLERRM;
               END IF;
           END IF;

EXCEPTION
  WHEN OTHERS THEN
       RETURN 'ERROR|'||SQLERRM;
END ;


-----------------------------------------------------------------------------------------
-- FN_TMM_DETER_DECENT
-- *** PENDIENTE de USO.....
----------------------------------------------------------------------------------------
FUNCTION FN_TMM_DETER_DECENT (NUM_MOVI NUMBER)  RETURN VARCHAR IS

    NCARGA              ICC_MOVIMIENTO.CARGA%TYPE;
    NVALORPLAN          ICC_MOVIMIENTO.VALOR_PLAN%TYPE;
    SVAL_PARAMETRO        GED_PARAMETROS.VAL_PARAMETRO%TYPE;
    SVAL_PARAMETRO_DEC  GED_PARAMETROS.VAL_PARAMETRO%TYPE;

    VALOR1              VARCHAR2(100);
    VALOR2              NUMBER;
    VALOR3              NUMBER;
    VALOR4                VARCHAR2(1);
    LN_cero                NUMBER(1):=0;

BEGIN
     VALOR4 :='';
      GN_cod_producto  :=   1;
     BEGIN
     GV_cod_modulo    :='GE';
      GV_nom_parametro :='SEP_DECIMALES_ORACLE';
     SELECT  TRIM(VAL_PARAMETRO)
     INTO  SVAL_PARAMETRO_DEC
     FROM GED_PARAMETROS
     WHERE
     NOM_PARAMETRO = GV_nom_parametro AND
     COD_MODULO    = GV_cod_modulo    AND
     COD_PRODUCTO  = GN_cod_producto;
     EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN 'ERROR'||' PARAMETRO SEP. DEC. NO EXISTE';
        WHEN OTHERS THEN
            RETURN 'ERROR|'||SQLERRM;
      END;


     BEGIN
     GV_cod_modulo    :='GA';
      GV_nom_parametro :='DETDECENT';
     SELECT  VAL_PARAMETRO
     INTO  SVAL_PARAMETRO
     FROM GED_PARAMETROS
     WHERE
     NOM_PARAMETRO = GV_nom_parametro AND
     COD_MODULO    = GV_cod_modulo    AND
     COD_PRODUCTO  = GN_cod_producto;

     EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN 'ERROR'||' PARAMETRO NO EXISTE';
        WHEN OTHERS THEN
            RETURN 'ERROR|'||SQLERRM;
      END;

     VALOR3 :=    SVAL_PARAMETRO;
     BEGIN
     SELECT  NVL(CARGA, LN_cero), NVL(VALOR_PLAN, LN_cero)
     INTO NCARGA ,NVALORPLAN
     FROM ICC_MOVIMIENTO
     WHERE
     NUM_MOVIMIENTO = NUM_MOVI;

     EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN 'ERROR'||' MOVIMIENTO NO EXISTE';
        WHEN OTHERS THEN
            RETURN 'ERROR|'||SQLERRM;
      END;

     IF NCARGA > 0  THEN

        VALOR1 := TO_CHAR(NCARGA);
        VALOR2 := INSTR(VALOR1,SVAL_PARAMETRO_DEC);

        IF VALOR2 > 0 THEN
            BEGIN

            UPDATE ICC_MOVIMIENTO
            SET CARGA = NCARGA * VALOR3
            WHERE
            NUM_MOVIMIENTO = NUM_MOVI;

             EXCEPTION
             WHEN NO_DATA_FOUND THEN
                RETURN 'ERROR'||' MOVIMIENTO NO EXISTE (CARGA)';
                WHEN OTHERS THEN
                RETURN 'ERROR|'||SQLERRM;
             END;

            VALOR4:= '1';
        ELSE
            VALOR4:= '0';
        END IF;
     ELSE
       IF NVALORPLAN > 0 THEN
             VALOR1 := TO_CHAR(NVALORPLAN);
            VALOR2 := INSTR(VALOR1,SVAL_PARAMETRO_DEC);

          IF VALOR2 > 0 THEN
             BEGIN

             UPDATE ICC_MOVIMIENTO
             SET VALOR_PLAN = NVALORPLAN * VALOR3
             WHERE
             NUM_MOVIMIENTO = NUM_MOVI;

               EXCEPTION
              WHEN NO_DATA_FOUND THEN
                RETURN 'ERROR'||' MOVIMIENTO NO EXISTE (VALOR PLAN)';
                 WHEN OTHERS THEN
                RETURN 'ERROR|'||SQLERRM;
              END;

             VALOR4:='1';
          ELSE
             VALOR4:='0';
            END IF;
       END IF;
     END IF;


     RETURN VALOR4;

    EXCEPTION
        WHEN OTHERS THEN
             RETURN 'ERROR|'||SQLERRM;

END ;

-----------------------------------------------------------------------------------------
-- FN_TMM_RECARGA
----------------------------------------------------------------------------------------
FUNCTION FN_TMM_RECARGA (NUM_MOVI NUMBER) RETURN VARCHAR2 IS

    SCOD_VALOR           PV_RECARGAPREPAGO_TO.COD_RECARGA%TYPE;
    SCOD_ACTABO          ICC_MOVIMIENTO.COD_ACTABO%TYPE;
BEGIN
     BEGIN

     SELECT  COD_RECARGA
     INTO SCOD_VALOR
     FROM PV_RECARGAPREPAGO_TO
     WHERE
     NUM_MOVIMIENTO = NUM_MOVI;

     EXCEPTION
        WHEN NO_DATA_FOUND THEN
              SCOD_VALOR:='PB';
        WHEN OTHERS THEN
            RETURN 'ERROR '||SQLERRM;
      END;

     BEGIN

     SELECT  COD_ACTABO
     INTO      SCOD_ACTABO
     FROM ICC_MOVIMIENTO
     WHERE
     NUM_MOVIMIENTO = NUM_MOVI ;

     EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN 'ERROR'||' MOVIMIENTO NO EXISTE';
        WHEN OTHERS THEN
            RETURN 'ERROR '||SQLERRM;
      END;

     IF  SCOD_ACTABO = 'P4' THEN
          RETURN '00';
     ELSE
         RETURN SCOD_VALOR;
     END IF;

    EXCEPTION
        WHEN OTHERS THEN
             RETURN 'ERROR|'||SQLERRM;


END ;

-----------------------------------------------------------------------------------------
-- FN_TMM_RECCAUSASUSP
----------------------------------------------------------------------------------------
FUNCTION FN_TMM_RECCAUSASUSP (sNumMovimiento IN NUMBER) RETURN VARCHAR2 IS

/******************************************************************************
AUTOR    : Christian Estay M.
AREA     : POSTVENTA
EMPRESA  : TELEFONICA MOVIL SOLUTION S.A.
******************************************************************************/

sCodCausa      GA_SUSPREHABO.COD_CAUSUSP%TYPE;
D_FEC_INGRESO  ICC_MOVIMIENTO.FEC_INGRESO%TYPE;
V_NUM_ABONADO  ICC_MOVIMIENTO.NUM_ABONADO%TYPE;
V_COD_SERVICIO ICC_MOVIMIENTO.COD_SUSPREHA%TYPE;
V_COD_ACTABO   ICC_MOVIMIENTO.COD_ACTABO%TYPE;
V_COD_A ICC_MOVIMIENTO.COD_SUSPREHA%TYPE;
D_FEC_SUSPBD   GA_SUSPREHABO.FEC_SUSPBD%TYPE;
MAXI NUMBER;

BEGIN
     MAXI :=0;
     BEGIN

     SELECT NUM_ABONADO,FEC_INGRESO,TRIM(COD_SUSPREHA), COD_ACTABO
       INTO V_NUM_ABONADO,D_FEC_INGRESO,V_COD_SERVICIO, V_COD_ACTABO
       FROM ICC_MOVIMIENTO
      WHERE NUM_MOVIMIENTO = sNumMovimiento;

      EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN 'ERROR'||' MOVIMIENTO NO EXISTE';
        WHEN OTHERS THEN
            RETURN 'ERROR '||SQLERRM;
      END;



     IF V_COD_SERVICIO IS NULL THEN

          RETURN 'ERROR'||' CODIGO DE SERVICIO ERRONEO';

     ELSE

          IF V_COD_ACTABO = 'BQ' OR V_COD_ACTABO = 'DQ'  THEN
              RETURN V_COD_SERVICIO; -- Para el caso de Bloqueo y Desbloqueo - PrePago
         END IF;

         BEGIN

          SELECT MAX(FEC_SUSPBD)
           INTO D_FEC_SUSPBD
           FROM GA_SUSPREHABO
          WHERE NUM_ABONADO =V_NUM_ABONADO
          AND COD_SERVICIO  = V_COD_SERVICIO;

         EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RETURN 'ERROR'||' ABONADO NO POSEE CAUSA DE SUSPENSION (MAX FEC)';
            WHEN OTHERS THEN
                RETURN 'ERROR '||SQLERRM;
          END;

         IF D_FEC_SUSPBD IS NULL THEN
              RETURN 'ERROR'||' ABONADO SIN REGISTRO DE SUSP.(GA_SUSPREHABO)';
         ELSE

            BEGIN

            SELECT COD_CAUSUSP
             INTO sCodCausa
            FROM GA_SUSPREHABO
            WHERE NUM_ABONADO   =  V_NUM_ABONADO
            AND COD_SERVICIO  = V_COD_SERVICIO
            AND FEC_SUSPBD    = D_FEC_SUSPBD;
            EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RETURN 'ERROR'||' ABONADO NO POSEE CAUSA DE SUSPENSION (CAUSA)';
            WHEN OTHERS THEN
                RETURN 'ERROR '||SQLERRM;
             END;

         END IF;

     END IF;

      RETURN sCodCausa;

      EXCEPTION
        WHEN OTHERS THEN
             RETURN 'ERROR|'||SQLERRM;


END;


-----------------------------------------------------------------------------------------
-- FN_TMM_GE_PREFIJONIR
----------------------------------------------------------------------------------------
FUNCTION FN_TMM_GE_PREFIJONIR (v_num_mov IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN VARCHAR2
IS

-- *************************************************************
-- * Funcion               : Prefijo de numero telefonico para NIR (Num Ident Region)
-- * Salida                        : Prefijo de numero de telefonico para NIR
-- * Descripcion           : Funcion que retorna el prefijo de un numero telefonico correspondiente a su rango
-- *                         si es nulo devuelve un error
-- * Fecha de creacion     : 24 de Enero de 2003
-- * Responsable           : Erika Vadell
-- *************************************************************

NUM_NIR GA_CELNUM_SUBALM.NUM_NIR%TYPE;
NUM_NIR_NUE GA_CELNUM_SUBALM.NUM_NIR%TYPE;
num_celular GA_ABOCEL.num_celular%TYPE;
num_celular_nue ICC_MOVIMIENTO.num_celular_nue%TYPE;
v_num_desde ICC_MOVIMIENTO.num_celular_nue%TYPE;
BEGIN
   SELECT NVL(TO_CHAR(num_celular), 0), NVL(TO_CHAR(num_celular), 0)
   INTO num_celular, num_celular_nue
   FROM ICC_MOVIMIENTO
   WHERE num_movimiento = v_num_mov;
   IF num_celular <> 0 THEN
      BEGIN
      -- INICIO incidencia 34848 María Lorena Rojo L. 09/11/2006 Se optimiza consulta
         SELECT NVL(num_nir,'0')
         INTO    NUM_NIR
         FROM    GA_CELNUM_SUBALM
         WHERE  num_desde = num_celular;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            SELECT NVL(MAX(num_desde),0)
            INTO   v_num_desde
            FROM   GA_CELNUM_SUBALM
            WHERE  num_desde < num_celular;
            IF v_num_desde <> 0 then
               SELECT NVL(num_nir,'0')
               INTO      NUM_NIR
               FROM      GA_CELNUM_SUBALM
               WHERE  num_desde = v_num_desde;
            ELSE
               NUM_NIR := '0';
            END IF;
      -- FIN incidencia 34848 María Lorena Rojo L. 09/11/2006 Se optimiza consulta
      END;
   ELSE
      NUM_NIR := '0';
   END IF;

   IF num_celular_nue <> 0 THEN
      BEGIN
      -- INICIO incidencia 34848 María Lorena Rojo L. 09/11/2006 Se optimiza consulta
         SELECT NVL(num_nir,'0')
         INTO     NUM_NIR_NUE
         FROM    GA_CELNUM_SUBALM
         WHERE  num_desde = num_celular_nue;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            SELECT NVL(MAX(num_desde),0)
            INTO   v_num_desde
            FROM   GA_CELNUM_SUBALM
            WHERE  num_desde < num_celular_nue;
            IF v_num_desde <> 0 THEN
               SELECT NVL(num_nir,'0')
               INTO   NUM_NIR_NUE
               FROM   GA_CELNUM_SUBALM
               WHERE  num_desde = v_num_desde;
            ELSE
               NUM_NIR_NUE := '0';
            END IF;
    -- FIN incidencia 34848 María Lorena Rojo L. 09/11/2006 Se optimiza consulta
      END;
   ELSE
      NUM_NIR_NUE := '0';
   END IF;
   IF NUM_NIR <> '0' THEN
      IF NUM_NIR_NUE <> '0' THEN
         RETURN NUM_NIR || '|' || NUM_NIR_NUE;
       ELSE
          RETURN NUM_NIR || '|' || NUM_NIR;
       END IF;
   ELSE
      IF NUM_NIR_NUE <> '0' THEN
         RETURN NUM_NIR_NUE || '|' || NUM_NIR_NUE;
      ELSE
         RETURN 'ERROR|'||SQLERRM;
      END IF;
   END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         RETURN 'ERROR -20102, ' || 'Numero no existe......';
END;


----------------------------------------------------------------------------
-- FN_TMm_MSISDN --
-- Ejemplo: MSISDN=5291602110
----------------------------------------------------------------------------
FUNCTION FN_TMM_MSISDN(v_num_mov IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
        v_num_cel VARCHAR2(512);
        v_num_cel_nue VARCHAR2(512);
    error_proceso EXCEPTION;
  BEGIN

    SELECT NVL(TO_CHAR(num_celular), ''), NVL(TO_CHAR(num_celular_nue),CHR(0))
        INTO v_num_cel, v_num_cel_nue
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        IF v_num_cel_nue = CHR(0) THEN
      v_out := '52'||v_num_cel || '|' || '52'||v_num_cel;
        ELSE
          v_out := '52'||v_num_cel || '|' || '52'||v_num_cel_nue;
        END IF;

    RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_TMM_MSISDN, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_TMM_MSISDN, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
  END;


----------------------------------------------------------------------------
-- FN_TMM_ICC_NUE --
----------------------------------------------------------------------------
  FUNCTION FN_TMM_ICC_NUE(V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
        v_icc VARCHAR2(512);
        v_icc_nue VARCHAR2(512);
    error_proceso EXCEPTION;
  BEGIN

    SELECT NVL(ICC, ''), NVL(ICC_NUE, CHR(0))
        INTO v_icc, v_icc_nue
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        IF v_icc_nue = CHR(0) THEN
      v_out := v_icc || '|' || v_icc;
        ELSE
          v_out := v_icc_nue || '|' || v_icc;
        END IF;

    RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_TMC_ICC, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_TMC_ICC, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
  END;


----------------------------------------------------------------------------
-- FN_TMM_MTONETBRUT
-- Funcion que retorne monto neto o bruto del campo icc_movimiento.carga
-- se agrega situacion particular para el modulo IC.
----------------------------------------------------------------------------
  FUNCTION FN_TMM_MTONETBRUT (V_Num_Movimiento  IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN VARCHAR2 IS

--Inicio Incidencia CO-0015 26-4-2006 centrales
        V_ICC              GA_ABOCEL.NUM_SERIE%TYPE;
        v_cod_actabo        ICC_MOVIMIENTO.COD_ACTABO%TYPE;
--Fin Incidencia CO-0015 26-4-2006 centrales

    v_Carga                ICC_MOVIMIENTO.CARGA%TYPE;
    v_Valor_plan           ICC_MOVIMIENTO.VALOR_PLAN%TYPE;

    V_VAL_PARAMETRO           GED_PARAMETROS.VAL_PARAMETRO%TYPE;
    V_VAL_PARAMETRO2       GED_PARAMETROS.VAL_PARAMETRO%TYPE;

    V_Num_Abonado           ICC_MOVIMIENTO.NUM_ABONADO%TYPE;

    V_Mto_Carga               NUMBER;
    V_PARAM                   VARCHAR2(200) := 0;
    v_cod_mod              ICC_MOVIMIENTO.cod_modulo%TYPE;
    v_tip_tecnologia       ICC_MOVIMIENTO.tip_tecnologia%TYPE;
    v_num_celular          ICC_MOVIMIENTO.num_celular%TYPE;
    v_cargobasico          GA_ABOCEL.cod_cargobasico%TYPE;
    v_imp_cargobasico      TA_CARGOSBASICO.imp_cargobasico%TYPE;
    v_region               GA_ABOCEL.cod_region%TYPE;
    v_provincia            GA_ABOCEL.cod_provincia%TYPE;
    v_ciudad               GA_ABOCEL.cod_ciudad%TYPE;
    v_zonaimpositiva       GE_ZONACIUDAD.cod_zonaimpo%TYPE;

BEGIN

     BEGIN
--Inicio Incidencia CO-0015 26-4-2006 centrales
--         SELECT NVL(carga,0),NVL(valor_plan,0), NUM_ABONADO, NVL(cod_modulo, CHR(0)),tip_tecnologia,num_celular
--         INTO V_carga,v_valor_plan, V_Num_Abonado, v_cod_mod,v_tip_tecnologia,v_num_celular
--Fin Incidencia CO-0015 26-4-2006 centrales
         SELECT NVL(carga,0),NVL(valor_plan,0), NUM_ABONADO, NVL(cod_modulo, CHR(0)),tip_tecnologia,num_celular,cod_actabo
         INTO V_carga,v_valor_plan, V_Num_Abonado, v_cod_mod,v_tip_tecnologia,v_num_celular,v_cod_actabo
         FROM ICC_MOVIMIENTO
         WHERE
         NUM_MOVIMIENTO =  V_Num_Movimiento;


     EXCEPTION
     WHEN NO_DATA_FOUND THEN
              RETURN 'MOVIMIENTO NO EXISTE | '||SQLERRM;
     WHEN OTHERS THEN
             RETURN 'ERROR ACCESO ICC_MOVIMIENTO | '||SQLERRM;
     END;

     -- Situacion particular.
--Inicio Incidencia CO-0015 26-4-2006 centrales
--     IF V_COD_MOD = 'IC' THEN
--Fin Incidencia CO-0015 26-4-2006 centrales
     IF V_COD_MOD = 'IC' AND v_cod_actabo <> 'BP' THEN
     BEGIN
        IF substr(v_tip_tecnologia,1,3) = 'CDM' THEN

           SELECT COD_CARGOBASICO INTO v_cargobasico
           FROM GA_ABOCEL WHERE NUM_CELULAR = v_num_celular;

           SELECT IMP_CARGOBASICO INTO v_imp_cargobasico
           FROM TA_CARGOSBASICO WHERE COD_CARGOBASICO = v_cargobasico;

           V_carga := v_imp_cargobasico;

           SELECT COD_REGION,COD_PROVINCIA,COD_CIUDAD INTO v_region,v_provincia,v_ciudad
           FROM GA_ABOCEL WHERE NUM_CELULAR = v_num_celular AND ROWNUM = 1;

           SELECT COD_ZONAIMPO INTO v_zonaimpositiva FROM GE_ZONACIUDAD
           WHERE COD_REGION = v_region
           AND COD_PROVINCIA = v_provincia
           AND COD_CIUDAD = v_ciudad
           AND ROWNUM = 1;

           IF v_zonaimpositiva = '1' THEN
              V_carga := ROUND(V_carga * 1.15);
           ELSE
              V_carga := ROUND(V_carga * 1.1);
           END IF;

           RETURN TO_CHAR(V_carga);
        END IF;
        IF v_tip_tecnologia = 'GSM' THEN
           SELECT COD_CARGOBASICO INTO v_cargobasico
           FROM GA_ABOCEL WHERE NUM_CELULAR = v_num_celular;

           SELECT IMP_CARGOBASICO INTO v_imp_cargobasico
           FROM TA_CARGOSBASICO WHERE COD_CARGOBASICO = v_cargobasico;

           V_carga := v_imp_cargobasico;

           RETURN TO_CHAR(V_carga);
        END IF;
     END;
     END IF;

--Inicio Incidencia CO-0015 26-4-2006 centrales
/*
IF v_tip_tecnologia = 'GSM' AND V_COD_MOD = 'IC' AND V_COD_ACTABO = 'BP' THEN

         SELECT NUM_SERIE INTO V_ICC
         FROM  GA_ABOCEL
         WHERE NUM_CELULAR = v_num_celular
             AND    COD_SITUACION = 'AAA';

         UPDATE ICC_MOVIMIENTO
         SET ICC = V_ICC
         WHERE NUM_MOVIMIENTO = V_Num_Movimiento;

     END IF;
*/
--Fin Incidencia CO-0015 26-4-2006 centrales

     GV_cod_modulo   := 'GA';
     GN_cod_producto := 1;
     BEGIN
     GV_nom_parametro := 'FLAG_MTO_ENTRANTE';
     SELECT
     VAL_PARAMETRO
     INTO
     V_VAL_PARAMETRO
     FROM
     GED_PARAMETROS
     WHERE
     NOM_PARAMETRO = GV_nom_parametro  AND
     COD_MODULO    = GV_cod_modulo        AND
     COD_PRODUCTO  = GN_cod_producto;

     EXCEPTION
                WHEN NO_DATA_FOUND THEN
                         RETURN 'PARAMETRO NO EXISTE | '||SQLERRM;
             WHEN OTHERS THEN
                        RETURN 'PARAM ERROR FLAG_MTO_ENTRANTE | ' ||SQLERRM;
     END;

     BEGIN
         GV_nom_parametro := 'FLAG_MTO_SALIENTE';
        SELECT  VAL_PARAMETRO      INTO       V_VAL_PARAMETRO2
        FROM     GED_PARAMETROS
        WHERE     NOM_PARAMETRO = GV_nom_parametro
          AND   COD_MODULO    = GV_cod_modulo
          AND   COD_PRODUCTO  = GN_cod_producto;

     EXCEPTION
                WHEN NO_DATA_FOUND THEN
                         RETURN 'PARAMETRO NO EXISTE | '||SQLERRM;
        WHEN OTHERS THEN
                        RETURN 'PARAM ERROR FLAG_MTO_SALIENTE | ' ||SQLERRM;
     END;

     IF V_carga = 0 THEN
        V_Mto_Carga    :=v_valor_plan;
     ELSE
         V_Mto_Carga    :=V_carga;
     END IF;

     IF V_Mto_Carga > 0 THEN
          IF V_VAL_PARAMETRO2<>V_VAL_PARAMETRO THEN
                V_PARAM := Pv_Mtonbporc_Fn(V_Num_Movimiento,NULL,V_Mto_Carga,V_VAL_PARAMETRO,V_Num_Abonado);
          ELSE
             V_PARAM:= V_Mto_Carga;
          END IF;
     END IF;

     RETURN v_param;

END FN_TMM_MTONETBRUT;

----------------------------------------------------------------------------
-- FN_TMM_MENSAJE --
----------------------------------------------------------------------------
  FUNCTION FN_TMM_mensaje(v_num_mov IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE)
RETURN STRING IS
    v_out STRING(512);
        v_cod_cen ICC_MOVIMIENTO.cod_central%TYPE;
        v_cod_men ICC_MOVIMIENTO.cod_mensaje%TYPE;
        v_p1 ICC_MOVIMIENTO.param1_mens%TYPE;
        v_p2 ICC_MOVIMIENTO.param2_mens%TYPE;
        v_p3 ICC_MOVIMIENTO.param3_mens%TYPE;
        v_des_men ICG_MENSAJE.des_mensaje%TYPE;
    error_proceso EXCEPTION;
  BEGIN

    SELECT NVL(cod_central, 0),
               NVL(cod_mensaje, 0),
               NVL(param1_mens, NULL),
                   NVL(param2_mens, NULL),
                   NVL(param3_mens, NULL)
    INTO v_cod_cen,v_cod_men,v_p1,v_p2,v_p3
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        SELECT des_mensaje INTO v_des_men
        FROM ICG_MENSAJE
        WHERE cod_mensaje = v_cod_men
        AND cod_central = v_cod_cen
        AND cod_producto = 1;

    IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        --- Aqui logica para reemplazar parametros en el mensaje (des_men)
        v_des_men := REPLACE(v_des_men, '<p1>', v_p1);
        v_des_men := REPLACE(v_des_men, '<p2>', v_p2);
        v_des_men := REPLACE(v_des_men, '<p3>', v_p3);


        -- Incluye caracter de escape para caracteres "," y ";"
         v_out := REPLACE (v_des_men,',','\,');
        v_out := REPLACE (v_out,';','\;');


        RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_TMM_mensaje, SQLCODE:' || TO_CHAR(SQLCODE) ||
'SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_TMM_mensaje, SQLCODE:' || TO_CHAR(SQLCODE) ||
'SLQERRM:' || SQLERRM;
  END;

-----------------------------------------------------------------------------------------
 -- FN_TMM_ICCPUK_NUE-- Retorna valor PUK de la tarjeta nueva en funcion al ICC
 ----------------------------------------------------------------------------------------
 FUNCTION FN_TMM_ICCPUK_NUE (v_num_mov IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
    v_tmp STRING(512);
    v_icc VARCHAR2(25);                -- Size according to iccMovimiento
    v_icc_nue VARCHAR2(25);                -- Size according to iccMovimiento
    v_comando_sql  VARCHAR2(200);
    error_proceso EXCEPTION;

  BEGIN

   -- Get ICC
  SELECT NVL(ICC, ''), NVL(ICC_NUE, CHR(0))
        INTO v_icc, v_icc_nue
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        IF v_icc_nue = CHR(0) THEN
       v_icc_nue := v_icc;
        END IF;

    -- Get TYPE a partir ICCNue
    v_tmp:= fRecuperSIMCARD_FN (v_icc_nue,'PUK');

    v_out := v_tmp;

    -- Get TYPE a partir ICC
    v_tmp:= fRecuperSIMCARD_FN (v_icc,'PUK');

    v_out := v_out || '|' || v_tmp;

    RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_TMM_ICCPUK_NUE, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_TMM_ICCPUK_NUE, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
  END;


-----------------------------------------------------------------------------------------
 -- FN_TMM_ICCPUK2_NUE-- Retorna valor PUK2 de la tarjeta nueva en funcion al ICC
 ----------------------------------------------------------------------------------------
 FUNCTION FN_TMM_ICCPUK2_NUE (v_num_mov IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
    v_tmp STRING(512);
    v_icc VARCHAR2(25);                -- Size according to iccMovimiento
    v_icc_nue VARCHAR2(25);                -- Size according to iccMovimiento
    v_comando_sql  VARCHAR2(200);
    error_proceso EXCEPTION;

  BEGIN

   -- Get ICC
  SELECT NVL(ICC, ''), NVL(ICC_NUE, CHR(0))
        INTO v_icc, v_icc_nue
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        IF v_icc_nue = CHR(0) THEN
           v_icc_nue := v_icc;
        END IF;

    -- Get TYPE a partir ICCNue
     v_tmp:= fRecuperSIMCARD_FN (v_icc_nue,'PUK2');

    v_out := v_tmp;


    -- Get TYPE a partir ICC
    v_tmp:= fRecuperSIMCARD_FN (v_icc,'PUK2');

    v_out := v_out || '|' || v_tmp;


    RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_TMM_ICCPUK2_NUE, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_TMM_ICCPUK2_NUE, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
  END;
-----------------------------------------------------------------------------------------
 -- FN_TMM_IMSI--
 ----------------------------------------------------------------------------------------
  FUNCTION FN_TMM_IMSI(V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
        v_icc VARCHAR2(512);
        v_icc_nue VARCHAR2(512);
        v_imsi VARCHAR2(512);
        v_imsi_nue VARCHAR2(512);
        v_comando_sql  VARCHAR2(200);
    error_proceso EXCEPTION;
  BEGIN

    SELECT NVL(ICC, ''), NVL(ICC_NUE, CHR(0))
        INTO v_icc, v_icc_nue
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

    -- Get IMSI
    v_imsi:=fRecuperSIMCARD_FN (v_icc_nue,'IMSI');

        IF v_icc_nue = CHR(0) THEN
            v_imsi_nue := v_imsi;
        ELSE
                v_imsi_nue:= fRecuperSIMCARD_FN (v_icc,'IMSI');
        END IF;

    v_out := v_imsi || '|' || v_imsi_nue ;

        RETURN v_out;


  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_TMC_IMSI, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_TMC_IMSI, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
  END;


-------------------------------------------------------------------------------------------
--FN_TMM_nummin_pv -- Retorna valor MIN para el celular, de acuerdo a FN_RECUPERA_NUM_MIN--
-------------------------------------------------------------------------------------------
FUNCTION FN_TMM_nummin_pv(V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING
IS
    v_out          STRING(512);
    v_num_abonado  ICC_MOVIMIENTO.NUM_ABONADO%TYPE;
    v_nummin       VARCHAR2(512);
    error_proceso EXCEPTION;

BEGIN

   SELECT NUM_ABONADO
   INTO v_num_abonado
   FROM ICC_MOVIMIENTO
   WHERE num_movimiento = v_num_mov;

   IF SQLCODE <> 0 THEN
      RAISE error_proceso;
   END IF;

   v_nummin := Fn_Recupera_Num_Min(v_num_abonado);

   v_out := v_nummin;

  RETURN v_out;

EXCEPTION
    WHEN error_proceso THEN
         RETURN 'ERROR FN_TMM_nummin_pv, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
        RETURN 'ERROR FN_TMM_nummin_pv, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
END;

----------------------------------------------------------------------------
-- FN_TMM_CLICODCUENTA                               --
----------------------------------------------------------------------------

FUNCTION FN_TMM_clicodcuenta(v_num_mov IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
    v_cod_cli GE_CLIENTES.cod_cliente%TYPE;
    v_codcuenta GE_CLIENTES.cod_cuenta%TYPE;
    error_proceso EXCEPTION;
  BEGIN

    BEGIN
      SELECT cod_cliente INTO v_cod_cli
      FROM GA_ABOCEL
      WHERE NUM_ABONADO = (SELECT NUM_ABONADO FROM ICC_MOVIMIENTO WHERE num_movimiento = v_num_mov);
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        SELECT cod_cliente INTO v_cod_cli
        FROM GA_ABOAMIST
        WHERE NUM_ABONADO = (SELECT NUM_ABONADO FROM ICC_MOVIMIENTO WHERE num_movimiento = v_num_mov);
    END;

    --IF SQLCODE <> 0 THEN
    --    RAISE error_proceso;
    --END IF;

    SELECT a.COD_CUENTA
        INTO v_codcuenta
    FROM GE_CLIENTES a, GA_CUENTAS b
    WHERE a.cod_cuenta = b.cod_cuenta
    AND a.COD_CLIENTE = V_COD_CLI;

    IF SQLCODE <> 0 THEN
        RAISE error_proceso;
    END IF;

    v_out := TO_CHAR(v_codcuenta) || '|' || TO_CHAR(v_codcuenta);

    RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_TMM_clicodcuenta, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_TMM_clicodcuenta, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
 END;

-------------------------------------------------------------------------------------------
--FN_TMM_nummin -- Retorna valor MIN para el celular.--
-------------------------------------------------------------------------------------------
FUNCTION FN_TMM_nummin(V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING
IS
    v_out STRING(512);
    v_cod_modulo   ICC_MOVIMIENTO.COD_MODULO%TYPE;
    v_num_abonado  ICC_MOVIMIENTO.NUM_ABONADO%TYPE;
    v_fec_ingreso  ICC_MOVIMIENTO.FEC_INGRESO%TYPE;
    v_num_os       PV_MOVIMIENTOS.NUM_OS%TYPE;
    v_num_cel     VARCHAR2(512);
    v_num_cel_nue VARCHAR2(512);
    v_nummin      VARCHAR2(512);
    v_nummin_nue  VARCHAR2(512);
    v_dummy       VARCHAR2(512);
    v_dummy_nue   VARCHAR2(512);
    v_num_min_mdn_orig VARCHAR2(512);
    v_cod_actuacion       VARCHAR2(512);
    v_cod_actabo       VARCHAR2(512);
    v_cod_servicios       VARCHAR2(512);

    error_proceso EXCEPTION;
    error_negocio_0 EXCEPTION;
    error_negocio_1 EXCEPTION;
    error_negocio_2 EXCEPTION;
    error_negocio_3 EXCEPTION;
    error_GE_FN_MIN_DE_MDN EXCEPTION;
    error_GE_FN_MIN_DE_MDN_nue EXCEPTION;

BEGIN

   SELECT NVL(TO_CHAR(num_celular), CHR(0)), NVL(TO_CHAR(NUM_CELULAR_NUE), CHR(0)),
          NUM_ABONADO, fec_ingreso, cod_modulo, cod_actabo, cod_actuacion
   INTO v_num_cel, v_num_cel_nue, v_num_abonado, v_fec_ingreso, v_cod_modulo, v_cod_actabo, v_cod_actuacion
   FROM ICC_MOVIMIENTO
   WHERE num_movimiento = v_num_mov;

   IF SQLCODE <> 0 THEN
      RAISE error_proceso;
   END IF;

   IF v_cod_modulo = 'AL' THEN


      v_dummy := Ge_Fn_Min_De_Mdn(v_num_cel);

      IF v_dummy=0 THEN
         RAISE error_negocio_0;
      ELSIF v_dummy=1 THEN
         RAISE error_negocio_1;
      ELSIF v_dummy=2 THEN
         RAISE error_negocio_2;
      ELSIF v_dummy=3 THEN
         RAISE error_negocio_3;
      ELSIF v_dummy<0 THEN
         RAISE error_GE_FN_MIN_DE_MDN;
      END IF;

      v_nummin:= (v_dummy);

      IF v_num_cel_nue <> CHR(0) THEN
         V_dummy_nue := Ge_Fn_Min_De_Mdn(v_num_cel_nue);

          IF v_dummy_nue =0 THEN
             RAISE error_negocio_0;
          ELSIF v_dummy_nue=1 THEN
              RAISE error_negocio_1;
          ELSIF v_dummy_nue=2 THEN
             RAISE error_negocio_2;
          ELSIF v_dummy_nue=3 THEN
             RAISE error_negocio_3;
          ELSIF v_dummy_nue<0 THEN
             RAISE error_GE_FN_MIN_DE_MDN_nue;
          END IF;

          v_nummin_nue:= (v_dummy_nue);
      ELSE
          v_nummin_nue:= v_nummin;
      END IF;

   ELSE
      BEGIN
       IF v_cod_actabo = 'SS' THEN
           SELECT NVL(cod_servicios, CHR(0))
         INTO v_cod_servicios
           FROM ICC_MOVIMIENTO
         WHERE num_movimiento = v_num_mov;

           IF v_cod_actuacion = '1010' AND v_cod_servicios='560001' THEN
             SELECT NVL(num_min_mdn_orig, CHR(0))
            INTO v_num_min_mdn_orig
            FROM PV_ENRUTA_LLAMADA
            WHERE num_abonado=v_num_abonado
              AND num_cel_origen=v_num_cel_nue
              AND v_fec_ingreso < fec_termino;
         ELSIF  v_cod_actuacion = '1010' AND v_cod_servicios='560000' THEN

            SELECT num_os
            INTO v_num_os
            FROM PV_MOVIMIENTOS
            WHERE num_movimiento = v_num_mov;

            SELECT NVL(num_min_mdn_orig, CHR(0))
            INTO v_num_min_mdn_orig
            FROM PV_ENRUTA_LLAMADA
            WHERE num_abonado=v_num_abonado
              AND num_cel_origen=v_num_cel_nue
              AND num_ooss_des = v_num_os;
         ELSIF v_cod_actuacion='10' THEN
             SELECT NVL(num_min_mdn_orig, CHR(0))
            INTO v_num_min_mdn_orig
            FROM PV_ENRUTA_LLAMADA
            WHERE num_abonado=v_num_abonado
              AND num_cel_origen=v_num_cel
              AND v_fec_ingreso < fec_termino;
         END IF;
       END IF;

       IF v_cod_actabo = 'TG' THEN
           SELECT NVL(num_min_mdn_orig, CHR(0))
           INTO v_num_min_mdn_orig
           FROM PV_ENRUTA_LLAMADA
           WHERE num_abonado=v_num_abonado
             AND num_cel_origen=v_num_cel
             AND v_fec_ingreso < fec_termino;
       END IF;

      EXCEPTION
         WHEN NO_DATA_FOUND THEN
             v_num_min_mdn_orig := CHR(0);
      END;

      IF (v_num_min_mdn_orig <> CHR(0)) THEN
         v_nummin := v_num_min_mdn_orig;
         v_nummin_nue := v_num_min_mdn_orig;
      ELSE
        v_nummin_nue := Fn_Recupera_Num_Min(v_num_abonado);
        BEGIN
          v_nummin := Fn_Recupera_Num_Min_Ant (v_num_abonado, v_fec_ingreso);
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            v_nummin := v_nummin_nue;
        END;
      END IF;
   END IF;

  v_out := v_nummin || '|' || v_nummin_nue;

-- SE APLICA CAMBIO POR INCIDENCIA TM-200407290866 GMGE
   IF v_out = '|' THEN
       v_out:='ERROR EN FN_TMM_nummin.El Min no ha sido encontrado (Error 1)';
   END IF;
-- HASTA AQUI TM-200407290866 GMGE

  RETURN v_out;

EXCEPTION
    WHEN error_proceso THEN
         RETURN 'ERROR FN_TMM_nummin, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN error_GE_FN_MIN_DE_MDN THEN
        RETURN 'ERROR DE PROCESO EN GE_FN_MIN_DE_MDN (MDN), :' || v_dummy;
    WHEN error_GE_FN_MIN_DE_MDN_nue THEN
        RETURN 'ERROR DE PROCESO EN GE_FN_MIN_DE_MDN (MDN_NUE), :' || v_dummy || ':'|| v_dummy_nue;
    WHEN error_negocio_0 THEN
        RETURN 'ERROR DE NEGOCIO EN GE_FN_MIN_DE_MDN, :' || v_dummy || ':'|| v_dummy_nue || ' : No existe el número de MDN';
    WHEN error_negocio_1 THEN
        RETURN 'ERROR DE NEGOCIO EN GE_FN_MIN_DE_MDN, :' || v_dummy || ':'|| v_dummy_nue || ' : Error en el largo del MDN';
    WHEN error_negocio_2 THEN
        RETURN 'ERROR DE NEGOCIO EN GE_FN_MIN_DE_MDN, :' || v_dummy || ':'|| v_dummy_nue || ' : Error de formato (contiene caracteres no númericos)';
    WHEN error_negocio_3 THEN
        RETURN 'ERROR DE NEGOCIO EN GE_FN_MIN_DE_MDN, :' || v_dummy || ':'|| v_dummy_nue || ' : Error comienza con cero';
    WHEN OTHERS THEN
        RETURN 'ERROR FN_TMM_nummin, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
END;

----------------------------------------------------------------------------------------
-- FN_TMM_numminnue -- Retorna valor MIN para el celular.nuevo a cambiar              --
----------------------------------------------------------------------------------------
FUNCTION FN_TMM_numminnue(V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING
IS
    v_out STRING(512);
    v_num_cel VARCHAR(512);
    v_num_cel_nue VARCHAR(512);
    v_nummin VARCHAR2(512);
    v_nummin_nue VARCHAR2(512);
    v_dummy VARCHAR2(512);
    v_dummy_2 VARCHAR2(512);
    error_proceso EXCEPTION;
    error_negocio_0 EXCEPTION;
    error_negocio_1 EXCEPTION;
    error_negocio_2 EXCEPTION;
    error_negocio_3 EXCEPTION;
    error_GE_FN_MIN_DE_MDN EXCEPTION;
    error_GE_FN_MIN_DE_MDN_nue EXCEPTION;
BEGIN

    SELECT NVL(TO_CHAR(NUM_CELULAR), CHR(0)), NVL(TO_CHAR(NUM_CELULAR_NUE), CHR(0))
    INTO v_num_cel, v_num_cel_nue
    FROM ICC_MOVIMIENTO
    WHERE num_movimiento = v_num_mov;

    IF SQLCODE <> 0 THEN
       RAISE error_proceso;
    END IF;

    v_dummy := Ge_Fn_Min_De_Mdn(v_num_cel);

   IF v_dummy=0 THEN
      RAISE error_negocio_0;
   ELSIF v_dummy=1 THEN
      RAISE error_negocio_1;
   ELSIF v_dummy=2 THEN
      RAISE error_negocio_2;
   ELSIF v_dummy=3 THEN
      RAISE error_negocio_3;
   ELSIF v_dummy<0 THEN
      RAISE error_GE_FN_MIN_DE_MDN;
   END IF;

   v_nummin:= (v_dummy);

   IF v_num_cel_nue <> CHR(0) THEN
      V_dummy_2:=Ge_Fn_Min_De_Mdn(v_num_cel_nue);

      IF v_dummy_2 =0 THEN
         RAISE error_negocio_0;
      ELSIF v_dummy_2=1 THEN
         RAISE error_negocio_1;
      ELSIF v_dummy_2=2 THEN
         RAISE error_negocio_2;
      ELSIF v_dummy_2=3 THEN
         RAISE error_negocio_3;
      ELSIF v_dummy_2<0 THEN
         RAISE error_GE_FN_MIN_DE_MDN_nue;
      END IF;

      v_nummin_nue:= (v_dummy_2);
   ELSE
      v_nummin_nue:= v_nummin;
   END IF;

   v_out := v_nummin_nue || '|' || v_nummin;

    RETURN v_out;

EXCEPTION
    WHEN error_proceso THEN
         RETURN 'ERROR FN_TMM_numminnue, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN error_GE_FN_MIN_DE_MDN THEN
        RETURN 'ERROR DE PROCESO EN GE_FN_MIN_DE_MDN (MDN), :' || v_dummy;
    WHEN error_GE_FN_MIN_DE_MDN_nue THEN
        RETURN 'ERROR DE PROCESO EN GE_FN_MIN_DE_MDN (MDN_NUE), :' || v_dummy || ':'|| v_dummy_2;
    WHEN error_negocio_0 THEN
        RETURN 'ERROR DE NEGOCIO EN GE_FN_MIN_DE_MDN, :' || v_dummy || ':'|| v_dummy_2 || ' : No existe el número de MDN';
    WHEN error_negocio_1 THEN
        RETURN 'ERROR DE NEGOCIO EN GE_FN_MIN_DE_MDN, :' || v_dummy || ':'|| v_dummy_2 || ' : Error en el largo del MDN';
    WHEN error_negocio_2 THEN
        RETURN 'ERROR DE NEGOCIO EN GE_FN_MIN_DE_MDN, :' || v_dummy || ':'|| v_dummy_2 || ' : Error de formato (contiene caracteres no númericos)';
    WHEN error_negocio_3 THEN
        RETURN 'ERROR DE NEGOCIO EN GE_FN_MIN_DE_MDN, :' || v_dummy || ':'|| v_dummy_2 || ' : Error comienza con cero';
    WHEN OTHERS THEN
        RETURN 'ERROR FN_TMM_numminnue, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
END;


-----------------------------------------------------------------------------------------
-- FN_TMM_MOTIVO
----------------------------------------------------------------------------------------

FUNCTION FN_TMM_MOTIVO (sNumMovimiento IN NUMBER) RETURN VARCHAR2 IS

sVar VARCHAR2(1024); --GA_SUSPREHABO.COD_CAUSUSP%TYPE;
sCodMotivo VARCHAR2(512);

BEGIN

     sVar := FN_TMM_RECCAUSASUSP(sNumMovimiento);
     IF sVar='0' THEN
         sCodMotivo :='2';
     ELSE
         sCodMotivo :='1';
     END IF;
      RETURN sCodMotivo;
EXCEPTION
     WHEN OTHERS THEN
         RETURN 'ERROR |'||SQLERRM;
END;


----------------------------------------------------------------------------
-- FN_TMM_FECHA INGRESO          --
----------------------------------------------------------------------------
FUNCTION FN_TMM_fecingreso(V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN VARCHAR2 IS

sFec_ingreso VARCHAR2(512);
BEGIN
     SELECT TO_CHAR(fec_ingreso,'mm/dd/yyyy')
  INTO sFec_ingreso
  FROM ICC_MOVIMIENTO
  WHERE num_movimiento=V_NUM_MOV;
  RETURN sFec_ingreso;
EXCEPTION
  WHEN OTHERS THEN
         RETURN 'ERROR |'||SQLERRM;
END;

-----------------------------------------------------------------------------------------
-- FN_TMM_SWREGION -- Retorna el SW de region.                          ---
-----------------------------------------------------------------------------------------
FUNCTION FN_TMM_SWREGION (V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING
IS
 v_out STRING(8);
 v_outnue string(8);
 v_region NUMBER(3);
 v_nummin STRING(512);
 v_numminnue STRING(512);
 v_piv STRING(10);
 v_pivnum NUMBER(10);
 v_pivnue STRING(10);
 v_pivnumnue NUMBER(10);
 v_flag BOOLEAN := TRUE;
 error_proceso EXCEPTION;
 error_proceso_nue EXCEPTION;

BEGIN
  v_out :=99;
  v_outnue := 99;
  v_nummin:=Ic_Pkg_Parametros.FN_TMM_nummin(V_NUM_MOV);

  v_piv:=SUBSTR(v_nummin,1,7);
  v_pivnum:=TO_NUMBER(v_piv);

  BEGIN
   SELECT REGION
   INTO v_region
   FROM ICC_SWITCH_TO
   WHERE v_pivnum BETWEEN COD_INFERIOR AND COD_SUPERIOR;
  EXCEPTION
     WHEN NO_DATA_FOUND THEN
      v_flag := FALSE;
  END;

  IF v_flag = TRUE THEN
    v_out:='REGION ' || TO_CHAR(v_region);
  ELSE
    v_out := 99;
  END IF;

  v_numminnue:=LTRIM(RTRIM(SUBSTR(v_nummin, INSTR(v_nummin,'|') +1)));
  v_pivnue:=SUBSTR(v_numminnue,1,7);
  v_pivnumnue:=TO_NUMBER(v_pivnue);

  BEGIN
   SELECT REGION
   INTO v_region
   FROM ICC_SWITCH_TO
   WHERE v_pivnumnue BETWEEN COD_INFERIOR AND COD_SUPERIOR;
  EXCEPTION
     WHEN OTHERS THEN
      RAISE error_proceso_nue;
  END;

  v_outnue:='REGION ' || TO_CHAR(v_region);

  RETURN v_out|| '|' ||v_outnue;

EXCEPTION
   WHEN error_proceso_nue THEN
      RETURN v_out|| '|' ||v_outnue;
   WHEN OTHERS THEN
      RETURN v_out|| '|' ||v_outnue;
END;
----------------------------------------------------------------------------
-- FN_TMM_NUMABONADO                               --
----------------------------------------------------------------------------

 FUNCTION FN_TMM_numabonado(V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
    v_num_abonado ICC_MOVIMIENTO.NUM_ABONADO%TYPE;
    error_proceso EXCEPTION;
  BEGIN

    SELECT NVL(NUM_ABONADO, 0) INTO v_num_abonado
    FROM ICC_MOVIMIENTO
    WHERE num_movimiento = v_num_mov;

    IF SQLCODE <> 0 THEN
       RAISE error_proceso;
    END IF;

    v_out := TO_CHAR(v_num_abonado) || '|' || TO_CHAR(v_num_abonado);

    RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_TMM_numabonado, SQLCODE:' || TO_CHAR(SQLCODE) || '-SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_TMM_numabonado, SQLCODE:' || TO_CHAR(SQLCODE) || '-SLQERRM:' || SQLERRM;
  END;

-----------------------------------------------------------------------------------------
-- FN_TMM_SWITCHID-- Retorna el ID del SW .                           --
-----------------------------------------------------------------------------------------
FUNCTION FN_TMM_SWITCHID (V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING
IS

v_out NUMBER(10);
v_outnue string(8);
v_switchid NUMBER(3);
v_nummin STRING(512);
v_numminnue STRING(512);
v_piv STRING(10);
v_pivnum NUMBER(10);
v_pivnue STRING(10);
v_pivnumnue NUMBER(10);
v_flag BOOLEAN := TRUE;
error_proceso EXCEPTION;
error_proceso_nue EXCEPTION;

BEGIN
   v_out := 99;
   v_outnue := 99;
   v_nummin:=Ic_Pkg_Parametros.FN_TMM_nummin(V_NUM_MOV);

   v_piv:=SUBSTR(v_nummin,1,7);
   v_pivnum:=TO_NUMBER(v_piv);

   BEGIN
   SELECT SWITCHID
   INTO v_switchid
   FROM ICC_SWITCH_TO
   WHERE v_pivnum BETWEEN COD_INFERIOR AND COD_SUPERIOR;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
          v_flag := FALSE;
   END;

   IF v_flag = TRUE THEN
     v_out:=v_switchid;
   ELSE
     v_out := 99;
   END IF;

   v_numminnue:=LTRIM(RTRIM(SUBSTR(v_nummin, INSTR(v_nummin,'|') +1)));
   v_pivnue:=SUBSTR(v_numminnue,1,7);
   v_pivnumnue:=TO_NUMBER(v_pivnue);

   BEGIN
   SELECT SWITCHID
   INTO v_switchid
   FROM ICC_SWITCH_TO
   WHERE v_pivnumnue BETWEEN COD_INFERIOR AND COD_SUPERIOR;
   EXCEPTION
     WHEN OTHERS THEN
      RAISE error_proceso_nue;
   END;

   v_outnue:=v_switchid;

   RETURN v_out|| '|' ||v_outnue;

EXCEPTION
   WHEN error_proceso_nue THEN
      RETURN v_out|| '|' ||v_outnue;
   WHEN OTHERS THEN
      RETURN v_out|| '|' ||v_outnue;

END;
-----------------------------------------------------------------------------------------
-- FN_TMM_NUMSWITCH -- Retorna el num del SW .                           --
-----------------------------------------------------------------------------------------
FUNCTION FN_TMM_NUMSWITCH (V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING
IS
   v_out NUMBER(10);
   v_outnue string(8);
   v_numswitch NUMBER(5);
   v_nummin STRING(512);
   v_numminnue STRING(512);
   v_piv STRING(10);
   v_pivnum NUMBER(10);
   v_pivnue STRING(10);
   v_pivnumnue NUMBER(10);
   v_flag BOOLEAN := TRUE;
   error_proceso EXCEPTION;
   error_proceso_nue EXCEPTION;

BEGIN
   v_out := 99;
   v_outnue := 99;
   v_nummin:=Ic_Pkg_Parametros.FN_TMM_nummin(V_NUM_MOV);

   v_piv:=SUBSTR(v_nummin,1,7);
   v_pivnum:=TO_NUMBER(v_piv);

   BEGIN
    SELECT NUM_SWITCH
    INTO v_numswitch
    FROM ICC_SWITCH_TO
    WHERE v_pivnum BETWEEN COD_INFERIOR AND COD_SUPERIOR;
   EXCEPTION
     WHEN NO_DATA_FOUND THEN
           v_flag := FALSE;
   END;

   IF v_flag = TRUE THEN
     v_out:=v_numswitch;
   ELSE
     v_out := 99;
   END IF;

   v_numminnue:=LTRIM(RTRIM(SUBSTR(v_nummin, INSTR(v_nummin,'|') +1)));
   v_pivnue:=SUBSTR(v_numminnue,1,7);
   v_pivnumnue:=TO_NUMBER(v_pivnue);

   BEGIN
    SELECT NUM_SWITCH
    INTO v_numswitch
    FROM ICC_SWITCH_TO
    WHERE v_pivnumnue BETWEEN COD_INFERIOR AND COD_SUPERIOR;
   EXCEPTION
     WHEN OTHERS THEN
      RAISE error_proceso_nue;
   END;

   v_outnue:=v_numswitch;
   RETURN v_out|| '|' ||v_outnue;

EXCEPTION
   WHEN error_proceso_nue THEN
      RETURN v_out|| '|' ||v_outnue;
   WHEN OTHERS THEN
      RETURN v_out|| '|' ||v_outnue;
END;

----------------------------------------------------------------------------
-- FN_TMM_PLANANT                               --
----------------------------------------------------------------------------
FUNCTION FN_TMM_PLANANT(v_num_mov IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
    v_num_abo VARCHAR2(20);
    v_plan    VARCHAR2(20);
    error_proceso EXCEPTION;
  BEGIN

    SELECT NVL(TO_CHAR(NUM_ABONADO), '0')
    INTO v_num_abo
    FROM ICC_MOVIMIENTO
    WHERE num_movimiento = v_num_mov;

    IF SQLCODE <> 0 THEN
       RAISE error_proceso;
    END IF;

    IF v_num_abo <> '0' THEN
       -- Rescata el  plan antiguo para el abonado
         v_out := Pv_Rec_Plan_Antiguo_Fn(v_num_abo);

    ELSE
       RETURN 'ERROR FN_TMM_PLAN, Codigo de Abonado 0 no corresponde';
    END IF;

    RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_TMM_PLAN, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_TMM_MSISDN, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
  END;

----------------------------------------------------------------------------
-- FN_TMM_NUMSERNUE --
----------------------------------------------------------------------------
  FUNCTION FN_TMM_numsernue(v_num_mov IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
        v_num_ser ICC_MOVIMIENTO.num_serie%TYPE;
        v_num_ser_nue ICC_MOVIMIENTO.num_serie_nue%TYPE;
    error_proceso EXCEPTION;
        v_mov ICC_MOVIMIENTO%ROWTYPE;
  BEGIN

    SELECT NVL(num_serie, CHR(0)),NVL(num_serie_nue, CHR(0))
        INTO v_num_ser, v_num_ser_nue
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        IF v_num_ser_nue = CHR(0) THEN
          v_out := v_num_ser;
        ELSE
          v_out := v_num_ser_nue;
        END IF;

  RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_TMM_numsernue, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_TMM_numsernue, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
  END;

----------------------------------------------------------------------------
-- FN_TMM_DESCNETBRUT
------------------------------------------------------------------------------
  FUNCTION FN_TMM_DESCNETBRUT(V_Num_Movimiento  IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN VARCHAR2 IS

 v_Carga           ICC_MOVIMIENTO.CARGA%TYPE;
 v_Valor_plan      ICC_MOVIMIENTO.VALOR_PLAN%TYPE;
 V_VAL_PARAMETRO   GED_PARAMETROS.VAL_PARAMETRO%TYPE;
 V_VAL_PARAMETRO2   GED_PARAMETROS.VAL_PARAMETRO%TYPE;
 V_Num_Abonado     ICC_MOVIMIENTO.NUM_ABONADO%TYPE;
 V_Mto_Carga       NUMBER;
 V_PARAM           VARCHAR2(200) := 0;

BEGIN

  BEGIN

  SELECT VAL_PARAMETRO INTO V_VAL_PARAMETRO
  FROM GED_PARAMETROS
  WHERE NOM_PARAMETRO = 'FLAG_MTO_ENTRANTE' AND
  COD_MODULO = 'GA' AND
  COD_PRODUCTO = 1;

  EXCEPTION
          WHEN NO_DATA_FOUND THEN
                     RETURN 'PARAMETRO NO EXISTE | '||SQLERRM;
          WHEN OTHERS THEN
                     RETURN 'PARAM ERROR FLAG_MTO_ENTRANTE | ' ||SQLERRM;
  END;

  /*CAPTURA FLG MTO SALIENTE */
  BEGIN
  SELECT   VAL_PARAMETRO   INTO   V_VAL_PARAMETRO2
  FROM   GED_PARAMETROS
  WHERE   NOM_PARAMETRO = 'FLAG_MTO_SALIENTE' AND
  COD_MODULO    = 'GA'      AND
  COD_PRODUCTO  = 1;

  EXCEPTION
          WHEN NO_DATA_FOUND THEN
                      RETURN 'PARAMETRO NO EXISTE | '||SQLERRM;
          WHEN OTHERS THEN
                     RETURN 'PARAM ERROR FLAG_MTO_SALIENTE | ' ||SQLERRM;
  END;


  BEGIN
   SELECT NVL(carga,0), NUM_ABONADO
   INTO v_Carga, V_Num_Abonado
   FROM ICC_MOVIMIENTO
   WHERE
   NUM_MOVIMIENTO =  V_Num_Movimiento;

  EXCEPTION
  WHEN NO_DATA_FOUND THEN
       RETURN 'MOVIMIENTO NO EXISTE | '||SQLERRM;
  WHEN OTHERS THEN
       RETURN 'ERROR ACCESO ICC_MOVIMIENTO | '||SQLERRM;
  END;

  IF v_Carga = 0 THEN
     V_PARAM := CHR(0);
  ELSE
    IF V_VAL_PARAMETRO2<>V_VAL_PARAMETRO THEN
         V_PARAM := Pv_Mtonbporc_Fn(V_Num_Movimiento,NULL,v_Carga,V_VAL_PARAMETRO,V_Num_Abonado);
    ELSE
        V_PARAM:= v_Carga;
    END IF;
  END IF;

  RETURN V_PARAM;

END FN_TMM_DESCNETBRUT;

----------------------------------------------------------------------------
-- FN_TMM_NUMCELNUE --
----------------------------------------------------------------------------
  FUNCTION FN_TMM_numcelnue(v_num_mov IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
    error_proceso EXCEPTION;
  BEGIN

    SELECT NVL(TO_CHAR(num_celular_nue), CHR(0))
        INTO v_out
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

    RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_TMM_numcelnue, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
          RAISE_APPLICATION_ERROR(-20000, 'ERROR OTHERS');
      RETURN 'ERROR FN_TMM_numcelnue, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
  END;

-----------------------------------------------------------------------------------------
-- FN_TMM_TIPO -- Retorna el tipo de abonado (pospago o prepago).
----------------------------------------------------------------------------------------
FUNCTION FN_TMM_TIPO (V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(7);
    v_out_nue STRING(7);
    v_num_cel     VARCHAR2(512);
    v_num_cel_nue VARCHAR2(512);
    v_existe      NUMBER;
    error_proceso EXCEPTION;
  BEGIN

  v_existe := 0;
    SELECT NVL(TO_CHAR(num_celular), CHR(0)), NVL(TO_CHAR(num_celular_nue),CHR(0))
        INTO v_num_cel, v_num_cel_nue
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        SELECT COUNT(1) INTO v_existe
         FROM GA_ABOCEL
        WHERE num_celular = v_num_cel;

        IF v_existe > 0 THEN
          v_out:='POSPAGO';
        ELSE
          v_out:='PREPAGO';
        END IF;

        IF v_num_cel_nue = CHR(0) THEN
           v_out_nue := v_out;
        ELSE
          SELECT COUNT(1) INTO v_existe
           FROM GA_ABOCEL
          WHERE num_celular = v_num_cel_nue;

          IF v_existe > 0 THEN
            v_out_nue:='POSPAGO';
          ELSE
            v_out_nue:='PREPAGO';
          END IF;
        END IF;

        RETURN v_out|| '|' ||v_out_nue;

        EXCEPTION
           WHEN error_proceso THEN
                RETURN 'ERROR FN_TMM_TIPO, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:'
              || SQLERRM;
           WHEN NO_DATA_FOUND THEN
                 RETURN 'ERROR FN_TMM_TIPO, NO HAY celular en tablas maestras | '||SQLERRM;
           WHEN OTHERS THEN
              RETURN 'ERROR FN_TMM_TIPO, ERROR ACCESO | '||SQLERRM;
END;

-----------------------------------------------------------------------------------------
-- FN_TMM_TIPOTEC -- Retorna el tipo de abonado (pospago o prepago).
----------------------------------------------------------------------------------------
FUNCTION FN_TMM_TIPOTEC (V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(10);
    v_tip_tec     ICC_MOVIMIENTO.TIP_TECNOLOGIA%TYPE;
    error_proceso EXCEPTION;
  BEGIN


    SELECT LTRIM(RTRIM(tip_tecnologia))
        INTO v_tip_tec
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        v_out:= v_tip_tec;

        RETURN v_out|| '|' ||v_out;

        EXCEPTION
           WHEN error_proceso THEN
                RETURN 'ERROR FN_TMM_TIPOTEC, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:'
              || SQLERRM;
           WHEN NO_DATA_FOUND THEN
                 RETURN 'ERROR FN_TMM_TIPOTEC, NO HAY dato de Tipo Tecnologia | '||SQLERRM;
           WHEN OTHERS THEN
              RETURN 'ERROR FN_TMM_TIPOTEC, ERROR ACCESO | '||SQLERRM;
END;

----------------------------------------------------------------------------
-- FN_TMM_MTOCARGA --
----------------------------------------------------------------------------
  FUNCTION FN_TMM_mtocarga(V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
    error_proceso EXCEPTION;
    v_Carga                ICC_MOVIMIENTO.CARGA%TYPE;
    V_Num_Abonado           ICC_MOVIMIENTO.NUM_ABONADO%TYPE;
    v_cod_mod              ICC_MOVIMIENTO.cod_modulo%TYPE;
    v_tip_tecnologia       ICC_MOVIMIENTO.tip_tecnologia%TYPE;
    v_num_celular          ICC_MOVIMIENTO.num_celular%TYPE;
    v_cargobasico          GA_ABOCEL.cod_cargobasico%TYPE;
    v_imp_cargobasico      TA_CARGOSBASICO.imp_cargobasico%TYPE;
    v_region               GA_ABOCEL.cod_region%TYPE;
    v_provincia            GA_ABOCEL.cod_provincia%TYPE;
    v_ciudad               GA_ABOCEL.cod_ciudad%TYPE;
    v_zonaimpositiva       GE_ZONACIUDAD.cod_zonaimpo%TYPE;
    LV_cod_situacion_baa   ga_abocel.cod_situacion%type:='BAA';
    LV_cod_situacion_bap   ga_abocel.cod_situacion%type:='BAP';
  BEGIN

  SELECT NVL(TO_CHAR(carga), CHR(0)), NUM_ABONADO, NVL(cod_modulo, CHR(0)),tip_tecnologia,num_celular
    INTO  v_out, V_Num_Abonado, v_cod_mod,v_tip_tecnologia,v_num_celular
    FROM ICC_MOVIMIENTO
    WHERE NUM_MOVIMIENTO =  v_num_mov;

         -- Situacion particular.
     IF V_COD_MOD = 'IC' THEN
     BEGIN
        IF substr(v_tip_tecnologia,1,3) = 'CDM' THEN

  --- Modificación x TM-200410050976
    --- Se estaba consultando por num celular , trayendo más de una fila.
           SELECT COD_CARGOBASICO, NUM_ABONADO INTO v_cargobasico, v_num_abonado
           FROM GA_ABOCEL
           WHERE NUM_CELULAR = v_num_celular
             AND COD_SITUACION NOT IN (LV_cod_situacion_baa, LV_cod_situacion_bap)
           ORDER BY fec_alta DESC;
    --- FIN  TM-200410050976

           SELECT IMP_CARGOBASICO INTO v_imp_cargobasico
           FROM TA_CARGOSBASICO WHERE COD_CARGOBASICO = v_cargobasico;

           V_carga := v_imp_cargobasico;

       --- Modificación x TM-200410050976
         SELECT COD_REGION,COD_PROVINCIA,COD_CIUDAD
         INTO v_region,v_provincia,v_ciudad
         FROM GA_ABOCEL
         WHERE  NUM_ABONADO = v_num_abonado AND NUM_CELULAR = v_num_celular;
         --- Modificación x TM-200410050976

           SELECT COD_ZONAIMPO INTO v_zonaimpositiva FROM GE_ZONACIUDAD
           WHERE COD_REGION = v_region
           AND COD_PROVINCIA = v_provincia
           AND COD_CIUDAD = v_ciudad
           AND ROWNUM = 1;

           IF v_zonaimpositiva = '1' THEN
              V_carga := ROUND(V_carga * 1.15);
           ELSE
              V_carga := ROUND(V_carga * 1.1);
           END IF;

           v_out:= V_carga;
        END IF;
        IF v_tip_tecnologia = 'GSM' THEN
           --- Modificación x TM-200410050976
         SELECT COD_CARGOBASICO  INTO v_cargobasico
         FROM GA_ABOCEL
         WHERE NUM_CELULAR = v_num_celular
          AND COD_SITUACION NOT IN (LV_cod_situacion_baa, LV_cod_situacion_bap)
         ORDER BY fec_alta DESC;
         --- Modificación x TM-200410050976

           SELECT IMP_CARGOBASICO INTO v_imp_cargobasico
           FROM TA_CARGOSBASICO WHERE COD_CARGOBASICO = v_cargobasico;

           V_carga := v_imp_cargobasico;

           v_out:= V_carga;
        END IF;
     END;
     END IF;


        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_TMM_mtocarga, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_TMM_mtocarga, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
  END;

----------------------------------------------------------------------------
-- FN_TMM_NUMSERACT --
----------------------------------------------------------------------------
FUNCTION FN_TMM_numseract(v_num_mov IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
        v_num_ser ICC_MOVIMIENTO.num_serie%TYPE;
        v_num_ser_nue ICC_MOVIMIENTO.num_serie_nue%TYPE;
    error_proceso EXCEPTION;
        v_mov ICC_MOVIMIENTO%ROWTYPE;
  BEGIN

    SELECT NVL(num_serie, CHR(0)),NVL(num_serie_nue, CHR(0))
        INTO v_num_ser, v_num_ser_nue
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        IF v_num_ser_nue = CHR(0) THEN
          v_out := v_num_ser;
        ELSE
          v_out := v_num_ser;
        END IF;

  RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_TMM_numseract, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_TMM_numseract, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
  END;


----------------------------------------------------------------------------
-- FN_TMM_CODPLAN --
----------------------------------------------------------------------------
FUNCTION Fn_Tmm_Codplan(V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    V_OUT        STRING(512);
    V_CODE       STRING(5);
    V_PLAN       ICC_MOVIMIENTO.PLAN%TYPE;
    V_TIP_TECNO  ICC_MOVIMIENTO.tip_tecnologia%TYPE;
    v_subtec     ICC_MOVIMIENTO.tip_tecnologia%TYPE;
    v_modulo     ICC_MOVIMIENTO.cod_modulo%TYPE;
    v_actabo     ICC_MOVIMIENTO.cod_actabo%TYPE;
    error_proceso EXCEPTION;
    error_homologacion EXCEPTION;
  BEGIN

       SELECT NVL(b.PLAN, CHR(0)), NVL(b.TIP_TECNOLOGIA, CHR(0)), c.tecnologia, b.cod_modulo, b.cod_actabo
       INTO v_plan, v_tip_tecno, v_subtec, v_modulo, v_actabo
       FROM ICC_MOVIMIENTO b, (SELECT a.cod_central,
       DECODE(SUBSTR(a.nom_central,1,4),'C190','CD1900','C850','CD850','GSM') AS tecnologia
       FROM icg_central a) c
       WHERE b.num_movimiento = v_num_mov
       AND c.cod_central =  b.cod_central;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

       IF substr(v_tip_tecno,1,3) = 'CDM' THEN

          IF  v_modulo = 'AL' OR (v_modulo = 'GA' AND (v_actabo = 'AM'))  THEN
              v_out := Pv_Homologacionplan_Fn(v_plan);

           IF v_subtec = 'CD850'  THEN
                   v_out := v_out||'B';
           ELSE
                   v_out := v_out||'A';
           END IF;
          ELSE
              v_out := v_plan;
          END IF;

              v_code := SUBSTR(v_out,1,4);
              IF v_code = 'ORA-' THEN
                 RAISE error_homologacion;
              END IF;
       ELSE
          v_out := v_plan;
       END IF;

       v_out := v_out || '|' || v_out;
       RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_TMM_codplan, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN error_homologacion THEN
      RETURN 'ERROR FN_TMM_codplan, SLQERRM:' || v_out;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_TMM_codplan, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
  END;

-----------------------------------------------------------------------------------------
-- FN_TMM_SWREGION_MEX -- Retorna el Home: MEXICO siempre que sea 850 (norte) y 99 si 1900
-----------------------------------------------------------------------------------------
FUNCTION FN_TMM_SWREGION_MEX (V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING
IS
 v_out STRING(8);
 v_outnue string(8);
 v_region NUMBER(3);
 v_nummin STRING(512);
 v_numminnue STRING(512);
 v_piv STRING(10);
 v_pivnum NUMBER(10);
 v_pivnue STRING(10);
 v_pivnumnue NUMBER(10);
 v_flag BOOLEAN := TRUE;
 error_proceso EXCEPTION;
 error_proceso_nue EXCEPTION;

BEGIN
  v_out :=99;
  v_outnue := 99;
  v_nummin:=Ic_Pkg_Parametros.FN_TMM_nummin(V_NUM_MOV);

  v_piv:=SUBSTR(v_nummin,1,7);
  v_pivnum:=TO_NUMBER(v_piv);

  BEGIN
   SELECT REGION
   INTO v_region
   FROM ICC_SWITCH_TO
   WHERE v_pivnum BETWEEN COD_INFERIOR AND COD_SUPERIOR;
  EXCEPTION
     WHEN NO_DATA_FOUND THEN
      v_flag := FALSE;
  END;

  IF v_flag = TRUE THEN
    v_out:='MEXICO';
  ELSE
    v_out := 99;
  END IF;

  v_numminnue:=LTRIM(RTRIM(SUBSTR(v_nummin, INSTR(v_nummin,'|') +1)));
  v_pivnue:=SUBSTR(v_numminnue,1,7);
  v_pivnumnue:=TO_NUMBER(v_pivnue);

  BEGIN
   SELECT REGION
   INTO v_region
   FROM ICC_SWITCH_TO
   WHERE v_pivnumnue BETWEEN COD_INFERIOR AND COD_SUPERIOR;
  EXCEPTION
     WHEN OTHERS THEN
      RAISE error_proceso_nue;
  END;

  v_outnue:='MEXICO';

  RETURN v_out|| '|' ||v_outnue;

EXCEPTION
   WHEN error_proceso_nue THEN
      RETURN v_out|| '|' ||v_outnue;
   WHEN OTHERS THEN
      RETURN v_out|| '|' ||v_outnue;
END;

-----------------------------------------------------------------------------------------
-- FN_TMM_planAH-- Retorna el plan ahooro basico de CDMA apara anulaciones de baja en Sixbell
-----------------------------------------------------------------------------------------
FUNCTION Fn_Tmm_planAH(V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    V_OUT        STRING(512);
    V_CODE       STRING(5);
    V_PLAN       ICC_MOVIMIENTO.PLAN%TYPE;
    V_TIP_TECNO  ICC_MOVIMIENTO.tip_tecnologia%TYPE;
    v_subtec     ICC_MOVIMIENTO.tip_tecnologia%TYPE;
    v_modulo     ICC_MOVIMIENTO.cod_modulo%TYPE;
    error_proceso EXCEPTION;

  BEGIN
       SELECT NVL(b.PLAN, CHR(0)), NVL(b.TIP_TECNOLOGIA, CHR(0)), c.tecnologia, b.cod_modulo
       INTO v_plan, v_tip_tecno, v_subtec, v_modulo
       FROM ICC_MOVIMIENTO b, (SELECT a.cod_central,
       DECODE(SUBSTR(a.nom_central,1,4),'C190','CD1900','C850','CD850','GSM') AS tecnologia
       FROM icg_central a) c
       WHERE b.num_movimiento = v_num_mov
       AND c.cod_central =  b.cod_central;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

       IF substr(v_tip_tecno,1,3) = 'CDM' THEN
          IF v_subtec = 'CD850'  THEN
                   v_out := 21||'B';
           ELSE
                   v_out := 21||'A';
           END IF;
       END IF;

       v_out := v_out || '|' || v_out;
       RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_TMM_planAH, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_TMM_planAH, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
  END;

-----------------------------------------------------------------------------------------
-- FN_TMM_umbral.
-----------------------------------------------------------------------------------------

  FUNCTION FN_TMM_umbral(v_num_mov IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN VARCHAR2 IS
    /*
  <NOMBRE>            : FN_TMM_umbral.</NOMBRE>
  <FECHACREA>        : 09/07/2004<FECHACREA/>
  <MODULO >            : IC </MODULO >
  <AUTOR >          : Maritza Tapia A </AUTOR >
  <VERSION >         : 1.0</VERSION >
  <DESCRIPCION>     : Breve descripción explicativa </DESCRIPCION>
  <FECHAMOD >         : DD/MM/YYYY </FECHAMOD >
  <DESCMOD >           : Breve descripción de Modificación </DESCMOD >
  <ParamEntr>       : V_NUM_MOV numero de Movimento. </ParamEntr>
  <ParamSal >       : umbral </ParamEntr>
  */
    SV_out STRING(512);
    TN_num_cel ICC_MOVIMIENTO.num_celular%TYPE;
    error_proceso EXCEPTION;
  BEGIN
       SELECT NVL(num_celular, 0) INTO TN_num_cel
       FROM ICC_MOVIMIENTO
       WHERE num_movimiento = v_num_mov;

       IF SQLCODE <> 0 THEN
          RAISE error_proceso;
       END IF;

       IF TN_num_cel IS NOT NULL THEN
          SV_out := PV_UMBRAL_FN(TN_num_cel);
       END IF;

       RETURN SV_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_TMM_umbral, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_TMM_umbral, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
  END;

-----------------------------------------------------------------------------------------
-- FN_TMM_numavisos.
-----------------------------------------------------------------------------------------

  FUNCTION FN_TMM_numavisos(v_num_mov IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN VARCHAR2 IS
    /*
  <NOMBRE>            : FN_TMM_numavisos</NOMBRE>
  <FECHACREA>        : 12/07/2004<FECHACREA/>
  <MODULO >            : IC </MODULO >
  <AUTOR >          : Maritza Tapia A </AUTOR >
  <VERSION >         : 1.0</VERSION >
  <DESCRIPCION>     : Breve descripción explicativa </DESCRIPCION>
  <FECHAMOD >         : DD/MM/YYYY </FECHAMOD >
  <DESCMOD >           : Breve descripción de Modificación </DESCMOD >
  <ParamEntr>       : V_NUM_MOV numero de Movimento. </ParamEntr>
  <ParamSal >       : cant_avisos </ParamEntr>
  */
    SV_out STRING(512);
    TN_num_cel ICC_MOVIMIENTO.num_celular%TYPE;
    error_proceso EXCEPTION;
  BEGIN
          SELECT NVL(num_celular, 0) INTO TN_num_cel
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        IF TN_num_cel IS NOT NULL THEN
              SV_out := PV_NUMAVISOS_FN(TN_num_cel);
        END IF;

        RETURN SV_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_TMM_numavisos, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_TMM_numavisos, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
  END;

-----------------------------------------------------------------------------------------
-- FN_TMM_codbono.
-----------------------------------------------------------------------------------------

  FUNCTION FN_TMM_codbono(v_num_mov IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN VARCHAR2 IS
  /*
  <NOMBRE>            : FN_TMM_codBono</NOMBRE>
  <FECHACREA>        : 25/08/2004<FECHACREA/>
  <MODULO >            : IC </MODULO >
  <AUTOR >          : Carlos Sellao H. </AUTOR >
  <VERSION >         : 1.0</VERSION >
  <DESCRIPCION>     : Obtiene codigo de bono. </DESCRIPCION>
  <FECHAMOD >         : DD/MM/YYYY </FECHAMOD >
  <DESCMOD >           : Breve descripción de Modificación </DESCMOD >
  <ParamEntr>       : V_NUM_MOV numero de Movimento. </ParamEntr>
  <ParamSal >       : codigo de bono </ParamEntr>
  */

    v_out STRING(512);
    Bono_out STRING(512);
    error_proceso EXCEPTION;
  BEGIN
        SELECT NVL(valor2, CHR(0)) INTO v_out
        FROM PV_ICGENERICA_TO
        WHERE num_movimiento = v_num_mov;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        Bono_out := v_out;
        RETURN Bono_out;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      Bono_out := CHR(0);
      RETURN Bono_out;
    WHEN error_proceso THEN
      RETURN 'ERROR FN_TMM_codBono, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_TMM_codBono, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
  END;

----------------------------------------------------------------------------
-- FN_TMM_FECEXPIRA --
----------------------------------------------------------------------------
  FUNCTION FN_TMM_fecexpira(v_num_mov IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING IS
    v_out STRING(512);
    error_proceso EXCEPTION;
  BEGIN

    SELECT NVL(TO_CHAR(fec_expira, 'DDMMYYYY'), CHR(0))
    INTO v_out
    FROM ICC_MOVIMIENTO
    WHERE num_movimiento = v_num_mov;

    IF SQLCODE <> 0 THEN
      RAISE error_proceso;
    END IF;

    RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_TMM_fecexpira, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_TMM_fecexpira, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
  END;


  FUNCTION IC_CODLIS_FN(EN_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN VARCHAR2 IS
    /*
    <Documentación TipoDoc = "Función">
    <Elemento Nombre = "IC_CODLIS_FN" Lenguaje="PL/SQL" Fecha="01-04-2005" Versión="1.0.0" Diseñador="Stuver Cañete" Programador="Maritsa Tapia" Ambiente="BD">
    <Retorno>Código de Lista</Retorno>
    <Descripción>Retorna código de lista asociado al abonado</Descripción>
    <Parámetros>
    <Entrada>
    <param nom="EN_NUM_MOV" Tipo="NUMBER(9)">Descripción Número de movimiento</param>
    </Entrada>
    <Salida>
    </Salida>
    </Parámetros>
    </Elemento>
    </Documentación>
    */

      LV_out STRING(512);
    error_proceso EXCEPTION;

    BEGIN

        SELECT a.valor2
          INTO LV_out
          FROM PV_ICGENERICA_TO a
         WHERE a.num_movimiento = EN_NUM_MOV;

          IF SQLCODE <> 0 THEN
                       RAISE error_proceso;
          END IF;


          RETURN LV_out;


      EXCEPTION
        WHEN error_proceso THEN
                RETURN 'ERROR IC_CODLIS_FN, SQLCODE:' || TO_CHAR(SQLCODE) ||' SLQERRM:' || SQLERRM;
        WHEN OTHERS THEN
               RETURN 'ERROR IC_CODLIS_FN, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    END;

    FUNCTION IC_CADITEM_FN(EN_num_mov IN icc_movimiento.NUM_MOVIMIENTO%TYPE) RETURN VARCHAR2 IS
    /*
    <Documentación TipoDoc = "Función">
    <Elemento Nombre = "IC_CADITEM_FN" Lenguaje="PL/SQL" Fecha="01-04-2005" Versión="1.0.0" Diseñador="Stuver Cañete" Programador="Maritsa Tapia" Ambiente="BD">
    <Retorno>Items</Retorno>
    <Descripción>Retorna cadena de items asociados a lista de números frecuentes</Descripción>
    <Parámetros>
    <Entrada>
    <param nom="EN_NUM_MOV" Tipo="NUMBER(9)">Descripción Número de movimiento</param>
    </Entrada>
    <Salida>
    </Salida>
    </Parámetros>
    </Elemento>
    </Documentación>
    */
        LV_out                  VARCHAR2(1024);
        LV_caditemant              VARCHAR2(1024);
        LV_caditempos              VARCHAR2(1024);
        LN_numfrecuente_ant   NUMBER(15);
        LN_numfrecuente       NUMBER(15);
        LD_fecingreso             DATE;
        LN_numabonado          NUMBER(10);
        LN_count              NUMBER(2);
        LV_lista                            varchar2(5);
        LV_numfrecuenteant      ppt_numerofrecuente.NUM_FRECUENTE_ANT%TYPE;
        LV_numfrecuente          ppt_numerofrecuente.NUM_FRECUENTE%TYPE;

        error_proceso EXCEPTION;

        CURSOR C1 (v_num  NUMBER, v_fec  DATE) is
            SELECT nro.num_frecuente_ant,nro.num_frecuente
              FROM ppt_numerofrecuente nro
             WHERE num_abonado = v_num
               AND fec_modificacion = v_fec;

    BEGIN

      SELECT NVL(icc.num_abonado, 0), icc.fec_ingreso
        INTO LN_numabonado,
               LD_fecingreso
        FROM icc_movimiento icc
       WHERE icc.num_movimiento = EN_num_mov;

    SELECT DISTINCT (a.ind_lista)
          INTO LV_lista
          FROM PPT_NUMEROFRECUENTE a
         WHERE a.num_abonado = LN_numabonado
           AND a.fec_modificacion = LD_fecingreso;

      LN_count := 1;
      OPEN C1(LN_numabonado, LD_fecingreso);
       LOOP
          FETCH C1 INTO LV_numfrecuenteant, LV_numfrecuente;
          EXIT WHEN C1%NOTFOUND;
          LV_caditemant := LV_caditemant || 'cadItemA' || TO_CHAR(LN_count) || '=' || LV_numfrecuenteant || ',';
          LV_caditempos := LV_caditempos || 'cadItemP' || TO_CHAR(LN_count) || '=' || LV_numfrecuente || ',';
            LN_count := LN_count + 1;
       END LOOP;

      CLOSE C1;
      LV_out := LV_lista || ',' || LTRIM(RTRIM(LV_caditemant||LV_caditempos));

      LV_out := SUBSTR(LV_out,1, LENGTH(LV_out)-1);

      RETURN LV_out;

    EXCEPTION
        WHEN error_proceso THEN
            RETURN 'ERROR IC_CADITEM_FN, SQLCODE:' || TO_CHAR(SQLCODE) ||' SLQERRM:' || SQLERRM;
        WHEN OTHERS THEN
            RETURN 'ERROR IC_CADITEM_FN, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    END;

----------------------------------------------------------------------------------
-- Funciones para Integracion Altamira --
----------------------------------------------------------------------------------

FUNCTION IC_FechaEjec_FN(
        EN_Num_Mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING IS
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_FechaEjec_FN"
                Lenguaje="PL/SQL"
                Fecha creación="05-12-2005"
                Creado por="Carlos Sellao H.."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>STRING</Retorno>
                <Descripción>Funcion para obtener la fecha de corte + 1 o de la primera ejecución</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_Num_Mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>
                                <param nom="LV_salida"       Tipo="CARACTER">Valor a retornar</param>
                                <param nom="LN_cod_retorno"  Tipo="NUMERICO">Codigo de Retorno</param>
                                <param nom="LV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
                                <param nom="LN_num_evento"   Tipo="NUMERICO">Numero de Evento</param>
                        </Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
        LN_cod_ciclo ga_abocel.cod_ciclo%TYPE;
        LN_num_abonado ga_abocel.num_abonado%TYPE;
        LN_cod_plantarif ta_plantarif.cod_plantarif%TYPE;
        LN_cod_tiplan ta_plantarif.cod_tiplan%TYPE;
        LV_nompar ged_parametros.nom_parametro%TYPE;
        LV_ndias ged_parametros.val_parametro%TYPE;
        LV_fecha_ejec VARCHAR2(64);
        LV_des_error VARCHAR2(512);
        sSql GE_Errores_PG.vQuery;

        LV_salida VARCHAR2(512);
        LN_cod_retorno ge_errores_td.cod_msgerror%TYPE;
        LV_mens_retorno ge_errores_td.det_msgerror%TYPE;
        LN_num_evento GE_Errores_PG.evento;
        LN_fecdesde ta_plantarif.FEC_DESDE%type;  -- Inc 42590

BEGIN
        sSql := 'SELECT icc.num_abonado';
        sSql := sSql||' INTO LN_num_abonado';
        sSql := sSql||' FROM icc_movimiento icc';
        sSql := sSql||' WHERE icc.num_movimiento = '||EN_Num_Mov;

        SELECT icc.num_abonado
        INTO   LN_num_abonado
        FROM   icc_movimiento icc
        WHERE  icc.num_movimiento = EN_Num_Mov;

        BEGIN
           sSql := 'SELECT abo.cod_ciclo, abo.cod_plantarif';
           sSql := sSql||' INTO LN_cod_ciclo, LN_cod_plantarif';
           sSql := sSql||' FROM ga_abocel abo';
           sSql := sSql||' WHERE abo.num_abonado = '||LN_num_abonado;

           SELECT abo.cod_ciclo, abo.cod_plantarif
           INTO   LN_cod_ciclo, LN_cod_plantarif
           FROM   ga_abocel abo
           WHERE  abo.num_abonado = LN_num_abonado;

        EXCEPTION
           WHEN NO_DATA_FOUND THEN
              BEGIN
                 sSql := 'SELECT abo.cod_ciclo, abo.cod_plantarif';
                 sSql := sSql||' INTO LN_cod_ciclo, LN_cod_plantarif';
                 sSql := sSql||' FROM ga_aboamist abo';
                 sSql := sSql||' WHERE abo.num_abonado = '||LN_num_abonado;

                 SELECT abo.cod_ciclo, abo.cod_plantarif
                 INTO   LN_cod_ciclo, LN_cod_plantarif
                 FROM   ga_aboamist abo
                 WHERE  abo.num_abonado = LN_num_abonado;

                 EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                       LV_salida := 'FALSE';
                       RETURN LV_salida;
                    WHEN OTHERS THEN
                       LN_cod_retorno := CN_Err_FecEjec;
                       IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                          LV_mens_retorno := CV_Err_NoClasif;
                       END IF;
                       LV_des_error := 'IC_PKG_Parametros.IC_FechaEjec_FN('||EN_num_mov||'); - ' || SQLERRM;
                       LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_PKG_Parametros.IC_FechaEjec_FN',sSql,SQLCODE,LV_des_error);
                       LV_salida := 'FALSE';
                       RETURN LV_salida;
                       END;

           WHEN OTHERS THEN
              LN_cod_retorno := CN_Err_FecEjec;
              IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                 LV_mens_retorno := CV_Err_NoClasif;
              END IF;
              LV_des_error := 'IC_PKG_Parametros.IC_FechaEjec_FN('||EN_num_mov||'); - ' || SQLERRM;
              LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_PKG_Parametros.IC_FechaEjec_FN',sSql,SQLCODE,LV_des_error);
              LV_salida := 'FALSE';
              RETURN LV_salida;
        END;

        -- Inicio 42590
        -- Sin importar si esta abierto o cerrado trae el ultimo registro existente

        sSql := 'SELECT plant.cod_tiplan,MAX(plant.fec_desde)';
        sSql := sSql||' INTO   LN_cod_tiplan , LN_fecdesde';
        sSql := sSql||' FROM   ta_plantarif plant';
        sSql := sSql||' WHERE  plant.cod_producto = ' || CN_Producto;
        sSql := sSql||' AND    plant.cod_plantarif = ' || LN_cod_plantarif;
        sSql := sSql||' GROUP BY plant.cod_tiplan';

        SELECT plant.cod_tiplan,MAX(plant.fec_desde)
        INTO   LN_cod_tiplan , LN_fecdesde
        FROM   ta_plantarif plant
        WHERE  plant.cod_producto = CN_Producto
        AND    plant.cod_plantarif = LN_cod_plantarif
        GROUP BY plant.cod_tiplan;

        -- Fin 42590

        --      Un camino para hibridos y un camino para prepago.-
        IF LN_cod_tiplan = 3 THEN    -- HIBRIDOS.-

           sSql := 'SELECT TO_CHAR((fac.fec_hastallam + 1),'''||'yyyymmdd'||''')' || '000000' ||'dia';
           sSql := sSql||' INTO LV_fecha_ejec';
           sSql := sSql||' FROM fa_ciclfact fac';
           sSql := sSql||' WHERE fac.cod_ciclo = '||LN_cod_ciclo;
           sSql := sSql||' AND SYSDATE BETWEEN fac.fec_desdellam AND fac.fec_hastallam';

           SELECT TO_CHAR((fac.fec_hastallam + 1),'yyyymmdd')||'000000' dia
           INTO   LV_fecha_ejec
           FROM   fa_ciclfact fac
           WHERE  fac.cod_ciclo = LN_cod_ciclo
           AND SYSDATE BETWEEN fac.fec_desdellam AND fac.fec_hastallam;

        ELSIF LN_cod_tiplan = 1 THEN   -- PREPAGO.-

           LV_nompar := 'DIAS_INICIO';

           sSql := 'SELECT NVL(par.val_parametro,CHR(0))';
           sSql := sSql||' INTO LV_ndias';
           sSql := sSql||' FROM ged_parametros par';
           sSql := sSql||' WHERE par.nom_parametro = '''||LV_nompar||'''';
           sSql := sSql||' AND par.cod_modulo = '''||CV_Modulo||'''';
           sSql := sSql||' AND par.cod_producto = '||CN_Producto;

           SELECT NVL(par.val_parametro,CHR(0))
           INTO   LV_ndias
           FROM   ged_parametros par
           WHERE  par.nom_parametro = LV_nompar
           AND par.cod_modulo = CV_Modulo
           AND par.cod_producto = CN_Producto;

           LV_fecha_ejec := TO_CHAR((SYSDATE + TO_NUMBER(LV_ndias)),'yyyymmdd') || '000000';

        ELSE
           LV_fecha_ejec := 'FALSE: EL ABONADO:'|| TO_CHAR(LN_num_abonado) ||' NO ES HIBRIDO NI PREPAGO';
        END IF;

        LV_salida := LV_fecha_ejec;

        RETURN LV_fecha_ejec;

EXCEPTION
   WHEN NO_DATA_FOUND THEN
      LV_salida := 'FALSE';
      RETURN LV_salida;
   WHEN OTHERS THEN
      LN_cod_retorno := CN_Err_FecEjec;
      IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
         LV_mens_retorno := CV_Err_NoClasif;
      END IF;
      LV_des_error := 'IC_PKG_Parametros.IC_FechaEjec_FN('||EN_num_mov||'); - ' || SQLERRM;
      LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_PKG_Parametros.IC_FechaEjec_FN',sSql,SQLCODE,LV_des_error);
      LV_salida := 'FALSE';
      RETURN LV_salida;
END;

FUNCTION IC_Periodicidad_FN(
        EN_Num_Mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING IS
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_Periodicidad_FN"
                Lenguaje="PL/SQL"
                Fecha creación="05-12-2005"
                Creado por="Carlos Sellao H.."
                Fecha modificacion="24-04-2007"
                Modificado por="Igor Sánchez"
                Ambiente Desarrollo="BD">
                <Retorno>STRING</Retorno>
                <Descripción>Funcion para obtener el código de priodicida</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_Num_Mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>
                                <param nom="LV_salida"       Tipo="CARACTER">Valor a retornar</param>
                                <param nom="LN_cod_retorno"  Tipo="NUMERICO">Codigo de Retorno</param>
                                <param nom="LV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
                                <param nom="LN_num_evento"   Tipo="NUMERICO">Numero de Evento</param>
                        </Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
        LN_cod_ciclo ga_abocel.cod_ciclo%TYPE;
        LN_num_abonado ga_abocel.num_abonado%TYPE;
        LV_codpertot ged_parametros.val_parametro%TYPE;
        LV_nomciclo ged_parametros.nom_parametro%TYPE;
        LN_Cont NUMBER;
        LN_PosIni NUMBER;
        LN_PosLim NUMBER := 0;
        LV_PerTmp VARCHAR2(250);
        LV_Per VARCHAR2(512);
        LV_PerPaso VARCHAR2(250);
        LV_des_error VARCHAR2(512);
        sSql GE_Errores_PG.vQuery;

        LV_salida VARCHAR2(512);
        LN_cod_retorno ge_errores_td.cod_msgerror%TYPE;
        LV_mens_retorno ge_errores_td.det_msgerror%TYPE;
        LN_num_evento GE_Errores_PG.evento;

        /*
        SE MODIFICA PKG POR INCIDENCIA 39660, PERIOCIDAD DE CICLO 24/04/2007
        */

        LV_ciclo_per VARCHAR2(512);
    LN_cont_existe NUMBER;

    CURSOR CICLOS IS
        SELECT NOM_PARAMETRO, VALOR_TEXTO
        FROM IC_PARAMETROS_MULTIPLES_VW
        WHERE COD_MODULO = CV_Modulo;


BEGIN
        sSql := 'SELECT icc.num_abonado';
        sSql := sSql||' INTO LN_num_abonado';
        sSql := sSql||' FROM icc_movimiento icc';
        sSql := sSql||' WHERE icc.num_movimiento = '||EN_Num_Mov;

        SELECT
                icc.num_abonado
        INTO
                LN_num_abonado
        FROM
                icc_movimiento icc
        WHERE
                icc.num_movimiento = EN_Num_Mov;

        BEGIN
                sSql := 'SELECT abo.cod_ciclo';
                sSql := sSql||' INTO LN_cod_ciclo';
                sSql := sSql||' FROM ga_abocel abo';
                sSql := sSql||' WHERE abo.num_abonado = '||LN_num_abonado;

                SELECT
                        abo.cod_ciclo
                INTO
                        LN_cod_ciclo
                FROM
                        ga_abocel abo
                WHERE
                        abo.num_abonado = LN_num_abonado;

        EXCEPTION
                WHEN NO_DATA_FOUND THEN
                        BEGIN
                                sSql := 'SELECT abo.cod_ciclo';
                                sSql := sSql||' INTO LN_cod_ciclo';
                                sSql := sSql||' FROM ga_aboamist abo';
                                sSql := sSql||' WHERE abo.num_abonado = '||LN_num_abonado;

                                SELECT
                                        abo.cod_ciclo
                                INTO
                                        LN_cod_ciclo
                                FROM
                                        ga_aboamist abo
                                WHERE
                                        abo.num_abonado = LN_num_abonado;
                        EXCEPTION
                                WHEN NO_DATA_FOUND THEN
                                        LV_salida := 'FALSE';
                                        RETURN LV_salida;
                                WHEN OTHERS THEN
                                        LN_cod_retorno := CN_Err_PerCiclo;
                                        IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                                                LV_mens_retorno := CV_Err_NoClasif;
                                        END IF;
                                        LV_des_error := 'IC_PKG_Parametros.IC_Periodicidad_FN('||EN_num_mov||'); - ' || SQLERRM;
                                        LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_PKG_Parametros.IC_Periodicidad_FN',sSql,SQLCODE,LV_des_error);
                                        LV_salida := 'FALSE';
                                        RETURN LV_salida;
                        END;

                WHEN OTHERS THEN
                        LN_cod_retorno := CN_Err_PerCiclo;
                        IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                                LV_mens_retorno := CV_Err_NoClasif;
                        END IF;
                        LV_des_error := 'IC_PKG_Parametros.IC_Periodicidad_FN('||EN_num_mov||'); - ' || SQLERRM;
                        LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_PKG_Parametros.IC_Periodicidad_FN',sSql,SQLCODE,LV_des_error);
                        LV_salida := 'FALSE';
                        RETURN LV_salida;
        END;

        LV_nomciclo := 'PERCICLO_'||TO_CHAR(LN_cod_ciclo);

        LN_cont:=1;
    LN_cont_existe:=0;

    FOR C1 IN CICLOS LOOP
        BEGIN
             IF C1.NOM_PARAMETRO = LV_nomciclo THEN
                      LV_ciclo_per:=LV_ciclo_per || ',CodPer' || TO_CHAR(LN_cont) || '=' ||C1.VALOR_TEXTO;
                  LN_cont := LN_cont+1;
                  LN_cont_existe:=LN_cont_existe+1;
             END IF;
        END;
    END LOOP;
    LV_Per:= LV_ciclo_per;

    IF LN_cont_existe = 0 THEN
                LV_Per := 'FALSE: NO HAY CODIGOS DE PERIODICIDAD PARA EL CICLO' || TO_CHAR(LN_cod_ciclo);
        END IF;

        RETURN LV_Per;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
                LV_salida := 'FALSE';
                RETURN LV_salida;
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_PerCiclo;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_PKG_Parametros.IC_Periodicidad_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_PKG_Parametros.IC_Periodicidad_FN',sSql,SQLCODE,LV_des_error);
                LV_salida := 'FALSE';
                RETURN LV_salida;
END;

FUNCTION IC_PeriodNuevo_FN(
        EN_Num_Mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING IS
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_PeriodNuevo_FN"
                Lenguaje="PL/SQL"
                Fecha creación="05-12-2005"
                Creado por="Carlos Sellao H.."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>STRING</Retorno>
                <Descripción>Funcion para obtener el código de priodicidad y fecha de ejecución</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_Num_Mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>
                                <param nom="LV_salida"       Tipo="CARACTER">Valor a retornar</param>
                                <param nom="LN_cod_retorno"  Tipo="NUMERICO">Codigo de Retorno</param>
                                <param nom="LV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
                                <param nom="LN_num_evento"   Tipo="NUMERICO">Numero de Evento</param>
                        </Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
        LN_cod_ciclo ga_abocel.cod_ciclo%TYPE;
        LN_cod_ciclo_nue ga_abocel.cod_ciclo%TYPE;
        LN_num_abonado ga_abocel.num_abonado%TYPE;
        LN_cod_cliente ga_abocel.cod_cliente%TYPE;
        LV_codpertot ged_parametros.val_parametro%TYPE;
        LV_nomciclo ged_parametros.nom_parametro%TYPE;
        LV_fecha_ejec VARCHAR2(27);
        LN_Cont NUMBER;
        LN_PosIni NUMBER;
        LN_PosLim NUMBER := 0;
        LV_PerTmp VARCHAR2(250);
        LV_Per VARCHAR2(250);
        LV_PerPaso VARCHAR2(250);
        LV_des_error VARCHAR2(512);
        sSql GE_Errores_PG.vQuery;

        LV_salida VARCHAR2(512);
        LN_cod_retorno ge_errores_td.cod_msgerror%TYPE;
        LV_mens_retorno ge_errores_td.det_msgerror%TYPE;
        LN_num_evento GE_Errores_PG.evento;

BEGIN
        sSql := 'SELECT icc.num_abonado';
        sSql := sSql||' INTO LN_num_abonado';
        sSql := sSql||' FROM icc_movimiento icc';
        sSql := sSql||' WHERE icc.num_movimiento = '||EN_Num_Mov;

        SELECT
                icc.num_abonado
        INTO
                LN_num_abonado
        FROM
                icc_movimiento icc
        WHERE
                icc.num_movimiento = EN_Num_Mov;

        BEGIN
                sSql := 'SELECT abo.cod_ciclo, abo.cod_cliente';
                sSql := sSql||' INTO LN_cod_ciclo, LN_cod_cliente';
                sSql := sSql||' FROM ga_abocel abo';
                sSql := sSql||' WHERE abo.num_abonado = '||LN_num_abonado;

                SELECT
                        abo.cod_ciclo, abo.cod_cliente
                INTO
                        LN_cod_ciclo, LN_cod_cliente
                FROM
                        ga_abocel abo
                WHERE
                        abo.num_abonado = LN_num_abonado;

        EXCEPTION
                WHEN NO_DATA_FOUND THEN
                        BEGIN
                                sSql := 'SELECT abo.cod_ciclo, abo.cod_cliente';
                                sSql := sSql||' INTO LN_cod_ciclo, LN_cod_cliente';
                                sSql := sSql||' FROM ga_aboamist abo';
                                sSql := sSql||' WHERE abo.num_abonado = '||LN_num_abonado;

                                SELECT
                                        abo.cod_ciclo, abo.cod_cliente
                                INTO
                                        LN_cod_ciclo, LN_cod_cliente
                                FROM
                                        ga_aboamist abo
                                WHERE
                                        abo.num_abonado = LN_num_abonado;
                        EXCEPTION
                                WHEN NO_DATA_FOUND THEN
                                        LV_salida := 'FALSE';
                                        RETURN LV_salida;
                                WHEN OTHERS THEN
                                        LN_cod_retorno := CN_Err_PerCiclo;
                                        IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                                                LV_mens_retorno := CV_Err_NoClasif;
                                        END IF;
                                        LV_des_error := 'IC_PKG_Parametros.IC_PeriodNuevo_FN('||EN_num_mov||'); - ' || SQLERRM;
                                        LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_PKG_Parametros.IC_PeriodNuevo_FN',sSql,SQLCODE,LV_des_error);
                                        LV_salida := 'FALSE';
                                        RETURN LV_salida;
                        END;

                WHEN OTHERS THEN
                        LN_cod_retorno := CN_Err_PerCiclo;
                        IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                                LV_mens_retorno := CV_Err_NoClasif;
                        END IF;
                        LV_des_error := 'IC_PKG_Parametros.IC_PeriodNuevo_FN('||EN_num_mov||'); - ' || SQLERRM;
                        LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_PKG_Parametros.IC_PeriodNuevo_FN',sSql,SQLCODE,LV_des_error);
                        LV_salida := 'FALSE';
                        RETURN LV_salida;
        END;

        sSql := 'SELECT fin.cod_ciclo';
        sSql := sSql||' INTO LN_cod_ciclo_nue';
        sSql := sSql||' FROM ga_finciclo fin';
        sSql := sSql||' WHERE fin.cod_cliente = '||LN_cod_cliente;
        sSql := sSql||' AND fin.num_Abonado = '||LN_num_abonado;
        sSql := sSql||' AND fin.cod_ciclfact IS NOT NULL';
        sSql := sSql||' AND fin.cod_ciclo IS NOT NULL';

        SELECT
                fin.cod_ciclo
        INTO
                LN_cod_ciclo_nue
        FROM
                ga_finciclo fin
        WHERE
                fin.cod_cliente = LN_cod_cliente
                AND fin.num_Abonado = LN_num_abonado
                AND fin.cod_ciclfact IS NOT NULL
                AND fin.cod_ciclo IS NOT NULL;

        sSql := 'SELECT TO_CHAR((fac.fec_hastallam + 1),'''||'yyyymmdd'||''')' || '000000' ||'dia';
        sSql := sSql||' INTO LV_fecha_ejec';
        sSql := sSql||' FROM fa_ciclfact fac';
        sSql := sSql||' WHERE fac.cod_ciclo = '||LN_cod_ciclo_nue;
        sSql := sSql||' AND SYSDATE BETWEEN fac.fec_desdellam AND DECODE(fac.fec_hastallam, NULL, TO_DATE('''||CV_Fecha_Abierta||''','''||CV_Formato_Fecha||'''), fac.fec_hastallam)';

        SELECT
                TO_CHAR((fac.fec_hastallam + 1),'yyyymmdd')||'000000' dia
        INTO
                LV_fecha_ejec
        FROM
                fa_ciclfact fac
        WHERE
                fac.cod_ciclo = LN_cod_ciclo_nue
                AND SYSDATE BETWEEN fac.fec_desdellam AND DECODE(fac.fec_hastallam, NULL, TO_DATE(CV_Fecha_Abierta,CV_Formato_Fecha), fac.fec_hastallam);

        LV_nomciclo := 'PERCICLO_'||TO_CHAR(LN_cod_ciclo_nue);

        sSql := 'SELECT NVL(par.val_parametro,CHR(0))';
        sSql := sSql||' INTO LV_codpertot';
        sSql := sSql||' FROM ged_parametros par';
        sSql := sSql||' WHERE par.nom_parametro = '''||LV_nomciclo||'''';
        sSql := sSql||' AND par.cod_modulo = '''||CV_Modulo||'''';
        sSql := sSql||' AND par.cod_producto = '||CN_Producto;

        SELECT
                NVL(par.val_parametro,CHR(0))
        INTO
                LV_codpertot
        FROM
                ged_parametros par
        WHERE
                par.nom_parametro = LV_nomciclo
        AND
                par.cod_modulo = CV_Modulo
        AND
                par.cod_producto = CN_Producto;

        -- Proceso del valor rescatado.
        LV_Per := '';
        LN_PosIni := 1;
        LN_cont := 1;
        LN_PosLim := INSTR(LV_codpertot, ',',LN_PosIni,LN_cont);

        WHILE LN_PosIni <= LENGTH(LV_codpertot) LOOP
                IF LN_PosLim = 0 THEN
                        LN_PosLim := LENGTH(LV_codpertot) +1;
                END IF;
                LV_PerTmp := SUBSTR(LV_codpertot,LN_PosIni,LN_PosLim-LN_PosIni);
                LN_PosIni := LN_PosLim +1;
                LV_PerPaso := ',CodPer' || TO_CHAR(LN_cont) || '=' || LV_PerTmp;
                LV_Per := LV_Per || LV_PerPaso;
                LN_cont := LN_cont+1;
                LN_PosLim := INSTR(LV_codpertot, ',',1,LN_cont);
        END LOOP;

        IF LENGTH(LV_Per) = 0 THEN
                LV_Per := 'FALSE: NO HAY CODIGOS DE PERIODICIDAD PARA EL CICLO' || TO_CHAR(LN_cod_ciclo);
        ELSE
                LV_Per := LV_Per || ',fecEjec=' || LV_fecha_ejec;
        END IF;

        LV_salida := LV_Per;

        RETURN LV_Per;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
                LV_salida := 'FALSE';
                RETURN LV_salida;
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_PerCiclo;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_PKG_Parametros.IC_PeriodNuevo_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_PKG_Parametros.IC_PeriodNuevo_FN',sSql,SQLCODE,LV_des_error);
                LV_salida := 'FALSE';
                RETURN LV_salida;
END;

FUNCTION IC_CadSecuencia_FN(
        EN_Num_Mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING IS
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_CadSecuencia_FN"
                Lenguaje="PL/SQL"
                Fecha creación="05-12-2005"
                Creado por="Carlos Sellao H.."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>STRING</Retorno>
                <Descripción>Funcion para obtener el numero de secuencia o id de transaccion de alguna ejecucion de servicios registrada</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_Num_Mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>
                                <param nom="LV_salida"       Tipo="CARACTER">Valor a retornar</param>
                                <param nom="LN_cod_retorno"  Tipo="NUMERICO">Codigo de Retorno</param>
                                <param nom="LV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
                                <param nom="LN_num_evento"   Tipo="NUMERICO">Numero de Evento</param>
                        </Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
        LN_num_abonado ga_abocel.num_abonado%TYPE;
        LN_transaccion ic_interfazsersupl_to.num_trx%TYPE;
        LN_cod_servicios_tr ic_interfazsersupl_to.cod_servicios%TYPE;
        LN_cod_servicios_mv icc_movimiento.cod_servicios%TYPE;
        LV_cadena VARCHAR2(1024);
        LN_Transac ic_interfazsersupl_to.num_trx%TYPE;
        V_Transac  ic_interfazsersupl_to.num_trx%TYPE;
        LV_Serv ic_interfazsersupl_to.cod_periocidad%TYPE;
        LV_des_error VARCHAR2(512);
        sSql GE_Errores_PG.vQuery;
        TYPE CursorType IS REF CURSOR;

CURSOR secuencias IS
        SELECT num_trx, cod_periocidad, cod_servicios
          FROM ic_interfazsersupl_to
         WHERE num_abonado = LN_num_abonado;

        LV_salida VARCHAR2(512);
        LN_cod_retorno ge_errores_td.cod_msgerror%TYPE;
        LV_mens_retorno ge_errores_td.det_msgerror%TYPE;
        LN_num_evento GE_Errores_PG.evento;

BEGIN
        sSql := 'SELECT icc.num_abonado';
        sSql := sSql||' INTO LN_num_abonado';
        sSql := sSql||' FROM icc_movimiento icc';
        sSql := sSql||' WHERE icc.num_movimiento = '||EN_Num_Mov;

        SELECT icc.num_abonado, icc.cod_servicios
          INTO LN_num_abonado, LN_cod_servicios_mv
          FROM icc_movimiento icc
         WHERE icc.num_movimiento = EN_Num_Mov;

        sSql := 'CURSOR secuencias IS';
        sSql := sSql||' SELECT num_trx, cod_periocidad';
        sSql := sSql||' FROM ic_interfazsersupl_to';
        sSql := sSql||' WHERE num_abonado = '||LN_num_abonado;

        OPEN secuencias;

        LV_cadena:='0';
        V_Transac:='';
        FETCH secuencias INTO  LN_Transac, LV_Serv, LN_cod_servicios_tr;
        dbms_output.put_line('V_Transac SSK=['||V_Transac||']');
        IF (secuencias%FOUND) THEN
            LOOP
            IF (V_Transac is null) THEN
                dbms_output.put_line('V_Transac SS1='||V_Transac);
                V_Transac:= FN_RET_TRN(LN_Transac, LN_cod_servicios_tr, LN_cod_servicios_mv, EN_Num_Mov);
            ELSE
                LN_Transac:=V_Transac;
            END IF;
                    FETCH secuencias INTO  LN_Transac, LV_Serv, LN_cod_servicios_tr;
                    EXIT WHEN secuencias%NOTFOUND;
            END LOOP;

        IF (V_Transac is null) THEN
             LN_Transac:=0;
        END IF;
        LV_cadena := TO_CHAR(LN_Transac) || ':' || 'REC01' ||CHR(38)|| TO_CHAR(LN_Transac) || ':' ||'SMS01';

        ELSE
            LV_cadena := '0';
        CLOSE secuencias;
        LV_salida := LV_cadena;
        END IF;

        CLOSE secuencias;

        IF LENGTH(LV_cadena) = 0 THEN
                LV_cadena := 'FALSE: NO HAY SECUENCIAS DE TRANSACCION PARA EL ABONADO:' || TO_CHAR(LN_num_abonado);
        END IF;

        LV_salida := LV_cadena;

        RETURN LV_cadena;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
                LV_salida := 'FALSE';
                RETURN LV_salida;
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_Sec;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_PKG_Parametros.IC_CadSecuencia_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_PKG_Parametros.IC_CadSecuencia_FN',sSql,SQLCODE,LV_des_error);
                LV_salida := 'FALSE';
                RETURN LV_salida;
END;

FUNCTION IC_ImporteRec_FN(
        EN_Num_Mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING IS
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_ImporteRec_FN"
                Lenguaje="PL/SQL"
                Fecha creación="05-12-2005"
                Creado por="Carlos Sellao H.."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>STRING</Retorno>
                <Descripción>Funcion para obtener el valor del cargo básico para el servicio de recarga periodica</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_Num_Mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>
                                <param nom="LV_salida"       Tipo="CARACTER">Valor a retornar</param>
                                <param nom="LN_cod_retorno"  Tipo="NUMERICO">Codigo de Retorno</param>
                                <param nom="LV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
                                <param nom="LN_num_evento"   Tipo="NUMERICO">Numero de Evento</param>
                        </Salida>
                </Parámetros>
        </Elemento>
        <VERSIONMOD >  : 1.1 </VERSION >
        <FECHAMOD >    : 10/04/2008 </FECHAMOD >
        <DESCMOD >     : Se modifica la función IC_ImporteRec_FN Inc 64502
                         Funcion encargada de obtener el valor del cargo básico para el servicio de recarga periodica
                         La modificacion consiste en identificar el movimiento generado como recarga de Hibridos(por incidencia del Modulo de Post-Venta)
        </DESCMOD>
</Documentación>
*/
        LN_num_abonado ga_abocel.num_abonado%TYPE;
        LN_cod_plantarif ta_plantarif.cod_plantarif%TYPE;
        LN_cargobas ta_plantarif.cod_cargobasico%TYPE;
        LN_impcargobas ta_cargosbasico.imp_cargobasico%TYPE;
        LN_importe NUMBER;
        LV_des_error VARCHAR2(512);
        sSql GE_Errores_PG.vQuery;

        LV_salida VARCHAR2(512);
        LN_cod_retorno ge_errores_td.cod_msgerror%TYPE;
        LV_mens_retorno ge_errores_td.det_msgerror%TYPE;
        LN_num_evento GE_Errores_PG.evento;
        LN_fecdesde ta_plantarif.FEC_DESDE%type;  -- Inc 42590
        LV_plan icc_movimiento.PLAN%type;         -- Inc 64502
        LN_carga NUMBER;                          -- Inc 64502

BEGIN

    -- Inicio Inc 64502
        sSql := 'SELECT icc.num_abonado, icc.plan,nvl(icc.carga,-1)';
        sSql := sSql||' INTO   LN_num_abonado, LV_plan, LN_carga';
        sSql := sSql||' FROM   icc_movimiento icc';
        sSql := sSql||' WHERE  icc.num_movimiento = '|| EN_Num_Mov;

        SELECT icc.num_abonado, icc.plan, nvl(icc.carga,-1)
        INTO   LN_num_abonado, LV_plan, LN_carga
        FROM   icc_movimiento icc
        WHERE  icc.num_movimiento = EN_Num_Mov;

        IF LN_carga = -1 or LN_carga = 0 THEN

        -- Fin Inc 64502

           BEGIN
               sSql := 'SELECT abo.cod_plantarif';
               sSql := sSql||' INTO LN_cod_plantarif';
               sSql := sSql||' FROM ga_abocel abo';
               sSql := sSql||' WHERE abo.num_abonado = '||LN_num_abonado;

               SELECT abo.cod_plantarif
               INTO   LN_cod_plantarif
               FROM   ga_abocel abo
               WHERE  abo.num_abonado = LN_num_abonado;

       EXCEPTION
       WHEN NO_DATA_FOUND THEN
           BEGIN
              sSql := 'SELECT abo.cod_plantarif';
              sSql := sSql||' INTO LN_cod_plantarif';
              sSql := sSql||' FROM ga_aboamist abo';
              sSql := sSql||' WHERE abo.num_abonado = '||LN_num_abonado;

              SELECT abo.cod_plantarif
              INTO   LN_cod_plantarif
              FROM   ga_aboamist abo
              WHERE  abo.num_abonado = LN_num_abonado;

              EXCEPTION
              WHEN NO_DATA_FOUND THEN
                 LV_salida := 'FALSE';
                 RETURN LV_salida;
              WHEN OTHERS THEN
                 LN_cod_retorno := CN_Err_ImpBas;
                 IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                    LV_mens_retorno := CV_Err_NoClasif;
                 END IF;
                 LV_des_error := 'IC_PKG_Parametros.IC_ImporteRec_FN('||EN_num_mov||'); - ' || SQLERRM;
                 LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_PKG_Parametros.IC_ImporteRec_FN',sSql,SQLCODE,LV_des_error);
                 LV_salida := 'FALSE';
                 RETURN LV_salida;
              END;

       WHEN OTHERS THEN
          LN_cod_retorno := CN_Err_ImpBas;
          IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
             LV_mens_retorno := CV_Err_NoClasif;
          END IF;
          LV_des_error := 'IC_PKG_Parametros.IC_ImporteRec_FN('||EN_num_mov||'); - ' || SQLERRM;
          LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_PKG_Parametros.IC_ImporteRec_FN',sSql,SQLCODE,LV_des_error);
          LV_salida := 'FALSE';
          RETURN LV_salida;
       END;



           -- Inicio 42590
           -- Esta consulta trae el ultimo registro de ta_cargosbasico sin importar si el plan está abierto o cerrado
           sSql := 'SELECT plant.cod_cargobasico,MAX(d.fec_desde)';
           sSql := sSql||' INTO LN_cargobas, LN_fecdesde';
           sSql := sSql||' FROM ta_plantarif plant, ta_cargosbasico d';
           sSql := sSql||' WHERE plant.cod_cargobasico=d.cod_cargobasico';
       sSql := sSql||' AND   d.cod_producto = ' || CN_Producto;
       sSql := sSql||' AND plant.cod_plantarif = ' || LN_cod_plantarif;
           sSql := sSql||' GROUP BY plant.cod_cargobasico';

           SELECT plant.cod_cargobasico,MAX(d.fec_desde)
             INTO LN_cargobas, LN_fecdesde
             FROM ta_plantarif plant, ta_cargosbasico d
            WHERE plant.cod_cargobasico=d.cod_cargobasico
          AND d.cod_producto = CN_Producto
          AND plant.cod_plantarif = LN_cod_plantarif
            GROUP BY plant.cod_cargobasico;

           -- Aqui averiguamos el importe del ultimo registro de ta_cargosbasico

           sSql := 'SELECT  car.imp_cargobasico';
           sSql := sSql||' INTO  LN_impcargobas';
           sSql := sSql||' FROM  ta_cargosbasico car';
           sSql := sSql||' WHERE car.cod_producto = ' || CN_Producto;
           sSql := sSql||' AND car.cod_cargobasico = ' || LN_cargobas;
           sSql := sSql||' AND car.fec_desde=LN_fecdesde';

           SELECT car.imp_cargobasico
             INTO LN_impcargobas
             FROM  ta_cargosbasico car
            WHERE car.cod_producto = CN_Producto
              AND car.cod_cargobasico = LN_cargobas
              AND car.fec_desde=LN_fecdesde;

           -- Fin 42590

        ELSE     -- Inc 64502
           LN_impcargobas:=LN_carga;
        END IF;  -- Fin 64502

        LV_salida := TO_CHAR(LN_impcargobas);


        -- aplica impuesto.-
        LN_importe := IC_PKG_PARAMETROS.IC_AplicaImpuesto_FN(LN_impcargobas);

        IF LN_importe < 0 THEN
           LV_salida := 'FALSE';
           RETURN LV_salida;
        END IF;

    LV_salida := TO_CHAR(LN_importe);

    RETURN LV_salida;

EXCEPTION
   WHEN NO_DATA_FOUND THEN
      LV_salida := 'FALSE';
      RETURN LV_salida;
   WHEN OTHERS THEN
      LN_cod_retorno := CN_Err_ImpBas;
      IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
         LV_mens_retorno := CV_Err_NoClasif;
      END IF;
      LV_des_error := 'IC_PKG_Parametros.IC_ImporteRec_FN('||EN_num_mov||'); - ' || SQLERRM;
      LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_PKG_Parametros.IC_ImporteRec_FN',sSql,SQLCODE,LV_des_error);
      LV_salida := 'FALSE';
      RETURN LV_salida;
END;

FUNCTION IC_ImporteRec_Basic_FN(
        EN_Num_Mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING IS
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_ImporteRec_Basic_FN"
                Lenguaje="PL/SQL"
                Fecha creación="05-06-2008"
                Creado por="Hector Leiav R."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>STRING</Retorno>
                <Descripción>Funcion para obtener el valor del cargo básico para el servicio de recarga periodica</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_Num_Mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>
                                <param nom="LV_salida"       Tipo="CARACTER">Valor a retornar</param>
                                <param nom="LN_cod_retorno"  Tipo="NUMERICO">Codigo de Retorno</param>
                                <param nom="LV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
                                <param nom="LN_num_evento"   Tipo="NUMERICO">Numero de Evento</param>
                        </Salida>
                </Parámetros>
        </Elemento>
        <VERSIONMOD >  : 1.1 </VERSION >
</Documentación>
*/
        LN_num_abonado ga_abocel.num_abonado%TYPE;
        LN_cod_plantarif ta_plantarif.cod_plantarif%TYPE;
        LN_cargobas ta_plantarif.cod_cargobasico%TYPE;
        LN_impcargobas ta_cargosbasico.imp_cargobasico%TYPE;
    LN_importe NUMBER;
        LV_des_error VARCHAR2(512);
        sSql GE_Errores_PG.vQuery;

        LV_salida VARCHAR2(512);
        LN_cod_retorno ge_errores_td.cod_msgerror%TYPE;
        LV_mens_retorno ge_errores_td.det_msgerror%TYPE;
        LN_num_evento GE_Errores_PG.evento;
    LN_fecdesde ta_plantarif.FEC_DESDE%type;  -- Inc 42590
    LV_plan icc_movimiento.PLAN%type;         -- Inc 64502
    LN_carga NUMBER;                          -- Inc 64502

BEGIN

    sSql := 'SELECT icc.num_abonado, icc.plan,nvl(icc.carga,-1)';
        sSql := sSql||' INTO   LN_num_abonado, LV_plan, LN_carga';
        sSql := sSql||' FROM   icc_movimiento icc';
        sSql := sSql||' WHERE  icc.num_movimiento = '|| EN_Num_Mov;

        SELECT icc.num_abonado, icc.plan, nvl(icc.carga,-1)
        INTO   LN_num_abonado, LN_cod_plantarif, LN_carga
        FROM   icc_movimiento icc
        WHERE  icc.num_movimiento = EN_Num_Mov;

           -- Esta consulta trae el ultimo registro de ta_cargosbasico sin importar si el plan está abierto o cerrado
           sSql := 'SELECT plant.cod_cargobasico,MAX(d.fec_desde)';
           sSql := sSql||' INTO LN_cargobas, LN_fecdesde';
           sSql := sSql||' FROM ta_plantarif plant, ta_cargosbasico d';
           sSql := sSql||' WHERE plant.cod_cargobasico=d.cod_cargobasico';
              sSql := sSql||' AND   d.cod_producto = ' || CN_Producto;
           sSql := sSql||' AND plant.cod_plantarif = ' || LN_cod_plantarif;
           sSql := sSql||' GROUP BY plant.cod_cargobasico';

           SELECT plant.cod_cargobasico,MAX(d.fec_desde)
             INTO LN_cargobas, LN_fecdesde
             FROM ta_plantarif plant, ta_cargosbasico d
            WHERE plant.cod_cargobasico=d.cod_cargobasico
          AND d.cod_producto = CN_Producto
          AND plant.cod_plantarif = LN_cod_plantarif
            GROUP BY plant.cod_cargobasico;

           -- Aqui averiguamos el importe del ultimo registro de ta_cargosbasico

           sSql := 'SELECT  car.imp_cargobasico';
           sSql := sSql||' INTO  LN_impcargobas';
           sSql := sSql||' FROM  ta_cargosbasico car';
           sSql := sSql||' WHERE car.cod_producto = ' || CN_Producto;
           sSql := sSql||' AND car.cod_cargobasico = ' || LN_cargobas;
           sSql := sSql||' AND car.fec_desde=LN_fecdesde';

           SELECT car.imp_cargobasico
             INTO LN_impcargobas
             FROM ta_cargosbasico car
            WHERE car.cod_producto = CN_Producto
              AND car.cod_cargobasico = LN_cargobas
              AND car.fec_desde=LN_fecdesde;

        LV_salida := TO_CHAR(LN_impcargobas);

        -- aplica impuesto.-
        LN_importe := IC_PKG_PARAMETROS.IC_AplicaImpuesto_FN(LN_impcargobas);

        IF LN_importe < 0 THEN
           LV_salida := 'FALSE';
           RETURN LV_salida;
        END IF;

    LV_salida := TO_CHAR(LN_importe);

    RETURN LV_salida;

EXCEPTION
   WHEN NO_DATA_FOUND THEN
      LV_salida := 'FALSE';
      RETURN LV_salida;
   WHEN OTHERS THEN
      LN_cod_retorno := CN_Err_ImpBas;
      IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
         LV_mens_retorno := CV_Err_NoClasif;
      END IF;
      LV_des_error := 'IC_PKG_Parametros.IC_ImporteRec_Basic_FN('||EN_num_mov||'); - ' || SQLERRM;
      LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_PKG_Parametros.IC_ImporteRec_Basic_FN',sSql,SQLCODE,LV_des_error);
      LV_salida := 'FALSE';
      RETURN LV_salida;
END;


FUNCTION IC_ImpRecNuevo_FN(
        EN_Num_Mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING IS
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_ImpRecNuevo_FN"
                Lenguaje="PL/SQL"
                Fecha creación="05-12-2005"
                Creado por="Carlos Sellao H.."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>STRING</Retorno>
                <Descripción>Funcion para obtener el valor del cargo básico para el servicio de recarga periodica</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_Num_Mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>
                                <param nom="LV_salida"       Tipo="CARACTER">Valor a retornar</param>
                                <param nom="LN_cod_retorno"  Tipo="NUMERICO">Codigo de Retorno</param>
                                <param nom="LV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
                                <param nom="LN_num_evento"   Tipo="NUMERICO">Numero de Evento</param>
                        </Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
        LN_num_abonado ga_abocel.num_abonado%TYPE;
        LN_cod_plantarif ta_plantarif.cod_plantarif%TYPE;
        LN_cargobas ta_plantarif.cod_cargobasico%TYPE;
        LN_impcargobas ta_cargosbasico.imp_cargobasico%TYPE;
        LN_importe NUMBER;
        LV_des_error VARCHAR2(512);
        sSql GE_Errores_PG.vQuery;

        LV_salida VARCHAR2(512);
        LN_cod_retorno ge_errores_td.cod_msgerror%TYPE;
        LV_mens_retorno ge_errores_td.det_msgerror%TYPE;
        LN_num_evento GE_Errores_PG.evento;

BEGIN
        sSql := 'SELECT icc.num_abonado, icc.plan';
        sSql := sSql||' INTO LN_num_abonado, LN_cod_plantarif';
        sSql := sSql||' FROM icc_movimiento icc';
        sSql := sSql||' WHERE icc.num_movimiento = '||EN_Num_Mov;

        SELECT icc.num_abonado, icc.plan
          INTO LN_num_abonado, LN_cod_plantarif
          FROM icc_movimiento icc
        WHERE  icc.num_movimiento = EN_Num_Mov;

        sSql := 'SELECT plant.cod_cargobasico';
        sSql := sSql||' INTO LN_cargobas';
        sSql := sSql||' FROM ta_plantarif plant';
        sSql := sSql||' WHERE plant.cod_producto = '||CN_Producto;
        sSql := sSql||' AND plant.cod_plantarif = '||LN_cod_plantarif;
        sSql := sSql||' AND SYSDATE BETWEEN plant.fec_desde AND DECODE(plant.fec_hasta, NULL, TO_DATE('''||CV_Fecha_Abierta||''','''||CV_Formato_Fecha||'''), plant.fec_hasta)';

        SELECT plant.cod_cargobasico
          INTO LN_cargobas
          FROM ta_plantarif plant
         WHERE plant.cod_producto = CN_Producto
           AND plant.cod_plantarif = LN_cod_plantarif
           AND SYSDATE BETWEEN plant.fec_desde AND DECODE(plant.fec_hasta, NULL, TO_DATE(CV_Fecha_Abierta,CV_Formato_Fecha), plant.fec_hasta);

        sSql := 'SELECT car.imp_cargobasico';
        sSql := sSql||' INTO LN_impcargobas';
        sSql := sSql||' FROM ta_cargosbasico car';
        sSql := sSql||' WHERE car.cod_producto = '||CN_Producto;
        sSql := sSql||' AND car.cod_cargobasico = '||LN_cargobas;
        sSql := sSql||' AND SYSDATE BETWEEN car.fec_desde AND DECODE(car.fec_hasta, NULL, TO_DATE('''||CV_Fecha_Abierta||''','''||CV_Formato_Fecha||'''), car.fec_hasta)';

        SELECT car.imp_cargobasico
          INTO LN_impcargobas
          FROM ta_cargosbasico car
         WHERE car.cod_producto = CN_Producto
           AND car.cod_cargobasico = LN_cargobas
           AND SYSDATE BETWEEN car.fec_desde AND DECODE(car.fec_hasta, NULL, TO_DATE(CV_Fecha_Abierta,CV_Formato_Fecha), car.fec_hasta);

        LV_salida := TO_CHAR(LN_impcargobas);

        -- aplica impuesto.-
        LN_importe := IC_PKG_PARAMETROS.IC_AplicaImpuesto_FN(LN_impcargobas);

        IF LN_importe < 0 THEN
            LV_salida := 'FALSE';
            RETURN LV_salida;
        END IF;

        LV_salida := TO_CHAR(LN_importe);

        RETURN LV_salida;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
                LV_salida := 'FALSE';
                RETURN LV_salida;
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_ImpBas;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_PKG_Parametros.IC_ImpRecNuevo_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_PKG_Parametros.IC_ImpRecNuevo_FN',sSql,SQLCODE,LV_des_error);
                LV_salida := 'FALSE';
                RETURN LV_salida;
END;

FUNCTION IC_ValHibrido_FN(
        EN_Num_Mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING IS
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_ValHibrido_FN"
                Lenguaje="PL/SQL"
                Fecha creación="05-12-2005"
                Creado por="Carlos Sellao H.."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>STRING</Retorno>
                <Descripción>Funcion para validar el tipo Hibrido del abonado</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_Num_Mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>
                                <param nom="LV_salida"       Tipo="CARACTER">Valor a retornar</param>
                                <param nom="LN_cod_retorno"  Tipo="NUMERICO">Codigo de Retorno</param>
                                <param nom="LV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
                                <param nom="LN_num_evento"   Tipo="NUMERICO">Numero de Evento</param>
                        </Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
        LN_num_abonado ga_abocel.num_abonado%TYPE;
        LN_cod_plantarif ta_plantarif.cod_plantarif%TYPE;
        LN_cod_tiplan ta_plantarif.cod_tiplan%TYPE;
        LV_hibrido VARCHAR2(60);
        LV_des_error VARCHAR2(512);
        sSql GE_Errores_PG.vQuery;

        LV_salida VARCHAR2(512);
        LN_cod_retorno ge_errores_td.cod_msgerror%TYPE;
        LV_mens_retorno ge_errores_td.det_msgerror%TYPE;
        LN_num_evento GE_Errores_PG.evento;

BEGIN
        sSql := 'SELECT icc.num_abonado';
        sSql := sSql||' INTO LN_num_abonado';
        sSql := sSql||' FROM icc_movimiento icc';
        sSql := sSql||' WHERE icc.num_movimiento = '||EN_Num_Mov;

        SELECT
                icc.num_abonado
        INTO
                LN_num_abonado
        FROM
                icc_movimiento icc
        WHERE
                icc.num_movimiento = EN_Num_Mov;

        BEGIN
                sSql := 'SELECT abo.cod_plantarif';
                sSql := sSql||' INTO LN_cod_plantarif';
                sSql := sSql||' FROM ga_abocel abo';
                sSql := sSql||' WHERE abo.num_abonado = '||LN_num_abonado;

                SELECT
                        abo.cod_plantarif
                INTO
                        LN_cod_plantarif
                FROM
                        ga_abocel abo
                WHERE
                        abo.num_abonado = LN_num_abonado;

        EXCEPTION
                WHEN NO_DATA_FOUND THEN
                        BEGIN
                                sSql := 'SELECT abo.cod_plantarif';
                                sSql := sSql||' INTO LN_cod_plantarif';
                                sSql := sSql||' FROM ga_aboamist abo';
                                sSql := sSql||' WHERE abo.num_abonado = '||LN_num_abonado;

                                SELECT
                                        abo.cod_plantarif
                                INTO
                                        LN_cod_plantarif
                                FROM
                                        ga_aboamist abo
                                WHERE
                                        abo.num_abonado = LN_num_abonado;
                        EXCEPTION
                                WHEN NO_DATA_FOUND THEN
                                        LV_salida := 'FALSE';
                                        RETURN LV_salida;
                                WHEN OTHERS THEN
                                        LN_cod_retorno := CN_Err_Abonado;
                                        IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                                                LV_mens_retorno := CV_Err_NoClasif;
                                        END IF;
                                        LV_des_error := 'IC_PKG_Parametros.IC_ValHibrido_FN('||EN_num_mov||'); - ' || SQLERRM;
                                        LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_PKG_Parametros.IC_ValHibrido_FN',sSql,SQLCODE,LV_des_error);
                                        LV_salida := 'FALSE';
                                        RETURN LV_salida;
                        END;

                WHEN OTHERS THEN
                        LN_cod_retorno := CN_Err_Abonado;
                        IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                                LV_mens_retorno := CV_Err_NoClasif;
                        END IF;
                        LV_des_error := 'IC_PKG_Parametros.IC_ValHibrido_FN('||EN_num_mov||'); - ' || SQLERRM;
                        LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_PKG_Parametros.IC_ValHibrido_FN',sSql,SQLCODE,LV_des_error);
                        LV_salida := 'FALSE';
                        RETURN LV_salida;
        END;

        sSql := 'SELECT plant.cod_tiplan';
        sSql := sSql||' INTO LN_cod_tiplan';
        sSql := sSql||' FROM ta_plantarif plant';
        sSql := sSql||' WHERE plant.cod_producto = '||CN_Producto;
        sSql := sSql||' AND plant.cod_plantarif = '||LN_cod_plantarif;
        sSql := sSql||' AND SYSDATE BETWEEN plant.fec_desde AND DECODE(plant.fec_hasta, NULL, TO_DATE('''||CV_Fecha_Abierta||''','''||CV_Formato_Fecha||'''), plant.fec_hasta)';

        SELECT
                plant.cod_tiplan
        INTO
                LN_cod_tiplan
        FROM
                ta_plantarif plant
        WHERE
                plant.cod_producto = CN_Producto
                AND plant.cod_plantarif = LN_cod_plantarif
                AND SYSDATE BETWEEN plant.fec_desde AND DECODE(plant.fec_hasta, NULL, TO_DATE(CV_Fecha_Abierta,CV_Formato_Fecha), plant.fec_hasta);

        IF LN_cod_tiplan = 3 THEN
                LV_hibrido := 'HIBRIDO';
        ELSE
                LV_hibrido := 'FALSE: EL ABONADO:'|| TO_CHAR(LN_num_abonado) ||' NO ES HIBRIDO';
        END IF;

        LV_salida := LV_hibrido;

        RETURN LV_hibrido;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
                LV_salida := 'FALSE';
                RETURN LV_salida;
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_Abonado;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_PKG_Parametros.IC_ValHibrido_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_PKG_Parametros.IC_ValHibrido_FN',sSql,SQLCODE,LV_des_error);
                LV_salida := 'FALSE';
                RETURN LV_salida;
END;


FUNCTION IC_ImporteBono_FN(
        EN_Num_Mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING IS
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_ImporteBono_FN"
                Lenguaje="PL/SQL"
                Fecha creación="21-02-2006"
                Creado por="Carlos Sellao H.."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>STRING</Retorno>
                <Descripción>Funcion para obtener una cadena con importes correspondientes a los servicios</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_Num_Mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>
                                <param nom="LV_salida"       Tipo="CARACTER">Valor a retornar</param>
                                <param nom="LN_cod_retorno"  Tipo="NUMERICO">Codigo de Retorno</param>
                                <param nom="LV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
                                <param nom="LN_num_evento"   Tipo="NUMERICO">Numero de Evento</param>
                        </Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/

        LN_num_abonado ga_abocel.num_abonado%TYPE;
        LV_cod_servicios icc_movimiento.cod_servicios%TYPE;
        LV_cod_actabo    icc_movimiento.cod_actabo%TYPE;
        LV_serv_tmp      icc_movimiento.cod_servicios%TYPE;
        LV_serv          icc_movimiento.cod_servicios%TYPE;
        LV_nivel         icc_movimiento.cod_servicios%TYPE;
        LV_servicios     icc_movimiento.cod_servicios%TYPE;
        LV_cod_planserv  ga_tarifas.cod_planserv%TYPE;
        LN_imp_tarifa    ga_tarifas.imp_tarifa%TYPE;
        LN_importe       ga_tarifas.imp_tarifa%TYPE;
        LV_cod_servicio  ga_servsupl.cod_servicio%TYPE;
        LV_cadena VARCHAR2(1024);
        LN_cont NUMBER := 1;
        LV_len_serv NUMBER := 0;
        LV_des_error VARCHAR2(512);
        sSql GE_Errores_PG.vQuery;

        LV_salida VARCHAR2(512);
        LN_cod_retorno ge_errores_td.cod_msgerror%TYPE;
        LV_mens_retorno ge_errores_td.det_msgerror%TYPE;
        LN_num_evento GE_Errores_PG.evento;

BEGIN
        sSql := 'SELECT icc.num_abonado';
        sSql := sSql||' INTO LN_num_abonado';
        sSql := sSql||' FROM icc_movimiento icc';
        sSql := sSql||' WHERE icc.num_movimiento = '||EN_Num_Mov;

        SELECT
                icc.num_abonado, icc.cod_servicios, icc.cod_actabo
        INTO
                LN_num_abonado, LV_cod_servicios, LV_cod_actabo
        FROM
                icc_movimiento icc
        WHERE
                icc.num_movimiento = EN_Num_Mov;

        BEGIN
                sSql := 'SELECT abo.cod_planserv';
                sSql := sSql||' INTO LN_cod_planserv';
                sSql := sSql||' FROM ga_abocel abo';
                sSql := sSql||' WHERE abo.num_abonado = '||LN_num_abonado;

                SELECT
                        abo.cod_planserv
                INTO
                        LV_cod_planserv
                FROM
                        ga_abocel abo
                WHERE
                        abo.num_abonado = LN_num_abonado;

        EXCEPTION
                WHEN NO_DATA_FOUND THEN
                        BEGIN
                                sSql := 'SELECT abo.cod_planserv';
                                sSql := sSql||' INTO LN_cod_planserv';
                                sSql := sSql||' FROM ga_aboamist abo';
                                sSql := sSql||' WHERE abo.num_abonado = '||LN_num_abonado;

                                SELECT
                                        abo.cod_planserv
                                INTO
                                        LV_cod_planserv
                                FROM
                                        ga_aboamist abo
                                WHERE
                                        abo.num_abonado = LN_num_abonado;

                        EXCEPTION
                                WHEN NO_DATA_FOUND THEN
                                        LV_salida := 'FALSE';
                                        RETURN LV_salida;
                                WHEN OTHERS THEN
                                        LN_cod_retorno := CN_Err_ImpBas;
                                        IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                                                LV_mens_retorno := CV_Err_NoClasif;
                                        END IF;
                                        LV_des_error := 'IC_PKG_Parametros.IC_ImporteBono_FN('||EN_num_mov||'); - ' || SQLERRM;
                                        LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_PKG_Parametros.IC_PeriodNuevo_FN',sSql,SQLCODE,LV_des_error);
                                        LV_salida := 'FALSE';
                                        RETURN LV_salida;
                        END;

                WHEN OTHERS THEN
                        LN_cod_retorno := CN_Err_ImpBas;
                        IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                                LV_mens_retorno := CV_Err_NoClasif;
                        END IF;
                        LV_des_error := 'IC_PKG_Parametros.IC_ImporteBono_FN('||EN_num_mov||'); - ' || SQLERRM;
                        LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_PKG_Parametros.IC_PeriodNuevo_FN',sSql,SQLCODE,LV_des_error);
                        LV_salida := 'FALSE';
                        RETURN LV_salida;
        END;

       LV_servicios := LTRIM(RTRIM(LV_cod_servicios));
       LV_len_serv := LENGTH(LV_servicios);
       LN_cont := 1;
       LV_cadena:='0';

       WHILE LN_cont < LV_len_serv LOOP
           LV_serv_tmp := SUBSTR(LV_servicios,LN_cont,6);
           LV_serv := SUBSTR(LV_serv_tmp,1,2);
           LV_nivel := SUBSTR(LV_serv_tmp,3,4);
           LN_cont := LN_cont+6;

           BEGIN

              sSql := 'SELECT NVL(imp.imp_tarifa,0)';
              sSql := sSql||'INTO LN_imp_tarifa';
              sSql := sSql||'FROM ga_servsupl ser, ga_tarifas imp';
              sSql := sSql||'WHERE ser.cod_producto = c.cod_producto';
              sSql := sSql||'AND ser.cod_servicio = c.cod_servicio';
              sSql := sSql||'AND imp.cod_producto = '|| TO_CHAR(CN_Producto);
              sSql := sSql||'AND imp.cod_actabo = '||LV_cod_actabo;
              sSql := sSql||'AND imp.cod_tipserv = ' || TO_CHAR(CN_CodTipServ);
              sSql := sSql||'AND imp.cod_servicio IS NOT NULL';
              sSql := sSql||'AND imp.cod_planserv = '||LV_cod_planserv;
              sSql := sSql||'AND imp.fec_desde IS NOT NULL';
              sSql := sSql||'AND SYSDATE BETWEEN imp.fec_desde AND DECODE(imp.fec_hasta, NULL, sysdate, imp.fec_hasta)';
              sSql := sSql||'AND ser.cod_producto = '|| TO_CHAR(CN_Producto);
              sSql := sSql||'AND ser.cod_servicio IS NOT NULL ';
              sSql := sSql||'AND tip_servicio = '|| TO_CHAR(CN_TipServ);
              sSql := sSql||'AND ser.cod_servsupl = TO_NUMBER('||LV_serv||')';
              sSql := sSql||'AND ser.cod_nivel = TO_NUMBER('||LV_nivel||')';

              SELECT
                     NVL(imp.imp_tarifa,0)
              INTO
                     LN_imp_tarifa
              FROM
                     ga_servsupl ser, ga_tarifas imp
              WHERE
                     ser.cod_producto = imp.cod_producto
              AND
                     ser.cod_servicio = imp.cod_servicio
              AND
                     imp.cod_producto = CN_Producto
              AND
                     imp.cod_actabo = LV_cod_actabo -- del movimiento.-
              AND
                     imp.cod_tipserv = CN_CodTipServ
              AND
                     imp.cod_servicio IS NOT NULL
              AND
                     imp.cod_planserv = LV_cod_planserv -- del abonado.-
              AND
                     imp.fec_desde IS NOT NULL
              AND
                     SYSDATE BETWEEN imp.fec_desde AND DECODE(imp.fec_hasta, NULL, sysdate, imp.fec_hasta)
              AND
                     ser.cod_producto = CN_Producto
              AND
                     ser.cod_servicio IS NOT NULL
              AND
                     ser.tip_servicio = CN_TipServ
              AND
                     ser.cod_servsupl = TO_NUMBER(LV_serv)
              AND
                     ser.cod_nivel = TO_NUMBER(LV_nivel);
             EXCEPTION
                WHEN NO_DATA_FOUND THEN
                     LN_imp_tarifa := 0;
              WHEN OTHERS THEN
                  LN_cod_retorno := CN_Err_ImpBas;
                  IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                      LV_mens_retorno := CV_Err_NoClasif;
                  END IF;
                  LV_des_error := 'IC_PKG_Parametros.IC_ImporteBono_FN('||EN_num_mov||'); - ' || SQLERRM;
                  LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_PKG_Parametros.IC_ImporteBono_FN',sSql,SQLCODE,LV_des_error);
                  LV_salida := 'FALSE';
                  RETURN LV_salida;
           END;

           -- aplica impuesto.-
           LN_importe := IC_PKG_PARAMETROS.IC_AplicaImpuesto_FN(LN_imp_tarifa);

           IF LN_importe < 0 THEN
               LV_salida := 'FALSE';
               RETURN LV_salida;
           END IF;

           IF LV_cadena = '0' THEN
               LV_cadena := LV_serv || ':' || LV_nivel || ':' || TO_CHAR(LN_importe);
           ELSE
               LV_cadena := LV_cadena||CHR(38)|| LV_serv || ':' ||LV_nivel || ':' || TO_CHAR(LN_importe);
           END IF;

           -- debe arrojar una cadena del tipo: 56:0000:500"y"56:0001:350"y"40:0001:300

       END LOOP;

       LV_salida := LV_cadena;

       RETURN LV_cadena;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
                LV_salida := 'FALSE';
                RETURN LV_salida;
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_ImpBas;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_PKG_Parametros.IC_ImporteBono_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_PKG_Parametros.IC_PeriodNuevo_FN',sSql,SQLCODE,LV_des_error);
                LV_salida := 'FALSE';
                RETURN LV_salida;
END;

FUNCTION IC_AplicaImpuesto_FN(
        EN_Importe IN number) RETURN NUMBER IS
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_AplicaImpuesto_FN"
                Lenguaje="PL/SQL"
                Fecha creación="22-02-2006"
                Creado por="Carlos Sellao H.."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>STRING</Retorno>
                <Descripción>Funcion para aplicar impuesto a valores de importe</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_Importe" Tipo="NUMERICO">Valor del importe a aplicarle impuesto</param>
                        </Entrada>
                        <Salida>
                                <param nom="LV_out"       Tipo="NUMERICO">Valor a retornar</param>
                        </Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
        LN_importe       NUMBER;
        LV_aux_ice VARCHAR(5);
        LN_n_ice NUMBER(6,3);
        LV_aux_iva VARCHAR(5);
        LN_n_iva NUMBER(6,3);
        LN_flag_impuesto NUMBER(1);
        LV_flag_impuesto VARCHAR(1);

        LV_des_error VARCHAR2(512);
        sSql GE_Errores_PG.vQuery;

        LV_salida VARCHAR2(512);
        LN_cod_retorno ge_errores_td.cod_msgerror%TYPE;
        LV_mens_retorno ge_errores_td.det_msgerror%TYPE;
        LN_num_evento GE_Errores_PG.evento;

BEGIN
           LN_n_ice := 0;
           LN_n_iva := 0;

           SELECT TRIM(VAL_PARAMETRO)
           INTO LV_flag_impuesto
           FROM ged_parametros
           WHERE NOM_PARAMETRO = 'FLAG_IMPUESTO';

           IF(LV_flag_impuesto IS NULL ) THEN
               LV_flag_impuesto := '0';
           END IF;

           LN_flag_impuesto := TO_NUMBER(LV_flag_impuesto);

           IF(LN_flag_impuesto=1) THEN
               SELECT TRIM(VAL_PARAMETRO)
               INTO LV_aux_ice
               FROM ged_parametros
               WHERE NOM_PARAMETRO='IMPUESTO_ICE';

               IF (LV_aux_ice IS NULL) THEN
                  LV_aux_ice := '0';
               END IF;

               LN_n_ice := TO_NUMBER(LV_aux_ice);


               SELECT TRIM(VAL_PARAMETRO)
               INTO LV_aux_iva
               FROM ged_parametros
               WHERE NOM_PARAMETRO='IMPUESTO_IVA';

               IF(LV_aux_iva IS NULL) THEN
                  LV_aux_iva := '0';
               END IF;

               LN_n_iva := TO_NUMBER(LV_aux_iva);

               LN_importe := TO_CHAR(EN_Importe + ((EN_Importe*LN_n_ice)/100) + ((EN_Importe*LN_n_iva)/100));
           ELSE
               LN_importe := EN_Importe;
           END IF;

           -- aplica redondeo  a 2 decimales.
           LN_importe := ROUND(LN_importe,2);

           RETURN LN_importe;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
                LV_salida := 'FALSE';
                RETURN -1;
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_FecEjec;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_PKG_Parametros.IC_AplicaImpuesto_FN('||EN_Importe||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_PKG_Parametros.IC_AplicaImpuesto_FN',sSql,SQLCODE,LV_des_error);
                LV_salida := 'FALSE';
                RETURN -1;
END;

FUNCTION FN_COD_SUBALM RETURN VARCHAR2
IS
        LV_COD_SUBALM          GA_CELNUM_SUBALM.COD_SUBALM%TYPE;
BEGIN

        BEGIN
                SELECT val_parametro
                INTO LV_COD_SUBALM
                FROM GED_PARAMETROS
                WHERE NOM_PARAMETRO='COD_SUBALM' AND COD_MODULO='IC' AND
                COD_PRODUCTO=1;

                RETURN LV_COD_SUBALM;
        EXCEPTION WHEN NO_DATA_FOUND THEN
                RETURN '0203';
        END;

EXCEPTION
  WHEN OTHERS THEN
       RETURN 'ERROR|'||SQLERRM;
END ;


FUNCTION IC_ValidaServicio_FN(
        EN_Num_Mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING IS
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_ValidaServicio_FN"
                Lenguaje="PL/SQL"
                Fecha creación="20-02-2007"
                Creado por="Lorena Rojo L."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>STRING</Retorno>
                <Descripción>Funcion para validar si un abonado tiene contratado un servicio</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_Num_Mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>
                                <param nom="LV_salida"       Tipo="CARACTER">Valor a retornar</param>
                        </Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/


        LV_des_error VARCHAR2(512);
        sSql GE_Errores_PG.vQuery;

        LV_salida VARCHAR2(512);
        LN_cod_retorno ge_errores_td.cod_msgerror%TYPE;
        LV_mens_retorno ge_errores_td.det_msgerror%TYPE;
        LN_num_evento GE_Errores_PG.evento;
        LV_num_abonado ga_abocel.num_abonado%TYPE;
        LN_cod_nivel ga_servsuplabo.cod_nivel%TYPE;
        LN_cod_servsupl ga_servsuplabo.cod_servsupl%TYPE;

BEGIN

-- Inicio 36689 Maria Lorena Rojo L. 20/02/2007

            LN_cod_servsupl := 7;

            SELECT NUM_ABONADO
            INTO LV_num_abonado
            FROM ICC_MOVIMIENTO
            WHERE NUM_MOVIMIENTO = EN_Num_Mov;

            BEGIN
                SELECT COD_NIVEL
                INTO LN_cod_nivel
                FROM GA_SERVSUPLABO
                WHERE NUM_ABONADO = LV_num_abonado
                AND IND_ESTADO < 3
                AND FEC_BAJABD IS  NULL
                AND FEC_BAJACEN IS NULL
                AND COD_SERVSUPL = LN_cod_servsupl;

                LV_salida := '1';
            EXCEPTION
            WHEN NO_DATA_FOUND THEN
               LV_salida := '0';
                WHEN TOO_MANY_ROWS THEN
                   LV_salida := '1';
                WHEN OTHERS THEN
                   LV_salida := '0';
            END;


            RETURN LV_salida;
-- Fin 36689

EXCEPTION
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_FecEjec;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_PKG_Parametros.IC_ValidaServicio_FN ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_PKG_Parametros.IC_ValidaServicio_FN',sSql,SQLCODE,LV_des_error);
END;

----------------------------------------------------------------------------
-- FN_COL_MTONETBRUT
-- Funcion que retorne monto neto o bruto del campo icc_movimiento.carga
-- Para el caso de Colombia, se solicitó que cuando el campo ICC_MOVIMIENTO.CARGA = 0 adopte el valor 1 (GED_PARAMETROS.NOM_PARAMETRO = 'VALORCARGA_0')
-- es homologa a la función FN_TMM_MTONETBRUT
-- se agrega situacion particular para el modulo IC.
----------------------------------------------------------------------------
  FUNCTION FN_COL_MTONETBRUT (V_Num_Movimiento  IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN VARCHAR2 IS

--Inicio Incidencia CO-0015 26-4-2006 centrales
        V_ICC              GA_ABOCEL.NUM_SERIE%TYPE;
        v_cod_actabo        ICC_MOVIMIENTO.COD_ACTABO%TYPE;
--Fin Incidencia CO-0015 26-4-2006 centrales

    v_Carga                ICC_MOVIMIENTO.CARGA%TYPE;

-- P-COL-07003 INI
    v_Carga_0              ICC_MOVIMIENTO.CARGA%TYPE;
-- P-COL-07003 FIN

    v_Valor_plan           ICC_MOVIMIENTO.VALOR_PLAN%TYPE;

    V_VAL_PARAMETRO           GED_PARAMETROS.VAL_PARAMETRO%TYPE;
    V_VAL_PARAMETRO2       GED_PARAMETROS.VAL_PARAMETRO%TYPE;

    V_Num_Abonado           ICC_MOVIMIENTO.NUM_ABONADO%TYPE;

    V_Mto_Carga               NUMBER;
    V_PARAM                   VARCHAR2(200) := 0;
    v_cod_mod              ICC_MOVIMIENTO.cod_modulo%TYPE;
    v_tip_tecnologia       ICC_MOVIMIENTO.tip_tecnologia%TYPE;
    v_num_celular          ICC_MOVIMIENTO.num_celular%TYPE;
    v_cargobasico          GA_ABOCEL.cod_cargobasico%TYPE;
    v_imp_cargobasico      TA_CARGOSBASICO.imp_cargobasico%TYPE;
    v_region               GA_ABOCEL.cod_region%TYPE;
    v_provincia            GA_ABOCEL.cod_provincia%TYPE;
    v_ciudad               GA_ABOCEL.cod_ciudad%TYPE;
    v_zonaimpositiva       GE_ZONACIUDAD.cod_zonaimpo%TYPE;

BEGIN

-- Inicio Incidencia 40572 15/05/2007
     BEGIN
--Inicio Incidencia CO-0015 26-4-2006 centrales
--         SELECT NVL(trim(carga),0),NVL(valor_plan,0), NUM_ABONADO, NVL(cod_modulo, CHR(0)),tip_tecnologia,num_celular
--         INTO V_carga,v_valor_plan, V_Num_Abonado, v_cod_mod,v_tip_tecnologia,v_num_celular
--Fin Incidencia CO-0015 26-4-2006 centrales
         SELECT NVL(carga,0),NVL(valor_plan,0), NUM_ABONADO, NVL(cod_modulo, CHR(0)),tip_tecnologia,num_celular,cod_actabo
         INTO V_carga,v_valor_plan, V_Num_Abonado, v_cod_mod,v_tip_tecnologia,v_num_celular,v_cod_actabo
         FROM ICC_MOVIMIENTO
         WHERE
         NUM_MOVIMIENTO =  V_Num_Movimiento;


     EXCEPTION
     WHEN NO_DATA_FOUND THEN
              RETURN 'MOVIMIENTO NO EXISTE | '||SQLERRM;
     WHEN OTHERS THEN
             RETURN 'ERROR ACCESO ICC_MOVIMIENTO | '||SQLERRM;
     END;

--
-- P-COL-07003
-- INI

        IF V_carga = 0 or V_carga is null THEN

        BEGIN
            SELECT VAL_PARAMETRO
            INTO   v_Carga_0
            FROM   GED_PARAMETROS
            WHERE  NOM_PARAMETRO = 'VALORCARGA_0'
            AND    COD_MODULO    = 'GA'
            AND    COD_PRODUCTO  = 1;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                   RETURN 'PARAMETRO VALORCARGA_0 NO EXISTE | '||SQLERRM;
            WHEN OTHERS THEN
                   RETURN 'PARAM ERROR VALORCARGA_0 | ' ||SQLERRM;
        END;

        V_carga := to_number(v_Carga_0);
        RETURN TO_CHAR(V_carga);

    END IF;

-- FIN
-- P-COL-07003
--

     -- Situacion particular.
--Inicio Incidencia CO-0015 26-4-2006 centrales
--     IF V_COD_MOD = 'IC' THEN
--Fin Incidencia CO-0015 26-4-2006 centrales
     IF V_COD_MOD = 'IC' AND v_cod_actabo <> 'BP' THEN
     BEGIN
        IF substr(v_tip_tecnologia,1,3) = 'CDM' THEN

           SELECT COD_CARGOBASICO INTO v_cargobasico
           FROM GA_ABOCEL WHERE NUM_CELULAR = v_num_celular;

           SELECT IMP_CARGOBASICO INTO v_imp_cargobasico
           FROM TA_CARGOSBASICO WHERE COD_CARGOBASICO = v_cargobasico;

           V_carga := v_imp_cargobasico;

           SELECT COD_REGION,COD_PROVINCIA,COD_CIUDAD INTO v_region,v_provincia,v_ciudad
           FROM GA_ABOCEL WHERE NUM_CELULAR = v_num_celular AND ROWNUM = 1;

           SELECT COD_ZONAIMPO INTO v_zonaimpositiva FROM GE_ZONACIUDAD
           WHERE COD_REGION = v_region
           AND COD_PROVINCIA = v_provincia
           AND COD_CIUDAD = v_ciudad
           AND ROWNUM = 1;

           IF v_zonaimpositiva = '1' THEN
              V_carga := ROUND(V_carga * 1.15);
           ELSE
              V_carga := ROUND(V_carga * 1.1);
           END IF;

           RETURN TO_CHAR(V_carga);
        END IF;
        IF v_tip_tecnologia = 'GSM' THEN
           SELECT COD_CARGOBASICO INTO v_cargobasico
           FROM GA_ABOCEL WHERE NUM_CELULAR = v_num_celular;

           SELECT IMP_CARGOBASICO INTO v_imp_cargobasico
           FROM TA_CARGOSBASICO WHERE COD_CARGOBASICO = v_cargobasico;

           V_carga := v_imp_cargobasico;

           RETURN TO_CHAR(V_carga);
        END IF;
     END;
     END IF;

--Inicio Incidencia CO-0015 26-4-2006 centrales
/*
IF v_tip_tecnologia = 'GSM' AND V_COD_MOD = 'IC' AND V_COD_ACTABO = 'BP' THEN

         SELECT NUM_SERIE INTO V_ICC
         FROM  GA_ABOCEL
         WHERE NUM_CELULAR = v_num_celular
             AND    COD_SITUACION = 'AAA';

         UPDATE ICC_MOVIMIENTO
         SET ICC = V_ICC
         WHERE NUM_MOVIMIENTO = V_Num_Movimiento;

     END IF;
*/
--Fin Incidencia CO-0015 26-4-2006 centrales

     GV_cod_modulo   := 'GA';
     GN_cod_producto := 1;
     BEGIN
     GV_nom_parametro := 'FLAG_MTO_ENTRANTE';
     SELECT
     VAL_PARAMETRO
     INTO
     V_VAL_PARAMETRO
     FROM
     GED_PARAMETROS
     WHERE
     NOM_PARAMETRO = GV_nom_parametro  AND
     COD_MODULO    = GV_cod_modulo        AND
     COD_PRODUCTO  = GN_cod_producto;

     EXCEPTION
                WHEN NO_DATA_FOUND THEN
                         RETURN 'PARAMETRO NO EXISTE | '||SQLERRM;
             WHEN OTHERS THEN
                        RETURN 'PARAM ERROR FLAG_MTO_ENTRANTE | ' ||SQLERRM;
     END;

     BEGIN
         GV_nom_parametro := 'FLAG_MTO_SALIENTE';
        SELECT  VAL_PARAMETRO      INTO       V_VAL_PARAMETRO2
        FROM     GED_PARAMETROS
        WHERE     NOM_PARAMETRO = GV_nom_parametro
          AND   COD_MODULO    = GV_cod_modulo
          AND   COD_PRODUCTO  = GN_cod_producto;

     EXCEPTION
                WHEN NO_DATA_FOUND THEN
                         RETURN 'PARAMETRO NO EXISTE | '||SQLERRM;
        WHEN OTHERS THEN
                        RETURN 'PARAM ERROR FLAG_MTO_SALIENTE | ' ||SQLERRM;
     END;

     IF V_carga = 0 THEN
        V_Mto_Carga    :=v_valor_plan;
     ELSE
         V_Mto_Carga    :=V_carga;
     END IF;

     IF V_Mto_Carga > 0 THEN
          IF V_VAL_PARAMETRO2<>V_VAL_PARAMETRO THEN
                V_PARAM := Pv_Mtonbporc_Fn(V_Num_Movimiento,NULL,V_Mto_Carga,V_VAL_PARAMETRO,V_Num_Abonado);
          ELSE
             V_PARAM:= V_Mto_Carga;
          END IF;
     END IF;

     RETURN v_param;
-- Fin Incidencia 40572

END FN_COL_MTONETBRUT;


END Ic_Pkg_Parametros;
/
SHOW ERRORS
