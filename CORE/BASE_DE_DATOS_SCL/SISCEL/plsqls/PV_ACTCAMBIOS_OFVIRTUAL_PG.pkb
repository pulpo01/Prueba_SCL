CREATE OR REPLACE PACKAGE BODY PV_ACTCAMBIOS_OFVIRTUAL_PG
IS


/*
<NOMBRE>       : PV_actcambios_ofvirtual_PG</NOMBRE>
<FECHACREA>    : 11/11/2005<FECHACREA/>
<MODULO >      : PV</MODULO >
<AUTOR >       : ANONIMO</AUTOR >
<VERSION >     : 1.2</VERSION >
<DESCRIPCION>  : RUTINAS DE ACTUALIZACION DE CAMBIOS DE OFICINA VIRTUAL</DESCRIPCION>
<FECHAMOD >    : 30/01/2006 </FECHAMOD >
<DESCMOD >     : Se modifica procedimiento PV_cargos_ciclo_PR para que NÀmero de serie sea opcional XC-200601180989</DESCMOD>
<FECHAMOD >    : 04/10/2006 </FECHAMOD >
<DESCMOD >     : Se modifica procedimiento PV_cambioserie_PR, se vuelve a generar la clase servicio del abonado, TMC 34328</DESCMOD>
*/

---------------------------------------
--V1.1 INC 160153 GUA JRCH 28-12-2010
---------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_desc_cadena_transacabo_FN(
                            EV_cadena             IN  GA_TRANSACABO.des_cadena%TYPE ,
                            SV_cadena_descom    OUT NOCOPY   arreglo,
                            SN_cod_retorno      OUT NOCOPY   ge_errores_pg.codError,
                            SV_mens_retorno     OUT NOCOPY   ge_errores_pg.MsgError,
                            SN_num_evento       OUT NOCOPY   ge_errores_pg.Evento)
/*
<Documentaci¥n
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "PV_desc_cadena_transacabo_FN"
      Lenguaje="PL/SQL"
      Fecha="05/05/2008"
      Versi¥n="1.0"
      Dise¿ador="Joan Zamorano"
      Programador=""
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripci¥n>Permite descomponer la cadena entregada por la ejecuci¥n de un PL que deje datos en la tabla GA_TRANSACABO</Descripci¥n>
      <Par¿metros>
         <Entrada>
            <param nom="EV_cadena  Tipo="CARACTER">Cadena a decomponer</param>
         </Entrada>
         <Salida>
            <param nom="SV_cadena_descom"   Tipo="ARREGLO">Arreglo con los valores ya descompuestos entregados por la cadena ingresada</param>
            <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"      Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Par¿metros>
   </Elemento>
</Documentaci¥n>
*/
IS
     LV_des_error                     ge_errores_pg.DesEvent;
     LV_sSql                         ge_errores_pg.vQuery;
     CV_num_version                     CONSTANT VARCHAR2(5) :='1.0';
     LN_largoCadena                     NUMBER;
     LN_posicion_ini                 NUMBER;
     LN_posicion_fin                 NUMBER;
     LV_caracter_separador             VARCHAR2(1):='/';
     LV_pos                             NUMBER:=1;

       BEGIN
          LN_posicion_ini     := 2;
          LN_largoCadena:= LENGTH(EV_cadena);
          SV_cadena_descom := arreglo();

          WHILE (LN_posicion_ini <= LN_largoCadena) LOOP
                  SV_cadena_descom.EXTEND;
                LN_posicion_fin          := INSTR(EV_cadena, LV_caracter_separador, LN_posicion_ini, 1);
                SV_cadena_descom(LV_pos):= SUBSTR(EV_cadena, LN_posicion_ini, LN_posicion_fin - LN_posicion_ini);
                LN_posicion_ini         := LN_posicion_fin + 1;
                LV_pos                    := LV_pos + 1;
          END LOOP;

     EXCEPTION
     WHEN OTHERS  THEN
           SN_cod_retorno  := '';
           IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno ,SV_mens_retorno) THEN
                SV_mens_retorno :=CV_error_no_clasIF;
           END IF;
           LV_des_error := SUBSTR('PV_desc_cadena_transacabo_FN(...); - ' || SQLERRM,1,CN_largoerrtec);
           SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
           SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_num_version, USER,
                                                        'Pv_Actcambios_Ofvirtual_Pg.PV_desc_cadena_transacabo_FN', LV_sSql, SQLCODE, SV_mens_retorno );
END  PV_desc_cadena_transacabo_FN;
-------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_obtiene_grupo_tecnologia_FN(
                            EV_cod_tecnologia    IN  AL_TECNOLOGIA.cod_tecnologia%TYPE,
                            SV_cod_grupo        OUT NOCOPY   AL_TECNOLOGIA.cod_grupo%TYPE,
                            SN_cod_retorno      OUT NOCOPY   ge_errores_pg.codError,
                            SV_mens_retorno     OUT NOCOPY   ge_errores_pg.MsgError,
                            SN_num_evento       OUT NOCOPY   ge_errores_pg.Evento)
/*
<Documentaci¥n
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "PV_obtiene_grupo_tecnologia_FN"
      Lenguaje="PL/SQL"
      Fecha="15-11-2005"
      Versi¥n="1.0"
      Dise¿ador="Joan Zamorano"
      Programador=""
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripci¥n>Obtiene el c¥digo de grupo asociado a la tecnolog¿a</Descripci¥n>
      <Par¿metros>
         <Entrada>
            <param nom="EV_cod_tecnologia"  Tipo="CARACTER">C¥digo de tecnolog¿a</param>
         </Entrada>
         <Salida>
            <param nom="SV_cod_grupo"       Tipo="CARACTER">C¥digo del grupo asociado a la tecnolog¿a</param>
            <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"      Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Par¿metros>
   </Elemento>
</Documentaci¥n>
*/
IS
     LV_des_error                     ge_errores_pg.DesEvent;
     LV_sSql                         ge_errores_pg.vQuery;
     CV_num_version                     CONSTANT VARCHAR2(5) :='1.0';

       BEGIN

         LV_sSql:='SELECT a.cod_grupo ';
        LV_sSql:=LV_sSql || 'FROM al_tecnologia a ';
        LV_sSql:=LV_sSql || 'WHERE a.cod_tecnologia = ' || EV_cod_tecnologia;

        SELECT a.cod_grupo
        INTO SV_cod_grupo
        FROM AL_TECNOLOGIA a
        WHERE a.cod_tecnologia = EV_cod_tecnologia;

     EXCEPTION
     WHEN NO_DATA_FOUND THEN
           SN_cod_retorno  := '';
           IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
              SV_mens_retorno := CV_error_no_clasIF;
           END IF;
           LV_des_error := SUBSTR('PV_OBTIENE_GRUPO_TECNOLOGIA_FN(...); - ' || SQLERRM,1,CN_largoerrtec);
           SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
           SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_num_version, USER,
                                                         'Pv_Actcambios_Ofvirtual_Pg.PV_obtiene_grupo_tecnologia_FN', LV_sSql, SQLCODE, SV_mens_retorno );
     WHEN OTHERS  THEN
           SN_cod_retorno  := '';
           IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno ,SV_mens_retorno) THEN
                SV_mens_retorno :=CV_error_no_clasIF;
           END IF;
           LV_des_error := SUBSTR('PV_OBTIENE_GRUPO_TECNOLOGIA_FN(...); - ' || SQLERRM,1,CN_largoerrtec);
           SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
           SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_num_version, USER,
                                                        'Pv_Actcambios_Ofvirtual_Pg.PV_obtiene_grupo_tecnologia_FN', LV_sSql, SQLCODE, SV_mens_retorno );
END  PV_obtiene_grupo_tecnologia_FN;

-------------------------------------------------------------------------------------------------------------------------------------
FUNCTION PV_registra_orden_servicio_FN(
                                     EN_num_abonado      IN  GA_ABOAMIST.NUM_ABONADO%TYPE ,
                            EV_cod_OS            IN    CI_ORSERV.COD_OS%TYPE ,
                            EV_des_os           IN    CI_ORSERV.COMENTARIO%TYPE ,
                            EV_nom_usuario        IN  CI_ORSERV.usuario%TYPE ,
                            SN_cod_retorno      OUT NOCOPY   ge_errores_pg.codError,
                            SV_mens_retorno     OUT NOCOPY   ge_errores_pg.MsgError,
                            SN_num_evento       OUT NOCOPY   ge_errores_pg.Evento)
                            RETURN BOOLEAN
/*
<Documentaci¥n
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "PV_REGISTRA_ORDEN_SERVICIO_FN"
      Lenguaje="PL/SQL"
      Fecha="15-11-2005"
      Versi¥n="1.0"
      Dise¿ador="Christian Estay"
      Programador="CAGV"
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripci¥n>Registra la orden de Servicio</Descripci¥n>
      <Par¿metros>
         <Entrada>
            <param nom="EN_num_abonado"       Tipo="NUMERICO">NÀmero de abonado</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"       Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"     Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"       Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Par¿metros>
   </Elemento>
</Documentaci¥n>
*/
IS
     Error_Ejecucion                    EXCEPTION ;
     CV_num_version                     CONSTANT VARCHAR2(5) :='1.0';
     CN_cod_producto                 CONSTANT CI_ORSERV.producto%TYPE := 1;
     /* Variables */
     LV_num_grupo                     CI_TIPORSERV.grupo%TYPE;
     LV_cod_inter                     CI_TIPORSERV.grupo%TYPE;
      LV_cod_error                     GA_TRANSACABO.cod_retorno%TYPE;
     LV_des_error                     ge_errores_pg.DesEvent;
     LV_sSql                         ge_errores_pg.vQuery;

     LN_seq_transacabo                 NUMBER(10);
     LN_seq_numos                     NUMBER(10);

       BEGIN

            BEGIN

          LV_sSql:= 'SELECT ci_seq_numos.NEXTVAL'||
                       'FROM dual ';
          SELECT ci_seq_numos.NEXTVAL
          INTO LN_seq_numos
          FROM dual;
          EXCEPTION
          WHEN NO_DATA_FOUND THEN
               SN_cod_retorno := 531; -- No se pudo recuperar secuencia ci_seq_numos
          RAISE error_ejecucion;
          END;

            BEGIN
          LV_sSql:= 'SELECT f.grupo FROM ci_tiporserv f'||
                       'WHERE f.cod_os = ' ||EV_cod_OS;
          SELECT f.grupo
          INTO LV_num_grupo
          FROM CI_TIPORSERV f
          WHERE f.cod_os = EV_cod_OS;
          EXCEPTION
          WHEN NO_DATA_FOUND THEN
               SN_cod_retorno := 561; -- No se pudo recuperar grupo de la Orden de Servicio
          RAISE error_ejecucion;
          END;

          BEGIN
          LV_sSql:= 'INSERT INTO ci_orserv' ||
                      '( num_os, cod_os, producto, tip_inter, cod_inter, usuario, fecha, comentario,num_cargo,' ||
                    '  cod_modulo, id_gestor, num_movimiento, cod_estado ) VALUES '||
                    '('||LN_seq_numos||','||EV_cod_OS||','||CN_cod_producto||','||LV_num_grupo||','||EN_num_abonado||
                    ','||USER||','||SYSDATE||','||EV_des_os||','||NULL||','||CV_cod_modulo_gral||
                    ','||NULL||','||NULL||','||NULL||')';
          INSERT INTO CI_ORSERV
          ( num_os, cod_os, producto, tip_inter, cod_inter, usuario, fecha, comentario,num_cargo,
            cod_modulo, id_gestor, num_movimiento, cod_estado )
          VALUES
          ( LN_seq_numos, EV_cod_os, CN_cod_producto, LV_num_grupo, EN_num_abonado, EV_nom_usuario, SYSDATE, EV_des_os, NULL,
            CV_cod_modulo_gral, NULL, NULL, NULL);
          EXCEPTION
          WHEN OTHERS THEN
               SN_cod_retorno := 532; -- No se pudo insertar registro en ci_orserv
               RAISE error_ejecucion;
          END;

          RETURN TRUE;

     EXCEPTION
     WHEN error_ejecucion THEN
           IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
              SV_mens_retorno := CV_error_no_clasIF;
           END IF;
           LV_des_error := SUBSTR('PV_REGISTRA_ORDEN_SERVICIO_FN(...); - ' || SQLERRM,1,CN_largoerrtec);
           SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
           SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_num_version, USER,
                                                         'Pv_Actcambios_Ofvirtual_Pg.PV_registra_orden_servicio_FN', LV_sSql, SQLCODE, SV_mens_retorno );
           RETURN FALSE;

     WHEN OTHERS  THEN
           SN_cod_retorno  := '302';
           IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno ,SV_mens_retorno) THEN
                SV_mens_retorno :=CV_error_no_clasIF;
           END IF;
           LV_des_error := SUBSTR('PV_REGISTRA_ORDEN_SERVICIO_FN(...); - ' || SQLERRM,1,CN_largoerrtec);
           SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
           SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_num_version, USER,
                                                        'Pv_Actcambios_Ofvirtual_Pg.PV_Registra_Orden_Servicio_FN', LV_sSql, SQLCODE, SV_mens_retorno );
           RETURN FALSE;

       END  PV_registra_orden_servicio_FN;

-------------------------------------------------------------------------------------------------------------------------------------
/*
Inicio
Incidencia XC-200512270964
Fecha Cambio : 11-01-2006
Autor : Patricio Gallegos
Inclusi¥n de Homologaci¥n de servicios suplementarios
*/

FUNCTION PV_Obtservsupltecno_fn(
                    EN_num_abonado      IN  GA_ABOCEL.NUM_ABONADO%TYPE,
                    EN_num_celular        IN  GA_ABOCEL.num_celular%TYPE,
                    EN_cod_producto     IN    GA_ABOCEL.cod_producto%TYPE,
                    EN_codcentral_nva    IN  ICG_CENTRAL.cod_central%TYPE,
                    EV_tip_terminal_act    IN    GA_ABOCEL.tip_terminal%TYPE,
                    EV_tip_terminal_nva    IN    GA_ABOCEL.tip_terminal%TYPE,
                    EV_tecnologia_act     IN    GA_ABOCEL.cod_tecnologia%TYPE,
                    EV_tecnologia_nva     IN    GA_ABOCEL.cod_tecnologia%TYPE,
                    EN_cod_uso            IN    GA_ABOCEL.cod_uso%TYPE,
                    EV_nom_usuario      IN  GE_SEG_USUARIO.nom_usuario%TYPE,
                    EV_tabla_abo        IN  VARCHAR2,
                    EV_sSERVICIO_AUTENTICACION         IN VARCHAR2,
                    SV_sCadenaServicio                 IN OUT    NOCOPY VARCHAR2,
                    SV_sCadenaICCSS                     IN OUT NOCOPY VARCHAR2,
                    SV_MsgError            OUT    NOCOPY VARCHAR2
                                        )
RETURN BOOLEAN
/*
<Documentaci¥n>
  <TipoDoc = "Funci¥n"/>
   <Elemento
      Nombre = "PV_Obtservsupltecno_fn"
      Lenguaje="PL/SQL"
      Fecha="09-01-2006"
      Versi¥n="1.0"
      Dise¿ador="Patricio Gallegos"
      Programador="Patricio Gallegos"
      Ambiente Desarrollo="BD">
      <Retorno></Retorno>
      <Descripci¥n>Homologaci¥n de servicios suplementarios.</Descripci¥n>
      <Par¿metros>
         <Entrada>
            <param nom="EN_num_abonado" Tipo="NUMERO">NÀmero de abonado</param>
            <param nom="EN_num_celular" Tipo="NUMERO">NÀmero celular</param>
            <param nom="EN_cod_producto" Tipo="NUMERO">C¥digo producto</param>
            <param nom="EN_codcentral_nva" Tipo="NUMERO">C¥digo central nueva</param>
            <param nom="EV_tip_terminal_act" Tipo="CARACTER">Tipo de terminal actual</param>
            <param nom="EV_tip_terminal_nva" Tipo="CARACTER">Tipo de terminal nuevo</param>
            <param nom="EV_tecnologia_act" Tipo="CARACTER">Tipo de tecnologia actual</param>
            <param nom="EV_tecnologia_nva" Tipo="CARACTER">Tipo de tecnologia nueva</param>
            <param nom="EN_cod_uso" Tipo="NUMERO">C¥digo de uso</param>
            <param nom="EV_nom_usuario" Tipo="CARACTER">Nombre de usuario</param>
            <param nom="EV_tabla_abo" Tipo="CARACTER">Nombre tabla de abonados (GA_ABOCEL u GA_ABOAMIST)</param>
            <param nom="EV_sSERVICIO_AUTENTICACION" Tipo="CARACTER">Servicio de autenticaci¥n. (GA_ABOCEL u GA_ABOAMIST)</param>
         </Entrada>
         <Salida>
            <param nom="SV_sCadenaServicio" Tipo="CARACTER">Cadena de servicio.</param>
            <param nom="SV_sCadenaICCSS" Tipo="CARACTER">Cadena de ICC</param>
            <param nom="SV_MsgError" Tipo="CARACTER">Mensaje de Error</param>
         </Salida>
      </Par¿metros>
   </Elemento>
</Documentaci¥n>
*/

AS

  LV_cod_sistema ICG_CENTRAL.cod_sistema%TYPE;

  LN_cod_servsupl    GA_SERVSUPLABO.cod_servsupl%TYPE;
  LN_cod_nivel        GA_SERVSUPLABO.cod_nivel%TYPE;
  LV_cod_servicio   GA_SERVSUPLABO.cod_servicio%TYPE;
  LV_valor            VARCHAR2(1);

  LV_exTecnoIni        GA_ABOCEL.cod_tecnologia%TYPE;

  LV_cod_actabo        GA_ACTABO.cod_actabo%TYPE;
  LN_cod_actcen        GA_ACTABO.cod_actcen%TYPE;

  LV_sscadena_def    ICG_ACTUACIONTERCEN.cod_servicios%TYPE;

  LV_TecnologiaGsm                  GED_PARAMETROS.val_parametro%TYPE:='GSM';
  LV_TecnologiaTdma                GED_PARAMETROS.val_parametro%TYPE:='TDMA';

  --CV_cod_modulo_gral varchar2(2):='GA';

  /* FIN POR MIENTRAS */


  TYPE LR_servsupl IS RECORD (
      cod_servsupl       GA_SERVSUPLABO.cod_servsupl%TYPE,
      cod_nivel          GA_SERVSUPLABO.cod_nivel%TYPE,
      cod_servicio    GA_SERVSUPLABO.cod_servicio%TYPE,
      valor4          VARCHAR2(2),
      valor5          VARCHAR2(2));

  TYPE LT_servsupl IS TABLE OF LR_servsupl INDEX BY BINARY_INTEGER;
  CO_SSHomologos              LT_servsupl;
  CO_SSabonados                  LT_servsupl;
  CO_SS_DEFAULT                   LT_servsupl;
  CO_SS_TRANSFERENCIA        LT_servsupl;
  CO_SSHomolog_FINAL        LT_servsupl;
  CO_SS_A_ACTIVAR            LT_servsupl;

  F INTEGER;
  --T Integer;
  H INTEGER;
  X INTEGER;

  LN_Valor INTEGER;
  iCon INTEGER;
  LN_sEsta       PLS_INTEGER;
  LN_CANT_ACTIVAR INTEGER;
  LN_CANT_ACTIVAR_CADENA INTEGER;


  LN_GSM_SERSUPL      GA_SERVSUPL.cod_servsupl%TYPE;
  LN_GSM_NIVEL           GA_SERVSUPL.cod_nivel%TYPE;
  LV_sscadena_SERV      GA_SERVSUPL.cod_servicio%TYPE;


  CN_len_ss                            CONSTANT     NUMBER(1):= 2;
  CN_len_niv                            CONSTANT     NUMBER(1):= 4;
  CN_len_tt                           CONSTANT     NUMBER(1):= CN_len_ss + CN_len_niv;
  LV_sServicios       VARCHAR2(10);
  LV_sCodServ       GA_SERVSUP_DEF.cod_servicio%TYPE;

  LN_var_larg       INTEGER;
  LN_CANT_HOMFINAL INTEGER;

  LV_sGrupoh VARCHAR2(10);
  LV_sNivelh VARCHAR2(10);
--  LV_sCadenaICCSS varchar2(1000);
  LV_sCadenaICCSer VARCHAR2(1000);
  LV_sCadenaICCSer_DEF VARCHAR2(1000);

  LD_FechaHoy      DATE;

  bInc_Cadena_DesactSS BOOLEAN;
  LV_GrupoTecnoAbonado VARCHAR2(7);
  LN_cod_retorno       ge_errores_pg.codError;
  LV_mens_retorno       ge_errores_pg.MsgError;
  LN_num_evento           ge_errores_pg.Evento;


CURSOR LC_SSupl (LV_cod_sistema ICG_CENTRAL.cod_sistema%TYPE) IS
     SELECT a.cod_servsupl, a.cod_nivel, a.cod_servicio, ' '
     FROM GA_SERVSUPLABO a
     WHERE NUM_ABONADO = EN_num_abonado
     AND   ind_estado < 3
     AND EXISTS (SELECT 1
                 FROM ICG_SERVICIOTERCEN b
                 WHERE b.cod_producto = EN_cod_producto
                 AND b.cod_servicio = a.cod_servsupl
                 AND b.tip_terminal = EV_tip_terminal_nva
                 AND b.cod_sistema  = LV_cod_sistema
                 AND b.tip_tecnologia = EV_tecnologia_nva)
     UNION
     SELECT a.cod_servsupl, a.cod_nivel, a.cod_servicio, 'N'
     FROM GA_SERVSUPLABO a
     WHERE NUM_ABONADO = EN_num_abonado
     AND   ind_estado < 3
     AND NOT EXISTS (SELECT 1
                 FROM ICG_SERVICIOTERCEN b
                 WHERE b.cod_producto = EN_cod_producto
                 AND b.cod_servicio = a.cod_servsupl
                 AND b.tip_terminal = EV_tip_terminal_nva
                 AND b.cod_sistema  = LV_cod_sistema
                 AND b.tip_tecnologia = EV_tecnologia_nva);

--Excepciones
NO_HAY_SS EXCEPTION;--No hay servicios suplementarios
ERROR_COD_ACTCEN EXCEPTION;
ERR_FORMATO_CADENA EXCEPTION;
ERR_ACT_SS EXCEPTION;
ERR_DESACT_SS EXCEPTION;
NO_HAY_COD_SIST EXCEPTION;

FUNCTION bValSSUso(iLV_cod_servicio IN GA_SERVUSO.cod_servicio%TYPE)
RETURN BOOLEAN IS
       i PLS_INTEGER;
BEGIN

     SELECT 1 INTO i
    FROM GA_SERVUSO
    WHERE Cod_Uso = EN_cod_uso
    AND cod_producto = EN_cod_producto
    AND cod_servicio = iLV_cod_servicio;

    RETURN TRUE;

EXCEPTION
         WHEN NO_DATA_FOUND THEN
               RETURN FALSE;
END bValSSUso;

FUNCTION bValSSTecno(iLN_cod_servsupl IN ICG_SERVICIOTERCEN.cod_servicio%TYPE)
RETURN BOOLEAN IS
       i PLS_INTEGER;
BEGIN

    SELECT 1 INTO i
     FROM ICG_SERVICIOTERCEN
     WHERE cod_producto = EN_cod_producto
     AND cod_servicio =  iLN_cod_servsupl
     AND tip_terminal = EV_tip_terminal_nva
     AND cod_sistema  = LV_cod_sistema
     AND Tip_tecnologia = EV_tecnologia_nva;

    RETURN TRUE;

EXCEPTION
         WHEN NO_DATA_FOUND THEN
               RETURN FALSE;
END bValSSTecno;

FUNCTION ObtenerCodActabo(TecnoIni             IN GA_ABOCEL.cod_tecnologia%TYPE,
                           TecnoActual         IN GA_ABOCEL.cod_tecnologia%TYPE,
                          TecnoFin             IN GA_ABOCEL.cod_tecnologia%TYPE)
RETURN VARCHAR2 IS
       i PLS_INTEGER;
BEGIN
     --Para llevar a pl ---
     IF TecnoIni = LV_TecnologiaTdma THEN
         IF TecnoActual = LV_TecnologiaTdma THEN
           IF TecnoFin = LV_TecnologiaGsm THEN RETURN 'TG'; END IF;
           IF TecnoFin = LV_TecnologiaTdma THEN RETURN 'CE'; END IF;
        END IF;
         IF TecnoActual = LV_TecnologiaGsm THEN
           IF TecnoFin = LV_TecnologiaTdma THEN RETURN 'ET'; END IF;
           IF TecnoFin = LV_TecnologiaGsm THEN RETURN 'CE'; END IF;
        END IF;
     ELSIF TecnoIni = LV_TecnologiaGsm THEN
          IF TecnoActual = LV_TecnologiaTdma THEN
               IF TecnoFin = LV_TecnologiaGsm THEN RETURN 'TG';END IF;
            IF TecnoFin = LV_TecnologiaTdma THEN RETURN 'CE';    END IF;
        END IF;
        IF TecnoActual = LV_TecnologiaGsm THEN
            IF TecnoFin = LV_TecnologiaTdma THEN RETURN 'GT'; END IF;
            IF TecnoFin = LV_TecnologiaGsm THEN RETURN 'CE'; END IF;
          END IF;
     ELSE
          RETURN NULL;
     END IF;

END ObtenerCodActabo;

PROCEDURE ComponeNuevaCadena(sCad1 IN OUT VARCHAR2,
                               sCadC IN VARCHAR2)
IS
sTmpS        VARCHAR2(1000);
sTmpN         VARCHAR2(1000);
sTmpS2        VARCHAR2(1000);
sTmpN2        VARCHAR2(1000);
i              INTEGER;
j             INTEGER;
bIndCambio  BOOLEAN;
sCadTmp        VARCHAR2(1000);

BEGIN

    FOR i IN 0..((LENGTH(sCadC) / 6)) - 1 LOOP
       --sTmpS2 = Mid$(sCadC, i * 6 + 1, 2)
       sTmpS2 := SUBSTR(sCadC, i * 6 + 1, 2);
       --sTmpN2 = Mid$(sCadC, i * 6 + 3, 4)
       sTmpN2 := SUBSTR(sCadC, i * 6 + 3, 4);
       bIndCambio := FALSE;
       FOR j IN 0..((LENGTH(sCad1) / 6) - 1) LOOP
           --sTmpS = Mid$(sCad1, j * 6 + 1, 2)
           sTmpS := SUBSTR(sCad1, j * 6 + 1, 2);
           --sTmpN = Mid$(sCad1, j * 6 + 3, 4)
           sTmpN := SUBSTR(sCad1, j * 6 + 3, 4);
           IF sTmpS = sTmpS2 THEN
              --'Ha habido un cambio de nivel en un servicio
              --sCadTmp = Mid$(sCad1, 1, j * 6)
              sCadTmp := SUBSTR(sCad1, 1, j * 6);
              IF sTmpN2 != '0000' THEN
                 --sCadTmp = sCadTmp + Format$(sTmpS2, "00") + Format$(sTmpN2, "0000")
                 sCadTmp := sCadTmp || SUBSTR('00' || sTmpS2,2) + SUBSTR('0000' || sTmpN2,4);
              END IF;
              --sCadTmp = sCadTmp + Mid$(sCad1, j * 6 + 7)
              sCadTmp := sCadTmp || SUBSTR(sCad1, j * 6 + 7);
              sCad1 := sCadTmp;
              bIndCambio := TRUE;
              EXIT;
           END IF;
       END LOOP;
       IF bIndCambio = FALSE THEN
          --sCad1 = sCad1 + Format$(sTmpS2, "00") + Format$(sTmpN2, "0000")
          sCad1 := sCad1 ||  SUBSTR('00' || sTmpS2,2) + SUBSTR('0000' || sTmpN2,4);
       END IF;
    END LOOP;

END ComponeNuevaCadena;

FUNCTION bActDesSS(sTipoAct                IN VARCHAR2,
                   sCodServicio                IN GA_SERVSUPLABO.cod_servicio%TYPE,
                   sServSupl                IN GA_SERVSUPLABO.cod_servsupl%TYPE,
                  sCodNivel                IN GA_SERVSUPLABO.cod_nivel%TYPE)
RETURN BOOLEAN IS
       sCodConcepto                           GA_ACTUASERV.cod_concepto%TYPE;
       sNumDiasNum                           GA_SERVSUPLABO.num_diasnum%TYPE;
       sGrupo                               VARCHAR2(10);
       sNivel                               VARCHAR2(10);
       sCadCambios                           VARCHAR2(1000);
       sCadServicios                       VARCHAR2(1000);
       --sCodConcepto                           ga_actuaserv.cod_concepto%TYPE;
       --sNumDiasNum                           ga_servsuplabo.num_diasnum%TYPE;
BEGIN

    IF sTipoAct = 'D' THEN  --'Desactiva

        UPDATE GA_SERVSUPLABO
        SET FEC_BAJABD = LD_FechaHoy,IND_ESTADO=3
        WHERE NUM_ABONADO = EN_num_abonado
        AND COD_SERVSUPL = sServSupl
        AND COD_NIVEL = sCodNivel
        AND IND_ESTADO < 3;

        sGrupo := SUBSTR('00' || sServSupl,LENGTH('00' || sServSupl) - 1,2);
        --sGrupo = Mid$("00" + sServSupl, Len("00" + sServSupl) - 1, 2)
        sNivel := '0000';
        sCadCambios := sCadCambios || sGrupo || sNivel;

    ELSIF sTipoAct = 'A' THEN  --'Activa

        BEGIN
            SELECT cod_concepto INTO sCodConcepto
            FROM GA_ACTUASERV
            WHERE cod_producto = EN_cod_producto AND cod_tipserv = 2
            AND cod_servicio = sCodServicio AND cod_actabo = 'FA';
        EXCEPTION
                 WHEN NO_DATA_FOUND THEN
                        sCodConcepto := NULL;
        END;

        BEGIN
            SELECT num_diasnum
            INTO sNumDiasNum
            FROM GA_SERVSUPLABO
            WHERE NVL(cod_producto,1) = EN_cod_producto
            AND cod_servicio = sCodServicio
            AND NUM_ABONADO = EN_num_abonado
            AND FEC_BAJABD =LD_FechaHoy;
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
             sNumDiasNum := NULL;
        END;

        INSERT INTO GA_SERVSUPLABO
        (NUM_ABONADO, COD_SERVICIO, FEC_ALTABD, COD_SERVSUPL, COD_NIVEL, NUM_TERMINAL,
        COD_PRODUCTO, NOM_USUARORA, IND_ESTADO, COD_CONCEPTO, NUM_DIASNUM)
        VALUES (
        EN_num_abonado,
        sCodServicio,
        LD_FechaHoy,
        sServSupl,
        sCodNivel,
        EN_num_celular,
        EN_cod_producto,
        NVL(Trim(EV_nom_usuario),USER),
        1 ,
        sCodConcepto,
        sNumDiasNum);

        sGrupo := SUBSTR('00' || sServSupl,LENGTH('00' || sServSupl) - 1,2);
        --sGrupo = Mid$("00" + sServSupl, Len("00" + sServSupl) - 1, 2)
        sNivel := SUBSTR('0000' || sCodNivel, LENGTH('0000' || sCodNivel) - 3, 4);
        --sNivel = Mid$("0000" + sCodNivel, Len("0000" + sCodNivel) - 3, 4)
        sCadCambios := sCadCambios || sGrupo || sNivel;

    END IF;


    IF EV_tabla_abo = 'GA_ABOCEL' THEN
        SELECT clase_servicio INTO sCadServicios
        FROM GA_ABOCEL
        WHERE NUM_ABONADO = EN_num_abonado;
    ELSE
        SELECT clase_servicio INTO sCadServicios
        FROM GA_ABOAMIST
        WHERE NUM_ABONADO = EN_num_abonado;
    END IF;

    ComponeNuevaCadena (sCadServicios, sCadCambios);

    IF EV_tabla_abo = 'GA_ABOCEL' THEN
        UPDATE GA_ABOCEL  SET --"    'MAM.11/08/2003
        clase_servicio = sCadServicios
        WHERE NUM_ABONADO = EN_num_abonado;
    ELSE
        UPDATE GA_ABOAMIST  SET --"    'MAM.11/08/2003
        clase_servicio = sCadServicios
        WHERE NUM_ABONADO = EN_num_abonado;
    END IF;

    RETURN TRUE;
EXCEPTION
         WHEN OTHERS THEN
               RETURN FALSE;
END bActDesSS;

FUNCTION Trim2(valor IN VARCHAR2)
RETURN VARCHAR2 IS
BEGIN
     IF TRIM(valor) IS NULL THEN
         RETURN ' ';
     ELSE
         RETURN TRIM(valor);
     END IF;
END Trim2;

