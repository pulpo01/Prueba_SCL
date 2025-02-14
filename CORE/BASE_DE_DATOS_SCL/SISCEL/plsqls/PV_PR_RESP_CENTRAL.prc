CREATE OR REPLACE PROCEDURE Pv_Pr_Resp_Central
                                                                                                (
                                                                                                 --p_cod_actabo in  varchar2,
                                                                                                 p_num_mov    IN  NUMBER--,
                                                                                                 --s_error      out varchar2,
                                                                                                 --NUM_ERROR    out number
                                                                                                )
                                                                                                 IS
-- PL/SQL Specification
--
-- *************************************************************
-- * procedimiento      : Pv_Pr_Resp_Central
-- * Descripcion        : Procedimiento Almacenado para Actualiza pv_movmientos para informar resultado de central al Motor Batch de Postventa
-- * Fecha de creacion  : 13-01-2003 15:00
-- * Responsable        : Area Postventa
-- *************************************************************
observ              EXCEPTION;
n_os                pv_iorserv.NUM_OS%TYPE;
v_num_ospadre       pv_iorserv.num_ospadre%type;
ord_mov             pv_movimientos.ORD_COMANDO%TYPE;
estado_termino      fa_intestadoc.COD_ESTADOC%TYPE;
cant_mov            INTEGER;
cant_mov_terminados INTEGER;
N_ERROR             INTEGER;
tmp                 INTEGER;
BEGIN

   tmp:=0;
   BEGIN
           SELECT NUM_OS, ORD_COMANDO
           INTO n_os, ord_mov
           FROM PV_MOVIMIENTOS
           WHERE NUM_MOVIMIENTO = p_num_mov;
   EXCEPTION
       WHEN  NO_DATA_FOUND THEN
               n_os:= NULL;
                   N_ERROR:= 1;
   END;

   IF n_os IS NOT NULL THEN
           SELECT MAX(ORD_COMANDO)
           INTO cant_mov
           FROM PV_MOVIMIENTOS
           WHERE NUM_OS = n_os;

           SELECT COUNT (*)
           INTO cant_mov_terminados
           FROM PV_MOVIMIENTOS
           WHERE RESP_CENTRAL IS NOT NULL
           AND NUM_OS = n_os;

           SELECT MAX(COD_ESTADOC) INTO estado_termino FROM FA_INTESTADOC WHERE COD_APLIC= 'PVA';

           UPDATE PV_MOVIMIENTOS
           SET RESP_CENTRAL =  'EJECUTADO MOV. [' || TO_CHAR(cant_mov_terminados+1) || '/' || TO_CHAR(cant_mov) || ']', FEC_EXPIRA = SYSDATE
           WHERE NUM_OS = n_os
           AND ORD_COMANDO = ord_mov;

           /*
           IF cant_mov_terminados = cant_mov -1 THEN
              -- Insertamos movmiento de termino en pv_erecorrido y actualizamos a este estado la solicitud
                   INSERT INTO PV_ERECORRIDO
                   (NUM_OS, COD_ESTADO, DESCRIPCION, TIP_ESTADO, FEC_INGESTADO, MSG_ERROR)
                   VALUES
                   (n_os, estado_termino, 'MOVTO. EN CENTRAL CONCLUIDO', 3, SYSDATE, NULL);

                   UPDATE PV_IORSERV
                   SET COD_ESTADO = estado_termino
                   WHERE NUM_OS = n_os;
         */
                   /*
                     Procedimiento para actualizar padre asociado a la ooss
                   */

                 /*
                   SELECT num_ospadre
                     INTO v_num_ospadre
                     FROM pv_iorserv
                WHERE num_os = n_os;

                   UPDATE pv_iorserv
                      SET num_osf = num_osf - 1
                    WHERE NUM_OS = v_num_ospadre;


           END IF;
           */
   END IF;
   IF N_ERROR = 1 THEN
      NULL;
      --S_ERROR:= 'MOV. NO PERTENECE A INTERFAZ OOSS';
          --NUM_ERROR:= N_ERROR;
   ELSE
      NULL;
      --NUM_ERROR:= 0;
          --S_ERROR:= 'EXITO';
   END IF;

   EXCEPTION
     WHEN OTHERS THEN
              --s_error:= TO_CHAR(sqlcode) || ':' || sqlerrm;
          --NUM_ERROR:= 10;
                  NULL;
END Pv_Pr_Resp_Central;
/
SHOW ERRORS
