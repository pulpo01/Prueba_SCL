CREATE OR REPLACE PACKAGE BODY        pkg_icc_servsuplabo AS
--------------------------------------------------------------------------------
-- Declaracion de variables globales del package
--------------------------------------------------------------------------------
  NumAbo NUMBER(8);
  UsuOra VARCHAR2(25);
  -- NumCel NUMBER(9); -- Se modifica por Proyecto 15 Digitos
  NumCel GA_ABOCEL.NUM_CELULAR%TYPE;
  NumSer VARCHAR2(11);
  CadSerMov VARCHAR2(255);
--------------------------------------------------------------------------------
-- GetAbo : Rescato el abonado con el codigo del cliente y el numero de terminal
--------------------------------------------------------------------------------
  PROCEDURE GetAbo(CodCli IN NUMBER, NumCel IN NUMBER, NumAbo OUT NUMBER) IS
  BEGIN
	SELECT num_abonado INTO NumAbo
	FROM ga_abocel
	WHERE cod_cliente = CodCli
	AND num_celular = NumCel;
  EXCEPTION
    WHEN OTHERS THEN
	  raise_application_error(-20005, 'GetAbo/' || SQLERRM, TRUE);
  END GetAbo;
--------------------------------------------------------------------------------
-- SetSerSupAbo : Cambio de UN Servicio Suplementario
--------------------------------------------------------------------------------
  PROCEDURE SetSerSupAbo(NumAbonado IN NUMBER, CodSer IN VARCHAR2) IS
    CodSerSup NUMBER;
	CodNiv NUMBER;
    CadSer VARCHAR2(255) := NULL;
    CodSerSupTmp VARCHAR2(2);
	CodNivTmp VARCHAR2(4);
    CURSOR cur_sersup IS
           SELECT to_char(cod_servsupl, 'FM09'), to_char(cod_nivel, 'FM0999')
           FROM ga_servsuplabo
           WHERE num_abonado = NumAbo
           AND ind_estado < 3;
  BEGIN
    NumAbo := NumAbonado;
    -- Usuario del Package
    SELECT user INTO UsuOra FROM dual;
    -- Numero y serie del terminal
	SELECT num_celular, num_seriehex
    INTO NumCel, NumSer
	FROM ga_abocel
	WHERE num_abonado = NumAbo;
    -- Servicio suplementario y su nivel
	SELECT cod_servsupl, cod_nivel
	INTO CodSerSup, CodNiv
	FROM ga_servsupl
	WHERE cod_servicio = CodSer
	AND cod_producto = 1;
    -- Cadena de servicios que ira en el movimiento
    CadSerMov := CadSerMov || to_char(CodSerSup, 'FM09') || to_char(CodNiv, 'FM0999');
    -- Dependiendo del nivel del servicio es la accion a tomar (Activar o Desactivar)
    --  ESTO ES PARA DAR EL SERVICIO
    IF CodNiv = 0 THEN
      --  ESTO ES PARA QUITAR EL SERVICIO
	  UPDATE siscel.ga_servsuplabo
	  SET ind_estado = 3,
	      fec_bajabd = SYSDATE
	  WHERE num_abonado = NumAbo
	  AND cod_servsupl = CodSerSup
	  AND fec_bajabd IS NULL;
      COMMIT;
    ELSE
      -- Cerrar servicio anterior
	  UPDATE siscel.ga_servsuplabo
      SET ind_estado = 3,
	      fec_bajabd = SYSDATE
      WHERE num_abonado = NumAbo
	  AND cod_servsupl = CodSerSup
	  AND fec_bajabd IS NULL;
      COMMIT;
	  --Si el update "falla" => hay que seguir ya que el servicio es nuevo
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
			 ind_estado
			 )VALUES(
			 NumAbo,
             CodSer,
	         SYSDATE,
	         CodSerSup,
	         CodNiv,
	         1,
	         NumCel,
	         UsuOra,
	         1);
      COMMIT;
	END IF;
	-- Actualiza clase_servicio del abonado. Se construye a partir de ga_servsuplabo
    OPEN cur_sersup;
    LOOP
      FETCH cur_sersup INTO CodSerSupTmp, CodNivTmp;
	  EXIT WHEN cur_sersup%NOTFOUND;
      CadSer := CadSer || CodSerSupTmp || CodNivTmp;
    END LOOP;
    CLOSE cur_sersup;
    UPDATE siscel.ga_abocel
	SET clase_servicio = CadSer
	WHERE num_abonado = NumAbo;
	COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
	  raise_application_error(-20000, 'SetSerSupAbo/' || SQLERRM, TRUE);
  END SetSerSupAbo;
--------------------------------------------------------------------------------
-- InsOOSS : Inserta OOSS (Activacion/Desactivacion Servicios Suplementarios)
--------------------------------------------------------------------------------
  PROCEDURE InsOOSS(TipOS IN VARCHAR2) IS
  Comentario VARCHAR2(500) := NULL;
  BEGIN
    IF TipOS = '10123' THEN
	   Comentario := 'Activacion de Gestor Corporativo';
	ELSE
	   IF TipOS = '10122' THEN
	      Comentario := 'Desactivacion de Gestor Corporativo';
	   ELSE
	      Comentario := NULL;
	      -- Aqui hay que raisear un error y salir (Tipo OOSS no valida)
	   END IF;
	END IF;
    INSERT INTO siscel.ci_orserv(
	       num_os,
		   cod_os,
		   producto,
		   tip_inter,
		   cod_inter,
		   usuario,
		   fecha,
		   comentario,
		   num_cargo
		   )VALUES(
		   ci_seq_numos.nextval,
		   TipOS,
		   1,
		   1,
		   NumAbo,
		   UsuOra,
		   SYSDATE,
		   Comentario,
		   NULL);
    COMMIT;
	EXCEPTION
	  WHEN OTHERS THEN
	    raise_application_error(-20001, 'InsOOSS/' || SQLERRM, TRUE);
  END InsOOSS;
--------------------------------------------------------------------------------
-- InsMovCel : Inserta una modificacion de servicios suplementarios
--------------------------------------------------------------------------------
  PROCEDURE InsMovCel(NumMov OUT INTEGER) IS
    SeqMov NUMBER;
  BEGIN
    SELECT icc_seq_nummov.NEXTVAL INTO SeqMov FROM DUAL;
	NumMov := SeqMov;
    INSERT INTO siscel.icc_movimiento(
           NUM_MOVIMIENTO,
           NUM_ABONADO,
           COD_ESTADO,
           COD_ACTABO,
           COD_MODULO,
           NUM_INTENTOS,
           DES_RESPUESTA,
           COD_ACTUACION,
           NOM_USUARORA,
           FEC_INGRESO,
           TIP_TERMINAL,
           COD_CENTRAL,
		   IND_BLOQUEO,
           NUM_CELULAR,
           NUM_SERIE,
           COD_SERVICIOS,
           NUM_MIN
		   )VALUES(
           NumMov,
           NumAbo,
           1,
           'SS',
           'GA',
           0,
           'PENDIENTE',
           49,
           UsuOra,
           SYSDATE,
           'D',
           14,
		   0,
           NumCel,
           NumSer,
           CadSerMov,
           '730');
  COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
	  raise_application_error(-20002, 'InsMovCel/' || SQLERRM, TRUE);
  END InsMovCel;
--------------------------------------------------------------------------------
-- Inicializacion del package
--------------------------------------------------------------------------------
BEGIN
  CadSerMov := NULL;
END PKG_ICC_SERVSUPLABO;
/
SHOW ERRORS
