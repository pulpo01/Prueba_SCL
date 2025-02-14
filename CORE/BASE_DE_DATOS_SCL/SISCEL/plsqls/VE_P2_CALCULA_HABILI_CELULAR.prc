CREATE OR REPLACE PROCEDURE        VE_P2_CALCULA_HABILI_CELULAR(
 vp_cod_vendedor IN VE_VENDEDORES.COD_VENDEDOR%TYPE,
 vp_num_liquidacion VE_CABLIQUIDAC.NUM_LIQUIDACION%TYPE,
 vp_producto IN GE_PRODUCTOS.COD_PRODUCTO%TYPE,
 vp_ctoliq  IN VE_CTOLIQ.COD_CTOLIQ%TYPE,
 vp_cod_tip_cuad IN VE_CTOLIQ.COD_TIPOCUAD%TYPE,
 vp_cat_vendedor IN VE_CATCOMIS.COD_CATCOMIS%TYPE,
 vp_tip_vendedor IN VE_TIPCOMIS.COD_TIPCOMIS%TYPE,
 vp_ind_nivel  IN VE_CATCOMIS.IND_NIVEL%TYPE,
 vp_fecha_inicial IN DATE,
 vp_fecha_final   IN DATE,
 vp_num_habi_celu IN OUT NUMBER,
 vp_num_habi_beep IN OUT NUMBER,
 vp_num_habi_celu_meta OUT NUMBER
)
IS
  vp_mensaje            VARCHAR2(120):=' ';
  vp_procedure          VARCHAR2(30):='VE_P2_calcula_habili_celular';
  vp_tabla              VARCHAR2(30):='GA_ABOCEL';
  vp_accion             VARCHAR2(1):='S';
  vp_AC                 VARCHAR2(2) := 'AC';
  vp_AMI                VARCHAR2(3) := 'AMI';