BEGIN


  LD_FechaHoy := SYSDATE;

  Pv_Pr_Devvalparam(CV_cod_modulo_gral, EN_cod_producto,'TECNOLOGIA_GSM',LV_TecnologiaGsm);

  Pv_Pr_Devvalparam(CV_cod_modulo_gral, EN_cod_producto,'TECNOLOGIA_TDMA',LV_TecnologiaTdma);

    BEGIN
        SELECT cod_sistema
        INTO LV_cod_sistema
        FROM ICG_CENTRAL
        WHERE cod_producto = EN_cod_producto
        AND cod_central = EN_codcentral_nva;
    EXCEPTION
             WHEN NO_DATA_FOUND THEN
                    RAISE NO_HAY_COD_SIST;
    END;
    F := 0;

    OPEN LC_SSupl(LV_cod_sistema);
        LOOP
            FETCH LC_SSupl
            INTO   LN_cod_servsupl,LN_cod_nivel,LV_cod_servicio,LV_valor;
            EXIT WHEN LC_SSupl%NOTFOUND;

            CO_SSabonados(F).cod_servsupl:= LN_cod_servsupl;
            CO_SSabonados(F).cod_nivel := LN_cod_nivel;
            CO_SSabonados(F).cod_servicio :=  LV_cod_servicio;
            CO_SSabonados(F).valor4 :=  LV_valor;

            F := F + 1;

        END LOOP;

    CLOSE LC_SSupl;

    IF F = 0 THEN
       RAISE NO_HAY_SS;
    END IF;

    FOR F IN NVL(CO_SSabonados.FIRST,0)..NVL(CO_SSabonados.LAST,-1) LOOP

        IF Trim(CO_SSAbonados(F).cod_servicio) IS NULL THEN
            EXIT;
        END IF;

        BEGIN

            IF EV_tecnologia_act = LV_TecnologiaGsm THEN
                SELECT cod_servsupl_tdma,cod_nivel_tdma,cod_servicio_tdma
                INTO   LN_cod_servsupl,LN_cod_nivel,LV_cod_servicio
                FROM GA_SERVSUPL_HOMTEC
                WHERE cod_producto = EN_cod_producto
                AND   cod_servicio_gsm = CO_SSabonados(F).cod_servicio
                AND   cod_servsupl_gsm = CO_SSabonados(F).cod_servsupl
                AND   cod_nivel_gsm = CO_SSabonados(F).cod_nivel
                AND ROWNUM=1;--Para controlar que devuelva solo 1, ya que, en VB si devuelve m¿s de 1 toma solo el primero
            ELSE
                SELECT cod_servsupl_gsm,cod_nivel_gsm,cod_servicio_gsm
                INTO   LN_cod_servsupl,LN_cod_nivel,LV_cod_servicio
                FROM GA_SERVSUPL_HOMTEC
                WHERE cod_producto = EN_cod_producto
                AND   cod_servicio_tdma = CO_SSabonados(F).cod_servicio
                AND   cod_servsupl_tdma = CO_SSabonados(F).cod_servsupl
                AND   cod_nivel_tdma = CO_SSabonados(F).cod_nivel
                AND ROWNUM=1;--Para controlar que devuelva solo 1, ya que, en VB si devuelve m¿s de 1 toma solo el primero
            END IF;
              CO_SSHomologos(F).cod_servsupl := LN_cod_servsupl;
              CO_SSHomologos(F).cod_nivel := LN_cod_nivel;
              CO_SSHomologos(F).cod_servicio := LV_cod_servicio;

                  IF CO_SSabonados(F).valor4 = 'N' THEN
                       --If bValSSTecno(tAbonado, sAuxTerminal, sCentralNue, asTabDat(1), sCodSistema, sTecnologiaNue) Then
                       IF bValSSTecno(CO_SSHomologos(F).cod_servsupl) THEN
                               --IF bValSSUso(tAbonado.sCodUso, tAbonado.sCodProducto, SSHomologos(F, 3)) HEN
                              IF bValSSUso(CO_SSHomologos(F).cod_servicio) THEN

                                    CO_SSHomologos(F).valor4 := ' '; --          ' Estado de SS
                                    CO_SSHomologos(F).valor5 := 'H';--          ' HOMOLOGO

                               ELSE
                                    CO_SSHomologos(F).valor4 := 'IT';--         ' Estado de SS
                                    CO_SSHomologos(F).valor5 := 'N' ;--         ' HOMOLOGO
                              END IF;

                       ELSE
                               CO_SSHomologos(F).valor4 := 'IT';--          ' Estado de SS
                               CO_SSHomologos(F).valor5 := 'N';--          ' HOMOLOGO

                       END IF;
                  ELSE
                       IF bValSSUso(CO_SSHomologos(F).cod_servicio) THEN

                           CO_SSHomologos(F).valor4 := ' ';--          ' Estado de SS
                           CO_SSHomologos(F).valor5 := 'H';--          ' HOMOLOGO

                           CO_SSAbonados(F).valor4 := 'N';

                       ELSE
                           CO_SSHomologos(F).valor4 := 'IT';--         ' Estado de SS
                           CO_SSHomologos(F).valor5 := 'N';--          ' HOMOLOGO
                       END IF;
                  END IF;

        EXCEPTION
                 WHEN NO_DATA_FOUND THEN
                             CO_SSHomologos(F).cod_servsupl := CO_SSAbonados(F).cod_servsupl;--SSAbonados(F, 1)  --' Serv.Suplem.
                            CO_SSHomologos(F).cod_nivel := CO_SSAbonados(F).cod_nivel;--SSAbonados(F, 2)  ' Nivel
                            CO_SSHomologos(F).cod_servicio := CO_SSAbonados(F).cod_servicio;--SSAbonados(F, 3)  ' Cod.Servicio

                          IF CO_SSAbonados(F).valor4 = 'N' THEN
                                 CO_SSHomologos(F).valor4 := 'IT';--               ' Estado de SS
                            ELSE
                                 CO_SSHomologos(F).valor4 := ' ';--               ' Estado de SS
                          END IF;

                            CO_SSHomologos(F).valor5 := 'N';--               ' NO HOMOLOGO

        END;

    END LOOP;
    FOR F IN NVL(CO_SSHomologos.FIRST,0)..NVL(CO_SSHomologos.LAST,-1) LOOP
        IF Trim(CO_SSHomologos(F).cod_servicio) IS NULL THEN
           EXIT;
        END IF;

        IF Trim(CO_SSHomologos(F).valor4) IS NULL THEN

            BEGIN
                SELECT B.COD_SERVSUPL,B.COD_NIVEL,B.COD_SERVICIO
                INTO LN_cod_servsupl,LN_cod_nivel,LV_cod_servicio
                 FROM GA_SERVSUP_DEF A, GA_SERVSUPL B, ICG_SERVICIOTERCEN C
                 WHERE A.COD_SERVICIO = CO_SSHomologos(F).cod_servicio
                 AND A.TIP_RELACION = 4
                 AND SYSDATE BETWEEN A.FEC_DESDE AND A.FEC_HASTA
                 AND A.COD_SERVDEF = B.COD_SERVICIO
                 AND B.COD_PRODUCTO = EN_cod_producto
                 AND A.COD_PRODUCTO = B.COD_PRODUCTO
                 AND B.COD_PRODUCTO = C.COD_PRODUCTO
                 AND B.COD_SERVSUPL = C.COD_SERVICIO
                 AND C.COD_SISTEMA = LV_cod_sistema
                 AND C.TIP_TERMINAL = EV_tip_terminal_nva
                 AND C.TIP_TECNOLOGIA = EV_tecnologia_nva
                 AND ROWNUM=1;--Para controlar que devuelva solo 1, ya que, en VB si devuelve m¿s de 1 toma solo el primero

                 IF bValSSUso(LV_cod_servicio) THEN

                     CO_SS_TRANSFERENCIA(F).cod_servsupl := LN_cod_servsupl;--asTabDat(1);-- 'MAM 14/08/2003
                     CO_SS_TRANSFERENCIA(F).cod_nivel := LN_cod_nivel;--asTabDat(2);-- 'MAM 14/08/2003
                     CO_SS_TRANSFERENCIA(F).cod_servicio := LV_cod_servicio ;--asTabDat(3);-- 'MAM 14/08/2003
                     CO_SS_TRANSFERENCIA(F).valor4 := ' ';
                 ELSE
                     CO_SS_TRANSFERENCIA(F).cod_servsupl := '';
                     CO_SS_TRANSFERENCIA(F).cod_nivel := '';
                     CO_SS_TRANSFERENCIA(F).cod_servicio := '';
                     CO_SS_TRANSFERENCIA(F).valor4 := '';
                 END IF;
            EXCEPTION
                     WHEN NO_DATA_FOUND THEN
                         CO_SS_TRANSFERENCIA(F).cod_servsupl := '';
                         CO_SS_TRANSFERENCIA(F).cod_nivel := '';
                         CO_SS_TRANSFERENCIA(F).cod_servicio := '';
                         CO_SS_TRANSFERENCIA(F).valor4 := '';
            END;
        ELSE
            CO_SS_TRANSFERENCIA(F).cod_servsupl := '';
            CO_SS_TRANSFERENCIA(F).cod_nivel := '';
            CO_SS_TRANSFERENCIA(F).cod_servicio := '';
            CO_SS_TRANSFERENCIA(F).valor4 := '';
        END IF;

    END LOOP;
    BEGIN

        SELECT cod_tecnologia INTO LV_exTecnoIni FROM ICG_CENTRAL
        WHERE  cod_central IN ( SELECT cod_central FROM GA_CELNUM_USO
        WHERE EN_num_celular BETWEEN num_desde AND num_hasta  )
        AND cod_producto = EN_cod_producto;

        Pv_Actcambios_Ofvirtual_Pg.PV_obtiene_grupo_tecnologia_FN(LV_exTecnoIni, LV_GrupoTecnoAbonado, LN_cod_retorno, LV_mens_retorno, LN_num_evento);

        LV_exTecnoIni:=LV_GrupoTecnoAbonado;

        LV_cod_actabo := ObtenerCodActabo(LV_exTecnoIni,EV_tecnologia_act,EV_tecnologia_nva);

        SELECT cod_actcen INTO LN_cod_actcen FROM GA_ACTABO
        WHERE cod_producto = EN_cod_producto
        AND cod_actabo = LV_cod_actabo
        AND cod_tecnologia = EV_tecnologia_act
        AND cod_modulo = CV_cod_modulo_gral;

    EXCEPTION
             WHEN OTHERS THEN
                   RAISE ERROR_COD_ACTCEN;
    END;
   --OBTENGO CADENA HOMOLOGO DEFAULT
    BEGIN
         SELECT cod_servicios INTO LV_sscadena_def
         FROM ICG_ACTUACIONTERCEN
         WHERE cod_producto = EN_cod_producto
         AND   cod_actuacion = LN_cod_actcen
         AND   cod_sistema = LV_cod_sistema
         AND   tip_terminal = EV_tip_terminal_act
         AND   tip_tecnologia = EV_tecnologia_act;
    EXCEPTION
             WHEN NO_DATA_FOUND THEN
                   LV_sscadena_def := '';
    END;

    IF TRIM(LV_sscadena_def) IS NULL THEN
        --'OBTENGO CADENA HOMOLOGO DEFAULT
        BEGIN
            SELECT COD_SERVICIO INTO LV_sscadena_def
            FROM  ICG_ACTUACION
            WHERE COD_PRODUCTO  = EN_cod_producto
            AND   COD_ACTUACION = LN_cod_actcen --sAuxCodServGA
            AND   COD_MODULO    = CV_cod_modulo_gral;
        EXCEPTION
                 WHEN NO_DATA_FOUND THEN
                       LV_sscadena_def := '';
        END;

    END IF;
    IF TRIM(LV_sscadena_def) IS NOT NULL THEN

       LV_sscadena_def := TRIM(LV_sscadena_def);

       IF NOT  MOD(LENGTH(LV_sscadena_def), CN_len_tt) = 0 THEN
          RAISE ERR_FORMATO_CADENA;
       ELSE
              LN_Valor := LENGTH(LV_sscadena_def)/CN_len_tt;
       END IF;

       F := 0;

       FOR iCon IN 1..LN_Valor LOOP

              LV_sServicios := SUBSTR(LV_sscadena_def, 1 + (CN_len_tt*(iCon-1)) ,CN_len_tt);
           LN_GSM_SERSUPL := TO_NUMBER(SUBSTR(LV_sServicios,1,CN_len_ss)); --CN_len_ss--CStr(Val(Trim$(Mid$(sServicios, 1, 2))));
              LN_GSM_NIVEL := TO_NUMBER(SUBSTR(LV_sServicios,CN_len_ss + 1,CN_len_niv));--CStr(Val(Trim$(Mid$(sServicios, 1 + 2, 4))))

           BEGIN
               SELECT cod_servicio
               INTO LV_sscadena_SERV
               FROM GA_SERVSUPL
               WHERE cod_producto = EN_cod_producto
               AND   cod_servsupl = LN_GSM_SERSUPL
               AND   cod_nivel =  LN_GSM_NIVEL;
           EXCEPTION
                       WHEN NO_DATA_FOUND THEN
                    LV_sscadena_SERV := '';
           END;

            IF Trim(LV_sscadena_SERV) IS NOT NULL THEN

                IF bValSSUso(LV_sscadena_SERV) THEN


                   CO_SS_DEFAULT(F).cod_servsupl := LN_GSM_SERSUPL;--    ' Serv.Suplem.
                   CO_SS_DEFAULT(F).cod_nivel := LN_GSM_NIVEL;--      ' Nivel
                   CO_SS_DEFAULT(F).cod_servicio := Trim(LV_sscadena_SERV);--  ' Cod.Servicio
                   CO_SS_DEFAULT(F).valor4 := ' ';--            ' Estado de SS
                   F := F + 1;
                ELSE

--                    ' limpieza al resto
                    CO_SS_DEFAULT(F).cod_servsupl := '';
                    CO_SS_DEFAULT(F).cod_nivel := '';
                    CO_SS_DEFAULT(F).cod_servicio := '';
                    CO_SS_DEFAULT(F).valor4 := '';

                END IF;
           ELSE
--                ' limpieza al resto
                CO_SS_DEFAULT(F).cod_servsupl := '';
                CO_SS_DEFAULT(F).cod_nivel := '';
                CO_SS_DEFAULT(F).cod_servicio := '';
                CO_SS_DEFAULT(F).valor4 := '';

           END IF;

       END LOOP;

    END IF;

    FOR H IN NVL(CO_SS_DEFAULT.FIRST,0)..NVL(CO_SS_DEFAULT.LAST,-1) LOOP

        IF trim(CO_SS_DEFAULT(H).cod_servicio) IS NULL THEN
            EXIT;
        END IF;

        BEGIN

            SELECT cod_servicio INTO LV_sCodServ
            FROM GA_SERVSUP_DEF
            WHERE cod_producto = EN_cod_producto
            AND   cod_servicio = CO_SS_DEFAULT(H).cod_servicio
            AND   tip_relacion = 3
            AND   SYSDATE BETWEEN fec_desde AND fec_hasta
            AND   ROWNUM = 1;
        EXCEPTION
                 WHEN NO_DATA_FOUND THEN
                       LV_sCodServ := '';
        END;
        IF Trim(LV_sCodServ) IS NOT NULL THEN
            CO_SS_DEFAULT(H).valor4 := '3';
        END IF;
    END LOOP;
--    'MARCO TODOS SS HOMOLOGOS ORIGINALES DEL ABONADO QUE NO SEAN COMPATIBLES CON LOS DEFAULT A LA TECNOLOGIA
 --   'Se ve si ya existe en Default
    FOR H IN NVL(CO_SSHomologos.FIRST,0)..NVL(CO_SSHomologos.LAST,-1) LOOP

        IF trim(CO_SSHomologos(H).cod_servicio) IS NULL THEN
            EXIT;
        END IF;

        IF CO_SSHomologos(H).valor4 = ' ' THEN

           FOR X IN NVL(CO_SS_DEFAULT.FIRST,0)..NVL(CO_SS_DEFAULT.LAST,-1) LOOP

               IF CO_SS_DEFAULT(X).cod_servicio IS NULL THEN
                    EXIT;
               END IF;

                --'CH-200408182016; German Espinoza Z; 25/08/2004
                --'Solo verifico si ya existen los que realmente voy a homologar por eso
                --'se agrego al siguiente if el And SSHomologos(H, 5) = "H"
--'                If SSHomologos(H, 3) = SS_DEFAULT(X, 3) Then  '(CH-200408182016; German Espinoza Z; 22/09/2004)
                IF CO_SSHomologos(H).cod_servicio = CO_SS_DEFAULT(X).cod_servicio AND CO_SSHomologos(H).valor5 = 'H' THEN
--                '(FIn - CH-200408182016; German Espinoza Z; 25/08/2004)
                    CO_SSHomologos(H).valor4 := 'E';   --'existente
                    EXIT;
                END IF;

                IF CO_SSHomologos(H).cod_servsupl = CO_SS_DEFAULT(X).cod_servsupl THEN
                    CO_SSHomologos(H).valor4 := 'E';--   'existente
                    EXIT;
                END IF;

           END LOOP;

        END IF;

    END LOOP;
--    ' VEO INCOMPATIBILIDAD CON SS POR DEFAULT
    FOR H IN NVL(CO_SSHomologos.FIRST,0)..NVL(CO_SSHomologos.LAST,-1) LOOP

        IF Trim(CO_SSHomologos(H).cod_servicio) IS NULL THEN
            EXIT;
        END IF;

        IF CO_SSHomologos(H).valor4 = ' ' THEN

           FOR X IN NVL(CO_SS_DEFAULT.FIRST,0)..NVL(CO_SS_DEFAULT.LAST,-1) LOOP

               IF Trim(CO_SS_DEFAULT(X).cod_servicio) IS NULL THEN
                    EXIT;
               END IF;

               --1
                  IF NOT CO_SSHomologos(H).cod_servicio = CO_SS_DEFAULT(X).cod_servicio THEN

                     IF CO_SS_DEFAULT(X).valor4 = '3' THEN
                      --' VERIFICO INCOMPATIBILIDAD CON SS HOMOLOGO

                      BEGIN
                          SELECT cod_servicio INTO LV_sCodServ
                          FROM GA_SERVSUP_DEF
                          WHERE cod_producto = EN_cod_producto
                          AND cod_servicio =  CO_SS_DEFAULT(X).cod_servicio
                          AND cod_servdef  =  CO_SSHomologos(H).cod_servicio
                          AND tip_relacion = 3
                          AND SYSDATE BETWEEN fec_desde AND fec_hasta
                          AND ROWNUM = 1;
                      EXCEPTION
                                 WHEN NO_DATA_FOUND THEN
                                       LV_sCodServ := '';
                      END;

                      IF Trim(LV_sCodServ) IS NOT NULL THEN

                         IF Trim(CO_SS_TRANSFERENCIA(H).cod_servicio) IS NOT NULL THEN
                             --' EXISTE TRANSFERENCIA
                             --' VALIDO SI TRANSFERENCIA ES INCOMPATIBLE CON SS POR DEFAULT
                             FOR G IN NVL(CO_SS_DEFAULT.FIRST,0)..NVL(CO_SS_DEFAULT.LAST,-1) LOOP
                             --For G = 0 To CANT_DEFAULT - 1
                                   BEGIN
                                      SELECT cod_servicio INTO LV_sCodServ
                                      FROM GA_SERVSUP_DEF
                                      WHERE cod_producto = EN_cod_producto
                                      AND cod_servicio =  CO_SS_DEFAULT(G).cod_servicio
                                      AND cod_servdef  =  CO_SS_TRANSFERENCIA(H).cod_servicio
                                      AND tip_relacion = 3
                                      AND SYSDATE BETWEEN fec_desde AND fec_hasta
                                      AND ROWNUM = 1;
                                  EXCEPTION
                                             WHEN NO_DATA_FOUND THEN
                                                   LV_sCodServ := '';
                                  END;

                                  IF Trim(LV_sCodServ) IS NOT NULL THEN
                                     CO_SSHomologos(H).valor4 := 'I';--  ' SS Incompatible
                                     EXIT;
                                  END IF;

                             END LOOP;

                             IF NOT CO_SSHomologos(H).valor4 = 'I' THEN --' si SS no es Incompatible

                                LN_sEsta := 0;

                                --' BUSCO QUE TRANSFERENCIA NO EXISTA EN HOMOLOGOS
                                FOR G IN NVL(CO_SSHomologos.FIRST,0)..NVL(CO_SSHomologos.LAST,-1) LOOP

                                  IF Trim(CO_SSHomologos(G).cod_servicio) IS NOT NULL THEN

                                    IF CO_SSHomologos(G).valor4 = ' ' AND Trim2(CO_SSHomologos(G).cod_servicio) = Trim2(CO_SS_TRANSFERENCIA(H).cod_servicio) AND G != H THEN
                                        LN_sEsta := 1;
                                        EXIT;
                                    END IF;

                                    IF CO_SSHomologos(G).valor4 = ' ' AND Trim2(CO_SSHomologos(G).cod_servsupl) = Trim2(CO_SS_TRANSFERENCIA(H).cod_servsupl) AND G != H THEN
                                        LN_sEsta := 1;
                                        EXIT;
                                    END IF;

                                  ELSE
                                    EXIT;
                                  END IF;

                                END LOOP;

                                --' BUSCO QUE TRANSFERENCIA NO EXISTA EN HOMOLOGOS
                                IF LN_sEsta = 0 THEN
                                    --' VER SI NO ES DEFAULT
                                    FOR F IN NVL(CO_SS_DEFAULT.FIRST,0)..NVL(CO_SS_DEFAULT.LAST,-1) LOOP
                                        IF CO_SS_TRANSFERENCIA(H).cod_servicio = CO_SS_DEFAULT(F).cod_servicio THEN
                                            LN_sEsta := 1;-- 'existente
                                            EXIT;
                                        END IF;
                                        IF CO_SS_TRANSFERENCIA(H).cod_servsupl = CO_SS_DEFAULT(F).cod_servsupl THEN
                                            LN_sEsta := 1;-- 'existente
                                            EXIT;
                                        END IF;
                                    END LOOP;
                                END IF;

                                IF LN_sEsta = 0 THEN
                                    CO_SSHomologos(H).cod_servsupl := CO_SS_TRANSFERENCIA(H).cod_servsupl;
                                    CO_SSHomologos(H).cod_nivel := CO_SS_TRANSFERENCIA(H).cod_nivel;
                                    CO_SSHomologos(H).cod_servicio := CO_SS_TRANSFERENCIA(H).cod_servicio;
                                    CO_SSHomologos(H).valor4 := CO_SS_TRANSFERENCIA(H).valor4;
                                    CO_SSHomologos(H).valor5 := 'T';
                                    --'(CH-200408182016; German Espinoza Z; 22/09/2004)
                                    IF NOT Trim2(CO_SSAbonados(H).valor4) = 'N' THEN
                                        CO_SSAbonados(H).valor4 := 'T';
                                    END IF;
                                    --' (FIN - CH-200408182016; German Espinoza Z; 22/09/2004)
                                ELSE
                                    --' SI ESTA DEBE MARCAR EL HOMOLOGO
                                    CO_SSHomologos(H).valor4 := 'I'; --  ' SS Incompatible
                                    --' (CH-200408182016; German Espinoza Z; 25/08/2004)
                                    --'Si el Servicio homologo es incompatible hay que buscarlo en los servicios
                                    --'del abonado para que sea dado de baja

                                    FOR F IN NVL(CO_SSabonados.FIRST,0)..NVL(CO_SSabonados.LAST,-1) LOOP
                                          IF trim(CO_SSAbonados(F).cod_servicio) IS NULL THEN
                                              EXIT;
                                          END IF;

                                          IF Trim2(CO_SSAbonados(F).cod_servicio) = Trim2(CO_SSHomologos(H).cod_servicio) THEN
                                              CO_SSAbonados(F).valor4 := 'N';
                                              EXIT;
                                          END IF;

                                    END LOOP;
--                                    '(FIN - CH-200408182016; German Espinoza Z; 25/08/2004)
                                END IF;

                                --' VA AL SIGUIENTE SS HOMOLOGO
                                EXIT;

                             END IF;

                          ELSE
                            --' NO TIENE TRANSFERENCIA
                              CO_SSHomologos(H).valor4 := 'I';--  ' SS Incompatible
                              --' (CH-200408182016; German Espinoza Z; 25/08/2004)
                              --'Si el Servicio homologo es incompatible hay que buscarlo en los servicios
                              --'del abonado para que sea dado de baja

                              FOR F IN NVL(CO_SSabonados.FIRST,0)..NVL(CO_SSabonados.LAST,-1) LOOP
                                    IF trim(CO_SSAbonados(F).cod_servicio) IS NULL THEN
                                        EXIT;
                                    END IF;

                                    IF Trim2(CO_SSAbonados(F).cod_servicio) = Trim2(CO_SSHomologos(H).cod_servicio) THEN
                                        CO_SSAbonados(F).valor4 := 'N';
                                        EXIT;
                                    END IF;

                              END LOOP;
                              --' (FIN - CH-200408182016; German Espinoza Z; 25/08/2004)
                              EXIT;
                          END IF;

                         END IF;

                  END IF;

               ELSE
                        CO_SSHomologos(H).valor4 := 'E';--   'existente
                        EXIT;
               --1
                  END IF;

           END LOOP;

        END IF;

    END LOOP;

    FOR H IN NVL(CO_SS_DEFAULT.FIRST,0)..NVL(CO_SS_DEFAULT.LAST,-1) LOOP

        IF Trim(CO_SS_DEFAULT(H).cod_servicio) IS NOT NULL THEN

           FOR F IN NVL(CO_SSabonados.FIRST,0)..NVL(CO_SSabonados.LAST,-1) LOOP

                  IF CO_SSAbonados(F).cod_servicio IS NULL THEN
                      EXIT;
                  END IF;

                  IF Trim2(CO_SSAbonados(F).cod_servicio) = Trim2(CO_SS_DEFAULT(H).cod_servicio) THEN
                      CO_SS_DEFAULT(H).valor4 := 'N';

                      IF Trim2(CO_SSAbonados(F).valor4) = 'N' THEN
                          CO_SSHomologos(F).valor5 := 'N';
                          CO_SSHomologos(F).valor4 := 'D';
                      END IF;

                      CO_SSAbonados(F).valor4 := '';
                      EXIT;
                  ELSE
                      CO_SS_DEFAULT(H).valor4 := '';
                      IF Trim2(CO_SSAbonados(F).cod_servsupl) = Trim2(CO_SS_DEFAULT(H).cod_servsupl) THEN
                            CO_SSAbonados(F).valor4 := 'N';
                            EXIT;
                      END IF;
                  END IF;


           END LOOP;

        ELSE
            EXIT;
        END IF;

    END LOOP;

--    'Se verifican que los SS a homologar no tengan un igual cod_servsupl con distinto cod_nivel
--    'dentro de los SS activos del abonado
    FOR H IN NVL(CO_SSHomologos.FIRST,0)..NVL(CO_SSHomologos.LAST,-1) LOOP
      IF Trim(CO_SSHomologos(H).cod_servicio) IS NOT NULL THEN

        IF Trim2(CO_SSHomologos(H).valor5) = 'H' THEN
            FOR F IN NVL(CO_SSabonados.FIRST,0)..NVL(CO_SSabonados.LAST,-1) LOOP

                  IF CO_SSAbonados(F).cod_servicio = '' THEN
                      EXIT;
                  END IF;

                  IF NOT trim2(CO_SSAbonados(F).valor4) = 'N' THEN
                    IF Trim2(CO_SSAbonados(F).cod_servicio) = Trim2(CO_SSHomologos(H).cod_servicio) THEN
                        CO_SSAbonados(F).valor4 := 'N';
                        EXIT;
                    ELSE
                        IF Trim2(CO_SSAbonados(F).cod_servsupl) = Trim2(CO_SSHomologos(H).cod_servsupl) THEN
                            CO_SSAbonados(F).valor4 := 'N';
                            EXIT;
                        END IF;
                    END IF;
                  END IF;

            END LOOP;
        END IF;
      ELSE
        EXIT;
      END IF;
    END LOOP;

--    '(FIN - CH-200408182016 German Espinoza Z; 25/08/2004)
--    '(CH-200408182016; German Espinoza Z; 06/09/2004)
--    'Se verifican los SS del Abonado con respecto al uso
    FOR F IN NVL(CO_SSabonados.FIRST,0)..NVL(CO_SSabonados.LAST,-1) LOOP
           IF CO_SSAbonados(F).cod_servicio IS NULL THEN
               EXIT;
           END IF;

           IF NOT Trim2(CO_SSAbonados(F).valor4) = 'N' THEN

--                '(CH-200408182016; German Espinoza Z; 21/09/2004)

--                'If Not bValSSUso(G_ParametrosCargo.sCodUsoLineaSimC, tAbonado.sCodProducto, SSAbonados(F, 3)) Then
                IF NOT bValSSUso(CO_SSAbonados(F).cod_servicio) THEN

                    BEGIN

                        SELECT b.cod_servsupl,b.cod_nivel,b.cod_servicio
                        INTO LN_cod_servsupl,LN_cod_nivel,LV_cod_servicio
                        FROM GA_SERVSUP_DEF a, GA_SERVSUPL b, ICG_SERVICIOTERCEN c
                        WHERE A.cod_servicio = CO_SSAbonados(F).cod_servicio
                        AND a.tip_relacion = 4
                        AND SYSDATE BETWEEN a.fec_desde AND a.fec_hasta
                        AND a.cod_servdef = b.cod_servicio
                        AND b.cod_producto = EN_cod_producto
                        AND a.cod_producto = b.cod_producto
                        AND b.cod_producto = c.cod_producto
                        AND b.cod_servsupl = c.cod_servicio
                        AND c.cod_sistema = LV_cod_sistema
                        AND c.tip_terminal = EV_tip_terminal_nva
                        AND c.tip_tecnologia = EV_tecnologia_nva;


--                                  ' (CH-200408182016; German Espinoza Z; 22/09/2004)
                        IF bValSSUso(LV_cod_servicio) THEN
--                                  '(FIN - CH-200408182016; German Espinoza Z; 22/09/2004)

                              CO_SSHomologos(F).cod_servsupl := LN_cod_servsupl;
                              CO_SSHomologos(F).cod_nivel := LN_cod_nivel;
                              CO_SSHomologos(F).cod_servicio := LV_cod_servicio;
                              CO_SSHomologos(F).valor4 := ' ';
                              CO_SSHomologos(F).valor5 := 'T';

                              CO_SSAbonados(F).valor4 := 'T';
                        ELSE
                               CO_SSAbonados(F).valor4 := 'N';
                               CO_SSHomologos(F).valor5 := 'N';
                               CO_SSHomologos(F).valor4 := 'U';
                        END IF;



                   EXCEPTION
                               WHEN NO_DATA_FOUND THEN
                                 CO_SSAbonados(F).valor4 := 'N';
                                 CO_SSHomologos(F).valor5 := 'N';
                                 CO_SSHomologos(F).valor4 := 'U';
                   END;
                END IF;
           END IF;

    END LOOP;

    LN_var_larg := 0;

--    '(FIN - CH-200408182016; German Espinoza Z; 06/09/2004)
    FOR H IN NVL(CO_SSHomologos.FIRST,0)..NVL(CO_SSHomologos.LAST,-1) LOOP --'MAM 29/08/2003
      IF Trim(CO_SSHomologos(H).cod_servicio) IS NOT NULL THEN

--        ' (CH-200408182016 German Espinoza Z; 24/08/2004)
--'        If Trim(SSHomologos(H, 4)) = "" Then FIN - CH-200408182016; German Espinoza Z; 22/09/2004
--        'Se agrego el And Trim(SSHomologos(H, 5)) <> "N" al if
--        'ya que solo se activaran los SS a homologar

        IF Trim(CO_SSHomologos(H).valor4) IS NULL AND ( Trim2(CO_SSHomologos(H).valor5) = 'H' OR Trim2(CO_SSHomologos(H).valor5) = 'T') THEN

--        '(FIN CH-200408182016 German Espinoza Z; 24/08/2004)
           CO_SSHomolog_FINAL(LN_var_larg).cod_servsupl := CO_SSHomologos(H).cod_servsupl;
           CO_SSHomolog_FINAL(LN_var_larg).cod_nivel := CO_SSHomologos(H).cod_nivel;
           CO_SSHomolog_FINAL(LN_var_larg).cod_servicio := CO_SSHomologos(H).cod_servicio;

--           ' MAM 19.08.2003
--         '  SS_A_ACTIVAR(var_larg, 1) = SSHomologos(H, 1)
--         '  SS_A_ACTIVAR(var_larg, 2) = SSHomologos(H, 2)
--         '  SS_A_ACTIVAR(var_larg, 3) = SSHomologos(H, 3)

           LN_var_larg := LN_var_larg + 1 ;--'MAM 19.08.2003
        END IF;
      ELSE
        EXIT;
      END IF;
    END LOOP;

--    'MAM 29/08/2003 - CANTIDAD DE SS A ACTIVAR SIN CONTAR LOS SS POR DEFECTO
    LN_CANT_ACTIVAR := LN_var_larg;

--    'Almaceno los por Default
    FOR H IN NVL(CO_SS_DEFAULT.FIRST,0)..NVL(CO_SS_DEFAULT.LAST,-1) LOOP --'MAM 29/08/2003
        IF Trim(CO_SS_DEFAULT(H).cod_servsupl) IS NOT NULL THEN
--            ' (CH-200408182016; German Espinoza Z; 25/08/2004)
--            'Se agregan los SS por defecto que no esten marcados con una N
--            'ya que los marcados por la N ya estan activos y no necesitan activarse denuevo
            IF NOT Trim2(CO_SS_DEFAULT(H).valor4) = 'N' THEN
--            ' (FIN - CH-200408182016; German Espinoza Z; 25/08/2004)
               CO_SSHomolog_FINAL(LN_var_larg).cod_servsupl := CO_SS_DEFAULT(H).cod_servsupl;
               CO_SSHomolog_FINAL(LN_var_larg).cod_nivel := CO_SS_DEFAULT(H).cod_nivel;
               CO_SSHomolog_FINAL(LN_var_larg).cod_servicio := CO_SS_DEFAULT(H).cod_servicio;

            LN_var_larg := LN_var_larg + 1;
            END IF;
--            ' (FIN - CH-200408182016; German Espinoza Z; 25/08/2004)
        ELSE
           EXIT;
        END IF;
    END LOOP;

