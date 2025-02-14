CREATE OR REPLACE PACKAGE BODY SISCEL.PV_GENERAL_OOSS_PG IS

FUNCTION RETORNA_VERSION RETURN VARCHAR2 -- Modificaco por Soporte - Alejandro Hott - 30/11/2004 - TM-200411151097
IS
  p_version    CONSTANT VARCHAR2(3) := '001';
  p_subversion CONSTANT VARCHAR2(3) := '003'; -- Modificaco por Soporte - Alejandro Hott - 29/11/2004 - TM-200411151097
BEGIN
   RETURN('Version : '||p_version||' <--> SubVersion : '||p_subversion);
END;


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION PV_RECUPERA_PLAN_COMERCIAL_FN (EN_cod_cliente   IN         ga_abocel.cod_cliente%TYPE,
                                           SN_cod_plancom   OUT NOCOPY ga_cliente_pcom.cod_plancom%TYPE,
                                        SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                           SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                           SN_num_evento    OUT NOCOPY ge_errores_pg.Evento
)
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "PV_RECUPERA_PLAN_COMERCIAL_FN"
      Lenguaje="PL/SQL"
      Fecha="16-11-2005"
      Versión="1.0"
      Diseñador="Jubitza Villanueva G."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Recuperar plan comercial del cliente.Migración al estándar de PV_RECUPERA_PLAN_COMERCIAL_FN</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_cliente"       Tipo="NUMERICO">Código de cliente</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_plancom"       Tipo="NUMERICO">Codigo dplan comercial del cliente</param>
            <param nom="SN_cod_retorno"       Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"      Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"        Tipo="NUMERICO">Numero de Evento</param>

         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
RETURN BOOLEAN
AS
        LV_des_error         ge_errores_pg.DesEvent;
        LV_Sql               ge_errores_pg.vQuery;

BEGIN
        SN_cod_retorno:=0;
        SN_num_evento:=0;
        SV_mens_retorno:=NULL;
        SN_cod_plancom:=NULL;

        LV_Sql:='SELECT A.COD_PLANCOM INTO SN_cod_plancom '||
                    ' FROM GA_CLIENTE_PCOM A '||
                  ' WHERE A.COD_CLIENTE='||EN_COD_CLIENTE||
                     ' AND SYSDATE BETWEEN A.FEC_DESDE AND NVL(A.FEC_HASTA, SYSDATE)';

        SELECT A.COD_PLANCOM
            INTO SN_cod_plancom
            FROM GA_CLIENTE_PCOM A
          WHERE A.COD_CLIENTE = EN_COD_CLIENTE
             AND SYSDATE BETWEEN A.FEC_DESDE AND NVL(A.FEC_HASTA, SYSDATE);

         RETURN  TRUE;

EXCEPTION
WHEN OTHERS THEN
                SN_cod_retorno:=302;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno:=CV_error_no_clasIF;
                END IF;
                LV_des_error:='OTHERS:PV_RECUPERA_PLAN_COMERCIAL_FN('||EN_cod_cliente||')- '||substr(SQLERRM,1,50);
                SN_num_evento:= Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno,'1.0', USER, 'PV_GENERAL_OOSS_PG.PV_RECUPERA_PLAN_COMERCIAL_FN', LV_Sql , SQLCODE, LV_des_error );
                RETURN  FALSE;
END PV_RECUPERA_PLAN_COMERCIAL_FN;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION pv_inserta_modabocel_fn      (EN_num_abonado   IN         ga_modabocel.num_abonado%TYPE,
                                        EV_cod_tipmodi   IN         ga_modabocel.cod_tipmodi%TYPE,
                                        ED_fec_modifica   IN        ga_modabocel.fec_modifica%TYPE,
                                       EV_nom_usuario   IN         ga_modabocel.nom_usuarora%TYPE,
                                       EV_num_frecuente IN         ga_modabocel.num_telefija%TYPE,
                                       SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                          SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                          SN_num_evento    OUT NOCOPY ge_errores_pg.Evento
                                 )
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "pv_inserta_modabocel_fn"
      Lenguaje="PL/SQL"
      Fecha="14-11-2005"
      Versión="1.0"
      Diseñador="Jubitza Villanueva G."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Insertar registro de modificación para un abonado. Función nueva</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_abonado"       Tipo="NUMERICO">nro abonado</param>
            <param nom="EV_num_frecuente"     Tipo="CARACTER">nro frecuente</param>
            <param nom="EN_num_diasnum"       Tipo="NUMERICO">Id.servicio suplementario F-F</param>
            <param nom="EV_tip_frecuente"     Tipo="CARACTER">Tipo de nro frecuente.</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"       Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"      Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"        Tipo="NUMERICO">Numero de Evento</param>

         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
RETURN BOOLEAN
AS
        LV_des_error         ge_errores_pg.DesEvent;
        LV_Sql               ge_errores_pg.vQuery;

BEGIN
        SN_cod_retorno:=0;
        SN_num_evento:=0;
        SV_mens_retorno:=NULL;

        LV_Sql:=' INSERT  '||
                ' INTO  GA_MODABOCEL '||
                ' (NUM_ABONADO,COD_TIPMODI,FEC_MODIFICA,NOM_USUARORA,NUM_TELEFIJA) '||
                ' VALUES ('||EN_num_abonado||','||EV_cod_tipmodi||','||ED_fec_modifica||','||EV_nom_usuario||','||EV_num_frecuente||')';

        INSERT
          INTO  GA_MODABOCEL
                (NUM_ABONADO,COD_TIPMODI,FEC_MODIFICA,NOM_USUARORA,NUM_TELEFIJA)
         VALUES (EN_num_abonado,EV_cod_tipmodi,ED_fec_modifica,EV_nom_usuario,EV_num_frecuente);
        RETURN TRUE;

EXCEPTION
WHEN OTHERS THEN
                SN_cod_retorno:=302;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno:=CV_error_no_clasIF;
                END IF;
                LV_des_error:='OTHERS:pv_inserta_modabocel_fn('||EN_num_abonado||','||EV_cod_tipmodi ||','||ED_fec_modifica||','||EV_nom_usuario||','||EV_num_frecuente||')- '||substr(SQLERRM,1,50);
                SN_num_evento:= Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno,'1.0', USER, 'PV_GENERAL_OOSS_PG.pv_inserta_modabocel_fn', LV_Sql , SQLCODE, LV_des_error );
                RETURN  FALSE;
END pv_inserta_modabocel_fn;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE PV_DATOS_ABONADO_PR (VP_NUM_CELULAR        IN GA_ABOCEL.NUM_CELULAR%TYPE,
            VP_IMPLIMCONS          OUT NUMBER  ,
            VP_PROC                        OUT VARCHAR2,
            VP_TABLA                       OUT VARCHAR2,
            VP_ACT                         OUT VARCHAR2,
            VP_SQLCODE                     OUT VARCHAR2,
            VP_SQLERRM                     OUT VARCHAR2,
            VP_ERROR                       OUT VARCHAR2) is

-- Procedimiento que recupera datos en la tabla de abonados celular (PostPago - Pre-Pago)
--            Los posibles retornos del procedimiento son :
--                - '0' Ejecucion Correcta
--                - '4' Error en el proceso
--
  V_LIMCONSUMO GA_ABOCEL.COD_LIMCONSUMO%TYPE;
  V_INDTOL GED_PARAMETROS.VAL_PARAMETRO%TYPE;
BEGIN
   VP_ERROR:='0';
   VP_PROC := 'PV_PRC_DATOS_ABOCEL';
   VP_TABLA := 'GED_PARAMETROS';

   SELECT VAL_PARAMETRO
   INTO  V_INDTOL
   FROM GED_PARAMETROS
   WHERE NOM_PARAMETRO = 'IND_TOL';
   VP_TABLA := 'GA_ABOCEL';
   VP_ACT := 'S';
   SELECT        NUM_ABONADO,                   COD_PRODUCTO,            COD_CLIENTE,           COD_CUENTA,
                         COD_SUBCUENTA,                 COD_USUARIO,             COD_REGION,            COD_PROVINCIA,
                         COD_CIUDAD,                    COD_CELDA,                       COD_CENTRAL,           COD_USO,
                         COD_SITUACION,                 IND_PROCALTA,            IND_PROCEQUI,          COD_VENDEDOR,
                         COD_VENDEDOR_AGENTE,   TIP_PLANTARIF,           TIP_TERMINAL,          COD_PLANTARIF,
                 COD_CARGOBASICO,               COD_PLANSERV,            COD_LIMCONSUMO,        NUM_SERIE,
                         NUM_SERIEHEX,                  NOM_USUARORA,            FEC_ALTA,              NUM_PERCONTRATO,
                         COD_ESTADO,                    NUM_SERIEMEC,            COD_HOLDING,           COD_EMPRESA,
                         COD_GRPSERV,                   IND_SUPERTEL,            NUM_TELEFIJA,          COD_OPREDFIJA,
                         COD_CARRIER,                   IND_PREPAGO,             IND_PLEXSYS,           COD_CENTRAL_PLEX,
                         NUM_CELULAR_PLEX,      NUM_VENTA,                       COD_MODVENTA,          COD_TIPCONTRATO,
                         NUM_CONTRATO,                  NUM_ANEXO,                       FEC_CUMPLAN,           COD_CREDMOR,
                         COD_CREDCON,                   COD_CICLO,                       IND_FACTUR,            IND_SUSPEN,
                         IND_REHABI,                    IND_INSGUIAS,            FEC_FINCONTRA,         FEC_RECDOCUM,
                         FEC_CUMPLIMEN,                 FEC_ACEPVENTA,           FEC_ACTCEN,            FEC_BAJA,
                         FEC_BAJACEN,                   FEC_ULTMOD,              COD_CAUSABAJA,         NUM_PERSONAL,
                         IND_SEGURO,                    CLASE_SERVICIO,          PERFIL_ABONADO,        NUM_MIN,
                         COD_VENDEALER,                 IND_DISP,                        COD_PASSWORD,      IND_PASSWORD,
                 COD_AFINIDAD,                  FEC_PRORROGA,            IND_EQPRESTADO,        FLG_CONTDIGI,
                         FEC_ALTANTRAS,                 COD_TECNOLOGIA,          NUM_IMEI,              COD_INDEMNIZACION,
                         NUM_MIN_MDN,                   FEC_ACTIVACION,          IND_TELEFONO
    INTO        VP_NUM_ABONADO,                 VP_COD_PRODUCTO,         VP_COD_CLIENTE,        VP_COD_CUENTA,
                        VP_COD_SUBCUENTA,               VP_COD_USUARIO,          VP_COD_REGION,         VP_COD_PROVINCIA,
                        VP_COD_CIUDAD,                  VP_COD_CELDA,            VP_COD_CENTRAL,        VP_COD_USO,
                        VP_COD_SITUACION,               VP_IND_PROCALTA,         VP_IND_PROCEQUI,       VP_COD_VENDEDOR,
                        VP_COD_VENDEDOR_AGENTE, VP_TIP_PLANTARIF,        VP_TIP_TERMINAL,       VP_COD_PLANTARIF,
                        VP_COD_CARGOBASICO,             VP_COD_PLANSERV,         VP_COD_LIMCONSUMO,     VP_NUM_SERIE,
                        VP_NUM_SERIEHEX,                VP_NOM_USUARORA,         VP_FEC_ALTA,           VP_NUM_PERCONTRATO,
                        VP_COD_ESTADO,                  VP_NUM_SERIEMEC,         VP_COD_HOLDING,        VP_COD_EMPRESA,
                        VP_COD_GRPSERV,                 VP_IND_SUPERTEL,         VP_NUM_TELEFIJA,       VP_COD_OPREDFIJA,
                        VP_COD_CARRIER,                 VP_IND_PREPAGO,          VP_IND_PLEXSYS,        VP_COD_CENTRAL_PLEX,
                        VP_NUM_CELULAR_PLEX,    VP_NUM_VENTA,            VP_COD_MODVENTA,       VP_COD_TIPCONTRATO,
                        VP_NUM_CONTRATO,                VP_NUM_ANEXO,            VP_FEC_CUMPLAN,        VP_COD_CREDMOR,
                        VP_COD_CREDCON,                 VP_COD_CICLO,            VP_IND_FACTUR,         VP_IND_SUSPEN,
                        VP_IND_REHABI,                  VP_IND_INSGUIAS,         VP_FEC_FINCONTRA,      VP_FEC_RECDOCUM,
                        VP_FEC_CUMPLIMEN,               VP_FEC_ACEPVENTA,        VP_FEC_ACTCEN,         VP_FEC_BAJA,
                        VP_FEC_BAJACEN,                 VP_FEC_ULTMOD,           VP_COD_CAUSABAJA,      VP_NUM_PERSONAL,
                        VP_IND_SEGURO,                  VP_CLASE_SERVICIO,       VP_PERFIL_ABONADO,     VP_NUM_MIN,
                        VP_COD_VENDEALER,               VP_IND_DISP,         VP_COD_PASSWORD,   VP_IND_PASSWORD,
                        VP_COD_AFINIDAD,                VP_FEC_PRORROGA,         VP_IND_EQPRESTADO,     VP_FLG_CONTDIGI,
                        VP_FEC_ALTANTRAS,               VP_COD_TECNOLOGIA,       VP_NUM_IMEI,           VP_COD_INDEMNIZACION,
                        VP_NUM_MIN_MDN,                 VP_FEC_ACTIVACION,       VP_IND_TELEFONO
    FROM GA_ABOCEL
    WHERE NUM_CELULAR = VP_NUM_CELULAR
    -- Inicio Modificación - GBM - 23-02-2005 - TM-200502161273
        --AND COD_SITUACION IN ('AAA','SAA');
        AND COD_SITUACION IN ('AAA','SAA','RTP','STP');
    -- Fin Modificación - GBM - 23-02-2005 - TM-200502161273

 IF V_INDTOL = 'S' THEN
    IF VP_COD_LIMCONSUMO <> '-1' THEN
        VP_TABLA := 'TOL_LIMITE_TD';
     SELECT IMP_LIMITE
     INTO VP_IMPLIMCONS
     FROM TOL_LIMITE_TD
     WHERE COD_LIMCONS = VP_COD_LIMCONSUMO;
    ELSE
     VP_IMPLIMCONS := 0;
    END IF;
 ELSE
  VP_TABLA := 'TA_LIMCONSUMO';
     SELECT IMP_LIMCONSUMO
       INTO VP_IMPLIMCONS
       FROM TA_LIMCONSUMO
      WHERE COD_PRODUCTO = 1
        AND COD_LIMCONSUMO = VP_COD_LIMCONSUMO;

    END IF;


EXCEPTION
   WHEN NO_DATA_FOUND THEN
   BEGIN
   VP_TABLA := 'GA_ABOAMIST';
    SELECT NUM_ABONADO,          COD_PRODUCTO,       COD_CLIENTE,         COD_CUENTA,             COD_SUBCUENTA, COD_USUARIO,
           COD_REGION,           COD_PROVINCIA,          COD_CIUDAD,              COD_CELDA,                      COD_CENTRAL, COD_USO, COD_SITUACION, IND_PROCALTA,
           IND_PROCEQUI,         COD_VENDEDOR,           COD_VENDEDOR_AGENTE, TIP_PLANTARIF,              TIP_TERMINAL, COD_PLANTARIF,
           COD_CARGOBASICO,  COD_PLANSERV,               COD_LIMCONSUMO,          NUM_SERIE,                      NUM_SERIEHEX, NOM_USUARORA, FEC_ALTA,
           NUM_PERCONTRATO,  COD_ESTADO,                 NUM_SERIEMEC,            COD_HOLDING,                    COD_EMPRESA, COD_GRPSERV, IND_SUPERTEL,
           NUM_TELEFIJA,         COD_OPREDFIJA,          COD_CARRIER,             IND_PREPAGO,                    IND_PLEXSYS, COD_CENTRAL_PLEX, NUM_CELULAR_PLEX,
           NUM_VENTA,            COD_MODVENTA,           COD_TIPCONTRATO,         NUM_CONTRATO,                   NUM_ANEXO, FEC_CUMPLAN, COD_CREDMOR, COD_CREDCON,
           COD_CICLO,            IND_FACTUR,             IND_SUSPEN,              IND_REHABI,                     IND_INSGUIAS, FEC_FINCONTRA, FEC_RECDOCUM, FEC_CUMPLIMEN,
           FEC_ACEPVENTA,        FEC_ACTCEN,             FEC_BAJA,                        FEC_BAJACEN,                    FEC_ULTMOD, COD_CAUSABAJA, NUM_PERSONAL, IND_SEGURO,
           CLASE_SERVICIO,       PERFIL_ABONADO,         NUM_MIN,                         COD_VENDEALER,                  IND_DISP, COD_PASSWORD, IND_PASSWORD,
           COD_AFINIDAD,         COD_TECNOLOGIA,         NUM_IMEI,                NUM_MIN_MDN,                    FEC_ACTIVACION, IND_TELEFONO
    INTO  VP_NUM_ABONADO,        VP_COD_PRODUCTO,        VP_COD_CLIENTE,          VP_COD_CUENTA,                  VP_COD_SUBCUENTA, VP_COD_USUARIO,
          VP_COD_REGION,         VP_COD_PROVINCIA,       VP_COD_CIUDAD,           VP_COD_CELDA,                   VP_COD_CENTRAL, VP_COD_USO, VP_COD_SITUACION,
          VP_IND_PROCALTA,       VP_IND_PROCEQUI,    VP_COD_VENDEDOR,     VP_COD_VENDEDOR_AGENTE, VP_TIP_PLANTARIF, VP_TIP_TERMINAL,
          VP_COD_PLANTARIF,  VP_COD_CARGOBASICO, VP_COD_PLANSERV,         VP_COD_LIMCONSUMO,      VP_NUM_SERIE, VP_NUM_SERIEHEX,
          VP_NOM_USUARORA,       VP_FEC_ALTA,            VP_NUM_PERCONTRATO,  VP_COD_ESTADO,              VP_NUM_SERIEMEC, VP_COD_HOLDING,
          VP_COD_EMPRESA,        VP_COD_GRPSERV,         VP_IND_SUPERTEL,         VP_NUM_TELEFIJA,                VP_COD_OPREDFIJA, VP_COD_CARRIER,
          VP_IND_PREPAGO,        VP_IND_PLEXSYS,         VP_COD_CENTRAL_PLEX, VP_NUM_CELULAR_PLEX,
          VP_NUM_VENTA,          VP_COD_MODVENTA,        VP_COD_TIPCONTRATO,  VP_NUM_CONTRATO,        VP_NUM_ANEXO, VP_FEC_CUMPLAN,
          VP_COD_CREDMOR,        VP_COD_CREDCON,         VP_COD_CICLO,            VP_IND_FACTUR,                  VP_IND_SUSPEN, VP_IND_REHABI, VP_IND_INSGUIAS,
          VP_FEC_FINCONTRA,  VP_FEC_RECDOCUM,    VP_FEC_CUMPLIMEN,        VP_FEC_ACEPVENTA,       VP_FEC_ACTCEN, VP_FEC_BAJA,
          VP_FEC_BAJACEN,        VP_FEC_ULTMOD,          VP_COD_CAUSABAJA,        VP_NUM_PERSONAL,                VP_IND_SEGURO,
          VP_CLASE_SERVICIO, VP_PERFIL_ABONADO,  VP_NUM_MIN,              VP_COD_VENDEALER,       VP_IND_DISP, VP_COD_PASSWORD,
          VP_IND_PASSWORD,       VP_COD_AFINIDAD,        VP_COD_TECNOLOGIA,   VP_NUM_IMEI,                        VP_NUM_MIN_MDN, VP_FEC_ACTIVACION, VP_IND_TELEFONO
     FROM GA_ABOAMIST
     WHERE NUM_CELULAR = VP_NUM_CELULAR
    -- Inicio Modificación - GBM - 23-02-2005 - TM-200502161273
        --AND COD_SITUACION IN ('AAA','SAA');
        AND COD_SITUACION IN ('AAA','SAA','RTP','STP');
    -- Fin Modificación - GBM - 23-02-2005 - TM-200502161273


   EXCEPTION
          WHEN OTHERS THEN
           VP_SQLCODE := SUBSTR(SQLCODE,1,15);
           VP_SQLERRM := SUBSTR(SQLERRM,1,60);
           VP_ERROR := '4';

   END;
   WHEN OTHERS THEN
           VP_SQLCODE := SUBSTR(SQLCODE,1,15);
           VP_SQLERRM := SUBSTR(SQLERRM,1,60);
           VP_ERROR := '4';

END;

-----------------------------------------------------------------------

PROCEDURE PV_PARAMETROS_OOSS_PR(EV_cod_ooss  IN VARCHAR2,
                        SV_descripcion OUT VARCHAR2,
                        SN_tip_procesa OUT NUMBER,
                        SV_cod_modgener OUT VARCHAR2,
                        SV_des_estadoc OUT VARCHAR2,
                        SV_error OUT VARCHAR2,
                        SV_proc  OUT VARCHAR2,
                        SV_tabla OUT VARCHAR2,
                        SV_act    OUT VARCHAR2,
                        SV_sqlcode OUT VARCHAR2,
                        SV_sqlerrm OUT VARCHAR2
)

