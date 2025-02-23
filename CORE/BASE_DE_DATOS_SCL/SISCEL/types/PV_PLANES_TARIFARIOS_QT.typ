CREATE OR REPLACE TYPE PV_PLANES_TARIFARIOS_QT AS OBJECT
(
COD_CLIENTE 	  	   		NUMBER(8),
COD_PLANTARIF 	  			VARCHAR2(3),
TIP_PLANTARIF 	  			VARCHAR2(1),
COD_TIPLAN 		  			VARCHAR2(5),
COD_TECNOLOGIA 	  			VARCHAR2(7),
NUM_ABONADO 	  			NUMBER(8),
NOM_USUARORA 	  			VARCHAR2(30),
CAMBIO_PLANFAMILIAR		VARCHAR2(5),
COD_PLANTARIF_NUEVO			VARCHAR2(3),
COD_CATEGORIA				VARCHAR2(3)
)
/
SHOW ERRORS
