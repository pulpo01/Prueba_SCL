CREATE OR REPLACE PACKAGE BODY ICC_movimiento_i_PG
AS
PROCEDURE ICC_agregar_PR(EN_num_movimiento IN NUMBER,
                         EN_num_abonado    IN NUMBER,
                         EV_cod_modulo     IN VARCHAR2,
                         EN_cod_estado     IN NUMBER,
                         EN_cod_actuacion  IN NUMBER,
                         EV_nom_usuarora   IN VARCHAR2,
                         ED_fec_ingreso    IN DATE,
                         EN_cod_central    IN NUMBER,
                         EN_num_celular    IN NUMBER,
                         EV_num_serie      IN VARCHAR2,
                         EN_num_movpos     IN NUMBER,
                         EN_num_movant     IN NUMBER,
                         EV_tip_terminal   IN VARCHAR2,
                         EV_cod_actabo     IN VARCHAR2,
                         EV_num_min        IN VARCHAR2,
                         EV_cod_servicios  IN VARCHAR2,
                         EV_tip_tecnologia IN VARCHAR2,
                         EV_imsi           IN VARCHAR2,
                         EV_imei           IN VARCHAR2,
                         EV_icc            IN VARCHAR2,
                         SN_coderror       OUT NOCOPY NUMBER,
                         SV_msgerror       OUT NOCOPY VARCHAR2)