IS
        BEGIN

                SV_error:='0';
                SV_proc := 'PV_LISTA_PARAMETROS_OOSS_PR';

                SV_act := 'S';
                SV_tabla := 'CI_TIPORSERV';
                SELECT   descripcion
                           , tip_procesa
                           , cod_modgener
                INTO     SV_descripcion
                           , SN_tip_procesa
                           , SV_cod_modgener
                FROM   CI_TIPORSERV
                WHERE cod_os = EV_cod_ooss;

                SV_tabla := 'FA_INTESTADOC';
                SELECT des_estadoc
                INTO   SV_des_estadoc
                FROM   FA_INTESTADOC
                WHERE  cod_aplic = 'PVA'
                AND    cod_estadoc = 10;

        EXCEPTION

                WHEN OTHERS THEN
                SV_error := 4;
                SV_sqlcode := SQLCODE;
                SV_sqlerrm := SQLERRM;

END PV_PARAMETROS_OOSS_PR;

--------------------------------------------------------

PROCEDURE PV_INSCRIBE_OOSS_PR(						  EN_num_celular        IN  NUMBER,
                                                      EN_cod_ooss               IN  VARCHAR2,
                                                      EV_usuario                    IN  VARCHAR2,
                                                      GN_secuencia          IN  NUMBER,
                                                      EN_modgener           IN  VARCHAR2,
													  EN_cod_actabo             IN  VARCHAR2,
													  EN_num_abonado            IN  NUMBER,
													  EN_cod_producto       IN  NUMBER,
													  EN_ind_central_ss     IN  PV_CAMCOM.IND_CENTRAL_SS%TYPE,--NUMBER,
													  EN_tip_terminal               IN  VARCHAR,
													  EV_tip_susp_avsinie   IN  PV_CAMCOM.TIP_SUSP_AVSINIE%TYPE,
													  EN_causa_sinie                IN  NUMBER,
                                                      EN_num_venta                  IN  PV_CAMCOM.NUM_VENTA%TYPE,--NUMBER
													  EN_num_transaccion    IN  PV_CAMCOM.NUM_TRANSACCION%TYPE,--NUMBER
													  EN_num_folio                  IN  PV_CAMCOM.NUM_FOLIO%TYPE,--NUMBER
													  EN_num_cuotas                 IN  PV_CAMCOM.NUM_CUOTAS%TYPE,--NUMBER
													  EN_num_proceso            IN  PV_CAMCOM.NUM_PROCESO%TYPE,--NUMBER
													  EV_fh_anula               IN  PV_CAMCOM.FH_ANULA%TYPE,--VARCHAR2
													  EV_cat_tribut                 IN  PV_CAMCOM.CAT_TRIBUT%TYPE,--VARCHAR2
													  EN_cod_estadoc            IN  PV_CAMCOM.COD_ESTADOC%TYPE,--NUMBER
													  EV_cod_causaelim              IN  PV_CAMCOM.COD_CAUSAELIM%TYPE,--VARCHAR2
													  EV_fec_vencimiento    IN  PV_CAMCOM.FEC_VENCIMIENTO%TYPE,--VARCHAR2
													  EV_clase_servicio_act IN  PV_CAMCOM.CLASE_SERVICIO_ACT%TYPE,--VARCHAR2
													  EV_clase_servicio_des IN  PV_CAMCOM.CLASE_SERVICIO_DES%TYPE,--VARCHAR2
													  EN_ind_portable               IN  PV_CAMCOM.IND_PORTABLE%TYPE,--NUMBER
													  EV_pref_plaza             IN  PV_CAMCOM.PREF_PLAZA%TYPE,--VARCHAR2
													  EN_cod_cuenta             IN  PV_CAMCOM.COD_CUENTA%TYPE,--NUMBER
													  SV_descripcion                IN  VARCHAR2,
													  SN_tip_procesa                IN  NUMBER,
													  SV_cod_modgener           IN  VARCHAR2,
													  SV_des_estadoc                IN  VARCHAR2,
													  EN_ind_estado             IN  PV_MOVIMIENTOS.IND_ESTADO%TYPE,
													  SN_imp_total              IN  PV_MOVIMIENTOS.CARGA%TYPE,
													  SV_error                         OUT  VARCHAR2,
													  SV_proc                          OUT  VARCHAR2,
													  SV_tabla                         OUT  VARCHAR2,
													  SV_act                           OUT  VARCHAR2,
													  SV_sqlcode               OUT  VARCHAR2,
													  SV_sqlerrm               OUT  VARCHAR2
)
/*
<DOC>
<NOMBRE>      PV_INSCRIBE_OOSS_PR                                      </NOMBRE>
<FECHACREA>                                                            </FECHACREA>
<MODULO>                                                                                   </MODULO>
<AUTOR>       Héctor Pérez Guzmán                                      </AUTOR>
<VERSION>     1.0.0                                                    </VERSION>
<DESCRIPCION> Ejecuta funciones de inscripcion de OOSS batch           </DESCRIPCION>
<FECHAMOD>    21-09-2004                                               </FECHAMOD>
<DESCMOD>     Consultar todos los tipos de articulos en SCL            </DESCMOD>
<ParamSal>    tTipArticulo: Cursor de Tipos de Articulos               </ParamSal>
<ParamSal>    ERRORCOD: Codgio Error Clasificado                       </ParamSal>
<ParamSal>    ERRORNEG: Descripcion Error Negocio                      </ParamSal>
<ParamSal>    ERRORSEV: Estado Error PL                                </ParamSal>
<ParamSal>    NEVENTO: Numero de Evento en Modelo de Error Tecnologia  </ParamSal>
<ParamSal>    ERRORDES: Traza Error y Descripcion Error Oracle         </ParamSal>
</DOC>
*/
IS
        GV_implimcons             NUMBER(14,4);
        GN_num_abonado            GA_ABOCEL.NUM_ABONADO%TYPE;
        GV_cod_cliente            GA_ABOCEL.COD_CLIENTE%TYPE;
        GV_bdatos                 VARCHAR2(16);
        SV_cod_servicio           PV_SERV_SUSPREHA_TO.COD_SERVICIO%TYPE;
        GV_tip_plantarif          GA_ABOCEL.TIP_PLANTARIF%TYPE;
        GV_cod_plantarif          GA_ABOCEL.COD_PLANTARIF%TYPE;
        GV_num_seriehex           GA_ABOCEL.NUM_SERIEHEX%TYPE;
        GN_cod_cliclo             GA_ABOCEL.COD_CICLO%TYPE;

        GV_comentario             PV_PARAM_ABOCEL.OBS_DETALLE%TYPE;

        BEGIN

                SV_error:='0';
                SV_proc := 'PV_INSCRIBE_OOSS_PR';

                GV_comentario := 'OOSS - PLATAFORMA EXTERNA';



                PV_GENERAL_OOSS_PG.PV_DATOS_ABONADO_PR (EN_num_celular,GV_implimcons,SV_PROC,SV_TABLA,SV_ACT,SV_SQLCODE,SV_SQLERRM,SV_ERROR);
                GN_num_abonado    := PV_GENERAL_OOSS_PG.VP_NUM_ABONADO;
                GV_cod_cliente    := PV_GENERAL_OOSS_PG.VP_COD_CLIENTE;
                GV_tip_plantarif  := PV_GENERAL_OOSS_PG.VP_TIP_PLANTARIF;
                GV_cod_plantarif  := PV_GENERAL_OOSS_PG.VP_COD_PLANTARIF;
                GV_num_seriehex   := PV_GENERAL_OOSS_PG.VP_NUM_SERIEHEX;
                GN_cod_cliclo     := PV_GENERAL_OOSS_PG.VP_COD_CICLO;

                SV_tabla := 'V$DATABASE';
                SV_act := 'S';
                SELECT instance_name
                INTO gv_bdatos
                FROM v$instance;

        IF PV_GENERAL_OOSS_PG.PV_INS_IORSERV_FN(GN_secuencia, EN_cod_ooss, SV_descripcion, EN_cod_producto, EV_usuario, SN_tip_procesa, EN_modgener,SV_error, SV_proc, SV_tabla, SV_act, SV_sqlcode, SV_sqlerrm) THEN
                   IF PV_GENERAL_OOSS_PG.PV_INS_ERECORRIDO_FN(GN_secuencia, SV_des_estadoc,SV_error, SV_proc, SV_tabla, SV_act, SV_sqlcode, SV_sqlerrm) THEN
                          IF PV_GENERAL_OOSS_PG.PV_INS_MOVIMIENTOS_FN(GN_secuencia, EN_cod_actabo, EN_ind_estado, SN_imp_total, SV_error, SV_proc, SV_tabla, SV_act, SV_sqlcode, SV_sqlerrm) THEN
                             IF PV_GENERAL_OOSS_PG.PV_INS_CAMCOM_FN(GN_secuencia, GN_num_abonado, EN_num_celular, GV_cod_cliente, EN_cod_cuenta, EN_cod_producto, GV_bdatos, EN_num_venta, EN_num_transaccion, EN_num_folio, EN_num_cuotas, EN_num_proceso, EN_cod_actabo, EV_fh_anula,  EV_cat_tribut, EN_cod_estadoc, EV_cod_causaelim, EV_fec_vencimiento, EV_clase_servicio_act, EV_clase_servicio_des, EN_ind_central_ss, EN_ind_portable, EN_tip_terminal, EV_tip_susp_avsinie, EV_pref_plaza, SV_error, SV_proc, SV_tabla, SV_act, SV_sqlcode, SV_sqlerrm) THEN
                                    IF PV_GENERAL_OOSS_PG.PV_RECUPERA_CODIGO_SERVICIO_FN(EN_num_celular, SV_cod_servicio, SV_error, SV_proc, SV_tabla , SV_act, SV_sqlcode, SV_sqlerrm) THEN
                                           IF PV_GENERAL_OOSS_PG.PV_INS_PARAM_ABOCEL_FN(GN_secuencia, GN_num_abonado, EN_cod_actabo, EV_usuario, EN_num_celular, GV_tip_plantarif, EN_tip_terminal, GV_cod_plantarif, GV_num_seriehex, GN_cod_cliclo, EN_causa_sinie, SV_cod_servicio, GV_comentario,  SV_error, SV_proc, SV_tabla, SV_act, SV_sqlcode, SV_sqlerrm) THEN
                                                  IF PV_GENERAL_OOSS_PG.PV_UPD_FIN_REGISTRO_FN(GN_secuencia, SV_des_estadoc, SV_error, SV_proc, SV_tabla, SV_act, SV_sqlcode, SV_sqlerrm) THEN
                                                          SV_error := 0;
                                                  END IF;
                                           END IF;
                                    END IF;
                             END IF;
                          END IF;
                   END IF;
            END IF;


        EXCEPTION

                WHEN OTHERS THEN
                SV_error := 4;
                SV_sqlcode := SQLCODE;
                SV_sqlerrm := SQLERRM;

END PV_INSCRIBE_OOSS_PR;

--------------------------------------------------------

FUNCTION PV_INS_IORSERV_FN(EN_Num_Os        IN PV_IORSERV.NUM_OS%TYPE,  --NUMBER
                                                EV_cod_Os                IN PV_IORSERV.COD_OS%TYPE,         --VARCHAR2,
                                                EV_descripcion   IN PV_IORSERV.DESCRIPCION%TYPE,--VARCHAR2,
                                                EN_producto      IN PV_IORSERV.PRODUCTO%TYPE,   --NUMBER,
                                                EV_usuario               IN PV_IORSERV.USUARIO%TYPE,    --VARCHAR2,
                                                EN_tip_Procesa   IN PV_IORSERV.TIP_PROCESA%TYPE,--NUMBER,
                                                EV_cod_Modgener  IN PV_IORSERV.COD_MODGENER%TYPE,--VARCHAR2,
                                                SV_error                 OUT VARCHAR2,
                                                SV_proc                  OUT VARCHAR2,
                                                SV_tabla                 OUT VARCHAR2,
                                                SV_act                   OUT VARCHAR2,
                                                SV_sqlcode               OUT VARCHAR2,
                                                SV_sqlerrm               OUT VARCHAR2
) RETURN BOOLEAN


IS
    LV_secuencia VARCHAR2(10);
        LV_comentario PV_IORSERV.COMENTARIO%TYPE;
        LN_estado_ini  PV_IORSERV.COD_ESTADO%TYPE;

        BEGIN

                SV_error:='0';
                SV_proc := 'PV_LISTA_PARAMETROS_OOSS_PR';
                LV_comentario := 'OOSS - PLATAFORMA EXTERNA';
                LN_estado_ini := 10;

                SV_act := 'I';
                SV_tabla := 'PV_IORSERV';

                --LV_secuencia:= CI_SEQ_NUMOS.NEXTVAL;

                INSERT INTO PV_IORSERV(Num_Os
                   , cod_Os
                   , num_Ospadre
                   , descripcion
                   , fecha_Ing
                   , producto
                       , usuario
                       , status
                       , tip_Procesa
                       , cod_Estado
                       , cod_Modgener
                           , num_osf
                       , tip_Sujeto
                       , comentario
                           )
                           VALUES(EN_Num_Os
                   , EV_cod_Os
                   , NULL
                   , EV_descripcion
                   , SYSDATE
                   , EN_producto
                       , EV_usuario
                       , 'EN PROCESO'
                       , EN_tip_Procesa
                       , LN_estado_ini
                       , EV_cod_Modgener
                       , 0-- num_Osf
                       , 'A'-- abonado
                       , LV_comentario
                           );


                 RETURN TRUE;

        EXCEPTION

                WHEN OTHERS THEN

                        SV_error := 4;
                        SV_sqlcode := SQLCODE;
                        SV_sqlerrm := SQLERRM;
                        RETURN FALSE;

END PV_INS_IORSERV_FN;
--------------------------------------------------------

FUNCTION PV_INS_ERECORRIDO_FN (EN_Num_Os      IN PV_ERECORRIDO.NUM_OS%TYPE--VARCHAR2
                                                        , EN_des_estado IN PV_ERECORRIDO.DESCRIPCION%TYPE--VARCHAR2
                                                        , SV_error              OUT VARCHAR2
                                                        , SV_proc               OUT VARCHAR2
                                                        , SV_tabla              OUT VARCHAR2
                                                        , SV_act                OUT VARCHAR2
                                                        , SV_sqlcode    OUT VARCHAR2
                                                        , SV_sqlerrm    OUT VARCHAR2
)RETURN BOOLEAN

IS
  GN_estado_ini PV_ERECORRIDO.COD_ESTADO%TYPE;

BEGIN


        SV_error:= '0';
        SV_proc := 'PV_INS_ERECORRIDO_FN';
        SV_act  := 'I';
        SV_tabla := 'PV_ERECORRIDO';

        GN_estado_ini := 10;

        INSERT INTO PV_ERECORRIDO(num_os
                        ,cod_estado
                        ,descripcion
                        ,tip_estado
                        ,fec_ingestado)
                        VALUES (EN_Num_Os
                        , GN_estado_ini
                        , EN_des_estado
                        , 1
                        , SYSDATE
                        );

        RETURN TRUE;

EXCEPTION
     WHEN OTHERS THEN
                  SV_error:= '4';
                  SV_sqlcode := SQLCODE;
                  SV_sqlerrm := SQLERRM;
                  RETURN FALSE;
END PV_INS_ERECORRIDO_FN;
------------------------------------------------------------------------

FUNCTION PV_INS_MOVIMIENTOS_FN (EV_secuencia  IN PV_MOVIMIENTOS.NUM_OS%TYPE                      --VARCHAR2
                                                        , EN_actabo     IN PV_MOVIMIENTOS.COD_ACTABO%TYPE                --VARCHAR2
                                                        , EN_ind_estado IN PV_MOVIMIENTOS.IND_ESTADO%TYPE                --NUMBER
                                                        , EN_carga              IN PV_MOVIMIENTOS.CARGA%TYPE                     --NUMBER
                                                        , SV_error              OUT VARCHAR2
                                                        , SV_proc               OUT VARCHAR2
                                                        , SV_tabla              OUT VARCHAR2
                                                        , SV_act                OUT VARCHAR2
                                                        , SV_sqlcode    OUT VARCHAR2
                                                        , SV_sqlerrm    OUT VARCHAR2
)RETURN BOOLEAN
IS
BEGIN

        SV_error:= '0';
        SV_proc := 'PV_INS_MOVIMIENTOS_FN';
        SV_act  := 'I';
        SV_tabla := 'PV_MOVIMIENTOS';

        INSERT INTO PV_MOVIMIENTOS(num_os
           , ord_comando
           , cod_actabo
           , ind_estado
                   , carga
                   , cod_estado)
                   VALUES(EV_secuencia
                   , 1
                   , EN_actabo
                   , EN_ind_estado
                   , EN_carga
                   , 0
                   );

        RETURN TRUE;

EXCEPTION
     WHEN OTHERS THEN
                  SV_error:= '4';
                  SV_sqlcode := SQLCODE;
                  SV_sqlerrm := SQLERRM;
                  RETURN FALSE;
END PV_INS_MOVIMIENTOS_FN;

------------------------------------------------------

FUNCTION PV_INS_PARAM_ABOCEL_FN (EV_secuencia  IN PV_PARAM_ABOCEL.NUM_OS%TYPE--VARCHAR2
                                                        , EV_num_abonado        IN PV_PARAM_ABOCEL.NUM_ABONADO%TYPE--VARCHAR2
                                                        , EV_actabo             IN PV_PARAM_ABOCEL.COD_TIPMODI%TYPE--VARCHAR2
                                                        , EV_usuario            IN PV_PARAM_ABOCEL.NUOM_USUARORA%TYPE --VARCHAR2
                                                        , EN_celular            IN PV_PARAM_ABOCEL.NUM_CELULAR%TYPE       --NUMBER
                                                        , EV_tip_plantarif              IN PV_PARAM_ABOCEL.TIP_PLANTARIF%TYPE--VARCHAR2
                                                        , EV_tip_terminal               IN PV_PARAM_ABOCEL.TIP_TERMINAL%TYPE--VARCHAR2
                                                        , EV_cod_plantarif              IN PV_PARAM_ABOCEL.COD_PLANTARIF%TYPE --VARCHAR2
                                                        , EV_num_seriehex               IN PV_PARAM_ABOCEL.NUM_SERIEHEX%TYPE--VARCHAR2
                                                        , EN_cod_ciclo                  IN PV_PARAM_ABOCEL.COD_CICLO%TYPE--NUMBER
                                                        , EV_cod_causa                  IN PV_PARAM_ABOCEL.COD_CAUSA%TYPE--VARCHAR2
                                                        , EV_cod_servicio               IN PV_PARAM_ABOCEL.COD_SERVICIO%TYPE--VARCHAR2
                                                        , EV_observacion                IN PV_PARAM_ABOCEL.OBS_DETALLE%TYPE
                                                        --, EV_desvio_numero              IN PV_CAMCOM.PREF_PLAZA%TYPE--VARCHAR2
                                                        , SV_error              OUT VARCHAR2
                                                        , SV_proc               OUT VARCHAR2
                                                        , SV_tabla              OUT VARCHAR2
                                                        , SV_act                OUT VARCHAR2
                                                        , SV_sqlcode    OUT VARCHAR2
                                                        , SV_sqlerrm    OUT VARCHAR2
)RETURN BOOLEAN
IS
BEGIN

        SV_error:= '0';
        SV_proc := 'PV_INS_PARAM_ABOCEL_PR';
        SV_act  := 'I';
        SV_tabla := 'PV_PARAM_ABOCEL';
        

        INSERT INTO PV_PARAM_ABOCEL(num_os
         , num_abonado
         , cod_tipmodi
         , fec_modifica
         , nuom_usuarora
         , num_celular
         , tip_plantarif
         , tip_terminal
         , cod_plantarif
         , num_seriehex
         , cod_ciclo
         , cod_causa
         , cod_servicio
         , obs_detalle
                 )
                 VALUES(EV_secuencia
                 , EV_num_abonado
                 , EV_actabo
                 , SYSDATE
                 , EV_usuario
                 , EN_celular
                 , EV_tip_plantarif
                 , EV_tip_terminal
                 , EV_cod_plantarif
                 , EV_num_seriehex
                 , EN_cod_ciclo
                 , EV_cod_causa
                 , EV_cod_servicio
                 , EV_observacion
                 );


        RETURN TRUE;

EXCEPTION
     WHEN OTHERS THEN
                  SV_error:= '4';
                  SV_sqlcode := SQLCODE;
                  SV_sqlerrm := SQLERRM;
                  RETURN FALSE;
END PV_INS_PARAM_ABOCEL_FN;

--------------------------------------------------------------------------------

