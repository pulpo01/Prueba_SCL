CREATE OR REPLACE TYPE PV_GAT_DEVLEQUIP_QT AS OBJECT
	(
	 cod_concepto     NUMBER(9),
	 cod_producto 	  NUMBER(1),
	 cod_categoria 	  VARCHAR2(3),
	 cod_modpago 	  NUMBER(2),
	 cod_estado_dev   VARCHAR2(5),
	 cod_tipcontrato  VARCHAR2(3),
	 num_meses		  NUMBER(2),
	 cod_antiguedad   VARCHAR2(3),
	 cod_operacion 	  VARCHAR2(5),
	 ind_causa 		  NUMBER(1),
	 cod_causa        VARCHAR2(2),
	 des_concepto     VARCHAR2(60),
	 cod_moneda       VARCHAR2(3),
	 imp_dev_equipo   NUMBER (14,4),
	 imp_dev_Acc      NUMBER (14,4),
	 des_moneda       VARCHAR2(20)
	)
/
SHOW ERRORS
