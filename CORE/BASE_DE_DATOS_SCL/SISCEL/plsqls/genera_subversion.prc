CREATE OR REPLACE PROCEDURE genera_subversion(
                                  EV_PROGRAMA       IN ge_programas.nom_exe%type,
                                  EN_SUBVERSION     IN pls_integer)
IS

     ultima_version  pls_integer:=0;
     ultima_sub      pls_integer:=0;
     a_cod_programa  ge_programas.cod_programa%type;
     a_version_NUM   ge_programas.NUM_VERSION%type;
     a_nom_exe       ge_programas.nom_exe%type;
     a_des_programa  ge_programas.des_programa%type;
     a_cod_modulo    ge_programas.cod_modulo%type;
     a_fec_desde     ge_programas.FEC_DESDE_DH%type;
     a_fec_hasta     ge_programas.FEC_HASTA_DH%type;
     LV_msgerror     VARCHAR2(200);
BEGIN
     IF (EN_SUBVERSION = 0) OR (EN_SUBVERSION IS NULL) OR (EN_SUBVERSION = '') THEN
        DBMS_OUTPUT.PUT_LINE('Subversion no puede tener valor cero ni nulo');
        return;
     END IF;

     -- Verificar Subversión...y Datos del registro vigente en la tabla ge_programas

     BEGIN
         SELECT num_version, num_subversion, cod_programa, num_version, nom_exe, des_programa, cod_modulo, fec_desde_DH, fec_hasta_DH
         INTO ultima_version, ultima_sub, a_cod_programa, a_version_NUM, a_nom_exe, a_des_programa, a_cod_modulo, a_fec_desde, a_fec_hasta
         FROM ge_programas
         WHERE nom_exe = EV_PROGRAMA
         AND fec_desde_dh = (SELECT MAX(fec_desde_dh)
                             FROM ge_programas
                             WHERE nom_exe = EV_PROGRAMA);

         IF ultima_sub >= EN_SUBVERSION THEN
            DBMS_OUTPUT.PUT_LINE('La subversión ingresada es menor o igual a la registrada actualmente, no se realizan cambios');
            RETURN;
         END IF;
     EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('No se encuentra configurado en el sistema el programa: ' || EV_PROGRAMA);
            RETURN;
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Se ha producido un error al consultar los datos del programa: ' || EV_PROGRAMA);
            RETURN;
     END;

     IF ultima_sub < EN_SUBVERSION then
         -- Deja fuera de vigencia actual programa
        BEGIN
         UPDATE ge_programas
         SET fec_hasta_dh = SYSDATE - .0007 -- MENOS UN MINUTO
         WHERE nom_exe = EV_PROGRAMA
         AND sysdate BETWEEN fec_desde_dh AND TRUNC(fec_hasta_dh);
        EXCEPTION
             WHEN OTHERS THEN
              DBMS_OUTPUT.PUT_LINE('Error al actualizar el registro asociado al programa: ' || EV_PROGRAMA);
              RETURN;
        END;

        BEGIN
         SELECT FEC_HASTA_DH
         INTO a_fec_hasta
         FROM GE_PROGRAMAS
         WHERE nom_exe = EV_PROGRAMA
         AND num_version = ultima_version
          AND num_subversion = ultima_sub
          AND ROWNUM = 1;
        EXCEPTION
             WHEN OTHERS THEN
              DBMS_OUTPUT.PUT_LINE('Error al obtener fec_hasta_dh de la versión ' || ultima_version || '.' || ultima_sub || ' del registro asociado al programa: ' || EV_PROGRAMA);
              RETURN;
        END;

        BEGIN
         -- Crea la nueva versión....
         INSERT INTO GE_PROGRAMAS
         (COD_PROGRAMA, NUM_VERSION, NUM_SUBVERSION, NOM_EXE, DES_PROGRAMA, COD_MODULO, FEC_DESDE_DH, FEC_HASTA_DH)
         VALUES
         (a_cod_programa, a_version_NUM, EN_SUBVERSION, a_nom_exe, a_des_programa, a_cod_modulo, a_fec_hasta + .0007, to_date('31-12-3000 23:59:59','dd-mm-yyyy hh24:mi:ss'));
        EXCEPTION
             WHEN OTHERS THEN
              DBMS_OUTPUT.PUT_LINE('Error al actualizar el registro asociado al programa: ' || EV_PROGRAMA);
              RETURN;
        END;
     END IF;
EXCEPTION
    WHEN OTHERS THEN
         DBMS_OUTPUT.PUT_LINE('Error al actualizar el registro asociado al programa: ' || EV_PROGRAMA);
         ROLLBACK;
END;
/