FUNCTION PV_INS_CAMCOM_FN (   EV_secuencia                  IN PV_CAMCOM.NUM_OS%TYPE--VARCHAR2
                                                        , EV_num_abonado            IN PV_CAMCOM.NUM_ABONADO%TYPE--VARCHAR2
                                                        , EN_celular                IN PV_CAMCOM.NUM_CELULAR%TYPE--NUMBER
                                                        , EN_cod_cliente            IN PV_CAMCOM.COD_CLIENTE%TYPE--NUMBER
                                                        , EN_cod_cuenta             IN PV_CAMCOM.COD_CUENTA%TYPE--NUMBER
                                                        , EN_cod_producto           IN PV_CAMCOM.COD_PRODUCTO%TYPE--NUMBER
                                                        , EV_bdatos                         IN PV_CAMCOM.BDATOS%TYPE--VARCHAR2
                                                        , EN_num_venta              IN PV_CAMCOM.NUM_VENTA%TYPE--NUMBER
                                                        , EN_num_transaccion    IN PV_CAMCOM.NUM_TRANSACCION%TYPE--NUMBER
                                                        , EN_num_folio              IN PV_CAMCOM.NUM_FOLIO%TYPE--NUMBER
                                                        , EN_num_cuotas             IN PV_CAMCOM.NUM_CUOTAS%TYPE--NUMBER
                                                , EN_num_proceso            IN PV_CAMCOM.NUM_PROCESO%TYPE--NUMBER
                                                , EV_cod_actabo             IN PV_CAMCOM.COD_ACTABO%TYPE--VARCHAR2
                                                , EV_fh_anula               IN PV_CAMCOM.FH_ANULA%TYPE--VARCHAR2
                                                , EV_cat_tribut             IN PV_CAMCOM.CAT_TRIBUT%TYPE--VARCHAR2
                                                , EN_cod_estadoc            IN PV_CAMCOM.COD_ESTADOC%TYPE--NUMBER
                                                , EV_cod_causaelim          IN PV_CAMCOM.COD_CAUSAELIM%TYPE--VARCHAR2
                                                , EV_fec_vencimiento    IN PV_CAMCOM.FEC_VENCIMIENTO%TYPE--VARCHAR2
                                                , EV_clase_servicio_act IN PV_CAMCOM.CLASE_SERVICIO_ACT%TYPE--VARCHAR2
                                                , EV_clase_servicio_des IN PV_CAMCOM.CLASE_SERVICIO_DES%TYPE--VARCHAR2
                                                , EN_ind_central_ss             IN PV_CAMCOM.IND_CENTRAL_SS%TYPE--NUMBER
                                                , EN_ind_portable               IN PV_CAMCOM.IND_PORTABLE%TYPE--NUMBER
                                                , EN_tip_terminal               IN PV_CAMCOM.TIP_TERMINAL%TYPE--VARCHAR2
                                                , EV_tip_susp_avsinie   IN PV_CAMCOM.TIP_SUSP_AVSINIE%TYPE--VARCHAR2
                                                , EV_pref_plaza                 IN PV_CAMCOM.PREF_PLAZA%TYPE--VARCHAR2
                                                        , SV_error              OUT VARCHAR2
                                                        , SV_proc               OUT VARCHAR2
                                                        , SV_tabla              OUT VARCHAR2
                                                        , SV_act                OUT VARCHAR2
                                                        , SV_sqlcode    OUT VARCHAR2
                                                        , SV_sqlerrm    OUT VARCHAR2
)RETURN BOOLEAN
IS
BEGIN

        SV_error:= '0';
        SV_proc := 'PV_INS_CAMCOM_FN';
        SV_act  := 'I';
        SV_tabla := 'PV_CAMCOM';

        INSERT INTO PV_CAMCOM(num_os
              , num_abonado
              , num_celular
              , cod_cliente
              , cod_cuenta
              , cod_producto
              , bdatos
              , num_venta
              , num_transaccion
              , num_folio
              , num_cuotas
              , num_proceso
              , cod_actabo
              , fh_anula
              , cat_tribut
              , cod_estadoc
              , cod_causaelim
              , fec_vencimiento
              , clase_servicio_act
              , clase_servicio_des
              , ind_central_ss
              , ind_portable
              , tip_terminal
              , tip_susp_avsinie
              , pref_plaza)
                  VALUES(EV_secuencia
                  , EV_num_abonado
                  , EN_celular
                  , EN_cod_cliente
                  , EN_cod_cuenta
                  , EN_cod_producto
                  , EV_bdatos
                  , EN_num_venta
                  , EN_num_transaccion
                  , EN_num_folio
                  , EN_num_cuotas
                  , EN_num_proceso
              , EV_cod_actabo
              , EV_fh_anula
              , EV_cat_tribut
              , EN_cod_estadoc
              , EV_cod_causaelim
              , EV_fec_vencimiento
              , EV_clase_servicio_act
              , EV_clase_servicio_des
              , EN_ind_central_ss
              , EN_ind_portable
              , EN_tip_terminal
              , EV_tip_susp_avsinie
              , EV_pref_plaza
                  );

        RETURN TRUE;

EXCEPTION
     WHEN OTHERS THEN
                  SV_error:= '4';
                  SV_sqlcode := SQLCODE;
                  SV_sqlerrm := SQLERRM;
                  RETURN FALSE;
END PV_INS_CAMCOM_FN;

------------------------------------------------------------------

FUNCTION PV_RECUPERA_CODIGO_SERVICIO_FN(EN_num_celular IN NUMBER,
                                                                                SV_cod_servicio    OUT VARCHAR2,
                                                                                SV_error                   OUT VARCHAR2,
                                                                                SV_proc                    OUT VARCHAR2,
                                                                                SV_tabla                   OUT VARCHAR2,
                                                                                SV_act                     OUT VARCHAR2,
                                                                                SV_sqlcode                 OUT VARCHAR2,
                                                                                SV_sqlerrm                 OUT VARCHAR2

)RETURN BOOLEAN
/*
<DOC>
<NOMBRE>      PV_RECUPERA_CODIGO_SERVICIO_FN                         </NOMBRE>
<FECHACREA>   13/10/2004                                         </FECHACREA>
<MODULO>      POSTVENTA                                          </MODULO>
<AUTOR>       Hector Perez Guzman                                </AUTOR>
<VERSION>     1.0.0                                              </VERSION>
<DESCRIPCION> </DESCRIPCION>
<FECHAMOD>                                                           </FECHAMOD>
<DESCMOD>                                                                                                        </DESCMOD>
<ParamEntr>             </ParamEntr>
<ParamSal>           </ParamSal>
<ParamSal>    SV_error: Codgio Error Controlado                  </ParamSal>
<ParamSal>    SV_proc: Nombre Procedimiento                      </ParamSal>
<ParamSal>    SV_tabla: Nombre Tabla                             </ParamSal>
<ParamSal>    SV_act: Accion Efectuada sobre la Tabla            </ParamSal>
<ParamSal>    SV_sqlcode: Codigo Error Oracle                           </ParamSal>
<ParamSal>    SV_sqlerrm: Mensaje Error Oracle                           </ParamSal>
</DOC>
*/
IS

        GV_cod_plantarif          GA_ABOCEL.COD_PLANTARIF%TYPE;
        GV_cod_tecnologia         GA_ABOCEL.COD_TECNOLOGIA%TYPE;
        GV_implimcons             NUMBER(14,4);
        SV_cod_servicio_aux   PV_SERV_SUSPREHA_TO.COD_SERVICIO%TYPE;
        BEGIN



                SV_error:='0';
                SV_proc := 'PV_RECUPERA_CODIGO_SERVICIO_FN';

                SV_act := 'S';
                SV_tabla := 'PV_IORSERV';

                PV_GENERAL_OOSS_PG.PV_DATOS_ABONADO_PR (EN_num_celular,GV_implimcons,SV_PROC,SV_TABLA,SV_ACT,SV_SQLCODE,SV_SQLERRM,SV_ERROR);
            GV_cod_plantarif :=  PV_GENERAL_OOSS_PG.VP_COD_PLANTARIF;
                GV_cod_tecnologia := PV_GENERAL_OOSS_PG.VP_COD_TECNOLOGIA;

                SELECT a.cod_servicio
                INTO   SV_cod_servicio_aux
                FROM   PV_SERV_SUSPREHA_TO a
                WHERE  a.cod_producto = 1
                AND    a.cod_modulo = CV_cod_modulo
                AND EXISTS (SELECT b.cod_tiplan
                                    FROM TA_PLANTARIF b
                            WHERE b.cod_producto = CN_cod_producto
                            AND   b.cod_plantarif = GV_cod_plantarif
                            AND   a.cod_tiplan = b.cod_tiplan)
                AND a.cod_tecnologia = GV_cod_tecnologia
                AND a.cod_actabo = CV_cod_actabo;

                SV_cod_servicio:= SV_cod_servicio_aux;
                RETURN TRUE;
        EXCEPTION
                WHEN OTHERS THEN
                         SV_error := 4;
                         SV_sqlcode := SQLCODE;
                         SV_sqlerrm := SQLERRM;
                         RETURN FALSE;
END PV_RECUPERA_CODIGO_SERVICIO_FN;

--------------------------------------------------------------------------------

FUNCTION PV_UPD_FIN_REGISTRO_FN (EN_Num_Os      IN PV_ERECORRIDO.NUM_OS%TYPE      --VARCHAR2
                                                        , EV_des_estadoc        IN PV_ERECORRIDO.DESCRIPCION%TYPE --VARCHAR2
                                                        , SV_error                      OUT VARCHAR2
                                                        , SV_proc                       OUT VARCHAR2
                                                        , SV_tabla                      OUT VARCHAR2
                                                        , SV_act                        OUT VARCHAR2
                                                        , SV_sqlcode            OUT VARCHAR2
                                                        , SV_sqlerrm            OUT VARCHAR2

)RETURN BOOLEAN
IS
BEGIN

        SV_error:= '0';
        SV_proc := 'PV_UPD_FIN_REGISTRO_FN';
        SV_act  := 'U';
        SV_tabla := 'PV_IORSERV';

        UPDATE PV_IORSERV SET
            STATUS = 'Proceso exitoso'
        WHERE NUM_OS = EN_Num_Os;


        SV_tabla := 'PV_ERECORRIDO';
        UPDATE PV_ERECORRIDO SET
             Descripcion = EV_des_estadoc
           , tip_estado = 3
        WHERE  NUM_OS = EN_Num_Os;

        RETURN TRUE;

EXCEPTION
     WHEN OTHERS THEN
                  SV_error:= '4';
                  SV_sqlcode := SQLCODE;
                  SV_sqlerrm := SQLERRM;
                  RETURN FALSE;
END PV_UPD_FIN_REGISTRO_FN;

--------------------------------------------------------------------------------

FUNCTION PV_VAL_LARGO_CELULAR_FN (EN_num_celular  IN NUMBER
                                        , SV_error       OUT VARCHAR2
                                        , SV_proc        OUT VARCHAR2
                                        , SV_tabla       OUT VARCHAR2
                                        , SV_act         OUT VARCHAR2
                                        , SV_sqlcode OUT VARCHAR2
                                        , SV_sqlerrm OUT VARCHAR2
)RETURN BOOLEAN

IS
    GN_largo_celular VARCHAR2(20);
BEGIN

        SV_error:= '0';
        SV_proc := 'PV_VAL_LARGO_CELULAR_FN';



        SV_act  := 'S';
        SV_tabla := 'GED_PARAMETROS';
        SELECT val_parametro
        INTO  GN_largo_celular
        FROM GED_PARAMETROS
        WHERE nom_parametro = 'LARGO_N_CELULAR';

        IF LENGTH(EN_num_celular) <> GN_largo_celular THEN
           SV_error:= '4';
           SV_sqlerrm := 'CELULAR NO CUMPLE CON LARGO DEFINIDO POR OPERADORA';
           RETURN FALSE;
        ELSE
                RETURN TRUE;
        END IF;

EXCEPTION
     WHEN OTHERS THEN
                  SV_error:= '4';
                  SV_sqlcode := SQLCODE;
                  SV_sqlerrm := SQLERRM;
                  RETURN FALSE;
END PV_VAL_LARGO_CELULAR_FN;

------------------------------------------------------------------------

FUNCTION PV_REG_CARTA_FN                        (EN_NUM_OOSS         IN CI_ORSERV.NUM_OS%TYPE,
                                                                                 EN_COD_OOSS         IN CI_TIPORSERV.COD_OS%TYPE,
                                                                                 EN_COD_CLIENTE      IN GE_CLIENTES.COD_CLIENTE%TYPE,
                                                                                 EN_NUM_CELULAR          IN GA_ABOCEL.NUM_CELULAR%TYPE,
                                                                                 SV_PROC            OUT VARCHAR2,
                                                                         SV_TABLA           OUT VARCHAR2,
                                                                         SV_ACT             OUT VARCHAR2,
                                                                         SV_SQLCODE         OUT VARCHAR2,
                                                                         SV_SQLERRM         OUT VARCHAR2,
                                                                         SV_ERROR           OUT VARCHAR2) RETURN BOOLEAN
/*
<DOC>
<NOMBRE>      PV_REG_CARTA_FN                       </NOMBRE>
<FECHACREA>   14/10/2004                                         </FECHACREA>
<MODULO>      POSTVENTA                                          </MODULO>
<AUTOR>       Hector Perez Guzman                                </AUTOR>
<VERSION>     1.0.0                                              </VERSION>
<DESCRIPCION>                                                                                                    </DESCRIPCION>
<FECHAMOD>                                                           </FECHAMOD>
<DESCMOD>                                                                                                        </DESCMOD>
<ParamEntr>                                                                                              </ParamEntr>
<ParamSal>                                                                                               </ParamSal>
<ParamSal>    SV_error: Codgio Error Controlado                  </ParamSal>
<ParamSal>    SV_proc: Nombre Procedimiento                      </ParamSal>
<ParamSal>    SV_tabla: Nombre Tabla                             </ParamSal>
<ParamSal>    SV_act: Accion Efectuada sobre la Tabla            </ParamSal>
<ParamSal>    SV_sqlcode: Codigo Error Oracle                    </ParamSal>
<ParamSal>    SV_sqlerrm: Mensaje Error Oracle                   </ParamSal>
</DOC>
*/
IS
  vv_Texto  CI_CARTAS.TEXTO%TYPE;
  vv_Idioma GE_CLIENTES.COD_IDIOMA%TYPE;
BEGIN
           SV_error   := '0';
           SV_proc        := 'PV_REG_CARTA_FN';
           SV_act         := 'I';
           SV_tabla   := 'CI_CARTAS';

           vv_Idioma      := PV_REC_TIP_IDIOMA_FN(EN_COD_CLIENTE,SV_PROC,SV_TABLA,SV_ACT,SV_SQLCODE,SV_SQLERRM,SV_ERROR);
           vv_Texto       := PV_REC_MSG_CARTA_FN(EN_COD_OOSS,vv_Idioma,SV_PROC,SV_TABLA,SV_ACT,SV_SQLCODE,SV_SQLERRM,SV_ERROR);
           vv_Texto               := REPLACE(vv_Texto,'<1>',TO_CHAR(EN_NUM_CELULAR));
           INSERT INTO CI_CARTAS(NUM_OS,FECHA,TEXTO)
                        VALUES(EN_NUM_OOSS,SYSDATE,vv_Texto);

           RETURN TRUE;

           EXCEPTION
                                WHEN OTHERS THEN
                                         SV_error := 4;
                                         SV_sqlcode := SQLCODE;
                                         SV_sqlerrm := SQLERRM;
                                         RETURN FALSE;

END PV_REG_CARTA_FN;


FUNCTION PV_REC_MSG_CARTA_FN            (EN_COD_OOSS         IN CI_TIPORSERV.COD_OS%TYPE,
                                                                                 EN_COD_IDIOMA           IN GE_CLIENTES.COD_IDIOMA%TYPE,
                                                                                 SV_PROC            OUT VARCHAR2,
                                                                         SV_TABLA           OUT VARCHAR2,
                                                                         SV_ACT             OUT VARCHAR2,
                                                                         SV_SQLCODE         OUT VARCHAR2,
                                                                         SV_SQLERRM         OUT VARCHAR2,
                                                                         SV_ERROR           OUT VARCHAR2) RETURN CI_TIPCARTAS.TEXTO%TYPE
/*
<DOC>
<NOMBRE>      PV_REC_MSG_CARTA_FN                      </NOMBRE>
<FECHACREA>   14/10/2004                                         </FECHACREA>
<MODULO>      POSTVENTA                                          </MODULO>
<AUTOR>       Hector Perez Guzman                                </AUTOR>
<VERSION>     1.0.0                                              </VERSION>
<DESCRIPCION>                                                                                                    </DESCRIPCION>
<FECHAMOD>                                                           </FECHAMOD>
<DESCMOD>                                                                                                        </DESCMOD>
<ParamEntr>                                                                                              </ParamEntr>
<ParamSal>                                                                                               </ParamSal>
<ParamSal>    SV_error: Codgio Error Controlado                  </ParamSal>
<ParamSal>    SV_proc: Nombre Procedimiento                      </ParamSal>
<ParamSal>    SV_tabla: Nombre Tabla                             </ParamSal>
<ParamSal>    SV_act: Accion Efectuada sobre la Tabla            </ParamSal>
<ParamSal>    SV_sqlcode: Codigo Error Oracle                    </ParamSal>
<ParamSal>    SV_sqlerrm: Mensaje Error Oracle                   </ParamSal>
</DOC>
*/
IS
  vv_Texto CI_TIPCARTAS.TEXTO%TYPE;
BEGIN
           SV_error   := '0';
           SV_proc        := 'PV_REC_MSG_CARTA_FN';
           SV_act         := 'S';
           SV_tabla   := 'CI_TIPCARTAS';

           SELECT TEXTO
           INTO   vv_Texto
           FROM   CI_TIPCARTAS
           WHERE  COD_OS          = EN_COD_OOSS
             AND  COD_IDIOMA  = EN_COD_IDIOMA;



           RETURN vv_Texto;

           EXCEPTION
                                WHEN OTHERS THEN
                                         SV_error := 4;
                                         SV_sqlcode := SQLCODE;
                                         SV_sqlerrm := SQLERRM;
                                         RETURN '';

END PV_REC_MSG_CARTA_FN;

--------------------------------------------------------------------------------

FUNCTION PV_REC_TIP_IDIOMA_FN           (EN_COD_CLIENTE      IN GE_CLIENTES.COD_CLIENTE%TYPE,
                                                                                 SV_PROC            OUT VARCHAR2,
                                                                         SV_TABLA           OUT VARCHAR2,
                                                                         SV_ACT             OUT VARCHAR2,
                                                                         SV_SQLCODE         OUT VARCHAR2,
                                                                         SV_SQLERRM         OUT VARCHAR2,
                                                                         SV_ERROR           OUT VARCHAR2) RETURN GE_CLIENTES.COD_IDIOMA%TYPE
IS
  vv_Idioma GE_CLIENTES.COD_IDIOMA%TYPE;
BEGIN
           SV_error   := '0';
           SV_proc        := 'PV_REC_TIP_IDIOMA_FN';
           SV_act         := 'S';
           SV_tabla   := 'GE_CLIENTES';

           SELECT COD_IDIOMA
           INTO   vv_Idioma
           FROM   GE_CLIENTES
           WHERE  COD_CLIENTE  = EN_COD_CLIENTE;



           RETURN vv_Idioma;

           EXCEPTION
                                WHEN OTHERS THEN
                                         SV_error := 4;
                                         SV_sqlcode := SQLCODE;
                                         SV_sqlerrm := SQLERRM;
                                         RETURN '';

END PV_REC_TIP_IDIOMA_FN;

--------------------------------------------------------------------------------

FUNCTION PV_EJEC_RESTRICCION_FN         (EV_COD_MODULO           IN VARCHAR2,
                                                                                 EN_COD_PRODUCTO         IN GA_ABOCEL.COD_PRODUCTO%TYPE,
                                                                                 EV_COD_ACTUACION        IN VARCHAR2,
                                                                                 EV_EVENTO                       IN VARCHAR2,
                                                                                 EV_PARAMETRO            IN VARCHAR2,
                                                                                 SV_PROC            OUT VARCHAR2,
                                                                         SV_TABLA           OUT VARCHAR2,
                                                                         SV_ACT             OUT VARCHAR2,
                                                                         SV_SQLCODE         OUT VARCHAR2,
                                                                         SV_SQLERRM         OUT VARCHAR2,
                                                                         SV_ERROR           OUT VARCHAR2) RETURN BOOLEAN
