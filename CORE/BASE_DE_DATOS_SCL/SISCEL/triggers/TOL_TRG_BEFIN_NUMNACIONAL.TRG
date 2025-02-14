CREATE OR REPLACE TRIGGER TOL_TRG_BEFIN_NUMNACIONAL
/*
<NOMBRE>      : TOL_TRG_BEFIN_NUMNACIONAL</NOMBRE>
<FECHACREA>   : Abril 2006 <FECHACREA/>
<MODULO >     : ADNUM        </MODULO >
<AUTOR >      : LyP        </AUTOR >
<VERSION >    : 1.0</VERSION >
<DESCRIPCION> : Triger que inserta en taba de tol: TOL_RANNUME_TD   </DESCRIPCION>
<FECMOD>      : 13/04/2006 </FECMOD>
<INC>         : MA-200603310902</INC>
<DESMOD>      : Inserción del campo cod_dope, de la tabla TA_NUMNACIONAL</DESMOD>
*/
BEFORE INSERT ON TA_NUMNACIONAL
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW
DECLARE
v_Ta_OperadoresCOD_TOPE TA_OPERADORES.cod_tope%TYPE;
v_Ta_OperadoresCOD_DOPE TA_OPERADORES.cod_dope%TYPE;
v_Tol_RelalmareaCOD_ALM TOL_RELALMAREA.COD_ALM%TYPE;

COD_ASL      VARCHAR2(5):='';
cod_area_new VARCHAR2(5):='';
cod_operador_new VARCHAR2(5):='';
cod_almArea  VARCHAR2(5):='';
ind_concat   VARCHAR2(1):='';

query_str VARCHAR2(1000):='';
cod_rang VARCHAR2(5):='';
BEGIN
BEGIN
   -- Extrae Codigos Tipo Operadora y Direccion Operadora

     SELECT cod_tope,     cod_dope,
                --trim(SUBSTR('00'||cod_operador,(LENGTH('00'||cod_operador) -1), 2))
                DECODE(LENGTH(cod_operador),1,LPAD(cod_operador,2,'0'),cod_operador)
           INTO v_Ta_OperadoresCOD_TOPE,
                v_Ta_OperadoresCOD_DOPE,
		cod_operador_new
         FROM TA_OPERADORES
         WHERE cod_operador = :NEW.cod_operador;
 EXCEPTION
   WHEN OTHERS THEN
   RAISE_APPLICATION_ERROR(-20999,'ERROR RESCATANDO TOPE Y DOPE '||SQLERRM);
   NULL;
END;


/* Inicio: MA-200603310902, Fecha: 03-04-2006, Resp: Zenén MUñoz H. Desc.: inserción del campo cod_dope, de la tabla TA_NUMNACIONAL. */

IF :NEW.cod_dope IS NOT NULL THEN
   v_Ta_OperadoresCOD_DOPE := :NEW.cod_dope;
END IF;

/* Fin: MA-200603310902 */


/* XO-200508210416 */
BEGIN
     SELECT cod_alm
     INTO cod_almArea
     FROM TA_AREAS
     WHERE cod_area = :NEW.cod_area;

 EXCEPTION
   WHEN OTHERS THEN
   RAISE_APPLICATION_ERROR(-20999,'ERROR RESCATANDO COD_ALM '||SQLERRM);
   NULL;
END;

  IF (:NEW.IND_NUMERO = 2) THEN     --INSERTARA LOS RANGOS NUMERICO PREPAGO
     cod_rang := 'PREPA';
  ELSIF (:NEW.IND_NUMERO = 4) THEN  --INSERTARA LOS RANGOS NUMERICO NORMAL (POS-PAGO)
     cod_rang := 'NORMA';
  ELSIF (:NEW.IND_NUMERO = 3) THEN
     cod_rang := 'ALQUI';           --INSERTARA LOS RANGOS NUMERICO ALQUILER
  ELSE
     cod_rang := ' ';
  END IF;



 query_str:='INSERT INTO TOL_RANNUME_TD (cod_rang,cod_oper,num_lini,num_linf,cod_area,cod_tope,cod_dope,cod_alm)';
 query_str:=query_str || ' VALUES (:1,:2,:3,:4,:5,:6,:7,:8)';

/*XO-200506170066 - HHA
	SE MODIFICA EL TRIGGER A PETICION DE CLAUDIO MACAYA
	SOLUCION ENVIADA POR EL (VER DOCUMENTO DE INCIDENCIA)
*/
/*SE CONSULTA LA TABLA GED_PARAMETROS PARA DETERMINAR SI SE CONCATENA O NO*/
BEGIN
	SELECT TRIM(val_parametro) INTO ind_concat FROM GED_PARAMETROS WHERE NOM_PARAMETRO = 'IND_CONCAT_AREA_OP';
	EXCEPTION
   WHEN OTHERS THEN
   RAISE_APPLICATION_ERROR(-20998,'ERROR RESCATANDO IND_CONCAT '||SQLERRM);
   NULL;
END;

	IF (ind_concat = '1') THEN

 		EXECUTE IMMEDIATE query_str USING cod_rang,
 		cod_operador_new,:NEW.num_tdesde,:NEW.num_thasta,
		trim(cod_operador_new || SUBSTR('000'||:NEW.cod_area,(LENGTH('000'||:NEW.cod_area) -2), 3)),
		v_Ta_OperadoresCOD_TOPE, v_Ta_OperadoresCOD_DOPE, cod_almArea;

	ELSE

		EXECUTE IMMEDIATE query_str USING cod_rang,
		cod_operador_new,
		:NEW.num_tdesde,:NEW.num_thasta,
		:NEW.cod_area,v_Ta_OperadoresCOD_TOPE, v_Ta_OperadoresCOD_DOPE,
		cod_almArea;

	END IF;

 EXCEPTION
   WHEN OTHERS THEN
   RAISE_APPLICATION_ERROR(-20999,'ERROR EN EL TRIGGER TOL_TRG_BEFIN_NUMNACIONAL '||SQLERRM);
   NULL;
END;
/
SHOW ERRORS