vp_1                  GA_CAUSABAJA.COD_PRODUCTO%TYPE := 1;
vp_Y                  VARCHAR2(3) := 'Y';
vp_Z                  VARCHAR2(3) := 'Z';
vp_ZZ                 VARCHAR2(3) := 'ZZ';
vp_90                 VARCHAR2(3) := '90';
vp_91                 VARCHAR2(3) := '91';
-- CAUSAS DE BAJA
vp_10                 VARCHAR2(2) := '10';
vp_11                 VARCHAR2(2) := '11';
vp_13                 VARCHAR2(2) := '13';
vp_15                 VARCHAR2(2) := '15';
vp_16                 VARCHAR2(2) := '16';
vp_19                 VARCHAR2(2) := '19';
vp_20                 VARCHAR2(2) := '20';
vp_21                 VARCHAR2(2) := '21';
vp_30                 VARCHAR2(2) := '30';
vp_38                 VARCHAR2(2) := '38';
vp_39                 VARCHAR2(2) := '39';
vp_43                 VARCHAR2(2) := '43';
vp_46                 VARCHAR2(2) := '46';
vp_80                 VARCHAR2(2) := '80';
vp_81                 VARCHAR2(2) := '81';
--
vp_BF	                VARCHAR2(2) := 'BF';
vp_0                  NUMBER := 0;
vp_sqlcode            VARCHAR2(10);
vp_sqlerrm            VARCHAR2(70);
vp_num_habi_vtas_pf   NUMBER := 0;
vp_num_habi_meta_pf   NUMBER := 0;
vp_num_habilit_meta   NUMBER := 0;
vp_num_habi_normales  NUMBER := 0;
vp_num_habilitaciones NUMBER := 0;
vp_num_bajas_A        NUMBER := 0;
vp_num_bajas_B        NUMBER := 0;
vp_num_bajas          NUMBER := 0;
BEGIN
VE_P2_calcula_habili_pf(vp_cod_vendedor,vp_num_liquidacion,vp_producto,vp_ctoliq,vp_cod_tip_cuad,vp_cat_vendedor,vp_tip_vendedor,vp_ind_nivel,vp_fecha_inicial,vp_fecha_final,vp_num_habi_vtas_pf,vp_num_habi_meta_pf);
IF vp_ind_nivel > 0 THEN
   SELECT COUNT(*)
    INTO vp_num_habi_normales
    FROM TA_PLANTARIF TA_PLANTARIF,
         GA_ABOCEL GA_ABOCEL,
         VE_VENDEDORES  VE_VENDEDORES,
         GA_VENTAS GA_VENTAS
    WHERE TA_PLANTARIF.IND_FAMILIAR = vp_0 AND     /* el plan no debe ser familiar */
          TA_PLANTARIF.COD_PLANTARIF = GA_ABOCEL.COD_PLANTARIF AND
          TA_PLANTARIF.COD_PRODUCTO = GA_ABOCEL.COD_PRODUCTO AND
          NOT EXISTS (SELECT ROWID
                      FROM GA_TRASPABO GA_TRASPABO
                      WHERE GA_TRASPABO.NUM_ABONADO = GA_ABOCEL.NUM_ABONADO) AND
          GA_ABOCEL.NUM_VENTA =  GA_VENTAS.NUM_VENTA AND
          GA_VENTAS.FEC_VENTA >= vp_fecha_inicial AND
          GA_VENTAS.FEC_VENTA < vp_fecha_final AND
          GA_VENTAS.IND_ESTVENTA =vp_AC AND
          GA_VENTAS.COD_VENDEDOR = VE_VENDEDORES.COD_VENDEDOR  AND
          VE_VENDEDORES.COD_VENDE_RAIZ = vp_cod_vendedor AND
          GA_ABOCEL.COD_PLANTARIF NOT IN (vp_AMI, vp_Y, vp_Z, vp_ZZ, vp_90, vp_91);
   IF vp_cat_vendedor = 1 THEN   /* categoria de comisionista Master Dealer */
      SELECT COUNT(*)
       INTO vp_num_bajas_A
       FROM GA_ABOCEL GA_ABOCEL,
            GA_VENTAS GA_VENTAS,
            VE_VENDEDORES VE_VENDEDORES
       WHERE GA_ABOCEL.COD_CAUSABAJA <> vp_39 AND      /* la baja no debe ser por traspaso */
             GA_ABOCEL.COD_CAUSABAJA = (SELECT COD_CAUSABAJA
                                         FROM GA_CAUSABAJA
                                         WHERE COD_CAUSABAJA IN (vp_10,vp_11,vp_13,vp_15,vp_16,vp_19,
                                                                 vp_20,vp_21,
                                                                 vp_30,vp_38,
                                                                 vp_43,vp_46,
                                                                 vp_80,vp_81) AND
                                               COD_CAUSABAJA = GA_ABOCEL.COD_CAUSABAJA AND
                                               COD_PRODUCTO = vp_1
                                        ) AND
             GA_ABOCEL.FEC_BAJA >= vp_fecha_inicial AND
             GA_ABOCEL.FEC_BAJA < vp_fecha_final AND
             GA_ABOCEL.FEC_BAJA <= ADD_MONTHS(GA_VENTAS.FEC_VENTA,6) AND
             GA_ABOCEL.COD_PLANTARIF NOT IN (vp_AMI, vp_Y, vp_Z, vp_ZZ, vp_90, vp_91) AND
             GA_ABOCEL.NUM_VENTA = GA_VENTAS.NUM_VENTA AND
             GA_VENTAS.IND_ESTVENTA = vp_AC AND
             GA_VENTAS.COD_VENDEDOR = VE_VENDEDORES.COD_VENDEDOR AND
             VE_VENDEDORES.COD_VENDE_RAIZ = vp_cod_vendedor;
