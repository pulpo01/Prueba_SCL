CREATE OR REPLACE PROCEDURE        VE_P2_CALCULA_SUBSIDIO_PF(
 vp_cod_vendedor        IN  VE_VENDEDORES.COD_VENDEDOR%TYPE,
 vp_num_liquidacion     IN  VE_CABLIQUIDAC.NUM_LIQUIDACION%TYPE,
 vp_ind_nivel           IN  VE_CATCOMIS.IND_NIVEL%TYPE,
 vp_fecha_inicial       IN  DATE,
 vp_fecha_final         IN  DATE,
 vp_num_total_ventas_pf OUT NUMBER,
 vp_importe_pf          OUT NUMBER
)
IS
-- CONSTANTES
vp_0   NUMBER:=0;
vp_1   NUMBER:=1;
vp_4   NUMBER:=4;
vp_AAA VARCHAR2(3) := 'AAA';
vp_ABP VARCHAR2(3) := 'ABP';
vp_ACP VARCHAR2(3) := 'ACP';
vp_CNP VARCHAR2(3) := 'CNP';
vp_CSP VARCHAR2(3) := 'CSP';
vp_RTP VARCHAR2(3) := 'RTP';
vp_CO  VARCHAR2(2) := 'CO';
vp_PR  VARCHAR2(2) := 'PR';
vp_AC  VARCHAR2(2) := 'AC';
vp_I   VARCHAR2(1) := 'I';
vp_AMI VARCHAR2(3) := 'AMI';
vp_Y   VARCHAR2(3) := 'Y';
vp_Z   VARCHAR2(3) := 'Z';
vp_ZZ  VARCHAR2(3) := 'ZZ';
vp_90  VARCHAR2(3) := '90';
vp_91  VARCHAR2(3) := '91';
-- VARIABLES AUXILIARES
vp_cod_cliente_ant    GA_ABOCEL.COD_CLIENTE%TYPE := 0;
vp_cod_plantarif_ant  GA_ABOCEL.COD_PLANTARIF%TYPE := ' ';
vp_num_abonado_ant    GA_ABOCEL.NUM_ABONADO%TYPE;
vp_fec_venta_ant      GA_VENTAS.FEC_VENTA%TYPE;
vp_cod_cattipocon_ant VE_CATTIPOCONTR.COD_CATTIPOCONTR%TYPE;
vp_cod_catplantar_ant VE_CATPLANTARIF.COD_CATEGORIA%TYPE;
vp_cod_articulo_ant   GA_EQUIPABOSER.COD_ARTICULO%TYPE;
vp_ind_familiar_ant   TA_PLANTARIF.IND_FAMILIAR%TYPE;
vp_importe_aux        NUMBER := 0;
vp_num_ventas_aux     NUMBER := 0;
-- VARIABLES PARA INFORME DE ERRORES
vp_mensaje VARCHAR2(120):=' ';
vp_procedure VARCHAR2(30):='VE_P2_comis_subsidio';
vp_tabla VARCHAR2(30):='ga_abocel';
vp_accion VARCHAR2(1):='S';
vp_sqlcode VARCHAR2(10);
vp_sqlerrm VARCHAR2(70);
--
CURSOR C1 IS
--      Este HINT no debe ser removido bajo ninguna circunstancia
SELECT /*+INDEX(GA_ABOCEL AK_GA_ABOCEL_VENTAS)*/
       GA_ABOCEL.COD_CLIENTE,
       GA_ABOCEL.COD_PLANTARIF,
       GA_ABOCEL.NUM_ABONADO,
       GA_VENTAS.FEC_VENTA,
       VE_CATTIPOCONTR.COD_CATTIPOCONTR COD_CATTIPOCON,
       VE_CATPLANTARIF.COD_CATEGORIA COD_CATPLANTAR,
       GA_EQUIPABOSER.COD_ARTICULO,
       TA_PLANTARIF.IND_FAMILIAR
 FROM VE_COMISUBSIDIO_PF VE_COMISUBSIDIO,
      GA_EQUIPABOSER GA_EQUIPABOSER,
      TA_PLANTARIF TA_PLANTARIF,
      GA_ABOCEL GA_ABOCEL,
      VE_CATPLANTARIF VE_CATPLANTARIF,
      VE_CATTIPOCONTR VE_CATTIPOCONTR,
      GA_VENTAS GA_VENTAS,
      VE_VENDEDORES DEALER
 WHERE VE_COMISUBSIDIO.COD_ARTICULO     =  GA_EQUIPABOSER.COD_ARTICULO AND
       VE_COMISUBSIDIO.IND_FAMILIAR     =  TA_PLANTARIF.IND_FAMILIAR AND
       VE_COMISUBSIDIO.COD_CATPLANTARIF =  VE_CATPLANTARIF.COD_CATEGORIA AND
       VE_COMISUBSIDIO.COD_CATTIPOCONTR =  VE_CATTIPOCONTR.COD_CATTIPOCONTR AND
       VE_COMISUBSIDIO.FEC_DESDE        <= GA_VENTAS.FEC_VENTA AND
       VE_COMISUBSIDIO.FEC_HASTA        >  GA_VENTAS.FEC_VENTA AND
       TO_CHAR(GA_EQUIPABOSER.FEC_ALTA,'YYYYMMDD') = TO_CHAR(GA_ABOCEL.FEC_ALTA,'YYYYMMDD') AND
       GA_EQUIPABOSER.TIP_STOCK         =  vp_4 AND      ---  MERCADERIA DEALER
       GA_EQUIPABOSER.NUM_SERIE         =  GA_ABOCEL.NUM_SERIE AND
       GA_EQUIPABOSER.NUM_ABONADO       =  GA_ABOCEL.NUM_ABONADO AND
       TA_PLANTARIF.COD_PLANTARIF       =  GA_ABOCEL.COD_PLANTARIF AND
       TA_PLANTARIF.COD_PRODUCTO        =  GA_ABOCEL.COD_PRODUCTO AND
       NOT EXISTS (SELECT ROWID
                   FROM GA_TRASPABO GA_TRASPABO
                   WHERE GA_TRASPABO.NUM_ABONADO = GA_ABOCEL.NUM_ABONADO) AND
       GA_ABOCEL.COD_PLANTARIF  NOT IN (vp_AMI,vp_Y,vp_Z,vp_ZZ,vp_90,vp_91) AND
       GA_ABOCEL.COD_SITUACION  NOT IN (SELECT COD_SITUACION
                                         FROM GA_SITUABO
                                         WHERE COD_SITUACION NOT IN (vp_AAA,vp_ABP,vp_ACP,vp_CNP,vp_CSP,vp_RTP)
                                       ) AND
       GA_ABOCEL.IND_PROCEQUI           =  vp_I AND
       GA_ABOCEL.COD_ESTADO             IN (vp_CO,vp_PR) AND
       VE_CATPLANTARIF.FEC_FINEFECTIVIDAD IS NULL AND
       VE_CATPLANTARIF.COD_PLANTARIF    =  GA_ABOCEL.COD_PLANTARIF AND
       VE_CATPLANTARIF.COD_PRODUCTO     =  GA_ABOCEL.COD_PRODUCTO  AND
       VE_CATTIPOCONTR.FEC_FINEFECTIVIDAD  IS NULL AND
       VE_CATTIPOCONTR.COD_TIPCONTRATO  =  GA_ABOCEL.COD_TIPCONTRATO AND
       VE_CATTIPOCONTR.COD_PRODUCTO     =  GA_ABOCEL.COD_PRODUCTO       AND
       GA_ABOCEL.NUM_VENTA              =  GA_VENTAS.NUM_VENTA AND
       GA_VENTAS.FEC_VENTA              <  vp_fecha_final AND
       GA_VENTAS.FEC_VENTA              >= vp_fecha_inicial AND
       GA_VENTAS.IND_ESTVENTA           =  vp_AC  AND
       GA_VENTAS.COD_VENDEDOR           =  DEALER.COD_VENDEDOR AND
       DEALER.COD_VENDE_RAIZ            =  vp_cod_vendedor
 ORDER BY GA_ABOCEL.COD_CLIENTE,
          GA_ABOCEL.COD_PLANTARIF,
          GA_VENTAS.FEC_VENTA,
          GA_ABOCEL.NUM_ABONADO;
