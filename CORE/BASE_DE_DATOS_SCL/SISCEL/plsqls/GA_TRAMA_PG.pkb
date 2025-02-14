CREATE OR REPLACE PACKAGE BODY          "GA_TRAMA_PG"  AS

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ga_coderror_fn(EV_cod_error IN ge_errores_td.cod_msgerror%TYPE)
RETURN ge_errores_td.cod_msgerror%TYPE IS
/*
<Documentacion
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "ga_coderror_fn"
      Fecha modificacion=""
      Fecha creacion="07-11-2005"
      Constructor="Andrés Osorio"
      Modificador=""
      Ambiente Desarrollo="BD">
      <Retorno>CARACTER</Retorno>
      <Descripcion>Funcion que retorna el codigo de error filtrado a 3 caracteres</Descripcion>
      <Parametros>
         <Entrada>
            <param nom="EV_cod_error"  Tipo="NUMERICO">Codigo de error a evaluar</param>
         </Entrada>
         <Salida>
            <param nom="" Tipo="Caracter">Codigo de error de largo 3</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
LN_largo ge_errores_td.cod_msgerror%TYPE;
LV_coderror ge_errores_td.cod_msgerror%TYPE;
BEGIN
        LV_coderror := SUBSTR(EV_cod_error,1,3);
         LN_largo := LENGTH(LV_coderror);

         IF (LN_largo = NULL) THEN
                RETURN 123;
         ELSIF (LN_largo = 1) THEN
                RETURN '00'||LV_coderror;
         ELSIF (LN_largo = 2) THEN
                RETURN '0'||LV_coderror;
         ELSE
                RETURN EV_cod_error;
         END IF;


END;



FUNCTION ga_gen_var_trama_fn (
   EV_variable       IN  VARCHAR2,
   EN_largo          IN  NUMBER,
   EV_caracter_trama IN  VARCHAR2
)
/*
<Documentacion
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "GA_GEN_VAR_TRAMA_FN"
      Fecha modificacion=""
      Fecha creacion="18-06-2005"
      Constructor="Carlos Navarro H. - Marcelo Godoy S."
      Modificador="
      Ambiente Desarrollo="BD">
      <Retorno>CARACTER</Retorno>
      <Descripcion>Servico de Tramas</Descripcion>
      <Parametros>
         <Entrada>
            <param nom="EV_variable"  Tipo="CARACTER"></param>
            <param nom="EN_largo"  Tipo="NUMERICO"></param>
            <param nom="EV_caracter_trama"  Tipo="CARACTER"></param>
         </Entrada>
         <Salida>
            <param nom="" Tipo=""></param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
RETURN VARCHAR2
AS
    V_var_entrada VARCHAR2(3000);
    VALOR NUMBER;
BEGIN

   IF EV_variable IS NULL THEN
      V_var_entrada := '';
   ELSE
      V_var_entrada := TRIM(EV_variable);
   END IF;


   IF LENGTH(V_var_entrada) > EN_largo  THEN
      RETURN SUBSTR(V_var_entrada,1,EN_largo);
   ELSIF NVL(LENGTH(V_var_entrada),0) = 0 THEN
      RETURN SUBSTR(LPAD(' ',EN_largo+1,EV_caracter_trama),1,EN_largo);
   ELSE
      RETURN LPAD(V_var_entrada, EN_largo ,EV_caracter_trama);
   END IF;

EXCEPTION

   WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-2000,'Error al generar variable trama');

END ga_gen_var_trama_fn;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION ga_consulta_segmentacion_fn (
   EV_trama_in       IN         VARCHAR2,
   SV_trama_out      OUT NOCOPY VARCHAR2,
   SN_cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
   SV_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
   SN_num_evento     OUT NOCOPY ge_errores_pg.Evento
)
/*
<Documentacion
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "GA_CONSULTA_SEGMENTACION_PR"
      Fecha modificacion=""
      Fecha creacion="18-06-2005"
      Constructor="Carlos Navarro H. - Marcelo Godoy S."
      Modificador="
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripcion>Servico de Trmas</Descripcion>
      <Parametros>
         <Entrada>
            <param nom="EV_trama_in"  Tipo="CARACTER">Trama de entrada</param>
         </Entrada>
         <Salida>
            <param nom="SV_trama_out" Tipo="CARACTER">Trama de salida</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
RETURN BOOLEAN
AS
   V_des_error      ge_errores_pg.DesEvent;
   sSql             ge_errores_pg.vQuery;
   N_num_celular      ga_abocel.num_celular%TYPE;

   N_num_abonado         NUMBER(8);
   V_nom_abocli              VARCHAR2(91);
   V_cod_perfil              ge_valores_cli.des_valor%TYPE;
   V_signo_saldo_cta     VARCHAR2(1);
   V_saldo_cta               VARCHAR2(10);
   V_saldo_30_dias           VARCHAR2(10);
   V_saldo_60_dias           VARCHAR2(10);
   V_saldo_90_dias           VARCHAR2(10);
   V_saldo_120_dias          VARCHAR2(10);
   V_cod_suspendido          VARCHAR2(1);
   V_valor_ult_pago      VARCHAR2(10);
   V_fecha_ult_pago          DATE;
   V_fecha_limite_pago   DATE;
   N_cod_cuenta              NUMBER(8);
   V_estado_servicio     VARCHAR2(2);
   V_cod_clave               VARCHAR2(7);
   V_cod_plantarif           VARCHAR2(3);
   V_fecha_corte                 DATE;
   /* Inicio modificacion by SAQL/Soporte 12/10/2006 - 34683 */
   /* N_cont_tasación        NUMBER(4); */
   N_cont_tasacion           NUMBER(4);
   /* Fin modificacion by SAQL/Soporte 12/10/2006 - 34683 */

   V_ind_servicios           VARCHAR2(10);
   N_cod_retorno                 NUMBER(3);
   V_mens_retorno                VARCHAR2(234);
   N_num_evento              NUMBER(9);
   V_des_plantarif       ta_plantarif.des_plantarif%TYPE;
   /* Inicio modificacion by SAQL/Soporte 12/10/2006 - 34683 */
   /*
   LN_VAL_MINTOTAL         NUMBER(8);
   LN_VAL_USADO        NUMBER(8);
   LN_VAL_DISPONIBLE   NUMBER(8);
   LN_USADO_BOLSA      NUMBER(8);
   LN_DISPONIBLE_BOLSA NUMBER(8);
   */
   LN_VAL_MINTOTAL         NUMBER;
   LN_VAL_USADO        NUMBER;
   LN_VAL_DISPONIBLE   NUMBER;
   LN_USADO_BOLSA      NUMBER;
   LN_DISPONIBLE_BOLSA NUMBER;

   LV_PLANX01              VARCHAR2(3);
   LV_PLANX02              VARCHAR2(3);
   LV_PLANX03              VARCHAR2(3);
   LV_PLANX04              VARCHAR2(3);
   LV_PLANX05              VARCHAR2(3);
   LV_PLANX06              VARCHAR2(3);
   LV_PLANX07              VARCHAR2(3);
   LV_PLANX08              VARCHAR2(3);
   LV_PLANX09              VARCHAR2(3);
   LV_PLANX10              VARCHAR2(3);
   LV_indicador            VARCHAR2(11);
   /* Inicio modificacion by SAQL/Soporte 14/03/2006 - RA-200603140913 */
   LV_CODCLIENTE        GE_CLIENTES.COD_CLIENTE%TYPE;
   /* Fin modificacion by SAQL/Soporte 14/03/2006 - RA-200603140913 */

   error_ejecucion EXCEPTION;
