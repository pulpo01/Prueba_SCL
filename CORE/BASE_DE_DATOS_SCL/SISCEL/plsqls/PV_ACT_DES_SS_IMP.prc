CREATE OR REPLACE procedure PV_ACT_DES_SS_IMP (V_NUM_CELULAR IN NUMBER,
 V_SERVICIOS   IN VARCHAR2,
 V_OPERACION   IN VARCHAR2
 )
IS
  VP_NUM_OS       CI_ORSERV.NUM_OS%TYPE;
  V_COD_CUENTA    GA_ABOAMIST.COD_CUENTA%TYPE;
  V_COD_CLIENTE   GA_ABOAMIST.COD_CLIENTE%TYPE;
  V_NUM_ABONADO   GA_ABOAMIST.NUM_ABONADO%TYPE;
  V_TRANSAC	      NUMBER(9);
  ERROR_PROCESO   EXCEPTION;


BEGIN

SELECT COD_CUENTA,COD_CLIENTE,NUM_ABONADO
INTO V_COD_CUENTA,V_COD_CLIENTE,V_NUM_ABONADO
FROM GA_ABOAMIST
WHERE NUM_CELULAR = V_NUM_CELULAR
AND COD_SITUACION = 'AAA';

SELECT GA_SEQ_TRANSACABO.NEXTVAL INTO V_TRANSAC FROM DUAL;

SELECT CI_SEQ_NUMOS.NEXTVAL INTO VP_NUM_OS FROM DUAL;

INSERT INTO pv_iorserv(num_os,cod_os,num_ospadre,descripcion,fecha_ing,producto,usuario,status,tip_procesa,fh_ejecucion,
cod_estado,cod_modgener,num_osf,tip_subsujeto,tip_sujeto,path_file,nfile)
VALUES (VP_NUM_OS,'10120',NULL,'ACTIVACION/DESACTIVACION SERVICIOS SUPLEMENTARIOS',SYSDATE,1,'SISCEL','en proceso',1,
to_date('','DD-MM-YYYY'),10,'ACF',0,'','A','','');

INSERT INTO pv_erecorrido(num_os,cod_estado,descripcion,tip_estado,fec_ingestado)
VALUES(VP_NUM_OS,10,'PROC. INSCRIPCION EN INTERFAZ',1,SYSDATE);

INSERT INTO pv_movimientos(num_os,ord_comando,cod_actabo,ind_estado)
VALUES(VP_NUM_OS,1,'SS','1');

IF V_OPERACION = 'D' THEN

INSERT INTO pv_camcom(
num_os, -- 1
num_abonado, -- 2
num_celular, -- 3
cod_cliente, -- 4
cod_cuenta, -- 5
cod_producto, -- 6
bdatos, -- 7
num_venta, -- 8
num_transaccion, -- 9
num_folio, -- 10
num_cuotas, -- 11
num_proceso, -- 12
cod_actabo, --13
fh_anula, -- 14
cat_tribut, -- 15
cod_estadoc, -- 16
cod_causaelim, -- 17
fec_vencimiento, -- 18
clase_servicio_act, -- 19
clase_servicio_des, -- 20
ind_central_ss, -- 21
ind_portable, -- 22
tip_terminal, -- 23
tip_susp_avsinie, -- 24
pref_plaza) -- 25
VALUES(
VP_NUM_OS, -- 1
V_NUM_ABONADO, -- 2
V_NUM_CELULAR, -- 3
V_COD_CLIENTE, -- 4
V_COD_CUENTA, -- 5
1, -- 6
'SCEL', -- 7
NULL, -- 8
V_TRANSAC, -- 9
NULL, -- 10
NULL, -- 11
0, -- 12
'SS', -- 13
NULL, -- 14
NULL, -- 15
0, -- 16
NULL, -- 17
NULL, -- 18
NULL, -- 19
V_SERVICIOS, -- 20
NULL, -- 21
0,-- 22
'', -- 23
'', -- 24
''); -- 25

ELSE

INSERT INTO pv_camcom(
num_os, -- 1
num_abonado, -- 2
num_celular, -- 3
cod_cliente, -- 4
cod_cuenta, -- 5
cod_producto, -- 6
bdatos, -- 7
num_venta, -- 8
num_transaccion, -- 9
num_folio, -- 10
num_cuotas, -- 11
num_proceso, -- 12
cod_actabo, --13
fh_anula, -- 14
cat_tribut, -- 15
cod_estadoc, -- 16
cod_causaelim, -- 17
fec_vencimiento, -- 18
clase_servicio_act, -- 19
clase_servicio_des, -- 20
ind_central_ss, -- 21
ind_portable, -- 22
tip_terminal, -- 23
tip_susp_avsinie, -- 24
pref_plaza) -- 25
VALUES(
VP_NUM_OS, -- 1
V_NUM_ABONADO, -- 2
V_NUM_CELULAR, -- 3
V_COD_CLIENTE, -- 4
V_COD_CUENTA, -- 5
1, -- 6
'SCEL', -- 7
NULL, -- 8
V_TRANSAC, -- 9
NULL, -- 10
NULL, -- 11
0, -- 12
'SS', -- 13
NULL, -- 14
NULL, -- 15
0, -- 16
NULL, -- 17
NULL, -- 18
V_SERVICIOS, -- 19
NULL, -- 20
NULL, -- 21
0,-- 22
'', -- 23
'', -- 24
''); -- 25

END IF;

UPDATE pv_iorserv SET status='Proceso exitoso'
WHERE num_os=VP_NUM_OS;

UPDATE pv_erecorrido SET descripcion='PROC. INSCRIPCION EN INTERFAZ',tip_estado=3
WHERE num_os=VP_NUM_OS;

END;
/
SHOW ERRORS
