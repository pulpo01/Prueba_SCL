CREATE OR REPLACE PACKAGE EBZ_SISCEL.NP_ART_CANAL_PG IS
/*
<NOMBRE>           : NP_ART_CANAL_PG </NOMBRE>
<FECHACREA>      : 16-07-2013<FECHACREA/>
<MODULO >          : Logistica </MODULO >
<AUTOR >            : IGOR SANCHEZ - ROBINSON SOTO T. </AUTOR >
<VERSION >         : 1.0</VERSION >
<DESCRIPCION>   : Mantención de Sobre Stock y Consultas por Tipo Canal </DESCRIPCION>
*/

    TYPE refcursor              IS REF CURSOR;
    TYPE NP_SPLIT_PARAM IS TABLE OF VARCHAR2(5000);
    CV_error_no_clasif        CONSTANT VARCHAR2(50):= 'No es posible clasificar el error';

    FUNCTION SPLIT_PARAMETRO_MULTIPLE (
        p_param_list    VARCHAR2,
        p_param_del    VARCHAR2
    ) RETURN NP_SPLIT_PARAM pipelined;

   PROCEDURE NP_INSERTA_CANAL_ART_PR  (
      v_cod_tipo_canal in npt_limite_Art_canal_td.COD_TIPO_CANAL%TYPE,
      v_cod_usuario     in  npt_limite_Art_canal_td.COD_USUARIO%TYPE,
      v_cod_articulo     in  npt_limite_Art_canal_td.COD_ARTICULO%TYPE,
      v_tip_stock          in  npt_limite_Art_canal_td.TIP_STOCK%TYPE,
      v_cod_uso           in  npt_limite_Art_canal_td.COD_USO%TYPE,
      v_cantidad           in  npt_limite_Art_canal_td.CANTIDAD%TYPE,
      v_operacion         in  varchar2,
      v_fec_desde         in  varchar2,
      v_fec_hasta          in  varchar2,
      v_fec_desde_new  in  varchar2,
      v_fec_hasta_new   in  varchar2,
      strError                 out varchar2
   );

   PROCEDURE NP_VALIDA_CANTIDAD_LIMITE  (
      v_cod_tipo_canal in npt_limite_Art_canal_td.COD_TIPO_CANAL%TYPE,
      v_cod_usuario     in npt_limite_articulo_td.COD_USUARIO%TYPE,
      v_cod_articulo     in npt_limite_articulo_td.COD_ARTICULO%TYPE,
      v_tip_stock          in npt_limite_articulo_td.TIP_STOCK%TYPE,
      v_cod_uso           in npt_limite_articulo_td.COD_USO%TYPE,
      v_cantidad           out npt_limite_articulo_td.CANTIDAD%TYPE,
      strError               out varchar2
   );

   PROCEDURE NP_INSERTA_ERRORES (
      v_cod_retorno           in ge_errores_pg.CodError,
      v_componente_error  in  ge_errores_pg.DesEvent,
      v_error_desc             in VARCHAR2
   );

   PROCEDURE NP_GET_LIMITE_ARTICULO  (
      v_cod_tipo_canal in npt_limite_Art_canal_td.COD_TIPO_CANAL%TYPE,
      v_cod_usuario     in npt_limite_articulo_td.COD_USUARIO%TYPE,
      v_cod_articulo     in npt_limite_articulo_td.COD_ARTICULO%TYPE,
      v_tip_stock          in npt_limite_articulo_td.TIP_STOCK%TYPE,
      v_cod_uso          in npt_limite_articulo_td.COD_USO%TYPE,
      v_cantidad          out npt_limite_articulo_td.CANTIDAD%TYPE,
      strError              out varchar2
   );

   PROCEDURE NP_VALIDA_SOBRE_STOCK  (
      V_COD_TIPO_CANAL IN NPT_LIMITE_ART_CANAL_TD.COD_TIPO_CANAL%TYPE,
      V_COD_ARTICULO IN NPT_LIMITE_ART_CANAL_TD.COD_ARTICULO%TYPE,
      V_CANTIDAD OUT NPT_LIMITE_ART_CANAL_TD.CANTIDAD%TYPE,
      STRERROR  OUT VARCHAR2
   );

   PROCEDURE NP_VALIDA_SOBRE_STOCK_VAL  (
      V_COD_TIPO_CANAL      IN NPT_LIMITE_ART_CANAL_TD.COD_TIPO_CANAL%TYPE,
      V_COD_ARTICULO         IN NPT_LIMITE_ART_CANAL_TD.COD_ARTICULO%TYPE,
      V_TIP_STOCK                IN NPT_LIMITE_ART_CANAL_TD.TIP_STOCK%TYPE,
      V_COD_USO                  IN NPT_LIMITE_ART_CANAL_TD.COD_USO%TYPE,
      V_CANTIDAD                 OUT NPT_LIMITE_ART_CANAL_TD.CANTIDAD%TYPE,
      STRERROR                    OUT VARCHAR2
   );

   PROCEDURE NP_VALIDA_SOBRE_STOCK_INT (
      V_COD_TIPO_CANAL      IN NPT_LIMITE_ART_CANAL_TD.COD_TIPO_CANAL%TYPE,
      V_COD_USUARIO           IN NPT_LIMITE_ART_CANAL_TD.COD_USUARIO%TYPE,
      V_COD_ARTICULO         IN NPT_LIMITE_ART_CANAL_TD.COD_ARTICULO%TYPE,
      V_TIP_STOCK                IN NPT_LIMITE_ART_CANAL_TD.TIP_STOCK%TYPE,
      V_COD_USO                  IN NPT_LIMITE_ART_CANAL_TD.COD_USO%TYPE,
      V_CANTIDAD                 OUT NPT_LIMITE_ART_CANAL_TD.CANTIDAD%TYPE,
      STRERROR                    OUT VARCHAR2
   );

   PROCEDURE NP_CANTIDAD_SOBRE_STOCK  (
      V_COD_TIPO_CANAL IN NPT_LIMITE_ART_CANAL_TD.COD_TIPO_CANAL%TYPE,
      V_COD_ARTICULO    IN NPT_LIMITE_ART_CANAL_TD.COD_ARTICULO%TYPE,
      V_CANTIDAD            OUT NPT_LIMITE_ART_CANAL_TD.CANTIDAD%TYPE,
      STRERROR               OUT VARCHAR2
   );

   PROCEDURE NP_CANTIDAD_SOBRE_STOCK_INT  (
      V_COD_TIPO_CANAL      IN NPT_LIMITE_ART_CANAL_TD.COD_TIPO_CANAL%TYPE,
      V_COD_ARTICULO         IN NPT_LIMITE_ART_CANAL_TD.COD_ARTICULO%TYPE,
      V_TIP_STOCK                IN NPT_LIMITE_ART_CANAL_TD.TIP_STOCK%TYPE,
      V_COD_USO                  IN NPT_LIMITE_ART_CANAL_TD.COD_USO%TYPE,
      V_CANTIDAD                 OUT NPT_LIMITE_ART_CANAL_TD.CANTIDAD%TYPE,
      STRERROR                    OUT VARCHAR2
   );

   PROCEDURE NP_GET_ARTICULO_TRANSITO  (
      v_cod_tipo_canal in npt_limite_Art_canal_td.COD_TIPO_CANAL%TYPE,
      v_cod_usuario in npt_limite_articulo_td.COD_USUARIO%TYPE,
      v_cod_articulo in npt_limite_articulo_td.COD_ARTICULO%TYPE,
      v_tip_stock in npt_limite_articulo_td.TIP_STOCK%TYPE,
      v_cod_uso in npt_limite_articulo_td.COD_USO%TYPE,
      v_cantidad out npt_limite_articulo_td.CANTIDAD%TYPE,
      strError  out varchar2
   );

   PROCEDURE NP_INSERTA_EXCEDENTE_STOCK_PR (
      v_cod_tipo_canal in NPT_REGISTRO_EXCEDENTE_TD.COD_DISTRIBUIDOR%TYPE,
      v_cod_articulo IN NPT_REGISTRO_EXCEDENTE_TD.COD_ARTICULO%TYPE,
      v_can_proyectada IN NPT_REGISTRO_EXCEDENTE_TD.CANTIDAD_PROYECTADA%TYPE ,
      v_can_consumida IN NPT_REGISTRO_EXCEDENTE_TD.CANTIDAD_CONSUMIDA%TYPE ,
      v_can_proyectada_c IN NPT_REGISTRO_EXCEDENTE_TD.CANTIDAD_PROYECTADA%TYPE ,
      v_can_proy_ind_c IN NPT_REGISTRO_EXCEDENTE_TD.CANTIDAD_PROYECTADA_CANAL%TYPE ,
      v_cantidad_sol IN NPT_REGISTRO_EXCEDENTE_TD.CANTIDAD_SOLICITADA%TYPE ,
      v_saldo_individual IN NPT_REGISTRO_EXCEDENTE_TD.SALDO_INDIVIDUAL%TYPE,
      v_saldo_sobre_stock IN NPT_REGISTRO_EXCEDENTE_TD.SALDO_SOBRESTOCK%tYPE,
      strError         out varchar2
   );
END;
/