BEGIN
   SV_mens_retorno := '';
   SN_cod_retorno  := 0;
   SN_num_evento   := 0;

   N_num_celular := TO_NUMBER(SUBSTR(EV_trama_in,29,10));
   ga_segmentacion_pg.ga_consulta_segmentacion_pr (N_num_celular, N_num_abonado, V_nom_abocli, V_cod_perfil, V_signo_saldo_cta, V_saldo_cta, V_saldo_30_dias, V_saldo_60_dias, V_saldo_90_dias,
                                                                           /* Inicio modificacion by SAQL/Soporte 14/03/2006 - RA-200603140913 */
                                                                           /* V_saldo_120_dias, V_cod_suspendido, V_valor_ult_pago, V_fecha_ult_pago, V_fecha_limite_pago, N_cod_cuenta, V_estado_servicio, V_cod_clave, */
                                                                           V_saldo_120_dias, V_cod_suspendido, V_valor_ult_pago, V_fecha_ult_pago, V_fecha_limite_pago, LV_CODCLIENTE, V_estado_servicio, V_cod_clave,
                                                                           /* Fin modificacion by SAQL/Soporte 14/03/2006 - RA-200603140913 */
                                                                           /* Inicio modificacion by SAQL/Soporte 12/10/2006 - 34683 */
                                                                           /*        V_cod_plantarif, V_fecha_corte, N_cont_tasación, V_ind_servicios, V_des_plantarif,LN_VAL_MINTOTAL,LN_VAL_USADO,LN_VAL_DISPONIBLE, */
                                                                                   V_cod_plantarif, V_fecha_corte, N_cont_tasacion, V_ind_servicios, V_des_plantarif,LN_VAL_MINTOTAL,LN_VAL_USADO,LN_VAL_DISPONIBLE,
                                                                           /* Fin modificacion by SAQL/Soporte 12/10/2006 - 34683 */
                                                                                                   LN_USADO_BOLSA,LN_DISPONIBLE_BOLSA,LV_PLANX01,LV_PLANX02,LV_PLANX03,LV_PLANX04,LV_PLANX05,LV_PLANX06,LV_PLANX07,LV_PLANX08,LV_PLANX09,
                                                                                                   LV_PLANX10, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

   IF (LENGTH(LN_VAL_MINTOTAL) > 6) OR (LENGTH(LN_VAL_USADO) > 6) OR (LENGTH(LN_VAL_DISPONIBLE) > 6) THEN
          IF NOT ga_error_desborde_fn(LV_indicador,SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
                 LV_indicador := CV_DESACTIVADO;--'DESACTIVADO'
          END IF;

          IF (LV_indicador = CV_ACTIVADO ) THEN --' ACTIVADO'
                 SN_cod_retorno := 525;

         IF NOT  Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasIF;
         END  IF;

          END IF;
   END IF;


   IF SN_cod_retorno = 0 THEN
      SV_trama_out := '000'||SUBSTR(EV_trama_in,1,2)||CN_consecutivo||TO_CHAR(SYSDATE,'YYYYMMDDHHMMSS')||ga_gen_var_trama_fn(N_num_celular,10,0);

      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(N_num_abonado      ,  8,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(V_nom_abocli       , 91, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(V_cod_perfil       ,  5,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(V_signo_saldo_cta  ,  1, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(V_saldo_cta        , 10, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(V_saldo_30_dias    , 10, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(V_saldo_60_dias    , 10, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(V_saldo_90_dias    , 10, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(V_saldo_120_dias   , 10, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(V_cod_suspendido   ,  1, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO             ,  3, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(V_valor_ult_pago   , 10, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(TO_CHAR(V_fecha_ult_pago,'YYYYMMDD')   ,  8,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(TO_CHAR(V_fecha_limite_pago,'YYYYMMDD'),  8,   0);
      /* Inicio modificacion by SAQL/Soporte 14/03/2006 - RA-200603140913 */
      /* SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(N_cod_cuenta       ,  8,   0); */
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(LV_CODCLIENTE      ,  8,   0);
      /* Fin modificacion by SAQL/Soporte 14/03/2006 - RA-200603140913 */
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(V_estado_servicio  ,  2, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(V_cod_clave        ,  4,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(V_cod_plantarif    ,  3, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(TO_CHAR(V_fecha_corte,'YYYYMMDD'),  8,   0);
      /* Inicio modificacion by SAQL/Soporte 12/10/2006 - 34683 */
      /* SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(N_cont_tasación    ,  4,   0);*/
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(N_cont_tasacion    ,  4,   0);
      /* Fin modificacion by SAQL/Soporte 12/10/2006 - 34683 */

      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(V_ind_servicios    , 10, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO             , 10,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO             , 10,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO             , 10,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO             , 10,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO             ,234, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(LV_PLANX01         ,  3, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(LV_PLANX02         ,  3, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(LV_PLANX03         ,  3, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(LV_PLANX04         ,  3, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(LV_PLANX05         ,  3, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(LV_PLANX06         ,  3, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(LV_PLANX07         ,  3, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(LV_PLANX08         ,  3, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(LV_PLANX09         ,  3, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(LV_PLANX10         ,  3, ' ');
          SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(LN_VAL_USADO       ,  6,   0);
          SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(LN_VAL_DISPONIBLE  ,  6,   0);
          SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(LN_VAL_MINTOTAL    ,  6,   0);
          SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(LN_USADO_BOLSA     , 11,   0);
          SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(LN_DISPONIBLE_BOLSA, 11,   0);

   ELSE
      RAISE error_ejecucion;
   END IF;

   RETURN TRUE;

EXCEPTION

   WHEN error_ejecucion THEN
      V_des_error := 'ga_consulta_segmentacion_pr('||EV_trama_in||', '||SV_trama_out||'); - ' || SQLERRM;
      SN_num_evento := ge_errores_pg.grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.0', USER, 'ga_consulta_segmentacion_pr', sSql, SN_cod_retorno, V_des_error );
      SV_trama_out := ga_coderror_fn(SN_cod_retorno)
                                      ||SUBSTR(EV_trama_in,1,2)||CN_consecutivo||TO_CHAR(SYSDATE,'YYYYMMDDHHMMSS')||ga_gen_var_trama_fn(N_num_celular,10,0);
          SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  8,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO, 91, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  5,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  1, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO, 10, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO, 10, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO, 10, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO, 10, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO, 10, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  1, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  3, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO, 10, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  8,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  8,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  8,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  2, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  4,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  3, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  8,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  4,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO, 10, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO, 10,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO, 10,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO, 10,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO, 10,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(SV_mens_retorno,234, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  3, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  3, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  3, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  3, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  3, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  3, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  3, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  3, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  3, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  3, ' ');
      RETURN FALSE;

   WHEN OTHERS THEN
      SN_cod_retorno := 156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'ga_consulta_segmentacion_pr('||EV_trama_in||', '||SV_trama_out||'); - ' || SQLERRM;
      SN_num_evento := ge_errores_pg.grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.0', USER, 'ga_consulta_segmentacion_pr', sSql, SN_cod_retorno, V_des_error );
      SV_trama_out := ga_coderror_fn(SN_cod_retorno);
          SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  8,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO, 91, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  5,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  1, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO, 10, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO, 10, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO, 10, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO, 10, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO, 10, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  1, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  3, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO, 10, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  8,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  8,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  8,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  2, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  4,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  3, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  8,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  4,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO, 10, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO, 10,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO, 10,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO, 10,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO, 10,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(SV_mens_retorno,234, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  3, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  3, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  3, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  3, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  3, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  3, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  3, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  3, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  3, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  3, ' ');
      RETURN FALSE;

END ga_consulta_segmentacion_fn;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION ga_cobro_consulta_tasacion_fn (
   EV_trama_in      IN          VARCHAR2,
   SV_trama_out      OUT NOCOPY VARCHAR2,
   SN_cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
   SV_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
   SN_num_evento     OUT NOCOPY ge_errores_pg.Evento
)
/*
<Documentacion
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "GA_COBRO_CONSULTA_TASACION_PR"
      Fecha modificacion=""
      Fecha creacion="18-06-2005"
      Constructor="Carlos Navarro H. - Marcelo Godoy S."
      Modificador="
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripcion>Servico de Trmas</Descripcion>
      <Parametros>
         <Entrada>
            <param nom="EV_trama_in"  Tipo="CARACTER">Trama de entrada</param>
         </Entrada>
         <Salida>
            <param nom="SV_trama_out" Tipo="CARACTER">Trama de salida</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
RETURN BOOLEAN
AS
   V_datos_error    VARCHAR2(222);

   V_des_error      ge_errores_pg.DesEvent;
   sSql             ge_errores_pg.vQuery;
   N_num_celular      ga_abocel.num_celular%TYPE;
   error_ejecucion EXCEPTION;
BEGIN
   SV_mens_retorno := '';
   SN_cod_retorno  := 0;
   SN_num_evento   := 0;

   N_num_celular := TO_NUMBER(SUBSTR(EV_trama_in,29,10));
   ga_consumo_pg.ga_cobro_consulta_tasacion_pr(N_num_celular, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

   IF SN_cod_retorno = 0 THEN
      SV_trama_out := '000'||SUBSTR(EV_trama_in,1,2)||CN_consecutivo||TO_CHAR(SYSDATE,'YYYYMMDDHHMMSS')||ga_gen_var_trama_fn(N_num_celular,10,0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO, 222,' ');
   ELSE
      RAISE error_ejecucion;
   END IF;

   RETURN TRUE;

EXCEPTION

   WHEN error_ejecucion THEN
      V_des_error := 'ga_cobro_consulta_tasacion_pr('||EV_trama_in||', '||SV_trama_out||'); - ' || SQLERRM;
      SN_num_evento := ge_errores_pg.grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.0', USER, 'ga_cobro_consulta_tasacion_pr', sSql, SN_cod_retorno, V_des_error );
      SV_trama_out := ga_coderror_fn(SN_cod_retorno)
                                          ||SUBSTR(EV_trama_in,1,2)||CN_consecutivo||TO_CHAR(SYSDATE,'YYYYMMDDHHMMSS')||ga_gen_var_trama_fn(N_num_celular,10,0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(SV_mens_retorno, 222,' ');
      RETURN FALSE;

   WHEN OTHERS THEN
      SN_cod_retorno := 156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'ga_cobro_consulta_tasacion_pr('||EV_trama_in||', '||SV_trama_out||'); - ' || SQLERRM;
      SN_num_evento := ge_errores_pg.grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.0', USER, 'ga_cobro_consulta_tasacion_pr', sSql, SN_cod_retorno, V_des_error );
      SV_trama_out := ga_coderror_fn(SN_cod_retorno)
                                          ||SUBSTR(EV_trama_in,1,2)||CN_consecutivo||TO_CHAR(SYSDATE,'YYYYMMDDHHMMSS')||ga_gen_var_trama_fn(N_num_celular,10,0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(SV_mens_retorno, 222,' ');
      RETURN FALSE;

END ga_cobro_consulta_tasacion_fn;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION ga_consulta_mensaje_fn (
   EV_trama_in       IN         VARCHAR2,
   SV_trama_out      OUT NOCOPY VARCHAR2,
   SN_cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
   SV_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
   SN_num_evento     OUT NOCOPY ge_errores_pg.Evento
)
/*
<Documentacion
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "GA_CONSULTA_MENSAJE_FN"
      Fecha modificacion=""
      Fecha creacion="18-06-2005"
      Constructor="Carlos Navarro H. - Marcelo Godoy S."
      Modificador="
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripcion>Servico de Trmas</Descripcion>
      <Parametros>
         <Entrada>
            <param nom="EV_trama_in"  Tipo="CARACTER">Trama de entrada</param>
         </Entrada>
         <Salida>
            <param nom="SV_trama_out" Tipo="CARACTER">Trama de salida</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
RETURN BOOLEAN
AS
   V_des_error         ge_errores_pg.DesEvent;
   sSql                ge_errores_pg.vQuery;
   N_num_celular       ga_abocel.num_celular%TYPE;
   N_cargo_basico      NUMBER;
   N_can_mensaje_recib NUMBER;
   N_val_mensaje_recib NUMBER;
   N_can_mensaje_envia NUMBER;
   N_val_mensaje_envia NUMBER;
   N_tot_valor_servic  NUMBER;
   error_ejecucion  EXCEPTION;
BEGIN
   SV_mens_retorno := '';
   SN_cod_retorno  := 0;
   SN_num_evento   := 0;

   N_num_celular := TO_NUMBER(SUBSTR(EV_trama_in,29,10));
   ga_consumo_pg.ga_consulta_mensaje_pr(N_num_celular,N_cargo_basico,N_can_mensaje_recib,N_val_mensaje_recib,N_can_mensaje_envia,N_val_mensaje_envia,N_tot_valor_servic,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
   IF SN_cod_retorno = 0 THEN
      SV_trama_out := '000'||SUBSTR(EV_trama_in,1,2)||CN_consecutivo||TO_CHAR(SYSDATE,'YYYYMMDDHHMMSS')||ga_gen_var_trama_fn(N_num_celular,10,0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(N_cargo_basico,  11,'0');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(N_can_mensaje_recib,   6,'0');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(N_val_mensaje_recib,  11,'0');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(N_can_mensaje_envia,   6,'0');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(N_val_mensaje_envia,  11,'0');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(N_tot_valor_servic,  11,'0');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO, 161,' ');
   ELSE
      RAISE error_ejecucion;
   END IF;

   RETURN TRUE;

EXCEPTION

   WHEN error_ejecucion THEN
      V_des_error := 'ga_consulta_mensaje_fn('||EV_trama_in||', '||SV_trama_out||'); - ' || SQLERRM;
      SN_num_evento := ge_errores_pg.grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.0', USER, 'ga_consulta_mensaje_fn', sSql, SN_cod_retorno, V_des_error );
      SV_trama_out := ga_coderror_fn(SN_cod_retorno)
                                          ||SUBSTR(EV_trama_in,1,2)||CN_consecutivo||TO_CHAR(SYSDATE,'YYYYMMDDHHMMSS')||ga_gen_var_trama_fn(N_num_celular,10,0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  11,'0');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,   6,'0');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  11,'0');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,   6,'0');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  11,'0');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  11,'0');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(SV_mens_retorno, 161,' ');
      RETURN FALSE;

   WHEN OTHERS THEN
      SN_cod_retorno := 156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'ga_consulta_mensaje_fn('||EV_trama_in||', '||SV_trama_out||'); - ' || SQLERRM;
      SN_num_evento := ge_errores_pg.grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.0', USER, 'ga_consulta_mensaje_fn', sSql, SN_cod_retorno, V_des_error );
      SV_trama_out := ga_coderror_fn(SN_cod_retorno)
                                          ||SUBSTR(EV_trama_in,1,2)||CN_consecutivo||TO_CHAR(SYSDATE,'YYYYMMDDHHMMSS')||ga_gen_var_trama_fn(N_num_celular,10,0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  11,'0');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,   6,'0');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  11,'0');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,   6,'0');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  11,'0');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  11,'0');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(SV_mens_retorno, 161,' ');
      RETURN FALSE;

END ga_consulta_mensaje_fn;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION ga_cambio_clave_fn (
   EV_trama_in       IN         VARCHAR2,
   SV_trama_out      OUT NOCOPY VARCHAR2,
   SN_cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
   SV_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
   SN_num_evento     OUT NOCOPY ge_errores_pg.Evento
)
/*
<Documentacion
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "GA_CAMBIO_CLAVE_FN"
      Fecha modificacion=""
      Fecha creacion="18-06-2005"
      Constructor="Carlos Navarro H. - Marcelo Godoy S."
      Modificador="
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripcion>Servico de Trmas</Descripcion>
      <Parametros>
         <Entrada>
            <param nom="EV_trama_in"  Tipo="CARACTER">Trama de entrada</param>
         </Entrada>
         <Salida>
            <param nom="SV_trama_out" Tipo="CARACTER">Trama de salida</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
RETURN BOOLEAN
AS
   V_des_error      ge_errores_pg.DesEvent;
   sSql             ge_errores_pg.vQuery;
   N_num_celular    ga_abocel.num_celular%TYPE;
   V_clave_actual   ga_abocel.cod_password%TYPE;
   V_clave_nueva    ga_abocel.cod_password%TYPE;
   error_ejecucion  EXCEPTION;
BEGIN
   SV_mens_retorno := '';
   SN_cod_retorno  := 0;
   SN_num_evento   := 0;

   N_num_celular  := TO_NUMBER(SUBSTR(EV_trama_in,29,10));
   V_clave_actual := SUBSTR(EV_trama_in,25,4);
   V_clave_nueva  := SUBSTR(EV_trama_in,39,4);

   ga_clave_pg.ga_cambio_clave_pr(N_num_celular,V_clave_actual,V_clave_nueva,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

   IF SN_cod_retorno = 0 THEN
      SV_trama_out := '000'||SUBSTR(EV_trama_in,1,2)||CN_consecutivo||TO_CHAR(SYSDATE,'YYYYMMDDHHMMSS')||ga_gen_var_trama_fn(N_num_celular,10,0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO, 222,' ');
   ELSE
      RAISE error_ejecucion;
   END IF;

   RETURN TRUE;

EXCEPTION

   WHEN error_ejecucion THEN
      V_des_error := 'ga_cambio_clave_fn('||EV_trama_in||', '||SV_trama_out||'); - ' || SQLERRM;
      SN_num_evento := ge_errores_pg.grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.0', USER, 'ga_cambio_clave_fn', sSql, SN_cod_retorno, V_des_error );
      SV_trama_out := ga_coderror_fn(SN_cod_retorno)
                                          ||SUBSTR(EV_trama_in,1,2)||CN_consecutivo||TO_CHAR(SYSDATE,'YYYYMMDDHHMMSS')||ga_gen_var_trama_fn(N_num_celular,10,0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(SV_mens_retorno, 222,' ');
      RETURN FALSE;

   WHEN OTHERS THEN
      SN_cod_retorno := 156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'ga_cambio_clave_fn('||EV_trama_in||', '||SV_trama_out||'); - ' || SQLERRM;
      SN_num_evento := ge_errores_pg.grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.0', USER, 'ga_cambio_clave_fn', sSql, SN_cod_retorno, V_des_error );
      SV_trama_out := ga_coderror_fn(SN_cod_retorno)
                                          ||SUBSTR(EV_trama_in,1,2)||CN_consecutivo||TO_CHAR(SYSDATE,'YYYYMMDDHHMMSS')||ga_gen_var_trama_fn(N_num_celular,10,0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(SV_mens_retorno, 222,' ');
      RETURN FALSE;

END ga_cambio_clave_fn;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION ga_bloqueo_clave_fn (
   EV_trama_in       IN         VARCHAR2,
   SV_trama_out      OUT NOCOPY VARCHAR2,
   SN_cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
   SV_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
   SN_num_evento     OUT NOCOPY ge_errores_pg.Evento
)
/*
<Documentacion
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "GA_BLOQUEO_CLAVE_FN"
      Fecha modificacion=""
      Fecha creacion="18-06-2005"
      Constructor="Carlos Navarro H. - Marcelo Godoy S."
      Modificador="
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripcion>Servico de Trmas</Descripcion>
      <Parametros>
         <Entrada>
            <param nom="EV_trama_in"  Tipo="CARACTER">Trama de entrada</param>
         </Entrada>
         <Salida>
            <param nom="SV_trama_out" Tipo="CARACTER">Trama de salida</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
RETURN BOOLEAN
AS
   V_des_error     ge_errores_pg.DesEvent;
   sSql            ge_errores_pg.vQuery;
   V_clave_actual  ga_abocel.cod_password%TYPE;
   N_num_celular   ga_abocel.num_celular%TYPE;
   error_ejecucion EXCEPTION;
BEGIN
   SV_mens_retorno := '';
   SN_cod_retorno  := 0;
   SN_num_evento   := 0;

   N_num_celular  := TO_NUMBER(SUBSTR(EV_trama_in,29,10));
   V_clave_actual := SUBSTR(EV_trama_in,25,4);

   ga_clave_pg.ga_bloqueo_clave_pr(N_num_celular, V_clave_actual, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

   IF SN_cod_retorno = 0 THEN
      SV_trama_out := '000'||SUBSTR(EV_trama_in,1,2)||CN_consecutivo||TO_CHAR(SYSDATE,'YYYYMMDDHHMMSS')||ga_gen_var_trama_fn(N_num_celular,10,0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO, 222,' ');
   ELSE
      RAISE error_ejecucion;
   END IF;

   RETURN TRUE;

EXCEPTION

   WHEN error_ejecucion THEN
      V_des_error := 'ga_bloqueo_clave_fn('||EV_trama_in||', '||SV_trama_out||'); - ' || SQLERRM;
      SN_num_evento := ge_errores_pg.grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.0', USER, 'ga_bloqueo_clave_fn', sSql, SN_cod_retorno, V_des_error );
      SV_trama_out := ga_coderror_fn(SN_cod_retorno)
                                          ||SUBSTR(EV_trama_in,1,2)||CN_consecutivo||TO_CHAR(SYSDATE,'YYYYMMDDHHMMSS')||ga_gen_var_trama_fn(N_num_celular,10,0);
          SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(SV_mens_retorno, 222,' ');
      RETURN FALSE;

   WHEN OTHERS THEN
      SN_cod_retorno := 156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'ga_bloqueo_clave_fn('||EV_trama_in||CN_consecutivo||SV_trama_out||'); - ' || SQLERRM;
      SN_num_evento := ge_errores_pg.grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.0', USER, 'ga_bloqueo_clave_fn', sSql, SN_cod_retorno, V_des_error );
      SV_trama_out := ga_coderror_fn(SN_cod_retorno)
                                          ||SUBSTR(EV_trama_in,1,2)||CN_consecutivo||TO_CHAR(SYSDATE,'YYYYMMDDHHMMSS')||ga_gen_var_trama_fn(N_num_celular,10,0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(SV_mens_retorno, 222,' ');
      RETURN FALSE;

END ga_bloqueo_clave_fn;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION ga_desbloqueo_clave_fn (
   EV_trama_in       IN         VARCHAR2,
   SV_trama_out      OUT NOCOPY VARCHAR2,
   SN_cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
   SV_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
   SN_num_evento     OUT NOCOPY ge_errores_pg.Evento
)
/*
<Documentacion
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "GA_DESBLOQUEO_CLAVE_FN"
      Fecha modificacion=""
      Fecha creacion="18-06-2005"
      Constructor="Carlos Navarro H. - Marcelo Godoy S."
      Modificador="
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripcion>Servico de Trmas</Descripcion>
      <Parametros>
         <Entrada>
            <param nom="EV_trama_in"  Tipo="CARACTER">Trama de entrada</param>
         </Entrada>
         <Salida>
            <param nom="SV_trama_out" Tipo="CARACTER">Trama de salida</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
RETURN BOOLEAN
AS

   V_des_error     ge_errores_pg.DesEvent;
   sSql            ge_errores_pg.vQuery;
   N_num_celular   ga_abocel.num_celular%TYPE;
   V_clave_actual  ga_abocel.cod_password%TYPE;
   error_ejecucion EXCEPTION;
BEGIN
   SV_mens_retorno := '';
   SN_cod_retorno  := 0;
   SN_num_evento   := 0;

   N_num_celular  := TO_NUMBER(SUBSTR(EV_trama_in,29,10));
   V_clave_actual := SUBSTR(EV_trama_in,25,4);

   ga_clave_pg.ga_desbloqueo_clave_pr (N_num_celular, V_clave_actual, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

   IF SN_cod_retorno = 0 THEN
      SV_trama_out := '000'||SUBSTR(EV_trama_in,1,2)||CN_consecutivo||TO_CHAR(SYSDATE,'YYYYMMDDHHMMSS')||ga_gen_var_trama_fn(N_num_celular,10,0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO, 222,' ');
   ELSE
      RAISE error_ejecucion;
   END IF;

   RETURN TRUE;

EXCEPTION

   WHEN error_ejecucion THEN
      V_des_error := 'ga_servicio1_fn('||EV_trama_in||', '||SV_trama_out||'); - ' || SQLERRM;
      SN_num_evento := ge_errores_pg.grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.0', USER, 'ga_desbloqueo_clave_fn', sSql, SN_cod_retorno, V_des_error );
      SV_trama_out := ga_coderror_fn(SN_cod_retorno)
                                          ||SUBSTR(EV_trama_in,1,2)||CN_consecutivo||TO_CHAR(SYSDATE,'YYYYMMDDHHMMSS')||ga_gen_var_trama_fn(N_num_celular,10,0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(SV_mens_retorno, 222,' ');
      RETURN FALSE;

   WHEN OTHERS THEN
      SN_cod_retorno := 156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'ga_desbloqueo_clave_fn('||EV_trama_in||', '||SV_trama_out||'); - ' || SQLERRM;
      SN_num_evento := ge_errores_pg.grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.0', USER, 'ga_desbloqueo_clave_fn', sSql, SN_cod_retorno, V_des_error );
      SV_trama_out := ga_coderror_fn(SN_cod_retorno)
                                          ||SUBSTR(EV_trama_in,1,2)||CN_consecutivo||TO_CHAR(SYSDATE,'YYYYMMDDHHMMSS')||ga_gen_var_trama_fn(N_num_celular,10,0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(SV_mens_retorno, 222,' ');
      RETURN FALSE;

END ga_desbloqueo_clave_fn;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION ga_consulta_clave_fn (
   EV_trama_in       IN         VARCHAR2,
   SV_trama_out      OUT NOCOPY VARCHAR2,
   SN_cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
   SV_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
   SN_num_evento     OUT NOCOPY ge_errores_pg.Evento
)
/*
<Documentacion
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "GA_CONSULTA_CLAVE_FN"
      Fecha modificacion=""
      Fecha creacion="18-06-2005"
      Constructor="Carlos Navarro H. - Marcelo Godoy S."
      Modificador="
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripcion>Servico de Trmas</Descripcion>
      <Parametros>
         <Entrada>
            <param nom="EV_trama_in"  Tipo="CARACTER">Trama de entrada</param>
         </Entrada>
         <Salida>
            <param nom="SV_trama_out" Tipo="CARACTER">Trama de salida</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
RETURN BOOLEAN
AS
   V_des_error      ge_errores_pg.DesEvent;
   sSql             ge_errores_pg.vQuery;
   N_clave          NUMBER(4);
   V_tip_tarifario  VARCHAR2(1);
   N_estado_cliente NUMBER(1);
   N_ind_prepago    NUMBER(1);
   N_num_celular    ga_abocel.num_celular%TYPE;
   error_ejecucion  EXCEPTION;
BEGIN
   SV_mens_retorno := '';
   SN_cod_retorno  := 0;
   SN_num_evento   := 0;

   N_num_celular := TO_NUMBER(SUBSTR(EV_trama_in,29,10));


   ga_clave_pg.ga_consulta_clave_pr(N_num_celular, N_clave, V_tip_tarifario, N_estado_cliente, N_ind_prepago, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

   IF SN_cod_retorno = 0 THEN
      SV_trama_out := '000'||SUBSTR(EV_trama_in,1,2)||CN_consecutivo||TO_CHAR(SYSDATE,'YYYYMMDDHHMMSS')||ga_gen_var_trama_fn(N_num_celular,10,0);

      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(N_clave          ,   4,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(V_tip_tarifario  ,   1, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(N_estado_cliente ,   1,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(N_ind_prepago    ,   1,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO           , 215, ' ');
   ELSE
      RAISE error_ejecucion;
   END IF;

   RETURN TRUE;

EXCEPTION

   WHEN error_ejecucion THEN
      V_des_error := 'ga_consulta_clave_fn('||EV_trama_in||', '||SV_trama_out||'); - ' || SQLERRM;
      SN_num_evento := ge_errores_pg.grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.0', USER, 'ga_consulta_clave_fn', sSql, SN_cod_retorno, V_des_error );
      SV_trama_out := ga_coderror_fn(SN_cod_retorno)
                                          ||SUBSTR(EV_trama_in,1,2)||CN_consecutivo||TO_CHAR(SYSDATE,'YYYYMMDDHHMMSS')||ga_gen_var_trama_fn(N_num_celular,10,0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO         ,   4,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO         ,   1, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO         ,   1,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO         ,   1,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(SV_mens_retorno, 215, ' ');
      RETURN FALSE;

   WHEN OTHERS THEN
      SN_cod_retorno := 156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'ga_consulta_clave_fn('||EV_trama_in||', '||SV_trama_out||'); - ' || SQLERRM;
      SN_num_evento := ge_errores_pg.grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.0', USER, 'ga_consulta_clave_fn', sSql, SN_cod_retorno, V_des_error );
      SV_trama_out := ga_coderror_fn(SN_cod_retorno)
                                          ||SUBSTR(EV_trama_in,1,2)||CN_consecutivo||TO_CHAR(SYSDATE,'YYYYMMDDHHMMSS')||ga_gen_var_trama_fn(N_num_celular,10,0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO         ,   4,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO         ,   1, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO         ,   1,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO         ,   1,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(SV_mens_retorno, 215, ' ');
      RETURN FALSE;

END ga_consulta_clave_fn;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION ga_plan_detallado_fn (
   EV_trama_in       IN         VARCHAR2,
   SV_trama_out      OUT NOCOPY VARCHAR2,
   SN_cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
   SV_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
   SN_num_evento     OUT NOCOPY ge_errores_pg.Evento
)
/*
<Documentacion
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "GA_PLAN_DETALLADO_FN"
      Fecha modificacion=""
      Fecha creacion="18-06-2005"
      Constructor="Carlos Navarro H. - Marcelo Godoy S."
      Modificador="
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripcion>Servico de Trmas</Descripcion>
      <Parametros>
         <Entrada>
            <param nom="EV_trama_in"  Tipo="CARACTER">Trama de entrada</param>
         </Entrada>
         <Salida>
            <param nom="SV_trama_out" Tipo="CARACTER">Trama de salida</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
RETURN BOOLEAN
AS
   V_des_error       ge_errores_pg.DesEvent;
   sSql              ge_errores_pg.vQuery;
   V_cod_plantarif   ta_plantarif.cod_plantarif%TYPE;
   V_fec_vigencia    ga_abocel.fec_cumplan%TYPE;
   N_num_unidades    ta_plantarif.num_unidades%TYPE;
   N_imp_cargobasico ta_cargosbasico.imp_cargobasico%TYPE;
   N_num_celular     ga_abocel.num_celular%TYPE;
   error_ejecucion EXCEPTION;
BEGIN
   SV_mens_retorno := '';
   SN_cod_retorno  := 0;
   SN_num_evento   := 0;

   N_num_celular := TO_NUMBER(SUBSTR(EV_trama_in,29,10));


   ga_consumo_pg.ga_plan_detallado_pr (N_num_celular, V_cod_plantarif, V_fec_vigencia, N_num_unidades, N_imp_cargobasico, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

   IF SN_cod_retorno = 0 THEN
      SV_trama_out := '000'||SUBSTR(EV_trama_in,1,2)||CN_consecutivo||TO_CHAR(SYSDATE,'YYYYMMDDHHMMSS');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(V_cod_plantarif   ,  3, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(TO_CHAR(V_fec_vigencia,'YYYYMMDD')    , 10, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(N_num_unidades    ,  6,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(N_imp_cargobasico , 14,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO            , 14,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO            , 14,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO            , 14,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO            , 14,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO            , 14,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO            , 14,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO            , 14,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO            , 14,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO            , 99, ' ');
   ELSE
      RAISE error_ejecucion;
   END IF;

   RETURN TRUE;

EXCEPTION

   WHEN error_ejecucion THEN
      V_des_error := 'ga_plan_detallado_fn('||EV_trama_in||', '||SV_trama_out||'); - ' || SQLERRM;
      SN_num_evento := ge_errores_pg.grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.0', USER, 'ga_plan_detallado_fn', sSql, SN_cod_retorno, V_des_error );
      SV_trama_out := ga_coderror_fn(SN_cod_retorno)
                                          ||SUBSTR(EV_trama_in,1,2)||CN_consecutivo||TO_CHAR(SYSDATE,'YYYYMMDDHHMMSS');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  3, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO, 10, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  6,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO, 14,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO, 14,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO, 14,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO, 14,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO, 14,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO, 14,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO, 14,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO, 14,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO, 14,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(SV_mens_retorno, 99, ' ');
      RETURN FALSE;

   WHEN OTHERS THEN
      SN_cod_retorno := 156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'ga_plan_detallado_fn('||EV_trama_in||', '||SV_trama_out||'); - ' || SQLERRM;
      SN_num_evento := ge_errores_pg.grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.0', USER, 'ga_plan_detallado_fn', sSql, SN_cod_retorno, V_des_error );
      SV_trama_out := ga_coderror_fn(SN_cod_retorno)
                                          ||SUBSTR(EV_trama_in,1,2)||CN_consecutivo||TO_CHAR(SYSDATE,'YYYYMMDDHHMMSS');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  3, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO, 10, ' ');
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  6,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO, 14,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO, 14,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO, 14,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO, 14,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO, 14,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO, 14,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO, 14,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO, 14,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO, 14,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(SV_mens_retorno, 99, ' ');
      RETURN TRUE;

END ga_plan_detallado_fn;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION ga_consulta_tasacion_fn (
   EV_trama_in       IN         VARCHAR2,
   SV_trama_out      OUT NOCOPY VARCHAR2,
   SN_cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
   SV_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
   SN_num_evento     OUT NOCOPY ge_errores_pg.Evento
)
/*
<Documentacion
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "GA_CONSULTA_TASACION_FN"
      Fecha modificacion=""
      Fecha creacion="18-06-2005"
      Constructor="Carlos Navarro H. - Marcelo Godoy S."
      Modificador="
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripcion>Servico de Trmas</Descripcion>
      <Parametros>
         <Entrada>
            <param nom="EV_trama_in"  Tipo="CARACTER">Trama de entrada</param>
         </Entrada>
         <Salida>
            <param nom="SV_trama_out" Tipo="CARACTER">Trama de salida</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
<Código de Incidencia>
   <Datos Incidencia="MCO-200608180004" Descripción="Solicitud de retorno de Tiempo Extra y Plan por separado"></Datos>
   <Fecha Cambio="29/09/2006"></Fecha>
   <Programador Nombre="Robinson A. Soto Toloza"></Programador>
</Código de Incidencia>
<Código de Incidencia>
   <Datos Incidencia="35869" Descripción="Se agrega indicador de unidad en trama de consulta tasación"></Datos>
   <Fecha Cambio="05/12/2006"></Fecha>
   <Programador Nombre="Robinson A. Soto Toloza"></Programador>
</Código de Incidencia>
*/
RETURN BOOLEAN
AS
   V_des_error      ge_errores_pg.DesEvent;
   sSql             ge_errores_pg.vQuery;
   N_num_abonado    GA_ABOCEL.NUM_ABONADO%TYPE;
   N_tim_llam_ent   NUMBER;
   N_val_llam_ent   NUMBER;
   N_tim_llam_sal   NUMBER;
   N_val_llam_sal   NUMBER;
   N_tim_llam_dat   NUMBER;
   N_val_llam_dat   NUMBER;
   N_tim_tota_voz   NUMBER;
   N_tim_text_voz   NUMBER; -- 34629 -rast- 28/09/2006 Tiempo Extra
   N_val_tota_voz   NUMBER;
   N_tim_oper_tot   NUMBER;
   N_tim_cons_pla   NUMBER;
   N_tim_cons_npl   NUMBER;
   N_ind_unidad     NUMBER; -- 35869 -rast- 04/12/2006 (1 Si es V y 0 Si es M)
   N_minutos_prom   NUMBER;
   N_can_cosn_tas   NUMBER;
   error_ejecucion  EXCEPTION;

   /* Inicio modificacion by SAQL/Soporte 18/05/2006 - CO-200605050102 */
   LN_VAL_MINTOTAL     NUMBER;
   LN_VAL_USADO        NUMBER;
   LN_VAL_DISPONIBLE   NUMBER;
   LN_USADO_BOLSA      NUMBER;
   LN_DISPONIBLE_BOLSA NUMBER;
   /* Fin modificacion by SAQL/Soporte 18/05/2006 - CO-200605050102 */
   LV_indicador        VARCHAR2(11);

   -- 34629 -rast- 13/10/2006 Se agrega valor del tiempo total al aire
   LN_tiempoAire       NUMBER;

BEGIN
   SV_mens_retorno := '';
   SN_cod_retorno  := 0;
   SN_num_evento   := 0;
   LN_tiempoAire   := 0;

   N_num_abonado := TO_NUMBER(SUBSTR(EV_trama_in,3,8));

   -- 34629 -rast- 13/10/2006 Se agrega tiempo extra en llamado a procedimiento (N_tim_text_voz)
   -- 35869 -rast- 13/10/2006 Se agrega ind_unidad en llamado a procedimiento (N_ind_unidad)
   ga_consumo_pg.ga_consulta_tasacion_pr(
      N_num_abonado    , N_tim_llam_ent     , N_val_llam_ent     , N_tim_llam_sal ,  N_val_llam_sal , N_tim_llam_dat,
      N_val_llam_dat   , N_tim_tota_voz     , N_tim_text_voz     , N_val_tota_voz ,  N_tim_oper_tot , N_tim_cons_pla,
      N_tim_cons_npl   , N_ind_unidad       , N_minutos_prom     , N_can_cosn_tas ,  LN_VAL_MINTOTAL, LN_VAL_USADO  ,
      LN_VAL_DISPONIBLE, LN_USADO_BOLSA     , LN_DISPONIBLE_BOLSA, SN_cod_retorno , SV_mens_retorno , SN_num_evento
   );

   IF (LENGTH(LN_VAL_MINTOTAL) > 6) OR (LENGTH(LN_VAL_USADO) > 6) OR (LENGTH(LN_VAL_DISPONIBLE) > 6) THEN
      IF NOT ga_error_desborde_fn(LV_indicador,SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
         LV_indicador := CV_DESACTIVADO;--'DESACTIVADO'
      END IF;

      IF (LV_indicador = CV_ACTIVADO ) THEN --' ACTIVADO'
         SN_cod_retorno := 525;
      END IF;

      IF NOT  Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasIF;
      END  IF;
   END IF;

   -- 34629 -rast- 13/10/2006
   -- Se agrega valor del tiempo total al aire, y se modifica trama según nueva definición

   -- 35869 -rast- 04/12/2006 (1 Si es V y 0 Si es M)
   -- Se agrega ind_unidad en campo nro13 de la trama
   LN_tiempoAire := N_tim_tota_voz + N_tim_text_voz;

   IF SN_cod_retorno = 0 THEN
      SV_trama_out := '000'||SUBSTR(EV_trama_in,1,2);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(LN_tiempoAire      ,  8 ,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(N_val_tota_voz     ,  11,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(N_can_cosn_tas     ,  4 ,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(N_tim_llam_dat     ,  6 ,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO             ,  14,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(N_val_llam_dat     ,  11,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(N_tim_llam_ent     ,  6 ,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(N_val_llam_ent     ,  11,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(N_tim_llam_sal     ,  6 ,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(N_val_llam_sal     ,  11,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(N_ind_unidad       ,  8 ,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO             ,  8 ,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO             ,  8 ,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO             ,  8 ,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(LN_VAL_MINTOTAL    ,  6 ,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(LN_VAL_USADO       ,  6 ,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(LN_VAL_DISPONIBLE  ,  6 ,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(N_tim_cons_pla     ,  11,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(N_tim_cons_npl     ,  11,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(N_tim_tota_voz     ,  8 ,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(N_tim_text_voz     ,  8 ,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(N_val_tota_voz     ,  11,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO             ,  8 ,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO             ,  8 ,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(N_tim_oper_tot     ,  8 ,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO             ,  8 ,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(N_minutos_prom     ,  8 ,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO             ,  8 ,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO             ,  8 ,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO             ,  8 ,   0);
   ELSE
      RAISE error_ejecucion;
   END IF;

   RETURN TRUE;

EXCEPTION

   WHEN error_ejecucion THEN
      V_des_error := 'ga_consulta_tasacion_fn('||EV_trama_in||', '||SV_trama_out||'); - ' || SQLERRM;
      SN_num_evento := ge_errores_pg.grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.0', USER, 'ga_consulta_tasacion_fn', sSql, SN_cod_retorno, V_des_error );
      SV_trama_out := ga_coderror_fn(SN_cod_retorno)
                                          ||SUBSTR(EV_trama_in,1,2);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  8 ,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  11,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  4 ,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  6 ,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  14,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  11,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  6 ,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  11,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  6 ,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  11,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  8 ,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  8 ,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  8 ,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  8 ,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  6 ,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  6 ,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  6 ,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  11,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  11,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  8 ,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  8 ,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  11,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  8 ,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  8 ,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  8 ,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  8 ,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  8 ,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  8 ,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  8 ,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  8 ,   0);
      RETURN FALSE;

   WHEN OTHERS THEN
      SN_cod_retorno := 156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'ga_consulta_tasacion_fn('||EV_trama_in||', '||SV_trama_out||'); - ' || SQLERRM;
      SN_num_evento := ge_errores_pg.grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.0', USER, 'ga_consulta_tasacion_fn', sSql, SN_cod_retorno, V_des_error );
      SV_trama_out := ga_coderror_fn(SN_cod_retorno)
                                          ||SUBSTR(EV_trama_in,1,2);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  8 ,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  11,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  4 ,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  6 ,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  14,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  11,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  6 ,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  11,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  6 ,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  11,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  8 ,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  8 ,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  8 ,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  8 ,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  6 ,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  6 ,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  6 ,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  11,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  11,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  8 ,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  8 ,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  11,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  8 ,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  8 ,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  8 ,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  8 ,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  8 ,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  8 ,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  8 ,   0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO,  8 ,   0);
      RETURN FALSE;

END ga_consulta_tasacion_fn;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION ga_extratiempo_contrato_fn (
   EV_trama_in       IN         VARCHAR2,
   SV_trama_out      OUT NOCOPY VARCHAR2,
   SN_cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
   SV_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
   SN_num_evento     OUT NOCOPY ge_errores_pg.Evento
)
/*
<Documentacion
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "GA_EXTRATIEMPO_CONTRATO_FN"
      Fecha modificacion=""
      Fecha creacion="18-06-2005"
      Constructor="Carlos Navarro H. - Marcelo Godoy S."
      Modificador="
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripcion>Servico de Trmas</Descripcion>
      <Parametros>
         <Entrada>
            <param nom="EV_trama_in"  Tipo="CARACTER">Trama de entrada</param>
         </Entrada>
         <Salida>
            <param nom="SV_trama_out" Tipo="CARACTER">Trama de salida</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
RETURN BOOLEAN
AS
   V_des_error      ge_errores_pg.DesEvent;
   sSql             ge_errores_pg.vQuery;
   N_num_celular    ga_abocel.num_celular%TYPE;
   N_cod_plan           bpd_planes.cod_plan%TYPE;
   N_valor_recarga  NUMBER(8);
   error_ejecucion  EXCEPTION;
BEGIN
   SV_mens_retorno := '';
   SN_cod_retorno  := 0;
   SN_num_evento   := 0;

   N_num_celular   := TO_NUMBER(SUBSTR(EV_trama_in,3,10));
   N_valor_recarga := TO_NUMBER(SUBSTR(EV_trama_in,13,8));
   N_cod_plan      := SUBSTR(EV_trama_in,21,5);

   ga_extra_tiempo_pg.ga_extratiempo_contrato_pr(N_num_celular,N_valor_recarga,N_cod_plan,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
   IF SN_cod_retorno = 0 THEN
      SV_trama_out := '000'||SUBSTR(EV_trama_in,1,2)||CN_consecutivo||TO_CHAR(SYSDATE,'YYYYMMDDHHMMSS')||ga_gen_var_trama_fn(N_num_celular,10,0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO, 222, ' ');
   ELSE
      RAISE error_ejecucion;
   END IF;

   RETURN TRUE;

EXCEPTION

   WHEN error_ejecucion THEN
      V_des_error := 'ga_extratiempo_contrato_fn('||EV_trama_in||', '||SV_trama_out||'); - ' || SQLERRM;
      SN_num_evento := ge_errores_pg.grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.0', USER, 'ga_extratiempo_contrato_fn', sSql, SN_cod_retorno, V_des_error );
      SV_trama_out := ga_coderror_fn(SN_cod_retorno)
                                          ||SUBSTR(EV_trama_in,1,2)||CN_consecutivo||TO_CHAR(SYSDATE,'YYYYMMDDHHMMSS')||ga_gen_var_trama_fn(N_num_celular,10,0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(SV_mens_retorno, 222, ' ');
      RETURN FALSE;

   WHEN OTHERS THEN
      SN_cod_retorno := 156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'ga_extratiempo_contrato_fn('||EV_trama_in||', '||SV_trama_out||'); - ' || SQLERRM;
      SN_num_evento := ge_errores_pg.grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.0', USER, 'ga_extratiempo_contrato_fn', sSql, SN_cod_retorno, V_des_error );
      SV_trama_out := ga_coderror_fn(SN_cod_retorno)
                                          ||SUBSTR(EV_trama_in,1,2)||CN_consecutivo||TO_CHAR(SYSDATE,'YYYYMMDDHHMMSS')||ga_gen_var_trama_fn(N_num_celular,10,0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(SV_mens_retorno, 222, ' ');
      RETURN FALSE;

END ga_extratiempo_contrato_fn;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION ga_carga_prepago_a_postpago_fn (
   EV_trama_in       IN         VARCHAR2,
   SV_trama_out      OUT NOCOPY VARCHAR2,
   SN_cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
   SV_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
   SN_num_evento     OUT NOCOPY ge_errores_pg.Evento
)
/*
<Documentacion
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "GA_CARGA_PREPAGO_A_POSTPAGO_FN"
      Fecha modificacion=""
      Fecha creacion="18-06-2005"
      Constructor="Carlos Navarro H. - Marcelo Godoy S."
      Modificador="
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripcion>Servico de Trmas</Descripcion>
      <Parametros>
         <Entrada>
            <param nom="EV_trama_in"  Tipo="CARACTER">Trama de entrada</param>
         </Entrada>
         <Salida>
            <param nom="SV_trama_out" Tipo="CARACTER">Trama de salida</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
RETURN BOOLEAN
AS
   V_des_error      ge_errores_pg.DesEvent;
   sSql             ge_errores_pg.vQuery;
   N_num_celular_origen  ga_abocel.num_celular%TYPE;
   N_num_celular_destino ga_abocel.num_celular%TYPE;
   N_valor_recarga       NUMBER(8);
   error_ejecucion EXCEPTION;
BEGIN
   SV_mens_retorno := '';
   SN_cod_retorno  := 0;
   SN_num_evento   := 0;

   N_num_celular_origen   := TO_NUMBER(SUBSTR(EV_trama_in,3,10));
   N_num_celular_destino  := TO_NUMBER(SUBSTR(EV_trama_in,13,10));
   N_valor_recarga        := TO_NUMBER(SUBSTR(EV_trama_in,23,8));

   ga_extra_tiempo_pg.ga_carga_prepago_a_postpago_pr(N_num_celular_origen,N_num_celular_destino,N_valor_recarga,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
   IF SN_cod_retorno = 0 THEN
      SV_trama_out := '000'||SUBSTR(EV_trama_in,1,2)||CN_consecutivo||TO_CHAR(SYSDATE,'YYYYMMDDHHMMSS')||ga_gen_var_trama_fn(N_num_celular_origen,10,0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(NONULO, 222, ' ');
   ELSE
      RAISE error_ejecucion;
   END  IF;

   RETURN TRUE;


EXCEPTION

   WHEN error_ejecucion THEN
      V_des_error := 'ga_carga_prepago_a_postpago_fn('||EV_trama_in||', '||SV_trama_out||'); - ' || SQLERRM;
      SN_num_evento := ge_errores_pg.grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.0', USER, 'ga_carga_prepago_a_postpago_fn', sSql, SN_cod_retorno, V_des_error );
      SV_trama_out := ga_coderror_fn(SN_cod_retorno)
                                          ||SUBSTR(EV_trama_in,1,2)||CN_consecutivo||TO_CHAR(SYSDATE,'YYYYMMDDHHMMSS')||ga_gen_var_trama_fn(N_num_celular_origen,10,0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(SV_mens_retorno, 222, ' ');
      RETURN FALSE;

   WHEN OTHERS THEN
      SN_cod_retorno := 156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'ga_carga_prepago_a_postpago_fn('||EV_trama_in||', '||SV_trama_out||'); - ' || SQLERRM;
      SN_num_evento := ge_errores_pg.grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.0', USER, 'ga_carga_prepago_a_postpago_fn', sSql, SN_cod_retorno, V_des_error );
      SV_trama_out := ga_coderror_fn(SN_cod_retorno)
                                          ||SUBSTR(EV_trama_in,1,2)||CN_consecutivo||TO_CHAR(SYSDATE,'YYYYMMDDHHMMSS')||ga_gen_var_trama_fn(N_num_celular_origen,10,0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(SV_mens_retorno, 222, ' ');
      RETURN FALSE;

END ga_carga_prepago_a_postpago_fn;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ga_asigna_beneficio_fn (
   EV_trama_in       IN         VARCHAR2,
   SV_trama_out      OUT NOCOPY VARCHAR2,
   SN_cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
   SV_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
   SN_num_evento     OUT NOCOPY ge_errores_pg.Evento
)
/*
<Documentacion
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "ga_asigna_beneficio_fn"
      Fecha modificacion=""
      Fecha creacion="20-10-2006"
      Constructor="Mauricio Moya"
      Modificador="
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripcion>Servico de Trmas</Descripcion>
      <Parametros>
         <Entrada>
            <param nom="EV_trama_in"  Tipo="CARACTER">Trama de entrada</param>
         </Entrada>
         <Salida>
            <param nom="SV_trama_out" Tipo="CARACTER">Trama de salida</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
RETURN BOOLEAN
AS
   V_des_error      ge_errores_pg.DesEvent;
   sSql             ge_errores_pg.vQuery;
   N_num_abonado    GA_ABOCEL.NUM_ABONADO%TYPE;
   N_cod_plan   bpd_planes.cod_plan%TYPE;
   error_ejecucion  EXCEPTION;
BEGIN
   SV_mens_retorno := '';
   SN_cod_retorno  := 0;
   SN_num_evento   := 0;
   sSql   := '';

   N_num_abonado   := TO_NUMBER(SUBSTR(EV_trama_in,3,8));
   N_cod_plan      := SUBSTR(EV_trama_in,11,5);

   BP_PROMOCIONES_PG.bp_asigna_beneficio_pr(N_num_abonado,N_cod_plan,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
   IF SN_cod_retorno = 0 THEN
      SV_trama_out := '000'||SUBSTR(EV_trama_in,1,2)||CN_consecutivo||TO_CHAR(SYSDATE,'YYYYMMDDHHMMSS')||ga_gen_var_trama_fn(N_num_abonado,8,0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(SV_mens_retorno, 50, ' ');
   ELSE
      RAISE error_ejecucion;
   END IF;

   RETURN TRUE;

EXCEPTION

   WHEN error_ejecucion THEN
      SV_trama_out := ga_coderror_fn(SN_cod_retorno)
                                          ||SUBSTR(EV_trama_in,1,2)||CN_consecutivo||TO_CHAR(SYSDATE,'YYYYMMDDHHMMSS')||ga_gen_var_trama_fn(N_num_abonado,8,0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(SV_mens_retorno, 50, ' ');

      V_des_error := 'ga_asigna_beneficio_fn('||EV_trama_in||', '||SV_trama_out||'); - ';
      SN_num_evento := ge_errores_pg.grabarpl( SN_num_evento, 'BP', SV_mens_retorno, '1.0', USER, 'ga_asigna_beneficio_fn', sSql, SN_cod_retorno, V_des_error );

      RETURN FALSE;

   WHEN OTHERS THEN
      SN_cod_retorno := 156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := 'ga_asigna_beneficio_fn('||EV_trama_in||', '||SV_trama_out||'); - ' || SQLERRM;
      SN_num_evento := ge_errores_pg.grabarpl( SN_num_evento, 'BP', SV_mens_retorno, '1.0', USER, 'ga_asigna_beneficio_fn', sSql, SN_cod_retorno, V_des_error );
      SV_trama_out := ga_coderror_fn(SN_cod_retorno)
                                          ||SUBSTR(EV_trama_in,1,2)||CN_consecutivo||TO_CHAR(SYSDATE,'YYYYMMDDHHMMSS')||ga_gen_var_trama_fn(N_num_abonado,8,0);
      SV_trama_out := SV_trama_out || ga_gen_var_trama_fn(SV_mens_retorno, 224, ' ');
      RETURN FALSE;

END ga_asigna_beneficio_fn;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ga_error_desborde_fn(SV_IND_OVERFLOW     OUT NOCOPY VARCHAR2
                                                          ,SN_COD_RETORNO  OUT NOCOPY NUMBER
                                                          ,SV_MENS_RETORNO OUT NOCOPY VARCHAR2
                                                          ,SN_NUM_EVENTO   OUT NOCOPY NUMBER
                                                          )
                                                          RETURN BOOLEAN IS
/*
<Documentación
   TipoDoc = "Funcion">
   <Elemento
        Nombre = "GA_ERROR_DESBORDE_FN"
        Lenguaje="PL/SQL"
        Fecha="31-10-2005"
        Versión="1.0"
        Diseñador="Andrés Osorio Gallardo"
        Programador="Andrés Osorio Gallardo"
        Ambiente Desarrollo="BD">
        <Retorno>BOOLEAN</Retorno>
        <Descripción>Extrae desde la base de datos el indicador que sirve para identificar si la operadora desea que el desborde
                    sea considerado error o no. Devuleve TURE si se ejecuto con exito, FALSE en caso contrario</Descripción>
        <Parámetros>
                <Salida>
                                        <param nom="SV_PREFIJOX"      Tipo="VARCHAR">Prefijo de los planes extratiempo</param>
                                        <param nom="SN_COD_RETORNO"   Tipo="NUMERICO">Código de Retorno (descripción de error)</param>
                                <param nom="SV_MENS_RETORNO"  Tipo="VARCHAR">Mensaje de Retorno (código de error)</param>
                                <param nom="SN_NUM_EVENTO"    Tipo="NUMERICO">Número de Evento</param>
                </Salida>
        </Parámetros>
   </Elemento>
</Documentación>
*/
  N_codretorno           ge_errores_td.cod_msgerror%TYPE;
  V_des_error            ge_errores_pg.DesEvent;
  sSql                   ge_errores_pg.vQuery;
  V_val_parametro        ged_parametros.val_parametro%TYPE;
  V_mens_retorno         ge_errores_td.det_msgerror%TYPE;
  LV_cod_modulo                  VARCHAR2(2) :='GA';
BEGIN
        SN_COD_RETORNO          :=0;
        SV_MENS_RETORNO         :=NULL;
        SN_NUM_EVENTO           :=0;
         sSql := 'SELECT parametro.val_parametro '
                         ||' INTO       SV_IND_OVERFLOW '
                         ||' FROM       ged_parametros parametro '
                         ||' WHERE  parametro.nom_parametro = '||'OVERFLOW_SERV_TRAMA'
                         ||' AND    parametro.cod_modulo = '||LV_cod_modulo
                         ||' AND    parametro.cod_producto =  1';

         SELECT parametro.val_parametro
         INTO   SV_IND_OVERFLOW
         FROM   ged_parametros parametro
         WHERE  parametro.nom_parametro = 'OVERFLOW_SERV_TRAMA'
         AND    parametro.cod_modulo = LV_cod_modulo
         AND    parametro.cod_producto =  1;

         RETURN TRUE;

EXCEPTION
         WHEN NO_DATA_FOUND THEN
                 SN_cod_retorno := '215';
         IF NOT  Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasIF;
         END  IF;
         V_des_error := SUBSTR('NO_DATA_FOUND: ga_error_desborde_fn(); - ' || SQLERRM,1,CN_largoerrtec);
                 SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
         SN_num_evento := ge_errores_pg.grabarpl( SN_num_evento, LV_cod_modulo, SV_mens_retorno, '1.0', USER, 'ga_trama_pg.ga_error_desborde_fn', sSql, SQLCODE, V_des_error );
         RETURN  FALSE;
        WHEN OTHERS THEN
                 SN_cod_retorno := '302';
         IF NOT  Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasIF;
         END  IF;
         V_des_error := SUBSTR('OTHERS: ga_error_desborde_fn(''); - ' || SQLERRM,1,CN_largoerrtec);
                 SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
         SN_num_evento := ge_errores_pg.grabarpl( SN_num_evento, LV_cod_modulo, SV_mens_retorno, '1.0', USER, 'ga_trama_pg.ga_error_desborde_fn', sSql, SQLCODE, V_des_error );
         RETURN  FALSE;
END ga_error_desborde_fn;
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE ga_trama_pr (
   EV_trama_in       IN         VARCHAR2,
   SV_trama_out      OUT NOCOPY VARCHAR2,
   SN_cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
   SV_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
   SN_num_evento     OUT NOCOPY ge_errores_pg.Evento
)
/*
<Documentacion
  TipoDoc = "Procedure">
   <Elemento
      Nombre = "GA_TRAMA_PR"
      Fecha modificacion=" "
      Fecha creacion="16-06-2005"
      Constructor="Marcelo Godoy S."
      Modificador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Recupera cantidad y valor de mensajes recibidos y enviados</Descripcion>
      <Parametros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
         </Entrada>
         <Salida>
            <param nom="EV_trama_in"          Tipo="NUMERICO">Trama entrada</param>
            <param nom="SN_trama_out"         Tipo="NUMERICO">Trama salida</param>
            <param nom="SN_cod_retorno"       Tipo="NUMERICO">Codigo de retorno</param>
            <param nom="SV_mens_retorno"      Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"        Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
AS
   V_des_error         ge_errores_pg.DesEvent;
   sSql                ge_errores_pg.vQuery;
   error_ejecucion      EXCEPTION;
   error_parametros     EXCEPTION;
BEGIN
   SV_mens_retorno := '';
   SN_cod_retorno  := 0;
   SN_num_evento   := 0;

   CASE SUBSTR(EV_trama_in,1,2)

      WHEN 'SG' THEN
         IF NOT ga_consulta_segmentacion_fn(EV_trama_in, SV_trama_out, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
            RAISE error_ejecucion;
         END IF;
      WHEN 'KC' THEN
         IF NOT ga_cobro_consulta_tasacion_fn(EV_trama_in, SV_trama_out, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
            RAISE error_ejecucion;
         END IF;
      WHEN 'MP' THEN
         IF NOT ga_consulta_mensaje_fn(EV_trama_in, SV_trama_out, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
            RAISE error_ejecucion;
         END IF;
      WHEN 'CK' THEN
         IF NOT ga_cambio_clave_fn(EV_trama_in, SV_trama_out, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
            RAISE error_ejecucion;
         END IF;
      WHEN 'BC' THEN
         IF NOT ga_bloqueo_clave_fn(EV_trama_in, SV_trama_out, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
            RAISE error_ejecucion;
         END IF;
      WHEN 'DC' THEN
         IF NOT ga_desbloqueo_clave_fn(EV_trama_in, SV_trama_out, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
            RAISE error_ejecucion;
         END IF;
      WHEN 'CL' THEN
         IF NOT ga_consulta_clave_fn(EV_trama_in, SV_trama_out, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
            RAISE error_ejecucion;
         END IF;
      WHEN 'PD' THEN
         IF NOT ga_plan_detallado_fn(EV_trama_in, SV_trama_out, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
            RAISE error_ejecucion;
         END IF;
      WHEN 'CO' THEN
         IF NOT ga_consulta_tasacion_fn(EV_trama_in, SV_trama_out, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
            RAISE error_ejecucion;
         END IF;
      WHEN 'EP' THEN
         IF NOT ga_extratiempo_contrato_fn(EV_trama_in, SV_trama_out, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
            RAISE error_ejecucion;
         END IF;
      WHEN 'RP' THEN
         IF NOT ga_carga_prepago_a_postpago_fn(EV_trama_in, SV_trama_out, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
            RAISE error_ejecucion;
         END IF;
      WHEN 'BP' THEN
         IF NOT ga_asigna_beneficio_fn(EV_trama_in, SV_trama_out, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
            RAISE error_ejecucion;
         END IF;
      ELSE
         RAISE error_parametros;
   END CASE;

EXCEPTION

   WHEN error_ejecucion THEN
      V_des_error := sqlerrm || 'ga_trama_pr('||EV_trama_in||', '||SV_trama_out||'); - ' || SQLERRM;
      SN_num_evento := ge_errores_pg.grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.0', USER, 'ga_trama_pr', sSql, SN_cod_retorno, V_des_error );

   WHEN error_parametros THEN
      SN_cod_retorno := 98;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error   := sqlerrm || 'ga_trama_pr('||EV_trama_in||', '||SV_trama_out||'); - ' || SQLERRM;
      SN_num_evento := ge_errores_pg.grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.0', USER, 'ga_trama_pr', sSql, SN_cod_retorno, V_des_error );
          SV_trama_out  := ga_coderror_fn(SN_cod_retorno);

   WHEN OTHERS THEN
      SN_cod_retorno := 156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      V_des_error := sqlerrm || 'ga_trama_pr('||EV_trama_in||', '||SV_trama_out||'); - ' || SQLERRM;
      SN_num_evento := ge_errores_pg.grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.0', USER, 'ga_trama_pr', sSql, SN_cod_retorno, V_des_error );
          SV_trama_out  := ga_coderror_fn(SN_cod_retorno);

END ga_trama_pr;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
END Ga_Trama_Pg;
/
SHOW ERRORS