/*
<DOC>
<NOMBRE>      PV_EJEC_RESTRICCION_FN                                     </NOMBRE>
<FECHACREA>   14/10/2004                                         </FECHACREA>
<MODULO>      POSTVENTA                                          </MODULO>
<AUTOR>       Hector Perez Guzman                                </AUTOR>
<VERSION>     1.0.0                                              </VERSION>
<DESCRIPCION>                                                                                                    </DESCRIPCION>
<FECHAMOD>                                                           </FECHAMOD>
<DESCMOD>                                                                                                        </DESCMOD>
<ParamEntr>                                                                                              </ParamEntr>
<ParamSal>                                                                                               </ParamSal>
<ParamSal>    SV_error: Codgio Error Controlado                  </ParamSal>
<ParamSal>    SV_proc: Nombre Procedimiento                      </ParamSal>
<ParamSal>    SV_tabla: Nombre Tabla                             </ParamSal>
<ParamSal>    SV_act: Accion Efectuada sobre la Tabla            </ParamSal>
<ParamSal>    SV_sqlcode: Codigo Error Oracle                    </ParamSal>
<ParamSal>    SV_sqlerrm: Mensaje Error Oracle                   </ParamSal>
</DOC>
*/
IS

   vn_Secuencia  NUMBER(10);
   vn_CodRetorno BOOLEAN;
BEGIN

           SV_error   := '0';
           SV_proc        := 'PV_EJEC_RESTRICCION_FN';
           SV_act         := '';
           SV_tabla   := '';

           SELECT GA_SEQ_TRANSACABO.NEXTVAL
           INTO vn_Secuencia
           FROM DUAL;

           PV_PR_EJECUTA_RESTRICCION (vn_Secuencia,EV_COD_MODULO,EN_COD_PRODUCTO,EV_COD_ACTUACION,EV_EVENTO,EV_PARAMETRO);

           vn_CodRetorno:=PV_GA_TRANSACABO_FN(vn_Secuencia,SV_PROC,SV_TABLA,SV_ACT,SV_SQLCODE,SV_SQLERRM,SV_ERROR);

           RETURN vn_CodRetorno;

           EXCEPTION
                                WHEN OTHERS THEN
                                         SV_error := 4;
                                         SV_sqlcode := SQLCODE;
                                         SV_sqlerrm := SQLERRM;
                                         RETURN FALSE;

END PV_EJEC_RESTRICCION_FN;

--------------------------------------------------------------------------------

FUNCTION PV_GA_TRANSACABO_FN            (EN_NUM_TRANSACCION      IN GA_TRANSACABO.NUM_TRANSACCION%TYPE,
                                                                                 SV_PROC            OUT VARCHAR2,
                                                                         SV_TABLA           OUT VARCHAR2,
                                                                         SV_ACT             OUT VARCHAR2,
                                                                         SV_SQLCODE         OUT VARCHAR2,
                                                                         SV_SQLERRM         OUT VARCHAR2,
                                                                         SV_ERROR           OUT VARCHAR2) RETURN BOOLEAN
/*
<DOC>
<NOMBRE>      PV_GA_TRANSACABO_FN                                        </NOMBRE>
<FECHACREA>   14/10/2004                                         </FECHACREA>
<MODULO>      POSTVENTA                                          </MODULO>
<AUTOR>       Hector Perez Guzman                                </AUTOR>
<VERSION>     1.0.0                                              </VERSION>
<DESCRIPCION>                                                                                                    </DESCRIPCION>
<FECHAMOD>                                                           </FECHAMOD>
<DESCMOD>                                                                                                        </DESCMOD>
<ParamEntr>                                                                                              </ParamEntr>
<ParamSal>                                                                                               </ParamSal>
<ParamSal>    SV_error: Codgio Error Controlado                  </ParamSal>
<ParamSal>    SV_proc: Nombre Procedimiento                      </ParamSal>
<ParamSal>    SV_tabla: Nombre Tabla                             </ParamSal>
<ParamSal>    SV_act: Accion Efectuada sobre la Tabla            </ParamSal>
<ParamSal>    SV_sqlcode: Codigo Error Oracle                    </ParamSal>
<ParamSal>    SV_sqlerrm: Mensaje Error Oracle                   </ParamSal>
</DOC>
*/
IS
   vn_CodRetorno   GA_TRANSACABO.COD_RETORNO%TYPE;
   vv_Descripcion  GA_TRANSACABO.DES_CADENA%TYPE;
BEGIN

           SV_error   := '0';
           SV_proc        := 'PV_GA_TRANSACABO_FN';
           SV_act         := 'S';
           SV_tabla   := 'GA_TRANSACABO';


           SELECT COD_RETORNO,DES_CADENA
           INTO vn_CodRetorno,vv_Descripcion
           FROM GA_TRANSACABO
           WHERE NUM_TRANSACCION = EN_NUM_TRANSACCION;

           IF vn_CodRetorno = 0 THEN
                  RETURN TRUE;
           ELSE
                  SV_SQLERRM :=  vv_Descripcion;
                  RETURN FALSE;
           END IF;

           EXCEPTION
                                WHEN NO_DATA_FOUND THEN
                                         RETURN TRUE;
                                WHEN OTHERS THEN
                                         SV_error := 4;
                                         SV_sqlcode := SQLCODE;
                                         SV_sqlerrm := SQLERRM;
                                         RETURN FALSE;

END PV_GA_TRANSACABO_FN;

--------------------------------------------------------------------------------

FUNCTION PV_GA_ERRORES_FN               (EN_NUM_ABONADO      IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                                                                 EV_COD_ACTABO           IN VARCHAR2,
                                                                                 EN_COD_PRODUCTO         IN GA_ABOCEL.COD_PRODUCTO%TYPE,
                                                                                 SV_ERROR           OUT VARCHAR2,
                                                                                 EV_PROC             IN VARCHAR2,
                                                                         EV_TABLA            IN VARCHAR2,
                                                                         EV_ACT              IN VARCHAR2,
                                                                         EV_SQLCODE          IN VARCHAR2,
                                                                         EV_SQLERRM          IN VARCHAR2,
                                                                         SV_SQLCODE         OUT VARCHAR2,
                                                                         SV_SQLERRM         OUT VARCHAR2) RETURN BOOLEAN
/*
<DOC>
<NOMBRE>      PV_GA_ERRORES_FN                                     </NOMBRE>
<FECHACREA>   14/10/2004                                         </FECHACREA>
<MODULO>      POSTVENTA                                          </MODULO>
<AUTOR>       Hector Perez Guzman                                </AUTOR>
<VERSION>     1.0.0                                              </VERSION>
<DESCRIPCION>                                                                                                    </DESCRIPCION>
<FECHAMOD>                                                           </FECHAMOD>
<DESCMOD>                                                                                                        </DESCMOD>
<ParamEntr>                                                                                              </ParamEntr>
<ParamSal>                                                                                               </ParamSal>
<ParamSal>    SV_error: Codgio Error Controlado                  </ParamSal>
<ParamSal>    SV_proc: Nombre Procedimiento                      </ParamSal>
<ParamSal>    SV_tabla: Nombre Tabla                             </ParamSal>
<ParamSal>    SV_act: Accion Efectuada sobre la Tabla            </ParamSal>
<ParamSal>    SV_sqlcode: Codigo Error Oracle                    </ParamSal>
<ParamSal>    SV_sqlerrm: Mensaje Error Oracle                   </ParamSal>
</DOC>
*/
IS

BEGIN


           INSERT INTO GA_ERRORES (COD_ACTABO,    CODIGO,         FEC_ERROR,  COD_PRODUCTO,    NOM_PROC, NOM_TABLA, COD_ACT,    COD_SQLCODE, COD_SQLERRM)
                       VALUES     (EV_COD_ACTABO, EN_NUM_ABONADO, SYSDATE,    EN_COD_PRODUCTO, EV_PROC,  EV_TABLA,  EV_ACT,     EV_SQLCODE,  substr(EV_SQLERRM,1,60));
           RETURN TRUE;
           EXCEPTION
                                WHEN OTHERS THEN
                                         SV_error := 4;
                                         SV_sqlcode := SQLCODE;
                                         SV_sqlerrm := SQLERRM;
                                         RETURN FALSE;

END PV_GA_ERRORES_FN;

--------------------------------------------------------------------------------

FUNCTION PV_CARGOS_FN           (EN_COD_PRODUCTO         IN GA_ABOCEL.COD_PRODUCTO%TYPE,
                                                                 EV_COD_ACTABO           IN GA_ACTUASERV.COD_ACTABO%TYPE,
                                                                 EV_COD_PLANSERV         IN GA_TARIFAS.COD_PLANSERV%TYPE,
                                                                 SV_COD_CONCEPTO        OUT GA_ACTUASERV.COD_CONCEPTO%TYPE,
                                                                 SV_COD_MONEDA          OUT GA_TARIFAS.COD_MONEDA%TYPE,
                                                                 SN_IMP_TARIFA          OUT GA_TARIFAS.IMP_TARIFA%TYPE,
                                                                 SV_PROC            OUT VARCHAR2,
                                                         SV_TABLA           OUT VARCHAR2,
                                                         SV_ACT             OUT VARCHAR2,
                                                         SV_SQLCODE         OUT VARCHAR2,
                                                         SV_SQLERRM         OUT VARCHAR2,
                                                         SV_ERROR           OUT VARCHAR2) RETURN BOOLEAN
/*
<DOC>
<NOMBRE>      PV_CARGOS_FN                                         </NOMBRE>
<FECHACREA>   14/10/2004                                         </FECHACREA>
<MODULO>      POSTVENTA                                          </MODULO>
<AUTOR>       Hector Perez Guzman                                </AUTOR>
<VERSION>     1.0.0                                              </VERSION>
<DESCRIPCION>                                                                                                    </DESCRIPCION>
<FECHAMOD>                                                           </FECHAMOD>
<DESCMOD>                                                                                                        </DESCMOD>
<ParamEntr>                                                                                              </ParamEntr>
<ParamSal>                                                                                               </ParamSal>
<ParamSal>    SV_error: Codgio Error Controlado                  </ParamSal>
<ParamSal>    SV_proc: Nombre Procedimiento                      </ParamSal>
<ParamSal>    SV_tabla: Nombre Tabla                             </ParamSal>
<ParamSal>    SV_act: Accion Efectuada sobre la Tabla            </ParamSal>
<ParamSal>    SV_sqlcode: Codigo Error Oracle                    </ParamSal>
<ParamSal>    SV_sqlerrm: Mensaje Error Oracle                   </ParamSal>
</DOC>
*/
IS

  vv_CodConcepto  GA_ACTUASERV.COD_CONCEPTO%TYPE;
  vv_CodMoneda    GA_TARIFAS.COD_MONEDA%TYPE;
  vv_ImpTarifa    GA_TARIFAS.IMP_TARIFA%TYPE;

BEGIN

           SV_error   := '0';
           SV_proc        := 'PV_CARGOS_FN';
           SV_act         := 'S';
           SV_tabla   := '';


                SELECT   A.COD_CONCEPTO,
                                 B.COD_MONEDA,
                                 PV_CNV_MONEDAS_FN(A.COD_CONCEPTO,B.COD_MONEDA,B.IMP_TARIFA)
                INTO     vv_CodConcepto,
                                 vv_CodMoneda,
                                 vv_ImpTarifa
                FROM     GA_ACTUASERV A,  GA_TARIFAS B,  GA_SERVICIOS C,  GE_MONEDAS D
                WHERE    A.COD_PRODUCTO = EN_COD_PRODUCTO
                AND      A.COD_ACTABO   = EV_COD_ACTABO
                AND      A.COD_TIPSERV  = 1
                AND      B.COD_PRODUCTO = A.COD_PRODUCTO
                AND      B.COD_ACTABO   = A.COD_ACTABO
                AND      B.COD_TIPSERV  = A.COD_TIPSERV
                AND      B.COD_SERVICIO = A.COD_SERVICIO
                AND      B.COD_PLANSERV = EV_COD_PLANSERV
                AND      SYSDATE BETWEEN B.FEC_DESDE AND  NVL(B.FEC_HASTA, SYSDATE)
                AND      C.COD_PRODUCTO = A.COD_PRODUCTO
                AND      C.COD_SERVICIO = A.COD_SERVICIO
                AND      D.COD_MONEDA   = B.COD_MONEDA --Modificado por Soporte - Alejandro Hott - 25/11/2004
                AND      ROWNUM = 1;  -- Agregado por Soporte - Alejandro Hott - 25/11/2004

                SV_COD_CONCEPTO := vv_CodConcepto;
                SV_COD_MONEDA   := vv_CodMoneda;
                SN_IMP_TARIFA   := vv_ImpTarifa;

           RETURN TRUE;
           EXCEPTION
                                WHEN NO_DATA_FOUND THEN
                                         RETURN FALSE;
                                WHEN OTHERS THEN
                                         SV_ERROR := 4;
                                         SV_SQLCODE := SQLCODE;
                                         SV_SQLERRM := SQLERRM;
                                         RETURN FALSE;
END PV_CARGOS_FN;
--------------------------------------------------------------------------------
FUNCTION PV_CARGOS_SS_FN        (EN_COD_PRODUCTO         IN GA_ABOCEL.COD_PRODUCTO%TYPE,
                                                                 EV_COD_ACTABO           IN GA_ACTUASERV.COD_ACTABO%TYPE,
                                                                 EV_COD_PLANSERV         IN GA_TARIFAS.COD_PLANSERV%TYPE,
                                                                 EV_COD_SERVICIO         IN GA_ACTUASERV.COD_SERVICIO%TYPE,
                                                                 SV_COD_CONCEPTO        OUT GA_ACTUASERV.COD_CONCEPTO%TYPE,
                                                                 SV_COD_MONEDA          OUT GA_TARIFAS.COD_MONEDA%TYPE,
                                                                 SN_IMP_TARIFA          OUT GA_TARIFAS.IMP_TARIFA%TYPE,
                                                                 SV_PROC            OUT VARCHAR2,
                                                         SV_TABLA           OUT VARCHAR2,
                                                         SV_ACT             OUT VARCHAR2,
                                                         SV_SQLCODE         OUT VARCHAR2,
                                                         SV_SQLERRM         OUT VARCHAR2,
                                                         SV_ERROR           OUT VARCHAR2) RETURN BOOLEAN
/*
<DOC>
<NOMBRE>      PV_CARGOS_SS_FN                                      </NOMBRE>
<FECHACREA>   14/10/2004                                         </FECHACREA>
<MODULO>      POSTVENTA                                          </MODULO>
<AUTOR>       Hector Perez Guzman                                </AUTOR>
<VERSION>     1.0.0                                              </VERSION>
<DESCRIPCION>                                                                                                    </DESCRIPCION>
<FECHAMOD>                                                           </FECHAMOD>
<DESCMOD>                                                                                                        </DESCMOD>
<ParamEntr>                                                                                              </ParamEntr>
<ParamSal>                                                                                               </ParamSal>
<ParamSal>    SV_error: Codgio Error Controlado                  </ParamSal>
<ParamSal>    SV_proc: Nombre Procedimiento                      </ParamSal>
<ParamSal>    SV_tabla: Nombre Tabla                             </ParamSal>
<ParamSal>    SV_act: Accion Efectuada sobre la Tabla            </ParamSal>
<ParamSal>    SV_sqlcode: Codigo Error Oracle                    </ParamSal>
<ParamSal>    SV_sqlerrm: Mensaje Error Oracle                   </ParamSal>
</DOC>
*/
IS

  vv_CodConcepto  GA_ACTUASERV.COD_CONCEPTO%TYPE;
  vv_CodMoneda    GA_TARIFAS.COD_MONEDA%TYPE;
  vv_ImpTarifa    GA_TARIFAS.IMP_TARIFA%TYPE;

BEGIN

           SV_error   := '0';
           SV_proc        := 'PV_CARGOS_SS_FN';
           SV_act         := 'S';
           SV_tabla   := '';


                SELECT   A.COD_CONCEPTO,
                                 B.COD_MONEDA,
                                 PV_CNV_MONEDAS_FN(A.COD_CONCEPTO,B.COD_MONEDA,B.IMP_TARIFA)
                INTO     vv_CodConcepto,
                                 vv_CodMoneda,
                                 vv_ImpTarifa
                FROM     GA_ACTUASERV A,  GA_TARIFAS B,  GA_SERVSUPL C,  GE_MONEDAS D
                WHERE    A.COD_PRODUCTO = EN_COD_PRODUCTO
                AND      A.COD_ACTABO   = EV_COD_ACTABO
                AND      A.COD_TIPSERV  = 2
                AND      A.COD_SERVICIO = EV_COD_SERVICIO
                AND      B.COD_PRODUCTO = A.COD_PRODUCTO
                AND      B.COD_ACTABO   = A.COD_ACTABO
                AND      B.COD_TIPSERV  = A.COD_TIPSERV
                AND      B.COD_SERVICIO = A.COD_SERVICIO
                AND      B.COD_PLANSERV = EV_COD_PLANSERV
                AND      SYSDATE BETWEEN B.FEC_DESDE AND  NVL(B.FEC_HASTA, SYSDATE)
                AND      C.COD_PRODUCTO = A.COD_PRODUCTO
                AND      C.COD_SERVICIO = A.COD_SERVICIO
                AND      D.COD_MONEDA   = B.COD_MONEDA
                AND      C.IND_COBRO    = 0;


                SV_COD_CONCEPTO := vv_CodConcepto;
                SV_COD_MONEDA   := vv_CodMoneda;
                SN_IMP_TARIFA   := vv_ImpTarifa;

           RETURN TRUE;
           EXCEPTION
                                WHEN NO_DATA_FOUND THEN
                                         RETURN FALSE;
                                WHEN OTHERS THEN
                                         SV_ERROR := 4;
                                         SV_SQLCODE := SQLCODE;
                                         SV_SQLERRM := SQLERRM;
                                         RETURN FALSE;

END PV_CARGOS_SS_FN;

--------------------------------------------------------------------------------
FUNCTION PV_CARGOS_PENAL_FN     (EN_COD_PRODUCTO         IN GA_ABOCEL.COD_PRODUCTO%TYPE,
                                                                 EN_COD_PENALIZA         IN GA_ACTUASERV.COD_ACTABO%TYPE,
                                                                 SV_COD_CONCEPTO        OUT GA_ACTUASERV.COD_CONCEPTO%TYPE,
                                                                 SV_COD_MONEDA          OUT GA_TARIFAS.COD_MONEDA%TYPE,
                                                                 SN_IMP_TARIFA          OUT GA_TARIFAS.IMP_TARIFA%TYPE,
                                                                 SV_PROC            OUT VARCHAR2,
                                                         SV_TABLA           OUT VARCHAR2,
                                                         SV_ACT             OUT VARCHAR2,
                                                         SV_SQLCODE         OUT VARCHAR2,
                                                         SV_SQLERRM         OUT VARCHAR2,
                                                         SV_ERROR           OUT VARCHAR2) RETURN BOOLEAN
/*
<DOC>
<NOMBRE>      PV_CARGOS_PENAL_FN                                   </NOMBRE>
<FECHACREA>   14/10/2004                                         </FECHACREA>
<MODULO>      POSTVENTA                                          </MODULO>
<AUTOR>       Hector Perez Guzman                                </AUTOR>
<VERSION>     1.0.0                                              </VERSION>
<DESCRIPCION>                                                                                                    </DESCRIPCION>
<FECHAMOD>                                                           </FECHAMOD>
<DESCMOD>                                                                                                        </DESCMOD>
<ParamEntr>                                                                                              </ParamEntr>
<ParamSal>                                                                                               </ParamSal>
<ParamSal>    SV_error: Codgio Error Controlado                  </ParamSal>
<ParamSal>    SV_proc: Nombre Procedimiento                      </ParamSal>
<ParamSal>    SV_tabla: Nombre Tabla                             </ParamSal>
<ParamSal>    SV_act: Accion Efectuada sobre la Tabla            </ParamSal>
<ParamSal>    SV_sqlcode: Codigo Error Oracle                    </ParamSal>
<ParamSal>    SV_sqlerrm: Mensaje Error Oracle                   </ParamSal>
</DOC>
*/
IS

  vv_CodConcepto  GA_ACTUASERV.COD_CONCEPTO%TYPE;
  vv_CodMoneda    GA_TARIFAS.COD_MONEDA%TYPE;
  vv_ImpTarifa    GA_TARIFAS.IMP_TARIFA%TYPE;

BEGIN

           SV_error   := '0';
           SV_proc        := 'PV_CARGOS_PENAL_FN';
           SV_act         := 'S';
           SV_tabla   := '';


                SELECT B.COD_CONCEPTO,
                           A.COD_MONEDA,
                           PV_CNV_MONEDAS_FN(B.COD_CONCEPTO,A.COD_MONEDA,A.IMP_PENALIZA)
                INTO   vv_CodConcepto,
                           vv_CodMoneda,
                           vv_ImpTarifa
                FROM   GA_IMPPENALIZA A,  GA_PENALIZA B, GE_MONEDAS C
                WHERE  A.COD_PRODUCTO = EN_COD_PRODUCTO
                  AND  A.COD_PENALIZA = EN_COD_PENALIZA
                  AND  SYSDATE BETWEEN A.FEC_DESDE AND  NVL(A.FEC_HASTA, SYSDATE)
                  AND  A.COD_PRODUCTO = B.COD_PRODUCTO
                  AND  A.COD_PENALIZA = B.COD_PENALIZA
                  AND  A.COD_MONEDA   = C.COD_MONEDA;

                SV_COD_CONCEPTO := vv_CodConcepto;
                SV_COD_MONEDA   := vv_CodMoneda;
                SN_IMP_TARIFA   := vv_ImpTarifa;

           RETURN TRUE;
           EXCEPTION
                                WHEN NO_DATA_FOUND THEN
                                         RETURN FALSE;
                                WHEN OTHERS THEN
                                         SV_ERROR := 4;
                                         SV_SQLCODE := SQLCODE;
                                         SV_SQLERRM := SQLERRM;
                                         RETURN FALSE;
