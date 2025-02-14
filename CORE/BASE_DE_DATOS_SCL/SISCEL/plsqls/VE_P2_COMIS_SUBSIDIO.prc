CREATE OR REPLACE PROCEDURE        VE_P2_COMIS_SUBSIDIO(
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
 vp_num_habi_beep IN OUT NUMBER
)
IS
-- Constantes
VP_AC VARCHAR2(2):='AC';
VP_AMI VARCHAR2(3):='AMI';
VP_Y   VARCHAR2(3):='Y';
VP_Z   VARCHAR2(3):='Z';
VP_ZZ  VARCHAR2(3):='ZZ';
VP_90  VARCHAR2(3):='90';
VP_91  VARCHAR2(3):='91';
vp_AAA VARCHAR2(3):='AAA';
vp_ABP VARCHAR2(3):='ABP';
vp_ACP VARCHAR2(3):='ACP';
vp_CNP VARCHAR2(3):='CNP';
vp_CSP VARCHAR2(3):='CSP';
vp_RTP VARCHAR2(3):='RTP';
vp_I   VARCHAR2(1):='I';
vp_CO  VARCHAR2(2):='CO';
vp_PR  VARCHAR2(2):='PR';
vp_0 number:=0;
vp_1 number:=1;
vp_4 number:=4;
-- Variables para informe de errores
vp_mensaje VARCHAR2(120):=' ';
vp_procedure VARCHAR2(30):='VE_P2_comis_subsidio';
vp_tabla VARCHAR2(30):='VE_CUADRANTESLIQ';
vp_accion VARCHAR2(1):='S';
vp_sqlcode VARCHAR2(10);
vp_sqlerrm VARCHAR2(70);
--
vp_importe_total NUMBER:=0;
vp_importe_aux NUMBER:=0;
vp_num_total_ventas NUMBER:=0;
vp_num_ventas_aux NUMBER:=0;
vp_num_total_ventas_pf NUMBER:=0;
vp_importe_pf NUMBER:=0;
vp_cod_vendedor_aux VE_VENDEDORES.COD_VENDEDOR%TYPE;
--
CURSOR c_vtoliq IS
 SELECT  VE_VENDEDORES.COD_VENDEDOR
 FROM  VE_VENDEDORES
 WHERE  VE_VENDEDORES.COD_VENDE_RAIZ=vp_cod_vendedor;
