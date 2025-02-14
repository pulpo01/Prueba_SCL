CREATE OR REPLACE PACKAGE BODY IC_PKG_RESCATA_CADSERV AS

/*
<NOMBRE>       : IC_PKG_RESCATA_CADSERV</NOMBRE>
<FECHACREA>    : <FECHACREA/>
<MODULO >      : IC</MODULO >
<AUTOR >       : ANONIMO</AUTOR >
<VERSION >     : 1.0</VERSION >
<DESCRIPCION>  : Parametros Interfaz con Centrales</DESCRIPCION>
<FECHAMOD >    : 04/03/2009 </FECHAMOD >
<DESCMOD >     : Se modifica funcion FN_RESCATA_CADSERVICIO Incidencia 76664
                 Realizado por Hector Leiva R</DESCMOD>
*/
FUNCTION FN_RESCATA_CADSERVICIO (v_Num_Abondo IN number, v_Num_Movimiento IN number, v_Cod_Accion IN number, v_cod_comando IN number, 
v_num_orden IN number, v_num_ooss IN number) RETURN STRING IS

LN_ServSupl      VARCHAR2(200);
LN_DesCondicion  VARCHAR2(200);
LN_Cod_Comando   icc_comproc.cod_comando%TYPE;
LN_num_orden     icc_comproc.num_orden%TYPE;
LN_cod_lenguaje  icc_comproc.cod_lenguaje%TYPE;
LN_cod_sistema   icc_comproc.cod_sistema%TYPE;


LV_sql    VARCHAR2(4000);
v_ret     VARCHAR2(4000);
v_ret2    VARCHAR2(4000);
v_hold    VARCHAR2(4000);
v_hold2   VARCHAR2(4000);
v_cont    int;
v_len_ser int;
v_ser_tmp VARCHAR2(200);
v_out     VARCHAR2(200);

error_proceso EXCEPTION;

TYPE cur_typ IS REF CURSOR;
CursorGAServ cur_typ;

CURSOR CursorSevPers is
select VAL_PARAMETRO 
  from ged_parametros 
 where nom_parametro 
  like '%SERV_ALBONPERS%';

CURSOR CursorIcgRelaccion (p_codaccion number, p_codcomando number, p_numorden number, p_codlenguaje number, p_codsistema number) is
select replace(des_condicion,'A','') AS DES_CONDICION
  from icg_relaccion 
 where cod_accion       = p_codaccion  
   and cod_comando      = p_codcomando
   and num_orden        = p_numorden
   and cod_lenguaje_exe = p_codlenguaje
   and cod_sistema      = p_codsistema;
   
CURSOR CursorSevPerCom is
select VAL_PARAMETRO 
  from ged_parametros 
 where nom_parametro 
  like '%SERV_ALBONPERCOM%';

BEGIN

 OPEN CursorSevPers;
  LOOP
    FETCH CursorSevPers INTO v_hold;
    EXIT WHEN CursorSevPers%NOTFOUND;
    IF v_ret IS NULL THEN
      v_ret := v_hold;
    ELSE
      v_ret := v_ret || ',' || v_hold;
    END IF;
  END LOOP;
  CLOSE CursorSevPers;
    
  --dbms_output.put_line('v_Ret ='||v_ret);
 
  OPEN CursorSevPerCom;
  LOOP
    FETCH CursorSevPerCom INTO v_hold2;
    EXIT WHEN CursorSevPerCom%NOTFOUND;
    IF v_ret2 IS NULL THEN
      v_ret2 := v_hold2;
    ELSE
      v_ret2 := v_ret2 || ',' || v_hold2;
    END IF;
  END LOOP;
  CLOSE CursorSevPerCom;
  
  --dbms_output.put_line('v_Ret2 ='||v_ret2);
	
	IF (v_cod_comando = 0 or v_cod_comando is null) Then
	
	   select c.num_orden, c.cod_lenguaje, e.cod_sistema, c.cod_comando
	   INTO  LN_num_orden, LN_cod_lenguaje, LN_cod_sistema, LN_cod_comando
	   from icc_comproc c, icg_central e
	   where c.cod_central = e.cod_central
		 and c.Num_movimiento = v_Num_Movimiento
		 and c.num_ooss = v_num_ooss;
		 
	    IF SQLCODE <> 0 THEN
	      RAISE error_proceso;
	    END IF;
	ELSE
	   select c.num_orden, c.cod_lenguaje, e.cod_sistema, c.cod_comando
	   INTO  LN_num_orden, LN_cod_lenguaje, LN_cod_sistema, LN_cod_comando
	   from icc_comproc c, icg_central e
	   where c.cod_central = e.cod_central
		 and c.Num_movimiento = v_Num_Movimiento
		 and c.cod_comando = v_cod_comando
		 and c.num_orden =  v_num_orden;
		 
	    IF SQLCODE <> 0 THEN
	      RAISE error_proceso;
	    END IF;
    END IF;
	
   /*dbms_output.put_line('LN_num_orden ='||LN_num_orden);
   dbms_output.put_line('LN_cod_lenguaje ='||LN_cod_lenguaje);
   dbms_output.put_line('LN_cod_sistema ='||LN_cod_sistema);
   dbms_output.put_line('LN_cod_comando ='||LN_cod_comando);*/

   LV_sql := '';
   LV_sql := LV_sql || 'SELECT lpad(cod_servsupl,2,''0'')||lpad(cod_nivel,4,''0'') ';
   LV_sql := LV_sql || '  FROM ga_servsuplabo ';
   LV_sql := LV_sql || ' WHERE num_abonado = ' || TO_CHAR(v_Num_Abondo);
   LV_sql := LV_sql || '   AND (cod_servsupl IN (' || TO_CHAR(v_ret) ||')'; 
   LV_sql := LV_sql || '        or lpad(cod_servsupl,2,''0'')||lpad(cod_nivel,4,''0'') IN (' || TO_CHAR(v_ret2) ||'))';
   LV_sql := LV_sql || '   AND ind_estado < 3';
   
   --dbms_output.put_line('Ret2 ='||LV_sql);
   
   OPEN CursorGAServ FOR LV_sql;
   LOOP
    FETCH CursorGAServ INTO LN_ServSupl;
    EXIT WHEN CursorGAServ%NOTFOUND;
    --dbms_output.put_line('Ret3 ='||LN_ServSupl);
	
	  OPEN CursorIcgRelaccion (v_Cod_Accion, LN_cod_comando, LN_num_orden, LN_cod_lenguaje, LN_cod_sistema);
	  LOOP
	    FETCH CursorIcgRelaccion INTO LN_DesCondicion;
	    EXIT WHEN CursorIcgRelaccion%NOTFOUND;
		   --dbms_output.put_line('Ret5 ='||LN_DesCondicion);
		   v_len_ser := LENGTH(LN_DesCondicion);
		   v_cont:=1;
		   WHILE v_cont < v_len_ser LOOP
           v_ser_tmp := SUBSTR(LN_DesCondicion,v_cont,6);
           v_cont := v_cont+6;
		   IF (LN_ServSupl = v_ser_tmp) THEN
			    v_out := v_ser_tmp;
		   END IF;
		END LOOP;
	  END LOOP;
	  CLOSE  CursorIcgRelaccion;
    END LOOP;
   CLOSE  CursorGAServ;
  
   
   --dbms_output.put_line('v_out ='||v_out);
   
    RETURN v_out;
   
    EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_RESCATA_CADSERVICIO, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20056,'Error',TRUE);
      RETURN 'ERROR FN_RESCATA_CADSERVICIO, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
END;

END IC_PKG_RESCATA_CADSERV;
/
SHOW ERRORS