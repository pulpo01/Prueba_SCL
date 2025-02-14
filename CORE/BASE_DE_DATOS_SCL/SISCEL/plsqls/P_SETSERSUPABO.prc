CREATE OR REPLACE PROCEDURE        P_SetSerSupAbo(NumAbo IN NUMBER, CodSer IN VARCHAR2) IS
    CodSerSup NUMBER;
	CodNiv NUMBER;
--	CodCon NUMBER;
    CadSer VARCHAR2(255) := NULL;
	NumCel ga_abocel.num_celular%TYPE;
	NumSer ga_abocel.num_seriehex%TYPE;
	UsuOra VARCHAR2(21);
	Num NUMBER;
	AboAmist NUMBER;
	Fec DATE;
	tiene_el_servicio EXCEPTION;
	-- servicios suplementarios activos
    CURSOR cur_sersup(NumAbonado NUMBER) IS
           SELECT cod_servsupl, cod_nivel
           FROM ga_servsuplabo
           WHERE num_abonado = NumAbonado
           AND ind_estado < 3;
  BEGIN
    SELECT count(*) INTO Num
	FROM siscel.ga_servsuplabo
    WHERE num_abonado = NumAbo
	AND cod_servicio = CodSer
	AND ind_estado < 3;
	IF Num > 0 THEN
	  RAISE tiene_el_servicio;
	END IF;
	--Si el update "falla" => hay que seguir ya que el servicio es nuevo
    -- Usuario del Package
    SELECT user INTO UsuOra FROM dual;
	-- Numero y serie del terminal
	SELECT count(*) INTO AboAmist
	FROM ga_aboamist
	WHERE num_abonado = NumAbo;
	IF AboAmist = 0 THEN
	   SELECT num_celular, num_seriehex INTO NumCel, NumSer
 	   FROM ga_abocel
	   WHERE num_abonado = NumAbo;
	ELSE
	   SELECT num_celular, num_seriehex INTO NumCel, NumSer
	   FROM ga_aboamist
	   WHERE num_abonado = NumAbo;
	END IF;
    -- Codigo y nivel del servicio que quiero dar
	SELECT cod_servsupl, cod_nivel INTO CodSerSup, CodNiv
	FROM ga_servsupl
	WHERE cod_servicio = CodSer
	AND cod_producto = 1;
    -- Rescato el concepto segun el servicio
--    select cod_concepto INTO CodCon
--	from ga_actuaserv
--    where cod_producto = 1
--    and cod_actabo = 'FA'
--    and cod_tipserv = 2
--    and cod_servicio = CodSer;
    FOR cur IN cur_sersup(NumAbo) LOOP
	    IF cur.cod_servsupl = CodSerSup AND cur.cod_nivel = CodNiv THEN
		   EXIT;
		 END IF;
	END LOOP;
    -- Dependiendo del nivel del servicio es la accion a tomar (Activar o Desactivar)
    -- Si el nivel es 0 es que debo quitarlo
    IF CodNiv = 0 THEN
	  UPDATE siscel.ga_servsuplabo
	  SET ind_estado = 3,
	      fec_bajabd = SYSDATE
	  WHERE num_abonado = NumAbo
	  AND cod_servsupl = CodSerSup
	  AND fec_bajabd IS NULL;
--      COMMIT;
    ELSE
	  --Insertar un nuevo servicio o el mismo pero con otro nivel
	  INSERT INTO siscel.ga_servsuplabo(
	         num_abonado,
		     cod_servicio,
			 fec_altabd,
			 cod_servsupl,
			 cod_nivel,
			 cod_producto,
			 num_terminal,
			 nom_usuarora,
			 ind_estado,
			 fec_altacen,
			 fec_bajabd,
			 fec_bajacen,
			 cod_concepto,
			 num_diasnum
			 )VALUES(
			 NumAbo,
             CodSer,
	         SYSDATE,
	         CodSerSup,
	         CodNiv,
	         1,
	         NumCel,
	         UsuOra,
	         2,
			 SYSDATE,
			 NULL,
			 NULL,
			 NULL,
			 NULL
			 );
--      COMMIT;
	END IF;
	-- Actualiza clase_servicio del abonado. Se construye a partir de ga_servsuplabo
	FOR cur IN cur_sersup(NumAbo) LOOP
	    CadSer := CadSer || to_char(cur.cod_servsupl, 'FM09') || to_char(cur.cod_nivel, 'FM0999');
	END LOOP;
	IF AboAmist = 0 THEN
	    UPDATE siscel.ga_abocel
		SET clase_servicio = CadSer, perfil_abonado = CadSer
		WHERE num_abonado = NumAbo;
	ELSE
	    UPDATE siscel.ga_aboamist
		SET clase_servicio = CadSer, perfil_abonado = CadSer
		WHERE num_abonado = NumAbo;
	END IF;
--	COMMIT;
  EXCEPTION
	WHEN tiene_el_servicio THEN NULL;
    WHEN OTHERS THEN
	  raise_application_error(-20000, 'P_SetSerSupAbo/' || SQLERRM, TRUE);
  END P_SetSerSupAbo;
/
SHOW ERRORS