--
BEGIN
IF vp_ind_nivel > 0 THEN
   OPEN c_vtoliq;
   LOOP
      FETCH c_vtoliq INTO  vp_cod_vendedor_aux;
      EXIT WHEN c_vtoliq%NOTFOUND;
      SELECT SUM(VE_COMISUBSIDIO.IMP_SUBSIDIO), COUNT(*)
      INTO vp_importe_aux, vp_num_ventas_aux
      FROM GA_EQUIPABOSER GA_EQUIPABOSER,
           TA_PLANTARIF TA_PLANTARIF,
           GA_ABOCEL GA_ABOCEL,
           VE_CATPLANTARIF VE_CATPLANTARIF,
           VE_CATTIPOCONTR VE_CATTIPOCONTR,
           VE_COMISUBSIDIO_PF VE_COMISUBSIDIO,
           GA_VENTAS GA_VENTAS
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
            TA_PLANTARIF.IND_FAMILIAR        =  vp_0 AND             -- El plan no debe ser familiar
            TA_PLANTARIF.COD_PLANTARIF       =  GA_ABOCEL.COD_PLANTARIF AND
            TA_PLANTARIF.COD_PRODUCTO        =  GA_ABOCEL.COD_PRODUCTO AND
            NOT EXISTS (SELECT ROWID
                        FROM GA_TRASPABO GA_TRASPABO
                        WHERE GA_TRASPABO.NUM_ABONADO = GA_ABOCEL.NUM_ABONADO) AND
            GA_ABOCEL.COD_PLANTARIF     NOT IN (vp_AMI,vp_Y,vp_Z,vp_ZZ,vp_90,vp_91) AND
            GA_ABOCEL.COD_SITUACION     NOT IN (SELECT COD_SITUACION
                                                 FROM GA_SITUABO
                                                 WHERE COD_SITUACION NOT IN (vp_AAA,vp_ABP,vp_ACP,vp_CNP,vp_CSP,vp_RTP)
                                               ) AND
            GA_ABOCEL.IND_PROCEQUI           =  vp_I AND
            GA_ABOCEL.COD_ESTADO             IN (vp_CO,vp_PR) AND
            VE_CATPLANTARIF.FEC_FINEFECTIVIDAD IS NULL AND
            VE_CATPLANTARIF.COD_PLANTARIF    =  GA_ABOCEL.COD_PLANTARIF AND
            VE_CATPLANTARIF.COD_PRODUCTO     =  GA_ABOCEL.COD_PRODUCTO  AND
            VE_CATTIPOCONTR.FEC_FINEFECTIVIDAD IS NULL AND
            VE_CATTIPOCONTR.COD_TIPCONTRATO  =  GA_ABOCEL.COD_TIPCONTRATO AND
            VE_CATTIPOCONTR.COD_PRODUCTO     =  GA_ABOCEL.COD_PRODUCTO       AND
            GA_ABOCEL.NUM_VENTA              =  GA_VENTAS.NUM_VENTA AND
            GA_VENTAS.FEC_VENTA              <  vp_fecha_final AND
            GA_VENTAS.FEC_VENTA              >= vp_fecha_inicial AND
            GA_VENTAS.IND_ESTVENTA           =  vp_AC  AND
            GA_VENTAS.COD_VENDEDOR           =  vp_cod_vendedor_aux;
      vp_importe_aux:=NVL(vp_importe_aux,0);
      vp_importe_total:=vp_importe_total + vp_importe_aux;
-- ** dbms_output.put_line('-- vp_importe_total (p): '|| to_char(vp_importe_total,'99,999,999'));
      vp_num_total_ventas:=  vp_num_total_ventas + vp_num_ventas_aux;
-- ** dbms_output.put_line('-- vp_num_total_ventas (p): '|| to_char(vp_num_total_ventas,'99,999,999'));
   END LOOP;
   CLOSE c_vtoliq;
   VE_P2_CALCULA_SUBSIDIO_PF(vp_cod_vendedor,vp_num_liquidacion,vp_ind_nivel,vp_fecha_inicial,vp_fecha_final,
                             vp_num_total_ventas_pf, vp_importe_pf);
-- ** dbms_output.put_line('-- vp_num_total_ventas_pf: '|| to_char(vp_num_total_ventas_pf,'99,999,999'));
-- ** dbms_output.put_line('-- vp_importe_pf: '|| to_char(vp_importe_pf,'99,999,999'));
   vp_importe_total := vp_importe_total + vp_importe_pf;
-- ** dbms_output.put_line('-- vp_importe_total (T): '|| to_char(vp_importe_total,'99,999,999'));
   vp_num_total_ventas := vp_num_total_ventas + vp_num_total_ventas_pf;
-- ** dbms_output.put_line('-- vp_num_total_ventas (T): '|| to_char(vp_num_total_ventas,'99,999,999'));
END IF;
VE_P2_inserta_resultado(vp_cod_vendedor,vp_num_liquidacion,vp_producto,vp_ctoliq,vp_tip_vendedor,vp_fecha_inicial,vp_fecha_final,
                        vp_importe_total,0, 0,vp_num_total_ventas,0);
EXCEPTION WHEN NO_DATA_FOUND THEN
vp_sqlcode := sqlcode;
vp_sqlerrm := sqlerrm;
VE_P2_insanomliq(vp_num_liquidacion,vp_mensaje,vp_procedure,vp_tabla,vp_accion,vp_sqlcode,vp_sqlerrm);
END VE_P2_comis_subsidio;
/
SHOW ERRORS
