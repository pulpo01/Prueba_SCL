CREATE OR REPLACE PACKAGE BODY IC_PROCPROVISION_PG AS

/*
<NOMBRE>       : IC_PROCPROVISION_PG</NOMBRE>
<FECHACREA>    : <FECHACREA/>
<MODULO >      : IC</MODULO >
<AUTOR >       : Carlos Sellao H.</AUTOR >
<VERSION >     : 1.0</VERSION >
<DESCRIPCION>  : Procedimientos y funciones para procesos de Centrales.</DESCRIPCION>
<FECHAMOD >    : </FECHAMOD>
<DESCMOD >     : </DESCMOD>
*/


PROCEDURE ic_valida_imei_pr(VP_TRANSAC   IN VARCHAR2,
                            EV_num_imei  IN ga_aboamist.num_serie%TYPE) IS
/*
<Documentación
        TipoDoc = "Procedure">
        <Elemento
                Nombre = "ic_valida_imei_pr"
                Lenguaje="PL/SQL"
                Fecha creación="06-2009"
                Creado por="Carlos Sellao H."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Procedure para validar un IMEI.</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="VP_TRANSAC" Tipo="VARCHAR2">secuencia de transaccion</param>
                                <param nom="EV_num_imei" Tipo="NUMERICO">Numero del Imei</param>
                        </Entrada>
                        <Salida>
        						<param nom="" Tipo=""></param>
                        </Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/

LB_retorno       BOOLEAN;
LN_largoimei     ga_aboamist.num_imei%TYPE;
LN_cod_retorno   ge_errores_td.cod_msgerror%TYPE;
LV_mens_retorno  ge_errores_td.det_msgerror%TYPE;
LN_num_evento    ge_errores_pg.evento;
LN_len           number:=0;
LV_dig           varchar2(2);
LV_num           varchar2(16);
LV_digval        varchar2(2);
LV_CADENA        varchar2(255) := NULL;

LV_ERROR         VARCHAR2(1) := '0';
LV_TRANSAC       GA_TRANSACABO.NUM_TRANSACCION%TYPE;
error_datos      EXCEPTION;

BEGIN

           LV_TRANSAC := TO_NUMBER(VP_TRANSAC);

           LB_retorno:= ve_recuperaparametros_sms_pg.ve_recupera_parametros_fn('LARGO_SERIE_TGSM', 'AL', 1, LN_largoimei, LN_cod_retorno, LV_mens_retorno,LN_num_evento);
           IF NOT LB_retorno THEN
                   LV_ERROR := '1';
                   RAISE error_datos;
           END IF;


           LN_len := LENGTH(TRIM(EV_num_imei));
           IF LN_len<>TO_NUMBER(LN_largoimei) THEN
                   LV_ERROR := '2'; --ERROR_LARGO_IMSI
                   RAISE error_datos;
           END IF;

           LV_dig := substr(EV_num_imei,LN_len, 1);
           LV_num := substr(EV_num_imei,1, LN_len-1);

           LV_digval := GE_FN_LUHN(LV_num);

           IF LV_dig<>LV_digval THEN
                   LV_ERROR := '3';
                   LV_CADENA := 'Digito encontrado:' || LV_digval;
                   RAISE error_datos;
           END IF;


           LV_CADENA := EV_num_imei;
           RAISE error_datos;

EXCEPTION
        WHEN error_datos THEN

           INSERT INTO GA_TRANSACABO
                  (NUM_TRANSACCION,
                   COD_RETORNO,
                   DES_CADENA)
           VALUES (LV_TRANSAC,
                   LV_ERROR,
                   LV_CADENA);

END ic_valida_imei_pr;


PROCEDURE ic_Desb_iPhone_pr(VP_TRANSAC   IN VARCHAR2,
                            EV_num_imei  IN ga_aboamist.num_serie%TYPE) IS
/*
<Documentación
        TipoDoc = "Procedure">
        <Elemento
                Nombre = "ic_desb_iPhone_pr"
                Lenguaje="PL/SQL"
                Fecha creación="06-2009"
                Creado por="Carlos Sellao H."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Procedure para generar un movimiento de desbloqueo de iPhone.</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="VP_TRANSAC" Tipo="VARCHAR2">secuencia de transaccion</param>
                                <param nom="EV_num_imei" Tipo="NUMERICO">Numero del Imei</param>
                        </Entrada>
                        <Salida>
        						<param nom="" Tipo=""></param>
                        </Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/

LB_retorno       BOOLEAN;
LN_cod_retorno   ge_errores_td.cod_msgerror%TYPE;
LV_mens_retorno  ge_errores_td.det_msgerror%TYPE;
LN_num_evento    ge_errores_pg.evento;
LV_CADENA        varchar2(255) := NULL;

LV_ERROR         VARCHAR2(1) := '0';
LV_TRANSAC       GA_TRANSACABO.NUM_TRANSACCION%TYPE;
error_datos      EXCEPTION;

LN_NUM_MOVIMIENTO  icc_movimiento.num_movimiento%TYPE;
LN_NUM_CELULAR  icc_movimiento.num_celular%TYPE;
LN_NUM_ABONADO  icc_movimiento.num_abonado%TYPE;
LN_COD_ESTADO   icc_movimiento.cod_estado%TYPE;
LV_COD_MODULO   icc_movimiento.cod_modulo%TYPE;
LV_COD_ACTABO   icc_movimiento.cod_actabo%TYPE;
LN_NUM_INTENTOS icc_movimiento.num_intentos%TYPE;
LV_DES_RESPUESTA   icc_movimiento.des_respuesta%TYPE;
LN_COD_ACTUACION   icc_movimiento.cod_actuacion%TYPE;
LV_NOM_USUARORA    icc_movimiento.nom_usuarora%TYPE;
LD_FEC_INGRESO     icc_movimiento.fec_ingreso%TYPE;
LV_TIP_TERMINAL    icc_movimiento.tip_terminal%TYPE;
LN_COD_CENTRAL     icc_movimiento.cod_central%TYPE;
LN_IND_BLOQUEO     icc_movimiento.ind_bloqueo%TYPE;
LV_NUM_SERIE       icc_movimiento.num_serie%TYPE;
LV_TIP_TECNOLOGIA  icc_movimiento.tip_tecnologia%TYPE;
LV_IMEI            icc_movimiento.imei%TYPE;
LV_actuacion       ged_parametros.VAL_PARAMETRO%TYPE;
LV_central         ged_parametros.VAL_PARAMETRO%TYPE;

BEGIN

   LV_TRANSAC := TO_NUMBER(VP_TRANSAC);

   LN_NUM_MOVIMIENTO := NULL;
   LN_NUM_CELULAR := 0;
   LN_NUM_ABONADO := 0;
   LN_COD_ESTADO := 1;
   LV_COD_MODULO := CV_Modulo_ST;
   LN_NUM_INTENTOS := 0;
   LV_DES_RESPUESTA := 'PENDIENTE';
   LV_NOM_USUARORA := USER;
   LD_FEC_INGRESO := SYSDATE;
   LV_TIP_TERMINAL := 'G';
   LN_IND_BLOQUEO := 0;
   LV_NUM_SERIE := '0';
   LV_TIP_TECNOLOGIA := 'GSM';
   LV_IMEI := EV_num_imei;


   LB_retorno:= ic_busca_parametros_fn('ACTABO_DESBL_IPHONE', 'ST', CN_Producto, LV_COD_ACTABO, LN_cod_retorno, LV_mens_retorno,LN_num_evento);
   IF NOT LB_retorno THEN
        LV_ERROR := '2';
        RAISE error_datos;
   END IF;

   BEGIN
        SELECT cod_actcen
        INTO LN_COD_ACTUACION
        FROM  ga_actabo
        WHERE cod_producto = CN_Producto
        AND   cod_actabo = LV_COD_ACTABO
        AND   cod_tecnologia = LV_TIP_TECNOLOGIA
        AND   cod_modulo = CV_Modulo_ST;
   EXCEPTION
      WHEN OTHERS THEN
        LV_ERROR := '2';
        RAISE error_datos;
   END;

   LB_retorno:= ic_busca_parametros_fn('CENTRAL_DESBL_IPHONE', 'ST', CN_Producto, LV_central, LN_cod_retorno, LV_mens_retorno,LN_num_evento);
   IF NOT LB_retorno THEN
        LV_ERROR := '2';
        RAISE error_datos;
   END IF;

   LN_COD_CENTRAL := TO_NUMBER(LV_central);

BEGIN
INSERT INTO ICC_MOVIMIENTO
(
        NUM_MOVIMIENTO,
        NUM_ABONADO,
        COD_ESTADO,
        COD_ACTABO,
        COD_MODULO,
        NUM_INTENTOS,
        COD_CENTRAL_NUE,
        DES_RESPUESTA,
        COD_ACTUACION,
        NOM_USUARORA,
        FEC_INGRESO,
        TIP_TERMINAL,
        COD_CENTRAL,
        FEC_LECTURA,
        IND_BLOQUEO,
        FEC_EJECUCION,
        TIP_TERMINAL_NUE,
        NUM_MOVANT,
        NUM_CELULAR,
        NUM_MOVPOS,
        NUM_SERIE,
        NUM_PERSONAL,
        NUM_CELULAR_NUE,
        NUM_SERIE_NUE,
        NUM_PERSONAL_NUE,
        NUM_MSNB,
        NUM_MSNB_NUE,
        COD_SUSPREHA,
        COD_SERVICIOS,
        NUM_MIN,
        NUM_MIN_NUE,
        STA,
        COD_MENSAJE,
        PARAM1_MENS,
        PARAM2_MENS,
        PARAM3_MENS,
        PLAN,
        CARGA,
        VALOR_PLAN,
        PIN,
        FEC_EXPIRA,
        DES_MENSAJE,
        COD_PIN,
        COD_IDIOMA,
        COD_ENRUTAMIENTO,
        TIP_ENRUTAMIENTO,
        DES_ORIGEN_PIN,
        NUM_LOTE_PIN,
        NUM_SERIE_PIN,
        TIP_TECNOLOGIA,
        IMSI,
        IMSI_NUE,
        IMEI,
        IMEI_NUE,
        ICC,
        ICC_NUE,
        FEC_ACTIVACION,
        COD_ESPEC_PROV,
        COD_PROD_CONTRATADO,
        IND_BAJATRANS
)
VALUES
(
        NVL(LN_NUM_MOVIMIENTO, ICC_SEQ_NUMMOV.NEXTVAL),
        LN_NUM_ABONADO,
        LN_COD_ESTADO,
        LV_COD_ACTABO,
        LV_COD_MODULO,
        LN_NUM_INTENTOS,
        NULL,
        LV_DES_RESPUESTA,
        LN_COD_ACTUACION,
        LV_NOM_USUARORA,
        LD_FEC_INGRESO,
        LV_TIP_TERMINAL,
        LN_COD_CENTRAL,
        NULL,
        LN_IND_BLOQUEO,
        NULL,
        NULL,
        NULL,
        LN_NUM_CELULAR,
        NULL,
        LV_NUM_SERIE,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        LV_TIP_TECNOLOGIA,
        NULL,
        NULL,
        LV_IMEI,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL
)RETURNING NUM_MOVIMIENTO INTO LN_NUM_MOVIMIENTO;


EXCEPTION
 WHEN OTHERS THEN
     LV_ERROR := '3';
     LV_CADENA := TO_CHAR(LN_NUM_MOVIMIENTO);
     RAISE error_datos;
END;

   LV_ERROR := '0';
   LV_CADENA := TO_CHAR(LN_NUM_MOVIMIENTO);
   RAISE error_datos;

EXCEPTION
        WHEN error_datos THEN

           INSERT INTO GA_TRANSACABO
                  (NUM_TRANSACCION,
                   COD_RETORNO,
                   DES_CADENA)
           VALUES (LV_TRANSAC,
                   LV_ERROR,
                   LV_CADENA);

END ic_Desb_iPhone_pr;


PROCEDURE ic_BuscaMov_iPhone_pr(VP_TRANSAC   IN VARCHAR2,
                            EV_num_imei  IN ga_aboamist.num_serie%TYPE) IS
/*
<Documentación
        TipoDoc = "Procedure">
        <Elemento
                Nombre = "ic_BuscaMov_iPhone_pr"
                Lenguaje="PL/SQL"
                Fecha creación="06-2009"
                Creado por="Carlos Sellao H."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Procedure para buscar un movimiento de desbloqueo de iPhone para un imei.</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="VP_TRANSAC" Tipo="VARCHAR2">secuencia de transaccion</param>
                                <param nom="EV_num_imei" Tipo="NUMERICO">Numero del Imei</param>
                        </Entrada>
                        <Salida>
        						<param nom="" Tipo=""></param>
                        </Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/

LB_retorno       BOOLEAN;
LN_cod_retorno   ge_errores_td.cod_msgerror%TYPE;
LV_mens_retorno  ge_errores_td.det_msgerror%TYPE;
LN_num_evento    ge_errores_pg.evento;
LV_CADENA        varchar2(255) := NULL;
LV_actuacion     ged_parametros.VAL_PARAMETRO%TYPE;
LV_ERROR         VARCHAR2(1) := '0';
LV_TRANSAC       GA_TRANSACABO.NUM_TRANSACCION%TYPE;
LN_cod_actuacion icc_movimiento.cod_actuacion%TYPE;
LV_COD_ACTABO    icc_movimiento.cod_actabo%TYPE;
LV_TIP_TECNOLOGIA  icc_movimiento.tip_tecnologia%TYPE;
LN_NUM_MOVIMIENTO  icc_movimiento.num_movimiento%TYPE;
error_datos      EXCEPTION;

BEGIN

   LV_TRANSAC := TO_NUMBER(VP_TRANSAC);

   LV_TIP_TECNOLOGIA := 'GSM';

   LB_retorno:= ic_busca_parametros_fn('ACTABO_DESBL_IPHONE', 'ST', CN_Producto, LV_COD_ACTABO, LN_cod_retorno, LV_mens_retorno,LN_num_evento);
   IF NOT LB_retorno THEN
        LV_ERROR := '1';
        RAISE error_datos;
   END IF;


   BEGIN
        SELECT cod_actcen
        INTO LN_cod_actuacion
        FROM  ga_actabo
        WHERE cod_producto = CN_Producto
        AND   cod_actabo = LV_COD_ACTABO
        AND   cod_tecnologia = LV_TIP_TECNOLOGIA
        AND   cod_modulo = CV_Modulo_ST;
   EXCEPTION
      WHEN OTHERS THEN
        LV_ERROR := '1';
        RAISE error_datos;
   END;

   BEGIN
       SELECT num_movimiento
       INTO LN_NUM_MOVIMIENTO
       FROM icc_movimiento
       WHERE cod_actuacion = LN_cod_actuacion
       AND IMEI = EV_num_imei;

   EXCEPTION
    WHEN NO_DATA_FOUND THEN
        LV_ERROR := '2';
        RAISE error_datos;
    WHEN TOO_MANY_ROWS THEN
        LV_ERROR := '3';
        RAISE error_datos;
    WHEN OTHERS THEN
        LV_ERROR := '1';
        RAISE error_datos;
   END;

   LV_ERROR := '0';
   LV_CADENA := TO_CHAR(LN_NUM_MOVIMIENTO);
   RAISE error_datos;

EXCEPTION
        WHEN error_datos THEN

           INSERT INTO GA_TRANSACABO
                  (NUM_TRANSACCION,
                   COD_RETORNO,
                   DES_CADENA)
           VALUES (LV_TRANSAC,
                   LV_ERROR,
                   LV_CADENA);

END ic_BuscaMov_iPhone_pr;


FUNCTION ic_busca_parametros_fn (
        ev_nom_parametro    IN               ged_parametros.nom_parametro%TYPE,
        ev_cod_modulo       IN               ged_parametros.cod_modulo%TYPE,
        en_cod_producto     IN               ged_parametros.cod_producto%TYPE,
        sv_val_parametro    OUT NOCOPY       ged_parametros.val_parametro%TYPE,
        sn_cod_retorno      OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
        sv_mens_retorno     OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
        sn_num_evento       OUT NOCOPY       ge_errores_pg.evento
) RETURN BOOLEAN
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "ic_busca_parametros_fn""
      Lenguaje="PL/SQL"
      Fecha="06-2009"
      Versión="1.0"
      Diseñador=""
      Programador=""
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción></Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EV_nom_parametro" Tipo="CARACTER">Nombre de parametro </param>
			<param nom="EV_cod_modulo   " Tipo="CARACTER">Codigo de Modulo    </param>
			<param nom="EN_cod_producto " Tipo="NUMERICO">Cod.Producto Celular</param>
         </Entrada>
         <Salida>
            <param nom="SV_val_parametro" Tipo="CARACTER">Valor parametro   </param>
            <param nom="SN_cod_retorno  " Tipo="NUMERICO">Codigo de Retorno </param>
            <param nom="SV_mens_retorno " Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento   " Tipo="NUMERICO">Numero de Evento  </param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
    exception_ErrParam EXCEPTION;
	V_des_error  	   ge_errores_pg.DesEvent;
	LV_sql         	   ge_errores_pg.vQuery;
	LV_nomparametro    ged_parametros.nom_parametro%TYPE;
BEGIN
    SN_cod_retorno := 0;
    SN_num_evento  := 0;
    SV_mens_retorno:= NULL;

    LV_sql := 'SELECT param.val_parametro';
    LV_sql := LV_sql || ' INTO EV_val_parametro';
    LV_sql := LV_sql || ' FROM ged_parametros param';
    LV_sql := LV_sql || ' WHERE nom_parametro = '|| EV_nom_parametro;
    LV_sql := LV_sql || ' AND cod_modulo = '|| EV_cod_modulo;
    LV_sql := LV_sql || ' AND cod_producto = '|| EN_cod_producto;

    SELECT param.val_parametro
      INTO SV_val_parametro
      FROM ged_parametros param
     WHERE nom_parametro = EV_nom_parametro
       AND cod_modulo = EV_cod_modulo
       AND cod_producto = EN_cod_producto;

    RETURN TRUE;

EXCEPTION
WHEN OTHERS THEN
		SN_cod_retorno := 156;
		IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
		    SV_mens_retorno := CV_Err_NoClasif;
		END IF;
		V_des_error := 'IC_PROCPROVISION_PG.ic_busca_parametros_fn('|| EV_nom_parametro||', '||EV_cod_modulo||', '||EN_cod_producto||'); - ' || SQLERRM;
		SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'IC', SV_mens_retorno, '1.0', USER, 'IC_PROCPROVISION_PG.ic_busca_parametros_fn', LV_sql, SQLCODE, V_des_error );
		RETURN FALSE;
END ic_busca_parametros_fn;

END IC_PROCPROVISION_PG;
/
SHOW ERRORS
