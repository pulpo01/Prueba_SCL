CREATE OR REPLACE PACKAGE NP_LIMITE_ARTICULOS_PG IS
/*
<NOMBRE>           : NP_LIMITE_ARTICULOS_PG  .</NOMBRE>
<FECHACREA>        : 22-11-2011<FECHACREA/>
<MODULO >          : Logistica </MODULO >
<AUTOR >       :  ANGELO FLORES</AUTOR >
<VERSION >     : 1.0</VERSION >
<DESCRIPCION>  : Inserta registro en tabla de limite de articulos para ventas al distribuidor</DESCRIPCION>
*/

    TYPE refcursor IS REF CURSOR;
    CV_error_no_clasif  CONSTANT VARCHAR2(50):= 'No es posible clasificar el error';


        PROCEDURE NP_INSERTA_LIMITE_ARTICULO_PR  (v_cod_usuario     in  NPT_LIMITE_ARTICULO_TD.COD_USUARIO%TYPE,
                                                   v_cod_articulo   in  NPT_LIMITE_ARTICULO_TD.COD_ARTICULO%TYPE,
                                                   v_tip_stock      in  NPT_LIMITE_ARTICULO_TD.TIP_STOCK%TYPE,
                                                   v_cod_uso        in  NPT_LIMITE_ARTICULO_TD.COD_USO%TYPE,
                                                   v_cantidad       in  NPT_LIMITE_ARTICULO_TD.CANTIDAD%TYPE,
                                                   v_operacion      in  varchar2,
                                                   v_fec_desde      in  varchar2,
                                                   v_fec_hasta      in  varchar2,
                                                   v_fec_desde_new  in  varchar2,
                                                   v_fec_hasta_new  in  varchar2,
                                                   strError         out varchar2);

        PROCEDURE NP_VALIDA_CANTIDAD_LIMITE  (v_cod_usuario in NPT_LIMITE_ARTICULO_TD.COD_USUARIO%TYPE,
                                                   v_cod_articulo in NPT_LIMITE_ARTICULO_TD.COD_ARTICULO%TYPE,
                                                   v_tip_stock in NPT_LIMITE_ARTICULO_TD.TIP_STOCK%TYPE,
                                                   v_cod_uso in NPT_LIMITE_ARTICULO_TD.COD_USO%TYPE,
                                                   v_cantidad out NPT_LIMITE_ARTICULO_TD.CANTIDAD%TYPE,
                                                   strError  out varchar2);


        PROCEDURE NP_INSERTA_ERRORES(           v_cod_retorno           in ge_errores_pg.CodError,
                                                v_componente_error      in  ge_errores_pg.DesEvent,
                                                v_error_desc            in VARCHAR2);



PROCEDURE NP_GET_LIMITE_ARTICULO  (v_cod_usuario in NPT_LIMITE_ARTICULO_TD.COD_USUARIO%TYPE,
                                                   v_cod_articulo in NPT_LIMITE_ARTICULO_TD.COD_ARTICULO%TYPE,
                                                   v_tip_stock in NPT_LIMITE_ARTICULO_TD.TIP_STOCK%TYPE,
                                                   v_cod_uso in NPT_LIMITE_ARTICULO_TD.COD_USO%TYPE,
                                                   v_cantidad out NPT_LIMITE_ARTICULO_TD.CANTIDAD%TYPE,
                                                   strError  out varchar2);

   PROCEDURE NP_GET_ARTICULO_TRANSITO  (v_cod_usuario in NPT_LIMITE_ARTICULO_TD.COD_USUARIO%TYPE,
                                                       v_cod_articulo in NPT_LIMITE_ARTICULO_TD.COD_ARTICULO%TYPE,
                                                       v_tip_stock in NPT_LIMITE_ARTICULO_TD.TIP_STOCK%TYPE,
                                                       v_cod_uso in NPT_LIMITE_ARTICULO_TD.COD_USO%TYPE,
                                                       v_cantidad out NPT_LIMITE_ARTICULO_TD.CANTIDAD%TYPE,
                                                       strError  out varchar2);


END; 
/

