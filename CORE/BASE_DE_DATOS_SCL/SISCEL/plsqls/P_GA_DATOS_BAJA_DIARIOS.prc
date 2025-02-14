CREATE OR REPLACE PROCEDURE P_GA_DATOS_BAJA_DIARIOS
(snum_transaccion in varchar2,
fecha_consulta in varchar2, snom_tabla in varchar2) IS

v_cod_modulo icc_movimiento.cod_modulo%type;
v_num_celular icc_movimiento.NUM_CELULAR%type;
v_fec_ingreso icc_movimiento.fec_ingreso%type;
v_cod_actuacion icc_movimiento.cod_actuacion%type;
v_cod_uso   GA_CELNUM_USO.COD_USO%type;
cur_datos integer;
ssql varchar2(1024);

resultado varchar(50);
v_resul_l integer;
num_transaccion number;
iOTN Number;     /* Otras Bajas por sistema comercial (No Ident) */
iOTA Number;     /* Otras bajas por almacen (No Ident) */
iAMN Number;     /* Bajas Amistar por sistema comercial */
iAMA Number;     /* Bajas Amistar por almacen */
iCTN Number;     /* Bajas Cuenta Segura por sistema comercial */
iCTA Number;     /* Bajas Cuenta Segura por Almacen */
iPEV Number;     /* Bajas Prepagos x eventos */
sfecha varchar(12);
sFecFormat varchar(12);
inum_desde number;
/******************************************************************************
   NAME:       DATOS_BAJA_DIARIOS
   PURPOSE:    Calcula la cantidad de bajas en fecha especifica
******************************************************************************/
BEGIN
   iOTN := 0;
   iOTA := 0;
   iAMN := 0;
   iAMA := 0;
   iCTN := 0;
   iCTA := 0;
   iPEV := 0;
   sfecha := chr(39) || fecha_consulta || chr(39);
   sFecFormat := chr(39) || 'DD-MM-YYYY' || chr(39);
   num_transaccion := to_number(snum_transaccion);

   ssql := 'SELECT ' ||
          ' COD_MODULO, NUM_CELULAR, FEC_INGRESO, COD_ACTUACION '||
          ' FROM ' || snom_tabla ||
          ' WHERE TRUNC(FEC_INGRESO) = :v_fec_ingreso' ||
          ' AND COD_ACTUACION IN (9,54,3,50,55,51,59,540) ' ||
          ' UNION ALL '||
          ' SELECT ' ||
          ' COD_MODULO, NUM_CELULAR, FEC_INGRESO, COD_ACTUACION ' ||
 	   ' FROM ICC_MOVIMIENTO' ||
 	   ' WHERE TRUNC(FEC_INGRESO) = :v_fec_ingreso ' ||
          ' AND COD_ACTUACION IN (9,54,3,50,55,51,59,540) ';

       cur_datos:=dbms_sql.open_cursor;

       dbms_sql.parse(cur_datos, ssql, dbms_sql.native);

       DBMS_SQL.BIND_VARIABLE(cur_datos,':v_fec_ingreso', TO_DATE(sfecha, sFecFormat ));

       dbms_sql.define_column(cur_datos, 1, v_cod_modulo,2);
       dbms_sql.define_column(cur_datos, 2, v_num_celular);
       dbms_sql.define_column(cur_datos, 3, v_fec_ingreso);
       dbms_sql.define_column(cur_datos, 4, v_cod_actuacion);

       v_resul_l:=DBMS_SQL.EXECUTE(cur_datos);

	   LOOP
	     if DBMS_SQL.FETCH_ROWS(cur_datos) = 0 then
		     insert into GA_TRANSACABO
			    (num_transaccion, cod_retorno, des_cadena) values
			    (num_transaccion, 0, 'OTN' || to_char(iOTN) || ';OTA'|| to_char(iOTA) ||
                         ';AMN' || to_char(iAMN) || ';AMA'|| to_char(iAMA) ||
                         ';CTN' || to_char(iCTN) || ';CTA'|| to_char(iCTA) ||
						 ';PEV' || to_char(iPEV));
                 exit;
             end if;
             dbms_sql.column_value(cur_datos, 1, v_cod_modulo);
             dbms_sql.column_value(cur_datos, 2, v_num_celular);
             dbms_sql.column_value(cur_datos, 3, v_fec_ingreso);
             dbms_sql.column_value(cur_datos, 4, v_cod_actuacion);
             begin
		SELECT COD_USO INTO v_cod_uso
		FROM GA_CELNUM_USO
		WHERE v_num_celular BETWEEN NUM_DESDE(+) AND NUM_HASTA(+);
	     exception
	 	when others then
		 v_cod_uso := 0;
             end;
	     begin
		SELECT NUM_DESDE INTO inum_desde
		FROM GA_NUMROACOM
		WHERE v_num_celular BETWEEN NUM_DESDE AND NUM_HASTA;
	     exception
	 	when others then
		 inum_desde := 0;
	     end;
	     if inum_desde = 0 then
		if v_cod_actuacion = 59 then
		   iPEV := iPEV + 1;  /* Bajas Prepagos x eventos */
             	ElsIf v_cod_uso = 0 And v_cod_modulo <> 'AL' Then
                   iOTN := iOTN + 1;  /* Otras Bajas por sistema comercial (No Ident) */
             	ElsIf v_cod_uso = 0 And v_cod_modulo = 'AL' Then
                   iOTA := iOTA + 1;  /* Otras bajas por almacen (No Ident) */
             	ElsIf v_cod_uso = 3 And v_cod_modulo <> 'AL' Then
                   iAMN := iAMN + 1;  /* Bajas Amistar por sistema comercial */
             	ElsIf v_cod_uso = 3 And v_cod_modulo = 'AL' Then
                   iAMA := iAMA + 1; /* Bajas Amistar por almacen */
             	ElsIf (v_cod_uso = 10 Or v_cod_uso = 15) And v_cod_modulo <> 'AL' Then
                   iCTN := iCTN + 1;  /* Bajas Cuenta Segura por sistema comercial */
             	ElsIf (v_cod_uso = 10 Or v_cod_uso = 15) And v_cod_modulo = 'AL' Then
                   iCTA := iCTA + 1;  /* Bajas Cuenta Segura por Almacen */
             	End If;
	     end if;
       END LOOP;
       DBMS_SQL.CLOSE_CURSOR(cur_datos);
exception
       when others then
	RESULTADO := TO_CHAR(SQLCODE) || '  ' || SQLERRM;
	if dbms_sql.is_open(cur_datos) then
	   dbms_sql.close_cursor(cur_datos);
	end if;
        INSERT INTO GA_TRANSACABO (NUM_TRANSACCION,
                                   COD_RETORNO,
                                   DES_CADENA)
                           VALUES (num_transaccion,
                                   4,
                                   resultado );
END;
/
SHOW ERRORS
