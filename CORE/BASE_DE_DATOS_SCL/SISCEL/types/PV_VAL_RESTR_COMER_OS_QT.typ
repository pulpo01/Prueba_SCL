CREATE OR REPLACE TYPE PV_VAL_RESTR_COMER_OS_QT AS OBJECT
(
NUM_TRANSACCION   	   NUMBER   (09),
COD_ACTUACION    	   VARCHAR2 (02),
COD_EVENTO       	   VARCHAR2 (10),
PROGRAMA		 	   VARCHAR2 (22),
PROCESO			 	   VARCHAR2 (30),
NUM_ABONADO 	 	   NUMBER   (08),
COD_CLIENTE 	 	   NUMBER   (08),
COD_MODGENER	 	   VARCHAR2 (03),
NUM_VENTA	 	       NUMBER   (10),
COD_OOSS		 	   VARCHAR2 (05),
COD_VENDEDOR	 	   VARCHAR2 (30),
DESACTIVACION_SS 	   NUMBER   (03),
PLAN_DESTINO  	 	   VARCHAR2 (03),
COD_USO  			   NUMBER   (02),
COD_CUENTA_ORIGEN	   NUMBER   (08),
COD_CUENTA_DESTINO	   NUMBER   (08),
COD_CLIENTE_DESTINO	   NUMBER   (08),
TIPO_PLAN		 	   VARCHAR2 (01),
TIPO_PLAN_DESTINO 	   VARCHAR2 (01),
NUM_CICLO	   		   NUMBER   (10),
FECHA_SISTEMA	 	   DATE,
RESTRICCION_AUXILIAR   VARCHAR2 (10),
COD_MODULO			   VARCHAR2 (02),
COD_TAREA			   NUMBER   (06),
COD_CENTRAL	 	       NUMBER   (03)
)
/
SHOW ERRORS