--      SELECT COUNT(*)
--       INTO vp_num_bajas_B
--       FROM CO_EVENTOS CO_EVENTOS,
--            CO_ABONADOEVENTO CO_ABONADOEVENTO,
--            GA_ABOCEL GA_ABOCEL,
--            GA_VENTAS GA_VENTAS,
--            VE_VENDEDORES VE_VENDEDORES
--       WHERE CO_EVENTOS.COD_ESTADO = vp_BF AND
--             CO_EVENTOS.COD_EVENTO = CO_ABONADOEVENTO.COD_EVENTO AND
--             CO_ABONADOEVENTO.FECHA_ALTA >= vp_fecha_inicial AND
--             CO_ABONADOEVENTO.FECHA_ALTA < vp_fecha_final AND
--             CO_ABONADOEVENTO.FECHA_ALTA <= ADD_MONTHS(GA_VENTAS.FEC_VENTA,6) AND
--             CO_ABONADOEVENTO.NUM_ABONADO = GA_ABOCEL.NUM_ABONADO AND
--             CO_ABONADOEVENTO.COD_CLIENTE = GA_ABOCEL.COD_CLIENTE AND
--             GA_ABOCEL.FEC_BAJA IS NULL AND
--             GA_ABOCEL.COD_PLANTARIF NOT IN (vp_AMI, vp_Y, vp_Z, vp_ZZ, vp_90, vp_91) AND
--             GA_ABOCEL.NUM_VENTA = GA_VENTAS.NUM_VENTA AND
--             GA_VENTAS.IND_ESTVENTA = vp_AC AND
--             GA_VENTAS.COD_VENDEDOR = VE_VENDEDORES.COD_VENDEDOR AND
--             VE_VENDEDORES.COD_VENDE_RAIZ = vp_cod_vendedor;
--
      vp_num_bajas := vp_num_bajas_A + vp_num_bajas_B;
--
   END IF;
ELSE
   SELECT COUNT(*)
    INTO  vp_num_habi_normales
    FROM TA_PLANTARIF TA_PLANTARIF,
         GA_ABOCEL GA_ABOCEL,
         GA_VENTAS GA_VENTAS
    WHERE TA_PLANTARIF.IND_FAMILIAR = vp_0 AND
          TA_PLANTARIF.COD_PLANTARIF = GA_ABOCEL.COD_PLANTARIF AND
          TA_PLANTARIF.COD_PRODUCTO = GA_ABOCEL.COD_PRODUCTO AND
          NOT EXISTS (SELECT ROWID
                      FROM GA_TRASPABO GA_TRASPABO
                      WHERE GA_TRASPABO.NUM_ABONADO = GA_ABOCEL.NUM_ABONADO) AND
          GA_VENTAS.COD_VENDEDOR = vp_cod_vendedor AND
          GA_VENTAS.FEC_VENTA >= vp_fecha_inicial AND
          GA_VENTAS.FEC_VENTA < vp_fecha_final AND
          GA_VENTAS.IND_ESTVENTA =vp_AC AND
          GA_VENTAS.NUM_VENTA = GA_ABOCEL.NUM_VENTA AND
          GA_ABOCEL.COD_PLANTARIF NOT IN (vp_AMI, vp_Y, vp_Z, vp_ZZ, vp_90, vp_91);
END IF;
--
vp_num_habilitaciones := vp_num_habi_vtas_pf + vp_num_habi_normales;
IF vp_num_bajas > vp_num_habilitaciones THEN
   vp_num_habi_celu := 0;
ELSE
   vp_num_habi_celu := vp_num_habilitaciones - vp_num_bajas;
END IF;
--
vp_num_habilit_meta := vp_num_habi_meta_pf + vp_num_habi_normales;
IF vp_num_bajas > vp_num_habilit_meta THEN
   vp_num_habi_celu_meta := 0;
ELSE
   vp_num_habi_celu_meta := vp_num_habilit_meta - vp_num_bajas;
END IF;
--
EXCEPTION WHEN NO_DATA_FOUND THEN
vp_sqlcode := sqlcode;
vp_sqlerrm := sqlerrm;
VE_P2_insanomliq(vp_num_liquidacion,vp_mensaje,vp_procedure,vp_tabla,vp_accion,vp_sqlcode,vp_sqlerrm);
END VE_P2_calcula_habili_celular;
/
SHOW ERRORS