END PV_CARGOS_PENAL_FN;


--------------------------------------------------------------------------------



FUNCTION PV_CNV_MONEDAS_FN      (EV_COD_CONCEPTO     IN GA_ACTUASERV.COD_CONCEPTO%TYPE,
                                                                 EV_COD_MONEDA           IN GA_TARIFAS.COD_MONEDA%TYPE,
                                                                 EN_IMP_TARIFA           IN GA_TARIFAS.IMP_TARIFA%TYPE) RETURN GA_TARIFAS.IMP_TARIFA%TYPE
/*
<DOC>
<NOMBRE>      PV_CNV_MONEDAS_FN                                    </NOMBRE>
<FECHACREA>   14/10/2004                                         </FECHACREA>
<MODULO>      POSTVENTA                                          </MODULO>
<AUTOR>       Hector Perez Guzman                                </AUTOR>
<VERSION>     1.0.0                                              </VERSION>
<DESCRIPCION>                                                                                                    </DESCRIPCION>
<FECHAMOD>                                                           </FECHAMOD>
<DESCMOD>                                                                                                        </DESCMOD>
<ParamEntr>                                                                                              </ParamEntr>
<ParamSal>                                                                                               </ParamSal>
<ParamSal>    SV_error: Codgio Error Controlado                  </ParamSal>
<ParamSal>    SV_proc: Nombre Procedimiento                      </ParamSal>
<ParamSal>    SV_tabla: Nombre Tabla                             </ParamSal>
<ParamSal>    SV_act: Accion Efectuada sobre la Tabla            </ParamSal>
<ParamSal>    SV_sqlcode: Codigo Error Oracle                    </ParamSal>
<ParamSal>    SV_sqlerrm: Mensaje Error Oracle                   </ParamSal>
</DOC>
*/
IS
  v_Cursor             vCursor;
  vv_CodMonedaO            FA_CONCEPTOS.COD_MONEDA%TYPE;
  vv_CodMonedaD            GE_CONVERSION.CAMBIO%TYPE;
  vn_CambioO               GE_CONVERSION.CAMBIO%TYPE;
  vn_CambioD               GE_CONVERSION.CAMBIO%TYPE;
  vn_ImpTarifa             GA_TARIFAS.IMP_TARIFA%TYPE;

BEGIN

           vv_CodMonedaO := EV_COD_MONEDA;

           SELECT A.COD_MONEDA
           INTO   vv_CodMonedaD
           FROM   FA_CONCEPTOS A, GE_MONEDAS B
           WHERE  A.COD_CONCEPTO = EV_COD_CONCEPTO
                 AND  A.COD_MONEDA   = B.COD_MONEDA;

           IF vv_CodMonedaD = vv_CodMonedaO THEN
                  vn_ImpTarifa := EN_IMP_TARIFA;
                  RETURN vn_ImpTarifa;
           END IF;

           SELECT CAMBIO
           INTO   vn_CambioO
           FROM   GE_CONVERSION
           WHERE  COD_MONEDA = vv_CodMonedaO
                 AND  SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA;

            SELECT CAMBIO
                INTO   vn_CambioD
                FROM   GE_CONVERSION
                WHERE  COD_MONEDA = vv_CodMonedaD
                  AND  SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA;

           vn_ImpTarifa := (EN_IMP_TARIFA * vn_CambioO) / vn_CambioD;

           RETURN vn_ImpTarifa;


END PV_CNV_MONEDAS_FN;

--------------------------------------------------------------------------------

FUNCTION  PV_INSERTA_CARGOS_FN             (EN_COD_CLIENTE        IN GA_ABOCEL.COD_CLIENTE%TYPE,
                                                                                EN_COD_PRODUCTO   IN GA_ABOCEL.COD_PRODUCTO%TYPE,
                                                                                EN_NUM_ABONADO    IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                                                                EN_NUM_TERMINAL   IN GA_ABOCEL.NUM_CELULAR%TYPE,
                                                                                EV_COD_PLANCOM    IN GA_CLIENTE_PCOM.COD_PLANCOM%TYPE,
                                                                                ED_FEC_ALTA       IN GA_ABOCEL.FEC_ALTA%TYPE,
                                                                                EN_COD_CICLFACT   IN FA_CICLFACT.COD_CICLFACT%TYPE,
                                                                                EV_COD_CONCEPTO   IN GE_CARGOS.COD_CONCEPTO%TYPE,
                                                                                EN_IMP_CARGO      IN GE_CARGOS.IMP_CARGO%TYPE,
                                                                                EV_COD_MONEDA     IN GE_CARGOS.COD_MONEDA%TYPE,
                                                                                EV_USUARIO        IN GE_CARGOS.NOM_USUARORA%TYPE,
                                                                        SV_PROC          OUT VARCHAR2,
                                                                        SV_TABLA         OUT VARCHAR2,
                                                                        SV_ACT                   OUT VARCHAR2,
                                                                        SV_SQLCODE       OUT VARCHAR2,
                                                                        SV_SQLERRM       OUT VARCHAR2,
                                                                        SV_ERROR         OUT VARCHAR2) RETURN BOOLEAN
/*
<DOC>
<NOMBRE>      PV_INSERTA_CARGOS_FN                      </NOMBRE>
<FECHACREA>   14/10/2004                                         </FECHACREA>
<MODULO>      POSTVENTA                                          </MODULO>
<AUTOR>       Hector Perez Guzman                                </AUTOR>
<VERSION>     1.0.0                                              </VERSION>
<DESCRIPCION>                                                                                                    </DESCRIPCION>
<FECHAMOD>                                                           </FECHAMOD>
<DESCMOD>                                                                                                        </DESCMOD>
<ParamEntr>                                                                                              </ParamEntr>
<ParamSal>                                                                                               </ParamSal>
<ParamSal>    SV_error: Codgio Error Controlado                  </ParamSal>
<ParamSal>    SV_proc: Nombre Procedimiento                      </ParamSal>
<ParamSal>    SV_tabla: Nombre Tabla                             </ParamSal>
<ParamSal>    SV_act: Accion Efectuada sobre la Tabla            </ParamSal>
<ParamSal>    SV_sqlcode: Codigo Error Oracle                    </ParamSal>
<ParamSal>    SV_sqlerrm: Mensaje Error Oracle                   </ParamSal>
</DOC>
*/
IS

BEGIN
           SV_error   := '0';
           SV_proc        := 'PV_INSERTA_CARGOS_FN';
           SV_act         := 'I';
           SV_tabla   := 'GE_CARGO';


           INSERT INTO GE_CARGOS (NUM_CARGO,                 COD_CLIENTE,       COD_PRODUCTO,
                                                          NUM_ABONADO,                           NUM_TERMINAL,      COD_PLANCOM,
                                                          COD_CICLFACT,                          IND_FACTUR,        FEC_ALTA,
                                                          COD_CONCEPTO,                          NUM_UNIDADES,      IMP_CARGO,
                                                          COD_MONEDA,                    IND_CUOTA,         NOM_USUARORA )
                                    VALUES   (GE_SEQ_CARGOS.NEXTVAL,     EN_COD_CLIENTE,        EN_COD_PRODUCTO,
                                                          EN_NUM_ABONADO,                        EN_NUM_TERMINAL,       EV_COD_PLANCOM,
                                                          EN_COD_CICLFACT,                       1,                                     ED_FEC_ALTA,
                                                          EV_COD_CONCEPTO,                       1,                                     EN_IMP_CARGO,
                                                          EV_COD_MONEDA,                         NULL,                          EV_USUARIO);


           RETURN TRUE;

           EXCEPTION
                                WHEN OTHERS THEN
                                         SV_error := 4;
                                         SV_sqlcode := SQLCODE;
                                         SV_sqlerrm := SQLERRM;
                                         RETURN FALSE;
END PV_INSERTA_CARGOS_FN;

--------------------------------------------------------------------------------

FUNCTION PV_RECUPERA_CICLO_FACT_FN  (EN_COD_CLIENTE      IN GA_CLIENTE_PCOM.COD_PLANCOM%TYPE,
                                                                         SV_PROC            OUT VARCHAR2,
                                                                 SV_TABLA           OUT VARCHAR2,
                                                                 SV_ACT             OUT VARCHAR2,
                                                                 SV_SQLCODE         OUT VARCHAR2,
                                                                 SV_SQLERRM         OUT VARCHAR2,
                                                                 SV_ERROR           OUT VARCHAR2) RETURN FA_CICLFACT.COD_CICLFACT%TYPE
IS
  vn_CodCiclFact  FA_CICLFACT.COD_CICLFACT%TYPE;
BEGIN
           SV_error   := '0';
           SV_proc        := 'PV_RECUPERA_CICLO_FACT_FN';
           SV_act         := 'S';
           SV_tabla   := 'FA_CICLFACT';


                SELECT  A.COD_CICLFACT
                INTO    vn_CodCiclFact
                FROM    FA_CICLFACT A,  GE_CLIENTES B
                WHERE   A.COD_CICLO   = B.COD_CICLO
                AND     B.COD_CLIENTE = EN_COD_CLIENTE
                AND     SYSDATE BETWEEN FEC_DESDELLAM AND  NVL(FEC_HASTALLAM, SYSDATE);


           RETURN vn_CodCiclFact;

           EXCEPTION
                                WHEN NO_DATA_FOUND THEN
                                         RETURN NULL;
                                WHEN OTHERS THEN
                                         SV_error := 4;
                                         SV_sqlcode := SQLCODE;
                                         SV_sqlerrm := SQLERRM;
                                         RETURN NULL;

END PV_RECUPERA_CICLO_FACT_FN ;

--------------------------------------------------------------------------------

FUNCTION PV_VALIDA_CICLO_VIG_FN     (EN_COD_CLIENTE      IN GA_CLIENTE_PCOM.COD_PLANCOM%TYPE,
                                                                         EN_NUM_ABONADO      IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                                                         EN_COD_CICLFACT         IN FA_CICLFACT.COD_CICLFACT%TYPE,
                                                                         SV_PROC            OUT VARCHAR2,
                                                                 SV_TABLA           OUT VARCHAR2,
                                                                 SV_ACT             OUT VARCHAR2,
                                                                 SV_SQLCODE         OUT VARCHAR2,
                                                                 SV_SQLERRM         OUT VARCHAR2,
                                                                 SV_ERROR           OUT VARCHAR2) RETURN BOOLEAN
IS
  vn_Reg  NUMBER;
BEGIN
           SV_error   := '0';
           SV_proc        := 'PV_VALIDA_CICLO_VIG_FN';
           SV_act         := 'S';
           SV_tabla   := 'FA_CICLFACT';

        SELECT COUNT(*)
        INTO   vn_Reg
        FROM GA_INFACCEL
                WHERE COD_CLIENTE  = EN_COD_CLIENTE
          AND NUM_ABONADO  = EN_NUM_ABONADO
          AND COD_CICLFACT = EN_COD_CICLFACT;

           IF vn_Reg > 0 THEN
                  RETURN TRUE;
           ELSE
                  RETURN FALSE;
           END IF;

           EXCEPTION
                                WHEN NO_DATA_FOUND THEN
                                         RETURN FALSE;
                                WHEN OTHERS THEN
                                         SV_error := 4;
                                         SV_sqlcode := SQLCODE;
                                         SV_sqlerrm := SQLERRM;
                                         RETURN FALSE;

END PV_VALIDA_CICLO_VIG_FN ;
--------------------------------------------------------------------------------

FUNCTION PV_RECUPERA_PLAN_COMERCIAL_FN  (EN_COD_CLIENTE      IN GA_CLIENTE_PCOM.COD_PLANCOM%TYPE,
                                                                                 SV_PROC            OUT VARCHAR2,
                                                                         SV_TABLA           OUT VARCHAR2,
                                                                         SV_ACT             OUT VARCHAR2,
                                                                         SV_SQLCODE         OUT VARCHAR2,
                                                                         SV_SQLERRM         OUT VARCHAR2,
                                                                         SV_ERROR           OUT VARCHAR2) RETURN GA_CLIENTE_PCOM.COD_PLANCOM%TYPE
/*
<DOC>
<NOMBRE>      PV_RECUPERA_PLAN_COMERCIAL_FN                         </NOMBRE>
<FECHACREA>   14/10/2004                                         </FECHACREA>
<MODULO>      POSTVENTA                                          </MODULO>
<AUTOR>       Hector Perez Guzman                                </AUTOR>
<VERSION>     1.0.0                                              </VERSION>
<DESCRIPCION>                                                                                                    </DESCRIPCION>
<FECHAMOD>                                                           </FECHAMOD>
<DESCMOD>                                                                                                        </DESCMOD>
<ParamEntr>                                                                                              </ParamEntr>
<ParamSal>                                                                                               </ParamSal>
<ParamSal>    SV_error: Codgio Error Controlado                  </ParamSal>
<ParamSal>    SV_proc: Nombre Procedimiento                      </ParamSal>
<ParamSal>    SV_tabla: Nombre Tabla                             </ParamSal>
<ParamSal>    SV_act: Accion Efectuada sobre la Tabla            </ParamSal>
<ParamSal>    SV_sqlcode: Codigo Error Oracle                    </ParamSal>
<ParamSal>    SV_sqlerrm: Mensaje Error Oracle                   </ParamSal>
</DOC>
*/
IS
  vv_CodPlanCom   GA_CLIENTE_PCOM.COD_PLANCOM%TYPE;
BEGIN
           SV_error   := '0';
           SV_proc        := 'PV_RECUPERA_PLAN_COMERCIAL_FN';
           SV_act         := 'S';
           SV_tabla   := 'FA_CICLFACT';



                SELECT COD_PLANCOM
                INTO   vv_CodPlanCom
                FROM   GA_CLIENTE_PCOM
                WHERE  COD_CLIENTE = EN_COD_CLIENTE
                AND    SYSDATE BETWEEN FEC_DESDE AND NVL(FEC_HASTA, SYSDATE) ;



           RETURN vv_CodPlanCom;

           EXCEPTION
                                WHEN OTHERS THEN
                                         SV_error := 4;
                                         SV_sqlcode := SQLCODE;
                                         SV_sqlerrm := SQLERRM;
                                         RETURN 0;

END PV_RECUPERA_PLAN_COMERCIAL_FN;

--------------------------------------------------------------------------------

FUNCTION  PV_UPD_CARGOS_FN                     (EN_COD_CLIENTE    IN GA_ABOCEL.COD_CLIENTE%TYPE,
                                                                                EN_NUM_ABONADO    IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                                                                EN_COD_CICLFACT   IN FA_CICLFACT.COD_CICLFACT%TYPE,
                                                                        SV_PROC          OUT VARCHAR2,
                                                                        SV_TABLA         OUT VARCHAR2,
                                                                        SV_ACT                   OUT VARCHAR2,
                                                                        SV_SQLCODE       OUT VARCHAR2,
                                                                        SV_SQLERRM       OUT VARCHAR2,
                                                                        SV_ERROR         OUT VARCHAR2) RETURN BOOLEAN
/*
<DOC>
<NOMBRE>      PV_UPD_CARGOS_FN                      </NOMBRE>
<FECHACREA>   14/10/2004                                         </FECHACREA>
<MODULO>      POSTVENTA                                          </MODULO>
<AUTOR>       Hector Perez Guzman                                </AUTOR>
<VERSION>     1.0.0                                              </VERSION>
<DESCRIPCION>                                                                                                    </DESCRIPCION>
<FECHAMOD>                                                           </FECHAMOD>
<DESCMOD>                                                                                                        </DESCMOD>
<ParamEntr>                                                                                              </ParamEntr>
<ParamSal>                                                                                               </ParamSal>
<ParamSal>    SV_error: Codgio Error Controlado                  </ParamSal>
<ParamSal>    SV_proc: Nombre Procedimiento                      </ParamSal>
<ParamSal>    SV_tabla: Nombre Tabla                             </ParamSal>
<ParamSal>    SV_act: Accion Efectuada sobre la Tabla            </ParamSal>
<ParamSal>    SV_sqlcode: Codigo Error Oracle                    </ParamSal>
<ParamSal>    SV_sqlerrm: Mensaje Error Oracle                   </ParamSal>
</DOC>
*/
IS

BEGIN
           SV_error   := '0';
           SV_proc        := 'PV_UPD_CARGOS_FN';
           SV_act         := 'U';
           SV_tabla   := 'GA_INFACCEL';


                UPDATE  GA_INFACCEL
                SET     IND_CARGOS=1
                WHERE   COD_CLIENTE =  EN_COD_CLIENTE
                AND     NUM_ABONADO =  EN_NUM_ABONADO
                AND     COD_CICLFACT=  EN_COD_CICLFACT;



           RETURN TRUE;

           EXCEPTION
                                WHEN OTHERS THEN
                                         SV_error := 4;
                                         SV_sqlcode := SQLCODE;
                                         SV_sqlerrm := SQLERRM;
                                         RETURN FALSE;
END PV_UPD_CARGOS_FN;

--------------------------------------------------------------------------------

FUNCTION PV_VALIDA_USUARIO_FN  (EV_USUARIO              IN GA_ABOCEL.NOM_USUARORA%TYPE,
                                                                SV_ERROR           OUT VARCHAR2,
                                                                SV_PROC            OUT VARCHAR2,
                                                    SV_TABLA           OUT VARCHAR2,
                                                        SV_ACT                 OUT VARCHAR2,
                                                    SV_SQLCODE         OUT VARCHAR2,
                                                    SV_SQLERRM         OUT VARCHAR2
                                                    ) RETURN BOOLEAN
/*
<DOC>
<NOMBRE>      PV_VALIDA_USUARIO_FN                         </NOMBRE>
<FECHACREA>   14/10/2004                                         </FECHACREA>
<MODULO>      POSTVENTA                                          </MODULO>
<AUTOR>       Hector Perez Guzman                                </AUTOR>
<VERSION>     1.0.0                                              </VERSION>
<DESCRIPCION>                                                                                                    </DESCRIPCION>
<FECHAMOD>                                                           </FECHAMOD>
<DESCMOD>                                                                                                        </DESCMOD>
<ParamEntr>                                                                                              </ParamEntr>
<ParamSal>                                                                                               </ParamSal>
<ParamSal>    SV_error: Codgio Error Controlado                  </ParamSal>
<ParamSal>    SV_proc: Nombre Procedimiento                      </ParamSal>
<ParamSal>    SV_tabla: Nombre Tabla                             </ParamSal>
<ParamSal>    SV_act: Accion Efectuada sobre la Tabla            </ParamSal>
<ParamSal>    SV_sqlcode: Codigo Error Oracle                    </ParamSal>
<ParamSal>    SV_sqlerrm: Mensaje Error Oracle                   </ParamSal>
</DOC>
*/
IS
  vn_Valor   NUMBER(1);
BEGIN
           SV_error   := '0';
           SV_proc        := 'PV_VALIDA_USUARIO_FN';
           SV_act         := 'S';
           SV_tabla   := 'GE_SEG_USUARIO';

                SELECT COUNT(1)
                INTO   vn_Valor
                FROM   GE_SEG_USUARIO
                WHERE  NOM_USUARIO = EV_USUARIO;


                IF vn_Valor = 0 THEN
                           RETURN FALSE;
                ELSE
                           RETURN TRUE;
                END IF;

           EXCEPTION
                                WHEN OTHERS THEN
                                         SV_error := 4;
                                         SV_sqlcode := SQLCODE;
                                         SV_sqlerrm := SQLERRM;
                                         RETURN FALSE;

END PV_VALIDA_USUARIO_FN;

--------------------------------------------------------------------------------

