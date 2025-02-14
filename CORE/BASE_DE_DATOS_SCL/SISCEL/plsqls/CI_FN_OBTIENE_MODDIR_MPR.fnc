CREATE OR REPLACE FUNCTION        ci_fn_obtiene_moddir_mpr (num_os number, des_tipdir varchar2) RETURN VARCHAR2 IS
--
v_ssql VARCHAR2(2000);
sFecFormat varchar2(20);
sFecFormatH varchar2(20);
sTipCategoria varchar2(5);
--
BEGIN
    --
	SELECT  val_parametro INTO sFecFormat
	FROM ged_parametros
	WHERE cod_modulo = 'GE'
	AND cod_producto=1
	and nom_parametro = 'FORMATO_SEL2';

  	--sFecFormat:= 'dd-mm-yyyy';
	--sFecFormatH:= 'dd-mm-yyyy hh24:mi';
--	sTipCategoria:= 'S';
	v_ssql:= 'SELECT '||'''Fecha Modif.:'''||'||TO_CHAR(A.fec_MODIFICA,'''|| sFecFormat ||''')|| '||
			 ''';Estado Ant.: '''||'||X.des_ciudad||'||''';Pueblo Ant.: '''||'||K.des_comuna||'||''';Direccion Ant.: '''||'||b.des_direc1 '||'||'||'b.des_direc2||'||''';ZIP: '''||'||b.zip|| '||
			 ''';Estado Nuevo: '''||'||W.des_ciudad||'||''';Pueblo Nuevo: '''||'||Z.des_comuna||'||''';Direccion Nueva: '''||'||c.des_direc1 '||'||'||'c.des_direc2||'||''';ZIP: '''||'||c.zip ||'||''';'''||
             ' FROM ga_moddircli a,ge_direcciones b,ge_direcciones c,ge_comunas k, ' ||
			 'ge_comunas z,ge_ciudades x,ge_ciudades w,ci_orserv d,ge_tipdireccion e ' ||
             'WHERE d.num_os = ['|| num_os ||'] ' ||
             'And e.des_tipdireccion = [''' || des_tipdir || '''] ' ||
             'AND d.cod_inter = a.cod_cliente ' ||
             'AND TO_char(a.fec_modifica,'''||sFecFormat||''') = to_char(d.fecha,'''||sFecFormat||''') ' ||
             'AND TO_char(a.fec_modifica,'''||sFecFormat||''') between ' ||
             'to_char(d.fecha-(1/720),'''||sFecFormat||''') and ' ||
             'to_char(d.fecha,'''||sFecFormat||''') ' ||
             'AND a.cod_direcant = b.cod_direccion ' ||
             'AND a.cod_direcnue = c.cod_direccion ' ||
             'AND b.cod_comuna = k.cod_comuna ' ||
             'AND c.cod_comuna = z.cod_comuna ' ||
             'AND b.cod_ciudad = x.cod_ciudad ' ||
             'AND c.cod_ciudad = w.cod_ciudad ' ||
             'AND a.cod_tipdireccion = e.cod_tipdireccion ';
	 -- ****************************************************
	 RETURN v_ssql;
	 --*********************************************************
EXCEPTION

   WHEN VALUE_ERROR THEN
   		RETURN 'ERROR 1 ci_fn_obtiene_moddir_mpr, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM;

   WHEN INVALID_NUMBER THEN
   		RETURN 'ERROR 2 ci_fn_obtiene_moddir_mpr, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM;

   WHEN OTHERS THEN
      RETURN 'ERROR 3 ci_fn_obtiene_moddir_mpr, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM;
END;
/
SHOW ERRORS