--   'German Espinoza Z; 03/09/2004
    LN_CANT_ACTIVAR_CADENA := 0;
   -- INI TMC|61570|28-01-2008|SAQL
   FOR H IN NVL(CO_SSHomologos.FIRST,0)..NVL(CO_SSHomologos.LAST,-1) LOOP
      IF Trim(CO_SSHomologos(H).cod_servicio) IS NOT NULL THEN
         IF Trim(CO_SSHomologos(H).valor4) IS NULL THEN
            CO_SS_A_ACTIVAR(LN_CANT_ACTIVAR_CADENA).cod_servsupl := CO_SSHomologos(H).cod_servsupl;
            CO_SS_A_ACTIVAR(LN_CANT_ACTIVAR_CADENA).cod_nivel := CO_SSHomologos(H).cod_nivel;
            CO_SS_A_ACTIVAR(LN_CANT_ACTIVAR_CADENA).cod_servicio := CO_SSHomologos(H).cod_servicio;
            LN_CANT_ACTIVAR_CADENA := LN_CANT_ACTIVAR_CADENA + 1;
         END IF;
      ELSE
         EXIT;
      END IF;
   END LOOP;
   -- FIN TMC|61570|28-01-2008|SAQL

--    'FIN - German Espinoza Z; 03/09/2004


--    'MAM 29/08/2003 - CANTIDAD DE SS A ACTIVAR SIN CONTAR LOS SS POR DEFECTO
    LN_CANT_HOMFINAL := LN_var_larg;

--    'Desactiva SS ORIGINALES
    LV_sGrupoh := '';
    LV_sNivelh := '';
    SV_sCadenaICCSS := '';
    FOR H IN NVL(CO_SSabonados.FIRST,0)..NVL(CO_SSabonados.LAST,-1) LOOP
        IF Trim(CO_SSAbonados(H).cod_servicio) IS NOT NULL THEN --' MAM 0808 - And Trim(SSAbonados(H, 4)) <> "N" Then
--            ' (CH-200408182016; German Espinoza Z; 24/08/2004)
--            'Se desactivan los SS que tienen el indicador (4) en N

            IF Trim2(CO_SSAbonados(H).valor4) = 'N' OR Trim2(CO_SSAbonados(H).valor4) = 'T' THEN
--            ' (FIN - CH-200408182016; German Espinoza Z; 24/08/2004)
            IF NOT bActDesSS('D', CO_SSAbonados(H).cod_servicio, CO_SSAbonados(H).cod_servsupl, CO_SSAbonados(H).cod_nivel) THEN
                    --MsgBox "Error al Desactivar Servicio Suplementario de la Tecnologia Original"
                    --bObtServSuplTecno = False
                    --Exit Function
                    RAISE ERR_DESACT_SS;
            ELSE

--                        ' (CH-200408182016; German Espinoza Z; 26/08/2004)
--                        'Se verifica si el SS a desactivar no este con otro nivel dentro de los activar
--                        'ya que si es asi este SS no debe ir en la cadena

                        bInc_Cadena_DesactSS := TRUE;

                        FOR X IN NVL(CO_SSHomolog_FINAL.FIRST,0)..NVL(CO_SSHomolog_FINAL.LAST,-1) LOOP
                          IF Trim(CO_SSHomolog_FINAL(X).cod_servicio) IS NOT NULL THEN
                            IF CO_SSAbonados(H).cod_servsupl = CO_SSHomolog_FINAL(X).cod_servsupl THEN
                                bInc_Cadena_DesactSS := FALSE;
                                EXIT;
                            END IF;
                          ELSE
                            EXIT;
                          END IF;
                        END LOOP;

                        IF bInc_Cadena_DesactSS THEN
--                        '(FIN - CH-200408182016; German Espinoza Z; 26/08/2004)


                           --sGrupoh = Mid$("00" + SSAbonados(H, 1), Len("00" + SSAbonados(H, 1)) - 1, 2)
                           LV_sGrupoh := SUBSTR('00' || CO_SSAbonados(H).cod_servsupl, LENGTH('00' || CO_SSAbonados(H).cod_servsupl) - 1, 2);
                           LV_sNivelh := '0000';
                           SV_sCadenaICCSS := SV_sCadenaICCSS || LV_sGrupoh || LV_sNivelh;
--                        ' (CH-200408182016; German Espinoza Z; 26/08/2004)
            END IF;
--                        ' (FIN - CH-200408182016; German Espinoza Z; 26/08/2004)
                END IF;

--            '(CH-200408182016; German Espinoza Z; 25/08/2004)
            END IF;
--            ' (Fin - CH-200408182016; German Espinoza Z; 25/08/2004)
        ELSE
            EXIT;
        END IF;
    END LOOP;
--    'AGREGA SERV.AUTENTICACION A CADENA DE DESACTIVADOS,
--    'SOLO CUANDO YA HAYA SIDO DESACTIVADO POR AUTENTICACION
    SV_sCadenaICCSS := SV_sCadenaICCSS || EV_sSERVICIO_AUTENTICACION;
--    'Activa SS Homologados FINALES
    LV_sGrupoh := '';
    LV_sNivelh := '';
    LV_sCadenaICCSer := '';

    FOR H IN NVL(CO_SSHomolog_FINAL.FIRST,0)..NVL(CO_SSHomolog_FINAL.LAST,-1) LOOP
        IF Trim(CO_SSHomolog_FINAL(H).cod_servicio) IS NOT NULL THEN
            IF NOT bActDesSS( 'A', CO_SSHomolog_FINAL(H).cod_servicio, CO_SSHomolog_FINAL(H).cod_servsupl, CO_SSHomolog_FINAL(H).cod_nivel) THEN
                     --MsgBox "Error al Activar Servicio Suplementario Homologados"
                     --bObtServSuplTecno = False
                     --Exit Function
                     RAISE ERR_ACT_SS;
            END IF;
        ELSE
            EXIT;
        END IF;
    END LOOP;
    LV_sGrupoh := '';
    LV_sNivelh := '';
    LV_sCadenaICCSer_DEF := '';
    FOR H IN NVL(CO_SS_DEFAULT.FIRST,0)..NVL(CO_SS_DEFAULT.LAST,-1) LOOP
        IF Trim(CO_SS_DEFAULT(H).cod_servicio) IS NOT NULL THEN
            LV_sGrupoh := SUBSTR('00' || CO_SS_DEFAULT(H).cod_servsupl, LENGTH('00' || CO_SS_DEFAULT(H).cod_servsupl) - 1, 2);
            LV_sNivelh := SUBSTR('0000' || CO_SS_DEFAULT(H).cod_nivel, LENGTH('0000' || CO_SS_DEFAULT(H).cod_nivel) - 3, 4);
            LV_sCadenaICCSer_DEF := LV_sCadenaICCSer_DEF || LV_sGrupoh || LV_sNivelh;
        ELSE
            EXIT;
        END IF;
    END LOOP;
--'   (CH-200408182016; German Espinoza Z; 22/09/2004)
--'    For H = 0 To CANT_ACTIVAR - 1
    FOR H IN NVL(CO_SS_A_ACTIVAR.FIRST,0)..NVL(CO_SS_A_ACTIVAR.LAST,-1) LOOP
  --  '(FIN - CH-200408182016; German Espinoza Z; 26/08/2004)
        IF Trim(CO_SS_A_ACTIVAR(H).cod_servicio) IS NOT NULL THEN
            LV_sGrupoh := SUBSTR('00' || CO_SS_A_ACTIVAR(H).cod_servsupl, LENGTH('00' || CO_SS_A_ACTIVAR(H).cod_servsupl) - 1, 2);
            LV_sNivelh := SUBSTR('0000' || CO_SS_A_ACTIVAR(H).cod_nivel, LENGTH('0000' || CO_SS_A_ACTIVAR(H).cod_nivel) - 3, 4);
            LV_sCadenaICCSer := LV_sCadenaICCSer || LV_sGrupoh || LV_sNivelh;
        ELSE
            EXIT;
        END IF;
    END LOOP;

    SV_sCadenaServicio := LV_sCadenaICCSer;

    LV_sCadenaICCSer_DEF := LV_sCadenaICCSer || LV_sCadenaICCSer_DEF;

    RETURN TRUE;
    --bObtServSuplTecno = True

EXCEPTION
         WHEN NO_HAY_COD_SIST THEN
               SV_MsgError := 'No existe informaci¥n del sistema.';
               RETURN FALSE;
         WHEN NO_HAY_SS THEN
               RETURN TRUE;
         WHEN ERROR_COD_ACTCEN THEN
               SV_MsgError := 'No existe c¥digo de actuacion en central para esta operaci¥n';
               RETURN FALSE;
         WHEN ERR_FORMATO_CADENA THEN
               SV_MsgError := 'Formato incorrecto Cadena';
               RETURN FALSE;
         WHEN ERR_ACT_SS THEN
               SV_MsgError := 'Error al activar servicio suplementario homologados.';
               RETURN FALSE;
         WHEN ERR_DESACT_SS THEN
               SV_MsgError := 'Error al desactivar servicio suplementario de la tecnologia original.';
               RETURN FALSE;
         WHEN OTHERS THEN
               SV_MsgError := SUBSTR('Error oracle no controlado: ' || SQLERRM,1,255);
               RETURN FALSE;
END PV_Obtservsupltecno_fn;
----------------------------------------------------------------------------------------
FUNCTION PV_activar_aut_FN (EN_num_abonado            IN     GA_ABOCEL.NUM_ABONADO%TYPE,
                                     EN_nivel                  IN     GA_SERVSUPLABO.cod_nivel%TYPE,
                                      EV_cod_servicio            IN     GA_SERVSUPLABO.cod_servicio%TYPE,
                            EN_cod_servsupl            IN     GA_SERVSUPLABO.cod_servsupl%TYPE,
                            EN_producto                IN     GA_SERVSUPLABO.cod_producto%TYPE,
                            EN_num_celular            IN     GA_SERVSUPLABO.num_terminal%TYPE,
                            EV_clase_servicio        IN     GA_ABOCEL.clase_servicio%TYPE,
                                      EV_ident_aut              IN     VARCHAR2,
                            EV_tabla                IN    VARCHAR2,
                            SN_cod_retorno           OUT NOCOPY  ge_errores_pg.codError,
                            SV_mens_retorno          OUT NOCOPY  ge_errores_pg.MsgError,
                            SN_num_evento            OUT NOCOPY  ge_errores_pg.Evento)
                            RETURN BOOLEAN
/*
<Documentaci¥n
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "PV_activar_aut_FN"
      Lenguaje="PL/SQL"
      Fecha="15-11-2005"
      Versi¥n="1.0"
      Dise¿ador="TMC-05035"
      Programador="TMC-05035"
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripci¥n>Activa servicio de autenticacion</Descripci¥n>
      <Par¿metros>
         <Entrada>
            <param nom="EN_num_abonado"           Tipo="NUMERICO">NÀmero de Abonado</param>
            <param nom="EN_nivel"               Tipo="NUMERICO">Nivel</param>
            <param nom="EV_cod_servicio"           Tipo="CARACTER">Codigo de Servicio</param>
            <param nom="EN_cod_servsupl"           Tipo="NUMERICO">Codigo de Servicio Suplementario</param>
            <param nom="EN_producto"               Tipo="NUMERICO">Producto</param>
            <param nom="EN_num_celular"           Tipo="NUMERICO">NÀmero de Celular</param>
            <param nom="EV_clase_servicio"      Tipo="CARACTER">Clase de Servicio</param>
            <param nom="EV_ident_aut"           Tipo="CARACTER">Identificacion autenticacion</param>
            <param nom="EV_tabla"               Tipo="CARACTER">Nombre de tabla</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"       Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"     Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"       Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Par¿metros>
   </Elemento>
</Documentaci¥n>
*/
IS

     Error_Ejecucion           EXCEPTION ;
     /*Constantes*/
--     CV_num_version            CONSTANT ge_evento_to.version_prg%TYPE :='1.0';
     CV_num_version                     CONSTANT VARCHAR2(5) :='1.0';
     CN_ind_estado            CONSTANT GA_SERVSUPLABO.ind_estado%TYPE := 1;
       CV_ident_aut           CONSTANT VARCHAR2(6):='460001';
     /*Variables*/
--     LV_des_error            ge_evento_detalle_to.descripcion_error%TYPE;
--     LV_sSql                ge_evento_detalle_to.query%TYPE;
     LV_des_error                     ge_errores_pg.DesEvent;
     LV_sSql                         ge_errores_pg.vQuery;
     LV_clase_servicio      GA_ABOCEL.clase_servicio%TYPE;
     LN_total                NUMBER;

     BEGIN

     LV_des_error := ' ';
     LV_sSql      := ' ';
     SN_cod_retorno := 0;
     SV_mens_retorno := ' ';

        BEGIN

        /* ingresa un registro en ga_servsuplabo */

              LV_sSql:= 'INSERT INTO ga_servsuplabo'||
                      '( num_abonado'||
                      ', cod_servicio'||
                      ', fec_altabd'||
                      ', cod_servsupl'||
                      ', cod_nivel'||
                      ', cod_producto'||
                      ', num_terminal'||
                      ', nom_usuarora'||
                      ', ind_estado'||
                      ')'||
                      'VALUES '||
                      '( EN_num_abonado'||
                      ', EN_cod_servicio'||
                      ', SYSDATE'||
                      ', EN_cod_servsupl'||
                      ', EN_nivel'||
                      ', EN_producto'||
                      ', EN_num_celular'||
                      ', USER'||
                      ', CN_ind_estado'||
                    ');';

            INSERT INTO GA_SERVSUPLABO
            ( NUM_ABONADO
            , cod_servicio
            , fec_altabd
            , cod_servsupl
            , cod_nivel
            , cod_producto
            , num_terminal
            , nom_usuarora
            , ind_estado
            )
            VALUES
            ( EN_num_abonado
            , EV_cod_servicio
            , SYSDATE
            , EN_cod_servsupl
            , EN_nivel
            , EN_producto
            , EN_num_celular
            , USER
            , CN_ind_estado
            );

        EXCEPTION
        WHEN OTHERS THEN
              SN_cod_retorno := 4;/*  No se pudo agregar datos */
             RAISE error_ejecucion;
        END;

        IF EV_ident_aut IS NOT NULL THEN

           /* modifica un registro -clase de servicios- en ga_abocel */

           IF UPPER(EV_tabla) = 'GA_ABOCEL' THEN

               BEGIN
               LV_sSql:= 'UPDATE ga_abocel'||
                          'SET clase_servicio = EV_clase_servicio || EV_ident_aut'||
                          ' , fec_ultmod = SYSDATE'||
                          ', nom_usuarora = USER'||
                          'WHERE num_abonado = EN_num_abonado;';

               UPDATE GA_ABOCEL
               SET clase_servicio = EV_clase_servicio || EV_ident_aut
                      , fec_ultmod = SYSDATE
                   , nom_usuarora = USER
               WHERE NUM_ABONADO = EN_num_abonado;

               EXCEPTION
               WHEN OTHERS THEN
                  SN_cod_retorno := 2; /* No se pudo actualizar datos */
                 RAISE error_ejecucion;
               END;

           ELSE

               BEGIN
               LV_sSql:= 'UPDATE ga_aboamist'||
                          'SET clase_servicio = EV_clase_servicio || EV_ident_aut'||
                          ' , fec_ultmod = SYSDATE'||
                          ', nom_usuarora = USER'||
                          'WHERE num_abonado = EN_num_abonado;';

               UPDATE GA_ABOAMIST
               SET clase_servicio = EV_clase_servicio || EV_ident_aut
                      , fec_ultmod = SYSDATE
                   , nom_usuarora = USER
               WHERE NUM_ABONADO = EN_num_abonado;

               EXCEPTION
               WHEN OTHERS THEN
                  SN_cod_retorno := 2; /* No se pudo actualizar datos */
                 RAISE error_ejecucion;
               END;

           END IF;

        END IF;

        RETURN TRUE;

EXCEPTION
     WHEN error_ejecucion THEN
           IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
              SV_mens_retorno := CV_error_no_clasIF;
           END IF;
           LV_des_error := SUBSTR('PV_activar_aut_FN(...); - ' || SQLERRM,1,CN_largoerrtec);
           SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
           IF SN_num_evento IS NULL THEN
                 SN_num_evento := 0;
           END IF;
           SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_num_version, USER,
                                                         'Pv_Actcambios_Ofvirtual_Pg.PV_activar_aut_FN', LV_sSql, SQLCODE, SV_mens_retorno );
           RETURN FALSE;

     WHEN OTHERS  THEN
           SN_cod_retorno  := '302';
           IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno ,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasIF;
           END IF;
           LV_des_error := SUBSTR('PV_activar_aut_FN(...); - ' || SQLERRM,1,CN_largoerrtec);
           SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
           IF SN_num_evento IS NULL THEN
                 SN_num_evento := 0;
           END IF;
           SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_num_version, USER,
                                                        'Pv_Actcambios_Ofvirtual_Pg.PV_activar_aut_FN', LV_sSql, SQLCODE, SV_mens_retorno );
           RETURN FALSE;

END PV_activar_aut_FN;

-------------------------------------------------------------------------------------------------------------------------------------
FUNCTION PV_actualiza_ict_akeys_FN (EN_num_esn                 IN             ICT_AKEYS.num_esn%TYPE,
                                                               ED_fec_actualizacion     IN             ICT_AKEYS.fec_actualizacion%TYPE,
                                                     EN_cod_estado              IN             ICT_AKEYS.cod_estado%TYPE,
                                                     SN_cod_retorno          OUT NOCOPY  ge_errores_pg.codError,
                                                     SV_mens_retorno         OUT NOCOPY  ge_errores_pg.MsgError,
                                                     SN_num_evento           OUT NOCOPY  ge_errores_pg.Evento)
                            RETURN BOOLEAN
/*
<Documentaci¥n
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "PV_ACTUALIZA_ICT_AKEYS_FN"
      Lenguaje="PL/SQL"
      Fecha="15-11-2005"
      Versi¥n="1.0"
      Dise¿ador="TMC-05035"
      Programador="TMC-05035"
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripci¥n>Actualiza registro en la tabla ICT_akeys</Descripci¥n>
      <Par¿metros>
         <Entrada>
            <param nom="EN_num_esn"           Tipo="NUMERICO">NÀmero de Serie</param>
        <param nom="ED_fec_actualizacion"     Tipo="FECHA">Fecha de Actualizacion</param>
        <param nom="EN_cod_estado"         Tipo="NUMERICO">Estado</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"       Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"     Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"       Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Par¿metros>
   </Elemento>
</Documentaci¥n>
*/
IS
     Error_Ejecucion                    EXCEPTION ;
     /*Constantes*/
--     CV_num_version                    ge_evento_to.version_prg%TYPE :='1.0';
     CV_num_version                     CONSTANT VARCHAR2(5) :='1.0';
     /*Variables*/
--     LV_des_error                    ge_evento_detalle_to.descripcion_error%TYPE;
--     LV_sSql                             ge_evento_detalle_to.query%TYPE;
     LV_des_error                     ge_errores_pg.DesEvent;
     LV_sSql                         ge_errores_pg.vQuery;

     BEGIN

     LV_des_error := ' ';
     LV_sSql      := ' ';
     SN_cod_retorno := 0;
     SV_mens_retorno := ' ';

         BEGIN
         LV_sSql:= 'UPDATE ict_akeys'||
                      'SET fec_actualizacion = ED_fec_actualizacion,'||
                      'cod_estado = EN_cod_estado'||
                    'WHERE num_esn = EN_num_esn;';
         UPDATE ICT_AKEYS
        SET fec_actualizacion = ED_fec_actualizacion,
            cod_estado = EN_cod_estado
        WHERE num_esn = EN_num_esn;
            EXCEPTION
        WHEN OTHERS THEN
         SN_cod_retorno := 2;-- No se pudo actualizar datos
              RAISE error_ejecucion;
        END;
        RETURN TRUE;

EXCEPTION
     WHEN error_ejecucion THEN
           IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
              SV_mens_retorno := CV_error_no_clasIF;
           END IF;
           LV_des_error := SUBSTR('PV_actualiza_ict_akeys_FN(...); - ' || SQLERRM,1,CN_largoerrtec);
           SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
           SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_num_version, USER,
                                                         'Pv_Actcambios_Ofvirtual_Pg.PV_actualiza_ict_akeys_FN', LV_sSql, SQLCODE, SV_mens_retorno );
           RETURN FALSE;

     WHEN OTHERS  THEN
           SN_cod_retorno  := '302';
           IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno ,SV_mens_retorno) THEN
                SV_mens_retorno :=CV_error_no_clasIF;
           END IF;
           LV_des_error := SUBSTR('PV_actualiza_ict_akeys_FN(...); - ' || SQLERRM,1,CN_largoerrtec);
           SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
           SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_num_version, USER,
                                                        'Pv_Actcambios_Ofvirtual_Pg.PV_actualiza_ict_akeys_FN', LV_sSql, SQLCODE, SV_mens_retorno );
           RETURN FALSE;

END PV_actualiza_ict_akeys_FN;

-------------------------------------------------------------------------------------------------------------------------------------
FUNCTION PV_sCod_Autenticacion_FN
RETURN VARCHAR2
/*
<Documentaci¥n>
  <TipoDoc = "Function"/>
   <Elemento
      Nombre = "PV_sCod_Autenticacion_FN"
      Lenguaje="PL/SQL"
      Fecha="11-01-2006"
      Versi¥n="1.0"
      Dise¿ador="Patricio Gallegos"
      Programador="Patricio Gallegos"
      Ambiente Desarrollo="BD">
      <Retorno></Retorno>
      <Descripci¥n>Obtiene codigo servicio suplementario asociado a autentificacion</Descripci¥n>
      <Par¿metros>
         <Entrada>
         </Entrada>
         <Salida>
            <param nom="PV_sCod_Autenticacion_FN" Tipo="VARCHAR2">Servicio Suplementario de Autenticacion</param>
         </Salida>
      </Par¿metros>
   </Elemento>
</Documentaci¥n>
*/
IS
LV_IndOpeAut    GED_PARAMETROS.val_parametro%TYPE;
LV_sCod_Autenti GA_SERVSUPL.cod_servsupl%TYPE;
BEGIN

     Pv_Pr_Devvalparam(CV_cod_modulo_gral, 1,'OPER_AUTENTICACION',LV_IndOpeAut);

     IF LV_IndOpeAut = '1' THEN
        SELECT A.COD_SERVSUPL INTO LV_sCod_Autenti
        FROM GA_SERVSUPL A, GED_PARAMETROS B
        WHERE    A.COD_SERVICIO = B.VAL_PARAMETRO
        AND      B.NOM_PARAMETRO = 'IND_AUTENTICACION'
        AND      A.COD_PRODUCTO  = 1;

        RETURN TO_CHAR(LV_sCod_Autenti);
     END IF;

END PV_sCod_Autenticacion_FN;
----------------------------------------------------------------------------------------
FUNCTION PV_desactivar_aut_FN (EN_num_abonado    IN     GA_ABOCEL.NUM_ABONADO%TYPE,
                                        EN_cod_servicio          IN     GA_SERVSUPLABO.cod_servicio%TYPE,
                                        EN_cod_servsupl          IN     GA_SERVSUPLABO.cod_servsupl%TYPE,
                                        EV_clase_servicio     IN GA_ABOCEL.clase_servicio%TYPE,
                              EV_tabla                IN VARCHAR,
                              SN_cod_retorno           OUT NOCOPY  ge_errores_pg.codError,
                              SV_mens_retorno          OUT NOCOPY  ge_errores_pg.MsgError,
                              SN_num_evento            OUT NOCOPY  ge_errores_pg.Evento)
                            RETURN BOOLEAN
/*
<Documentaci¥n
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "PV_desactivar_aut_FN"
      Lenguaje="PL/SQL"
      Fecha="15-11-2005"
      Versi¥n="1.0"
      Dise¿ador="TMC-05035"
      Programador="TMC-05035"
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripci¥n>Desactiva servicio de autenticaci¥n</Descripci¥n>
      <Par¿metros>
         <Entrada>
            <param nom="EN_num_abonado"           Tipo="NUMERICO">NÀmero de Abonado</param>
            <param nom="EV_cod_servicio"           Tipo="CARACTER">Codigo de Servicio</param>
            <param nom="EN_cod_servsupl"           Tipo="NUMERICO">Codigo de Servicio Suplementario</param>
            <param nom="EV_clase_servicio"      Tipo="CARACTER">Clase de Servicio</param>
            <param nom="EV_tabla"               Tipo="CARACTER">Nombre de tabla</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"       Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"     Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"       Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Par¿metros>
   </Elemento>
</Documentaci¥n>
*/
IS
     Error_Ejecucion           EXCEPTION ;
     /*Constantes*/
--     CV_num_version            CONSTANT ge_evento_to.version_prg%TYPE :='1.0';
     CV_num_version                     CONSTANT VARCHAR2(5) :='1.0';
     CN_ind_estado            CONSTANT GA_SERVSUPLABO.ind_estado%TYPE := 3;
       CV_ident_aut           CONSTANT VARCHAR2(6):='460001';
     /*Variables*/
--     LV_des_error            ge_evento_detalle_to.descripcion_error%TYPE;
--     LV_sSql                ge_evento_detalle_to.query%TYPE;
     LV_des_error                     ge_errores_pg.DesEvent;
     LV_sSql                         ge_errores_pg.vQuery;
     LV_clase_servicio      GA_ABOCEL.clase_servicio%TYPE;
     LN_total                NUMBER;

     BEGIN

     LV_des_error := ' ';
     LV_sSql      := ' ';
     SN_cod_retorno := 0;
     SV_mens_retorno := ' ';

        BEGIN
              LV_sSql:= 'UPDATE ga_servsuplabo'||
                      'SET ind_estado = CN_ind_estado'||
                      ', nom_usuarora = USER'||
                      ', fec_bajabd = SYSDATE'||
                      'WHERE num_abonado = EN_num_abonado'||
                      'AND cod_servicio = EN_cod_servicio'||
                      'AND cod_servsupl = EN_cod_servsupl'||
                    'AND fec_bajabd IS NULL;';

            UPDATE GA_SERVSUPLABO
            SET ind_estado = CN_ind_estado
            , nom_usuarora = USER
            , fec_bajabd = SYSDATE
            WHERE NUM_ABONADO = EN_num_abonado
            AND cod_servicio = EN_cod_servicio
            AND cod_servsupl = EN_cod_servsupl
            AND fec_bajabd IS NULL;

        EXCEPTION
        WHEN OTHERS THEN
         SN_cod_retorno := 536;/* No se realiz¥ la actualizaci¥n de los servicios suplementarios con +xito */
              RAISE error_ejecucion;
        END;

        GV_sSERVICIO_AUTENTICACION := PV_sCod_Autenticacion_FN || '0000';

        LV_clase_servicio := REPLACE(EV_clase_servicio, CV_ident_aut, '');

           IF UPPER(EV_tabla) = 'GA_ABOCEL' THEN

            BEGIN
                /* sacar el 460001 de la clase de servicio */

                  LV_sSql:= 'UPDATE ga_abocel'||
                          'SET clase_servicio = LV_clase_servicio'||
                          ', fec_ultmod = SYSDATE'||
                          ', nom_usuarora = USER'||
                        'WHERE num_abonado = EN_num_abonado;';

                UPDATE GA_ABOCEL
                SET clase_servicio = LV_clase_servicio
                    , fec_ultmod = SYSDATE
                    , nom_usuarora = USER
                WHERE NUM_ABONADO = EN_num_abonado;

            EXCEPTION
            WHEN OTHERS THEN
             SN_cod_retorno := 536;/* No se realiz¥ la actualizaci¥n de los servicios suplementarios con +xito */
                  RAISE error_ejecucion;
            END;

        ELSE

            BEGIN
                /* sacar el 460001 de la clase de servicio */

                  LV_sSql:= 'UPDATE ga_aboamist'||
                          'SET clase_servicio = LV_clase_servicio'||
                          ', fec_ultmod = SYSDATE'||
                          ', nom_usuarora = USER'||
                        'WHERE num_abonado = EN_num_abonado;';

                UPDATE GA_ABOAMIST
                SET clase_servicio = LV_clase_servicio
                    , fec_ultmod = SYSDATE
                    , nom_usuarora = USER
                WHERE NUM_ABONADO = EN_num_abonado;

            EXCEPTION
            WHEN OTHERS THEN
             SN_cod_retorno := 536;/* No se realiz¥ la actualizaci¥n de los servicios suplementarios con +xito */
                  RAISE error_ejecucion;
            END;

        END IF;

        RETURN TRUE;

EXCEPTION
     WHEN error_ejecucion THEN
           IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
              SV_mens_retorno := CV_error_no_clasIF;
           END IF;
           LV_des_error := SUBSTR('PV_autenticacion_ss_FN(...); - ' || SQLERRM,1,CN_largoerrtec);
           SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
           IF SN_num_evento IS NULL THEN
                 SN_num_evento := 0;
           END IF;
           SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_num_version, USER,
                                                         'Pv_Actcambios_Ofvirtual_Pg.PV_autenticacion_ss_FN', LV_sSql, SQLCODE, SV_mens_retorno );
           RETURN FALSE;

     WHEN OTHERS  THEN
           SN_cod_retorno  := '302';
           IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno ,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasIF;
           END IF;
           LV_des_error := SUBSTR('PV_autenticacion_ss_FN(...); - ' || SQLERRM,1,CN_largoerrtec);
           SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
           IF SN_num_evento IS NULL THEN
                 SN_num_evento := 0;
           END IF;
           SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_num_version, USER,
                                                        'Pv_Actcambios_Ofvirtual_Pg.PV_autenticacion_ss_FN', LV_sSql, SQLCODE, SV_mens_retorno );
           RETURN FALSE;

END PV_desactivar_aut_FN;

-------------------------------------------------------------------------------------------------------------------------------------
FUNCTION PV_autenticacion_ss_FN (EN_num_abonado     IN     GA_ABOCEL.NUM_ABONADO%TYPE,
                                                                     EN_cod_servicio  IN     GA_SERVSUPLABO.cod_servicio%TYPE,
                                                            SN_cod_retorno   OUT NOCOPY  ge_errores_pg.codError,
                                                            SV_mens_retorno  OUT NOCOPY  ge_errores_pg.MsgError,
                                                            SN_num_evento    OUT NOCOPY  ge_errores_pg.Evento)
                            RETURN BOOLEAN
/*
<Documentaci¥n
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "PV_autenticacion_ss_FN"
      Lenguaje="PL/SQL"
      Fecha="15-11-2005"
      Versi¥n="1.0"
      Dise¿ador="TMC-05035"
      Programador="TMC-05035"
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripci¥n>Valida si existe servicio de autenticacion</Descripci¥n>
      <Par¿metros>
         <Entrada>
            <param nom="EN_num_abonado"           Tipo="NUMERICO">NÀmero de Abonado</param>
            <param nom="EV_cod_servicio"           Tipo="CARACTER">Codigo de Servicio</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"       Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"     Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"       Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Par¿metros>
   </Elemento>
</Documentaci¥n>
*/
IS
     Error_Ejecucion           EXCEPTION ;
     /*Constantes*/
     CV_num_version                     CONSTANT VARCHAR2(5) :='1.0';
     /*Variables*/
     LV_des_error                     ge_errores_pg.DesEvent;
     LV_sSql                         ge_errores_pg.vQuery;
     LN_total                NUMBER;

     BEGIN

     LV_des_error := ' ';
     LV_sSql      := ' ';
     SN_cod_retorno := 0;
     SV_mens_retorno := ' ';

        BEGIN
         LV_sSql:= 'SELECT count(1)'||
                      'INTO LN_total'||
                      'FROM ga_servsuplabo'||
                      'WHERE num_abonado = EN_num_abonado'||
                      'AND cod_servicio = EN_cod_servicio'||
                      'AND TRUNC(fec_altabd) >= TRUNC(SYSDATE)'||
                    'AND fec_bajabd IS NULL';

        SELECT COUNT(1)
        INTO LN_total
        FROM GA_SERVSUPLABO
        WHERE NUM_ABONADO = EN_num_abonado
        AND cod_servicio = EN_cod_servicio
        AND TRUNC(fec_altabd) <= TRUNC(SYSDATE)
        AND fec_bajabd IS NULL;

        IF LN_total > 0 THEN
           RETURN TRUE;
        ELSE
           RETURN FALSE;
        END IF;

        EXCEPTION
        WHEN OTHERS THEN
              SN_cod_retorno := 214;/* No es posible recuperar servicio suplementario. */
             RAISE error_ejecucion;
        END;
        RETURN TRUE;

EXCEPTION
     WHEN error_ejecucion THEN
           IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
              SV_mens_retorno := CV_error_no_clasIF;
           END IF;
           LV_des_error := SUBSTR('PV_autenticacion_ss_FN(...); - ' || SQLERRM,1,CN_largoerrtec);
           SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
           IF SN_num_evento IS NULL THEN
                 SN_num_evento := 0;
           END IF;
           SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_num_version, USER,
                                                         'Pv_Actcambios_Ofvirtual_Pg.PV_autenticacion_ss_FN', LV_sSql, SQLCODE, SV_mens_retorno );
           RETURN FALSE;

     WHEN OTHERS  THEN
           SN_cod_retorno  := '302';
           IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno ,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasIF;
           END IF;
           LV_des_error := SUBSTR('PV_autenticacion_ss_FN(...); - ' || SQLERRM,1,CN_largoerrtec);
           SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
           IF SN_num_evento IS NULL THEN
                 SN_num_evento := 0;
           END IF;
           SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_num_version, USER,
                                                        'Pv_Actcambios_Ofvirtual_Pg.PV_autenticacion_ss_FN', LV_sSql, SQLCODE, SV_mens_retorno );
           RETURN FALSE;

END PV_autenticacion_ss_FN;

-------------------------------------------------------------------------------------------------------------------------------------
FUNCTION PV_Inserta_ict_akeys_FN (EN_num_esn                 IN             ICT_AKEYS.num_esn%TYPE,
                                                              ED_fec_actualizacion     IN             ICT_AKEYS.fec_actualizacion%TYPE,
                                                    EN_id_carga              IN             ICT_AKEYS.id_carga%TYPE,
                                                    EN_cod_estado              IN             ICT_AKEYS.cod_estado%TYPE,
                                                    SN_cod_retorno          OUT NOCOPY  ge_errores_pg.codError,
                                                    SV_mens_retorno         OUT NOCOPY  ge_errores_pg.MsgError,
                                                    SN_num_evento           OUT NOCOPY  ge_errores_pg.Evento)
                            RETURN BOOLEAN
