CREATE OR REPLACE PROCEDURE IC_genera_version_PR (
	programa     IN   CHAR,
	version      IN   PLS_INTEGER,
	subversion   IN   PLS_INTEGER
)
IS
	fec_hasta        DATE := TO_DATE ('1-01-3001', 'dd-mm-yyyy') - 1 / 24 / 60 / 60;
	fec_desde        DATE := SYSDATE;
	ultima_version   PLS_INTEGER := 0;
BEGIN

	--  Toma version actual
	SELECT MAX (num_version)
	INTO ultima_version
	FROM ge_programas
	WHERE nom_exe = programa
	AND SYSDATE BETWEEN fec_desde_dh AND TRUNC (fec_hasta_dh);

	DBMS_OUTPUT.put_line (
	      'Programa : '
	   || programa
	   || ' Version : '
	   || ultima_version
	);

-- Deja fuera de vigencia actual programa
	UPDATE ge_programas
	SET fec_hasta_dh =   SYSDATE - .0007 -- menos un minuto
	WHERE nom_exe = programa
	AND SYSDATE BETWEEN fec_desde_dh AND TRUNC (fec_hasta_dh);

-- Crea nueva version de programa
	INSERT INTO ge_programas ( cod_programa, num_version, num_subversion, nom_exe, des_programa, cod_modulo, fec_desde_dh, fec_hasta_dh )
	SELECT cod_programa, version, subversion, nom_exe, des_programa, cod_modulo, fec_desde, fec_hasta
	FROM ge_programas
	WHERE nom_exe = programa
	AND num_version = ultima_version
	AND ROWNUM = 1;

-- Genera las opciones de menu para nueva version
	BEGIN
		INSERT INTO ge_seg_procprog ( formulario, cod_programa, num_version, cod_proceso, menu, observaciones, fec_desde_dh )
		SELECT UNIQUE b.formulario, b.cod_programa, version, b.cod_proceso, b.menu, b.observaciones, fec_desde
		FROM ge_seg_procprog b, ge_programas a
		WHERE a.nom_exe = programa
		AND a.num_version = ultima_version
		AND a.num_version = b.num_version
		AND a.cod_programa = b.cod_programa;

		-- Genera los perfiles por grupo para la nueva version
		INSERT INTO ge_seg_perfiles ( cod_grupo, cod_programa, num_version, cod_proceso )
		SELECT UNIQUE b.cod_grupo, b.cod_programa, version, b.cod_proceso
		FROM ge_seg_perfiles b, ge_programas a
		WHERE a.nom_exe = programa
		AND a.num_version = ultima_version
		AND a.num_version = b.num_version
		AND a.cod_programa = b.cod_programa;

		COMMIT;
	EXCEPTION
		WHEN OTHERS
			THEN
			DBMS_OUTPUT.put_line (SQLCODE);
			DBMS_OUTPUT.put_line (SQLERRM);
			ROLLBACK;
	END;

END IC_genera_version_PR;
/
SHOW ERRORS