C1_ABONADO_PF	   C1%ROWTYPE;
--
BEGIN
vp_num_total_ventas_pf := 0;
vp_importe_pf          := 0;
IF vp_ind_nivel > 0 THEN
   OPEN C1;
   FETCH C1 INTO C1_ABONADO_PF;
   LOOP
      EXIT WHEN C1%NOTFOUND;
      vp_cod_cliente_ant    := C1_ABONADO_PF.COD_CLIENTE;
      vp_cod_plantarif_ant  := C1_ABONADO_PF.COD_PLANTARIF;
      vp_num_abonado_ant    := C1_ABONADO_PF.NUM_ABONADO;
      vp_fec_venta_ant      := C1_ABONADO_PF.FEC_VENTA;
      vp_cod_cattipocon_ant := C1_ABONADO_PF.COD_CATTIPOCON;
      vp_cod_catplantar_ant := C1_ABONADO_PF.COD_CATPLANTAR;
      vp_cod_articulo_ant   := C1_ABONADO_PF.COD_ARTICULO;
      vp_ind_familiar_ant   := C1_ABONADO_PF.IND_FAMILIAR;
      FETCH C1 INTO C1_ABONADO_PF;
      IF C1%NOTFOUND THEN
         C1_ABONADO_PF.COD_CLIENTE := 99999999;
         C1_ABONADO_PF.COD_PLANTARIF:= 'ZZZ';
      END IF;
      vp_tabla := 'VE_COMISUBSIDIO';
      IF (C1_ABONADO_PF.COD_CLIENTE <> vp_cod_cliente_ant) OR
         (C1_ABONADO_PF.COD_PLANTARIF <> vp_cod_plantarif_ant) THEN
