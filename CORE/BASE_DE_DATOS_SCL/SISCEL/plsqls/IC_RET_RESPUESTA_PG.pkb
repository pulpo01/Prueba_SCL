CREATE OR REPLACE PACKAGE BODY IC_RET_RESPUESTA_PG AS
------------------------------------------------------------------------------------------------------------
FUNCTION IC_RETRESP_SALDO_FN(EN_num_mov IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE)
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_RETRESP_SALDO_FN"
                Lenguaje="PL/SQL"
                Fecha creación=""
                Creado por=""
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>STRING</Retorno>
                <Descripción>Funcion </Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>VARCHAR</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
RETURN STRING IS
        LV_Carga   ICC_MOVIMIENTO.CARGA%TYPE;
        LN_cod_retorno NUMBER(4);
        LV_des_error VARCHAR2(512);
    LV_sql  VARCHAR2(512);
BEGIN

        select NVL(round(to_number(substr(des_respuesta,instr(des_respuesta,'#SA')+7,
        instr(des_respuesta,'#',
        instr(des_respuesta,'#')+1,1)-instr(des_respuesta,'#')-7  )) ,2),-1) cadena
        INTO LV_Carga
        from icc_comproc
        where num_movimiento = EN_num_mov
        and cod_comando
        in( select to_number(val_parametro) from ged_parametros where cod_modulo='IC'
                and nom_parametro ='COM_RESCATA_SALDO');

    IF  LV_Carga=-1
     THEN
            RETURN 'empty-NO HA ARRIVADO EL SALDO-empty';
    ELSE
            RETURN LV_Carga;
    END IF;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
                RETURN 'empty-NO HA ARRIVADO EL SALDO-empty';
    WHEN OTHERS THEN
         LN_cod_retorno := 1370;
         RETURN 'FALSE';
END IC_RETRESP_SALDO_FN;
---------------------------------------------------------------------------------------------------------

FUNCTION IC_RETSS_ABONADO_FN(EN_num_mov IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE)
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_RETSS_ABONADO_FN"
                Lenguaje="PL/SQL"
                Fecha creación=""
                Creado por=""
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>STRING</Retorno>
                <Descripción>Funcion </Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>VARCHAR</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
RETURN STRING IS
        LV_SSABO  GA_ABOCEL.CLASE_SERVICIO%TYPE;
        LN_cod_retorno NUMBER(4);
        LV_des_error VARCHAR2(512);
        LV_sql  VARCHAR2(512);
BEGIN


select  NVL(clase_servicio,'ABO_SIN_SERVICIOS')  INTO LV_SSABO
from  ga_abocel a, icc_movimiento b
where b.num_movimiento=  EN_num_mov
and a.num_abonado =b.num_abonado
union
select  NVL(clase_servicio,'ABO_SIN_SERVICIOS')
from  ga_aboamist a, icc_movimiento b
where b.num_movimiento=  EN_num_mov
and a.num_abonado =b.num_abonado;

RETURN  LV_SSABO;


EXCEPTION
    WHEN NO_DATA_FOUND THEN
                RETURN 'empty-PROBLEMAS AL RETORNAR SS A ABONADO-empty';
    WHEN OTHERS THEN
         LN_cod_retorno := 1371;
         RETURN 'FALSE';
END IC_RETSS_ABONADO_FN;
---------------------------------------------------------------------------------------------------------
FUNCTION IC_RETSS_MOVIMIENTO_FN(EN_num_mov IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE)
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_RETSS_ABONADO_FN"
                Lenguaje="PL/SQL"
                Fecha creación=""
                Creado por=""
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>STRING</Retorno>
                <Descripción>Funcion </Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>VARCHAR</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
RETURN STRING IS
        LV_SSMOV   ICC_MOVIMIENTO.COD_SERVICIOS%TYPE;
        LN_cod_retorno NUMBER(4);
        LV_des_error VARCHAR2(512);
    LV_sql  VARCHAR2(512);
BEGIN


select NVL(COD_SERVICIOS,'MOV_SIN_SERVICIOS') INTO LV_SSMOV
from icc_movimiento
where num_movimiento=  EN_num_mov;


RETURN  LV_SSMOV;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
                RETURN 'empty-PROBLEMAS AL RETORNAR SS DESDE MOVIMIENTO-empty';
    WHEN OTHERS THEN
         LN_cod_retorno := 1372;
         RETURN 'FALSE';
END IC_RETSS_MOVIMIENTO_FN;
---------------------------------------------------------------------------------------------------------
FUNCTION IC_RETSS_ABO_FN(EN_num_mov IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE)
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_RETSS_ABONADO_FN"
                Lenguaje="PL/SQL"
                Fecha creación=""
                Creado por=""
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>STRING</Retorno>
                <Descripción>Funcion </Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>VARCHAR</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
