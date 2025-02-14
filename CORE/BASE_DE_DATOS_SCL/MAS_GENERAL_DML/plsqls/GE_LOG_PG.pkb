CREATE OR REPLACE PACKAGE BODY Ge_Log_Pg AS

    PROCEDURE set_nivel_log(ev_nivel VARCHAR2) IS
	    PRAGMA autonomous_transaction;
	    ln_cnt NUMBER;
    BEGIN
	    SELECT COUNT(1) INTO ln_cnt FROM GE_LOGADMIN_TT WHERE parametro='NIVEL';
		IF ln_cnt = 0 THEN
           INSERT INTO GE_LOGADMIN_TT (parametro, valor) VALUES ('NIVEL', ev_nivel);
		ELSE
		   UPDATE GE_LOGADMIN_TT SET valor = ev_nivel WHERE parametro = 'NIVEL';
		END IF;
		COMMIT;
    END;

    PROCEDURE set_maquina_log(ev_maq VARCHAR2) IS
	    PRAGMA autonomous_transaction;
	    ln_cnt NUMBER;
    BEGIN
	    SELECT COUNT(1) INTO ln_cnt FROM GE_LOGADMIN_TT WHERE parametro='MAQUINA';
		IF ln_cnt = 0 THEN
           INSERT INTO GE_LOGADMIN_TT (parametro, valor) VALUES ('MAQUINA', ev_maq );
		ELSE
		   UPDATE GE_LOGADMIN_TT SET valor = ev_maq WHERE parametro = 'MAQUINA';
		END IF;
		COMMIT;
    END;

    PROCEDURE set_programa_log(ev_prog VARCHAR2) IS
	    PRAGMA autonomous_transaction;
	    ln_cnt NUMBER;
    BEGIN
	    SELECT COUNT(1) INTO ln_cnt FROM GE_LOGADMIN_TT WHERE parametro='PROGRAMA';
		IF ln_cnt = 0 THEN
           INSERT INTO GE_LOGADMIN_TT (parametro, valor) VALUES ('PROGRAMA', ev_prog );
		ELSE
		   UPDATE GE_LOGADMIN_TT SET valor = ev_prog WHERE parametro = 'PROGRAMA';
		END IF;
		COMMIT;
    END;

	PROCEDURE do_log (ev_nivel VARCHAR2, ev_maq VARCHAR2, ev_prog VARCHAR2, ev_msg VARCHAR2) IS
	PRAGMA autonomous_transaction;
	BEGIN
	    INSERT INTO GE_LOGTABLE_TO ( NIVEL, MAQUINA, FECHA, USUARIO, PROGRAMA, MENSAJE,ID_LOG )
		VALUES ( ev_nivel, ev_maq, SYSDATE, USER, ev_prog, ev_msg,ge_logtable_sq.NEXTVAL );
		COMMIT;
	END;
--
	PROCEDURE set_nivel_none IS
    BEGIN
	    set_nivel_log(CV_NONE);
    END;

	PROCEDURE set_nivel_fatal IS
    BEGIN
	    set_nivel_log(CV_FATAL);
    END;

	PROCEDURE set_nivel_error IS
    BEGIN
	    set_nivel_log(CV_ERROR);
    END;

	PROCEDURE set_nivel_warn IS
    BEGIN
	    set_nivel_log(CV_WARN);
    END;

	PROCEDURE set_nivel_info IS
    BEGIN
	    set_nivel_log(CV_INFO);
    END;

	PROCEDURE set_nivel_debug IS
    BEGIN
	    set_nivel_log(CV_DEBUG);
    END;

	PROCEDURE set_nivel_all IS
    BEGIN
	    set_nivel_log(CV_ALL);
    END;
