CREATE OR REPLACE PACKAGE Co_Aplica_Pago_Distribuidor_PG IS

PROCEDURE Co_P_APLICA_PAGO (lCod_cliente  IN NUMBER ,
    			    vp_Imp_pago   IN NUMBER,
    			    vp_folio 	  IN NUMBER ,
    			    vp_plaza      IN VARCHAR2,
    			    vp_OutGlosa   OUT VARCHAR2,
    			    vp_OutRetorno OUT NUMBER  );

PROCEDURE CO_P_BUSCA_PAGOS;

vp_Gls_Error        VARCHAR2(255);

END Co_Aplica_Pago_Distribuidor_PG;
/
SHOW ERRORS