AS
/*
<Documentación TipoDoc = "procedure">
<Elemento Nombre = "ICC_agregar_PR" Lenguaje="PL/SQL" Fecha="30/11/2004" Versión="1.0.0" Diseñador="" Programador="vladimir maureira" Ambiente="DEIMOS">
<Retorno>NA</Retorno>
<Descripción>Ingresar datos ICC_MOVIMIENTO</Descripción>
<Parámetros>
<Entrada>
<param nom="EN_num_movimiento" Tipo="NUMBER">numero movimiento</param>
<param nom="EN_num_abonado   " Tipo="NUMBER">numero abonado</param>
<param nom="EV_cod_modulo    " Tipo="VARCHAR2">codigo modulo</param>
<param nom="EN_cod_estado    " Tipo="NUMBER">codigo estado</param>
<param nom="EN_cod_actuacion " Tipo="NUMBER">codigo actuacion</param>
<param nom="EV_nom_usuarora  " Tipo="VARCHAR2">user</param>
<param nom="ED_fec_ingreso   " Tipo="NUMBER">fecha</param>
<param nom="EN_cod_central   " Tipo="NUMBER">central</param>
<param nom="EN_num_celular   " Tipo="NUMBER">numero central</param>
<param nom="EV_num_serie     " Tipo="VARCHAR2">numero serie</param>
<param nom="EN_num_movpos    " Tipo="NUMBER">numero movimiento</param>
<param nom="EN_num_movant    " Tipo="NUMBER">numero movimiento</param>
<param nom="EV_tip_terminal  " Tipo="VARCHAR2">terminal</param>
<param nom="EV_cod_actabo    " Tipo="VARCHAR2">codigo actabo</param>
<param nom="EV_num_min       " Tipo="VARCHAR2">num min</param>
<param nom="EV_cod_servicios " Tipo="VARCHAR2">codigo servicio</param>
<param nom="EV_tip_tecnologia" Tipo="VARCHAR2">tecnologia</param>
<param nom="EV_imsi          " Tipo="VARCHAR2">imsi</param>
<param nom="EV_imei          " Tipo="VARCHAR2">imei</param>
<param nom="EV_icc           " Tipo="VARCHAR2">icc</param>
</Entrada>
<Salida>
<param nom="SN_coderror" Tipo="NUMBER">0 Proceso realizado correctamente,4 En el proceso se produjo un error</param>
<param nom="SV_msgerror" Tipo="VARCHAR2">mensaje del error</param>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
BEGIN
     SN_coderror := 0;
     SV_msgerror := '';

       BEGIN
            INSERT INTO ICC_MOVIMIENTO
                    (num_movimiento,num_abonado,cod_modulo,cod_estado,
                    cod_actuacion,nom_usuarora,fec_ingreso,cod_central,
                    num_celular,num_serie,num_movpos,num_movant,tip_terminal,
                    cod_actabo,num_min,cod_servicios,tip_tecnologia,imsi,imei,icc)
            VALUES
                    (EN_num_movimiento,EN_num_abonado,EV_cod_modulo,EN_cod_estado,
                    EN_cod_actuacion,EV_nom_usuarora,ED_fec_ingreso,EN_cod_central,
                    EN_num_celular,EV_num_serie,EN_num_movpos,EN_num_movant,
                    EV_tip_terminal,EV_cod_actabo,EV_num_min,EV_cod_servicios,
                    EV_tip_tecnologia,EV_imsi,EV_imei,EV_icc);

            EXCEPTION
             WHEN OTHERS THEN
                SN_coderror := 4;
                SV_msgerror := 'ICC_movimiento_i_PG.ICC_AGREGAR_PR al insertar en tabla ICC_MOVIMIENTO SQLERRM: ' || SUBSTR(SQLERRM,1,150);
      END;
END ICC_agregar_PR;

PROCEDURE ICC_AGREGAR_PR(
  EN_num_movimiento    IN icc_movimiento.num_movimiento%TYPE,
  EN_num_abonado       IN icc_movimiento.num_abonado%TYPE,
  EN_cod_estado        IN icc_movimiento.cod_estado%TYPE,
  EV_cod_actabo        IN icc_movimiento.cod_actabo%TYPE,
  EV_cod_modulo        IN icc_movimiento.cod_modulo%TYPE,
  EN_num_intentos      IN icc_movimiento.num_intentos%TYPE,
  EN_cod_central_nue   IN icc_movimiento.cod_central_nue%TYPE,
  EV_des_respuesta     IN icc_movimiento.des_respuesta%TYPE,
  EN_cod_actuacion     IN icc_movimiento.cod_actuacion%TYPE,
  EV_nom_usuarora      IN icc_movimiento.nom_usuarora%TYPE,
  ED_fec_ingreso       IN icc_movimiento.fec_ingreso%TYPE,
  EV_tip_terminal      IN icc_movimiento.tip_terminal%TYPE,
  EN_cod_central       IN icc_movimiento.cod_central%TYPE,
  ED_fec_lectura       IN icc_movimiento.fec_lectura%TYPE,
  EN_ind_bloqueo       IN icc_movimiento.ind_bloqueo%TYPE,
  ED_fec_ejecucion     IN icc_movimiento.fec_ejecucion%TYPE,
  EV_tip_terminal_nue  IN icc_movimiento.tip_terminal_nue%TYPE,
  EN_num_movant        IN icc_movimiento.num_movant%TYPE,
  EN_num_celular       IN icc_movimiento.num_celular%TYPE,
  EN_num_movpos        IN icc_movimiento.num_movpos%TYPE,
  EV_num_serie         IN icc_movimiento.num_serie%TYPE,
  EV_num_personal      IN icc_movimiento.num_personal%TYPE,
  EV_num_celular_nue   IN icc_movimiento.num_celular_nue%TYPE,
  EV_num_serie_nue     IN icc_movimiento.num_serie_nue%TYPE,
  EV_num_personal_nue  IN icc_movimiento.num_personal_nue%TYPE,
  EV_num_msnb          IN icc_movimiento.num_msnb%TYPE,
  EV_num_msnb_nue      IN icc_movimiento.num_msnb_nue%TYPE,
  EV_cod_suspreha      IN icc_movimiento.cod_suspreha%TYPE,
  EV_cod_servicios     IN icc_movimiento.cod_servicios%TYPE,
  EV_num_min           IN icc_movimiento.num_min%TYPE,
  EV_num_min_nue       IN icc_movimiento.num_min_nue%TYPE,
  EC_sta               IN icc_movimiento.sta%TYPE,
  EN_cod_mensaje       IN icc_movimiento.cod_mensaje%TYPE,
  EV_param1_mens       IN icc_movimiento.param1_mens%TYPE,
  EV_param2_mens       IN icc_movimiento.param2_mens%TYPE,
  EV_param3_mens       IN icc_movimiento.param3_mens%TYPE,
  EV_plan              IN icc_movimiento.plan%TYPE,
  EN_carga             IN icc_movimiento.carga%TYPE,
  EN_valor_plan        IN icc_movimiento.valor_plan%TYPE,
  EV_pin               IN icc_movimiento.pin%TYPE,
  ED_fec_expira        IN icc_movimiento.fec_expira%TYPE,
  EV_des_mensaje       IN icc_movimiento.des_mensaje%TYPE,
  EV_cod_pin           IN icc_movimiento.cod_pin%TYPE,
  EV_cod_idioma        IN icc_movimiento.cod_idioma%TYPE,
  EN_cod_enrutamiento  IN icc_movimiento.cod_enrutamiento%TYPE,
  EN_tip_enrutamiento  IN icc_movimiento.tip_enrutamiento%TYPE,
  EV_des_origen_pin    IN icc_movimiento.des_origen_pin%TYPE,
  EN_num_lote_pin      IN icc_movimiento.num_lote_pin%TYPE,
  EV_num_serie_pin     IN icc_movimiento.num_serie_pin%TYPE,
  EV_tip_tecnologia    IN icc_movimiento.tip_tecnologia%TYPE,
  EV_imsi              IN icc_movimiento.imsi%TYPE,
  EV_imsi_nue          IN icc_movimiento.imsi_nue%TYPE,
  EV_imei              IN icc_movimiento.imei%TYPE,
  EV_imei_nue          IN icc_movimiento.imei_nue%TYPE,
  EV_icc               IN icc_movimiento.icc%TYPE,
  EV_icc_nue           IN icc_movimiento.icc_nue%TYPE,
  EV_cod_prog              IN VARCHAR2,
  SN_p_correlativo    OUT NOCOPY  NUMBER,
  SN_p_filasafectas   OUT NOCOPY  NUMBER,
  SN_p_retornora      OUT NOCOPY  NUMBER,
  SN_p_nroevento      OUT NOCOPY  NUMBER,
  SV_p_vcod_retorno   OUT NOCOPY VARCHAR2
  )

IS
/*
<Documentación
TipoDoc = "Package">
 <Elemento
    Nombre = "AGREGAR_PR"
    Lenguaje="PL/SQL"
    Fecha="06-07-2006"
    Versión="1.0"
    Diseñador="Patricio Gallegos"
    Programador="Patricio Gallegos"
    Ambiente Desarrollo="BD">
    <Retorno>NA</Retorno>
    <Descripción>Prodedimiento que permite insertar registro en la tabla icc_movimiento>
    <Parámetros>
       <Entrada>
                        <param nom="EN_num_movimiento   " Tipo="NUMBER">Número movimiento</param>
                        <param nom="EN_num_abonado      " Tipo="NUMBER">Número abonado</param>
                        <param nom="EN_cod_estado        " Tipo="NUMBER">Estado</param>
                        <param nom="EV_cod_actabo       " Tipo="VARCHAR2">Código actuación</param>
                        <param nom="EV_cod_modulo       " Tipo="VARCHAR2">Codigo modulo</param>
                        <param nom="EN_num_intentos      " Tipo="NUMBER">N° intentos</param>
                        <param nom="EN_cod_central_nue   " Tipo="NUMBER">codigo central</param>
                        <param nom="EV_des_respuesta     " Tipo="VARCHAR2">respuesta</param>
                        <param nom="EN_cod_actuacion     " Tipo="VARCHAR2">actuación</param>
                        <param nom="EV_nom_usuarora      " Tipo="VARCHAR2">usuario</param>
                        <param nom="ED_fec_ingreso       " Tipo="VARCHAR2">fecha ingreso</param>
                        <param nom="EV_tip_terminal      " Tipo="VARCHAR2">Tipo terminal</param>
                        <param nom="EN_cod_central       " Tipo="VARCHAR2">codigo central</param>
                        <param nom="ED_fec_lectura       " Tipo="VARCHAR2">Fecha lectura</param>
                        <param nom="EN_ind_bloqueo       " Tipo="VARCHAR2">Indicador bloqueo</param>
                        <param nom="ED_fec_ejecucion     " Tipo="VARCHAR2">Fecha ejecución</param>
                        <param nom="EV_tip_terminal_nue  " Tipo="VARCHAR2">Terminal nuevo</param>
                        <param nom="EN_num_movant        " Tipo="NUMBER">Movimineto anterior</param>
                        <param nom="EN_num_celular       " Tipo="VARCHAR2">N° celular</param>
                        <param nom="EN_num_movpos        " Tipo="NUMBER">Movimineto posterior</param>
                        <param nom="EV_num_serie         " Tipo="VARCHAR2">N° serie</param>
                        <param nom="EV_num_personal      " Tipo="VARCHAR2">N° personal</param>
                        <param nom="EV_num_celular_nue   " Tipo="NUMBER">N° celular nuevo</param>
                        <param nom="EV_num_serie_nue     " Tipo="VARCHAR2">N° serie nueva</param>
                        <param nom="EV_num_personal_nue  " Tipo="VARCHAR2">N° personal nuevo</param>
                        <param nom="EV_num_msnb          " Tipo="VARCHAR2">N° MSNB</param>
                        <param nom="EV_num_msnb_nue      " Tipo="VARCHAR2">N° MSNB nuevo</param>
                        <param nom="EV_cod_suspreha      " Tipo="VARCHAR2">Código suspención /rehabilitación</param>
                        <param nom="EV_cod_servicios     " Tipo="VARCHAR2">codigo servicios</param>
                        <param nom="EV_num_min           " Tipo="VARCHAR2">N° MIN</param>
                        <param nom="EV_num_min_nue       " Tipo="VARCHAR2">N° MIN nuevo</param>
                        <param nom="EC_sta               " Tipo="VARCHAR2">STA</param>
                        <param nom="EN_cod_mensaje       " Tipo="VARCHAR2">codigo mensaje</param>
                        <param nom="EV_param1_mens       " Tipo="VARCHAR2">Parametro mensaje</param>
                        <param nom="EV_param2_mens       " Tipo="VARCHAR2">Parametro mensaje</param>
                        <param nom="EV_param3_mens       " Tipo="VARCHAR2">Parametro mensaje</param>
                        <param nom="EV_plan              " Tipo="VARCHAR2">plan</param>
                        <param nom="EN_carga             " Tipo="VARCHAR2">carga</param>
                        <param nom="EN_valor_plan        " Tipo="VARCHAR2">valor plan</param>
                        <param nom="EV_pin               " Tipo="VARCHAR2">Pin</param>
                        <param nom="ED_fec_expira        " Tipo="VARCHAR2">fecha expiracion</param>
                        <param nom="EV_des_mensaje       " Tipo="VARCHAR2">Descripción mensaje</param>
                        <param nom="EV_cod_pin           " Tipo="VARCHAR2">codigo pin</param>
                        <param nom="EV_cod_idioma        " Tipo="VARCHAR2">codigo idioma</param>
                        <param nom="EN_cod_enrutamiento  " Tipo="VARCHAR2">codigo enrutamiento</param>
                        <param nom="EN_tip_enrutamiento  " Tipo="VARCHAR2">tipo enrutamiento</param>
                        <param nom="EV_des_origen_pin    " Tipo="VARCHAR2">descripcion origen pin</param>
                        <param nom="EN_num_lote_pin      " Tipo="VARCHAR2">N° lote</param>
                        <param nom="EV_num_serie_pin     " Tipo="VARCHAR2">N° serie pin</param>
                        <param nom="EV_tip_tecnologia    " Tipo="VARCHAR2">Tecnologia</param>
                        <param nom="EV_imsi              " Tipo="VARCHAR2">IMSI</param>
                        <param nom="EV_imsi_nue          " Tipo="VARCHAR2">IMSI nuevo</param>
                        <param nom="EV_imei              " Tipo="VARCHAR2">IMEI</param>
                        <param nom="EV_imei_nue          " Tipo="VARCHAR2">IMEI nuevo</param>
                        <param nom="EV_icc               " Tipo="VARCHAR2">ICC</param>
                        <param nom="EV_icc_nue           " Tipo="VARCHAR2">ICC nuevo</param>
                </Entrada>
           <Salida>
                   <param nom="SN_p_filasafectas" Tipo="NUMBER">Número de filas borradas</param>
                   <param nom="SN_p_retornora" Tipo="NUMBER">Código error oracle </param>
                   <param nom="SN_p_nroevento" Tipo="NUMBER">Número de evento</param>
                   <param nom="SV_p_vcod_retorno" Tipo="VARCHAR">código retorno de error</param>
           </Salida>

    </Parámetros>
 </Elemento>
</Documentación>
*/



  CV_Version                      CONSTANT VARCHAR2(3)   := '1.0';

  CV_PROCEDURE             CONSTANT VARCHAR2(45)  := 'PV_ICC_MOVIMIENTO_I_PG.PV_AGREGAR_PR';
  CV_0                     CONSTANT VARCHAR2(1)   := '0';
  CV_4                     CONSTANT VARCHAR2(1)   := '4';

  CN_0                     CONSTANT NUMBER(1)  := 0;
  CV_DES_ERROR_V1                  CONSTANT VARCHAR2(60) := 'Error el insertar registro en la tabla ICC_MOVIMIENTO.';

  LV_v_verror                      VARCHAR2(255);

  CN_20010                 CONSTANT NUMBER (6)     := -20010;

