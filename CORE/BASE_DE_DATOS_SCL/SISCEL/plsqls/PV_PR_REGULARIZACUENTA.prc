CREATE OR REPLACE PROCEDURE        PV_PR_REGULARIZACUENTA
IS

        nNumError                NUMBER (2);   -- nzmero de error
        sMsgError                VARCHAR2(70); -- mensaje de error
        sDuplicado       VARCHAR2(2);
        dFechaEjecucion  DATE;

        -- Variables de Error, para procediemientos.

        VP_ERROR                 VARCHAR2(1);
        VP_PROC                  VARCHAR2(50);
        VP_SQLCODE               VARCHAR2(15);
        VP_SQLERRM               VARCHAR2(70);
        VP_TABLA                 VARCHAR2(50);
        VP_ACT                   VARCHAR2(1);

        sSubCuenta       ga_subcuentas.COD_SUBCUENTA%TYPE;


        ERROR_PROCESO EXCEPTION;

        CURSOR C_SUBCUENTA IS
                   SELECT cod_subcuenta
                     FROM ga_subcuentas
                WHERE cod_subcuenta NOT LIKE '%.%'
                          and ROWNUM <= 11;

BEGIN

        nNumError:=0;                                                    --Operacion Exitosa
        sMsgError:='Operacisn Exitosa';
        dFechaEjecucion:=SYSDATE;

        VP_ERROR:='0';
        VP_PROC:='PV_PR_REGULARIZACUENTA';

        --Datos Generales
    BEGIN

                 nNumError:=1;
                 sMsgError:='Error Obteniendo Datos del Cursor';
                 VP_TABLA :='C_SUBCUENTA';
                 VP_ACT   :='S';


                 OPEN C_SUBCUENTA;
                 LOOP
                          FETCH C_SUBCUENTA INTO sSubCuenta;
                          EXIT WHEN C_SUBCUENTA%NOTFOUND;

                      dbms_output.put_line ('N0 de Cuenta : ' || sSubCuenta);

                          INSERT INTO ga_subcuentas (COD_SUBCUENTA,COD_CUENTA,DES_SUBCUENTA,COD_DIRECCION,FEC_ALTA)
              SELECT COD_SUBCUENTA || '.' || '999' ,COD_CUENTA,DES_SUBCUENTA,COD_DIRECCION,FEC_ALTA
                            FROM ga_subcuentas
                   WHERE cod_subcuenta = sSubCuenta;


                          --GA_ABOCEL
                          UPDATE ga_abocel
                 SET cod_subcuenta = COD_SUBCUENTA || '.' || '999'
               WHERE cod_subcuenta = sSubCuenta;

                          --ga_aboamist
                          UPDATE ga_aboamist
                 SET cod_subcuenta = COD_SUBCUENTA || '.' || '999'
               WHERE cod_subcuenta = sSubCuenta;

                          --ga_abobeep
                          UPDATE ga_abobeep
                 SET cod_subcuenta = COD_SUBCUENTA || '.' || '999'
               WHERE cod_subcuenta = sSubCuenta;

                          --ga_aborent
                          UPDATE ga_aborent
                 SET cod_subcuenta = COD_SUBCUENTA || '.' || '999'
               WHERE cod_subcuenta = sSubCuenta;

                          --ga_abotrek
                          UPDATE ga_abotrek
                 SET cod_subcuenta = COD_SUBCUENTA || '.' || '999'
               WHERE cod_subcuenta = sSubCuenta;

                          -- ga_abotrunk
                          UPDATE ga_abotrunk
                 SET cod_subcuenta = COD_SUBCUENTA || '.' || '999'
               WHERE cod_subcuenta = sSubCuenta;

                          -- ga_habobeep
                          UPDATE ga_habobeep
                 SET cod_subcuenta = COD_SUBCUENTA || '.' || '999'
               WHERE cod_subcuenta = sSubCuenta;

                          -- ga_habocel
                          UPDATE ga_habocel
                 SET cod_subcuenta = COD_SUBCUENTA || '.' || '999'
               WHERE cod_subcuenta = sSubCuenta;

                          --ga_haborent
                          UPDATE ga_haborent
                 SET cod_subcuenta = COD_SUBCUENTA || '.' || '999'
               WHERE cod_subcuenta = sSubCuenta;

                          -- ga_habotrek
                          UPDATE ga_habotrek
                 SET cod_subcuenta = COD_SUBCUENTA || '.' || '999'
               WHERE cod_subcuenta = sSubCuenta;

                          -- GA_HMODSUBCUENTAS
                          UPDATE GA_HMODSUBCUENTAS
                 SET cod_subcuenta = COD_SUBCUENTA || '.' || '999'
               WHERE cod_subcuenta = sSubCuenta;

                          -- GA_HMODUSUARIOS
                          UPDATE GA_HMODUSUARIOS
                 SET cod_subcuenta = COD_SUBCUENTA || '.' || '999'
               WHERE cod_subcuenta = sSubCuenta;

                          -- GA_HSUBCUENTAS
                          UPDATE GA_HSUBCUENTAS
                 SET cod_subcuenta = COD_SUBCUENTA || '.' || '999'
               WHERE cod_subcuenta = sSubCuenta;

                          --GA_HUSUARIOS
                          UPDATE GA_HUSUARIOS
                 SET cod_subcuenta = COD_SUBCUENTA || '.' || '999'
               WHERE cod_subcuenta = sSubCuenta;

                          -- GA_MODSUBCUENTAS
                          UPDATE GA_MODSUBCUENTAS
                 SET cod_subcuenta = COD_SUBCUENTA || '.' || '999'
               WHERE cod_subcuenta = sSubCuenta;

                          -- GA_MODUSUARIOS
                          UPDATE GA_MODUSUARIOS
                 SET cod_subcuenta = COD_SUBCUENTA || '.' || '999'
               WHERE cod_subcuenta = sSubCuenta;


                          -- GA_USUARIOS
                          UPDATE GA_USUARIOS
                 SET cod_subcuenta = COD_SUBCUENTA || '.' || '999'
               WHERE cod_subcuenta = sSubCuenta;


                          -- Borramos el registro erroneo
                      delete from ga_subcuentas
               where cod_subcuenta = sSubCuenta;

                 END LOOP;

     EXCEPTION
                 WHEN OTHERS THEN
                          RAISE ERROR_PROCESO;
     END;

         nNumError:=0;
         sMsgError:='Operacisn Exitosa';

         COMMIT;

EXCEPTION


        WHEN ERROR_PROCESO THEN


                  nNumError :=SQLCODE;
                  sMsgError :=SQLERRM;

                  dbms_output.put_line ('Mensaje de Error : ' || to_char(nNumError) ||'-' || sMsgError);

                  ROLLBACK;


END PV_PR_REGULARIZACUENTA;
/
SHOW ERRORS
