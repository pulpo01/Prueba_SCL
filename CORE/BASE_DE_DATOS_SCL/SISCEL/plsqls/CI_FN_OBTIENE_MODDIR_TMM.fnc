CREATE OR REPLACE FUNCTION CI_FN_OBTIENE_MODDIR_TMM (num_os number, des_tipdir varchar2) RETURN VARCHAR2 IS
--
v_ssql VARCHAR2(2000);
sFecFormat varchar2(20);
sFecFormatH varchar2(20);
sTipCategoria varchar2(5);
--
/*
<NOMBRE>       : ci_fn_obtiene_moddir_tmm</NOMBRE>
<FECHACREA>    : <FECHACREA/>
<MODULO >      : PV</MODULO >
<AUTOR >       : ANONIMO</AUTOR >
<VERSION >     : 1.2</VERSION >
<DESCRIPCION>  : RETORNA MODIFICACIONES DE DIRECCIONES</DESCRIPCION>
<FECHAMOD >    : 24/03/2006 </FECHAMOD >
<DESCMOD >     : Se modifica funcion ci_fn_obtiene_moddir_tmm para corregir consulta, Incidencia RA-200602070716
                 Realizado por Maria Lorena Rojo</DESCMOD>
*/
BEGIN
    --
	SELECT  val_parametro INTO sFecFormat
	FROM ged_parametros
	WHERE cod_modulo = 'GE'
	AND cod_producto=1
	and nom_parametro = 'FORMATO_SEL2';



	v_ssql:= 'SELECT '||'''Fecha Modif.: '''||'||TO_CHAR(A.fec_MODIFICA,'''|| sFecFormat ||''')|| '||
             -- Ini RA-200602070716 Diego Mejías 30/05/2006 --
			 --''';Ciudad Ant.: '''||'||X.des_ciudad||'||''';Colonia Ant.: '''||'||K.des_comuna||'||''';Calle Ant.: '''||'||b.nom_calle||'||''';Obs. Ant: '''||'||b.obs_direccion||'||''';N° Interno Ant.: '''||'||b.num_piso||'||''';Zip Ant.:''' ||'|| b.ZIP ||'||
			 ''';Ciudad Ant.: '''||'||X.des_ciudad||'||''';Colonia Ant.: '''||'||K.des_comuna||'||''';Calle Ant.: '''||'||b.nom_calle||'||
			 -- Fin RA-200602070716 --
			 -- Ini RA-200602070716 Rodrigo Araneda 28/06/2006
			 ''';Obs. Ant: '''||'||b.obs_direccion||'||
			 -- Fin RA-200602070716 Rodrigo Araneda 28/06/2006
			 ''';Plaza Ant.: '''||'||i.des_plaza||'||''';Ciudad Nueva: '''||'||W.des_ciudad||'||''';Colonia Nueva: '''||'||Z.des_comuna||'||''';Calle Nueva: '''||'||c.nom_calle|| '||
			 -- Ini RA-200602070716 Rodrigo Araneda 28/06/2006
			 ''';Obs Nueva: '''||'||c.obs_direccion||'||
			 -- Fin RA-200602070716 Rodrigo Araneda 28/06/2006
             -- Ini RA-200602070716 Diego Mejías 30/05/2006 --
			 --''';Obs Nueva: '''||'||c.obs_direccion||'||''';N° Interno Nuevo: '''||'||c.num_piso||'||''';Zip Nuevo : '''||'||c.zip||'||''';Plaza Nueva.: '''||'|| h.des_plaza ||'||''';'''||
			 ''';Plaza Nueva.: '''||'|| h.des_plaza ||'||''';'''||
             -- Fin RA-200602070716 --
			 ' FROM ga_moddircli a,ge_direcciones b,ge_direcciones c,ge_comunas k, ' ||
             -- Inicio modificacion by SAQL/Soporte 23/08/2005 - XO-200508190403
             --        'ge_comunas z,ge_ciudades x,ge_ciudades w,ci_orserv d,ge_tipdireccion e,ge_ciuplaza_td f,ge_ciuplaza_td g,ge_plazas_td h, ge_plazas_td i ' ||
             'ge_comunas z,ge_ciudades x,ge_ciudades w,ci_orserv d,ge_tipdireccion e,ge_plazas_td h, ge_plazas_td i ' ||
             -- Fin modificacion by SAQL/Soporte 23/08/2005 - XO-200508190403
             'WHERE d.num_os = ['|| num_os ||'] ' ||
             'And e.des_tipdireccion = [''' || des_tipdir || '''] ' ||
             'AND d.cod_inter = a.cod_cliente ' ||
-- RA-200602070716
             'AND a.fec_modifica <= d.fecha ' ||
-- RA-200602070716
       		 'AND a.cod_direcant = b.cod_direccion ' ||
       		 'AND a.cod_direcnue = c.cod_direccion ' ||
       		 'AND b.cod_comuna = k.cod_comuna(+) ' ||
       		 'AND c.cod_comuna = z.cod_comuna(+) ' ||
       		 'AND b.cod_ciudad = x.cod_ciudad(+) ' ||
       		 'AND c.cod_ciudad = w.cod_ciudad(+) ' ||
	   		 'AND x.cod_plaza = h.cod_plaza(+) ' ||
	   		 'AND w.cod_plaza = i.COD_PLAZA(+) ' ||
-- RA-200602070716
             'AND a.cod_tipdireccion = e.cod_tipdireccion ORDER BY a.fec_modifica DESC ';
-- RA-200602070716
	 -- ****************************************************
	 RETURN v_ssql;
	 --*********************************************************
EXCEPTION

   WHEN VALUE_ERROR THEN
   		RETURN 'ERROR 1 ci_fn_obtiene_moddir_tmm, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM;

   WHEN INVALID_NUMBER THEN
   		RETURN 'ERROR 2 ci_fn_obtiene_moddir_tmm, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM;

   WHEN OTHERS THEN
      RETURN 'ERROR 3 ci_fn_obtiene_moddir_tmm, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM;
END;
/
SHOW ERRORS