PROCEDURE PV_MOV_CENTRAL_PR    (EN_NUMSECUENCIA                 IN NUMBER,
                                                                EN_NUMABONADO                   IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                                                EV_CODESTADO                    IN VARCHAR2,
                                                                EV_CODACTABO                    IN GA_ACTABO.COD_ACTABO%TYPE,
                                                                EV_CODMODULO                    IN VARCHAR2,
                                                                EV_USUARIO                              IN VARCHAR2,
                                                                EV_FECINGRE                             IN VARCHAR2,
                                                                EV_TIPTERMINAL                  IN VARCHAR2,
                                                                EN_CODCENTRAL                   IN GA_ABOCEL.COD_CENTRAL%TYPE,
                                                                EN_INDBLOQUEO                   IN NUMBER,
                                                                EV_TIPTERMINAL_NUE              IN VARCHAR2,
                                                                EN_NUMCELULAR                   IN GA_ABOCEL.NUM_CELULAR%TYPE,
                                                                EV_NUMSERIE                             IN GA_ABOCEL.NUM_SERIE%TYPE,
                                                                EN_NUMCELULAR_NUE               IN GA_ABOCEL.NUM_CELULAR%TYPE,
                                                                EV_NUMSERIE_NUE                 IN GA_ABOCEL.NUM_SERIE%TYPE,
                                                                EV_CODSUSPREHA                  IN GA_SUSPREHABO.COD_CAUSUSP%TYPE,
                                                                EV_CODSERVICIOS                 IN VARCHAR2,
                                                                EN_NUMMIN                               IN GA_ABOCEL.NUM_MIN%TYPE,
                                                                EN_NUMMIN_NUE                   IN GA_ABOCEL.NUM_MIN%TYPE,
                                                                EV_TIPTECNOLOGIA                IN ICC_MOVIMIENTO.TIP_TECNOLOGIA%TYPE,
                                                                EV_IMSI_NUE                             IN ICC_MOVIMIENTO.IMSI%TYPE,
                                                                EV_IMEI                                 IN ICC_MOVIMIENTO.IMEI%TYPE,
                                                                EV_IMEI_NUE                             IN ICC_MOVIMIENTO.IMEI%TYPE,
                                                                EV_ICC                                  IN ICC_MOVIMIENTO.ICC%TYPE,
                                                                EV_ICC_NUE                              IN ICC_MOVIMIENTO.ICC%TYPE,
                                                                EN_CARGA                                IN ICC_MOVIMIENTO.CARGA%TYPE,
                                                                EN_CENTRAL_NUE                  IN ICC_MOVIMIENTO.COD_CENTRAL_NUE%TYPE,
                                                                EV_PLAN                                 IN ICC_MOVIMIENTO.PLAN%TYPE,
                                                                EN_VALORPLAN                    IN ICC_MOVIMIENTO.VALOR_PLAN%TYPE,
                                                                EV_NUMMSNB                              IN ICC_MOVIMIENTO.NUM_MSNB%TYPE,
                                                                SV_PROC                OUT VARCHAR2,
                                                    SV_TABLA               OUT VARCHAR2,
                                                    SV_ACT                         OUT VARCHAR2,
                                                    SV_SQLCODE             OUT VARCHAR2,
                                                    SV_SQLERRM             OUT VARCHAR2,
                                                    SV_ERROR               OUT VARCHAR2)
IS

   V_CODACTUACION        GA_ACTABO.COD_ACTCEN%TYPE; -- Actuacion de central
   V_IMSI                        ICC_MOVIMIENTO.IMSI%TYPE;
   V_ICC                         ICC_MOVIMIENTO.ICC%TYPE;

   VP_SQLCODE   NUMBER(9);
   VP_SQLERRM   VARCHAR2(255);

   VP_ERRORSEV  VARCHAR2(255);
   VP_NEVENTO   NUMBER(9);
   VP_ERRORDES  VARCHAR2(255);

   ERROR_PROCESO EXCEPTION;

BEGIN

           SV_error   := '0';
           SV_proc        := 'PV_MOV_CENTRAL_PR';
           SV_act         := '';
           SV_tabla   := '';


     PV_REGISTRA_MOVIMIENTO_PR(EN_NUMSECUENCIA,EN_NUMABONADO,EV_CODESTADO,EV_CODACTABO,EV_CODMODULO,EV_USUARIO,
                                                           EV_FECINGRE,EV_TIPTERMINAL,EN_CODCENTRAL,EN_INDBLOQUEO,EV_TIPTERMINAL_NUE,
                                                           EN_NUMCELULAR,EV_NUMSERIE,EN_NUMCELULAR_NUE,EV_NUMSERIE_NUE,EV_CODSUSPREHA,
                                                           EV_CODSERVICIOS,EN_NUMMIN,EN_NUMMIN_NUE,EV_TIPTECNOLOGIA,EV_IMSI_NUE,
                                                           EV_IMEI,EV_IMEI_NUE,EV_ICC, EV_ICC_NUE,EN_CARGA,EN_CENTRAL_NUE,EV_PLAN,EN_VALORPLAN,
                                                           EV_NUMMSNB, SV_PROC,SV_TABLA,SV_ACT,SV_SQLCODE,SV_SQLERRM,SV_ERROR);


           EXCEPTION
                                WHEN OTHERS THEN
                                         SV_error := 4;
                                         SV_sqlcode := SQLCODE;
                                         SV_sqlerrm := SQLERRM;

END PV_MOV_CENTRAL_PR;

--------------------------------------------------------------------------------

PROCEDURE PV_REGISTRA_MOVIMIENTO_PR (EN_NUMSECUENCIA            IN NUMBER,
                                                                   EN_NUMABONADO                IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                                                   EV_CODESTADO                 IN VARCHAR2,
                                                                   EV_CODACTABO                 IN GA_ACTABO.COD_ACTABO%TYPE,
                                                                   EV_CODMODULO                 IN VARCHAR2,
                                                                   EV_USUARIO                   IN VARCHAR2,
                                                                   EV_FECINGRE                  IN VARCHAR2,
                                                                   EV_TIPTERMINAL               IN VARCHAR2,
                                                                   EN_CODCENTRAL                IN GA_ABOCEL.COD_CENTRAL%TYPE,
                                                                   EN_INDBLOQUEO                IN NUMBER,
                                                                   EV_TIPTERMINAL_NUE   IN VARCHAR2,
                                                                   EN_NUMCELULAR                IN GA_ABOCEL.NUM_CELULAR%TYPE,
                                                                   EV_NUMSERIE                  IN GA_ABOCEL.NUM_SERIE%TYPE,
                                                                   EN_NUMCELULAR_NUE    IN GA_ABOCEL.NUM_CELULAR%TYPE,
                                                                   EV_NUMSERIE_NUE              IN GA_ABOCEL.NUM_SERIE%TYPE,
                                                                   EV_CODSUSPREHA               IN GA_SUSPREHABO.COD_CAUSUSP%TYPE,
                                                                   EV_CODSERVICIOS              IN VARCHAR2,
                                                                   EN_NUMMIN                    IN GA_ABOCEL.NUM_MIN%TYPE,
                                                                   EN_NUMMIN_NUE                IN GA_ABOCEL.NUM_MIN%TYPE,
                                                                   EV_TIPTECNOLOGIA             IN ICC_MOVIMIENTO.TIP_TECNOLOGIA%TYPE,
                                                                   EV_IMSI_NUE                  IN ICC_MOVIMIENTO.IMSI%TYPE,
                                                                   EV_IMEI                              IN ICC_MOVIMIENTO.IMEI%TYPE,
                                                                   EV_IMEI_NUE                  IN ICC_MOVIMIENTO.IMEI%TYPE,
                                                                   EV_ICC                               IN ICC_MOVIMIENTO.ICC%TYPE,
                                                                   EV_ICC_NUE                   IN ICC_MOVIMIENTO.ICC%TYPE,
                                                                   EN_CARGA                             IN ICC_MOVIMIENTO.CARGA%TYPE,
                                                                   EN_CENTRAL_NUE               IN ICC_MOVIMIENTO.COD_CENTRAL_NUE%TYPE,
                                                                   EV_PLAN                              IN ICC_MOVIMIENTO.PLAN%TYPE,
                                                                   EN_VALORPLAN                 IN ICC_MOVIMIENTO.VALOR_PLAN%TYPE,
                                                                   EV_NUMMSNB                   IN ICC_MOVIMIENTO.NUM_MSNB%TYPE,
                                                           SV_PROC             OUT VARCHAR2,
                                                           SV_TABLA            OUT VARCHAR2,
                                                           SV_ACT                  OUT VARCHAR2,
                                                           SV_SQLCODE          OUT VARCHAR2,
                                                           SV_SQLERRM          OUT VARCHAR2,
                                                           SV_ERROR            OUT VARCHAR2)
IS


   V_GRP_TECNO_GSM   ICC_MOVIMIENTO.TIP_TECNOLOGIA%TYPE;
   V_GRP_TECNO_DMA   ICC_MOVIMIENTO.TIP_TECNOLOGIA%TYPE;

   V_GRP_TECNOLOGICO ICC_MOVIMIENTO.TIP_TECNOLOGIA%TYPE;
   V_CODACTUACION        GA_ACTABO.COD_ACTCEN%TYPE; -- Actuacion de central
   V_IMSI                        ICC_MOVIMIENTO.IMSI%TYPE;
   V_ICC                         ICC_MOVIMIENTO.ICC%TYPE;
   V_NUMSERIE            ICC_MOVIMIENTO.NUM_SERIE%TYPE;

   VP_SQLCODE   NUMBER(9);
   VP_SQLERRM   VARCHAR2(255);

   v_Formato_Sel2   GED_PARAMETROS.VAL_PARAMETRO%TYPE;
   v_Formato_Sel7   GED_PARAMETROS.VAL_PARAMETRO%TYPE;
   v_Formato_Sel19  GED_PARAMETROS.VAL_PARAMETRO%TYPE;


   ERROR_PROCESO EXCEPTION;

BEGIN

           SV_error   := '0';
           SV_proc        := 'PV_REGISTRA_MOVIMIENTO_PR';
           SV_act         := 'I';
           SV_tabla   := 'ICC_MOVIMIENTO';


         v_Formato_Sel2  := GE_PAC_GENERAL.PARAM_GENERAL('FORMATO_SEL2');
         v_Formato_Sel7  := GE_PAC_GENERAL.PARAM_GENERAL('FORMATO_SEL7');
         v_Formato_Sel19 := GE_PAC_GENERAL.PARAM_GENERAL('FORMATO_SEL19');

         SELECT FN_CODACTCEN (1,EV_CODACTABO,EV_CODMODULO,EV_TIPTECNOLOGIA) INTO V_CODACTUACION FROM DUAL;
         IF LTRIM(RTRIM(V_CODACTUACION)) = '' THEN
            RAISE ERROR_PROCESO;
         END IF;

         V_NUMSERIE     := EV_NUMSERIE;
         IF V_NUMSERIE = NULL THEN
                V_NUMSERIE := EV_ICC;
         END IF;


         IF EV_TIPTECNOLOGIA =  V_GRP_TECNO_GSM THEN
            SELECT FN_RECUPERA_IMSI(V_NUMSERIE) INTO V_IMSI FROM DUAL;
         ELSE
            V_IMSI := 'NO ENTRO';
         END IF;


          INSERT INTO ICC_MOVIMIENTO(NUM_MOVIMIENTO, NUM_ABONADO, COD_ESTADO, COD_ACTABO, COD_MODULO,
                                                                 COD_ACTUACION,CARGA,COD_CENTRAL_NUE,
                                                                 NOM_USUARORA, FEC_INGRESO, TIP_TERMINAL, COD_CENTRAL,
                                                                 IND_BLOQUEO, TIP_TERMINAL_NUE, NUM_CELULAR,
                                                                 NUM_SERIE, NUM_CELULAR_NUE, NUM_SERIE_NUE,
                                                                 COD_SUSPREHA, COD_SERVICIOS,PLAN,VALOR_PLAN,
                                                                 NUM_MIN, NUM_MIN_NUE,NUM_MSNB,
                                                                 TIP_TECNOLOGIA, IMSI, IMSI_NUE, IMEI,
                                                                 IMEI_NUE, ICC, ICC_NUE)
                                  VALUES(EN_NUMSECUENCIA,EN_NUMABONADO,EV_CODESTADO,EV_CODACTABO,EV_CODMODULO,
                                                             V_CODACTUACION,EN_CARGA,EN_CENTRAL_NUE,
                                                                 EV_USUARIO,to_date(EV_FECINGRE,v_Formato_Sel2),EV_TIPTERMINAL,EN_CODCENTRAL,
                                                                 EN_INDBLOQUEO,EV_TIPTERMINAL_NUE,EN_NUMCELULAR,
                                                                 EV_NUMSERIE,EN_NUMCELULAR_NUE,EV_NUMSERIE_NUE,
                                                                 EV_CODSUSPREHA,EV_CODSERVICIOS,EV_PLAN,EN_VALORPLAN,
                                                                 EN_NUMMIN,EN_NUMMIN_NUE,EV_NUMMSNB,
                                                                 EV_TIPTECNOLOGIA,V_IMSI,EV_IMSI_NUE,EV_IMEI,
                                                                 EV_IMEI_NUE,EV_ICC,EV_ICC_NUE);



           EXCEPTION
                                WHEN OTHERS THEN
                                         SV_error := 4;
                                         SV_sqlcode := SQLCODE;
                                         SV_sqlerrm := SQLERRM;


END PV_REGISTRA_MOVIMIENTO_PR;

FUNCTION PV_CLASE_SERV_FN(EV_ServSupl     IN VARCHAR2,
                                                  SV_CodGrupo     IN OUT SISCEL.GE_TABTYPE_VCH2ARRAY,
                                                  SV_CodNivel     IN OUT SISCEL.GE_TABTYPE_VCH2ARRAY,
                                                SV_error                 OUT VARCHAR2,
                                                SV_proc                  OUT VARCHAR2,
                                                SV_tabla                 OUT VARCHAR2,
                                                SV_act                   OUT VARCHAR2,
                                                SV_sqlcode               OUT VARCHAR2,
                                                SV_sqlerrm               OUT VARCHAR2
) RETURN VARCHAR2


IS

        I             NUMBER:=1;
        vn_Pos            NUMBER;
        vn_MaxParam   NUMBER;
        vv_Caracter   VARCHAR2(1);
        vv_Cadena         VARCHAR2(255);
        vv_Grupo          VARCHAR2(255);
        vv_Nivel          VARCHAR2(255);
        vn_Tipo           NUMBER;
        vn_Cont           NUMBER;
        ERROR_PROCESO  EXCEPTION;
        BEGIN


           SV_error   := '0';
           SV_proc        := 'PV_CLASE_SERV_FN';
           SV_act         := '';
           SV_tabla   := '';

           vn_MaxParam := LENGTH(EV_ServSupl);
           vn_Tipo     := 0;
           vn_Pos          := 1;
           vv_Grupo        := '';
           vv_Nivel        := '';
           vn_Cont         := 1;
                WHILE vn_Pos <= vn_MaxParam LOOP
                        SELECT SUBSTR(EV_ServSupl,vn_Pos,1) INTO vv_Caracter FROM dual;

                        IF vv_Caracter IS NOT NULL THEN
                                IF vv_Caracter <> '|' THEN
                                        IF vn_Tipo = 1 THEN
                                                vv_Grupo :=  vv_Grupo || vv_Caracter;
                                        ELSIF vn_Tipo = 2  THEN
                                                vv_Nivel :=  vv_Nivel || vv_Caracter;
                                        ELSE
                                                RAISE ERROR_PROCESO;
                                        END IF;
                                ELSE
                                        vn_Tipo := vn_Tipo + 1;
                                        IF vn_Tipo = 3 THEN

                                                IF LENGTH(vv_Grupo) > 0 THEN
                                                    SV_CodGrupo(vn_Cont):= vv_Grupo;
                                                        FOR I IN LENGTH(vv_Grupo)..1 LOOP
                                                                        vv_Grupo := '0' || vv_Grupo;
                                                        END LOOP;
                                                ELSIF  LENGTH(vv_Grupo) = 0 THEN
                                                        RAISE ERROR_PROCESO;
                                                END IF;


                                                IF LENGTH(vv_Nivel) > 0 THEN
                                                    SV_CodNivel(vn_Cont):= vv_Nivel;
                                                        FOR I IN LENGTH(vv_Nivel)..3 LOOP
                                                                        vv_Nivel := '0' || vv_Nivel;
                                                        END LOOP;
                                                ELSE
                                                        RAISE ERROR_PROCESO;
                                                END IF;
                                                vn_Cont   :=  vn_Cont + 1;
                                                vv_Cadena :=  vv_Cadena||vv_Grupo||vv_Nivel;
                                                vv_Grupo  := '';
                                                vv_Nivel  := '';
                                        END IF;

                                        IF vn_Pos < vn_MaxParam THEN
                                                IF  vn_Tipo = 3 THEN
                                                        vn_Tipo   := 1;
                                                END IF;
                                        END IF;
                                END IF;
                        END IF;
                        vn_Pos := vn_Pos + 1;
                END LOOP;

           IF vn_Tipo < 3 THEN
                  RAISE ERROR_PROCESO;
           ELSE
                    RETURN vv_Cadena;
           END IF;


        EXCEPTION
            WHEN ERROR_PROCESO THEN
                        SV_error := 4;
                        SV_sqlcode := '-3000';
                        SV_sqlerrm := 'Parámetros ingresados no válidos';
                        RETURN '';
                WHEN OTHERS THEN
                        SV_error := 4;
                        SV_sqlcode := SQLCODE;
                        SV_sqlerrm := SQLERRM;
                        RETURN '';

END PV_CLASE_SERV_FN;


FUNCTION PV_REC_SERV_FN  (EV_COD_SERVICIO   IN  VARCHAR2,
                                                  SV_COD_SERVICIO  IN OUT SISCEL.GE_TABTYPE_VCH2ARRAY,
                                                  SN_TOTAL_SERV    OUT NUMBER,
                                                  SV_error                 OUT VARCHAR2,
                                                  SV_proc                  OUT VARCHAR2,
                                                  SV_tabla                 OUT VARCHAR2,
                                                  SV_act                   OUT VARCHAR2,
                                                  SV_sqlcode       OUT VARCHAR2,
                                                  SV_sqlerrm       OUT VARCHAR2
) RETURN BOOLEAN


IS


        vn_Pos                NUMBER;
        vn_Reg                    NUMBER;
        vn_MaxParam       NUMBER;
        vv_Caracter       VARCHAR2(1);
        vv_CodServicio    VARCHAR2(255);

        ERROR_PROCESO  EXCEPTION;
        BEGIN


           SV_error   := '0';
           SV_proc        := 'PV_REC_SERV_FN';
           SV_act         := '';
           SV_tabla   := '';
           vn_Reg         := 1;

           vn_MaxParam    := LENGTH(EV_COD_SERVICIO);
           IF  vn_MaxParam < 3 THEN
                   RAISE ERROR_PROCESO;
           END IF;
           vn_Pos                 := 1;
           vv_CodServicio := '';
                WHILE vn_Pos <= vn_MaxParam LOOP
                        SELECT SUBSTR(EV_COD_SERVICIO ,vn_Pos,1) INTO vv_Caracter FROM dual;
                        IF vv_Caracter IS NOT NULL THEN
                            IF (vn_Pos = 1 OR vn_Pos = vn_MaxParam) AND vv_Caracter <> '|' THEN
                                   RAISE ERROR_PROCESO;
                                END IF;
                                IF vv_Caracter <> '|' THEN
                                                vv_CodServicio :=  vv_CodServicio || vv_Caracter;
                                ELSE
                                         IF vn_Pos > 1 THEN
                                                IF LENGTH(vv_CodServicio) <> 0 THEN
                                                                SV_COD_SERVICIO(vn_Reg):= vv_CodServicio;
                                                                vn_Reg := vn_Reg + 1;
                                        ELSE
                                                RAISE ERROR_PROCESO;
                                        END IF;
                                        vv_CodServicio  := '';

                                         END IF;
                                END IF;
                        END IF;
                        vn_Pos := vn_Pos + 1;
                END LOOP;

            SN_TOTAL_SERV:= vn_Reg - 1;

            RETURN TRUE;

        EXCEPTION
            WHEN ERROR_PROCESO THEN
                        SV_error := 4;
                        SV_sqlcode := '-3000';
                        SV_sqlerrm := 'Parámetros ingresados no válidos';
                        RETURN FALSE;
                WHEN OTHERS THEN
                        SV_error := 4;
                        SV_sqlcode := SQLCODE;
                        SV_sqlerrm := SQLERRM;
                        RETURN FALSE;


END PV_REC_SERV_FN;

--------------------------------------------------------------------------------

FUNCTION PV_VALIDA_SERVICIO_FN (EV_CodServicio     IN GA_SERVSUPL.COD_SERVICIO%TYPE,
                                                                EV_CodGrupo                IN GA_SERVSUPL.COD_SERVSUPL%TYPE,
                                                                EN_CodNivel                IN GA_SERVSUPL.COD_NIVEL%TYPE,
                                                                SV_ERROR           OUT VARCHAR2,
                                                                SV_PROC            OUT VARCHAR2,
                                                    SV_TABLA           OUT VARCHAR2,
                                                        SV_ACT                 OUT VARCHAR2,
                                                    SV_SQLCODE         OUT VARCHAR2,
                                                    SV_SQLERRM         OUT VARCHAR2
                                                    ) RETURN BOOLEAN
