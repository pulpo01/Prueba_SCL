CREATE OR REPLACE FUNCTION ci_fn_subtelreporte_mpr (v_fec_inicio varchar2, v_fec_fin varchar2) RETURN VARCHAR2 IS
-- PL/SQL Specification
--
-- *************************************************************
-- * Funcion            : CI_FN_SUBTELREPORTE_MPR
-- * Salida             : query para carga de reporte subtel MPR
-- * Descripcion        : Funcion que retorna el query para carga
-- *                      de reporte subtel
-- * Fecha de creacion  : Diciembre 2002
-- * Responsable        : Rodrigo Araneda (TM-MAS)
-- *************************************************************
v_ssql VARCHAR2(2000);
sFecFormat varchar2(20);
sTipCategoria varchar2(5);
--
BEGIN
    --
        SELECT  val_parametro INTO sFecFormat
        FROM ged_parametros
        WHERE cod_modulo = 'GE'
        AND cod_producto=1
        and nom_parametro = 'FORMATO_SEL2';

        sTipCategoria:= 'S';
        v_ssql:= 'SELECT a.num_reclamo, a.NOM_RECLAMANTE || a.APP_RECLAMANTE || a.APM_RECLAMANTE, a.NUM_IDENTREC, a.DESC_EDIREC1 || a.DESC_EDIREC2, g2.des_comuna, ' ||
                         'g1.des_ciudad, a.tel_contact, to_char(a.fec_reclamo, ''' || sFecFormat ||'''), ' ||
                         'o.des_operadora, a.rec_descripcion, r.num_terminal, a.MON_RECLAMADO, ' ||
                         'a.cod_estado, a.des_solucion, to_char(a.fec_solucion,'''|| sFecFormat ||'''), ' ||
                         'a.mon_aceptado ' ||
                         'FROM ' ||
                         'ge_oficinas f, ge_seg_usuario e, ge_sectores d, ca_tipincidencias c, ' ||
                         're_reclamos a, re_terminales r, cid_operadora o, ge_estados g1, ' ||
                         'ge_pueblos g2 ' ||
                         'WHERE  a.tip_categoria = '''|| sTipCategoria ||''' ' ||
                         'AND a.fec_reclamo >= TO_DATE(''' || v_fec_inicio || ''','''|| sFecFormat ||''') ' ||
                         'AND a.fec_reclamo <= TO_DATE(''' || v_fec_fin || ''','''|| sFecFormat ||''') ' ||
                         'AND a.tip_reclamo = c.tip_incidencia AND a.cod_arearesp = d.cod_sector ' ||
                         'AND a.cod_username = e.nom_usuario AND a.cod_oficina = f.cod_oficina ' ||
                         'AND r.num_reclamo = a.num_reclamo AND r.tip_categoria = a.tip_categoria ' ||
                         'AND a.cod_operadora = o.cod_operadora (+) AND g1.cod_ciudad  = a.COD_ECIUDAD ' ||
                         'AND g2.cod_comuna  = a.COD_ECOMUNA ';
         -- ****************************************************
         RETURN v_ssql;
         --*********************************************************
EXCEPTION

   WHEN VALUE_ERROR THEN
                RETURN 'ERROR 1 ci_fn_subtelreporte_mpr, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM;

   WHEN INVALID_NUMBER THEN
                RETURN 'ERROR 2 ci_fn_subtelreporte_mpr, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM;

   WHEN OTHERS THEN
      RETURN 'ERROR 3 ci_fn_subtelreporte_mpr, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM;
END;
/
SHOW ERRORS
