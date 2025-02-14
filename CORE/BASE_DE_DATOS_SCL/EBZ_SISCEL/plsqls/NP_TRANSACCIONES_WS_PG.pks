CREATE OR REPLACE PACKAGE NP_TRANSACCIONES_WS_PG
 IS

  TYPE refCursor IS REF CURSOR;

  PROCEDURE NP_INSERT_VALI_SERIES_TO_PR(EN_codPedido  IN npt_serie_pedido.cod_pedido%TYPE,
									   EN_linPedido   IN npt_serie_pedido.lin_det_pedido%TYPE,
									   EV_codSerie    IN Varchar2,
									   EV_codBarra    IN npt_serie_pedido.cod_bar_ser_pedido%TYPE);

  PROCEDURE GRABAERROR_VALIDASERIES(cError    IN NUMBER,
								   pCodPedido IN npt_pedido.COD_PEDIDO%TYPE,                                  
                                   pLinPedido IN npt_detalle_pedido.lin_det_PEDIDO%TYPE,
								   v_serie    IN NP_VALIDACION_SERIES_TO.num_serie%TYPE);

  PROCEDURE NP_VALIDASERIES_PR(pCodPedido IN npt_pedido.COD_PEDIDO%TYPE,
   							   msgError   OUT varchar2);

  PROCEDURE NP_ORIGENVENTA_PR(evNumSerie  	IN  al_series.num_serie%TYPE,
		  					enTipoProceso	IN PLS_INTEGER,
							svCod_Uso 		OUT al_series.cod_uso%TYPE,
							svDes_Uso 		OUT al_usos.des_uso%TYPE,
							svCod_Articulo 	OUT al_series.cod_articulo%TYPE,
							svDes_Articulo 	OUT al_articulos.des_articulo%TYPE,
							ERRORNEG 	  	OUT VARCHAR2);
  FUNCTION NP_CARACTERVALIDO_FN(EV_CadenaEntrada IN  VARCHAR2,
                                EV_CadenaValida  IN  VARCHAR2
				) RETURN VARCHAR2;

/* CO-200605050103 Se incorpora validación del total de lineas del detalle del pedido que se esta grabando */
  FUNCTION NP_VALIDA_AL_CARGOS_FN
  (EN_codPedido      IN npt_detalle_pedido.cod_pedido%TYPE,
  EN_lindetPedido    IN npt_detalle_pedido.LIN_DET_PEDIDO%TYPE,
  EN_Cantidadlinea   IN npt_detalle_pedido.CAN_DETALLE_PEDIDO%TYPE
  ) RETURN number;
/* CO-200605050103 Fin */
FUNCTION NP_VALIDA_MAYORISTA_FN(
  EN_codPedido      IN npt_detalle_pedido.cod_pedido%type
) RETURN NUMBER;

FUNCTION NP_VALIDA_NUMERACION_FN(
  EN_serie  		in	npt_serie_pedido.cod_serie_pedido%type
) RETURN NUMBER;

END NP_TRANSACCIONES_WS_PG;
/