--
    FUNCTION fatal_activo RETURN BOOLEAN IS
	    ln_cnt NUMBER;
    BEGIN
        SELECT COUNT(1)
		INTO ln_cnt
		FROM GE_LOGADMIN_TT
		WHERE parametro = 'NIVEL'
		AND valor IN (CV_FATAL, CV_ERROR, CV_WARN, CV_INFO, CV_DEBUG, CV_ALL);
		RETURN (ln_cnt>0);
    END;

    FUNCTION error_activo RETURN BOOLEAN IS
	    ln_cnt NUMBER;
    BEGIN
        SELECT COUNT(1)
		INTO ln_cnt
		FROM GE_LOGADMIN_TT
		WHERE parametro = 'NIVEL'
		AND valor IN (CV_ERROR, CV_WARN, CV_INFO, CV_DEBUG, CV_ALL);
		RETURN (ln_cnt>0);
    END;

    FUNCTION warn_activo RETURN BOOLEAN IS
	    ln_cnt NUMBER;
    BEGIN
        SELECT COUNT(1)
		INTO ln_cnt
		FROM GE_LOGADMIN_TT
		WHERE parametro = 'NIVEL'
		AND valor  IN (CV_WARN, CV_INFO, CV_DEBUG, CV_ALL);
		RETURN (ln_cnt>0);
    END;

    FUNCTION info_activo RETURN BOOLEAN IS
	    ln_cnt NUMBER;
    BEGIN
        SELECT COUNT(1)
		INTO ln_cnt
		FROM GE_LOGADMIN_TT
		WHERE parametro = 'NIVEL'
		AND valor  IN (CV_INFO, CV_DEBUG, CV_ALL);
		RETURN (ln_cnt>0);
    END;

    FUNCTION debug_activo RETURN BOOLEAN IS
	    ln_cnt NUMBER;
    BEGIN
        SELECT COUNT(1)
		INTO ln_cnt
		FROM GE_LOGADMIN_TT
		WHERE parametro = 'NIVEL'
		AND valor IN (CV_DEBUG, CV_ALL);
		RETURN (ln_cnt>0);
    END;
--
    FUNCTION get_maquina RETURN VARCHAR2 IS
	    lv_maq VARCHAR2(30);
    BEGIN
	    SELECT valor
		INTO lv_maq
		FROM GE_LOGADMIN_TT
		WHERE parametro='MAQUINA';

		RETURN lv_maq;
    END;

    FUNCTION get_programa RETURN VARCHAR2 IS
	    lv_prog VARCHAR2(30);
    BEGIN
	    SELECT valor
		INTO lv_prog
		FROM GE_LOGADMIN_TT
		WHERE parametro='PROGRAMA';
		RETURN lv_prog;
    END;
--
    PROCEDURE fatal(ev_msg VARCHAR2) IS
    BEGIN
	    do_log (CV_FATAL, NULL, NULL, ev_msg);
    END;

    PROCEDURE error(ev_msg VARCHAR2) IS
    BEGIN
	    do_log (CV_ERROR, NULL, NULL, ev_msg);
    END;

    PROCEDURE warn(ev_msg VARCHAR2) IS
    BEGIN
	    do_log (CV_WARN, NULL, NULL, ev_msg);
    END;

    PROCEDURE info(ev_msg VARCHAR2) IS
    BEGIN
	    do_log (CV_INFO, NULL, NULL, ev_msg);
    END;

    PROCEDURE DEBUG(ev_msg VARCHAR2) IS
    BEGIN
	    do_log (CV_DEBUG, NULL, NULL, ev_msg);
    END;
--
    PROCEDURE fatal(ev_msg VARCHAR2, ev_maq VARCHAR2, ev_prog VARCHAR2) IS
    BEGIN
	    do_log (CV_FATAL, ev_maq, ev_prog, ev_msg);
    END;

    PROCEDURE error(ev_msg VARCHAR2, ev_maq VARCHAR2, ev_prog VARCHAR2) IS
    BEGIN
	    do_log (CV_ERROR, ev_maq, ev_prog, ev_msg);
    END;

    PROCEDURE warn(ev_msg VARCHAR2, ev_maq VARCHAR2, ev_prog VARCHAR2) IS
    BEGIN
	    do_log (CV_WARN, ev_maq, ev_prog, ev_msg);
    END;

    PROCEDURE info(ev_msg VARCHAR2, ev_maq VARCHAR2, ev_prog VARCHAR2) IS
    BEGIN
	    do_log (CV_INFO, ev_maq, ev_prog, ev_msg);
    END;

    PROCEDURE DEBUG(ev_msg VARCHAR2, ev_maq VARCHAR2, ev_prog VARCHAR2) IS
    BEGIN
	    do_log (CV_DEBUG, ev_maq, ev_prog, ev_msg);
    END;
END;
/
SHOW ERRORS