/*
<DOC>
<NOMBRE>      PV_VALIDA_SERVICIO_FN                         </NOMBRE>
<FECHACREA>   14/10/2004                                         </FECHACREA>
<MODULO>      POSTVENTA                                          </MODULO>
<AUTOR>       Hector Perez Guzman                                </AUTOR>
<VERSION>     1.0.0                                              </VERSION>
<DESCRIPCION>                                                                                                    </DESCRIPCION>
<FECHAMOD>                                                           </FECHAMOD>
<DESCMOD>                                                                                                        </DESCMOD>
<ParamEntr>                                                                                              </ParamEntr>
<ParamSal>                                                                                               </ParamSal>
<ParamSal>    SV_error: Codgio Error Controlado                  </ParamSal>
<ParamSal>    SV_proc: Nombre Procedimiento                      </ParamSal>
<ParamSal>    SV_tabla: Nombre Tabla                             </ParamSal>
<ParamSal>    SV_act: Accion Efectuada sobre la Tabla            </ParamSal>
<ParamSal>    SV_sqlcode: Codigo Error Oracle                    </ParamSal>
<ParamSal>    SV_sqlerrm: Mensaje Error Oracle                   </ParamSal>
</DOC>
*/
IS
  vn_Valor   NUMBER(1);
BEGIN
           SV_error   := '0';
           SV_proc        := 'PV_VALIDA_SERVICIO_FN';
           SV_act         := 'S';
           SV_tabla   := 'GA_SERVSUPL';

                SELECT COUNT(1) INTO vn_Valor
                FROM  GA_SERVSUPL
                WHERE COD_SERVICIO = EV_CodServicio
                AND   COD_SERVSUPL = EV_CodGrupo
                AND   COD_NIVEL    = EN_CodNivel;


                IF vn_Valor = 0 THEN
                           RETURN FALSE;
                ELSE
                           RETURN TRUE;
                END IF;

           EXCEPTION
                                WHEN OTHERS THEN
                                         SV_error := 4;
                                         SV_sqlcode := SQLCODE;
                                         SV_sqlerrm := SQLERRM;
                                         RETURN FALSE;

END PV_VALIDA_SERVICIO_FN;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION PV_VALIDA_CICLO_VIG_FN     (EN_COD_CLIENTE      IN GA_CLIENTE_PCOM.COD_PLANCOM%TYPE,
                                     EN_NUM_ABONADO      IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                        EN_COD_CICLFACT     IN FA_CICLFACT.COD_CICLFACT%TYPE,
                                       SN_cod_retorno      OUT NOCOPY  ge_errores_pg.CodError,
                                       SV_mens_retorno     OUT NOCOPY  ge_errores_pg.MsgError,
                                       SN_num_evento       OUT NOCOPY  ge_errores_pg.Evento
)
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "ge_valida_ciclo_fn"
      Lenguaje="PL/SQL"
      Fecha="27-04-2005"
      Versión="1.0"
      Diseñador="Fernando Garcia"
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Valida ciclo de facturación de un abonado. Migración al estándar de PV_VALIDA_CICLO_VIG_FN</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_cliente"     Tipo="NUMERICO">Codigo del Cliente</param>
            <param nom="EN_num_abonado"     Tipo="NUMERICO">Secuencia nro del abonado</param>
            <param nom="EN_cod_ciclfact"       Tipo="NUMERICO">Codigo del ciclo de facturación</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"       Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"      Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"        Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
RETURN  BOOLEAN
AS
    LV_des_error         ge_errores_pg.DesEvent;
    LV_Sql               ge_errores_pg.vQuery;
       LN_reg                 NUMBER;
       error_ejec_omensaje  EXCEPTION;

BEGIN
     SN_cod_retorno:=0;
     SN_num_evento:= 0;
     SV_mens_retorno:=NULL;
     LN_reg:=0;

     LV_Sql:='SELECT COUNT(1) '||
             ' FROM GA_INFACCEL A'||
             ' WHERE A.COD_CLIENTE='||EN_COD_CLIENTE||
             ' AND A.NUM_ABONADO='||EN_NUM_ABONADO||
             ' AND A.COD_CICLFACT='||EN_COD_CICLFACT;

     SELECT COUNT(1)  INTO LN_reg
       FROM GA_INFACCEL A
      WHERE A.COD_CLIENTE  = EN_COD_CLIENTE
        AND A.NUM_ABONADO  = EN_NUM_ABONADO
        AND A.COD_CICLFACT = EN_COD_CICLFACT;

       IF LN_reg = 0 THEN
          RAISE error_ejec_omensaje;
       END IF;
       RETURN  TRUE;

EXCEPTION
WHEN error_ejec_omensaje THEN
                SN_cod_retorno:=310;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasIF;
                END IF;
                LV_des_error:='error_ejec_omensaje:PV_VALIDA_CICLO_VIG_FN ('||EN_COD_CLIENTE||','||EN_NUM_ABONADO||','||EN_COD_CICLFACT||')- '||substr(SQLERRM,1,50);
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'PV_GENERAL_OOSS_PG.PV_VALIDA_CICLO_VIG_FN ', LV_Sql , SQLCODE, LV_des_error );
                RETURN FALSE;
WHEN OTHERS  THEN
                SN_cod_retorno:=302;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasIF;
                END IF;
                LV_des_error:='OTHER:PV_VALIDA_CICLO_VIG_FN ('||EN_COD_CLIENTE||','||EN_NUM_ABONADO||','||EN_COD_CICLFACT||')- '||substr(SQLERRM,1,50);
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'PV_GENERAL_OOSS_PG.PV_VALIDA_CICLO_VIG_FN ', LV_Sql , SQLCODE, LV_des_error );
                RETURN FALSE;
END PV_VALIDA_CICLO_VIG_FN;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION PV_CNV_MONEDAS_FN             (EN_COD_CONCEPTO   IN         GA_ACTUASERV.COD_CONCEPTO%TYPE,
                                           EV_COD_MONEDA     IN         GA_TARIFAS.COD_MONEDA%TYPE,
                                           EN_IMP_TARIFA     IN         GA_TARIFAS.IMP_TARIFA%TYPE,
                                        SN_convertido      OUT NOCOPY GA_TARIFAS.IMP_TARIFA%TYPE,
                                        SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                           SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                           SN_num_evento     OUT NOCOPY ge_errores_pg.Evento
)
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "PV_CNV_MONEDAS_FN"
      Lenguaje="PL/SQL"
      Fecha="16-11-2005"
      Versión="1.0"
      Diseñador="Jubitza Villanueva G."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Conversión de moneda para un monto. Migración al estándar de PV_CNV_MONEDAS_FN </Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_concepto"       Tipo="NUMERICO">Concepto facturable</param>
            <param nom="EV_cod_moneda"         Tipo="CARACTER">Código de moneda</param>
            <param nom="EN_imp_tarifa"        Tipo="NUMERICO">Importe de tarifa</param>
         </Entrada>
         <Salida>
            <param nom="SN_convertido         Tipo="NUMERICO">Importe de tarifa convertido a otra moneda</param>
            <param nom="SN_cod_retorno"       Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"      Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"        Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
RETURN BOOLEAN
AS
        error_ejecucion       EXCEPTION;
        error_ejec_omensaje   EXCEPTION;
        LV_des_error          ge_errores_pg.DesEvent;
        LV_Sql                ge_errores_pg.vQuery;
        LV_cod_moneda          GA_TARIFAS.COD_MONEDA%TYPE;
        LN_cambio_origen      ge_conversion.cambio%TYPE;
        LN_cambio_destino      ge_conversion.cambio%TYPE;

BEGIN
        SN_cod_retorno:=0;
        SN_num_evento:=0;
        SV_mens_retorno:=NULL;
        SN_convertido:=0;
        LV_cod_moneda:=NULL;
        LN_cambio_origen:=0;
        LN_cambio_destino:=0;

        --Obtener moneda del concepto....
        LV_Sql:='PV_OBTENER_MONEDA_FN('||EN_COD_CONCEPTO||')';
        IF NOT PV_OBTENER_MONEDA_FN(EN_COD_CONCEPTO,LV_COD_MONEDA,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
           RAISE error_ejecucion;
        END IF;

        LV_Sql:='IF EV_cod_moneda = LV_cod_moneda ';
        IF EV_cod_moneda = LV_cod_moneda THEN
           SN_convertido:=EN_IMP_TARIFA;
           RETURN TRUE;
        END IF;

        --Obtener cambio moneda origen...
        LV_Sql:='Moneda origen..EV_cod_moneda: PV_OBTENER_CAMBIO_MONEDA_FN('||EV_cod_moneda||')';
        IF NOT PV_OBTENER_CAMBIO_MONEDA_FN(EV_cod_moneda,LN_cambio_origen,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
           RAISE error_ejecucion;
        END IF;

        --Obtener cambio moneda destino..
        LV_Sql:='Moneda destino..LV_cod_moneda: PV_OBTENER_CAMBIO_MONEDA_FN('||LV_cod_moneda||')';
        IF NOT PV_OBTENER_CAMBIO_MONEDA_FN(LV_cod_moneda,LN_cambio_destino,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
           RAISE error_ejecucion;
        END IF;

        --Calcular conversión de importe de tarifa....
        LV_Sql:='IF LN_cambio_destino <> 0...LN_cambio_destino='||LN_cambio_destino;
        IF LN_cambio_destino <> 0 THEN
           LV_Sql:='SN_convertido:=('||EN_imp_tarifa||' * '|| LN_cambio_origen||')/'||LN_cambio_destino;
           SN_convertido:=(EN_imp_tarifa * LN_cambio_origen)/LN_cambio_destino;
        ELSE
           RAISE error_ejec_omensaje;
        END IF;
        RETURN TRUE;

EXCEPTION
WHEN error_ejecucion THEN
                LV_des_error:='error_ejecucion:PV_CNV_MONEDAS_FN('||EN_cod_concepto||','||EV_cod_moneda||','||EN_imp_tarifa||')';
                SN_num_evento:= Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno,'1.0', USER, 'GA_ADM_NUM_FREC_GENERAL_PG.PV_CNV_MONEDAS_FN', LV_Sql , SQLCODE, LV_des_error );
                RETURN  FALSE;
WHEN error_ejec_omensaje THEN
                SN_cod_retorno:=302;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno:=CV_error_no_clasIF;
                END IF;
                LV_des_error:='error_ejec_omensaje:PV_CNV_MONEDAS_FN('||EN_cod_concepto||','||EV_cod_moneda||','||EN_imp_tarifa||')';
                SN_num_evento:= Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno,'1.0', USER, 'PV_GENERAL_OOSS_PG.error_ejec_omensaje', LV_Sql , SQLCODE, LV_des_error );
                RETURN  FALSE;
WHEN OTHERS THEN
                SN_cod_retorno:=302;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno:=CV_error_no_clasIF;
                END IF;
                LV_des_error:='OTHERS:PV_CNV_MONEDAS_FN('||EN_cod_concepto||','||EV_cod_moneda||','||EN_imp_tarifa||')- '||substr(SQLERRM,1,50);
                SN_num_evento:= Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno,'1.0', USER, 'PV_GENERAL_OOSS_PG.PV_CNV_MONEDAS_FN', LV_Sql , SQLCODE, LV_des_error );
                RETURN  FALSE;
END PV_CNV_MONEDAS_FN;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION PV_INSERTA_CARGOS_FN        (EN_COD_CLIENTE    IN         GA_ABOCEL.COD_CLIENTE%TYPE,
                                      EN_COD_PRODUCTO   IN         GA_ABOCEL.COD_PRODUCTO%TYPE,
                                      EN_NUM_ABONADO    IN            GA_ABOCEL.NUM_ABONADO%TYPE,
                                      EN_NUM_TERMINAL   IN            GA_ABOCEL.NUM_CELULAR%TYPE,
                                      EN_COD_PLANCOM    IN            GA_CLIENTE_PCOM.COD_PLANCOM%TYPE,
                                      ED_FEC_ALTA       IN            GA_ABOCEL.FEC_ALTA%TYPE,
                                      EN_COD_CICLFACT   IN            FA_CICLFACT.COD_CICLFACT%TYPE,
                                      EV_COD_CONCEPTO   IN            GE_CARGOS.COD_CONCEPTO%TYPE,
                                      EN_IMP_CARGO      IN            GE_CARGOS.IMP_CARGO%TYPE,
                                      EV_COD_MONEDA     IN            GE_CARGOS.COD_MONEDA%TYPE,
                                      EV_USUARIO        IN            GE_CARGOS.NOM_USUARORA%TYPE,
                                      EN_ind_cuota      IN            GE_CARGOS.IND_CUOTA%TYPE,
                                      SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                         SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                         SN_num_evento     OUT NOCOPY ge_errores_pg.Evento
)
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "PV_INSERTA_CARGOS_FN "
      Lenguaje="PL/SQL"
      Fecha="16-11-2005"
      Versión="1.0"
      Diseñador="Jubitza Villanueva G."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Insertar cargo. Migración al estándar de PV_INSERTA_CARGOS_FN </Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_cliente"       Tipo="NUMERICO">Código de cliente</param>
            <param nom="EN_cod_producto"      Tipo="NUMERICO">Código de producto</param>
            <param nom="EN_num_abonado"       Tipo="NUMERICO">nro abonado</param>
            <param nom="EN_num_terminal"      Tipo="NUMERICO">nro celular</param>
            <param nom="EN_cod_plancom"       Tipo="NUMERICO">Plan comercial</param>
            <param nom="ED_FEC_ALTA"          Tipo="FECHA">Fecha de inserción</param>
            <param nom="EN_cod_ciclfact"      Tipo="NUMERICO">Código de ciclo de facturación</param>
            <param nom="EN_cod_concepto"       Tipo="NUMERICO">Concepto facturable</param>
            <param nom="EN_IMP_CARGO"          Tipo="NUMERICO">Importe de tarifa</param>
            <param nom="EV_cod_moneda"         Tipo="CARACTER">Código de moneda</param>
            <param nom="EV_USUARIO"            Tipo="CARACTER">Usuario</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"       Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"      Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"        Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
RETURN BOOLEAN
AS
        LV_des_error          ge_errores_pg.DesEvent;
        LV_Sql                ge_errores_pg.vQuery;

BEGIN
        SN_cod_retorno:=0;
        SN_num_evento:=0;
        SV_mens_retorno:=NULL;

        LV_Sql:='INSERT INTO GE_CARGOS (NUM_CARGO,COD_CLIENTE,COD_PRODUCTO,'||
                ' NUM_ABONADO,NUM_TERMINAL,COD_PLANCOM,'||
                ' COD_CICLFACT,IND_FACTUR,FEC_ALTA,'||
                ' COD_CONCEPTO,NUM_UNIDADES,IMP_CARGO,'||
                ' COD_MONEDA,IND_CUOTA,NOM_USUARORA)'||
                ' VALUES  (GE_SEQ_CARGOS.NEXTVAL,'||EN_COD_CLIENTE||','||EN_COD_PRODUCTO||','||
                   EN_NUM_ABONADO||','||EN_NUM_TERMINAL||','||EN_COD_PLANCOM||','||
                   EN_COD_CICLFACT||',1,'||ED_FEC_ALTA||','||
                   EV_COD_CONCEPTO||',1,'||EN_IMP_CARGO||','||
                   EV_COD_MONEDA||','||EN_ind_cuota||','||EV_USUARIO||')';

        INSERT INTO GE_CARGOS (NUM_CARGO,COD_CLIENTE,COD_PRODUCTO,
                NUM_ABONADO,NUM_TERMINAL,COD_PLANCOM,
                COD_CICLFACT,IND_FACTUR,FEC_ALTA,
                COD_CONCEPTO,NUM_UNIDADES,IMP_CARGO,
                COD_MONEDA,IND_CUOTA,NOM_USUARORA)
        VALUES  (GE_SEQ_CARGOS.NEXTVAL,  EN_COD_CLIENTE, EN_COD_PRODUCTO,
                 EN_NUM_ABONADO,EN_NUM_TERMINAL, EN_COD_PLANCOM,
                 EN_COD_CICLFACT,1,ED_FEC_ALTA,
                 EV_COD_CONCEPTO,1,EN_IMP_CARGO,
                 EV_COD_MONEDA,EN_ind_cuota,EV_USUARIO);

        RETURN TRUE;

EXCEPTION
WHEN OTHERS THEN
                SN_cod_retorno:=302;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno:=CV_error_no_clasIF;
                END IF;
                LV_des_error:='OTHERS:PV_INSERTA_CARGOS_FN('||EN_cod_cliente||','||EN_num_abonado||')- '||substr(SQLERRM,1,50);
                SN_num_evento:= Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno,'1.0', USER, 'PV_GENERAL_OOSS_PG.PV_INSERTA_CARGOS_FN', LV_Sql , SQLCODE, LV_des_error );
                RETURN  FALSE;
END PV_INSERTA_CARGOS_FN;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION  PV_UPD_CARGOS_INFACCEL_FN    (EN_COD_CLIENTE   IN         GA_ABOCEL.COD_CLIENTE%TYPE,
                                        EN_NUM_ABONADO   IN         GA_ABOCEL.NUM_ABONADO%TYPE,
                                           EN_COD_CICLFACT  IN         FA_CICLFACT.COD_CICLFACT%TYPE,
                                           EN_ind_cargos    IN         ga_infaccel.ind_cargos%TYPE,
                                        SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                           SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                           SN_num_evento    OUT NOCOPY ge_errores_pg.Evento
)
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "PV_UPD_CARGOS_INFACCEL_FN"
      Lenguaje="PL/SQL"
      Fecha="16-11-2005"
      Versión="1.0"
      Diseñador="Jubitza Villanueva G."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Modificar indicador de cargos en ga_infaccel para un cliente-abonado.Migración al estándar de  PV_UPD_CARGOS_FN  </Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_cliente"       Tipo="NUMERICO">Código de cliente</param>
            <param nom="EN_num_abonado"       Tipo="NUMERICO">nro abonado</param>
            <param nom="EN_cod_ciclfact"      Tipo="NUMERICO">Código de ciclo de facturación</param>
            <param nom="EN_ind_cargos"        Tipo="NUMERICO">Indicador de cargos</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"       Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"      Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"        Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
RETURN BOOLEAN
AS
        error_ejec_omensaje  EXCEPTION;
        LV_des_error         ge_errores_pg.DesEvent;
        LV_Sql               ge_errores_pg.vQuery;
BEGIN
        SN_cod_retorno:=0;
        SN_num_evento:=0;
        SV_mens_retorno:=NULL;

        LV_Sql:='UPDATE GA_INFACCEL A '||
                   ' SET A.IND_CARGOS='||EN_ind_cargos||
                 ' WHERE A.COD_CLIENTE='||EN_COD_CLIENTE||
                   ' AND A.NUM_ABONADO='||EN_NUM_ABONADO||
                   ' AND A.COD_CICLFACT='||EN_COD_CICLFACT;
        UPDATE GA_INFACCEL  A
           SET A.IND_CARGOS=EN_ind_cargos
         WHERE A.COD_CLIENTE=EN_COD_CLIENTE
           AND A.NUM_ABONADO=EN_NUM_ABONADO
           AND A.COD_CICLFACT=EN_COD_CICLFACT;

        LV_Sql:=' IF SQL%ROWCOUNT=0 ';
        IF SQL%ROWCOUNT=0 THEN
           RAISE error_ejec_omensaje;
        END IF;
        RETURN TRUE;

EXCEPTION
WHEN error_ejec_omensaje THEN
                SN_cod_retorno:=302;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno:=CV_error_no_clasIF;
                END IF;
                LV_des_error:='error_ejec_omensaje:PV_UPD_CARGOS_INFACCEL_FN('||EN_cod_cliente||','||EN_num_abonado||','||EN_cod_ciclfact||')';
                SN_num_evento:= Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno,'1.0', USER, 'GA_ADM_NUM_FREC_GENERAL_PG.PV_UPD_CARGOS_INFACCEL_FN', LV_Sql , SQLCODE, LV_des_error );
                RETURN  FALSE;
WHEN OTHERS THEN
                SN_cod_retorno:=302;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno:=CV_error_no_clasIF;
                END IF;
                LV_des_error:='OTHERS:PV_UPD_CARGOS_INFACCEL_FN('||EN_cod_cliente||','||EN_num_abonado||','||EN_cod_ciclfact||')- '||substr(SQLERRM,1,50);
                SN_num_evento:= Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno,'1.0', USER, 'PV_GENERAL_OOSS_PG.PV_UPD_CARGOS_INFACCEL_FN', LV_Sql , SQLCODE, LV_des_error );
                RETURN  FALSE;
END PV_UPD_CARGOS_INFACCEL_FN;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION PV_OBTENER_CAMBIO_MONEDA_FN   (EV_COD_MONEDA     IN         GA_TARIFAS.COD_MONEDA%TYPE,
                                           SN_cambio         OUT NOCOPY GE_CONVERSION.cambio%TYPE,
                                        SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                           SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                           SN_num_evento     OUT NOCOPY ge_errores_pg.Evento
)
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "PV_OBTENER_CAMBIO_MONEDA_FN"
      Lenguaje="PL/SQL"
      Fecha="16-11-2005"
      Versión="1.0"
      Diseñador="Jubitza Villanueva G."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Obtener cambio de conversión para una moneda.Nueva </Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EV_cod_moneda"         Tipo="CARACTER">Código de moneda</param>
         </Entrada>
         <Salida>
            <param nom="SN_cambio"            Tipo="NUMERICO">Cambio de conversión</param>
            <param nom="SN_cod_retorno"       Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"      Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"        Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