BEGIN

         IF EN_num_movimiento IS NULL THEN
                SELECT ICC_SEQ_NUMMOV.NEXTVAL INTO SN_p_correlativo FROM dual;
         ELSE
                SN_p_correlativo := EN_num_movimiento;
         END IF;

   INSERT INTO icc_movimiento(
                  num_movimiento,
                  num_abonado,
                  cod_estado,
                  cod_actabo,
                  cod_modulo,
                  num_intentos,
                  cod_central_nue,
                  des_respuesta,
                  cod_actuacion,
                  nom_usuarora,
                  fec_ingreso,
                  tip_terminal,
                  cod_central,
                  fec_lectura,
                  ind_bloqueo,
                  fec_ejecucion,
                  tip_terminal_nue,
                  num_movant,
                  num_celular,
                  num_movpos,
                  num_serie,
                  num_personal,
                  num_celular_nue,
                  num_serie_nue,
                  num_personal_nue,
                  num_msnb,
                  num_msnb_nue,
                  cod_suspreha,
                  cod_servicios,
                  num_min,
                  num_min_nue,
                  sta,
                  cod_mensaje,
                  param1_mens,
                  param2_mens,
                  param3_mens,
                  plan,
                  carga,
                  valor_plan,
                  pin,
                  fec_expira,
                  des_mensaje,
                  cod_pin,
                  cod_idioma,
                  cod_enrutamiento,
                  tip_enrutamiento,
                  des_origen_pin,
                  num_lote_pin,
                  num_serie_pin,
                  tip_tecnologia,
                  imsi,
                  imsi_nue,
                  imei,
                  imei_nue,
                  icc,
                  icc_nue
   ) VALUES(
                  SN_p_correlativo,--EN_num_movimiento,
                  EN_num_abonado,
                  EN_cod_estado,
                  EV_cod_actabo,
                  EV_cod_modulo,
                  EN_num_intentos,
                  EN_cod_central_nue,
                  EV_des_respuesta,
                  EN_cod_actuacion,
                  EV_nom_usuarora,
                  ED_fec_ingreso,
                  EV_tip_terminal,
                  EN_cod_central,
                  ED_fec_lectura,
                  EN_ind_bloqueo,
                  ED_fec_ejecucion,
                  EV_tip_terminal_nue,
                  EN_num_movant,
                  EN_num_celular,
                  EN_num_movpos,
                  EV_num_serie,
                  EV_num_personal,
                  EV_num_celular_nue,
                  EV_num_serie_nue,
                  EV_num_personal_nue,
                  EV_num_msnb,
                  EV_num_msnb_nue,
                  EV_cod_suspreha,
                  EV_cod_servicios,
                  EV_num_min,
                  EV_num_min_nue,
                  EC_sta,
                  EN_cod_mensaje,
                  EV_param1_mens,
                  EV_param2_mens,
                  EV_param3_mens,
                  EV_plan,
                  EN_carga,
                  EN_valor_plan,
                  EV_pin,
                  ED_fec_expira,
                  EV_des_mensaje,
                  EV_cod_pin,
                  EV_cod_idioma,
                  EN_cod_enrutamiento,
                  EN_tip_enrutamiento,
                  EV_des_origen_pin,
                  EN_num_lote_pin,
                  EV_num_serie_pin,
                  EV_tip_tecnologia,
                  EV_imsi,
                  EV_imsi_nue,
                  EV_imei,
                  EV_imei_nue,
                  EV_icc,
                  EV_icc_nue
   );

         SN_p_filasafectas := SQL%ROWCOUNT;
         SN_p_retornora    := SQLCODE;
         SV_p_vcod_retorno := CV_0;

EXCEPTION
                  WHEN OTHERS THEN

                SN_p_nroevento := GE_ERRORES_PG.GRABARPL(CN_0,
                                                                                                EV_cod_prog,
                                                                                                CV_DES_ERROR_V1,
                                                                                                CV_Version,
                                                                                                User,
                                                        CV_PROCEDURE,
                                                                                                NULL,
                                                                                                SQLCODE,
                                                                                                SQLERRM);

                LV_v_verror := SUBSTR(CV_DES_ERROR_V1 || SQLERRM,1,255);
                SN_p_retornora    := SQLCODE;
                SV_p_vcod_retorno := CV_4;

END ICC_AGREGAR_PR;

END ICC_movimiento_i_PG;
/
SHOW ERRORS