/*
<Documentaci¥n
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "PV_INSERTA_ICT_AKEYS_FN"
      Lenguaje="PL/SQL"
      Fecha="15-11-2005"
      Versi¥n="1.0"
      Dise¿ador="TMC-05035"
      Programador="TMC-05035"
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripci¥n>Inserta registro en la tabla ICT_akeys</Descripci¥n>
      <Par¿metros>
         <Entrada>
            <param nom="EN_num_esn"           Tipo="NUMERICO">NÀmero de Serie</param>
        <param nom="ED_fec_actualizacion"     Tipo="FECHA">Fecha de Actualizacion</param>
        <param nom="EN_id_carga"        Tipo="NUMERICO">Carga</param>
        <param nom="EN_cod_estado"         Tipo="NUMERICO">Estado</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"       Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"     Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"       Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Par¿metros>
   </Elemento>
</Documentaci¥n>
*/
IS
     Error_Ejecucion                    EXCEPTION ;
     /*Constantes*/
--     CV_num_version                    ge_evento_to.version_prg%TYPE :='1.0';
     CV_num_version                     CONSTANT VARCHAR2(5) :='1.0';
     /*Variables*/
--     LV_des_error                    ge_evento_detalle_to.descripcion_error%TYPE;
--     LV_sSql                             ge_evento_detalle_to.query%TYPE;
     LV_des_error                     ge_errores_pg.DesEvent;
     LV_sSql                         ge_errores_pg.vQuery;

     BEGIN

     LV_des_error := ' ';
     LV_sSql      := ' ';
     SN_cod_retorno := 0;
     SV_mens_retorno := ' ';

         BEGIN
         LV_sSql:= 'INSERT INTO ict_keys'||
                      '(NUM_ESN, FEC_ACTUALIZACION, ID_CARGA, COD_ESTADO)'||
                    'VALUES (EN_NUM_ESN , ED_FEC_ACTUALIZACION, EN_ID_CARGA, EN_COD_ESTADO);';
         INSERT INTO ICT_AKEYS
                (num_esn, fec_actualizacion, id_carga, cod_estado)
                VALUES (EN_num_esn , ED_fec_actualizacion, EN_id_carga, EN_cod_estado);
            EXCEPTION
        WHEN OTHERS THEN
            SN_cod_retorno := 4;-- No se pudo agregar datos
            RAISE error_ejecucion;
        END;
        RETURN TRUE;

EXCEPTION
     WHEN error_ejecucion THEN
           IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
              SV_mens_retorno := CV_error_no_clasIF;
           END IF;
           LV_des_error := SUBSTR('PV_Inserta_ICT_AKEYS_FN(...); - ' || SQLERRM,1,CN_largoerrtec);
           SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
           IF SN_num_evento IS NULL THEN
                 SN_num_evento := 0;
           END IF;
           SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_num_version, USER,
                                                         'Pv_Actcambios_Ofvirtual_Pg.PV_Inserta_ICT_AKEYS_FN', LV_sSql, SQLCODE, SV_mens_retorno );
           RETURN FALSE;

     WHEN OTHERS  THEN
          SN_cod_retorno  := '302';
           IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno ,SV_mens_retorno) THEN
                SV_mens_retorno :=CV_error_no_clasIF;
           END IF;
           LV_des_error := SUBSTR('PV_Inserta_ICT_AKEYS_FN(...); - ' || SQLERRM,1,CN_largoerrtec);
           SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
           IF SN_num_evento IS NULL THEN
                 SN_num_evento := 0;
           END IF;
           SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_num_version, USER,
                                                        'Pv_Actcambios_Ofvirtual_Pg.PV_Inserta_ICT_AKEYS_FN', LV_sSql, SQLCODE, SV_mens_retorno );
           RETURN FALSE;

END PV_Inserta_ICT_AKEYS_FN;

-------------------------------------------------------------------------------------------------------------------------------------

FUNCTION PV_elimina_ga_transacabo_FN(
                                     EN_num_transaccion      IN  GA_TRANSACABO.NUM_TRANSACCION%TYPE,
                            SN_cod_retorno      OUT NOCOPY   ge_errores_pg.codError,
                            SV_mens_retorno     OUT NOCOPY   ge_errores_pg.MsgError,
                            SN_num_evento       OUT NOCOPY   ge_errores_pg.Evento)
                            RETURN BOOLEAN
/*
<Documentaci¥n
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "PV_elimina_ga_transacabo_FN"
      Lenguaje="PL/SQL"
      Fecha="15-11-2005"
      Versi¥n="1.0"
      Dise¿ador="Christian Estay"
      Programador="CAGV"
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripci¥n>Elimina registro en tabla ga_transacabo</Descripci¥n>
      <Par¿metros>
         <Entrada>
            <param nom="EN_num_transaccion"       Tipo="NUMERICO">NÀmero de transaccion</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"       Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"     Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"       Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Par¿metros>
   </Elemento>
</Documentaci¥n>
*/
IS
     /*Constantes*/
--     CV_num_version                     ge_evento_to.version_prg%TYPE :='1.0';
     CV_num_version                     CONSTANT VARCHAR2(5) :='1.0';
     /*Variables*/
--     LV_des_error                     ge_evento_detalle_to.descripcion_error%TYPE;
--     LV_sSql                         ge_evento_detalle_to.query%TYPE;
     LV_des_error                     ge_errores_pg.DesEvent;
     LV_sSql                         ge_errores_pg.vQuery;

     BEGIN

          /*Eliminar registros que estan esperando ser ejecutados al cambio de ciclo*/
          LV_sSql:= 'DELETE GA_TRANSACABO'||
                      ' WHERE NUM_TRANSACCION ='||EN_num_transaccion;
          DELETE GA_TRANSACABO
          WHERE NUM_TRANSACCION = EN_num_transaccion;

          RETURN TRUE;
     EXCEPTION
     WHEN OTHERS  THEN
           SN_cod_retorno  := '3';-- No se realiz¥ la Eliminaci¥n con exito
           IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno ,SV_mens_retorno) THEN
                SV_mens_retorno :=CV_error_no_clasIF;
           END IF;
           LV_des_error := SUBSTR('PV_elimina_ga_transacabo_FN(...); - ' || SQLERRM,1,CN_largoerrtec);
           SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
           SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_num_version, USER,
                                                        'Pv_Actcambios_Ofvirtual_Pg.PV_elimina_ga_transacabo_FN', LV_sSql, SQLCODE, SV_mens_retorno );
           RETURN FALSE;

END  PV_elimina_ga_transacabo_FN;
-------------------------------------------------------------------------------------------------------------------------------------
FUNCTION PV_autenticacion_FN (
EV_num_serie       IN ICT_AKEYS.num_esn%TYPE,
EI_ind_activ      IN INTEGER,
EV_proc_equi      IN VARCHAR2,
EN_cod_uso        IN GA_ABOCEL.cod_uso%TYPE,
EN_num_abonado    IN GA_ABOCEL.num_celular%TYPE,
EV_tabla          IN VARCHAR2,
SV_comando           OUT NOCOPY   VARCHAR2,
SN_cod_retorno    OUT NOCOPY   ge_errores_pg.codError,
SV_mens_retorno   OUT NOCOPY   ge_errores_pg.MsgError,
SN_num_evento     OUT NOCOPY   ge_errores_pg.Evento
  ) RETURN NUMBER
/*
<Documentaci¥n
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "PV_AUTENTICACION_FN"
      Lenguaje="PL/SQL"
      Fecha="15-11-2005"
      Versi¥n="1.0"
      Dise¿ador="TMC-05035"
      Programador="TMC-05035"
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripci¥n>Activa servicio de autenticacion</Descripci¥n>
      <Par¿metros>
         <Entrada>
            <param nom="EN_num_serie"           Tipo="NUMERICO">NÀmero de Serie</param>
            <param nom="EI_ind_activ"               Tipo="NUMERICO">Activacion</param>
            <param nom="EV_proc_equi"           Tipo="CARACTER">Procedencia de Equipo</param>
            <param nom="EN_cod_uso"           Tipo="NUMERICO">Uso</param>
            <param nom="EN_num_abonado"               Tipo="NUMERICO">Numero de Abonado</param>
            <param nom="EV_tabla"               Tipo="CARACTER">Nombre de tabla</param>
         </Entrada>
         <Salida>
            <param nom="SV_comando"     Tipo="CARACTER">Cadena con servicios de autenticacion</param>
            <param nom="SN_cod_retorno"       Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"     Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"       Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Par¿metros>
   </Elemento>
</Documentaci¥n>
*/
IS

  Error_Ejecucion           EXCEPTION ;

     /*Constantes*/
--  CV_num_version            CONSTANT ge_evento_to.version_prg%TYPE :='1.0';
     CV_num_version                     CONSTANT VARCHAR2(5) :='1.0';

  CV_ident_aut                   CONSTANT VARCHAR2(6):='460001';
  CN_id_carga                   CONSTANT NUMBER := -1;
  CN_cod_estado                   CONSTANT NUMBER := -1;
  CN_cod_producto              CONSTANT GA_SERVSUPLABO.cod_producto%TYPE := 1;
  CN_cod_servsupl              CONSTANT GA_SERVSUPL.cod_servsupl%TYPE := '46'; /* SS de autenticacion */
  CV_cod_servicio_aut_si       CONSTANT GA_SERVSUPL.cod_servicio%TYPE := '124'; /* servicio de autenticacion activo */
  CV_cod_servicio_aut_no       CONSTANT GA_SERVSUPL.cod_servicio%TYPE := '125'; /* servicio de autenticacion desactivo */
  CN_retorna_ok                   CONSTANT NUMBER := 1;
  CN_retorna_no_ok               CONSTANT NUMBER := -1;

     /*Variables*/
  LV_des_error                     ge_errores_pg.DesEvent;
  LV_sSql                         ge_errores_pg.vQuery;
  LN_valor_seq                          GA_TRANSACABO.NUM_TRANSACCION%TYPE;
  LN_cod_salida                         GA_TRANSACABO.COD_RETORNO%TYPE;
  LV_cad_salida                      GA_TRANSACABO.DES_CADENA%TYPE;
  LN_autenticacion_ss            NUMBER;
  LV_comando_aut                VARCHAR2(6):= '460000';
  LN_retorno                      NUMBER := 0;
  LV_clase_servicio            GA_ABOCEL.clase_servicio%TYPE;
  LN_num_celular                 GA_ABOCEL.num_celular%TYPE;


