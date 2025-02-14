CREATE OR REPLACE PACKAGE BODY IC_PLATINFRANET_PG AS

/*
<Documentación TipoDoc = "CUERPO">
  <Elemento Nombre = "IC_PLATINFRANET_PG" Lenguaje = "PL/SQL" Fecha = "04-05-2005"
    Versión = "1.1.0" Diseñador = "Carlos Sellao" Programador = "Carlos Sellao" Ambiente = "Oracle 8i">
    <Descripción> Funciones paramétricas orientadas a la plataforma de Infranet </Descripción>
    <Propietarios>
      <Prop>Interfaz con Centrales</Prop>
    </Propietarios>
  </Elemento>
</Documentación>
*/


FUNCTION IC_PLANNUEVO_FN(EN_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE)
/*
<Documentación TipoDoc = "Función">
<Elemento Nombre = "IC_PLANNUEVO_FN" Lenguaje="PL/SQL" Fecha="05-05-2005" Versión"1.0.0" Diseñador"Carlos Sellao H." Programador="Carlos Sellao H." Ambiente="Oracle 8i">
<Retorno>NA</Retorno>
<Descripción>Funcion para obtener el plan tarifario desde campo plan</Descripción>
<Parámetros>
<Entrada>
<param nom="EN_NUM_MOV" Tipo="ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE">Numero de movimiento</param>
</Entrada>
<Salida>
<param nom="LV_plan" Tipo="STRING">Codigo de plan tarifario</param>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
RETURN STRING IS
--
    LV_plan     icc_movimiento.plan%TYPE;
    error_proceso  EXCEPTION;
--
BEGIN

       SELECT
	           icc.plan
	   INTO
	           LV_plan
       FROM
	           icc_movimiento icc
       WHERE
	           icc.num_movimiento = EN_NUM_MOV;

       IF SQLCODE <> 0 THEN
         RAISE error_proceso;
       END IF;

       RETURN LV_plan;

EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR IC_PLANNUEVO_FN, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR IC_PLANNUEVO_FN, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
END;


FUNCTION IC_PLAN_FN(EN_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE)
/*
<Documentación TipoDoc = "Función">
<Elemento Nombre = "IC_PLAN_FN" Lenguaje="PL/SQL" Fecha="05-05-2005" Versión"1.0.0" Diseñador"Carlos Sellao H." Programador="Carlos Sellao H." Ambiente="Oracle 8i">
<Retorno>NA</Retorno>
<Descripción>Funcion para obtener el plan antiguo o actual desde tabla de abonado</Descripción>
<Parámetros>
<Entrada>
<param nom="EN_NUM_MOV" Tipo="ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE">Numero de movimiento</param>
</Entrada>
<Salida>
<param nom="LV_cod_plantarif" Tipo="STRING">Codigo de plan tarifario actual</param>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

RETURN STRING IS
--
    LV_num_abonado    ga_abocel.num_abonado%TYPE;
    LV_cod_plantarif  ga_abocel.cod_plantarif%TYPE;
    error_proceso  EXCEPTION;
--
BEGIN

       SELECT
	           icc.num_abonado
	   INTO
	           LV_num_abonado
       FROM
	           icc_movimiento icc
       WHERE
	           icc.num_movimiento = EN_NUM_MOV;


       BEGIN
          SELECT
		        abo.cod_plantarif
          INTO
		        LV_cod_plantarif
          FROM
		        ga_abocel abo
          WHERE
		        abo.num_abonado = LV_num_abonado;

          EXCEPTION
          WHEN NO_DATA_FOUND THEN

  	      BEGIN
               SELECT
			          abo.cod_plantarif
               INTO
			          LV_cod_plantarif
               FROM
			          ga_aboamist abo
               WHERE
			          abo.num_abonado = LV_num_abonado;
  	      EXCEPTION
	  	     WHEN NO_DATA_FOUND THEN
		   		  RETURN 'ERROR '|| ' ABONADO NO EXISTE EN TABLAS DE POSTPAGO NI PREPAGO';
		     WHEN OTHERS THEN
			      RETURN 'ERROR '||SQLERRM;
          END;

	 	WHEN OTHERS THEN
			RETURN 'ERROR '||SQLERRM;
        END;

       RETURN LV_cod_plantarif;

EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR IC_PLAN_FN, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR IC_PLAN_FN, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
END;


FUNCTION IC_PLANCANCEL_FN(EN_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE)
/*
<Documentación TipoDoc = "Función">
<Elemento Nombre = "IC_PLANCANCEL_FN" Lenguaje="PL/SQL" Fecha="20-06-2005" Versión"1.0.0" Diseñador"Carlos Sellao H." Programador="Carlos Sellao H." Ambiente="Oracle 8i">
<Retorno>NA</Retorno>
<Descripción>Funcion para obtener el plan tarifario que fue cancelado</Descripción>
<Parámetros>
<Entrada>
<param nom="EN_NUM_MOV" Tipo="ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE">Numero de movimiento</param>
</Entrada>
<Salida>
<param nom="LV_cod_plantarif" Tipo="STRING">Codigo de plan tarifario cancelado</param>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

RETURN STRING IS
--
    LV_num_abonado    ga_abocel.num_abonado%TYPE;
    LV_cod_plantarif  ga_abocel.cod_plantarif%TYPE;
    LV_cod_cliente    ga_abocel.cod_cliente%TYPE;
    error_proceso  EXCEPTION;
--
BEGIN

       SELECT
	           icc.num_abonado
	   INTO
	           LV_num_abonado
       FROM
	           icc_movimiento icc
       WHERE
	           icc.num_movimiento = EN_NUM_MOV;


       BEGIN
          SELECT
		        abo.cod_cliente
          INTO
		        LV_cod_cliente
          FROM
		        ga_abocel abo
          WHERE
		        abo.num_abonado = LV_num_abonado;

          EXCEPTION
          WHEN NO_DATA_FOUND THEN

  	      BEGIN
               SELECT
			          abo.cod_cliente
               INTO
			          LV_cod_cliente
               FROM
			          ga_aboamist abo
               WHERE
			          abo.num_abonado = LV_num_abonado;
  	      EXCEPTION
	  	     WHEN NO_DATA_FOUND THEN
		   		  RETURN 'ERROR '|| ' ABONADO NO EXISTE EN TABLAS DE POSTPAGO NI PREPAGO';
		     WHEN OTHERS THEN
			      RETURN 'ERROR '||SQLERRM;
          END;

	 	WHEN OTHERS THEN
			RETURN 'ERROR '||SQLERRM;
        END;



        SELECT
                cel.cod_plantarif
        INTO
                LV_cod_plantarif
        FROM
                ga_intarcel cel
        WHERE
                cel.cod_cliente = LV_cod_cliente
          AND
                cel.num_abonado = LV_num_abonado
          AND
                cel.ind_numero IS NOT NULL
          AND
                cel.fec_desde in (
                  SELECT
                          MAX(cel2.fec_desde)
                    FROM
                          ga_intarcel cel2
                   WHERE
                          cel2.cod_cliente = LV_cod_cliente
                     AND
                          cel2.num_abonado = LV_num_abonado);

        IF SQLCODE <> 0 THEN
           RAISE error_proceso;
        END IF;

        RETURN LV_cod_plantarif;

EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR IC_PLANCANCEL_FN, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR IC_PLANCANCEL_FN, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
END;


FUNCTION IC_PLANMODULE_FN(EN_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE)
/*
<Documentación TipoDoc = "Función">
<Elemento Nombre = "IC_PLANMODULE_FN" Lenguaje="PL/SQL" Fecha="20-06-2005" Versión"1.0.0" Diseñador"Carlos Sellao H." Programador="Carlos Sellao H." Ambiente="Oracle 8i">
<Retorno>NA</Retorno>
<Descripción>Funcion para obtener el plan tarifario pendiente de aplicar al proximo ciclo</Descripción>
<Parámetros>
<Entrada>
<param nom="EN_NUM_MOV" Tipo="ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE">Numero de movimiento</param>
</Entrada>
<Salida>
<param nom="LV_plantarif" Tipo="STRING">Código de plan tarifario pendiente</param>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

RETURN STRING IS
--
    LV_cod_ciclo      ga_abocel.cod_ciclo%TYPE;
    LV_cod_ciclo_nue  ga_abocel.cod_ciclo%TYPE;
    LV_num_abonado    ga_abocel.num_abonado%TYPE;
    LV_cod_cliente    ga_abocel.cod_cliente%TYPE;
    LV_cod_ciclfact   fa_ciclfact.cod_ciclfact%TYPE;
    LV_plantarif      ga_abocel.cod_plantarif%TYPE;
    error_proceso  EXCEPTION;
--
BEGIN

       SELECT
	           icc.num_abonado
	   INTO
	           LV_num_abonado
       FROM
	           icc_movimiento icc
       WHERE
	           icc.num_movimiento = EN_NUM_MOV;


       BEGIN
          SELECT
		        abo.cod_cliente, abo.cod_ciclo
          INTO
		        LV_cod_cliente, LV_cod_ciclo
          FROM
		        ga_abocel abo
          WHERE
		        abo.num_abonado = LV_num_abonado;

          EXCEPTION
          WHEN NO_DATA_FOUND THEN

  	      BEGIN
               SELECT
			          abo.cod_cliente, abo.cod_ciclo
               INTO
			          LV_cod_cliente,  LV_cod_ciclo
               FROM
			          ga_aboamist abo
               WHERE
			          abo.num_abonado = LV_num_abonado;
  	      EXCEPTION
	  	     WHEN NO_DATA_FOUND THEN
		   		  RETURN 'ERROR '|| ' ABONADO NO EXISTE EN TABLAS DE POSTPAGO NI PREPAGO';
		     WHEN OTHERS THEN
			      RETURN 'ERROR '||SQLERRM;
          END;

	 	WHEN OTHERS THEN
			RETURN 'ERROR '||SQLERRM;
        END;


        SELECT
		       fac.cod_ciclfact
        INTO
		       LV_cod_ciclfact
        FROM
		       fa_ciclfact fac
        WHERE
		       fac.cod_ciclo = LV_cod_ciclo
        AND
		       sysdate BETWEEN fac.fec_desdellam AND fac.fec_hastallam;

        IF SQLCODE <> 0 THEN
           RAISE error_proceso;
        END IF;

        BEGIN
           SELECT
                  fin.cod_plantarif
           INTO
                  LV_plantarif
           FROM
                  ga_finciclo fin
           WHERE
                  fin.cod_cliente = LV_cod_cliente
           AND
                  fin.num_abonado = LV_num_abonado
           AND
                  fin.cod_ciclfact = LV_cod_ciclfact
           AND
                  fin.cod_plantarif IS NOT NULL;
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
           LV_plantarif := ' ';
        WHEN OTHERS THEN
           RAISE error_proceso;
        END;

        RETURN LV_plantarif;

EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR IC_PLANMODULE_FN, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR IC_PLANMODULE_FN, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
END;


FUNCTION IC_CICLO_FN(EN_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE)
/*
<Documentación TipoDoc = "Función">
<Elemento Nombre = "IC_CICLO_FN" Lenguaje="PL/SQL" Fecha="05-05-2005" Versión"1.0.0" Diseñador"Carlos Sellao H." Programador="Carlos Sellao H." Ambiente="Oracle 8i">
<Retorno>NA</Retorno>
<Descripción>Funcion para obtener el dia de inicio correspondiente al ciclo actual</Descripción>
<Parámetros>
<Entrada>
<param nom="EN_NUM_MOV" Tipo="ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE">Numero de movimiento</param>
</Entrada>
<Salida>
<param nom="LV_dia_ciclo" Tipo="STRING">Dia de inicio del ciclo</param>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

RETURN STRING IS
--
    LV_cod_ciclo      ga_abocel.cod_ciclo%TYPE;
    LV_num_abonado    ga_abocel.num_abonado%TYPE;
    LV_dia_ciclo      VARCHAR2(4);
    error_proceso  EXCEPTION;
--
BEGIN

       SELECT
	           icc.num_abonado
	   INTO
	           LV_num_abonado
       FROM
	           icc_movimiento icc
       WHERE
	           icc.num_movimiento = EN_NUM_MOV;


       BEGIN
          SELECT
		        abo.cod_ciclo
          INTO
		        LV_cod_ciclo
          FROM
		        ga_abocel abo
          WHERE
		        abo.num_abonado = LV_num_abonado;

          EXCEPTION
          WHEN NO_DATA_FOUND THEN

  	      BEGIN
               SELECT
			          abo.cod_ciclo
               INTO
			          LV_cod_ciclo
               FROM
			          ga_aboamist abo
               WHERE
			          abo.num_abonado = LV_num_abonado;
  	      EXCEPTION
	  	     WHEN NO_DATA_FOUND THEN
		   		  RETURN 'ERROR '|| ' ABONADO NO EXISTE EN TABLAS DE POSTPAGO NI PREPAGO';
		     WHEN OTHERS THEN
			      RETURN 'ERROR '||SQLERRM;
          END;

	 	WHEN OTHERS THEN
			RETURN 'ERROR '||SQLERRM;
        END;


        SELECT
		       to_char(fac.fec_desdellam,'dd') dia
        INTO
		       LV_dia_ciclo
        FROM
		       fa_ciclfact fac
        WHERE
		       fac.cod_ciclo = LV_cod_ciclo
        AND
		       sysdate BETWEEN fac.fec_desdellam AND fac.fec_hastallam;

        IF SQLCODE <> 0 THEN
           RAISE error_proceso;
        END IF;

        RETURN LV_dia_ciclo;

EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR IC_CICLO_FN, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR IC_CICLO_FN, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
END;


FUNCTION IC_CICLONUEVO_FN(EN_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE)
/*
<Documentación TipoDoc = "Función">
<Elemento Nombre = "IC_CICLONUEVO_FN" Lenguaje="PL/SQL" Fecha="20-06-2005" Versión"1.0.0" Diseñador"Carlos Sellao H." Programador="Carlos Sellao H." Ambiente="Oracle 8i">
<Retorno>NA</Retorno>
<Descripción>Funcion para obtener el dia de inicio correspondiente al ciclo nuevo</Descripción>
<Parámetros>
<Entrada>
<param nom="EN_NUM_MOV" Tipo="ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE">Numero de movimiento</param>
</Entrada>
<Salida>
<param nom="LV_dia_ciclo" Tipo="STRING">Dia de inicio del ciclo nuevo</param>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

RETURN STRING IS
--
    LV_cod_ciclo      ga_abocel.cod_ciclo%TYPE;
    LV_cod_ciclo_nue  ga_abocel.cod_ciclo%TYPE;
    LV_num_abonado    ga_abocel.num_abonado%TYPE;
    LV_cod_cliente    ga_abocel.cod_cliente%TYPE;
    LV_cod_ciclfact   fa_ciclfact.cod_ciclfact%TYPE;
    LV_plantarif      ga_abocel.cod_plantarif%TYPE;
    LV_dia_ciclo      VARCHAR2(4);
    error_proceso  EXCEPTION;
--
BEGIN

       SELECT
	           icc.num_abonado
	   INTO
	           LV_num_abonado
       FROM
	           icc_movimiento icc
       WHERE
	           icc.num_movimiento = EN_NUM_MOV;


       BEGIN
          SELECT
		        abo.cod_ciclo
          INTO
		         LV_cod_ciclo
          FROM
		        ga_abocel abo
          WHERE
		        abo.num_abonado = LV_num_abonado;

          EXCEPTION
          WHEN NO_DATA_FOUND THEN

  	      BEGIN
               SELECT
			          abo.cod_ciclo
               INTO
			          LV_cod_ciclo
               FROM
			          ga_aboamist abo
               WHERE
			          abo.num_abonado = LV_num_abonado;
  	      EXCEPTION
	  	     WHEN NO_DATA_FOUND THEN
		   		  RETURN 'ERROR '|| ' ABONADO NO EXISTE EN TABLAS DE POSTPAGO NI PREPAGO';
		     WHEN OTHERS THEN
			      RETURN 'ERROR '||SQLERRM;
          END;

	 	WHEN OTHERS THEN
			RETURN 'ERROR '||SQLERRM;
        END;


        SELECT
		       fac.cod_ciclfact
        INTO
		       LV_cod_ciclfact
        FROM
		       fa_ciclfact fac
        WHERE
		       fac.cod_ciclo = LV_cod_ciclo
        AND
		       sysdate BETWEEN fac.fec_desdellam AND fac.fec_hastallam;

        IF SQLCODE <> 0 THEN
           RAISE error_proceso;
        END IF;

        SELECT
               fin.cod_ciclo
        INTO
               LV_cod_ciclo_nue
        FROM
               ga_finciclo fin
        WHERE
               fin.cod_cliente = LV_cod_cliente
        AND
               fin.num_Abonado = LV_num_abonado
        AND
               fin.cod_ciclfact = LV_cod_ciclfact
        AND
               fin.cod_ciclo IS NOT NULL;

        IF SQLCODE <> 0 THEN
           RAISE error_proceso;
        END IF;


       SELECT
		      to_char(fac.fec_desdellam,'dd') dia
       INTO
		      LV_cod_ciclfact
       FROM
		      fa_ciclfact fac
       WHERE
		      fac.cod_ciclo = LV_cod_ciclo_nue
       AND
		      sysdate BETWEEN fac.fec_desdellam AND fac.fec_hastallam;

       IF SQLCODE <> 0 THEN
          RAISE error_proceso;
       END IF;

       RETURN LV_dia_ciclo;

EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR IC_CICLONUEVO_FN, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR IC_CICLONUEVO_FN, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
END;



FUNCTION IC_TIPOLINEA_FN(EN_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE)
/*
<Documentación TipoDoc = "Función">
<Elemento Nombre = "IC_TIPOLINEA_FN" Lenguaje="PL/SQL" Fecha="05-05-2005" Versión"1.0.0" Diseñador"Carlos Sellao H." Programador="Carlos Sellao H." Ambiente="Oracle 8i">
<Retorno>NA</Retorno>
<Descripción>Funcion para obtener el tipo de linea del abonado prepago/pospago</Descripción>
<Parámetros>
<Entrada>
<param nom="EN_NUM_MOV" Tipo="ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE">Numero de movimiento</param>
</Entrada>
<Salida>
<param nom="LV_tipo" Tipo="STRING">Codigo referencial de su tipo de linea del abonado</param>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

RETURN STRING IS
--
	LV_num_abonado_pos ga_abocel.num_abonado%TYPE;
    LV_num_abonado_pre ga_abocel.num_abonado%TYPE;
    LV_num_abonado     ga_abocel.num_abonado%TYPE;
	LV_tipo            VARCHAR2(4);
    error_proceso  EXCEPTION;
--
BEGIN

       LV_num_abonado_pos := 0;
       LV_num_abonado_pre := 0;

       SELECT
	           icc.num_abonado
	   INTO
	           LV_num_abonado
       FROM
	           icc_movimiento icc
       WHERE
	           icc.num_movimiento = EN_NUM_MOV;

       BEGIN
          SELECT
		         abo.num_abonado
          INTO
		         LV_num_abonado_pos
          FROM
		         ga_abocel abo
          WHERE
		         abo.num_abonado = LV_num_abonado;

          EXCEPTION
          WHEN NO_DATA_FOUND THEN

  	      BEGIN
               SELECT
			          abo.num_abonado
               INTO
			          LV_num_abonado_pre
               FROM
			          ga_aboamist abo
               WHERE
			          abo.num_abonado = LV_num_abonado;
  	      EXCEPTION
	  	     WHEN NO_DATA_FOUND THEN
		   		  RETURN 'ERROR '|| ' ABONADO NO EXISTE EN TABLAS DE POSTPAGO NI PREPAGO';
		     WHEN OTHERS THEN
			      RETURN 'ERROR '||SQLERRM;
          END;

	 	WHEN OTHERS THEN
			RETURN 'ERROR '||SQLERRM;
        END;

        IF LV_num_abonado_pos <> 0 THEN
          LV_tipo:='1';
		ELSE
          LV_tipo:='0';
		END IF;

        RETURN LV_tipo;

EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR IC_TIPOLINEA_FN, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR IC_TIPOLINEA_FN, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
END;



FUNCTION IC_SERVINFRANET_FN(EN_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE)
/*
<Documentación TipoDoc = "Función">
<Elemento Nombre = "IC_SERVINFRANET_FN" Lenguaje="PL/SQL" Fecha="05-05-2005" Versión"1.0.0" Diseñador"Carlos Sellao H." Programador="Carlos Sellao H." Ambiente="Oracle 8i">
<Retorno>NA</Retorno>
<Descripción>Funcion para filtrar codigos de servicios infranet</Descripción>
<Parámetros>
<Entrada>
<param nom="EN_NUM_MOV" Tipo="ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE">Numero de movimiento</param>
</Entrada>
<Salida>
<param nom="LV_serv_infranet" Tipo="STRING">codigo nemotecnico de servicios/nivel suplementarios infranet</param>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

RETURN STRING IS
--
	LV_cod_servicios icc_movimiento.cod_servicios%TYPE;
	LV_serv_tmp      icc_movimiento.cod_servicios%TYPE;
	LV_serv          icc_movimiento.cod_servicios%TYPE;
	LV_nivel         icc_movimiento.cod_servicios%TYPE;
	LV_servicios     icc_movimiento.cod_servicios%TYPE;
	LV_serv_infranet icc_movimiento.cod_servicios%TYPE;
	LV_serv_cancel   icc_movimiento.cod_servicios%TYPE;
    LV_ind_infranet  ga_servsupl.ind_infranet%TYPE;
	LV_cont          NUMBER := 1;
	LV_len_serv      NUMBER := 0;
    error_proceso  EXCEPTION;
--
BEGIN

       SELECT
	           NVL(icc.cod_servicios,CHR(0))
	   INTO
	           LV_cod_servicios
       FROM
	           icc_movimiento icc
       WHERE
	           icc.num_movimiento = EN_NUM_MOV;


       LV_servicios := LTRIM(RTRIM(LV_cod_servicios));
	   LV_len_serv := LENGTH(LV_servicios);
	   LV_serv_infranet := '';
	   LV_cont := 1;

       WHILE LV_cont < LV_len_serv LOOP
           LV_serv_tmp := SUBSTR(LV_servicios,LV_cont,6);
           LV_serv := SUBSTR(LV_serv_tmp,1,2);
           LV_nivel := SUBSTR(LV_serv_tmp,3,4);
           LV_cont := LV_cont+6;

		   LV_ind_infranet := 0;

		   BEGIN
              SELECT
		             NVL(serv.ind_infranet,0)
              INTO
		             LV_ind_infranet
              FROM
		             ga_servsupl serv
              WHERE
                     serv.cod_servsupl = TO_NUMBER(LV_serv)
   	          AND
			         serv.cod_nivel = TO_NUMBER(LV_nivel);
  	       EXCEPTION
	  	      WHEN NO_DATA_FOUND THEN
		   	      LV_ind_infranet := 0;
              WHEN OTHERS THEN
                  RAISE error_proceso;
           END;

		   IF LV_ind_infranet = 1 THEN
		        IF LV_nivel <> '0000' THEN
                   LV_serv_cancel := LV_serv || '0000';
                   LV_serv_infranet := LV_serv_infranet || LV_serv_cancel || LV_serv_tmp;
                ELSE
		           LV_serv_infranet := LV_serv_infranet || LV_serv_tmp;
                END IF;
		   END IF;

       END LOOP;


       RETURN LV_serv_infranet;

EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR IC_SERVINFRANET_FN, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR IC_SERVINFRANET_FN, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
END;


FUNCTION IC_FECEFECTIVA_FN(EN_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE)
/*
<Documentación TipoDoc = "Función">
<Elemento Nombre = "IC_FECEFECTIVA_FN" Lenguaje="PL/SQL" Fecha="20-06-2005" Versión"1.0.0" Diseñador"Carlos Sellao H." Programador="Carlos Sellao H." Ambiente="Oracle 8i">
<Retorno>NA</Retorno>
<Descripción>Funcion para obtener las fechas efectiva de activación de los cambios</Descripción>
<Parámetros>
<Entrada>
<param nom="EN_NUM_MOV" Tipo="ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE">Numero de movimiento</param>
</Entrada>
<Salida>
<param nom="LV_fecha_out" Tipo="STRING">fechas efectivas en segundos, fecha +1 y fecha +2</param>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

RETURN STRING IS
--
    LV_cod_ciclo      ga_abocel.cod_ciclo%TYPE;
    LV_num_abonado    ga_abocel.num_abonado%TYPE;
    LV_cod_cliente    ga_abocel.cod_cliente%TYPE;
    LV_fec_desdellam  fa_ciclfact.fec_desdellam%TYPE;
    LV_segundos       NUMBER;
    LV_cod_ciclfact   fa_ciclfact.cod_ciclfact%TYPE;
    LV_plantarif      ga_abocel.cod_plantarif%TYPE;
    LV_fecha_out      VARCHAR2(128);
    LV_hay_pendiente  NUMBER;
    error_proceso  EXCEPTION;
--
BEGIN

       SELECT
	           icc.num_abonado
	   INTO
	           LV_num_abonado
       FROM
	           icc_movimiento icc
       WHERE
	           icc.num_movimiento = EN_NUM_MOV;


       BEGIN
          SELECT
		        abo.cod_cliente, NVL(abo.cod_ciclo,0)
          INTO
		        LV_cod_cliente, LV_cod_ciclo
          FROM
		        ga_abocel abo
          WHERE
		        abo.num_abonado = LV_num_abonado;

          EXCEPTION
          WHEN NO_DATA_FOUND THEN

  	      BEGIN
               SELECT
			          abo.cod_cliente, NVL(abo.cod_ciclo,0)
               INTO
			          LV_cod_cliente, LV_cod_ciclo
               FROM
			          ga_aboamist abo
               WHERE
			          abo.num_abonado = LV_num_abonado;
  	      EXCEPTION
	  	     WHEN NO_DATA_FOUND THEN
		   		  RETURN 'ERROR '|| ' ABONADO NO EXISTE EN TABLAS DE POSTPAGO NI PREPAGO';
		     WHEN OTHERS THEN
			      RETURN 'ERROR '||SQLERRM;
          END;

	 	WHEN OTHERS THEN
			RETURN 'ERROR '||SQLERRM;
        END;


        SELECT
		       fac.cod_ciclfact, fac.fec_desdellam
        INTO
		       LV_cod_ciclfact, LV_fec_desdellam
        FROM
		       fa_ciclfact fac
        WHERE
		       fac.cod_ciclo = LV_cod_ciclo
        AND
		       sysdate BETWEEN fac.fec_desdellam AND fac.fec_hastallam;

        IF SQLCODE <> 0 THEN
           RAISE error_proceso;
        END IF;


        LV_hay_pendiente := 1;

        BEGIN
           SELECT
                  fin.cod_plantarif
           INTO
                  LV_plantarif
           FROM
                  ga_finciclo fin
           WHERE
                  fin.cod_cliente = LV_cod_cliente
           AND
                  fin.num_abonado = LV_num_abonado
           AND
                  fin.cod_ciclfact = LV_cod_ciclfact
           AND
                  fin.cod_plantarif IS NOT NULL;

        EXCEPTION
        WHEN NO_DATA_FOUND THEN
           LV_hay_pendiente := 0;
        WHEN OTHERS THEN
           RAISE error_proceso;
        END;


        IF LV_hay_pendiente = 1 THEN
           LV_segundos := ( LV_fec_desdellam - TO_DATE('01011970','ddmmyyyyhh24miss') ) * 3600*24;
		   LV_fecha_out := TO_CHAR(LV_segundos) || ',fecCompra1=' || TO_CHAR(LV_segundos + 1) || ',fecCompra2=' || TO_CHAR(LV_segundos + 2);
        ELSE
           LV_fecha_out := '0,fecCompra1=0,fecCompra2=0';
		END IF;


		RETURN LV_fecha_out;


EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR IC_FECEFECTIVA_FN, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR IC_FECEFECTIVA_FN, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
END;


END IC_PLATINFRANET_PG;
/
SHOW ERRORS