-- Cambio de cliente: Anterior era ultima ocurrencia del cliente, ES UNA 2DA LINEA
         IF vp_ind_familiar_ant = 1 THEN
-- Anterior era plan familiar
            SELECT VE_COMISUBSIDIO_PF.IMP_SUBSIDIO
             INTO vp_importe_aux
             FROM VE_COMISUBSIDIO_PF VE_COMISUBSIDIO_PF
             WHERE VE_COMISUBSIDIO_PF.COD_ARTICULO     =  vp_cod_articulo_ant
               AND VE_COMISUBSIDIO_PF.IND_FAMILIAR     =  vp_1
               AND VE_COMISUBSIDIO_PF.COD_CATPLANTARIF =  vp_cod_catplantar_ant
               AND VE_COMISUBSIDIO_PF.COD_CATTIPOCONTR =  vp_cod_cattipocon_ant
               AND VE_COMISUBSIDIO_PF.FEC_DESDE        <= vp_fec_venta_ant
               AND VE_COMISUBSIDIO_PF.FEC_HASTA        >  vp_fec_venta_ant;
            vp_importe_pf := vp_importe_pf + nvl(vp_importe_aux,0);
            vp_num_total_ventas_pf := vp_num_total_ventas_pf + 1;
         END IF;
      ELSE
-- NO cambio de cliente: Anterior es 1ra ocurrencia del cliente, ES UNA 1RA LINEA
         IF vp_ind_familiar_ant = 1 THEN
-- Anterior era plan familiar
            SELECT VE_COMISUBSIDIO_PF.IMP_SUBSIDIO
             INTO vp_importe_aux
             FROM VE_COMISUBSIDIO_PF VE_COMISUBSIDIO_PF
             WHERE VE_COMISUBSIDIO_PF.COD_ARTICULO     =  vp_cod_articulo_ant
               AND VE_COMISUBSIDIO_PF.IND_FAMILIAR     =  vp_0
               AND VE_COMISUBSIDIO_PF.COD_CATPLANTARIF =  vp_cod_catplantar_ant
               AND VE_COMISUBSIDIO_PF.COD_CATTIPOCONTR =  vp_cod_cattipocon_ant
               AND VE_COMISUBSIDIO_PF.FEC_DESDE        <= vp_fec_venta_ant
               AND VE_COMISUBSIDIO_PF.FEC_HASTA        >  vp_fec_venta_ant;
            vp_importe_pf := vp_importe_pf + nvl(vp_importe_aux,0);
            vp_num_total_ventas_pf := vp_num_total_ventas_pf + 1;
         END IF;
      END IF;
   END LOOP;
END IF;
vp_num_total_ventas_pf := nvl(vp_num_total_ventas_pf,0);
vp_importe_pf          := nvl(vp_importe_pf,0);
--
EXCEPTION WHEN NO_DATA_FOUND THEN
vp_sqlcode := sqlcode;
vp_sqlerrm := sqlerrm;
VE_P2_insanomliq(vp_num_liquidacion,vp_mensaje,vp_procedure,vp_tabla,vp_accion,vp_sqlcode,vp_sqlerrm);
END VE_P2_calcula_subsidio_pf;
/
SHOW ERRORS
