CREATE OR REPLACE TYPE PV_LIMITE_CONSUMO_QT AS OBJECT
(SUJETO			  	   	  NUMBER(8),
TIP_SUJETO     			  VARCHAR2(2),
FEC_DES   				  VARCHAR2(20),
FEC_HAS   				  VARCHAR2(20),
COD_ACTABO 				  VARCHAR2(2),
COD_PLANTARIF_NUEVO		  VARCHAR2(3),
TIPO_MOVIMIENTO			  VARCHAR2(3),
COD_PRODUCTO    		  NUMBER(1)
)
/
SHOW ERRORS
