CREATE OR REPLACE PROCEDURE        P_AL_TARJETAS_CRON
IS
-- 1. Genera peticiones de tarjeta a todo abonado de alta con antiguedad minima
-- de dos meses y que a su cuenta no se le haya generado tarjeta, es decir,
-- a cualquier otro abonado de esa cuenta.
-- 2. genera solicitud de la baja a las tarjetas que hayan alcanzado el fin de vigencia.
-- Al final de todo hace commit. Sino Rollback.
--
v_cod_cuenta 	ga_abocel.cod_cuenta%type;
v_cod_cliente 	ga_abocel.cod_cliente%type;
v_num_abonado 	ga_abocel.num_abonado%type;
v_cod_usuario 	ga_abocel.cod_usuario%type;
v_rango       	al_rangos_club.cod_rango%type;
v_num_serie  	al_tarjetas_club.num_serie%type;
v_serie         al_tarjetas_club.num_serie%type;
v_can_rango     NUMBER;
v_error         NUMBER;
v_errorint      NUMBER;
v_cont 		NUMBER;
--
-- Selecciona abonados que no se les haya generado tarjeta, que tengan mas de 2 meses
-- y que no existan en tabla al_tarjetas_club, es decir, que no se les haya generado tarjeta
CURSOR c_abocel_alta IS
	SELECT a.cod_cuenta, a.cod_cliente, a.num_abonado, a.cod_usuario
	FROM ga_abocel a, (select cod_cuenta, min(fec_alta) fec_alta
		 		   	   from  ga_abocel b
		 		   	   where fec_alta < SYSDATE - GE_FN_DEVVALPARAM('AC',1,'DIAS_PETICION_TCLUB')
					   and   cod_situacion = 'AAA'
					   group by cod_cuenta) c
	WHERE a.fec_alta < SYSDATE - GE_FN_DEVVALPARAM('AC',1,'DIAS_PETICION_TCLUB')
	AND NOT EXISTS (
			SELECT NULL FROM al_tarjetas_club b
			WHERE b.num_abonado = a.num_abonado)
	AND a.cod_cuenta = c.cod_cuenta
	AND a.fec_alta = c.fec_alta
	AND a.cod_situacion = 'AAA';
--
-- Selecciona abonados cuyas tarjetas hayan caducado, esten activas y en poder del cliente
CURSOR c_tarjetas_caducadas IS
	SELECT a.num_abonado, a.cod_usuario, b.num_serie
	FROM ga_abocel a , al_tarjetas_club b
	WHERE (b.fec_vigencia < SYSDATE OR a.cod_situacion IN ('BAA','BAP'))
	  AND a.num_abonado = b.num_abonado
	  AND b.cod_estado != 'BA'
	  AND b.num_serie > ' ';
--
BEGIN
-- Actualizacisn de estado en el scheduler de facturacion para indicar que esta en ejecucion
	v_errorint := -20001;
	UPDATE fa_intqueueproc
	SET   cod_estado = 3,
	      fec_estado = sysdate
	WHERE cod_proceso = 100
	  AND cod_modgener = 'TCL';
	COMMIT;
--
-- Ejecuta la peticion de Tarjetas llamando al p_al_tarjetas_club
   v_errorint := -20002;
   OPEN c_abocel_alta;
   LOOP
   	v_errorint := -20003;
	FETCH c_abocel_alta INTO v_cod_cuenta, v_cod_cliente, v_num_abonado, v_cod_usuario;
	EXIT when c_abocel_alta%NOTFOUND;
--
--      Verifica que no exista otro Abonado de la misma cuenta ya con tarjeta
	SELECT COUNT(*) INTO v_cont
	FROM ga_abocel a, al_tarjetas_club b
	WHERE cod_cuenta = v_cod_cuenta
	AND a.num_abonado =b.num_abonado;
--
	IF v_cont = 0 THEN
		--	Obtiene rango de la categoria del cliente
		   	v_errorint := -20004;
			SELECT COUNT(*) INTO v_can_rango
			FROM ge_clientes a, al_rangos_club b
			WHERE a.cod_cliente = v_cod_cliente
			  AND a.cod_categoria = b.cod_categoria;
			IF v_can_rango = 0 THEN
				v_rango:= '000';
			ELSE
		   		v_errorint := -20005;
				SELECT b.cod_rango INTO v_rango
				FROM ge_clientes a, al_rangos_club b
				WHERE a.cod_cliente = v_cod_cliente
			  	  AND a.cod_categoria = b.cod_categoria;
			END IF;
		--
		   	v_errorint := -20006;
			SELECT al_seq_club.NEXTVAL INTO v_num_serie FROM DUAL;
			v_serie:= v_rango||v_num_serie;
		--
		--  Llamada a procedimiento que ejecuta la peticion de tarjeta, actualizando tabla al_tarjetas_club
			p_al_tarjetas_club (v_serie, 'PD', v_cod_usuario, v_num_abonado, user, sysdate, null, v_error);
			IF v_error <> 0 THEN
				ROLLBACK;
		   		v_errorint := -20007;
		--	 	Actualiza estado de error en el scheduler de facturacion
				UPDATE fa_intqueueproc
				SET   cod_estado = 4,
				      fec_estado = sysdate
				WHERE cod_proceso = 100
				  AND cod_modgener = 'TCL';
				COMMIT;
				RAISE_APPLICATION_ERROR (TO_CHAR(v_errorint),
				    'CLUB:' || TO_CHAR(SQLCODE)|| 'ERRPD :'||v_serie||'AB:'||TO_CHAR(v_num_abonado));
			END IF;
     END IF;
   END LOOP;
   CLOSE c_abocel_alta;
--
-- Ejecuta la baja de Tarjetas llamando al p_al_tarjetas_club
   v_errorint := -20008;
   OPEN c_tarjetas_caducadas;
   LOOP
      	v_errorint := -20009;
	FETCH c_tarjetas_caducadas INTO v_num_abonado, v_cod_usuario, v_serie;
	EXIT WHEN c_tarjetas_caducadas%NOTFOUND;
--
   		v_errorint := -20010;
    	UPDATE AL_TARJETAS_CLUB
    	SET usu_baja = v_cod_usuario,
	        fec_baja = SYSDATE,
	        cod_causabaja_club=NULL,
	        cod_estado='BA'
    	WHERE num_serie=v_serie;
   END LOOP;
   CLOSE c_tarjetas_caducadas;
-- Actualiza estado de termino o espera en el scheduler de facturacion
   v_errorint := -20011;
   UPDATE fa_intqueueproc
   SET cod_estado = 1,
       fec_estado = sysdate
   WHERE cod_proceso = 100
     AND cod_modgener = 'TCL';
   COMMIT;
--
   EXCEPTION
	WHEN OTHERS THEN
		ROLLBACK;
--	 	Actualiza estado de error en el scheduler de facturacion
		UPDATE fa_intqueueproc
		SET   cod_estado = 4,
		      fec_estado = sysdate
		WHERE cod_proceso = 100
		  AND cod_modgener = 'TCL';
		COMMIT;
		RAISE_APPLICATION_ERROR (TO_CHAR(v_errorint), 'CLUB:' || TO_CHAR(SQLCODE)|| ' ERROR EN P_AL_TARJETAS_CRON');
END P_AL_TARJETAS_CRON;
/
SHOW ERRORS