BEGIN

     LV_des_error := ' ';
     LV_sSql      := ' ';
     SN_cod_retorno := 0;
     SV_mens_retorno := ' ';

     LV_sSql := 'SELECT GA_SEQ_TRANSACABO.NEXTVAL' ||
                 'INTO LN_valor_seq'||
                'FROM DUAL;';

     SELECT GA_SEQ_TRANSACABO.NEXTVAL
     INTO LN_valor_seq
     FROM DUAL;

     LV_sSql := 'GA_VALIDA_AUTENTICACION_PR( LN_valor_seq, PV, EV_num_serie, EV_proc_equi, NULL, EN_cod_uso );';

     Ga_Valida_Autenticacion_Pr( LN_valor_seq, 'PV', EV_num_serie, EV_proc_equi, NULL, EN_cod_uso );

     LV_sSql := 'SELECT COD_RETORNO, DES_CADENA Into LN_cod_salida, LV_cad_salida' ||
                 'FROM GA_TRANSACABO'||
                'WHERE NUM_TRANSACCION = LN_valor_seq;';

     SELECT COD_RETORNO, DES_CADENA INTO LN_cod_salida, LV_cad_salida
     FROM GA_TRANSACABO
     WHERE NUM_TRANSACCION = LN_valor_seq;

     LV_sSql := 'PV_Actcambios_ofvirtual_PG.PV_elimina_ga_transacabo_FN(LN_valor_seq, SN_cod_retorno, SV_mens_retorno, SN_num_evento )';

     IF NOT Pv_Actcambios_Ofvirtual_Pg.PV_elimina_ga_transacabo_FN(LN_valor_seq, SN_cod_retorno, SV_mens_retorno, SN_num_evento ) THEN
         RAISE Error_ejecucion;
     END IF;

     IF UPPER(EV_tabla) = 'GA_ABOCEL' THEN

         LV_sSql := 'SELECT clase_servicio, num_celular' ||
                     'INTO LV_clase_servicio, LN_num_celular'||
                     'FROM ga_abocel'||
                    'WHERE num_abonado = EN_num_abonado;';

         SELECT clase_servicio, num_celular
         INTO LV_clase_servicio, LN_num_celular
         FROM GA_ABOCEL
         WHERE NUM_ABONADO = EN_num_abonado;

     ELSE

         LV_sSql := 'SELECT clase_servicio, num_celular' ||
                     'INTO LV_clase_servicio, LN_num_celular'||
                     'FROM ga_aboamist'||
                    'WHERE num_abonado = EN_num_abonado;';

         SELECT clase_servicio, num_celular
         INTO LV_clase_servicio, LN_num_celular
         FROM GA_ABOAMIST
         WHERE NUM_ABONADO = EN_num_abonado;

     END IF;

     IF  LN_cod_salida = 0 THEN
     /* Continua con la PosVenta en MPR-TMC */

         LN_retorno := CN_retorna_ok;

     ELSIF LN_cod_salida = 1 THEN
     /* No continua la operacion en Posventa-MPR */

         LN_retorno := CN_retorna_no_ok;
         LV_cad_salida := LV_cad_salida || ' : ' || EV_num_serie;
         SV_mens_retorno := 'GA_VALIDA_AUTENTICACION_PR:'|| LV_cad_salida ||' .016';

     ELSIF LN_cod_salida = 2 THEN

         LV_sSql := 'PV_Inserta_ict_akeys_FN(TRIM(EV_num_serie), SYSDATE, CN_id_carga, CN_cod_estado, SN_cod_retorno, SV_mens_retorno, SN_num_evento)';

         IF NOT Pv_Actcambios_Ofvirtual_Pg.PV_Inserta_ict_akeys_FN(TRIM(EV_num_serie), SYSDATE, CN_id_carga, CN_cod_estado, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN


           LN_retorno := CN_retorna_no_ok;

        ELSE        /* Ejecut¥ OK */

             LN_retorno := CN_retorna_ok;

            LV_sSql := 'PV_autenticacion_ss_FN(EN_num_abonado, CV_cod_servicio_aut_si, SN_cod_retorno, SV_mens_retorno, SN_num_evento)';

           IF Pv_Actcambios_Ofvirtual_Pg.PV_autenticacion_ss_FN(EN_num_abonado, CV_cod_servicio_aut_si, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN


                  LV_sSql := 'PV_desactivar_aut_FN(EN_num_abonado, CV_cod_servicio_aut_si, CN_cod_servsupl, LV_clase_servicio, EV_tabla, SN_cod_retorno, SV_mens_retorno, SN_num_evento) ';

              IF NOT Pv_Actcambios_Ofvirtual_Pg.PV_desactivar_aut_FN(EN_num_abonado, CV_cod_servicio_aut_si, CN_cod_servsupl, LV_clase_servicio, EV_tabla, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN

                   LN_retorno := CN_retorna_no_ok;

              END IF;

           END IF;

        END IF;


     ELSIF     LN_cod_salida = 3 THEN
     /* TMC= ACtualiza Akeys en estado 1 - Activa Desactiva Servicio Suplementario */

            IF EI_ind_activ = 0 THEN

               SV_comando := '460000'; --Desactivacion Serv. Supl. Autenticacion

            ELSE

               SV_comando := '460001'; --Activacion Serv. Supl. Autenticacion

            END IF;

                  LV_sSql := 'PV_actualiza_ict_akeys_FN(EV_num_serie, SYSDATE, 1, SN_cod_retorno, SV_mens_retorno, SN_num_evento)';

            IF NOT Pv_Actcambios_Ofvirtual_Pg.PV_actualiza_ict_akeys_FN(EV_num_serie, SYSDATE, 1, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
            /* Error */

                   LN_retorno := CN_retorna_no_ok;

            ELSE

                 LN_retorno := CN_retorna_ok;

                     LV_sSql := 'PV_actcambios_ofvirtual_PG.PV_autenticacion_ss_FN(EN_num_abonado, CV_cod_servicio_aut_si, SN_cod_retorno, SV_mens_retorno, SN_num_evento)';

               IF NOT Pv_Actcambios_Ofvirtual_Pg.PV_autenticacion_ss_FN(EN_num_abonado, CV_cod_servicio_aut_si, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN

                           LV_sSql := 'PV_actcambios_ofvirtual_PG.PV_activar_aut_FN(EN_num_abonado, 1, CV_cod_servicio_aut_si, CN_cod_servsupl, CN_cod_producto, LN_num_celular, LV_clase_servicio, CV_ident_aut, EV_tabla, SN_cod_retorno, SV_mens_retorno, SN_num_evento)';

                     IF NOT Pv_Actcambios_Ofvirtual_Pg.PV_activar_aut_FN(EN_num_abonado, 1, CV_cod_servicio_aut_si, CN_cod_servsupl, CN_cod_producto, LN_num_celular, LV_clase_servicio, CV_ident_aut, EV_tabla, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN

                         LN_retorno := CN_retorna_no_ok;

                  END IF;

               END IF;

            END IF;

     ELSIF LN_cod_salida=4 THEN

            LN_retorno := CN_retorna_no_ok;

     ELSIF LN_cod_salida=5 THEN
     /* TMC = ACT-Des Servicio Suplementario */

                       LV_sSql := 'PV_autenticacion_ss_FN(EN_num_abonado, CV_cod_servicio_aut_si, SN_cod_retorno, SV_mens_retorno, SN_num_evento)';

               IF Pv_Actcambios_Ofvirtual_Pg.PV_autenticacion_ss_FN(EN_num_abonado, CV_cod_servicio_aut_si, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN

                             LV_sSql := 'PV_desactivar_aut_FN(EN_num_abonado, CV_cod_servicio_aut_si, CN_cod_servsupl, LV_clase_servicio, EV_tabla, SN_cod_retorno, SV_mens_retorno, SN_num_evento)';

                     IF NOT Pv_Actcambios_Ofvirtual_Pg.PV_desactivar_aut_FN(EN_num_abonado, CV_cod_servicio_aut_si, CN_cod_servsupl, LV_clase_servicio, EV_tabla, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN

                         LN_retorno := CN_retorna_no_ok;

                  END IF;

               END IF;

     END IF;

     RETURN LN_retorno;

EXCEPTION
     WHEN error_ejecucion THEN
           IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
              SV_mens_retorno := CV_error_no_clasIF;
           END IF;
           LV_des_error := SUBSTR('PV_autenticacion_FN(...); - ' || SQLERRM,1,CN_largoerrtec);
           SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
           IF SN_num_evento IS NULL THEN
                 SN_num_evento := 0;
           END IF;
           SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_num_version, USER,
                                                         'Pv_Actcambios_Ofvirtual_Pg.PV_autenticacion_FN', LV_sSql, SQLCODE, SV_mens_retorno );
           LN_retorno := CN_retorna_no_ok;
           RETURN LN_retorno;

     WHEN OTHERS  THEN
           SN_cod_retorno  := '302';
           IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno ,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasIF;
           END IF;
           LV_des_error := SUBSTR('PV_autenticacion_FN(...); - ' || SQLERRM,1,CN_largoerrtec);
           SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
           IF SN_num_evento IS NULL THEN
                 SN_num_evento := 0;
           END IF;
           SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_num_version, USER,
                                                        'Pv_Actcambios_Ofvirtual_Pg.PV_autenticacion_FN', LV_sSql, SQLCODE, SV_mens_retorno );
           LN_retorno := CN_retorna_no_ok;
           RETURN LN_retorno;

END PV_autenticacion_FN;
-------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_ins_equipaboser_PR (
ET_num_abonado      IN        GA_EQUIPABOSER.NUM_ABONADO%TYPE,
ET_num_serie      IN        GA_EQUIPABOSER.num_serie%TYPE,
ET_cod_producto      IN        GA_EQUIPABOSER.cod_producto%TYPE,
ET_ind_procequi      IN        GA_EQUIPABOSER.ind_procequi%TYPE,
ET_fec_alta      IN            GA_EQUIPABOSER.fec_alta%TYPE,
ET_ind_propiedad      IN        GA_EQUIPABOSER.ind_propiedad%TYPE,
ET_cod_bodega      IN        GA_EQUIPABOSER.cod_bodega%TYPE,
ET_tip_stock      IN        GA_EQUIPABOSER.tip_stock%TYPE,
ET_cod_articulo      IN        GA_EQUIPABOSER.cod_articulo%TYPE,
ET_ind_equiacc      IN        GA_EQUIPABOSER.ind_equiacc%TYPE,
ET_cod_modventa      IN        GA_EQUIPABOSER.cod_modventa%TYPE,
ET_tip_terminal      IN        GA_EQUIPABOSER.tip_terminal%TYPE,
ET_cod_uso      IN        GA_EQUIPABOSER.cod_uso%TYPE,
ET_cod_cuota      IN        GA_EQUIPABOSER.cod_cuota%TYPE,
ET_cod_estado      IN        GA_EQUIPABOSER.cod_estado%TYPE,
ET_cap_code      IN        GA_EQUIPABOSER.cap_code%TYPE,
ET_cod_protocolo      IN        GA_EQUIPABOSER.cod_protocolo%TYPE,
ET_num_velocidad      IN        GA_EQUIPABOSER.num_velocidad%TYPE,
ET_cod_frecuencia      IN        GA_EQUIPABOSER.cod_frecuencia%TYPE,
ET_cod_version      IN        GA_EQUIPABOSER.cod_version%TYPE,
ET_num_seriemec      IN        GA_EQUIPABOSER.num_seriemec%TYPE,
ET_des_equipo      IN        GA_EQUIPABOSER.des_equipo%TYPE,
ET_cod_paquete      IN        GA_EQUIPABOSER.cod_paquete%TYPE,
ET_num_movimiento      IN        GA_EQUIPABOSER.num_movimiento%TYPE,
ET_cod_causa      IN        GA_EQUIPABOSER.cod_causa%TYPE,
ET_ind_eqprestado      IN        GA_EQUIPABOSER.ind_eqprestado%TYPE,
ET_num_imei      IN        GA_EQUIPABOSER.num_imei%TYPE,
EV_fecha      IN        VARCHAR2,
ET_formatofec             IN VARCHAR2,
ET_cod_tecnologia        IN GA_EQUIPABOSER.cod_tecnologia%TYPE,
ET_imp_cargo            IN GA_EQUIPABOSER.imp_cargo%TYPE,
ET_prcVenta             IN GA_EQUIPABOSER.PRC_VENTA%TYPE,
EV_tipdto           IN              ga_equipaboser.TIP_DTO%TYPE,
EV_valdto           IN              ga_equipaboser.VAL_DTO%TYPE,
SN_cod_retorno      OUT NOCOPY ge_errores_pg.codError,
SV_des_error        OUT NOCOPY VARCHAR2 )


AS
/*
<Documentaci¥n>
  <TipoDoc = "Procedimiento"/>
   <Elemento
      Nombre = "pv_ins_equipaboser_pr "
      Lenguaje="PL/SQL"
      Fecha="21-11-2005"
      Versi¥n="1.0"
      Dise¿ador="Patricio Gallegos"
      Programador="Patricio Gallegos"
      Ambiente Desarrollo="BD">
      <Retorno></Retorno>
      <Descripci¥n>Ingresa registo a la tabla GA_EQUIPABOSER</Descripci¥n>
   </Elemento>
</Documentaci¥n>
*/
LV_Fecha      DATE;
LV_Precio_Venta     al_precios_venta.PRC_VENTA%TYPE;
SN_num_evento ge_errores_pg.Evento;

BEGIN

    SN_cod_retorno := 0;

    IF ET_fec_alta IS NULL AND Trim(EV_fecha) IS NULL THEN
       LV_Fecha := SYSDATE;
    ELSIF ET_fec_alta IS NULL THEN
       LV_Fecha:=TO_DATE(EV_fecha,ET_formatofec);
    ELSE
       LV_Fecha := ET_fec_alta;
    END IF;
--------------------------ET_num_serie o ET_num_imei
     -----------------SE AGREGA CAMPO PRC_VENTA EN GA_EQUIPABOSER 150909----INI-------------
     ---IF ET_ind_procequi = 'I' THEN
        --PV_ACTCAMBIOS_OFVIRTUAL_PG.PV_RECPRECIOVENTA_PR ( ET_num_serie, ET_num_abonado,ET_cod_modventa, LV_Precio_Venta, SN_cod_retorno, SV_des_error, SN_num_evento );
     ---END IF;

     -----------------SE AGREGA CAMPO PRC_VENTA EN GA_EQUIPABOSER 150909----FIN-------------
    INSERT INTO GA_EQUIPABOSER (
        NUM_ABONADO, num_serie, cod_producto, ind_procequi, fec_alta,
        ind_propiedad, cod_bodega, tip_stock, cod_articulo, ind_equiacc,
        cod_modventa, tip_terminal, cod_uso, cod_cuota, cod_estado,
        cap_code, cod_protocolo, num_velocidad, cod_frecuencia, cod_version,
        num_seriemec, des_equipo, cod_paquete, num_movimiento, cod_causa,
        ind_eqprestado, num_imei, cod_tecnologia, imp_cargo,tip_dto,val_dto,prc_venta)--prc_venta agregado 150909
    VALUES (
        ET_num_abonado, ET_num_serie, ET_cod_producto, ET_ind_procequi, LV_Fecha,
        ET_ind_propiedad, ET_cod_bodega, ET_tip_stock, ET_cod_articulo, ET_ind_equiacc,
        ET_cod_modventa, ET_tip_terminal, ET_cod_uso, ET_cod_cuota, ET_cod_estado,
        ET_cap_code, ET_cod_protocolo, ET_num_velocidad, ET_cod_frecuencia, ET_cod_version,
        ET_num_seriemec, ET_des_equipo, ET_cod_paquete, ET_num_movimiento, ET_cod_causa,
        ET_ind_eqprestado, ET_num_imei, ET_cod_tecnologia, ET_imp_cargo,EV_tipdto,EV_valdto,ET_prcVenta);

EXCEPTION
         WHEN OTHERS THEN
          SN_cod_retorno := 21;--No se ha podido ingresar la serie
         SV_des_error := SUBSTR(SQLERRM,1,255);
END PV_ins_equipaboser_PR;
-------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_interal_PR(
                               EV_TipMovimiento  IN    VARCHAR2,--Tipo Movimiento
                        EV_codTipStock      IN    AL_SERIES.tip_stock%TYPE,--Tipo de stock
                        EV_CodBodega      IN    AL_SERIES.cod_bodega%TYPE,--C¥digo bodega
                        EV_CodArticulo      IN    AL_SERIES.cod_articulo%TYPE,--C¥digo Articulo
                        EV_CodUso          IN    AL_SERIES.cod_uso%TYPE,--C¥digo Uso
                        EV_Estado          IN    AL_SERIES.cod_estado%TYPE,--C¥digo Estado
                        EV_Venta          IN    VARCHAR2,--NÀmero Venta
                        EV_cantidad          IN    VARCHAR2,--Cantidad
                        EV_NumSerie          IN    AL_SERIES.num_serie%TYPE,--NÀmero Serie
                        EV_IndTel           IN    VARCHAR2,
                        EN_cod_retorno      OUT NOCOPY     GA_TRANSACABO.cod_retorno%TYPE,
                        EV_des_cadena      OUT NOCOPY     GA_TRANSACABO.des_cadena%TYPE)

/*
<Documentaci¥n>
  <TipoDoc = "Procedimiento"/>
   <Elemento
      Nombre = "pv_interal_pr"
      Lenguaje="PL/SQL"
      Fecha="21-11-2005"
      Versi¥n="1.0"
      Dise¿ador="Patricio Gallegos"
      Programador="Patricio Gallegos"
      Ambiente Desarrollo="BD">
      <Retorno></Retorno>
      <Descripci¥n>Invoca interfaz con almac+n.</Descripci¥n>
      <Par¿metros>
         <Entrada>
            <param nom="EV_TipMovimiento" Tipo="CARACTER">Tipo movimiento.</param>
           <param nom="EV_codTipStock" Tipo="NUMERO">C¥digo tipo de stock.</param>
           <param nom="EV_CodBodega" Tipo="NUMERO">C¥digo bodega.</param>
           <param nom="EV_CodArticulo" Tipo="NUMERO">C¥digo de articulo.</param>
           <param nom="EV_CodUso" Tipo="NUMERO">C¥digo de uso.</param>
           <param nom="EV_Estado" Tipo="NUMERO">C¥digo de estado.</param>
           <param nom="EV_Venta" Tipo="NUMERO"></param>
           <param nom="EV_cantidad" Tipo="NUMERO">Cantidad.</param>
           <param nom="EV_NumSerie" Tipo="NUMERO">NÀmero de serie.</param>
           <param nom="EV_IndTel" Tipo="NUMERO"></param>
         </Entrada>
         <Salida>
            <param nom="EN_cod_retorno" Tipo="NUMERO">C¥digo retorno error</param>
            <param nom="EV_des_cadena" Tipo="CARACTER">Descripci¥n de la cadena</param>
         </Salida>
      </Par¿metros>
   </Elemento>
</Documentaci¥n>
*/
AS
LN_NumTransacabo        GA_TRANSACABO.num_transaccion%TYPE;
BEGIN
    SELECT GA_SEQ_TRANSACABO.NEXTVAL INTO LN_NumTransacabo FROM dual;
    P_Ga_Interal(LN_NumTransacabo, --NÀmero transacci¥n
                            EV_TipMovimiento,--Tipo Movimiento
                            EV_codTipStock,--Tipo de stock
                            EV_CodBodega,--C¥digo bodega
                            EV_CodArticulo,--C¥digo Articulo
                            EV_CodUso,--C¥digo Uso
                            EV_Estado,--C¥digo Estado
                            EV_Venta,--NÀmero Venta
                            EV_cantidad,--Cantidad
                            EV_NumSerie,--NÀmero Serie
                            EV_IndTel--Indicador telefono
                             );

    SELECT cod_retorno,des_cadena INTO EN_cod_retorno,EV_des_cadena
    FROM GA_TRANSACABO
    WHERE num_transaccion = LN_NumTransacabo;

    IF EN_cod_retorno = 0 THEN
        IF EV_des_cadena IS NULL THEN
           -- Error ejecutando actualizaci¥n de stock
           EN_cod_retorno := 4;
        END IF;
    END IF;
EXCEPTION
         WHEN OTHERS THEN
               EN_cod_retorno := 4;
END PV_interal_PR;
-------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE Pv_Generass_Plan_Pr (EN_cod_producto        IN ga_abocel.cod_producto%TYPE,
                                                EN_num_abonado            IN ga_servsuplabo.num_abonado%TYPE,
                                                EN_num_celular            IN ga_servsuplabo.num_terminal%TYPE,
                                                EV_nom_usuario            IN ga_servsuplabo.nom_usuarora%TYPE,
                                                EV_tabla_abo            IN VARCHAR2,
                                                EV_cod_plantarif        IN gad_servsup_plan.cod_plantarif%TYPE,
                                                EV_tip_terminal            IN icg_serviciotercen.tip_terminal%TYPE,
                                                EN_codcentral            IN icg_central.cod_central%TYPE,
                                                EV_cod_tecnologia        IN icg_serviciotercen.tip_tecnologia%TYPE,
                                                EV_cod_plantarif_nue    IN gad_servsup_plan.cod_plantarif%TYPE,
                                                EN_codcentral_nva        IN icg_central.cod_central%TYPE,
                                                EV_tip_terminal_nue        IN icg_serviciotercen.tip_terminal%TYPE,
                                                EV_cod_tecnologia_nue    IN icg_serviciotercen.tip_tecnologia%TYPE,
                                                LV_sCadenaPlan            OUT NOCOPY VARCHAR2    )
IS

CURSOR LC_SSupl  IS
     SELECT a.cod_servsupl, a.cod_nivel, a.cod_servicio
     FROM GA_SERVSUPLABO a
     WHERE NUM_ABONADO = EN_num_abonado
     AND   ind_estado < 3;

LN_cod_sistema            icg_central.cod_sistema%TYPE;
LN_cod_sistema_nue         icg_central.cod_sistema%TYPE;

CURSOR LC_SSdesac    IS
    SELECT a.cod_servsupl,a.cod_nivel,'D',a.cod_servicio
    FROM ga_servsupl a,icg_serviciotercen b,gad_servsup_plan c
    WHERE c.cod_producto = EN_cod_producto
    AND b.cod_producto = a.cod_producto
    AND b.tip_terminal = EV_tip_terminal
    AND b.cod_sistema = LN_cod_sistema
    AND b.cod_servicio = a.cod_servsupl
    AND b.tip_tecnologia = EV_cod_tecnologia
    AND a.cod_servicio = c.cod_servicio
    AND a.cod_producto = c.cod_producto
    AND c.cod_plantarif = EV_cod_plantarif
    AND c.tip_relacion = 3
    AND SYSDATE BETWEEN c.fec_desde AND c.fec_hasta;

CURSOR LC_SSactivar        IS
SELECT A.COD_SERVSUPL,A.COD_NIVEL,'A',A.COD_SERVICIO
 FROM GA_SERVSUPL A,ICG_SERVICIOTERCEN B,GAD_SERVSUP_PLAN C
 WHERE C.COD_PRODUCTO = EN_cod_producto
 AND B.COD_PRODUCTO = A.COD_PRODUCTO
 AND B.TIP_TERMINAL = EV_tip_terminal_nue
 AND B.COD_SISTEMA = LN_cod_sistema_nue
 AND B.COD_SERVICIO = A.COD_SERVSUPL
 AND B.TIP_TECNOLOGIA = EV_cod_tecnologia_nue
 AND A.COD_SERVICIO = C.COD_SERVICIO
 AND A.COD_PRODUCTO = C.COD_PRODUCTO
 AND C.COD_PLANTARIF = EV_cod_plantarif_nue
 AND C.TIP_RELACION = 3
 AND SYSDATE BETWEEN C.FEC_DESDE AND C.FEC_HASTA;

 --   'SS OPCIONALES
 --   'Buscar ss opcionales que esten para desactivar y marcarlos para no realizar operacion
 CURSOR LC_SSopcional        IS
 SELECT a.cod_servsupl,a.cod_nivel
 FROM ga_servsupl a,icg_serviciotercen b,gad_servsup_plan c
 WHERE c.cod_producto = EN_cod_producto
 AND b.cod_producto = A.COD_PRODUCTO
 AND b.tip_terminal = EV_tip_terminal_nue
 AND b.cod_sistema = LN_cod_sistema_nue
 AND b.cod_servicio = a.cod_servsupl
 AND b.tip_tecnologia = EV_cod_tecnologia_nue
 AND a.cod_servicio = c.cod_servicio
 AND a.cod_producto = c.cod_producto
 AND c.cod_plantarif = EV_cod_plantarif_nue
 AND c.tip_relacion = 2
 AND SYSDATE BETWEEN c.fec_desde AND c.fec_hasta;

TYPE LR_servsupl IS RECORD (
cod_servsupl       GA_SERVSUPLABO.cod_servsupl%TYPE,
cod_nivel          GA_SERVSUPLABO.cod_nivel%TYPE,
cod_servicio    GA_SERVSUPLABO.cod_servicio%TYPE,
valor4          VARCHAR2(2),
valor5          VARCHAR2(2));

TYPE LT_servsupl IS TABLE OF LR_servsupl INDEX BY BINARY_INTEGER;

CO_SSabonados                      LT_servsupl;
CO_SSDesactiva                    LT_servsupl;
CO_SSActiva                        LT_servsupl;
CO_SSFinal                        LT_servsupl;
CO_SSTranferencia                LT_servsupl;

F        INTEGER;
T        INTEGER:=0;
LN_cod_servsupl           ga_servsuplabo.cod_servsupl%TYPE;
LN_cod_nivel              ga_servsuplabo.cod_nivel%TYPE;
LV_cod_servicio            ga_servsuplabo.cod_servicio%TYPE;

LV_valor                VARCHAR2(1);


d1         INTEGER;
a        INTEGER;
d2        INTEGER;
D         INTEGER;
s        INTEGER;

nSwEncontro2    INTEGER;
nSwEncontro        INTEGER;
LD_FechaHoy        DATE:=SYSDATE;

sGrupo            VARCHAR(2);--ga_servsupl.cod_servsupl%TYPE;
sNivel            VARCHAR(4);
sCadenaICC        VARCHAR2(255);

error_fin        EXCEPTION;

i                INTEGER;
sNivel1            VARCHAR(4);
sGrupo1            VARCHAR(2);
sNivel2            VARCHAR(4);
sGrupo2            VARCHAR(2);
sw                PLS_INTEGER;
j                INTEGER;
j1                INTEGER;
X                INTEGER;
countgrup        INTEGER;
sCadenaICC2        VARCHAR2(255);
--sCadenaPlan        VARCHAR2(255);

FUNCTION bIncompatibilidad(    EV_cod_servicio    IN     ga_servsuplabo.cod_servicio%TYPE,
                            L                 IN OUT NOCOPY INTEGER)
RETURN BOOLEAN IS

 CURSOR LC_SSincompatible    IS
 SELECT a.cod_servdef
 FROM ga_servsup_def a, ga_servsupl b, icg_serviciotercen c
 WHERE a.cod_servicio = EV_cod_servicio
 AND a.tip_relacion =  3
 AND SYSDATE BETWEEN a.fec_desde AND a.fec_hasta
 AND a.cod_producto = b.cod_producto
 AND a.cod_servicio = b.cod_servicio
 AND b.cod_producto = c.cod_producto
 AND b.cod_servsupl = c.cod_servicio
 AND c.cod_sistema = LN_cod_sistema
 AND c.tip_terminal = EV_tip_terminal
 AND c.tip_tecnologia = EV_cod_tecnologia;

 F    INTEGER;
 LV_cod_servincomp        ga_servsuplabo.cod_servicio%TYPE;

BEGIN

    OPEN LC_SSincompatible;
        LOOP
            FETCH LC_SSincompatible
            INTO LV_cod_servincomp;
            EXIT WHEN LC_SSincompatible%NOTFOUND;

            FOR F IN NVL(CO_SSabonados.FIRST,0)..NVL(CO_SSabonados.LAST,-1) LOOP
                   IF CO_SSabonados(F).cod_servicio = LV_cod_servincomp THEN
                      --'Existe incompatibilidad
                      CO_SSTranferencia(L).cod_servicio := CO_SSAbonados(F).cod_servicio;
                      CO_SSTranferencia(L).valor4 := 'D';
                      CO_SSTranferencia(L).cod_servsupl := CO_SSAbonados(F).cod_servsupl;
                      CO_SSTranferencia(L).cod_nivel := CO_SSAbonados(F).cod_nivel;
                      L := L + 1;
                      --                           bIncompatibilidad = TRUE
                      CLOSE LC_SSincompatible;
                      RETURN TRUE;
                   END IF;
            END LOOP;

        CLOSE LC_SSincompatible;
        END LOOP;

        RETURN FALSE;

END bIncompatibilidad;

PROCEDURE Transferencia(EV_cod_servicio    IN     ga_servsuplabo.cod_servicio%TYPE,
                        T                 IN OUT NOCOPY INTEGER)

IS

 CURSOR LC_SSTransferencia    IS
 SELECT b.cod_servsupl,b.cod_nivel,'A',b.cod_servicio
 FROM ga_servsup_def a, ga_servsupl b, icg_serviciotercen c
 WHERE a.cod_servicio = EV_cod_servicio
 AND a.tip_relacion = 4
 AND SYSDATE BETWEEN a.fec_desde AND a.fec_hasta
 AND a.cod_servdef = b.cod_servicio
 AND b.cod_producto = 1
 AND a.cod_producto = b.cod_producto
 AND b.cod_producto = c.cod_producto
 AND b.cod_servsupl = c.cod_servicio
 AND c.cod_sistema = LN_cod_sistema
 AND c.tip_terminal = EV_tip_terminal
 AND c.tip_tecnologia = EV_cod_tecnologia;

BEGIN

    OPEN LC_SSTransferencia;
        LOOP
            FETCH LC_SSTransferencia
            INTO LN_cod_servsupl, LN_cod_nivel,LV_valor,LV_cod_servicio;
            EXIT WHEN LC_SSTransferencia%NOTFOUND;

            IF NOT bIncompatibilidad(LV_cod_servicio,T) THEN
               CO_SSTranferencia(T).cod_servsupl := LN_cod_servsupl;
               CO_SSTranferencia(T).cod_nivel := LN_cod_nivel;
               CO_SSTranferencia(T).cod_servicio := LV_cod_servicio;
               CO_SSTranferencia(T).valor4 := LV_valor;
               T := T + 1;
            END IF;

        END LOOP;

    CLOSE LC_SSTransferencia;


END Transferencia;

PROCEDURE ComponeNuevaCadena(sCad1 IN OUT VARCHAR2,
                               sCadC IN VARCHAR2)
IS
sTmpS        VARCHAR2(1000);
sTmpN         VARCHAR2(1000);
sTmpS2        VARCHAR2(1000);
sTmpN2        VARCHAR2(1000);
i              INTEGER;
j             INTEGER;
bIndCambio  BOOLEAN;
sCadTmp        VARCHAR2(1000);

BEGIN

    FOR i IN 0..((LENGTH(sCadC) / 6)) - 1 LOOP
       --sTmpS2 = Mid$(sCadC, i * 6 + 1, 2)
       sTmpS2 := SUBSTR(sCadC, i * 6 + 1, 2);
       --sTmpN2 = Mid$(sCadC, i * 6 + 3, 4)
       sTmpN2 := SUBSTR(sCadC, i * 6 + 3, 4);
       bIndCambio := FALSE;
       FOR j IN 0..((LENGTH(sCad1) / 6) - 1) LOOP
           --sTmpS = Mid$(sCad1, j * 6 + 1, 2)
           sTmpS := SUBSTR(sCad1, j * 6 + 1, 2);
           --sTmpN = Mid$(sCad1, j * 6 + 3, 4)
           sTmpN := SUBSTR(sCad1, j * 6 + 3, 4);
           IF sTmpS = sTmpS2 THEN
              --'Ha habido un cambio de nivel en un servicio
              --sCadTmp = Mid$(sCad1, 1, j * 6)
              sCadTmp := SUBSTR(sCad1, 1, j * 6);
              IF sTmpN2 != '0000' THEN
                 --sCadTmp = sCadTmp + Format$(sTmpS2, "00") + Format$(sTmpN2, "0000")
                 sCadTmp := sCadTmp || SUBSTR('00' || sTmpS2,-2) + SUBSTR('0000' || sTmpN2,-4);
              END IF;
              --sCadTmp = sCadTmp + Mid$(sCad1, j * 6 + 7)
              sCadTmp := sCadTmp || SUBSTR(sCad1, j * 6 + 7);
              sCad1 := sCadTmp;
              bIndCambio := TRUE;
              EXIT;
           END IF;
       END LOOP;
       IF bIndCambio = FALSE THEN
          --sCad1 = sCad1 + Format$(sTmpS2, "00") + Format$(sTmpN2, "0000")
          sCad1 := sCad1 ||  SUBSTR('00' || sTmpS2,-2) + SUBSTR('0000' || sTmpN2,-4);
       END IF;
    END LOOP;

END ComponeNuevaCadena;

FUNCTION bActDesSS(sTipoAct                IN VARCHAR2,
                   sCodServicio                IN ga_servsuplabo.cod_servicio%TYPE,
                   sServSupl                IN ga_servsuplabo.cod_servsupl%TYPE,
                  sCodNivel                IN ga_servsuplabo.cod_nivel%TYPE)
RETURN BOOLEAN IS
       sCodConcepto                           ga_actuaserv.cod_concepto%TYPE;
       sNumDiasNum                           ga_servsuplabo.num_diasnum%TYPE;
       sGrupo                               VARCHAR2(10);
       sNivel                               VARCHAR2(10);
       sCadCambios                           VARCHAR2(1000);
       sCadServicios                       VARCHAR2(1000);
       --sCodConcepto                           ga_actuaserv.cod_concepto%TYPE;
       --sNumDiasNum                           ga_servsuplabo.num_diasnum%TYPE;
BEGIN

    IF sTipoAct = 'D' THEN  --'Desactiva

        UPDATE GA_SERVSUPLABO
        SET FEC_BAJABD = LD_FechaHoy,IND_ESTADO=3
        WHERE NUM_ABONADO = EN_num_abonado
        AND COD_SERVSUPL = sServSupl
        AND COD_NIVEL = sCodNivel
        AND IND_ESTADO < 3;

        sGrupo := SUBSTR('00' || sServSupl,LENGTH('00' || sServSupl) - 1,2);
        --sGrupo = Mid$("00" + sServSupl, Len("00" + sServSupl) - 1, 2)
        sNivel := '0000';
        sCadCambios := sCadCambios || sGrupo || sNivel;

    ELSIF sTipoAct = 'A' THEN  --'Activa

        BEGIN
            SELECT cod_concepto INTO sCodConcepto
            FROM ga_actuaserv
            WHERE cod_producto = EN_cod_producto AND cod_tipserv = 2
            AND cod_servicio = sCodServicio AND cod_actabo = 'FA';
        EXCEPTION
                 WHEN NO_DATA_FOUND THEN
                        sCodConcepto := NULL;
        END;

        BEGIN
            SELECT num_diasnum
            INTO sNumDiasNum
            FROM GA_SERVSUPLABO
            WHERE NVL(cod_producto,1) = EN_cod_producto
            AND cod_servicio = sCodServicio
            AND num_abonado = EN_num_abonado
            AND FEC_BAJABD = SYSDATE;
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
             sNumDiasNum := NULL;
        END;

        INSERT INTO GA_SERVSUPLABO
        (NUM_ABONADO, COD_SERVICIO, FEC_ALTABD, COD_SERVSUPL, COD_NIVEL, NUM_TERMINAL,
        COD_PRODUCTO, NOM_USUARORA, IND_ESTADO, COD_CONCEPTO, NUM_DIASNUM)
        VALUES (
        EN_num_abonado,
        sCodServicio,
        LD_FechaHoy,
        sServSupl,
        sCodNivel,
        EN_num_celular,
        EN_cod_producto,
        NVL(Trim(EV_nom_usuario),USER),
        --USER,
        1 ,
        sCodConcepto,
        sNumDiasNum);

        sGrupo := SUBSTR('00' || sServSupl,LENGTH('00' || sServSupl) - 1,2);
        --sGrupo = Mid$("00" + sServSupl, Len("00" + sServSupl) - 1, 2)
        sNivel := SUBSTR('0000' || sCodNivel, LENGTH('0000' || sCodNivel) - 3, 4);
        --sNivel = Mid$("0000" + sCodNivel, Len("0000" + sCodNivel) - 3, 4)
        sCadCambios := sCadCambios || sGrupo || sNivel;

    END IF;


    IF EV_tabla_abo = 'GA_ABOCEL' THEN
        SELECT clase_servicio INTO sCadServicios
        FROM ga_abocel
        WHERE num_abonado = EN_num_abonado;
    ELSE
        SELECT clase_servicio INTO sCadServicios
        FROM ga_aboamist
        WHERE num_abonado = EN_num_abonado;
    END IF;

    ComponeNuevaCadena (sCadServicios, sCadCambios);

    IF EV_tabla_abo = 'GA_ABOCEL' THEN
        UPDATE ga_Abocel  SET --"    'MAM.11/08/2003
        clase_servicio = sCadServicios
        WHERE NUM_ABONADO = EN_num_abonado;
    ELSE
        UPDATE ga_Aboamist  SET --"    'MAM.11/08/2003
        clase_servicio = sCadServicios
        WHERE NUM_ABONADO = EN_num_abonado;
    END IF;

    RETURN TRUE;
EXCEPTION
         WHEN OTHERS THEN
               RETURN FALSE;
END bActDesSS;

FUNCTION VALIDABAJAGESTOR(EV_cod_servicio        IN ga_servsupl.cod_servicio%TYPE,
                          EN_cod_servsupl           IN ga_servsupl.cod_servsupl%TYPE,
                          EN_cod_nivel              IN ga_servsupl.cod_nivel%TYPE,
                          EN_cod_producto        IN ga_servsupl.cod_producto%TYPE)
RETURN BOOLEAN IS

LN_ind_gestor    ga_servsupl.ind_gestor%TYPE;

BEGIN

    SELECT ind_gestor INTO LN_ind_gestor
    FROM ga_servsupl
    WHERE cod_producto    = EN_cod_producto
    AND  cod_servicio     = EV_cod_servicio
    AND  cod_servsupl      = EN_cod_servsupl
    AND  cod_nivel        = EN_cod_nivel;

    IF LN_ind_gestor = 1 THEN
        RETURN FALSE;
    ELSE
        RETURN TRUE;
    END IF;
END VALIDABAJAGESTOR;

BEGIN

    F:=0;

    OPEN LC_SSupl;
        LOOP
            FETCH LC_SSupl
            INTO   LN_cod_servsupl,LN_cod_nivel,LV_cod_servicio;
            EXIT WHEN LC_SSupl%NOTFOUND;

            CO_SSabonados(F).cod_servsupl:= LN_cod_servsupl;
            CO_SSabonados(F).cod_nivel := LN_cod_nivel;
            CO_SSabonados(F).cod_servicio :=  LV_cod_servicio;

            F := F + 1;

        END LOOP;

    CLOSE LC_SSupl;

    SELECT cod_sistema
    INTO LN_cod_sistema
    FROM icg_central
    WHERE cod_producto = EN_cod_producto
    AND cod_central = EN_codcentral;

     F := 0;

    OPEN LC_SSdesac;
        LOOP
            FETCH LC_SSdesac
            INTO LN_cod_servsupl, LN_cod_nivel,LV_valor,LV_cod_servicio;
            EXIT WHEN LC_SSdesac%NOTFOUND;

            CO_SSDesactiva(F).cod_servsupl:= LN_cod_servsupl;
            CO_SSDesactiva(F).cod_nivel := LN_cod_nivel;
            CO_SSDesactiva(F).cod_servicio :=  LV_cod_servicio;
            CO_SSDesactiva(F).valor4 := LV_valor;

            F := F + 1;

        END LOOP;
    CLOSE LC_SSdesac;

    SELECT cod_sistema
    INTO LN_cod_sistema_nue
    FROM icg_central
    WHERE cod_central = EN_codcentral_nva
    AND cod_producto = EN_cod_producto;

    F := 0;

    OPEN LC_SSactivar;
        LOOP
            FETCH LC_SSactivar
            INTO LN_cod_servsupl, LN_cod_nivel,LV_valor,LV_cod_servicio;
            EXIT WHEN LC_SSactivar%NOTFOUND;

            CO_SSActiva(F).cod_servsupl:= LN_cod_servsupl;
            CO_SSActiva(F).cod_nivel := LN_cod_nivel;
            CO_SSActiva(F).cod_servicio :=  LV_cod_servicio;
            CO_SSActiva(F).valor4 := LV_valor;

            F := F + 1;

        END LOOP;
    CLOSE LC_SSactivar;

    D := 0;

    FOR d1 IN NVL(CO_SSDesactiva.FIRST,0)..NVL(CO_SSDesactiva.LAST,-1) LOOP

        FOR a IN NVL(CO_SSActiva.FIRST,0)..NVL(CO_SSActiva.LAST,-1) LOOP

            IF CO_SSActiva(a).cod_servsupl = CO_SSDesactiva(d1).cod_servsupl THEN

                CO_SSDesactiva(d1).valor4 := 'E';     --SSDesactiva(d1, 2) = "E"

                nSwEncontro2 := 0;

                FOR d2 IN NVL(CO_SSabonados.FIRST,0)..NVL(CO_SSabonados.LAST,-1) LOOP

                    --If SSAbonados(d2, 1) = SSActiva(a, 0) Then
                    IF CO_SSabonados(d2).cod_servsupl = CO_SSActiva(a).cod_servsupl THEN

                        nSwEncontro2 := 1;

                        LN_cod_servsupl           := CO_SSAbonados(d2).cod_servsupl;
                        LN_cod_nivel              := CO_SSAbonados(d2).cod_nivel;
                        LV_cod_servicio            := CO_SSAbonados(d2).cod_servicio;

                        --'Si el nivel tambi+n es igual entonces el abonado ya lo tiene, no se procesa
                        --' y debe marcarse como encontrado
                        --IF SSAbonados(d2, 2) = SSActiva(a, 1) THEN
                        IF CO_SSabonados(d2).cod_nivel = CO_SSActiva(a).cod_nivel THEN
                            nSwEncontro2 := 2;
                        END IF;
                        EXIT;

                    END IF;


                END LOOP;

                IF nSwEncontro2 = 1 THEN
                    --'El SS fue encontrado debe deshabilitarse el antiguo y habilitar el nuevo
                    CO_SSFinal(D).cod_servsupl := LN_cod_servsupl;
                    CO_SSFinal(D).cod_nivel := LN_cod_nivel;
                    CO_SSFinal(D).valor4 := 'D';
                    CO_SSFinal(D).cod_servicio := LV_cod_servicio;
                    D := D + 1;
               ELSIF nSwEncontro2 = 2 THEN
                    CO_SSActiva(a).valor4 := 'E';
               END IF;
               nSwEncontro := 1;
               EXIT;

            END IF;


        END LOOP; --Next a

--            'El SS no lo encuentra en el plan nuevo entonces debe desactivarlo
        IF nSwEncontro = 0 THEN
           CO_SSFinal(D).cod_servsupl := CO_SSDesactiva(d1).cod_servsupl; --sServicioD;
           CO_SSFinal(D).cod_nivel := CO_SSDesactiva(d1).cod_nivel; --sNivelD;
           CO_SSFinal(D).cod_servicio := CO_SSDesactiva(d1).cod_servicio;
           CO_SSFinal(D).valor4 := CO_SSDesactiva(d1).valor4;
           D := D + 1;
        END IF;


    END LOOP;--Next d1

    --'Ahora pasamos los a activar no encontrados
    --FOR a = 0 TO 200
    FOR a IN NVL(CO_SSActiva.FIRST,0)..NVL(CO_SSActiva.LAST,-1) LOOP
        --IF Trim(SSActiva(a, 2)) <> "E" THEN
        IF CO_SSActiva(a).valor4 <> 'E' THEN
           CO_SSFinal(D).cod_servsupl := CO_SSActiva(a).cod_servsupl;
           CO_SSFinal(D).cod_nivel := CO_SSActiva(a).cod_nivel ;
           CO_SSFinal(D).cod_servicio := CO_SSActiva(a).cod_servicio;
           CO_SSFinal(D).valor4 := CO_SSActiva(a).valor4;
           D := D + 1;
        END IF;
    END LOOP;

    OPEN LC_SSopcional;
        LOOP
            FETCH LC_SSopcional
            INTO LN_cod_servsupl, LN_cod_nivel;
            EXIT WHEN LC_SSopcional%NOTFOUND;
            --FOR a = 0 TO 200
            FOR a IN NVL(CO_SSFinal.FIRST,0)..NVL(CO_SSFinal.LAST,-1) LOOP
              --IF Trim(SSFinal(a, 0)) = "" THEN EXIT FOR
              IF LN_cod_servsupl = CO_SSFinal(a).cod_servsupl AND LN_cod_nivel = CO_SSFinal(a).cod_nivel AND CO_SSFinal(a).valor4 = 'D' THEN
                  CO_SSFinal(a).valor4 := 'E';-- 'No desactivar el SS opcional
                  EXIT;
              END IF;
            END LOOP;
        END LOOP;
    CLOSE LC_SSopcional;

    T := 0;
    FOR F IN NVL(CO_SSFinal.FIRST,0)..NVL(CO_SSFinal.LAST,-1) LOOP

        IF CO_SSFinal(F).valor4 = 'A' THEN


           IF bIncompatibilidad(CO_SSFinal(F).cod_servicio, T) THEN
              CO_SSFinal(F).valor4 := 'E';
           END IF;

        ELSIF CO_SSFinal(F).valor4 = 'D' THEN

            Transferencia(CO_SSFinal(F).cod_servicio, T);

        END IF;

    END LOOP;

    -- FOR F = 0 TO 200
    FOR F IN NVL(CO_SSTranferencia.FIRST,0)..NVL(CO_SSTranferencia.LAST,-1) LOOP
        CO_SSFinal(D).cod_servsupl := CO_SSTranferencia(F).cod_servsupl;
        CO_SSFinal(D).cod_nivel := CO_SSTranferencia(F).cod_nivel;
        CO_SSFinal(D).cod_servicio := CO_SSTranferencia(F).cod_servicio;
        CO_SSFinal(D).valor4 := CO_SSTranferencia(F).valor4;
        D := D + 1;
        T := F;
    END LOOP;

    FOR F IN NVL(CO_SSFinal.FIRST,0)..NVL(CO_SSFinal.LAST,-1) LOOP
        nSwEncontro := 0;
        FOR a IN NVL(CO_SSAbonados.FIRST,0)..NVL(CO_SSAbonados.LAST,-1) LOOP
            LN_cod_servsupl           := CO_SSAbonados(a).cod_servsupl;
            LN_cod_nivel              := CO_SSAbonados(a).cod_nivel;
            LV_cod_servicio            := CO_SSAbonados(a).cod_servicio;
            IF CO_SSFinal(F).cod_servsupl = CO_SSAbonados(a).cod_servsupl THEN
               nSwEncontro := 1;
               EXIT;
            END IF;
        END LOOP;

        IF nSwEncontro = 0 THEN --'No lo encontro
            IF CO_SSFinal(F).valor4 = 'A' THEN  -- 'Activar
--            bActDesSS(sTipoAct                IN VARCHAR2,
--                   sCodServicio                IN ga_servsuplabo.cod_servicio%TYPE,
--                   sServSupl                IN ga_servsuplabo.cod_servsupl%TYPE,
--                  sCodNivel
                IF NOT bActDesSS('A', CO_SSFinal(F).cod_servicio, CO_SSFinal(F).cod_servsupl, CO_SSFinal(F).cod_nivel) THEN
                    --MsgBox "Error al Activar Servicio Suplementario"
                    --bGeneraSS_Plan = FALSE
                    --EXIT FUNCTION
                    RAISE error_fin;
                END IF;

                --sGrupo = Mid$("00" + SSFinal(F, 0), Len("00" + SSFinal(F, 0)) - 1, 2)
                sGrupo := SUBSTR('00' || CO_SSFinal(F).cod_servsupl,-2);
                --sNivel = Mid$("0000" + SSFinal(F, 1), Len("0000" + SSFinal(F, 1)) - 3, 4)
                sNivel := SUBSTR('0000' || CO_SSFinal(F).cod_nivel, -4 );
                sCadenaICC := sCadenaICC || sGrupo || sNivel;

            END IF;

        ELSE   --'lo encontro
            IF CO_SSFinal(F).valor4 = 'D' THEN   --'Desactivar

                IF NOT bActDesSS('D',CO_SSFinal(F).cod_servicio, CO_SSFinal(F).cod_servsupl, CO_SSFinal(F).cod_nivel) THEN
                    RAISE error_fin;
                ELSE
                    IF VALIDABAJAGESTOR(CO_SSFinal(F).cod_servicio, CO_SSFinal(F).cod_servsupl, CO_SSFinal(F).cod_nivel,EN_cod_producto) THEN
                         --sGrupo = Mid$("00" + SSFinal(F, 0), Len("00" + SSFinal(F, 0)) - 1, 2)
                         sGrupo := SUBSTR('00' || CO_SSFinal(F).cod_servsupl,-2);
                         sNivel := '0000';
                         sCadenaICC := sCadenaICC || sGrupo || sNivel;
                      END IF ;
                END IF;

            --  'Concatenar String para inscribir en central
            ELSIF CO_SSFinal(F).valor4 = 'A' THEN   --'Activar

                IF CO_SSFinal(F).cod_nivel <> LN_cod_nivel THEN
                    --'Tengo que desactivar el del abonado
                    --'y activar el Nuevo

                    --'Ahora Aplicamos transferencia al que se desactiva
                    --' MAM 24/10 - PROYECTO GSM
                    --bRet = bTransferencia(SSAbonados(a, 3), SSAbonados(), SSTranferencia1(), tAbonado, iCrs, T)

                    Transferencia(LV_cod_servicio, T);

                    IF NOT bActDesSS('D', LV_cod_servicio, LN_cod_servsupl, LN_cod_nivel) THEN
                       RAISE error_fin;
                    END IF;
                    IF NOT bActDesSS('A', CO_SSFinal(F).cod_servicio, CO_SSFinal(F).cod_servsupl, CO_SSFinal(F).cod_nivel) THEN
                       RAISE error_fin;
                    ELSE

                       -- 'OCB/SP-INI 29-07-2003 If VALIDACTIVAGESTOR(SSFinal(F, 3), SSFinal(F, 0), SSFinal(F, 1)) Then
                       --sGrupo = Mid$("00" + SSFinal(F, 0), Len("00" + SSFinal(F, 0)) - 1, 2)
                       sGrupo :=  SUBSTR('00' || CO_SSFinal(F).cod_servsupl,-2);
                       --sNivel = Mid$("0000" + SSFinal(F, 1), Len("0000" + SSFinal(F, 1)) - 3, 4)
                       sNivel :=  SUBSTR('0000' || CO_SSFinal(F).cod_nivel, -4 );
                       sCadenaICC := sCadenaICC || sGrupo || sNivel;
                       -- 'OCB/SP-FIN  29-07-2003 End If
                    END IF;
                    --'Cargamos los transferidos al Final
                    --FOR s = T TO 200
                    FOR s IN NVL(T,0)+1..NVL(CO_SSTranferencia.LAST,-1) LOOP
                        CO_SSFinal(D).cod_servsupl := CO_SSTranferencia(s).cod_servsupl;
                        CO_SSFinal(D).cod_nivel := CO_SSTranferencia(s).cod_nivel;
                        CO_SSFinal(D).valor4 := CO_SSTranferencia(s).valor4;
                        CO_SSFinal(D).cod_servicio := CO_SSTranferencia(s).cod_servicio;
                    END LOOP;
               --ELSE
                  --'Solo Activo el nuevo
               END IF;

            END IF;

        END IF;

    END LOOP;

    IF sCadenaICC IS NOT NULL THEN
        i := 6;

        WHILE i <= 255 LOOP
            sGrupo1 := NULL;
            sNivel1 := NULL;
            sw := 0;
            j := i - 5;
            j1 := i - 3;

            --sGrupo1 = Mid$(sCadenaICC, j, 2)
            sGrupo1 := SUBSTR(sCadenaICC, j, 2);
            --sNivel1 = Mid$(sCadenaICC, j1, 4)
            sNivel1 := SUBSTR(sCadenaICC, j1, 4);
            X := 6;

            IF sGrupo1 IS NULL THEN
               X := 256;
               i := 256;
            END IF;

            countgrup := 0;
            WHILE X <= 255 LOOP
                j := X - 5;
                j1 := X - 3;
                sGrupo2 := NULL;
                sNivel2 := NULL;
                --sGrupo2 = Mid$(sCadenaICC, j, 2)
                sGrupo2 := SUBSTR(sCadenaICC, j, 2);
                --sNivel2 = Mid$(sCadenaICC, j1, 4)
                sNivel2 := SUBSTR(sCadenaICC, j1, 4);

                IF sGrupo2 = sGrupo1 THEN
                    countgrup := countgrup + 1;
                END IF;

                IF sGrupo2 = sGrupo1 AND TO_NUMBER(sNivel2) > TO_NUMBER(sNivel1) THEN
                   sw := 1;
                   X := 256;
                END IF;

                X := X + 6;
            END LOOP;

            IF sw = 1 THEN
                sCadenaICC2 := sCadenaICC2 || sGrupo2 || sNivel2;
            ELSE
                IF countgrup = 1 THEN
                   sCadenaICC2 := sCadenaICC2 || sGrupo1 || sNivel1;
                END IF;
            END IF ;
            i := i + 6;
        END LOOP;

    END IF;

    LV_sCadenaPlan := sCadenaICC2;

END Pv_Generass_Plan_Pr;

----------------------------------------------------------------------------------------
PROCEDURE PV_cambioserie_PR(
    EN_num_celular      IN               GA_ABOCEL.num_celular%TYPE ,
    EV_num_serie_equ    IN               GA_ABOCEL.num_imei%TYPE ,
    EV_num_serie_sim    IN               GA_ABOCEL.num_serie%TYPE ,
    EN_cod_vendedor     IN               VE_VENDEDORES.cod_vendedor%TYPE ,
    EV_nom_usuario      IN               GE_SEG_USUARIO.nom_usuario%TYPE ,
    EV_cod_central      IN               GA_ABOCEL.cod_central%TYPE ,
    EN_imp_cargo        IN               GA_EQUIPABOSER.imp_cargo%TYPE ,
    EV_cod_tipcontrato  IN               GA_TIPCONTRATO.cod_tipcontrato%TYPE ,
    EV_num_contrato     IN               GA_ABOCEL.num_contrato%TYPE ,
    EV_num_anexo        IN               GA_ABOCEL.num_anexo%TYPE ,
    EV_cod_causa        IN               GA_CAUCASER.cod_caucaser%TYPE ,
    EN_numTranEquipo    IN               GA_EQUIPABOSER.NUM_MOVIMIENTO%TYPE,
    EN_numTranSimcard   IN               GA_EQUIPABOSER.NUM_MOVIMIENTO%TYPE,
    EN_cod_uso          IN               ga_equipaboser.cod_uso%TYPE,
    EN_cod_articulo     IN               ga_equipaboser.cod_articulo%TYPE,
    EV_des_equipo       IN               ga_equipaboser.des_equipo%TYPE,
    EN_carga            IN               icc_movimiento.carga%TYPE,
    EV_prcventa         IN               ga_equipaboser.PRC_VENTA%TYPE,
    EV_tipdto           IN               ga_equipaboser.TIP_DTO%TYPE,
    EV_valdto           IN               ga_equipaboser.VAL_DTO%TYPE,
    SV_ind_operacion    OUT NOCOPY       PLS_INTEGER,
    SN_cod_retorno      OUT NOCOPY       ge_errores_pg.codError,
    SV_mens_retorno     OUT NOCOPY       ge_errores_pg.MsgError,
    SN_num_evento       OUT NOCOPY       ge_errores_pg.Evento)
/*
<Documentaci¥n>
  <TipoDoc = "Procedimiento"/>
   <Elemento
      Nombre = "pv_cambioserie_pr"
      Lenguaje="PL/SQL"
      Fecha="21-11-2005"
      Versi¥n="1.0"
      Dise¿ador="Patricio Gallegos"
      Programador="Patricio Gallegos"
      Ambiente Desarrollo="BD">
      <Retorno></Retorno>
      <Descripci¥n>Consulta datos del abonado.</Descripci¥n>
      <Par¿metros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERO">Numero celular</param>
            <param nom="EV_num_serie_equ" Tipo="CARACTER">Numero serie equipo</param>
            <param nom="EV_num_serie_sim" Tipo="CARACTER">Numero serie simcard</param>
            <param nom="EN_cod_vendedor" Tipo="NUMERO">C¥digo vendedor</param>
            <param nom="EV_nom_usuario" Tipo="CARACTER">Nombre de usuario</param>
         </Entrada>
         <Salida>
            <param nom="SV_ind_operacion" Tipo="NUMERO">Indica resultado operaci¥n.</param>
            <param nom="SN_cod_retorno" Tipo="NUMERO">C¥digo retorno error</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de error</param>
            <param nom="SN_num_evento" Tipo="NUMERO">Numero de evento</param>
         </Salida>
      </Par¿metros>
   </Elemento>
</Documentaci¥n>
*/

AS

--CONSTANTES LOCALES --
--CV_num_version                    CONSTANT      ge_evento_to.version_prg%TYPE :='1.0';
CV_num_version                    CONSTANT VARCHAR2(5) :='1.0';
--Movimientos de stock --
CV_MovResVenta                            CONSTANT VARCHAR2(1):= '4';--           ' Reserva de venta
CV_MovSalDef                            CONSTANT VARCHAR2(1):= '1';--           ' Salida definitiva
CV_MovSalDefArrCom                CONSTANT VARCHAR2(1):= '2';--           '' Salida definitiva por arriendo a compra

-- FIN CONSTANTES LOCALES --

fin_ejecucion                   EXCEPTION;

--GA_TRANSACABO --
LN_num_transacabo                GA_TRANSACABO.num_transaccion%TYPE;
LN_cod_retorno                    GA_TRANSACABO.cod_retorno%TYPE;
LV_des_cadena                    GA_TRANSACABO.des_cadena%TYPE;
--FIN TRANSACABO--

--Variables para restriccion --
LV_RESULTADO                         VARCHAR2(10);
LV_MENSAJE                        VARCHAR2(255);
LV_param_restr                    VARCHAR2(100);
--Fin vriables para restriccion --

--Variables de par¿metros --
LV_TecnologiaGsm                  GED_PARAMETROS.val_parametro%TYPE;
LV_TecnologiaTdma                GED_PARAMETROS.val_parametro%TYPE;
LV_TipTermSim                    GED_PARAMETROS.val_parametro%TYPE;
LT_TipTermDig                    GED_PARAMETROS.val_parametro%TYPE;
LV_ModVenta                        GED_PARAMETROS.val_parametro%TYPE;
--LV_CausaCambio                    ged_parametros.val_parametro%TYPE; comentado
LV_CodTipContrato                GED_PARAMETROS.val_parametro%TYPE;

/*se reemplaza por EV_cod_central**************************************
LV_cod_central                    ged_parametros.val_parametro%TYPE:=NULL;
***********************************************************************/

--Fin  variables de par¿metros --

--Variables ROWTYPE---
LR_DatAbonado                    GA_ABOCEL%ROWTYPE;

/* ELIMINAR
CURSOR DatSerie IS SELECT A.num_serie, A.cod_bodega, A.tip_stock, A.cod_articulo, A.cod_uso, A.cod_estado,
                    A.ind_telefono, A.cod_producto, A.cod_central,A.cod_hlr,B.tip_terminal/*descomentar ,C.cod_tecnologia*/
/*                   ,B.des_articulo,A.num_seriemec
                   FROM al_series A,al_articulos B,al_tipos_terminales C
                     WHERE A.Cod_articulo=B.cod_articulo
                   AND A.cod_producto=B.cod_producto
                   AND B.tip_terminal=C.tip_terminal
                   AND B.cod_producto=C.cod_producto;*/

CURSOR DatSerie IS SELECT A.num_serie, a.cod_bodega, a.tip_stock, a.cod_articulo, a.cod_uso, a.cod_estado,
                    a.ind_telefono, a.cod_producto, a.cod_central,a.cod_hlr,b.tip_terminal, d.cod_tecnologia,
                   b.des_articulo,a.num_seriemec
                   FROM AL_SERIES a, AL_ARTICULOS b, AL_TIPOS_TERMINALES c, AL_TECNOARTICULO_TD d
                   WHERE c.cod_producto = b.cod_producto AND
                            c.tip_terminal = b.tip_terminal AND
                         b.cod_articulo = d.cod_articulo AND
                         b.cod_articulo = a.cod_articulo AND
                         b.cod_producto = a.cod_producto AND
                         d.ind_defecto = 1;

-- Inicio incidencia TMC 34328 - JJR; - 03/10/2006
sCadServiciosAmiAdic             VARCHAR2(255);

CURSOR leeServiciosAbo (Abonado NUMBER) IS
       --INI TMC-38662|23-03-2007|GEZ
       /*SELECT CONCAT(LPAD(COD_SERVSUPL,2,'00'),LPAD(COD_NIVEL,4,'0000')) ServicioAbonado
       FROM GA_SERVSUPLABO
       WHERE num_abonado = Abonado
       AND SYSDATE BETWEEN FEC_ALTABD AND NVL(FEC_BAJABD,SYSDATE);*/
       SELECT CONCAT(LPAD(a.cod_servsupl,2,'00'),LPAD(a.cod_nivel,4,'0000')) ServicioAbonado
       FROM   GA_SERVSUPLABO a,GA_SERVSUPL b
       WHERE  a.NUM_ABONADO = Abonado
       AND    SYSDATE BETWEEN a.fec_altabd AND NVL(a.fec_bajabd,SYSDATE)
       AND    b.cod_servicio=a.cod_servicio
       AND      b.cod_producto=a.cod_producto
       AND      b.ind_central=1;
       --FIN TMC-38662|23-03-2007|GEZ

-- Fin incidencia TMC 34328 - JJR; - 03/10/2006

LR_DatSerieEqu                    DatSerie%ROWTYPE;
LR_DatSerieSim                    DatSerie%ROWTYPE;
LR_DatSerieAct                    DatSerie%ROWTYPE;
LR_venta                        GA_VENTAS%ROWTYPE;
--FIN Variables ROWTYPE---

--LV_des_error                     ge_evento_detalle_to.descripcion_error%TYPE;
LV_des_error                    ge_errores_pg.DesEvent;
LV_tabla_abo                    VARCHAR2(14);
LV_TecDestino                    AL_TECNOLOGIA.cod_tecnologia%TYPE;
SN_formato                      NUMBER;
LV_procedencia                    VARCHAR2(1);
LV_CodOperadora                    GE_CLIENTES.cod_operadora%TYPE;
LV_IndPropiedad                    GA_EQUIPABOSER.ind_propiedad%TYPE;
LV_IndCuotas                    GE_MODVENTA.ind_cuotas%TYPE;
LD_fecha                        DATE;
LT_IndComodato                     GA_TIPCONTRATO.ind_comodato%TYPE;
LT_IndEqprestado                GA_EQUIPABOSER.ind_eqprestado%TYPE;
LV_SerieHex                        GA_ABOCEL.num_seriehex%TYPE;
LV_cod_planserv                    GA_ABOCEL.cod_planserv%TYPE:=NULL;
LV_IndVtaExterna                 VE_TIPCOMIS.ind_vta_externa%TYPE;
LV_CadServicios                     ICC_MOVIMIENTO.cod_servicios%TYPE;
LV_TecInicial                    AL_TECNOLOGIA.cod_tecnologia%TYPE;

LV_CodActabo                    GA_ACTABO.cod_actabo%TYPE:='CE';
LV_CodActaboSS                    GA_ACTABO.cod_actabo%TYPE:='SS';
LV_CodPvActabo                     GA_ACTABO.cod_actabo%TYPE;

LN_CodActCen                      GA_ACTABO.cod_actcen%TYPE;
LT_NumMin                        GA_CELNUM_SUBALM.num_min%TYPE;
LT_TipTermNue                    AL_TIPOS_TERMINALES.tip_terminal%TYPE;

LT_imsi_nue                        ICC_MOVIMIENTO.imsi_nue%TYPE;
LT_imei_nue                        ICC_MOVIMIENTO.imei_nue%TYPE;
LT_icc_nue                        ICC_MOVIMIENTO.icc_nue%TYPE;
LT_imsi                            ICC_MOVIMIENTO.imsi%TYPE;
LT_imei                            ICC_MOVIMIENTO.imei%TYPE;
LT_icc                            ICC_MOVIMIENTO.icc%TYPE;
LV_comando                        VARCHAR2(10);

LV_sCadenaICCSS                    ICC_MOVIMIENTO.cod_servicios%TYPE;

    --INI 44720-TMC|08-10-2007|EFR.
    vCentralGSMIsr        GED_PARAMETROS.VAL_PARAMETRO%TYPE;
    vCentralTDMAIsr    GED_PARAMETROS.VAL_PARAMETRO%TYPE;
    vCentralesISR        GED_PARAMETROS.VAL_PARAMETRO%TYPE;
    vCod_Central_Nue   ICC_MOVIMIENTO.COD_CENTRAL%TYPE;
    vCentralGSMSCL        GED_PARAMETROS.VAL_PARAMETRO%TYPE;
    vCentralTDMASCL    GED_PARAMETROS.VAL_PARAMETRO%TYPE;
    --FIN 44720-TMC|08-10-2007|EFR.

    LV_GrupoTecnoAbonado VARCHAR2(7);
    LV_cadena_descom     arreglo;
    LV_movi_equipaboser     VARCHAR2(250);
    LN_num_meses         NUMBER;

    --INI.PAGC 06-05-2008
    LV_GrupoTecAbo        GED_PARAMETROS.val_parametro%TYPE;
    LV_GrupoTecGSM        GED_PARAMETROS.val_parametro%TYPE;
    LV_GrupoTecDMA        GED_PARAMETROS.val_parametro%TYPE;
    LV_GrupoTecNue        GED_PARAMETROS.val_parametro%TYPE;
    LV_TipPlanHib        GED_PARAMETROS.val_parametro%TYPE;
    LV_TipPlanPre        GED_PARAMETROS.val_parametro%TYPE;
    LN_cod_tiplan        TA_PLANTARIF.cod_tiplan%TYPE;
    LV_tip_plantarif    TA_PLANTARIF.tip_plantarif%TYPE;
    LV_cod_plantarif    TA_PLANTARIF.cod_plantarif%TYPE := NULL;
    LV_cod_cargobasico    TA_PLANTARIF.cod_cargobasico%TYPE:=NULL;
    LV_camtec_camplan    GED_PARAMETROS.val_parametro%TYPE;
    LV_plan                ICC_MOVIMIENTO.PLAN%TYPE := NULL;
    LN_carga            ICC_MOVIMIENTO.CARGA%TYPE := NULL;
    LV_NomParamAplImpto    VARCHAR2(100) := NULL;
    LV_AplicaImpto        VARCHAR2(100) := NULL;
    LN_Impto            NUMBER := NULL;
    --FIN

    --INI COL-71848|10-11-2008|GEZ
    LV_CadenaSS            ICC_MOVIMIENTO.cod_servicios%TYPE;

    LV_Estado            VARCHAR2(100);
    LV_Proc                VARCHAR2(100);
    LV_Tabla            VARCHAR2(100);
    LV_Act                VARCHAR2(100);
    LV_Code                VARCHAR2(100);
    LV_Precio_Venta     al_precios_venta.PRC_VENTA%TYPE;
    --FIN COL-71848|10-11-2008|GEZ

   -- v1.0  COL|71848|04-12-2008|SAQL

   ------ INICIO 148477 RAN 18-11-2010
   LN_CANT_RENOVA   pls_integer;
   ------ FIN 148477 RAN 18-11-2010


   D_fec_alta_aboser date; -- RRG COL 07-03-2009 78269
   D_AboserMasMeses  date; -- RRG COL 07-03-2009 78269

   LN_NUM_VENTA     GA_VENTAS.NUM_VENTA%TYPE;   --157095


BEGIN
     --Para que todas las fechas tengan el formato 'DD/MM/YYYY HH24:MI:SS'
      EXECUTE IMMEDIATE 'alter session set nls_date_format = ''DD/MM/YYYY HH24:MI:SS''';

      SV_ind_operacion := 1;


      --******* Validaci¥n de estado vendedor *************
      LV_des_error:='Excepci¥n en llamado pl p_ga_estado_vendedor';

      SELECT ga_seq_transacabo.NEXTVAL
      INTO LN_num_transacabo FROM Dual;

      P_Ga_Estado_Vendedor(LN_num_transacabo,EN_cod_vendedor);

      SELECT cod_retorno,des_cadena
      INTO LN_cod_retorno,LV_des_cadena
      FROM GA_TRANSACABO
      WHERE num_transaccion = LN_num_transacabo;

      IF LN_cod_retorno=0 THEN
           IF LV_des_cadena LIKE '/1/%' THEN--Vendedor Bloqueado
                SN_cod_retorno := 562;
                RAISE fin_ejecucion;
         END IF;
      ELSIF LN_cod_retorno=1 THEN--Vendedor no existe
           SN_cod_retorno := 300101;
         RAISE fin_ejecucion;
      ELSE
            SN_cod_retorno := 302;--Otro error
            --Otro Error
            RAISE fin_ejecucion;
      END IF;
      --******* Fin validaci¥n de estado vendedor *************

      --********Obtener datos del abonado ************
      LV_des_error:='Excepci¥n llamado pl pv_datos_abonado_pr';

      Pv_Consultas_Ofvirtual_Pg.PV_datos_abonado_PR(EN_num_celular,LR_DatAbonado,LV_tabla_abo,SN_cod_retorno);

      IF SN_cod_retorno<>0 THEN
           RAISE fin_ejecucion;
      END IF;

        LV_des_error:='Excepci¥n llamado pl PV_obtiene_grupo_tecnologia_FN';

      Pv_Actcambios_Ofvirtual_Pg.PV_obtiene_grupo_tecnologia_FN(LR_DatAbonado.cod_tecnologia, LV_GrupoTecnoAbonado, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

      LR_DatAbonado.cod_tecnologia:=LV_GrupoTecnoAbonado;

      LV_GrupoTecAbo := LV_GrupoTecnoAbonado;--PAGC 06-05-2006

      LV_GrupoTecnoAbonado:=NULL;

      IF SN_cod_retorno<>0 THEN
           RAISE fin_ejecucion;
      END IF;

      --********Fin obtener datos del abonado ************

      --********* Obtener par¿metros y datos**********************
      LV_des_error:='Excepci¥n llamado pls PV_PR_DEVVALPARAM';

      Pv_Pr_Devvalparam(CV_cod_modulo_gral, LR_DatAbonado.cod_producto,'TECNOLOGIA_GSM',LV_TecnologiaGsm);

      Pv_Pr_Devvalparam(CV_cod_modulo_gral, LR_DatAbonado.cod_producto,'TECNOLOGIA_TDMA',LV_TecnologiaTdma);

      --INI.PAGC 06-05-2008 Obtenci¥n de par¿metros para grupo tecnol¥gico..
      Pv_Pr_Devvalparam(CV_cod_modulo_gral, LR_DatAbonado.cod_producto,'GRUPO_TEC_GSM',LV_GrupoTecGSM);
      Pv_Pr_Devvalparam(CV_cod_modulo_gral, LR_DatAbonado.cod_producto,'GRUPO_TEC_DMA',LV_GrupoTecDMA);
      --FIN..

      --INI.PAGC 06-05-2008 Obtenci¥n de par¿metros para cambio de plan.
      Pv_Pr_Devvalparam(CV_cod_modulo_gral, LR_DatAbonado.cod_producto,'TIP_PLAN_PREPAGO',LV_TipPlanPre);
      Pv_Pr_Devvalparam(CV_cod_modulo_gral, LR_DatAbonado.cod_producto,'TIP_PLAN_HIBRIDO',LV_TipPlanHib);
      Pv_Pr_Devvalparam(CV_cod_modulo_gral, LR_DatAbonado.cod_producto,'CAMTEC_CAMPLAN',LV_camtec_camplan);
      --FIN..

      Pv_Pr_Devvalparam('AL', LR_DatAbonado.cod_producto,'COD_SIMCARD_GSM',LV_TipTermSim);

      Pv_Pr_Devvalparam(CV_cod_modulo_gral, LR_DatAbonado.cod_producto,'COD_MODCONTADO',LV_ModVenta);

      Pv_Pr_Devvalparam(CV_cod_modulo_gral, LR_DatAbonado.cod_producto,'TIP_DIGITAL', LT_TipTermDig);

      BEGIN
             LV_des_error:='Excepci¥n llamado pl FN_OBTIENE_OPERCLIENTE';
             LV_CodOperadora :=  Fn_Obtiene_Opercliente(LR_DatAbonado.cod_cliente);
      EXCEPTION
                 WHEN OTHERS THEN
               SN_cod_retorno:= 274;
               RAISE fin_ejecucion;
      END;
      --********* Fin obtener par¿metros *******************

      --******** Validar situaci¥n del abonado *************
      LV_des_error:='Excepci¥n llamado pl pv_prc_val_situacion';

      Pv_Prc_Val_Situacion ('||||' || LV_CodActabo || '|' || LR_DatAbonado.NUM_ABONADO || '|',LV_RESULTADO,LV_MENSAJE);

      IF NOT LV_RESULTADO='TRUE' THEN
           SN_cod_retorno:=323;--Por definir
         LV_des_error:= LV_des_error || LV_MENSAJE;
         RAISE fin_ejecucion;
      END IF;
      --******** Fin validar situaci¥n del abonado *************

      --Validar formato del equipo---
      LV_des_error:='Excepci¥n llamado pl pv_val_form_serie_equipo_pr';

      Pv_Consultas_Ofvirtual_Pg.PV_val_form_serie_equipo_PR (EV_num_serie_equ,SN_formato,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

      IF NOT SN_formato=0 THEN
           RAISE fin_ejecucion;
      END IF;

      --Validar formato de la simcard---
      --IF EV_num_serie_sim IS NOT NULL AND LENGTH(EV_num_serie_sim)>0 THEN
      IF TRIM(EV_num_serie_sim) IS NOT NULL THEN

          LV_des_error:='Excepci¥n llamado pl pv_val_form_serie_simcard_pr';

          Pv_Consultas_Ofvirtual_Pg.PV_val_form_serie_simcard_PR (EV_num_serie_sim,SN_formato,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

          IF NOT SN_formato=0 THEN
               RAISE fin_ejecucion;
          END IF;

          -- Viene serie simcard por lo tanto debe realizarse cambio de tecnolog¿a TDMA -GSM y
          -- se debe validar que el abonado posea tecnologia TDMA

            LV_TecDestino := LV_TecnologiaGsm;

          BEGIN--Obtenci¥n y validaci¥n de los datos de la simcard

                SELECT a.num_serie, a.cod_bodega, a.tip_stock, a.cod_articulo, a.cod_uso,
                       1/*representa cod_estado*/, a.ind_telefono, a.cod_producto, NVL(A.cod_central, LR_DatAbonado.cod_central),
                       a.cod_hlr, b.tip_terminal, d.cod_tecnologia, b.des_articulo, a.num_seriemec
                INTO LR_DatSerieSim
                FROM AL_SERIES a, AL_ARTICULOS b, AL_TIPOS_TERMINALES c, AL_TECNOARTICULO_TD d
                WHERE c.cod_producto = b.cod_producto AND
                      c.tip_terminal = b.tip_terminal AND
                      c.tip_terminal = LV_TipTermSim AND
                      b.cod_articulo = d.cod_articulo AND
                      b.cod_articulo = a.cod_articulo AND
                      b.cod_producto = a.cod_producto AND
                      d.ind_defecto = 1 AND
                      a.num_serie = EV_num_serie_sim AND
                      a.cod_producto = LR_DatAbonado.cod_producto;

                 --Validar el articulo en las bodegas asignadas al vendedor
                 LV_des_error:='Excepci¥n validaci¥n bodega de la simcard';

                 Pv_Consultas_Ofvirtual_Pg.PV_bodega_vendedor_PR(EN_cod_vendedor,LR_DatSerieSim.cod_bodega,LV_CodOperadora,SN_cod_retorno);

                 IF NOT SN_cod_retorno=0 THEN
                     RAISE fin_ejecucion;
                 END IF;

                 /*-- Reserva la serie  simcard--
                 LV_des_error:='Excepci¥n reserva venta de la simcard';

                 Pv_Actcambios_Ofvirtual_Pg.PV_interal_PR(CV_MovResVenta,LR_DatSerieSim.tip_stock,LR_DatSerieSim.cod_bodega,LR_DatSerieSim.cod_articulo,LR_DatSerieSim.cod_uso,LR_DatSerieSim.cod_estado,NULL,1,EV_num_serie_sim,0,LN_cod_retorno,LV_des_cadena);

                 IF NOT LN_cod_retorno=0 THEN
                     SN_cod_retorno := 300116;
                    LV_des_error   := LV_des_cadena;
                     RAISE fin_ejecucion;
                 END IF;*/

                 --INI 44720-TMC|08-10-2007|EFR.
                 --RESCATO LOS VALORES DE CENTRAL ISR.
                 SELECT Ge_Fn_Devvalparam('GA', 1, 'CENTRALES_ISR') INTO vCentralesISR FROM DUAL;
                 SELECT Ge_Fn_Devvalparam('GA', 1, 'CENTRAL_GSM_ISR') INTO vCentralGSMIsr FROM DUAL;
                 SELECT Ge_Fn_Devvalparam('GA', 1, 'CENTRAL_TDMA_ISR') INTO vCentralTDMAIsr FROM DUAL;

                 --scl.
                 /********** Se cambia por EV_cod_central***********************************************
                 select GE_FN_DEVVALPARAM('GA', 1, 'CENTRAL_GSM_CAMBTEC') INTO vCentralGSMSCL FROM DUAL;
                 ***************************************************************************************/

                 SELECT Ge_Fn_Devvalparam('GA', 1, 'CENTRAL_TDMA_CAMBTEC') INTO vCentralTDMASCL FROM DUAL;

                 --comparo para asignar nueva central.
                 IF INSTR(vCentralesISR, LR_DatSerieSim.cod_central) > 0 THEN --ISR.
                     IF LV_TecDestino = LV_TecnologiaTdma THEN
                           vCod_Central_Nue := vCentralTDMAIsr;
                     ELSE
                           vCod_Central_Nue := vCentralGSMIsr;
                     END IF;
                 ELSE -- SCL.
                     IF LV_TecDestino = LV_TecnologiaTdma THEN
                           vCod_Central_Nue := vCentralTDMASCL;
                     ELSE
                           vCod_Central_Nue := EV_cod_central;
                     END IF;
                 END IF;
                 --FIN 44720-TMC|08-10-2007|EFR.

          EXCEPTION
                     WHEN NO_DATA_FOUND THEN
                       SN_cod_retorno := 107;
                         LV_des_error := 'La serie simcard: ' || EV_num_serie_sim || ' no existe en SCL.';
                    RAISE fin_ejecucion;
          END;

      ELSE--No existe cambio de tecnolog¿a (TDMA-TDMA o GSM a GSM) ---
            LR_DatSerieSim.num_serie := NULL;
            LV_TecDestino := LR_DatAbonado.cod_tecnologia;
      END IF;

      --INI.PAGC 06-05-2008 obtener grupo tecnologico destino
      LV_GrupoTecNue := Ga_Aprovisionar_Central_Pg.PV_GRUPO_TECNOLOGICO_FN(LV_TecDestino);

      --Determinar procedencia del equipo destino: Interna o Externa
      BEGIN--Obtenci¥n y validaci¥n de los datos del equipo --

            SELECT a.num_serie, a.cod_bodega, a.tip_stock, a.cod_articulo, a.cod_uso,
                   1/*representa cod_estado*/, a.ind_telefono, a.cod_producto, a.cod_central, a.cod_hlr,
                   b.tip_terminal, d.cod_tecnologia, b.des_articulo, a.num_seriemec
            INTO LR_DatSerieEqu
            FROM AL_SERIES a, AL_ARTICULOS b, AL_TIPOS_TERMINALES c, AL_TECNOARTICULO_TD d
            WHERE c.cod_producto = b.cod_producto AND
                  c.tip_terminal = b.tip_terminal AND
                  NOT c.tip_terminal = LV_TipTermSim AND
                  b.cod_articulo = d.cod_articulo AND
                  b.cod_articulo = a.cod_articulo AND
                  b.cod_producto = a.cod_producto AND
                  d.ind_defecto = 1 AND
                  a.num_serie = EV_num_serie_equ AND
                  a.cod_producto = LR_DatAbonado.cod_producto;


             LV_procedencia:='I';

             /* Error por Cambio de tecnolog¿a GSM a TDMA  */
             IF LR_DatAbonado.cod_tecnologia=LV_TecnologiaGsm AND LR_DatSerieEqu.cod_tecnologia = LV_TecnologiaTdma THEN
                   SN_cod_retorno := 563;
                   LV_des_error := 'Cambio de tecnolog¿a GSM a TDMA no permitido.';
                   RAISE fin_ejecucion;
             END IF;

             --Validar la tecnolog¿a del terminal, ya que, debe coincidir con la tecnolog¿a destino
             IF NOT LV_TecDestino = LR_DatSerieEqu.cod_tecnologia THEN
                   SN_cod_retorno:=565;
                   LV_des_error := 'La tecnolog¿a del equipo (' || LR_DatSerieEqu.cod_tecnologia ||  ')no coincide con la tecnolog¿a destino (' || LV_TecDestino ||')del abonado.';
                   RAISE fin_ejecucion;
             END IF;

             --Validar el articulo en las bodegas asignadas al vendedor
             LV_des_error:='Excepci¥n validaci¥n bodega del equipo';
               Pv_Consultas_Ofvirtual_Pg.PV_bodega_vendedor_PR(EN_cod_vendedor,LR_DatSerieEqu.cod_bodega,LV_CodOperadora,SN_cod_retorno);

             IF NOT SN_cod_retorno=0 THEN
                 RAISE fin_ejecucion;
             END IF;

             /*-- Reserva la serie equipo--
             LV_des_error:='Excepci¥n reserva venta del equipo';
             Pv_Actcambios_Ofvirtual_Pg.PV_interal_PR(CV_MovResVenta,LR_DatSerieEqu.tip_stock,LR_DatSerieEqu.cod_bodega,LR_DatSerieEqu.cod_articulo,LR_DatSerieEqu.cod_uso,LR_DatSerieEqu.cod_estado,NULL,1,EV_num_serie_equ,0,LN_cod_retorno,LV_des_cadena);

             IF NOT LN_cod_retorno=0 THEN
                 SN_cod_retorno := 300116;
                LV_des_error   := LV_des_cadena;
                 RAISE fin_ejecucion;
             ELSE
                    Pv_Actcambios_Ofvirtual_Pg.PV_desc_cadena_transacabo_FN(LV_des_cadena, LV_cadena_descom, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
                LV_movi_equipaboser:=LV_cadena_descom(1);
             END IF;*/

      EXCEPTION
                 WHEN NO_DATA_FOUND THEN

                    LV_procedencia:='E';
                    LR_DatSerieEqu.num_serie := EV_num_serie_equ;
                    --INI.PAGC 02-06-2008
                    LR_DatSerieEqu.cod_uso := EN_cod_uso;
                    LR_DatSerieEqu.cod_articulo := EN_cod_articulo;
                    LR_DatSerieEqu.des_articulo := EV_des_equipo;
                    --FIN.

                    --Validaci¥n de serie en lista negra o repetici¥n --
                    LV_des_error:='Excepci¥n validaci¥n de series.';

                    IF LV_TecDestino=LV_TecnologiaGsm THEN

                       --Tipo terminal nuevo
                        Pv_Pr_Devvalparam('AL', LR_DatAbonado.cod_producto,'COD_TERMINAL_GSM',LR_DatSerieEqu.tip_terminal);

                        --Por mientras despues llevar a pl --
                        BEGIN--Valida repeticion --

                            IF LV_tabla_abo = 'GA_ABOCEL' THEN
                                SELECT num_imei INTO LR_DatSerieEqu.num_serie
                                FROM GA_ABOCEL WHERE num_imei = EV_num_serie_equ
                                AND cod_situacion NOT IN ('BAA','BAP');
                            ELSE
                                SELECT num_imei INTO LR_DatSerieEqu.num_serie
                                FROM GA_ABOAMIST WHERE num_imei = EV_num_serie_equ
                                AND cod_situacion NOT IN ('BAA','BAP');
                            END IF;

                            LN_cod_retorno:=2;--Indica que serie ya existe.

                        EXCEPTION
                            WHEN NO_DATA_FOUND THEN
                                 LN_cod_retorno:=0;
                            WHEN OTHERS THEN
                                 LN_cod_retorno:=4;
                        END;

                        --Valida lista negra --
                        BEGIN
                             SELECT num_serie INTO LR_DatSerieEqu.num_serie
                             FROM GA_LNCELU
                             WHERE num_serie = LR_DatSerieEqu.num_serie;
                             LN_cod_retorno:=3;--Indica que serie est¿ en lista negra
                        EXCEPTION
                            WHEN NO_DATA_FOUND THEN
                                 LN_cod_retorno:=0;
                            WHEN OTHERS THEN
                                 LN_cod_retorno:=4;
                        END;

                    ELSIF LV_TecDestino=LV_TecnologiaTdma THEN

                          --TipoTerminal nuevo, por default digital
                          LR_DatSerieEqu.tip_terminal := LT_TipTermDig;

                          SELECT ga_seq_transacabo.NEXTVAL
                          INTO LN_num_transacabo FROM Dual;

                          P_Valida_Serie(LN_num_transacabo,EV_num_serie_equ);

                          SELECT cod_retorno,des_cadena INTO LN_cod_retorno,LV_des_cadena
                          FROM GA_TRANSACABO WHERE num_transaccion=LN_num_transacabo;

                    ELSE
                        RAISE fin_ejecucion;
                    END IF;

                    IF NOT LN_cod_retorno=0 THEN

                       SELECT  DECODE(LN_cod_retorno,
                                                      1,300121,    --formato incorrecto
                                                2,566,        --serie repetida
                                                3,567,        --serie en lista negra
                                                  302)        --Otro error
                       INTO SN_cod_retorno FROM DUAL;

                       RAISE fin_ejecucion;

                    END IF;
      END;

      ---*********** INGRESAR REGISTRO EN LA TABLA GA_MODABOCEL y GA_EQUIPABOSER ******************+
      SELECT ind_cuotas
      INTO LV_IndCuotas
      FROM GE_MODVENTA
      WHERE cod_modventa = LV_ModVenta;

      LD_fecha := SYSDATE;

      --es comodato o arriendo se debe cambiar el tipo de
      --contrato configurado en un parametro ---------------

      IF LV_tabla_abo = 'GA_ABOCEL' THEN --TMC-38662|23-03-2007|GEZ

          SELECT a.ind_comodato INTO LT_IndComodato
          FROM GA_TIPCONTRATO a
          WHERE a.cod_producto = LR_DatAbonado.cod_producto
          AND a.cod_tipcontrato = EV_cod_tipcontrato;

      END IF; --TMC-38662|23-03-2007|GEZ

      IF NVL(LV_IndCuotas,0) = 0 THEN
             LV_IndPropiedad := 'C';
      ELSIF LV_IndCuotas IN (1,2,-1) THEN
              LV_IndPropiedad := 'E';
      END IF;

      IF LV_procedencia='I' THEN

         --PV_PR_DEVVALPARAM(CV_cod_modulo_gral, LR_DatAbonado.cod_producto,'CAUSA_CSERIEI',LV_CausaCambio); comentado
         LT_IndEqprestado := NVL(LT_IndComodato,0);

      ELSIF LV_procedencia='E' THEN

         --PV_PR_DEVVALPARAM(CV_cod_modulo_gral, LR_DatAbonado.cod_producto,'CAUSA_CSERIEE',LV_CausaCambio); comentado
         LT_IndEqprestado := 2;

      END IF;

    --INI.PAGC 06-05-2008
    --Validaci¥n cambio de tecnologia con cambio de plan...
    IF LV_GrupoTecAbo = LV_GrupoTecDMA  AND LV_GrupoTecNue = LV_GrupoTecGSM  AND LV_camtec_camplan = 'TRUE' THEN

        LV_des_error := 'Error al obtener plan destino para cambio de tecnologia.';

        SELECT cod_tiplan,tip_plantarif
        INTO LN_cod_tiplan,LV_tip_plantarif
        FROM TA_PLANTARIF
        WHERE cod_producto = LR_DatAbonado.cod_producto
        AND cod_plantarif =  LR_DatAbonado.cod_plantarif;

        IF LV_tip_plantarif <> 'E' AND
            (LN_cod_tiplan = TO_NUMBER(LV_TipPlanHib) OR LN_cod_tiplan = TO_NUMBER(LV_TipPlanPre)) THEN

            SELECT cod_plantarif_des INTO LV_cod_plantarif
            FROM   PV_CAMBTECNO_PLAN_TD
            WHERE  cod_tecnologia_ori = LR_DatAbonado.cod_tecnologia
            AND    cod_plantarif_ori = LR_DatAbonado.cod_plantarif
            AND    cod_tecnologia_des = LV_TecDestino
            AND    cod_producto = LR_DatAbonado.cod_producto;

            SELECT cod_cargobasico INTO LV_cod_cargobasico
            FROM TA_PLANTARIF
            WHERE cod_producto = LR_DatAbonado.cod_producto
            AND cod_plantarif =  LV_cod_plantarif;

            --Para colocar valor en el campo ICC_MOVIMIENTO.PLAN en caso de abonado prepago
            IF (LN_cod_tiplan = TO_NUMBER(LV_TipPlanPre)) OR (LN_cod_tiplan = TO_NUMBER(LV_TipPlanHib)) THEN
              LV_plan := LV_cod_plantarif;
              LN_carga := EN_carga;

              IF (LV_GrupoTecAbo = LV_GrupoTecGSM) THEN
                   LV_NomParamAplImpto :='APLICAIMPTO_GSM';
              END IF;
              IF (LV_GrupoTecAbo = LV_GrupoTecDMA) THEN
                   LV_NomParamAplImpto :='APLICAIMPTO_TDMA';
              END IF;

              Pv_Pr_Devvalparam('GA',LR_DatAbonado.cod_producto,LV_NomParamAplImpto,LV_AplicaImpto);

              IF LV_AplicaImpto = '1' THEN
                   SELECT Pv_Mtonbporc_Fn (NULL, NULL, NULL, NULL, LR_DatAbonado.num_abonado)
                 INTO LN_Impto
                 FROM dual;

                 IF LN_Impto > 0 THEN
                     LN_carga := ROUND(LN_carga * ((LN_Impto/100) +1));
                 END IF;
              END IF;

              IF LV_AplicaImpto = '0' THEN
                   LN_Impto := 0;
                 LN_carga := ROUND(LN_carga * ((LN_Impto/100) +1));
              END IF;
            END IF;
        END IF;
    END IF;
    --FIN---

    /*****Obtiene el nÀmero de meses del contrato actual para insertarlo en la ga_modabocel****/
    SELECT num_meses
    INTO LN_num_meses
    FROM GA_PERCONTRATO
    WHERE cod_tipcontrato = EV_cod_tipcontrato AND
            cod_producto = 1;

      LV_des_error:='Excepci¥n inserci¥n tabla ga_modabocel';

      INSERT INTO GA_MODABOCEL
      (NUM_ABONADO, cod_tipmodi, fec_modifica, nom_usuarora,
      tip_terminal,
      num_serie,
      num_seriehex,
      cod_causa, cod_tecnologia,
      ind_eqprestado,
      cod_tipcontrato,
      cod_planserv,
      num_imei,
      cod_central,
      --INI.PAGC 14-05-2008. Cambio de tecnologia con cambio de plan
      --num_meses)
      num_meses,cod_plantarif, cod_cargobasico)
      --FIN
      VALUES(
      LR_DatAbonado.NUM_ABONADO,LV_CodActabo,SYSDATE,EV_nom_usuario,
      LR_DatAbonado.tip_terminal,
      --DECODE(LR_DatAbonado.cod_tecnologia,LV_TecnologiaTdma,LR_DatAbonado.num_serie,NULL), -- TMC|36755|17/04/2007|SAQL
      DECODE(LR_DatAbonado.cod_tecnologia,LV_TecnologiaGsm,NULL,LR_DatAbonado.num_serie),
      DECODE(LR_DatAbonado.cod_tecnologia,LV_TecnologiaTdma,LR_DatAbonado.num_seriehex,NULL),
      --LV_CausaCambio, comentado
      EV_cod_causa,
      DECODE(LV_TecDestino,LR_DatAbonado.cod_tecnologia,NULL,LR_DatAbonado.cod_tecnologia),
      --DECODE(nvl(LR_DatAbonado.ind_eqprestado,0),LT_IndEqprestado,Null,LR_DatAbonado.ind_eqprestado), comentado
      DECODE(NVL(LR_DatAbonado.ind_eqprestado,0),LT_IndEqprestado,LR_DatAbonado.ind_eqprestado, LT_IndEqprestado),
      --DECODE(LV_CodTipContrato,LR_DatAbonado.cod_tipcontrato,Null,LR_DatAbonado.cod_tipcontrato), comentado
      LR_DatAbonado.cod_tipcontrato,
      DECODE(LV_TecDestino,LR_DatAbonado.cod_tecnologia,NULL,LR_DatAbonado.cod_planserv),
      DECODE(LR_DatAbonado.cod_tecnologia,LV_TecnologiaGsm,LR_DatAbonado.num_imei,NULL),
      DECODE(LV_TecDestino,LR_DatAbonado.cod_tecnologia,NULL,LR_DatAbonado.cod_central),
      --INI.PAGC 14-05-2008. Cambio de tecnologia con cambio de plan
      --0);
      LN_num_meses,
      NVL2(LV_cod_plantarif,LR_DatAbonado.cod_plantarif,NULL),
      NVL2(LV_cod_cargobasico,LR_DatAbonado.cod_cargobasico,NULL));
      --FIN

      /*SELECT des_cadena
      INTO LV_des_cadena
      FROM ga_transacabo
      WHERE num_transaccion = EN_numTranEquipo;

      Pv_Actcambios_Ofvirtual_Pg.PV_desc_cadena_transacabo_FN(LV_des_cadena, LV_cadena_descom, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
      LV_movi_equipaboser:=LV_cadena_descom(1);*/

      LV_des_error:='Excepci¥n ingreso ga_equipaboser de equipo';

      Pv_Actcambios_Ofvirtual_Pg.PV_ins_equipaboser_PR(LR_DatAbonado.NUM_ABONADO,EV_num_serie_equ,LR_DatAbonado.cod_producto,LV_procedencia,LD_fecha,LV_IndPropiedad,
      LR_DatSerieEqu.cod_bodega,LR_DatSerieEqu.tip_stock,LR_DatSerieEqu.cod_articulo,'E',LV_ModVenta,LR_DatSerieEqu.tip_terminal,LR_DatSerieEqu.cod_uso,
      NULL,LR_DatSerieEqu.cod_estado,NULL,NULL,NULL,NULL,NULL,
      LR_DatSerieEqu.num_seriemec,LR_DatSerieEqu.des_articulo,NULL,EN_numTranEquipo,
      --LV_CausaCambio, comentado
      EV_cod_causa,
      LT_IndEqprestado,NULL,
      NULL,NULL,LV_TecDestino,EN_imp_cargo,EV_prcVenta,EV_tipdto,EV_valdto,SN_cod_retorno,LV_des_error );

      IF NOT SN_cod_retorno = 0 THEN
           RAISE fin_ejecucion;
      END IF;

      DBMS_OUTPUT.PUT_LINE('LR_DatAbonado.cod_tecnologia:=' || LR_DatAbonado.cod_tecnologia);
      DBMS_OUTPUT.PUT_LINE('LV_TecDestino:=' || LV_TecDestino);

      --Insertar la simcard ---------
      IF NOT LR_DatAbonado.cod_tecnologia = LV_TecDestino  THEN

           /*SELECT des_cadena
           INTO LV_des_cadena
           FROM ga_transacabo
           WHERE num_transaccion = EN_numTranSimcard;

           Pv_Actcambios_Ofvirtual_Pg.PV_desc_cadena_transacabo_FN(LV_des_cadena, LV_cadena_descom, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
           LV_movi_equipaboser:=LV_cadena_descom(1);*/

              LV_des_error:='Excepci¥n ingreso ga_equipaboser de simcard.';

         -----------------SE AGREGA CAMPO PRC_VENTA EN GA_EQUIPABOSER 150909----INI-------------
         --PV_ACTCAMBIOS_OFVIRTUAL_PG.PV_RECPRECIOVENTA_PR ( EV_num_serie_equ, LR_DatAbonado.NUM_ABONADO,
         --LV_ModVenta, LV_Precio_Venta, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO );
         -----------------SE AGREGA CAMPO PRC_VENTA EN GA_EQUIPABOSER 150909----FIN-------------

         Pv_Actcambios_Ofvirtual_Pg.PV_ins_equipaboser_PR(LR_DatAbonado.NUM_ABONADO,EV_num_serie_sim,LR_DatAbonado.cod_producto,'I',LD_fecha,LV_IndPropiedad,
         LR_DatSerieSim.cod_bodega,LR_DatSerieSim.tip_stock,LR_DatSerieSim.cod_articulo,'E',LV_ModVenta,LR_DatSerieSim.tip_terminal,LR_DatSerieSim.cod_uso,
         NULL,LR_DatSerieSim.cod_estado,NULL,NULL,NULL,NULL,NULL,
         LR_DatSerieSim.num_seriemec,LR_DatSerieSim.des_articulo,NULL,EN_numTranSimcard,
         --LV_CausaCambio, comentado
         EV_cod_causa,
         LT_IndEqprestado,LR_DatSerieEqu.num_serie,
         NULL,NULL,LV_TecDestino,NULL,EV_prcventa,EV_tipdto,EV_valdto,SN_cod_retorno,LV_des_error );

         IF NOT SN_cod_retorno=0 THEN
                RAISE fin_ejecucion;
         END IF;

          BEGIN
              SELECT cod_planserv
             INTO LV_cod_planserv
             FROM GA_PLANTECPLSERV
             WHERE cod_producto = LR_DatAbonado.cod_producto
             --INI.PAGC 14-05-2008
             --En caso de existir cambio de tecnologia con cambio de plan utilizaremos la variable LV_cod_plantarif
             --para obtener el plan de servicios correspondiente al nuevo plan.
             --AND   cod_plantarif = LR_DatAbonado.cod_plantarif
             AND   cod_plantarif = NVL(LV_cod_plantarif,LR_DatAbonado.cod_plantarif)
             --FIN
             AND   cod_tecnologia = LV_TecDestino
             AND   SYSDATE BETWEEN fec_desde AND NVL(fec_hasta,SYSDATE);
          EXCEPTION
              WHEN NO_DATA_FOUND THEN
                 SN_cod_retorno := 568;
                  RAISE fin_ejecucion;
          END;

         /*************se reemplaza por el par¿metro ingresado EV_cod_central para la consulta LV_cod_central
         y la que obtiene vCod_Central_Nue *********************************************************************
          PV_PR_DEVVALPARAM(CV_cod_modulo_gral, LR_DatAbonado.cod_producto,'CENTRAL_GSM_CAMBTEC',LV_cod_central);
         ******************************************************************************************************/

      ELSIF LV_TecDestino = LV_TecnologiaGsm THEN

--         INSERT INTO GA_EQUIPABOSER
--         (NUM_ABONADO, num_serie, cod_producto, ind_procequi, fec_alta,
--         ind_propiedad, cod_bodega, tip_stock, cod_articulo, ind_equiacc, cod_modventa, tip_terminal,
--         cod_uso, cod_cuota, cod_estado, cap_code, cod_protocolo, num_velocidad, cod_frecuencia, cod_version,
--         num_seriemec, des_equipo, cod_paquete, num_movimiento, cod_causa, ind_eqprestado,num_imei, cod_tecnologia,
--         prc_venta)--prc_venta agregado 150909
--         -- SELECT num_abonado, num_serie, cod_producto, ind_procequi, LD_fecha, -- TMC 62470|19-02-2008|SAQL
--       SELECT NUM_ABONADO, NVL(EV_num_serie_sim,NUM_SERIE), cod_producto, ind_procequi, LD_fecha, -- TMC 62470|19-02-2008|SAQL
--         ind_propiedad, cod_bodega, tip_stock, cod_articulo, ind_equiacc, cod_modventa, tip_terminal,
--         cod_uso, cod_cuota, cod_estado, cap_code, cod_protocolo, num_velocidad, cod_frecuencia, cod_version,
--         num_seriemec, des_equipo, cod_paquete, num_movimiento, NULL, ind_eqprestado,EV_num_serie_equ, LV_TecDestino,
--         prc_venta--prc_venta agregado 150909
--         FROM GA_EQUIPABOSER
--         WHERE NUM_ABONADO = LR_DatAbonado.NUM_ABONADO
--         AND  num_serie = LR_DatAbonado.num_serie
--         AND num_imei = LR_DatAbonado.num_imei;

--          IF NOT SQL%ROWCOUNT = 1 THEN
--              LV_des_error:='Excepci¥n ingreso ga_equipaboser simcard actual.';
--             SN_cod_retorno := 569;
--             RAISE fin_ejecucion;
--          END IF;
NULL;
      END IF;

      --******* Fin ingresar en la tabla GA_EQUIPABOSER ***************

      LN_num_meses := NULL;

      /*****Obtiene el nÀmero de meses del contrato nuevo para insertarlo en la tabla de abonado****/

      SELECT num_meses
      INTO LN_num_meses
      FROM GA_PERCONTRATO
      WHERE cod_tipcontrato = EV_cod_tipcontrato AND
            cod_producto = 1;

      --******* Actualizar GA_ABOCEL o GA_ABOAMIST *******************
      IF LV_TecDestino = LV_TecnologiaTdma THEN
           BEGIN
                  LV_des_error:='Excepci¥n ingreso ga_equipaboser de equipo';
                 P_Transforma_Hexa (LR_DatSerieEqu.num_serie, LV_SerieHex);
            EXCEPTION
               WHEN OTHERS THEN
                 LV_des_error:='Excepci¥n transforma serie a hexadecimal.';
                 SN_cod_retorno := 518;
            END;
      ELSE
            LV_SerieHex :='0';
      END IF;

      DBMS_OUTPUT.PUT_LINE('LV_tabla_abo='||LV_tabla_abo);

      BEGIN
             LV_des_error:='Excepci¥n actualiza datos del abonado.';

           IF LV_tabla_abo='GA_ABOCEL' THEN

              -- INICIO RRG 07-03-2009 COL 78629

            select c.fec_alta_aboser
            into D_fec_alta_aboser
            from ga_abocel a , ga_percontrato b,
            ( select max(fec_alta) fec_alta_aboser,
            num_serie, Ind_procequi
            from ga_equipaboser where num_abonado = LR_DatAbonado.NUM_ABONADO
            group by num_serie,Ind_procequi) c
            Where num_abonado = LR_DatAbonado.NUM_ABONADO
            and a.cod_tipcontrato = b.cod_tipcontrato
            and c.num_serie = a.num_imei;


            --148477

            --valida los registros de renovacion que pueda tener para un cambio de serie
            LN_CANT_RENOVA:=0;

            SELECT COUNT(1)
            INTO LN_CANT_RENOVA
            FROM PV_REGISTRA_RENOVACION_OS_TO
            WHERE  COD_OS ='10270'
            AND NUM_OS = 0
            AND NUM_ABONADO =LR_DatAbonado.NUM_ABONADO
            AND FEC_INGRESO IN (SELECT  MAX(FEC_INGRESO)
                                FROM PV_REGISTRA_RENOVACION_OS_TO
                                WHERE  COD_OS ='10270'
                                AND NUM_OS = 0
                                AND NUM_ABONADO =LR_DatAbonado.NUM_ABONADO)
            AND TRUNC(FEC_INGRESO) = TRUNC(SYSDATE);

              IF LN_CANT_RENOVA = 1 THEN

                  select add_months(SYSDATE, LN_num_meses) into LR_DatAbonado.fec_fincontra FROM dual;
                  --Cambio de fecha de contrato solo agregando los numeros de meses del contrato nuevo mas la fecha actual de la renovacion

              ELSE

                  select add_months( D_fec_alta_aboser,LN_num_meses) into D_AboserMasMeses from dual;

                  If LR_DatAbonado.fec_fincontra > D_AboserMasMeses Then
                       LR_DatAbonado.fec_fincontra := LR_DatAbonado.fec_fincontra + LN_num_meses;

                     select add_months( LR_DatAbonado.fec_fincontra,LN_num_meses)
                     into LR_DatAbonado.fec_fincontra from dual;

                  End If;

              END IF;

              -- FIN RRG 07-03-2009 COL 78629

              UPDATE GA_ABOCEL
                 SET      cod_situacion   = 'CSP',
                         ind_procequi       = LV_procedencia,
                      num_serie       = DECODE(LV_TecDestino,LV_TecnologiaGsm,NVL(LR_DatSerieSim.num_serie,num_serie),EV_num_serie_equ),
                      num_seriemec       = DECODE(LV_TecDestino,LV_TecnologiaTdma,LR_DatSerieEqu.num_seriemec,NULL),
                      num_seriehex       = LV_SerieHex,
                      tip_terminal       = DECODE(LV_TecDestino,LV_TecnologiaTdma,LR_DatSerieEqu.tip_terminal,LV_TipTermSim),
                      fec_ultmod         = SYSDATE,
                      ind_eqprestado  = LT_IndEqprestado,
                      cod_modventa       = LV_ModVenta,
--                      cod_tipcontrato = LV_CodTipContrato, comentado
                      cod_tipcontrato = EV_cod_tipcontrato,
--                      fec_prorroga       = DECODE(LV_procedencia,'E',NULL,fec_prorroga), comentado
                      fec_prorroga       = DECODE(LV_procedencia,'E',NULL,SYSDATE),
                      num_imei           = DECODE(LV_TecDestino,LV_TecnologiaGsm,LR_DatSerieEqu.num_serie,NULL),
                      cod_planserv       = NVL(LV_cod_planserv,cod_planserv),
                      --cod_central       = nvl(LV_cod_central,cod_central),-- 44720-TMC|08-10-2007|EFR.
                         cod_central      = NVL(vCod_Central_Nue,cod_central),-- 44720-TMC|08-10-2007|EFR.
                      cod_tecnologia  = LV_TecDestino,
                      cod_password       = DECODE(NVL(LR_DatSerieSim.num_serie,0),0,cod_password, SUBSTR(LR_DatSerieSim.num_serie,-4)),
                      num_contrato      = DECODE(LV_procedencia,'E', LR_DatAbonado.num_contrato, EV_num_contrato),
                      num_anexo          = DECODE(LV_procedencia,'E', LR_DatAbonado.num_anexo, EV_num_anexo),
                      ---  INICIO RRG 07-03-2009 COL 78629
                      --fec_fincontra      = DECODE(LV_procedencia,'E', LR_DatAbonado.fec_fincontra, ADD_MONTHS(SYSDATE,LN_num_meses))
                      fec_fincontra      = LR_DatAbonado.fec_fincontra
                      -- FIN RRG 07-03-2009 COL 78629
                      ,cod_plantarif  = NVL(LV_cod_plantarif,cod_plantarif) --INI.pagc 06-05-2008
                      ,cod_cargobasico = NVL(LV_cod_cargobasico,cod_cargobasico) --INI.pagc 14-05-2008
                 WHERE NUM_ABONADO       = LR_DatAbonado.NUM_ABONADO;

           ELSIF LV_tabla_abo='GA_ABOAMIST' THEN

              UPDATE GA_ABOAMIST
                 SET      cod_situacion   = 'CSP',
                         ind_procequi       = LV_procedencia,
                      num_serie          = DECODE(LV_TecDestino,LV_TecnologiaGsm,NVL(LR_DatSerieSim.num_serie,num_serie),EV_num_serie_equ),
                      num_seriemec       = DECODE(LV_TecDestino,LV_TecnologiaTdma,LR_DatSerieEqu.num_seriemec,NULL),
                      num_seriehex       = LV_SerieHex,
                      tip_terminal       = DECODE(LV_TecDestino,LV_TecnologiaTdma,LR_DatSerieEqu.tip_terminal,LV_TipTermSim),
                      fec_ultmod         = SYSDATE,
                      cod_modventa       = LV_ModVenta,
                      --cod_tipcontrato = LV_CodTipContrato, --TMC-38662|23-03-2007|GEZ
                      num_imei        = DECODE(LV_TecDestino,LV_TecnologiaGsm,LR_DatSerieEqu.num_serie,NULL),
                      cod_planserv       = NVL(LV_cod_planserv,cod_planserv),
                      --cod_central       = nvl(LV_cod_central,cod_central),-- 44720-TMC|08-10-2007|EFR.
                             cod_central    = NVL(vCod_Central_Nue,cod_central),-- 44720-TMC|08-10-2007|EFR.
                      cod_tecnologia  = LV_TecDestino,
                      cod_password       = DECODE(ind_password,0,SUBSTR(NVL(LR_DatSerieSim.num_serie,LR_DatSerieEqu.num_serie),-4),cod_password)
                      ,cod_plantarif    = NVL(LV_cod_plantarif,cod_plantarif) --INI.pagc 06-05-2008
                      ,cod_cargobasico = NVL(LV_cod_cargobasico,cod_cargobasico) --INI.pagc 14-05-2008
                 WHERE NUM_ABONADO       = LR_DatAbonado.NUM_ABONADO;

           ELSE
                 RAISE fin_ejecucion;
           END IF;
      EXCEPTION
           WHEN OTHERS THEN
                 LV_des_error:= LV_des_error || SQLERRM;
               SN_cod_retorno := 570;
              RAISE fin_ejecucion;
      END;
      --******* FIN Actualizar GA_ABOCEL o GA_ABOAMIST *******************

      -- ******Configurar los servicios suplementarios cuando existe cambio de tecnologia *******

      --IF NOT LR_DatAbonado.cod_tecnologia = LV_TecDestino  THEN
      IF NOT LV_GrupoTecAbo = LV_GrupoTecNue  THEN
           LV_des_error:='Excepci¥n homologaci¥n servicios suplementarios.';

         IF LV_camtec_camplan = 'TRUE' AND LV_GrupoTecAbo = LV_GrupoTecDMA  AND LV_GrupoTecNue = LV_GrupoTecGSM  THEN

            pv_generass_plan_pr (LR_DatAbonado.cod_producto,
                                LR_DatAbonado.NUM_ABONADO,
                                LR_DatAbonado.num_celular,
                                EV_nom_usuario,
                                LV_tabla_abo,
                                LR_DatAbonado.cod_plantarif,
                                LR_DatAbonado.tip_terminal,
                                LR_DatAbonado.cod_central,
                                LR_DatAbonado.cod_tecnologia,
                                NVL(LV_cod_plantarif,LR_DatAbonado.cod_plantarif) ,
                                vCod_Central_Nue,
                                LV_TipTermSim,
                                LV_TecDestino,LV_CadServicios);
                                DBMS_OUTPUT.PUT_LINE('LV_CadServicios:'|| LV_CadServicios);
        ELSE

             IF NOT Pv_Actcambios_Ofvirtual_Pg.PV_Obtservsupltecno_fn(LR_DatAbonado.NUM_ABONADO,LR_DatAbonado.num_celular,LR_DatAbonado.cod_producto,EV_cod_central,LR_DatAbonado.tip_terminal,LV_TipTermSim,LR_DatAbonado.cod_tecnologia,LV_TecDestino,LR_DatAbonado.cod_uso,EV_nom_usuario,LV_tabla_abo,GV_sSERVICIO_AUTENTICACION,LV_CadServicios, LV_sCadenaICCSS,LV_des_error) THEN
                    SN_cod_retorno := 571;
                  RAISE fin_ejecucion;
                END IF;

        END IF;
      END IF;

      -- ******Configurar los servicios suplementarios cuando existe cambio de tecnologia *******

      --LV_CadServicios := LV_CadServicios || LV_comando;

      --******* Funcionalidad que actualizar¿ el stock de las series ******
      -- Salida definitiva del equipo comodato, ya que, se asume que no lo devuelve--
      IF LR_DatAbonado.ind_eqprestado=1 THEN
              LV_des_error:='Excepci¥n salida definitiva equipo arriendo.';

         IF LR_DatAbonado.cod_tecnologia = LV_TecnologiaTdma THEN
                  LR_DatSerieAct.num_serie := LR_DatAbonado.num_serie;
            ELSE
               LR_DatSerieAct.num_serie := LR_DatAbonado.num_imei;
            END IF;

            BEGIN
               SELECT  A.cod_bodega, A.tip_stock, A.cod_articulo, A.cod_uso,
              A.cod_estado, A.ind_telefono, A.cod_producto, A.cod_central
              INTO LR_DatSerieAct.cod_bodega, LR_DatSerieAct.tip_stock, LR_DatSerieAct.cod_articulo, LR_DatSerieAct.cod_uso,
              LR_DatSerieAct.cod_estado, LR_DatSerieAct.ind_telefono, LR_DatSerieAct.cod_producto, LR_DatSerieAct.cod_central
              FROM AL_SERIES A
              WHERE A.num_serie=LR_DatSerieAct.num_serie;
         EXCEPTION
              WHEN NO_DATA_FOUND THEN
                   SN_cod_retorno := 576;
                  RAISE fin_ejecucion;
         END;

          Pv_Actcambios_Ofvirtual_Pg.PV_interal_PR(CV_MovSalDefArrCom,LR_DatSerieAct.tip_stock,LR_DatSerieAct.cod_bodega,LR_DatSerieAct.cod_articulo,LR_DatSerieAct.cod_uso,NULL,NULL,1,LR_DatSerieAct.num_serie,NULL,LN_cod_retorno,LV_des_cadena);

         IF NOT LN_cod_retorno=0 THEN
              SN_cod_retorno := 300127;
            LV_des_error   := LV_des_cadena;
             RAISE fin_ejecucion;
         END IF;

      END IF;

       -- Salida definitiva del equipo nuevo --
       IF LV_procedencia = 'I' THEN

         LV_des_error:='Excepci¥n salida definitiva equipo nuevo.';
          Pv_Actcambios_Ofvirtual_Pg.PV_interal_PR(CV_MovSalDef,LR_DatSerieEqu.tip_stock,LR_DatSerieEqu.cod_bodega,LR_DatSerieEqu.cod_articulo,LR_DatSerieEqu.cod_uso,LR_DatSerieEqu.cod_estado,NULL,1,EV_num_serie_equ,NULL,LN_cod_retorno,LV_des_cadena);

         IF NOT LN_cod_retorno=0 THEN
              SN_cod_retorno := 300127;
            LV_des_error   := LV_des_cadena;
             RAISE fin_ejecucion;
          END IF;
       END IF;

      IF LR_DatSerieSim.num_serie IS NOT NULL THEN

             -- Salida definitva de la serie  simcard
             LV_des_error:='Excepci¥n salida definitiva simcard.';
             Pv_Actcambios_Ofvirtual_Pg.PV_interal_PR(CV_MovSalDef,LR_DatSerieSim.tip_stock,LR_DatSerieSim.cod_bodega,LR_DatSerieSim.cod_articulo,LR_DatSerieSim.cod_uso,LR_DatSerieSim.cod_estado,NULL,1,EV_num_serie_sim,NULL,LN_cod_retorno,LV_des_cadena);

             IF NOT LN_cod_retorno=0 THEN
                 SN_cod_retorno := 300127;
                LV_des_error   := LV_des_cadena;
                 RAISE fin_ejecucion;
             END IF;
      END IF;
      --******* Fin funcionalidad que actualizar¿ el stock de las series ******


      --*********** Insertar movimientos central ***************************

      IF LV_tabla_abo = 'GA_ABOCEL' THEN
           BEGIN
                 LT_NumMin := Al_Fn_Prefijo_Numero(LR_DatAbonado.num_celular);
            EXCEPTION
               WHEN OTHERS THEN
                 LV_des_error:='Excepci¥n al obtener prefijo.';
                    SN_cod_retorno := 496;
                 RAISE fin_ejecucion;
            END;
      END IF;

      IF LV_TecDestino = LV_TecnologiaGsm THEN
              BEGIN
                  LT_imsi_nue := Fn_Recupera_Imsi(NVL(LR_DatSerieSim.num_serie,LR_DatAbonado.num_serie));
            EXCEPTION
               WHEN OTHERS THEN
                 LV_des_error:='Excepci¥n al obtener imsi.';
                    SN_cod_retorno := 510;
                 RAISE fin_ejecucion;
            END;

         LT_imei_nue := LR_DatSerieEqu.num_serie;
            LT_icc_nue := NVL(LR_DatSerieSim.num_serie,LR_DatAbonado.num_serie);
      END IF;

      IF LR_DatAbonado.cod_tecnologia = LV_TecnologiaGsm THEN
          LT_imsi := LT_imsi_nue;
          LT_imei := LR_DatAbonado.num_imei;
          LT_icc  := LR_DatAbonado.num_serie;
      END IF;

--      IF NOT LR_DatAbonado.cod_tecnologia = LV_TecDestino  AND trim(LV_sCadenaICCSS) IS NOT NULL THEN
      IF (LR_DatAbonado.cod_tecnologia <> LV_TecDestino)  AND (trim(LV_sCadenaICCSS) IS NOT NULL) THEN

           --********INSERTAR MOVIMIENTO DE SERVICIO SUPLEMENTARIO PARA CAMBIO DE TECNOLOG¿A ******--
         BEGIN

              LV_des_error:='Excepci¥n ingreso movimiento central de servicio suplementario.';

              BEGIN

                   SELECT a.cod_actabo INTO LV_CodPvActabo
                   FROM PV_ACTABO_TIPLAN a, TA_PLANTARIF b
                    WHERE a.cod_tipmodi = LV_CodActaboSS
                    AND b.cod_plantarif = LR_DatAbonado.cod_plantarif
                    AND a.cod_tiplan  = b.cod_tiplan;

               EXCEPTION
                   WHEN NO_DATA_FOUND THEN
                  LV_CodPvActabo := LV_CodActaboSS;
               END;

               LN_CodActCen := Fn_Codactcen(LR_DatAbonado.cod_producto,LV_CodPvActabo,CV_cod_modulo_gral,LR_DatAbonado.cod_tecnologia);

              INSERT INTO ICC_MOVIMIENTO(
              num_movimiento,cod_estado,NUM_ABONADO,cod_modulo,nom_usuarora,fec_ingreso,cod_central,
              num_celular,num_serie,num_serie_nue,
              tip_terminal,cod_actabo,cod_servicios,num_min,tip_terminal_nue,tip_tecnologia,
              imsi,imei,icc,
              num_intentos,des_respuesta,cod_actuacion
              )
              VALUES(
              ICC_SEQ_NUMMOV.NEXTVAL,1,LR_DatAbonado.NUM_ABONADO,CV_cod_modulo_gral,EV_nom_usuario,SYSDATE,LR_DatAbonado.cod_central,
              LR_DatAbonado.num_celular,LR_DatAbonado.num_seriehex,'',
              LR_DatAbonado.tip_terminal,LV_CodActaboSS,LV_sCadenaICCSS,LT_NumMin,'',LV_TecDestino,
              LT_imsi,LT_imei,LT_icc,
              0,'PENDIENTE',LN_CodActCen
              );

         EXCEPTION
             WHEN OTHERS THEN
                    SN_cod_retorno := 574;
                   RAISE fin_ejecucion;
         END;
         --*****************************************************************************************
      END IF;

      --******************** INSERTAR MOVIMIENTO CENTRAL DE CAMBIO DE SERIE *************************
      BEGIN

          SELECT ice.cod_tecnologia
          INTO LV_TecInicial
          FROM ICG_CENTRAL ice
          WHERE ice.cod_producto = LR_DatAbonado.cod_producto
          AND EXISTS(
                  SELECT 1
                  FROM GA_CELNUM_USO ceu
                  WHERE EN_num_celular BETWEEN ceu.num_desde AND ceu.num_hasta
                  AND ceu.cod_central  = ice.cod_central);

            LV_des_error:='Excepci¥n llamado pl PV_obtiene_grupo_tecnologia_FN en Insertar movimiento central de serie';

          Pv_Actcambios_Ofvirtual_Pg.PV_obtiene_grupo_tecnologia_FN(LV_TecInicial, LV_GrupoTecnoAbonado, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

          LV_TecInicial:=LV_GrupoTecnoAbonado;

          LV_GrupoTecnoAbonado:=NULL;

     EXCEPTION
         WHEN OTHERS THEN
             SN_cod_retorno := 575;
             RAISE fin_ejecucion;
     END;


    LV_des_error:='Obtiene cod_actabo desde PV_TECNO_ACTABO_TD.';

    SELECT cod_actabo INTO LV_CodActabo
    FROM PV_TECNO_ACTABO_TD
    WHERE cod_tecnologia_ini = LV_TecInicial
    AND cod_tecnologia_act = LR_DatAbonado.cod_tecnologia
    AND cod_tecnologia_fin = LV_TecDestino;


     BEGIN
           LV_des_error:='Excepci¥n ingreso movimiento central de cambio serie.';

          BEGIN
             SELECT a.cod_actabo INTO LV_CodPvActabo FROM PV_ACTABO_TIPLAN a, TA_PLANTARIF b
             WHERE a.cod_tipmodi = LV_CodActabo
             AND b.cod_plantarif = LR_DatAbonado.cod_plantarif
             AND a.cod_tiplan  = b.cod_tiplan;
          EXCEPTION
              WHEN NO_DATA_FOUND THEN
                   LV_CodPvActabo := LV_CodActabo;
          END;

           LN_CodActCen := Fn_Codactcen(LR_DatAbonado.cod_producto,LV_CodPvActabo,CV_cod_modulo_gral,LR_DatAbonado.cod_tecnologia);

          IF NOT LR_DatAbonado.cod_tecnologia = LV_TecDestino THEN
                  LT_TipTermNue := LR_DatSerieSim.tip_terminal;-- TDMA -> GSM
          ELSE
               IF LV_procedencia = 'I' THEN

                IF LV_TecDestino = LV_TecnologiaGsm THEN
                        LT_TipTermNue := LV_TipTermSim;  --GSM->GSM  OR
                   ELSE
                         LT_TipTermNue := LR_DatSerieEqu.tip_terminal; --TDMA -> TDMA
                   END IF;
             ELSE
                --Cuando la procedencia del equipo es externa no tenemos el tipo de terminal nuevo por lo tanto
                -- actualizaremos con un valor por defualt para GSM y TDMA
                IF LV_TecDestino = LV_TecnologiaGsm THEN
                   LT_TipTermNue := LV_TipTermSim;
                ELSE
                   LT_TipTermNue := LT_TipTermDig;
                END IF;
             END IF;

          END IF;

          --INI COL-71848|10-11-2008|GEZ

          IF LV_camtec_camplan = 'TRUE' AND LV_GrupoTecAbo = LV_GrupoTecDMA  AND LV_GrupoTecNue = LV_GrupoTecGSM  THEN
               LV_CadenaSS:=Pv_Servicio_Suplementario_Pg.PV_CADENASS_ACTDES_ABO_FN (
                           LR_DatAbonado.NUM_ABONADO, '1','4', '0', '1'
                          ,LV_Estado, LV_Proc, SN_cod_retorno, SN_num_evento, LV_Tabla, LV_Act, LV_Code, LV_des_error );

             IF LV_Estado='3' THEN
                 LV_CadServicios:=LV_CadenaSS;
             ELSE
                 LV_des_error:=LV_des_error||'-'||LV_Tabla||'-'||LV_Act;
                 RAISE fin_ejecucion;
             END IF;

          END IF;

          --FIN COL-71848|10-11-2008|GEZ

          INSERT INTO ICC_MOVIMIENTO(
          num_movimiento,cod_estado,NUM_ABONADO,cod_modulo,nom_usuarora,fec_ingreso,cod_central,
          num_celular,num_serie,num_serie_nue,
          tip_terminal,cod_actabo,cod_servicios,num_min,tip_terminal_nue,tip_tecnologia,
          imsi_nue,imei_nue,icc_nue,imsi,imei,icc,
          num_intentos,des_respuesta,cod_actuacion,PLAN, carga
          )
          VALUES
          --(ICC_SEQ_NUMMOV.Nextval,1,LR_DatAbonado.num_abonado,CV_cod_modulo_gral,EV_nom_usuario,sysdate,NVL(LV_cod_central,LR_DatAbonado.cod_central), -- 44720-TMC|08-10-2007|EFR.
          (ICC_SEQ_NUMMOV.NEXTVAL,1,LR_DatAbonado.NUM_ABONADO,CV_cod_modulo_gral,EV_nom_usuario,SYSDATE,NVL(vCod_Central_Nue,LR_DatAbonado.cod_central),-- 44720-TMC|08-10-2007|EFR.
          LR_DatAbonado.num_celular,LR_DatAbonado.num_seriehex,DECODE(LV_TecDestino,LV_TecnologiaGsm,' ',LV_SerieHex),
          LR_DatAbonado.tip_terminal,LV_CodPvActabo,NVL(trim(LV_CadServicios),LV_comando),LT_NumMin,LT_TipTermNue,LV_TecDestino,
          LT_imsi_nue,LT_imei_nue,LT_icc_nue,LT_imsi,LT_imei,LT_icc,
          0,'PENDIENTE',LN_CodActCen,LV_plan, LN_carga
          );
     EXCEPTION
         WHEN OTHERS THEN
                SN_cod_retorno := 574;
                RAISE fin_ejecucion;
     END;
     --*********** Fin insertar movimientos central ************************

     --***********Inicio Inc 34328 - jjr.- 03/10/2006***************

     sCadServiciosAmiAdic := '';

     FOR vleeServiciosAbo IN leeServiciosAbo (LR_DatAbonado.NUM_ABONADO) LOOP
         sCadServiciosAmiAdic := sCadServiciosAmiAdic ||  vleeServiciosAbo.ServicioAbonado;
     END LOOP;

     DBMS_OUTPUT.PUT_LINE ('sCadServiciosAmiAdic: '||sCadServiciosAmiAdic);

     IF LV_tabla_abo='GA_ABOCEL' THEN
             UPDATE GA_ABOCEL SET
            clase_servicio = sCadServiciosAmiAdic--,--TMC-38662|23-03-2007|GEZ
            --Perfil_abonado = sCadServiciosAmiAdic --TMC-38662|23-03-2007|GEZ
             WHERE NUM_ABONADO = LR_DatAbonado.NUM_ABONADO;
     ELSIF LV_tabla_abo='GA_ABOAMIST' THEN
          UPDATE GA_ABOAMIST SET
            clase_servicio = sCadServiciosAmiAdic--,--TMC-38662|23-03-2007|GEZ
            --Perfil_abonado = sCadServiciosAmiAdic --TMC-38662|23-03-2007|GEZ
             WHERE NUM_ABONADO = LR_DatAbonado.NUM_ABONADO;
     END IF;
     --***********Fin Inc 34328 - jjr.- 03/10/2006***************

     /******** Registra Orden de Servicio **************/
     /*IF NOT Pv_Actcambios_Ofvirtual_Pg.PV_Registra_Orden_Servicio_FN(LR_DatAbonado.NUM_ABONADO, '10270','Cambio serie Of. Virtual',EV_nom_usuario,SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
        RAISE fin_ejecucion;
     END IF;*/

     /* cierre de variables */

  --INI INC 160153 GUA JRCH 28-12-2010
  Pv_Actcambios_Ofvirtual_Pg.PV_UP_CARGOINME_EQUIP_PR(EV_num_serie_equ,LR_DatAbonado.NUM_ABONADO,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

   IF SN_cod_retorno<>0 THEN
        RAISE fin_ejecucion;
   END IF;
   --FIN INC 160153 GUA JRCH 28-12-2010

     SV_ind_operacion := 0;
     SV_mens_retorno := 'Transacci¥n ejecutada correctamente';

     IF SN_cod_retorno IS NULL THEN
            SN_cod_retorno := 0;
     END IF;

     IF SN_num_evento IS NOT NULL THEN
            SN_num_evento := '';
     END IF;

     --INI Inc 157095

        LV_des_error:='busca numero de venta';

		        BEGIN --162979
				
                --SELECT B.NUM_VENTA 21-01-2011
                SELECT DISTINCT (B.NUM_VENTA)
                INTO LN_NUM_VENTA
                FROM GE_CARGOS A, GA_VENTAS B
                WHERE A.NUM_TRANSACCION = B.NUM_TRANSACCION
                AND A.NUM_ABONADO = LR_DatAbonado.NUM_ABONADO
                AND A.NOM_USUARORA = EV_nom_usuario
                AND B.FEC_VENTA IN (SELECT MAX(D.FEC_VENTA) FROM GE_CARGOS C, GA_VENTAS D
                                    WHERE C.NUM_TRANSACCION = D.NUM_TRANSACCION
                                    AND C.NUM_ABONADO = LR_DatAbonado.NUM_ABONADO);
				--ini 162979
				EXCEPTION
              			 WHEN NO_DATA_FOUND THEN
                   		 LN_NUM_VENTA := 0;
          		END;
				--fin 162979

                LV_des_error:='Excepci¥n llamado pl PV_movi_equiposimcard_PR que actualiza la tabla AL_MOVIMIENTOS';

                Pv_Actcambios_Ofvirtual_Pg.PV_movi_equiposimcard_PR(EV_num_serie_equ,LN_NUM_VENTA,LR_DatAbonado.NUM_ABONADO,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

                       IF SN_cod_retorno<>0 THEN
                            RAISE fin_ejecucion;
                       END IF;

     --FIN Inc 157095




EXCEPTION
     WHEN fin_ejecucion THEN

            IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
               SV_mens_retorno := CV_error_no_clasIF;
            END IF;

          IF SN_num_evento IS NULL THEN
                  SN_num_evento := 0;
            END IF;

          SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,
                                                  CV_cod_modulo,
                                                  SV_mens_retorno,
                                                  CV_num_version, USER,
                                                    'Pv_Actcambios_Ofvirtual_Pg.pv_cambioserie_pr',
                                                  NULL, SQLCODE, LV_des_error );
     WHEN OTHERS THEN

          SN_cod_retorno  := '302';

          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno ,SV_mens_retorno) THEN
               SV_mens_retorno :=CV_error_no_clasIF;
             END IF;

          LV_des_error := SUBSTR(LV_des_error ||':' || SQLERRM,1,CN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);

          IF SN_num_evento IS NULL THEN
                  SN_num_evento := 0;
          END IF;

          SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,
                                                      CV_cod_modulo,
                                                  SV_mens_retorno,
                                                  CV_num_version, USER,
                                                      'Pv_Actcambios_Ofvirtual_Pg.pv_cambioserie_pr',
                                                  NULL, SQLCODE, LV_des_error );

END PV_cambioserie_PR;
-------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_RecPlantarifDes_PR (EV_plan_tarif_abo           IN ta_plantarif.cod_plantarif%TYPE,
                                   EV_cod_tecnologia_ori     IN ga_equipaboser.cod_tecnologia%TYPE,
                                 EV_cod_tecnologia_des       IN ga_equipaboser.cod_tecnologia%TYPE,
                                 SV_plan_tarif_des           OUT NOCOPY ta_plantarif.des_plantarif%TYPE,
                                 SN_cod_retorno               OUT NOCOPY ge_errores_pg.codError,
                                 SV_mens_retorno           OUT NOCOPY ge_errores_pg.MsgError,
                                 SN_num_evento               OUT NOCOPY ge_errores_pg.Evento)

AS
/*
<Documentaci¥n>
  <TipoDoc = "Procedimiento"/>
   <Elemento
      Nombre = "pv_ins_equipaboser_pr "
      Lenguaje="PL/SQL"
      Fecha="21-11-2005"
      Versi¥n="1.0"
      Dise¿ador="Patricio Gallegos"
      Programador="Patricio Gallegos"
      Ambiente Desarrollo="BD">
      <Retorno></Retorno>
      <Descripci¥n>Ingresa registo a la tabla GA_EQUIPABOSER</Descripci¥n>
   </Elemento>
</Documentaci¥n>
*/

LV_des_error         ge_errores_pg.DesEvent;
LV_sSql                 ge_errores_pg.vQuery;
LV_GrupoTecnoAbonado al_tecnologia.cod_grupo%TYPE;
LV_plan_tarif_des     ta_plantarif.cod_plantarif%TYPE;

BEGIN

    SN_cod_retorno := 0;
    SV_mens_retorno:= '';
    SN_num_evento:= 0;

    LV_sSql := 'Pv_Actcambios_Ofvirtual_Pg.PV_obtiene_grupo_tecnologia_FN(';
    LV_sSql := LV_sSql || EV_cod_tecnologia_ori || ', ';
    LV_sSql := LV_sSql || LV_GrupoTecnoAbonado || ', ';
    LV_sSql := LV_sSql || SN_cod_retorno || ', ';
    LV_sSql := LV_sSql || SV_mens_retorno || ', ';
    LV_sSql := LV_sSql || SN_num_evento || ')';

    Pv_Actcambios_Ofvirtual_Pg.PV_obtiene_grupo_tecnologia_FN(EV_cod_tecnologia_ori, LV_GrupoTecnoAbonado, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

    LV_sSql := 'SELECT cod_plantarif_des';
    LV_sSql := LV_sSql || ' FROM pv_cambtecno_plan_td';
    LV_sSql := LV_sSql || ' WHERE cod_tecnologia_ori = ' || LV_GrupoTecnoAbonado || ' AND';
    LV_sSql := LV_sSql || ' cod_plantarif_ori = ' || EV_plan_tarif_abo || ' AND';
    LV_sSql := LV_sSql || ' cod_tecnologia_des = ' || EV_cod_tecnologia_des || ' AND';
    LV_sSql := LV_sSql || ' cod_producto = 1';

    SELECT cod_plantarif_des
    INTO LV_plan_tarif_des
    FROM pv_cambtecno_plan_td
    WHERE cod_tecnologia_ori = LV_GrupoTecnoAbonado    AND
          cod_plantarif_ori = EV_plan_tarif_abo    AND
          cod_tecnologia_des = EV_cod_tecnologia_des AND
          cod_producto = 1;

    LV_sSql := 'SELECT des_plantarif';
    LV_sSql := LV_sSql || ' FROM ta_plantarif';
    LV_sSql := LV_sSql || ' WHERE cod_plantarif = ' || LV_plan_tarif_des;

    SELECT des_plantarif
    INTO SV_plan_tarif_des
    FROM ta_plantarif
    WHERE cod_plantarif = LV_plan_tarif_des;

EXCEPTION
         WHEN OTHERS THEN
           SN_cod_retorno  := -1;
           SV_mens_retorno:= 'No existe configuraci¥n de Plan Hom¥logo, No podr¿ realizar Cambio de Tecnolog¿a.';
           LV_des_error := SUBSTR('PV_RecPlantarifDes_PR(...); - ' || SQLERRM,1,CN_largoerrtec);
           SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, '1.0', USER, 'Pv_Actcambios_Ofvirtual_Pg.PV_RecPlantarifDes_PR', LV_sSql, SQLCODE, LV_des_error);

END PV_RecPlantarifDes_PR;

PROCEDURE PV_RecPrecioVenta_PR(EV_num_serie    IN al_series.NUM_SERIE%TYPE,
                               EV_num_abonado  IN ga_abocel.NUM_ABONADO%TYPE,
                               EV_cod_modventa IN al_precios_venta.COD_MODVENTA%TYPE,
                               SV_precio_venta        OUT NOCOPY al_precios_venta.PRC_VENTA%TYPE,
                               SN_cod_retorno        OUT NOCOPY ge_errores_pg.codError,
                               SV_mens_retorno        OUT NOCOPY ge_errores_pg.MsgError,
                               SN_num_evento        OUT NOCOPY ge_errores_pg.Evento)

AS
/*
<Documentaci¥n>
  <TipoDoc = "Procedimiento"/>
   <Elemento
      Nombre = "PV_RecPrecioVenta_PR
      Lenguaje="PL/SQL"
      Fecha="15-09-2009
      Versi¥n="1.0"
      Dise¿ador="Patricio"
      Programador="Patricio
      Ambiente Desarrollo="BD">
      <Retorno></Retorno>
      <Descripci¥n>Obtiene el precio de venta de un equipo</Descripci¥n>
   </Elemento>
</Documentaci¥n>
*/

LV_des_error         ge_errores_pg.DesEvent;
LV_sSql                 ge_errores_pg.vQuery;
LV_cod_categoria     ve_catplantarif.COD_CATEGORIA%TYPE;
LV_cod_tipcontrato      ga_abocel.COD_TIPCONTRATO%TYPE;
LV_cod_plan_tarif     ga_abocel.COD_PLANTARIF%TYPE;
LV_num_meses         ga_percontrato.NUM_MESES%TYPE;
LV_cod_promedio        al_promfact.COD_PROMEDIO%TYPE;
LV_cod_cliente       ga_abocel.COD_CLIENTE%TYPE;
LV_cod_antiguedad       al_precios_venta.COD_ANTIGUEDAD%TYPE;

BEGIN

    SN_cod_retorno  := 0;
    SV_mens_retorno := '';
    SN_num_evento   := 0;
    SV_precio_venta := 0;

    LV_sSql := 'SELECT cod_tipcontrato,cod_pantarif,cod_cliente ';
    LV_sSql := LV_sSql || ' INTO LV_cod_tipcontrato,LV_cod_plan_tarif,LV_cod_cliente';
    LV_sSql := LV_sSql || ' FROM ga_abocel WHERE num_abonado = ' || EV_num_abonado;

    SELECT cod_tipcontrato,cod_plantarif,cod_cliente
    INTO LV_cod_tipcontrato,LV_cod_plan_tarif,LV_cod_cliente
    FROM ga_abocel WHERE num_abonado = EV_num_abonado;
    --------------------------------------------------------------------------------
    LV_sSql := 'SELECT cod_categoria INTO LV_cod_categoria ';
    LV_sSql := LV_sSql || ' FROM ve_catplantarif';
    LV_sSql := LV_sSql || ' WHERE cod_plantarif= = ' || LV_cod_plan_tarif;

    SELECT cod_categoria INTO LV_cod_categoria
    FROM ve_catplantarif
    WHERE cod_plantarif=LV_cod_plan_tarif;
    --------------------------------------------------------------------------------
    LV_sSql := 'SELECT num_meses INTO LV_num_meses FROM ga_percontrato ';
    LV_sSql := LV_sSql || ' WHERE cod_producto =1 ';
    LV_sSql := LV_sSql || ' AND cod_tipcontrato = ' || LV_cod_tipcontrato;

    SELECT num_meses INTO LV_num_meses FROM ga_percontrato
    WHERE cod_producto =1
    AND cod_tipcontrato = LV_cod_tipcontrato
    AND rownum =1;
    --------------------------------------------------------------------------------

    LV_sSql := 'SELECT a.cod_promedio  INTO LV_cod_promedio ';
    LV_sSql := LV_sSql || ' FROM al_promfact a, ';
    LV_sSql := LV_sSql || '        (SELECT ROUND(NVL(SUM(u.tot_factura)/MAX(v.cuenta),0)) total ';
    LV_sSql := LV_sSql || '        FROM fa_histdocu u, ';
    LV_sSql := LV_sSql || '              (SELECT COUNT(DISTINCT TO_CHAR(fec_emision,MM)) cuenta ';
    LV_sSql := LV_sSql || '               FROM fa_histdocu ';
    LV_sSql := LV_sSql || '               WHERE cod_tipdocum IN (SELECT cod_tipdocummov FROM fa_tipdocumen WHERE ind_ciclo = 1) AND ';
    LV_sSql := LV_sSql || '                     fec_emision > ADD_MONTHS(SYSDATE,-6) AND ';
    LV_sSql := LV_sSql || '                     cod_cliente = '||LV_cod_cliente||') v  ';
    LV_sSql := LV_sSql || '        WHERE u.cod_tipdocum IN (SELECT cod_tipdocummov FROM fa_tipdocumen WHERE ind_ciclo = 1) AND ';
    LV_sSql := LV_sSql || '               u.fec_emision > ADD_MONTHS(SYSDATE,-6) AND ';
    LV_sSql := LV_sSql || '             u.cod_cliente = '||LV_cod_cliente||') b ';
    LV_sSql := LV_sSql || '  WHERE b.total BETWEEN a.fact_desde AND a.fact_hasta ';

    SELECT a.cod_promedio  INTO LV_cod_promedio
    FROM al_promfact a,
           (SELECT ROUND(NVL(SUM(u.tot_factura)/MAX(v.cuenta),0)) total
           FROM fa_histdocu u,
                 (SELECT COUNT(DISTINCT TO_CHAR(fec_emision,'MM')) cuenta
                  FROM fa_histdocu
                  WHERE cod_tipdocum IN (SELECT cod_tipdocummov FROM fa_tipdocumen WHERE ind_ciclo = 1) AND
                        fec_emision > ADD_MONTHS(SYSDATE,-6) AND
                        cod_cliente = LV_cod_cliente) v
           WHERE u.cod_tipdocum IN (SELECT cod_tipdocummov FROM fa_tipdocumen WHERE ind_ciclo = 1) AND
                  u.fec_emision > ADD_MONTHS(SYSDATE,-6) AND
                u.cod_cliente = LV_cod_cliente) b
     WHERE b.total BETWEEN a.fact_desde AND a.fact_hasta;
    --------------------------------------------------------------------------------
    LV_sSql := 'SELECT a.cod_antiguedad ';
    LV_sSql := LV_sSql || ' INTO nCodAntiguedad ';
    LV_sSql := LV_sSql || ' FROM al_antiguedad a, ';
    LV_sSql := LV_sSql || '        (SELECT TRUNC(MONTHS_BETWEEN (SYSDATE,NVL(fec_alta,SYSDATE))) meses ';
    LV_sSql := LV_sSql || '        FROM ga_abocel ';
    LV_sSql := LV_sSql || '        WHERE num_abonado ='|| EV_num_abonado||') b ';
    LV_sSql := LV_sSql || ' WHERE b.meses BETWEEN a.ant_desde AND a.ant_hasta';

    SELECT a.cod_antiguedad
    INTO LV_cod_antiguedad
    FROM al_antiguedad a,
           (SELECT TRUNC(MONTHS_BETWEEN (SYSDATE,NVL(fec_alta,SYSDATE))) meses
           FROM ga_abocel
           WHERE num_abonado = EV_num_abonado) b
    WHERE b.meses BETWEEN a.ant_desde AND a.ant_hasta
    AND a.num_meses = LV_num_meses;

    --------------------------------------------------------------------------------
    LV_sSql := 'SELECT a.PRC_VENTA  INTO SV_precio_venta FROM al_precios_venta a,al_series b ';
    LV_sSql := LV_sSql || ' WHERE b.num_serie = '||EV_num_serie;
    LV_sSql := LV_sSql || ' AND a.fec_hasta>SYSDATE ';
    LV_sSql := LV_sSql || ' AND b.tip_stock      = a.tip_stock ';
    LV_sSql := LV_sSql || ' AND b.cod_articulo   = a.cod_articulo ';
    LV_sSql := LV_sSql || ' AND b.cod_uso        = a.cod_uso ';
    LV_sSql := LV_sSql || ' AND a.cod_modventa   = ' || EV_cod_modventa;
    LV_sSql := LV_sSql || ' AND a.cod_categoria  = ' || LV_cod_categoria;
    LV_sSql := LV_sSql || ' AND a.num_meses      = ' || LV_num_meses;
    LV_sSql := LV_sSql || ' AND a.cod_promedio   = ' || LV_cod_promedio;
    LV_sSql := LV_sSql || ' AND a.cod_antiguedad = ' || LV_cod_antiguedad;

    SELECT a.PRC_VENTA  INTO SV_precio_venta FROM al_precios_venta a,al_series b
    WHERE b.num_serie = EV_num_serie
        AND a.fec_hasta>SYSDATE
        AND b.tip_stock      = a.tip_stock
        AND b.cod_articulo   = a.cod_articulo
        AND b.cod_uso        = a.cod_uso
        AND a.cod_modventa   = EV_cod_modventa
        AND a.cod_categoria  = LV_cod_categoria
        AND a.num_meses      = LV_num_meses
        AND a.cod_promedio   = LV_cod_promedio
        AND a.cod_antiguedad = LV_cod_antiguedad
        AND rownum = 1;

EXCEPTION
         WHEN OTHERS THEN
           SN_cod_retorno  := -1;
           SV_mens_retorno:= 'No existe precio de venta.';
           LV_des_error := SUBSTR('PV_RecPrecioVenta_PR(...); - ' || SQLERRM,1,CN_largoerrtec);
           SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, '1.0', USER, 'Pv_Actcambios_Ofvirtual_Pg.PV_RecPrecioVenta_PR', LV_sSql, SQLCODE, LV_des_error);
END PV_RecPrecioVenta_PR;

----------------------------------------------------------------------------------------
--INI INC 160153 GUA JRCH 28-12-2010
PROCEDURE PV_UP_CARGOINME_EQUIP_PR(EV_num_serie        IN   al_series.NUM_SERIE%type,
                                   EV_num_abonado      IN   GA_ABOCEL.NUM_ABONADO%TYPE,
                                   SN_cod_retorno      OUT  NOCOPY     ge_errores_pg.CodError,
                                   SV_mens_retorno     OUT  NOCOPY     ge_errores_pg.MsgError,
                                   SN_num_evento       OUT  NOCOPY     ge_errores_pg.Evento
                                  )
IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_UP_CARGOINME_EQUIP_PR"
       Lenguaje="PL/SQL"
       Fecha="21-12-2010"
       Versión="La del package"
       Diseñador=""
       Programador="ORLANDO CABEZAS B "
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="EV_num_serie " Tipo="numerico">numero de serie  </param>>
             <param nom="EV_num_abonado  " Tipo="numerico">numero de abonado </param>>
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

  LV_des_error           ge_errores_pg.DesEvent;
  LV_sSql                ge_errores_pg.vQuery;
  LN_COD_PLANSERV        GA_aBOCEL.COD_PLANSERV%TYPE;
  LV_COD_CONCEPTO        GA_ACTUASERV.COD_CONCEPTO%TYPE;
  ERROR_EJECUCION        EXCEPTION;


 BEGIN
   sn_cod_retorno  := 0;
   sv_mens_retorno := NULL;
   sn_num_evento  := 0;

   LV_sSql := 'UPDATE GE_CARGOS ';
   LV_sSql := LV_sSql || ' SET NUM_SERIE = '||EV_num_serie;
   LV_sSql := LV_sSql || ' WHERE COD_CONCEPTO IN (SELECT cod_CONCEPTOART FROM AL_ARTICULOS ';
   LV_sSql := LV_sSql || ' WHERE COD_ARTICULO IN (SELECT  COD_ARTICULO ';
   LV_sSql := LV_sSql || ' FROM GA_EQUIPABOSER ';
   LV_sSql := LV_sSql || ' WHERE NUM_ABONADO = '||EV_num_abonado;
   LV_sSql := LV_sSql || ' AND TIP_TERMINAL=''T'' ';
   LV_sSql := LV_sSql || ' AND FEC_ALTA IN (SELECT MAX(FEC_ALTA) ';
   LV_sSql := LV_sSql || ' FROM GA_EQUIPABOSER ';
   LV_sSql := LV_sSql || ' WHERE NUM_ABONADO = '||EV_num_abonado;
   LV_sSql := LV_sSql || ' AND TIP_TERMINAL=''T'') ';
   LV_sSql := LV_sSql || ' ) ';
   LV_sSql := LV_sSql || ' ) ';
   LV_sSql := LV_sSql || ' AND NUM_ABONADO = '||EV_num_abonado;

   --ACTUALIZA CARGO DEL EQUIPO
   UPDATE GE_CARGOS
   SET NUM_SERIE = EV_num_serie
   WHERE COD_CONCEPTO IN (SELECT cod_CONCEPTOART FROM AL_ARTICULOS
                          WHERE COD_ARTICULO IN (SELECT  COD_ARTICULO
                                                 FROM GA_EQUIPABOSER
                                                 WHERE NUM_ABONADO = EV_num_abonado
                                                 AND TIP_TERMINAL='T'
                                                 AND FEC_ALTA IN (SELECT MAX(FEC_ALTA)
                                                 FROM GA_EQUIPABOSER
                                                 WHERE NUM_ABONADO = EV_num_abonado
                                                 AND TIP_TERMINAL='T')
                                                 )
                        )
  AND NUM_ABONADO = EV_num_abonado;

  LV_sSql := 'SELECT PLANSERV INTO  LN_COD_PLANSERV ';
  LV_sSql := LV_sSql || ' FROM( ';
  LV_sSql := LV_sSql || ' SELECT  COD_PLANSERV PLANSERV ';
  LV_sSql := LV_sSql || ' FROM  GA_ABOCEL ';
  LV_sSql := LV_sSql || ' WHERE  NUM_ABONADO = '||EV_num_abonado;
  LV_sSql := LV_sSql || ' UNION ';
  LV_sSql := LV_sSql || ' SELECT  COD_PLANSERV PLANSERV ';
  LV_sSql := LV_sSql || ' FROM  GA_ABOAMIST ';
  LV_sSql := LV_sSql || ' WHERE  NUM_ABONADO = '||EV_num_abonado ||')';

  SELECT PLANSERV INTO  LN_COD_PLANSERV
  FROM(
  SELECT  COD_PLANSERV PLANSERV
  FROM  GA_ABOCEL
  WHERE  NUM_ABONADO = EV_num_abonado
  UNION
  SELECT  COD_PLANSERV PLANSERV
  FROM GA_ABOAMIST
  WHERE  NUM_ABONADO = EV_num_abonado) ;

  BEGIN

      LV_sSql := 'SELECT  A.COD_CONCEPTO INTO LV_COD_CONCEPTO ';
      LV_sSql := LV_sSql || ' FROM  GA_ACTUASERV A, GA_TARIFAS B,GA_SERVICIOS C,GE_MONEDAS D ';
      LV_sSql := LV_sSql || ' WHERE A.COD_PRODUCTO = 1 ';
      LV_sSql := LV_sSql || ' AND A.COD_ACTABO = ''CE'' ';
      LV_sSql := LV_sSql || ' AND A.COD_TIPSERV    = 1 ';
      LV_sSql := LV_sSql || ' AND B.COD_PRODUCTO   = A.COD_PRODUCTO ';
      LV_sSql := LV_sSql || ' AND B.COD_ACTABO     = A.COD_ACTABO ';
      LV_sSql := LV_sSql || ' AND B.COD_TIPSERV    = A.COD_TIPSERV ';
      LV_sSql := LV_sSql || ' AND B.COD_SERVICIO   = A.COD_SERVICIO ';
      LV_sSql := LV_sSql || ' AND TO_NUMBER(TRIM(B.COD_PLANSERV)) = '||TO_NUMBER(LN_COD_PLANSERV);
      LV_sSql := LV_sSql || ' AND SYSDATE BETWEEN B.FEC_DESDE AND NVL(B.FEC_HASTA, SYSDATE) ';
      LV_sSql := LV_sSql || ' AND C.COD_PRODUCTO   = A.COD_PRODUCTO ';
      LV_sSql := LV_sSql || ' AND C.COD_SERVICIO   = A.COD_SERVICIO ';
      LV_sSql := LV_sSql || ' AND D.COD_MONEDA     = B.COD_MONEDA ';

      SELECT  A.COD_CONCEPTO INTO LV_COD_CONCEPTO
      FROM  GA_ACTUASERV A, GA_TARIFAS B,GA_SERVICIOS C,GE_MONEDAS D
      WHERE A.COD_PRODUCTO = 1
      AND A.COD_ACTABO     = 'CE'
      AND A.COD_TIPSERV    = 1
      AND B.COD_PRODUCTO   = A.COD_PRODUCTO
      AND B.COD_ACTABO     = A.COD_ACTABO
      AND B.COD_TIPSERV    = A.COD_TIPSERV
      AND B.COD_SERVICIO   = A.COD_SERVICIO
      AND TO_NUMBER(TRIM(B.COD_PLANSERV))   = TO_NUMBER(LN_COD_PLANSERV)
      AND SYSDATE BETWEEN B.FEC_DESDE AND NVL(B.FEC_HASTA, SYSDATE)
      AND C.COD_PRODUCTO   = A.COD_PRODUCTO
      AND C.COD_SERVICIO   = A.COD_SERVICIO
      AND D.COD_MONEDA     = B.COD_MONEDA;

  EXCEPTION
          WHEN NO_DATA_FOUND THEN
             LV_COD_CONCEPTO:=0;
  END;

   LV_sSql := 'UPDATE GE_CARGOS ';
   LV_sSql := LV_sSql || ' SET NUM_SERIE = '||EV_num_serie;
   LV_sSql := LV_sSql || ' WHERE NUM_ABONADO = '||EV_num_abonado;
   LV_sSql := LV_sSql || ' AND COD_CONCEPTO = '||LV_COD_CONCEPTO;
   LV_sSql := LV_sSql || ' AND FEC_ALTA IN (SELECT MAX(FEC_ALTA) ';
   LV_sSql := LV_sSql || ' FROM GE_CARGOS ';
   LV_sSql := LV_sSql || ' WHERE NUM_ABONADO = '||EV_num_abonado;
   LV_sSql := LV_sSql || ' AND COD_CONCEPTO = '||LV_COD_CONCEPTO;
   LV_sSql := LV_sSql || ' ) ';

  UPDATE GE_CARGOS
  SET NUM_SERIE = EV_num_serie
  WHERE NUM_ABONADO = EV_num_abonado
  AND COD_CONCEPTO = LV_COD_CONCEPTO
  AND FEC_ALTA IN (SELECT MAX(FEC_ALTA)
                   FROM GE_CARGOS
                   WHERE NUM_ABONADO = EV_num_abonado
                   AND COD_CONCEPTO = LV_COD_CONCEPTO
                   );


EXCEPTION
 WHEN OTHERS THEN
       SN_cod_retorno  := 2890; --Error al intentar actualizar serie
       SV_mens_retorno:= 'No es posible actualizar la serie en tabla de cargos.';
       LV_des_error   := 'PV_UP_CARGOINME_EQUIP_PR('||TO_CHAR( EV_num_abonado)||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, '1.1', USER, 'PV_ACTCAMBIOS_OFVIRTUAL_PG.PV_UP_CARGOINME_EQUIP_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_UP_CARGOINME_EQUIP_PR;
--FIN INC 160153 GUA JRCH 28-12-2010



PROCEDURE PV_movi_equiposimcard_PR (  EN_num_serie        IN   al_series.NUM_SERIE%type,
                                      EN_NUM_VENTA        IN   GA_ABOCEL.NUM_VENTA%TYPE,
                                      EN_NUM_ABONADO      IN   GA_ABOCEL.NUM_ABONADO%TYPE,
                                      SN_cod_retorno      OUT  NOCOPY     ge_errores_pg.CodError,
                                      SV_mens_retorno     OUT  NOCOPY     ge_errores_pg.MsgError,
                                      SN_num_evento       OUT  NOCOPY     ge_errores_pg.Evento
                                 )
IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_movi_equiposimcard_PR"
       Lenguaje="PL/SQL"
       Fecha="21-12-2010"
       Versión="La del package"
       Diseñador=""
       Programador="ORLANDO CABEZAS B "
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="EN_num_serie " Tipo="numerico">numero de serie  </param>>
             <param nom="EN_NUM_VENTA" Tipo="numerico">numero de venta </param>>
             <param nom="EN_NUM_ABONADO  " Tipo="numerico">numero de abonado </param>>
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
    LV_des_error                  ge_errores_pg.DesEvent;
  LV_sSql                       ge_errores_pg.vQuery;
  LV_NUM_MOVI                   AL_MOVIMIENTOS.NUM_MOVIMIENTO%TYPE;
  ERROR_EJECUCION               EXCEPTION;

   CURSOR C1 IS
   SELECT NUM_MOVIMIENTO
   FROM AL_MOVIMIENTOS
   WHERE NUM_SERIE= EN_num_serie AND tip_movimiento =3;

 BEGIN
   sn_cod_retorno  := 0;
   sv_mens_retorno := NULL;
   sn_num_evento  := 0;


   IF TRIM(EN_num_serie) <> '' OR TRIM(EN_num_serie) IS NOT NULL THEN


         OPEN C1;
           LOOP
              FETCH C1 INTO LV_NUM_MOVI;
                  EXIT WHEN C1%NOTFOUND;

                     UPDATE al_movimientos a
                     SET a.num_transaccion  = EN_NUM_VENTA
                     WHERE a.num_movimiento = LV_NUM_MOVI
                     AND a.tip_movimiento       = 3
                     AND nvl(a.NUM_TRANSACCION,0) = 0
                     AND a.NUM_SERIE        = EN_num_serie;

           END LOOP;
           CLOSE C1;
   END IF;


EXCEPTION
 WHEN ERROR_EJECUCION THEN
    LV_des_error   := 'PV_ACTCAMBIOS_OFVIRTUAL_PG.PV_movi_equiposimcard_PR('||TO_CHAR( EN_NUM_ABONADO)||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, '1.0', USER, 'PV_ACTCAMBIOS_OFVIRTUAL_PG.PV_movi_equiposimcard_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
 WHEN NO_DATA_FOUND THEN
       SN_cod_retorno := 149;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := ' PV_movi_equiposimcard_PR('||TO_CHAR( EN_NUM_ABONADO)||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, '1.0', USER, 'PV_ACTCAMBIOS_OFVIRTUAL_PG.PV_movi_equiposimcard_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN OTHERS THEN
       SN_cod_retorno := 156;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := 'PV_movi_equiposimcard_PR('||TO_CHAR( EN_NUM_ABONADO)|| SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, '1.0', USER, 'PV_ACTCAMBIOS_OFVIRTUAL_PG.PV_movi_equiposimcard_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_movi_equiposimcard_PR;


END Pv_Actcambios_Ofvirtual_Pg;
/