RETURN BOOLEAN
AS
        LV_des_error         ge_errores_pg.DesEvent;
        LV_Sql               ge_errores_pg.vQuery;
BEGIN
        SN_cod_retorno:=0;
        SN_num_evento:=0;
        SV_mens_retorno:=NULL;
        SN_cambio:=0;

        LV_Sql:='SELECT a.CAMBIO INTO SN_cambio '||
                ' FROM GE_CONVERSION a '||
                   ' WHERE a.COD_MONEDA='''||EV_cod_moneda||''||
                  ' AND SYSDATE BETWEEN a.FEC_DESDE AND a.FEC_HASTA';

       SELECT a.CAMBIO
         INTO SN_cambio
         FROM GE_CONVERSION a
        WHERE a.COD_MONEDA = EV_cod_moneda
          AND SYSDATE BETWEEN a.FEC_DESDE AND a.FEC_HASTA;

        RETURN TRUE;

EXCEPTION
WHEN OTHERS THEN
                SN_cod_retorno:=302;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno:=CV_error_no_clasIF;
                END IF;
                LV_des_error:='OTHERS:PV_OBTENER_CAMBIO_MONEDA_FN('||EV_cod_moneda||')- '||substr(SQLERRM,1,50);
                SN_num_evento:= Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno,'1.0', USER, 'PV_GENERAL_OOSS_PG.PV_OBTENER_CAMBIO_MONEDA_FN', LV_Sql , SQLCODE, LV_des_error );
                RETURN  FALSE;
END PV_OBTENER_CAMBIO_MONEDA_FN;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION PV_OBTENER_MONEDA_FN          (EN_COD_CONCEPTO   IN         GA_ACTUASERV.COD_CONCEPTO%TYPE,
                                           SV_COD_MONEDA     OUT NOCOPY GA_TARIFAS.COD_MONEDA%TYPE,
                                        SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                           SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                           SN_num_evento     OUT NOCOPY ge_errores_pg.Evento
)
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "PV_OBTENER_MONEDA_FN"
      Lenguaje="PL/SQL"
      Fecha="16-11-2005"
      Versión="1.0"
      Diseñador="Jubitza Villanueva G."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Obtener código de moneda para un concepto de facturación. Nueva</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_concepto"       Tipo="NUMERICO">Concepto facturable</param>
         </Entrada>
         <Salida>
            <param nom="SV_cod_moneda"         Tipo="CARACTER">Código de moneda</param>
            <param nom="SN_cod_retorno"       Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"      Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"        Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
RETURN BOOLEAN
AS
        LV_des_error         ge_errores_pg.DesEvent;
        LV_Sql               ge_errores_pg.vQuery;
BEGIN
        SN_cod_retorno:=0;
        SN_num_evento:=0;
        SV_mens_retorno:=NULL;
        SV_cod_moneda:=NULL;

        LV_Sql:='SELECT A.COD_MONEDA INTO SV_cod_moneda '||
                     ' FROM FA_CONCEPTOS A, GE_MONEDAS B '||
                    ' WHERE A.COD_CONCEPTO='||EN_COD_CONCEPTO||
                      ' AND A.COD_MONEDA=B.COD_MONEDA';

        SELECT A.COD_MONEDA
          INTO SV_cod_moneda
             FROM FA_CONCEPTOS A,GE_MONEDAS B
            WHERE A.COD_CONCEPTO=EN_COD_CONCEPTO
              AND A.COD_MONEDA=B.COD_MONEDA;

         RETURN TRUE;

EXCEPTION
WHEN OTHERS THEN
                SN_cod_retorno:=302;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno:=CV_error_no_clasIF;
                END IF;
                LV_des_error:='OTHERS:PV_OBTENER_MONEDA_FN('||EN_cod_concepto||')- '||substr(SQLERRM,1,50);
                SN_num_evento:= Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno,'1.0', USER, 'PV_GENERAL_OOSS_PG.PV_OBTENER_MONEDA_FN', LV_Sql , SQLCODE, LV_des_error );
                RETURN  FALSE;
END PV_OBTENER_MONEDA_FN;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--INI COL-77866|05-05-2009|GEZ
    PROCEDURE pv_audreg_pr (                        EVModulo             IN                ge_aud_regulariza_td.cod_modulo%TYPE,
                                  ENNumInter          IN            ge_aud_regulariza_td.num_inter%TYPE,
                            ENTipInter          IN            ge_aud_regulariza_td.tip_inter%TYPE,
                            ENEstado          IN            ge_aud_regulariza_td.cod_estado%TYPE,
                            EVIncidencia              IN            ge_aud_regulariza_td.cod_incidencia%TYPE,
                            EVTipModi          IN            ge_aud_regulariza_td.cod_tipmodi%TYPE,
                            EVCodOs              IN            ge_aud_regulariza_td.cod_os%TYPE,
                            EVDesEstado          IN            ge_aud_regulariza_td.des_estado%TYPE,
                            EVObserv          IN            ge_aud_regulariza_td.observacion%TYPE,
                            EVNomProc          IN            ge_aud_regulariza_td.nom_proc_prog%TYPE,
                            EVTabla              IN            ge_aud_regulariza_td.nom_tabla%TYPE,
                            EVAct              IN            ge_aud_regulariza_td.cod_act%TYPE,
                            ENEvento          IN            ge_aud_regulariza_td.num_evento%TYPE,
                            EVSqlCode          IN            ge_aud_regulariza_td.cod_sqlcode%TYPE,
                            EVSqlerrm          IN            ge_aud_regulariza_td.cod_sqlerrm%TYPE,
                            ENAuditoria          IN            NUMBER,
                            SNEstado          OUT NOCOPY   NUMBER,
                            SVCode              OUT NOCOPY   VARCHAR2,
                            SVErrm              OUT NOCOPY   VARCHAR2
                        ) IS

    /*
    <Documentación TipoDoc = "PROCEDIMIENTO">
        <Elemento Nombre = "pv_audreg_pr" Lenguaje="PL/SQL" Fecha="02-10-2008" Versión="1.0" Diseñador="German Espinoza Z." Programador="German Espinoza Z.">
            <Retorno>N/A</Retorno>
            <Descripción>Procedimiento que deja registro en la tabla ge_aud_regulariza_td</Descripción>
            <Parámetros>
                <Entrada>
                    <param nom="EVModulo"     Tipo="VARCHAR2">Modulo que esta registrando el Registro PV: postventa, VE: Ventas, TOL: Tasacion, FA:Facturacion, etc          </param>
                    <param nom="ENNumInter"   Tipo="NUMBER"  >Numero del Dato principal a guardar                                                                                              </param>
                    <param nom="ENTipInter"   Tipo="NUMBER"     >Tipo de Dato a registrar en el campo num_inter 1: abonado, 8: cliente,6: usuario, 10: num_cargo, 11: num_venta </param>
                    <param nom="ENEstado"       Tipo="NUMBER"     >Valor a almacenar en el campo cod_estado, ideal 3: ok, 4: error                                                   </param>
                    <param nom="EVIncidencia" Tipo="VARCHAR2">codigo de incidencia asociado al ingreso del registro                                                            </param>
                    <param nom="EVTipModi"       Tipo="VARCHAR2">codigo del tipo de modificacion a ingresar                                                                     </param>
                    <param nom="EVCodOs"       Tipo="VARCHAR2">codigo de os que se esta procesando                                                                             </param>
                    <param nom="EVDesEstado"  Tipo="VARCHAR2">Descripcion del proceso en donde ocurre el evento                                                                  </param>
                    <param nom="EVObserv"        Tipo="VARCHAR2">Observacion al evento                                                                                              </param>
                    <param nom="EVNomProc"       Tipo="VARCHAR2">nombre del proceso en donde ocurre el evento                                                                     </param>
                    <param nom="EVTabla"       Tipo="VARCHAR2">nombre de la tabla en donde ocurre el evento                                                                     </param>
                    <param nom="EVAct"             Tipo="VARCHAR2">accion sobre la tabla en donde ocurre el evento                                                                 </param>
                    <param nom="ENEvento"        Tipo="NUMBER"  >numero de evento registrado                                                                                      </param>
                    <param nom="EVSqlCode"       Tipo="VARCHAR2">codigo del error oracle a registrar                                                                              </param>
                    <param nom="EVSqlerrm"       Tipo="VARCHAR2">error oracle observacion al evento registrado                                                                      </param>
                    <param nom="ENAuditoria"  Tipo="NUMBER"  >0: no lleva auditoria 1: tiene auditoria                                                                           </param>
                </Entrada>
                <Salida>
                    <param nom="SVEstado" Tipo="NUMBER"  >Resultado 3: OK, 4: Error programa, 5: error validacion </param>
                    <param nom="SVCode"   Tipo="VARCHAR2">Codigo del Error Oracle                                          </param>
                    <param nom="SVErrm"   Tipo="VARCHAR2">Descripcion del Error Oracle                              </param>
                </Salida>
           </Parámetros>
        </Elemento>
    </Documentación>

    */
    PRAGMA AUTONOMOUS_TRANSACTION;

    LNIdent            ge_aud_regulariza_td.num_identificador%TYPE;
    LVUsuarioSO        ge_aud_regulariza_td.nom_usuario_so%TYPE;
    LVMaquina        ge_aud_regulariza_td.nom_maquina%TYPE;
    LVTerminal        ge_aud_regulariza_td.nom_terminal%TYPE;
    LVNomPrograma   ge_aud_regulariza_td.nom_proc_prog%TYPE;

    BEGIN
         SNEstado := '3';
         SVCode   := '0';
         SVErrm      := 'REGISTRO EXITOSO';

         IF EVModulo IS NULL THEN
             SNEstado := '5';
             SVCode   := '0';
             SVErrm     := 'NO SE ENVIA MODULO - NO SE PUEDE REGISTRAR DATOS';
         ELSE

             IF ENAuditoria=0 THEN
                 LVUsuarioSO   := NULL;
                LVMaquina      := NULL;
                LVTerminal      := NULL;
                LVNomPrograma := NULL;
             ELSIF ENAuditoria=1 THEN
                 SELECT osuser,machine,terminal,program
                   INTO   LVUsuarioSO,LVMaquina,LVTerminal,LVNomPrograma
                   FROM   v$session
                   WHERE  audsid = USERENV('sessionid');
             ELSE
                 LVUsuarioSO   := NULL;
                LVMaquina      := NULL;
                LVTerminal      := NULL;
                LVNomPrograma := NULL;
             END IF;

             SELECT ge_audreg_sq.NEXTVAL
             INTO    LNIdent
             FROM   dual;

             INSERT INTO ge_aud_regulariza_td
              (num_identificador, cod_modulo, num_inter, tip_inter, cod_estado, cod_incidencia,
                cod_tipmodi, cod_os, des_estado, observacion, nom_proc_prog, nom_tabla, cod_act, num_evento,
                cod_sqlcode, cod_sqlerrm, nom_usuario_so, nom_maquina, nom_terminal)
              VALUES
              (LNIdent,EVModulo,ENNumInter,ENTipInter,ENEstado,EVIncidencia,
              EVTipModi,EVCodOs,EVDesEstado,EVObserv,SUBSTR(EVNomProc||'-'||LVNomPrograma,1,70),EVTabla,EVAct,ENEvento,
              EVSqlCode,EVSqlerrm,LVUsuarioSO,LVMaquina,LVTerminal);

             COMMIT;

         END IF;
    EXCEPTION
        WHEN OTHERS THEN
            SNEstado := '4';
             SVCode   := SQLCODE;
             SVErrm     := SQLERRM;
    END pv_audreg_pr;

    PROCEDURE pv_audreg_sretorno_pr (
                              EVTransaccion              IN            VARCHAR2,
                            EVModulo             IN                ge_aud_regulariza_td.cod_modulo%TYPE,
                                  ENNumInter          IN            ge_aud_regulariza_td.num_inter%TYPE,
                            ENTipInter          IN            ge_aud_regulariza_td.tip_inter%TYPE,
                            ENEstado          IN            ge_aud_regulariza_td.cod_estado%TYPE,
                            EVIncidencia              IN            ge_aud_regulariza_td.cod_incidencia%TYPE,
                            EVTipModi          IN            ge_aud_regulariza_td.cod_tipmodi%TYPE,
                            EVCodOs              IN            ge_aud_regulariza_td.cod_os%TYPE,
                            EVDesEstado          IN            ge_aud_regulariza_td.des_estado%TYPE,
                            EVObserv          IN            ge_aud_regulariza_td.observacion%TYPE,
                            EVNomProc          IN            ge_aud_regulariza_td.nom_proc_prog%TYPE,
                            EVTabla              IN            ge_aud_regulariza_td.nom_tabla%TYPE,
                            EVAct              IN            ge_aud_regulariza_td.cod_act%TYPE,
                            ENEvento          IN            ge_aud_regulariza_td.num_evento%TYPE,
                            EVSqlCode          IN            ge_aud_regulariza_td.cod_sqlcode%TYPE,
                            EVSqlerrm          IN            ge_aud_regulariza_td.cod_sqlerrm%TYPE,
                            ENAuditoria          IN            NUMBER
                        ) IS
/*
<Documentación TipoDoc = "Función">
    <Elemento Nombre = "pv_audreg_sretorno_pr"
                        Lenguaje="PL/SQL" Fecha="24-11-2008" Versión="1.0" Diseñador="German Espinoza Zuñiga" Programador="German Espinoza Zuñiga" Ambiente="BD">
        <Retorno>N/A</Retorno>
        <Descripción>Registra Auditoria sin parametros de Salida para aplicaciones VB en ODBC</Descripción>
        <Parámetros>
            <Entrada>
                    <param nom="EVTransaccion"     Tipo="VARCHAR2">Numero de transaccion para respaldar resultado en ga_transacabo       </param>
                    <param nom="EVModulo"     Tipo="VARCHAR2">Modulo que esta registrando el Registro PV: postventa, VE: Ventas, TOL: Tasacion, FA:Facturacion, etc          </param>
                    <param nom="ENNumInter"   Tipo="NUMBER"  >Numero del Dato principal a guardar                                                                                              </param>
                    <param nom="ENTipInter"   Tipo="NUMBER"     >Tipo de Dato a registrar en el campo num_inter 1: abonado, 8: cliente,6: usuario, 10: num_cargo, 11: num_venta </param>
                    <param nom="ENEstado"       Tipo="NUMBER"     >Valor a almacenar en el campo cod_estado, ideal 3: ok, 4: error                                                   </param>
                    <param nom="EVIncidencia" Tipo="VARCHAR2">codigo de incidencia asociado al ingreso del registro                                                            </param>
                    <param nom="EVTipModi"       Tipo="VARCHAR2">codigo del tipo de modificacion a ingresar                                                                     </param>
                    <param nom="EVCodOs"       Tipo="VARCHAR2">codigo de os que se esta procesando                                                                             </param>
                    <param nom="EVDesEstado"  Tipo="VARCHAR2">Descripcion del proceso en donde ocurre el evento                                                                  </param>
                    <param nom="EVObserv"        Tipo="VARCHAR2">Observacion al evento                                                                                              </param>
                    <param nom="EVNomProc"       Tipo="VARCHAR2">nombre del proceso en donde ocurre el evento                                                                     </param>
                    <param nom="EVTabla"       Tipo="VARCHAR2">nombre de la tabla en donde ocurre el evento                                                                     </param>
                    <param nom="EVAct"             Tipo="VARCHAR2">accion sobre la tabla en donde ocurre el evento                                                                 </param>
                    <param nom="ENEvento"        Tipo="NUMBER"  >numero de evento registrado                                                                                      </param>
                    <param nom="EVSqlCode"       Tipo="VARCHAR2">codigo del error oracle a registrar                                                                              </param>
                    <param nom="EVSqlerrm"       Tipo="VARCHAR2">error oracle observacion al evento registrado                                                                      </param>
                    <param nom="ENAuditoria"  Tipo="NUMBER"  >0: no lleva auditoria 1: tiene auditoria                                                                           </param>
            </Entrada>
        </Parámetros>
    </Elemento>
</Documentación>
*/

    LNEstado          NUMBER;
    LVCode              VARCHAR2(2000);
    LVErrm              VARCHAR2(2000);

    BEGIN
         PV_AUDREG_PR ( EVMODULO, ENNUMINTER,ENTIPINTER,ENESTADO,EVINCIDENCIA,EVTIPMODI,
                        EVCODOS, EVDESESTADO,EVOBSERV,EVNOMPROC,EVTABLA,
                        EVACT, ENEVENTO,EVSQLCODE,EVSQLERRM,ENAUDITORIA,
                        LNEstado, LVCode,LVErrm );

        INSERT INTO GA_TRANSACABO (NUM_TRANSACCION,COD_RETORNO,DES_CADENA)
        VALUES (TO_NUMBER(EVTransaccion),LNEstado,LVErrm);

    END;
--FIN COL-77866|05-05-2009|GEZ

--INI COL-79523|06-03-2009|GEZ
PROCEDURE pv_situabo_actabo_pr(     EN_NumAbonado       IN                            ga_abocel.num_abonado%TYPE,
                                                        EV_CodActabo           IN                            pvd_actuacion_situacion.cod_actabo%TYPE,
                                                        SV_Estado                 OUT NOCOPY            VARCHAR2,
                                                        SV_Proc                      OUT NOCOPY             VARCHAR2,
                                                        SN_CodMsg               OUT NOCOPY              NUMBER,
                                                        SN_Evento                 OUT NOCOPY            NUMBER,
                                                        SV_Tabla                 OUT NOCOPY            VARCHAR2,
                                                        SV_Act                       OUT NOCOPY              VARCHAR2,
                                                        SV_Code                     OUT NOCOPY            VARCHAR2,
                                                        SV_Errm                     OUT NOCOPY            VARCHAR2) IS

LV_DesError                VARCHAR2(1000);
LV_Sql                       VARCHAR2(2000);
LV_MensajeError         VARCHAR2(2000);

LN_Cont                   NUMBER;

LV_CodSituacionAbo   ga_abocel.cod_situacion%TYPE;

BEGIN
     SV_Estado       := '3';
     SV_Proc        := 'PV_SITUABO_ACTABO_PR';
     SN_CodMsg     := 0;
     SN_Evento       := 0;
     SV_Code       := '0';
     SV_Errm       := '0';

     LV_DesError := 'PV_SITUABO_ACTABO_PR(' || EN_NumAbonado || ',' || EV_CodActabo ||')';

     SV_Tabla     :='ABOCEL/ABOAMIST';
     SV_Act        :='S';

     LV_Sql:=' SELECT cod_situacion FROM ga_abocel ';
     LV_Sql:=LV_Sql ||' WHERE num_abonado='||EN_NumAbonado;
     LV_Sql:=LV_Sql ||' UNION ALL SELECT cod_situacion FROM ga_aboamist ';
     LV_Sql:=LV_Sql ||' WHERE num_abonado='||EN_NumAbonado;

     EXECUTE IMMEDIATE LV_Sql INTO LV_CodSituacionAbo;

     SV_Tabla     :='PVD_ACTUACION_SITUACION';
     SV_Act        :='S';

     LV_Sql:=' SELECT COUNT(1) FROM pvd_actuacion_situacion WHERE cod_actabo='''||EV_CodActabo||''' AND cod_situacion='''||LV_CodSituacionAbo||'''';

     EXECUTE IMMEDIATE LV_Sql INTO LN_Cont;

     IF LN_Cont=0 THEN
                   SV_Estado    :='5';
                  SN_CodMsg := 844;
     ELSE
                  SV_Estado    :='3';
     END IF;

EXCEPTION

    WHEN OTHERS THEN
        SV_Estado    :='4';
        SV_Code        :=SQLCODE;
        SV_Errm        :=SQLERRM;

        SN_CodMsg := 2735;

        IF NOT ge_errores_pg.mensajeerror(SN_CodMsg, LV_MensajeError) THEN
           LV_MensajeError := 'Error No Clasificado';
        END IF;

        LV_DesError :=LV_DesError ||'-T:'||SV_Tabla;
        LV_DesError :=LV_DesError ||'('||SV_Act||')';
        LV_DesError :=LV_DesError ||'-'|| SV_Errm;

        SN_Evento := ge_errores_pg.grabarpl( SN_Evento,'PV',LV_MensajeError,'1.0',USER,'pv_situabo_actabo_pr',LV_Sql,SN_CodMsg,LV_DesError);

END pv_situabo_actabo_pr;
--FIN COL-79523|06-03-2009|GEZ

END PV_GENERAL_OOSS_PG;
/
