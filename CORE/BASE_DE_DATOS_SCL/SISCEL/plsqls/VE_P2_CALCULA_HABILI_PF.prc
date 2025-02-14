CREATE OR REPLACE PROCEDURE        VE_P2_CALCULA_HABILI_PF(
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
 vp_num_habi_vtas_pf OUT NUMBER,
 vp_num_habi_meta_pf OUT NUMBER
)
IS
-- CONSTANTES
vp_AC                 VARCHAR2(2) := 'AC';
vp_AMI                VARCHAR2(3) := 'AMI';
vp_Y                  VARCHAR2(3) := 'Y';
vp_Z                  VARCHAR2(3) := 'Z';
vp_ZZ                 VARCHAR2(3) := 'ZZ';
vp_90                 VARCHAR2(3) := '90';
vp_91                 VARCHAR2(3) := '91';
vp_39	              VARCHAR2(2) := '39';
p_BF	              VARCHAR2(2) := 'BF';
vp_1                  NUMBER := 1;
-- VARIABLES AUXILIARES
vp_cod_cliente_anterior GA_ABOCEL.COD_CLIENTE%TYPE := 0;
-- ACUMULADORES
vp_num_habilitac_vtas NUMBER := 0;
vp_num_habilitac_meta NUMBER := 0;
-- VARIABLES PARA INFORME DE ERRORES
vp_mensaje            VARCHAR2(120):=' ';
vp_procedure          VARCHAR2(30):='VE_P2_calcula_habili_pf';
vp_tabla              VARCHAR2(30):='GA_ABOCEL';
vp_accion             VARCHAR2(1):='S';
vp_sqlcode            VARCHAR2(10);
vp_sqlerrm            VARCHAR2(70);
--
CURSOR NIVEL1 IS
   SELECT GA_ABOCEL.COD_CLIENTE,
          GA_ABOCEL.COD_PLANTARIF,
          TA_PLANTARIF.IND_FAMILIAR
    FROM TA_PLANTARIF TA_PLANTARIF,
         GA_ABOCEL GA_ABOCEL,
         VE_VENDEDORES  VE_VENDEDORES,
         GA_VENTAS GA_VENTAS
    WHERE TA_PLANTARIF.COD_PLANTARIF = GA_ABOCEL.COD_PLANTARIF AND
          TA_PLANTARIF.COD_PRODUCTO = GA_ABOCEL.COD_PRODUCTO AND
          NOT EXISTS (SELECT ROWID
                      FROM GA_TRASPABO GA_TRASPABO
                      WHERE GA_TRASPABO.NUM_ABONADO = GA_ABOCEL.NUM_ABONADO) AND
          VE_VENDEDORES.COD_VENDEDOR = GA_VENTAS.COD_VENDEDOR  AND
          GA_VENTAS.FEC_VENTA >= vp_fecha_inicial AND
          GA_VENTAS.FEC_VENTA < vp_fecha_final AND
          GA_VENTAS.NUM_VENTA = GA_ABOCEL.NUM_VENTA AND
          GA_VENTAS.IND_ESTVENTA =vp_AC AND
          VE_VENDEDORES.COD_VENDE_RAIZ = vp_cod_vendedor AND
          GA_ABOCEL.COD_PLANTARIF NOT IN (vp_AMI, vp_Y, vp_Z, vp_ZZ, vp_90, vp_91)
    ORDER BY GA_ABOCEL.COD_CLIENTE, GA_VENTAS.FEC_VENTA;
NIVEL1_VENTAS_CLIENTE        nivel1%ROWTYPE;
--
CURSOR NIVEL0 IS
   SELECT GA_ABOCEL.COD_CLIENTE,
          GA_ABOCEL.COD_PLANTARIF,
          TA_PLANTARIF.IND_FAMILIAR
    FROM TA_PLANTARIF TA_PLANTARIF,
         GA_ABOCEL GA_ABOCEL,
         GA_VENTAS GA_VENTAS
    WHERE TA_PLANTARIF.COD_PLANTARIF = GA_ABOCEL.COD_PLANTARIF AND
          TA_PLANTARIF.COD_PRODUCTO = GA_ABOCEL.COD_PRODUCTO AND
          NOT EXISTS (SELECT ROWID
                      FROM GA_TRASPABO GA_TRASPABO
                      WHERE GA_TRASPABO.NUM_ABONADO = GA_ABOCEL.NUM_ABONADO) AND
          GA_ABOCEL.NUM_VENTA = GA_VENTAS.NUM_VENTA AND
          GA_VENTAS.FEC_VENTA >= vp_fecha_inicial AND
          GA_VENTAS.FEC_VENTA < vp_fecha_final AND
          GA_VENTAS.IND_ESTVENTA =vp_AC AND
          GA_VENTAS.COD_VENDEDOR = vp_cod_vendedor AND
          GA_ABOCEL.COD_PLANTARIF NOT IN (vp_AMI, vp_Y, vp_Z, vp_ZZ, vp_90, vp_91)
    ORDER BY GA_ABOCEL.COD_CLIENTE, GA_VENTAS.FEC_VENTA;
NIVEL0_VENTAS_CLIENTE        NIVEL0%ROWTYPE;
--
BEGIN
IF vp_ind_nivel > 0 THEN
   OPEN NIVEL1;
   LOOP
      FETCH NIVEL1 INTO NIVEL1_VENTAS_CLIENTE;
      EXIT WHEN NIVEL1%NOTFOUND;
      IF NIVEL1_VENTAS_CLIENTE.IND_FAMILIAR = 1 THEN -- Solo se calculan Planes Familiares
         IF NIVEL1_VENTAS_CLIENTE.COD_CLIENTE <> vp_cod_cliente_anterior THEN
            vp_num_habilitac_vtas := vp_num_habilitac_vtas + 1;
         END IF;
         vp_num_habilitac_meta := vp_num_habilitac_meta + 1;
      END IF;
      vp_cod_cliente_anterior := NIVEL1_VENTAS_CLIENTE.COD_CLIENTE;
   END LOOP;
ELSE
   OPEN NIVEL0;
   LOOP
      FETCH NIVEL0 INTO NIVEL0_VENTAS_CLIENTE;
      EXIT WHEN NIVEL0%NOTFOUND;
      IF NIVEL0_VENTAS_CLIENTE.IND_FAMILIAR = 1 THEN -- Solo se calculan Planes Familiares
         IF NIVEL0_VENTAS_CLIENTE.COD_CLIENTE <> vp_cod_cliente_anterior THEN
            vp_num_habilitac_vtas := vp_num_habilitac_vtas + 1;
         END IF;
         vp_num_habilitac_meta := vp_num_habilitac_meta + 1;
      END IF;
      vp_cod_cliente_anterior := NIVEL0_VENTAS_CLIENTE.COD_CLIENTE;
   END LOOP;
END IF;
--
vp_num_habi_vtas_pf := vp_num_habilitac_vtas;
vp_num_habi_meta_pf := vp_num_habilitac_meta;
--
EXCEPTION WHEN NO_DATA_FOUND THEN
vp_sqlcode := sqlcode;
vp_sqlerrm := sqlerrm;
VE_P2_insanomliq(vp_num_liquidacion,vp_mensaje,vp_procedure,vp_tabla,vp_accion,vp_sqlcode,vp_sqlerrm);
END VE_P2_calcula_habili_pf;
/
SHOW ERRORS