RETURN STRING IS
    SV_Clase_Servicio  GA_ABOCEL.CLASE_SERVICIO%TYPE;
    LV_SITABO GA_ABOCEL.COD_SITUACION%TYPE;
    SV_Servicio_Grupo varchar2(30);
        LN_cod_retorno NUMBER(4);
        LV_des_error VARCHAR2(512);
    LV_sql  VARCHAR2(512);

CURSOR CURSOR_SERVICIOS IS
    SELECT LPAD(cod_servsupl,2,'0')||LPAD(cod_nivel,4,'0')
    FROM ga_servsuplabo ga, icc_movimiento ic
    WHERE ic.num_movimiento = EN_num_mov
    AND ga.num_abonado=ic.num_abonado
    AND ga.ind_estado=2;

CURSOR CURSOR_SERVICIOSBAJA IS
    SELECT LPAD(cod_servsupl,2,'0')||LPAD(cod_nivel,4,'0')
    FROM ga_servsuplabo ga, icc_movimiento ic
    WHERE ic.num_movimiento = EN_num_mov
    AND ga.num_abonado=ic.num_abonado
    AND ga.ind_estado=5;


BEGIN

SV_Clase_Servicio:= '';

        SELECT ab.cod_situacion into LV_SITABO
        from ga_abocel ab, icc_movimiento icc
        where icc.num_movimiento =EN_num_mov
        and icc.num_abonado=ab.num_abonado
        union
        SELECT am.cod_situacion
        from ga_aboamist am, icc_movimiento icc
        where icc.num_movimiento =EN_num_mov
        and icc.num_abonado=am.num_abonado;

IF LV_SITABO='BAP' OR LV_SITABO='REP' THEN

       OPEN CURSOR_SERVICIOSBAJA;
    LOOP
        FETCH CURSOR_SERVICIOSBAJA INTO  SV_Servicio_Grupo;
        EXIT WHEN CURSOR_SERVICIOSBAJA%NOTFOUND;
        SV_Clase_Servicio := SV_Clase_Servicio || SV_Servicio_Grupo;
    END LOOP;
    CLOSE CURSOR_SERVICIOSBAJA;

ELSE

    OPEN CURSOR_SERVICIOS;
    LOOP
        FETCH CURSOR_SERVICIOS INTO  SV_Servicio_Grupo;
        EXIT WHEN CURSOR_SERVICIOS%NOTFOUND;
        SV_Clase_Servicio := SV_Clase_Servicio || SV_Servicio_Grupo;
    END LOOP;
    CLOSE CURSOR_SERVICIOS;
END IF;

RETURN SV_Clase_Servicio;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
                RETURN 'empty-PROBLEMAS AL RETORNAR SS A ABONADO-empty';
    WHEN OTHERS THEN
         LN_cod_retorno := 1371;
         RETURN 'empty-PROBLEMAS AL RETORNAR SS A ABONADO-empty';
END IC_RETSS_ABO_FN;

--------------------------------------------------------------------------------------------
FUNCTION IC_SUSP_ABO_FN(EN_num_mov IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE)
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_SUSP_ABO_FN"
                Lenguaje="PL/SQL"
                Fecha creación=""
                Creado por=""
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>STRING</Retorno>
                <Descripción>Funcion </Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>VARCHAR</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/

RETURN STRING IS
    error_proceso EXCEPTION;
    SV_Salida  VARCHAR2(512);
    SV_Suspension varchar2(32);
    LN_cod_retorno NUMBER(4);
    	LV_des_error VARCHAR2(512);
    LV_sql  VARCHAR2(512);

CURSOR CURSOR_SERVICIOS IS
    SELECT '('||ga.cod_servicio||'-'||ga.cod_modulo||')'
    FROM ga_susprehabo ga, icc_movimiento ic
    WHERE ic.num_movimiento = EN_num_mov
    AND ga.num_abonado=ic.num_abonado
    AND ga.fec_rehacen is null
	AND ga.fec_suspcen is not null
	AND ga.COD_MODULO <> ic.COD_MODULO
	AND ga.COD_SERVICIO <> ic.COD_SUSPREHA
	order by ga.fec_suspbd;

BEGIN

	 SV_Salida:= '';

    OPEN CURSOR_SERVICIOS;
    LOOP
        FETCH CURSOR_SERVICIOS INTO  SV_Suspension;
        EXIT WHEN CURSOR_SERVICIOS%NOTFOUND;
        SV_Salida := SV_Salida || SV_Suspension;
    END LOOP;
	
    CLOSE CURSOR_SERVICIOS;
	
	IF SV_Salida is null THEN
	   SV_Salida:='FALSE';
    END IF;


RETURN SV_Salida;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
                RETURN 'FALSE';
   WHEN error_proceso THEN
      RETURN 'empty - ERROR IC_SUSP_ABO_FN, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
   WHEN OTHERS THEN
      RETURN 'empty - ERROR IC_SUSP_ABO_FN, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
END;

--------------------------------------------------------------------------------------------
END IC_RET_RESPUESTA_PG;
/
SHOW ERRORS
