CREATE OR REPLACE FUNCTION        cr_fn_genera_arch_abocel_mpr RETURN VARCHAR2 IS
--
v_ssql VARCHAR2(2000);
--
BEGIN
    --
		v_ssql:= 'SELECT B.COD_CLIENTE, B.NUM_EVENTO, c.cod_tipdocum, C.DES_TIPDOCUM, B.NUM_FOLIO, '||
			 'BB.COD_CICLFACT, D.NOM_CLIENTE ||'' ''||  D.NOM_APECLIEN1 ||'' ''||  D.NOM_APECLIEN2, '||
			 'E.DES_DIREC1 , E.DES_DIREC2, G.DES_COMUNA, H.DES_CIUDAD,E.ZIP, I.NUM_CELULAR '||
			 'FROM  CRH_EVENTOS BB, '||
             'CRT_DETALLES B,GE_CLIENTES D,GE_DIRECCIONES E,GA_DIRECCLI F,GE_COMUNAS G, GE_CIUDADES H, '||
			 'GA_ABOCEL I, fa_histdocu J,GE_TIPDOCUMEN C, CRH_DEVOLUCIONES A ' ||
             'Where A.COD_TIPDOCUM = B.COD_TIPDOCUM ' ||
             'AND A.NUM_FOLIO = B.NUM_FOLIO ' ||
             'AND A.COD_TIPDOCUM = C.COD_TIPDOCUM ' ||
             'AND A.COD_ESTADODEV = 1 ' ||
			 'AND B.COD_TIPDOCUM=A.COD_TIPDOCUM ' ||
			 'AND B.NUM_EVENTO = BB.NUM_EVENTO ' ||
             'AND B.COD_CLIENTE = D.COD_CLIENTE ' ||
             'AND B.COD_CLIENTE = F.COD_CLIENTE ' ||
             'AND F.COD_TIPDIRECCION = 3 ' ||
             'AND F.COD_DIRECCION = E.COD_DIRECCION ' ||
             'AND E.COD_COMUNA = G.COD_COMUNA ' ||
             'AND E.COD_CIUDAD = H.COD_CIUDAD ' ||
             'AND B.COD_CLIENTE = I.COD_CLIENTE ' ||
             'AND I.COD_CLIENTE = J.COD_CLIENTE ' ||
             'AND B.COD_TIPDOCUM = J.COD_TIPDOCUM ' ||
			 'AND B.NUM_FOLIO = J.NUM_FOLIO ' ||
			 'AND J.IND_SUPERTEL = 0 ' ||
			 'AND J.IND_FACTUR = 1 ' ||
			 'AND I.COD_SITUACION <> ''BAA'' ' ||
			 'ORDER BY B.COD_CLIENTE ';

	 -- ****************************************************
	 RETURN v_ssql;
	 --*********************************************************
EXCEPTION

   WHEN VALUE_ERROR THEN
   		RETURN 'ERROR 1 cr_fn_genera_arch_abocel_mpr, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM;

   WHEN INVALID_NUMBER THEN
   		RETURN 'ERROR 2 cr_fn_genera_arch_abocel_mpr, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM;

   WHEN OTHERS THEN
      RETURN 'ERROR 3 cr_fn_genera_arch_abocel_mpr, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM;
END;
/
SHOW ERRORS
