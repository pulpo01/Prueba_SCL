CREATE OR REPLACE procedure PV_TRASPASOPROPIEDADINFAC_PR
(VP_PRODUCTO    IN NUMBER,
 VP_CLIENTE     IN NUMBER,
 VP_ABONADO     IN NUMBER,
 VP_CLIENTED    IN NUMBER,
 VP_CICLO       IN NUMBER,
 VP_FECSYS      IN DATE,
 VP_PROC        IN OUT VARCHAR2,
 VP_TABLA       IN OUT VARCHAR2,
 VP_ACT         IN OUT VARCHAR2,
 VP_SQLCODE     IN OUT VARCHAR2,
 VP_SQLERRM     IN OUT VARCHAR2,
 VP_ERROR       IN OUT VARCHAR2 )
IS
-- PL/SQL Specification
--
-- *************************************************************
-- * procedimiento      : PV_TRASPASOPROPIEDADINFAC_PR
-- * Descripción        : Procedimiento que refleja el traspaso de productos entre clientes
-- *                      en las tablas de interfase con tarificacion
-- * Fecha de creación  : 13-01-2003 12:42
-- * Responsable        : Area Postventa
-- *************************************************************
--            Los posibles retornos del procedimiento son :
--                - '0' Actualizaciones realizadas correctamente
--                - '4' Error en el proceso
--

   V_CLIENTE            GA_INFACCEL.COD_CLIENTE%TYPE;
   V_ABONADO            GA_INFACCEL.NUM_ABONADO%TYPE;
   V_FECALTA            GA_INFACCEL.FEC_ALTA%TYPE;
   V_FECBAJA            GA_INFACCEL.FEC_BAJA%TYPE;
   V_CICLFACT           GA_INFACCEL.COD_CICLFACT%TYPE;
   V_CELULAR            GA_INFACCEL.NUM_CELULAR%TYPE;
   V_ACTUAC             GA_INFACCEL.IND_ACTUAC%TYPE;
   V_FINCONTRA          GA_INFACCEL.FEC_FINCONTRA%TYPE;
   V_INDALTA            GA_INFACCEL.IND_ALTA%TYPE;
   V_DETALLE            GA_INFACCEL.IND_DETALLE%TYPE;
   V_FACTUR             GA_INFACCEL.IND_FACTUR%TYPE;
   V_CUOTAS             GA_INFACCEL.IND_CUOTAS%TYPE;
   V_ARRIENDO       GA_INFACCEL.IND_ARRIENDO%TYPE;
   V_CARGOS             GA_INFACCEL.IND_CARGOS%TYPE;
   V_PENALIZA           GA_INFACCEL.IND_PENALIZA%TYPE;
   V_SUPERTEL           GA_INFACCEL.IND_SUPERTEL%TYPE;
   V_TELEFIJA           GA_INFACCEL.NUM_TELEFIJA%TYPE;
   V_CCONTROL           GA_INFACCEL.IND_CUENCONTROLADA%TYPE;
   V_CARGOPRO           GA_INFACCEL.IND_CARGOPRO%TYPE;
   V_OPREDFIJA          GA_INFACCEL.COD_SUPERTEL%TYPE;
   V_FECHA                      GA_INFACCEL.FEC_BAJA%TYPE;
   V_FACTUR_NVO     GA_INFACCEL.IND_FACTUR%TYPE;
   V_IND_ACTUAC     GA_INFACCEL.IND_ACTUAC%TYPE;
    VP_CICLOD       GA_ABOCEL.COD_CICLO%TYPE;

   V_USO                        GA_ABOCEL.COD_USO%TYPE;

   V_RADIO                      GA_INFACTRUNK.NUM_RADIO%TYPE;
   V_MAN                        GA_INFACTREK.NUM_MAN%TYPE;
   V_BEEPER             GA_INFACBEEP.NUM_BEEPER%TYPE;

   V_ROWID     CHAR(18);
   V_TABORIGEN VARCHAR2(10);
   IND_VALOR   NUMBER;
   vCantAbonados NUMBER; /* Modificacion by SAQL/Soporte 18/07/2006 */

   RET_MENSAJE VARCHAR2(255);   --41935-COL|29/06/2007|PCR
   RET_CODIGO NUMBER;           --41935-COL|29/06/2007|PCR

BEGIN
   VP_PROC := 'PV_TRASPASOPROPIEDADINFAC_PR';
   VP_TABLA := 'FA_CICLFACT';
   VP_ACT := 'S';
   V_TABORIGEN:='ABOCEL';
   VP_ERROR := '0';
   -- dbms_output.PUT_LINE('VP_CICLO=' || VP_CICLO);
   -- dbms_output.PUT_LINE('VP_FECSYS=' || VP_FECSYS);

   SELECT COD_CICLFACT INTO V_CICLFACT
   FROM FA_CICLFACT
   WHERE COD_CICLO = VP_CICLO
         AND VP_FECSYS BETWEEN FEC_DESDELLAM
         AND FEC_HASTALLAM;

   IF VP_PRODUCTO = 1 THEN
      IND_VALOR := 6;
      VP_TABLA := 'GA_INFACCEL';
      VP_ACT := 'S';

          -- dbms_output.PUT_LINE('VP_CLIENTE=' || VP_CLIENTE);
      -- dbms_output.PUT_LINE('VP_ABONADO=' || VP_ABONADO);
      -- dbms_output.PUT_LINE('V_CICLFACT=' || V_CICLFACT);
      -- dbms_output.PUT_LINE('IND_VALOR =' || IND_VALOR);

          SELECT ROWID,COD_CLIENTE,NUM_ABONADO,
             FEC_ALTA,FEC_BAJA,NUM_CELULAR,
             IND_ACTUAC,FEC_FINCONTRA,IND_ALTA,
             IND_DETALLE,IND_FACTUR,IND_CUOTAS,
             IND_ARRIENDO,IND_CARGOS,IND_PENALIZA,
             IND_SUPERTEL,NUM_TELEFIJA, IND_CUENCONTROLADA,
                          IND_CARGOPRO,COD_SUPERTEL,IND_ACTUAC
      INTO V_ROWID,V_CLIENTE,V_ABONADO,
           V_FECALTA,V_FECBAJA,V_CELULAR,
           V_ACTUAC,V_FINCONTRA,V_INDALTA,
           V_DETALLE,V_FACTUR,V_CUOTAS,
           V_ARRIENDO,V_CARGOS,V_PENALIZA,
           V_SUPERTEL,V_TELEFIJA, V_CCONTROL,
                   V_CARGOPRO,V_OPREDFIJA,V_IND_ACTUAC
      FROM GA_INFACCEL
      WHERE COD_CLIENTE       = VP_CLIENTE
            AND NUM_ABONADO   = VP_ABONADO
            AND COD_CICLFACT  = V_CICLFACT
            AND IND_ACTUAC   <> IND_VALOR
            --AND VP_FECSYS BETWEEN FEC_BAJA AND FEC_ALTA;--MOD 42055-COL|03-07-2007|EFR
            AND VP_FECSYS BETWEEN FEC_ALTA and FEC_BAJA;--MOD 42055-COL|13-07-2007|EFR

      IND_VALOR := 3;
      V_FECHA   := VP_FECSYS - (1/(24*60*60));
      VP_TABLA  := 'GA_INFACCEL';
      VP_ACT    := 'U';

      UPDATE GA_INFACCEL
      SET FEC_BAJA   = V_FECHA,
          IND_ACTUAC = IND_VALOR
      WHERE ROWID    = V_ROWID;

          IF V_TABORIGEN= 'ABOCEL' THEN
                IF V_USO=3 THEN
                  V_CCONTROL:=0;
                END IF;
                VP_TABLA := 'GA_INFACCEL';
                VP_ACT := 'I';
                        IND_VALOR := 1;

                -- Inicio modificacion by SAQL/Soporte 27/01/2006 - RA-200601160594
                -- SELECT COD_CICLO INTO VP_CICLOD
                -- FROM GA_ABOCEL
                -- WHERE NUM_ABONADO = VP_ABONADO
                -- AND COD_CLIENTE   = VP_CLIENTED;

                SELECT COD_CICLO INTO VP_CICLOD
                FROM GE_CLIENTES
                WHERE COD_CLIENTE = VP_CLIENTED;
                -- Fin modificacion by SAQL/Soporte 27/01/2006 - RA-200601160594

                SELECT COD_CICLFACT INTO V_CICLFACT
                FROM FA_CICLFACT
                WHERE COD_CICLO = VP_CICLOD
                AND VP_FECSYS BETWEEN FEC_DESDELLAM
                AND FEC_HASTALLAM;

                INSERT INTO GA_INFACCEL (COD_CLIENTE,NUM_ABONADO,COD_CICLFACT,
                                       FEC_ALTA,FEC_BAJA,NUM_CELULAR,
                                       IND_ACTUAC,FEC_FINCONTRA,IND_ALTA,
                                       IND_DETALLE,IND_FACTUR,IND_CUOTAS,
                                       IND_ARRIENDO,IND_CARGOS,IND_PENALIZA,
                                       IND_SUPERTEL,NUM_TELEFIJA, IND_CUENCONTROLADA,
                                       IND_CARGOPRO, COD_SUPERTEL)
                               VALUES (VP_CLIENTED,VP_ABONADO,V_CICLFACT,
                                       VP_FECSYS,V_FECBAJA,V_CELULAR,
                                       IND_VALOR,V_FINCONTRA,IND_VALOR,V_DETALLE,V_FACTUR,V_CUOTAS,
                                       V_ARRIENDO,V_CARGOS,V_PENALIZA,V_SUPERTEL,V_TELEFIJA,
                                       V_CCONTROL,V_CARGOPRO,V_OPREDFIJA);

                 --INI 41935-COL|29/06/2007|PCR
                 PV_TRASPASO_INDACTUAC_PG.GA_ACTUALIZA_INDACTUAC_PR(VP_ABONADO,VP_CLIENTED,V_CICLFACT,ret_mensaje, ret_codigo); --41378|ECU|15/06/2007|JJR
                 IF ret_codigo <> 0 THEN
                    VP_SQLERRM := ret_mensaje;
                    VP_ERROR := '4';
                 END IF;
                 --FIN 41935-COL|29/06/2007|PCR

          END IF;
          /* Inicio modificacion by SAQL/Soporte 17/07/2006 - CO-200607050216 */
          SELECT COUNT(1) INTO vCantAbonados
          FROM GA_INFACCEL
          WHERE COD_CLIENTE = VP_CLIENTE
          AND NUM_ABONADO <> 0
          AND VP_FECSYS BETWEEN FEC_ALTA AND FEC_BAJA;
          IF vCantAbonados = 0 THEN
             BEGIN
                UPDATE GA_INFACCEL SET
                FEC_BAJA = VP_FECSYS - (1/(24*60*60))
                WHERE COD_CLIENTE = VP_CLIENTE
                AND NUM_ABONADO = 0;
             EXCEPTION
                WHEN OTHERS THEN
                   VP_TABLA := 'GA_INFACCEL';
             END;
          END IF;
      /* Fin modificacion by SAQL/Soporte 17/07/2006 - CO-200607050216 */

    ELSIF VP_PRODUCTO = 2 THEN
          IND_VALOR := 6;
          VP_TABLA  := 'GA_INFACBEEP';
          VP_ACT    := 'S';

          SELECT ROWID,COD_CLIENTE,NUM_ABONADO,
                 FEC_ALTA,FEC_BAJA,NUM_BEEPER,
                 IND_ACTUAC,FEC_FINCONTRA,IND_ALTA,
                 IND_DETALLE,IND_FACTUR,IND_CUOTAS,
                 IND_ARRIENDO,IND_CARGOS,IND_PENALIZA, IND_CARGOPRO
          INTO V_ROWID,V_CLIENTE,V_ABONADO,
               V_FECALTA,V_FECBAJA,V_BEEPER,
               V_ACTUAC,V_FINCONTRA,V_INDALTA,
               V_DETALLE,V_FACTUR,V_CUOTAS,
               V_ARRIENDO,V_CARGOS,V_PENALIZA, V_CARGOPRO
          FROM GA_INFACBEEP
          WHERE COD_CLIENTE      = VP_CLIENTE
                AND NUM_ABONADO  = VP_ABONADO
                AND COD_CICLFACT = V_CICLFACT
                AND IND_ACTUAC   <> IND_VALOR;

          V_FECHA   := VP_FECSYS - (1/(24*60*60));
          IND_VALOR := 3;
          VP_TABLA  := 'GA_INFACBEEP';
          VP_ACT    := 'U';

                  UPDATE GA_INFACBEEP
          SET FEC_BAJA   = V_FECHA,
              IND_ACTUAC = IND_VALOR
          WHERE ROWID    = V_ROWID;


          IND_VALOR := 1;
          VP_TABLA := 'GA_INFACBEEP';
          VP_ACT := 'I';
                  IND_VALOR := 1;
          INSERT INTO GA_INFACBEEP
                 (COD_CLIENTE,NUM_ABONADO,COD_CICLFACT,
                  FEC_ALTA,FEC_BAJA,NUM_BEEPER,IND_ACTUAC,FEC_FINCONTRA,IND_ALTA,
                  IND_DETALLE,IND_FACTUR,IND_CUOTAS,IND_ARRIENDO,IND_CARGOS,IND_PENALIZA,
                  IND_CARGOPRO)
          VALUES (VP_CLIENTED,VP_ABONADO,V_CICLFACT,
                  VP_FECSYS,V_FECBAJA,V_BEEPER,IND_VALOR,V_FINCONTRA,IND_VALOR,
                  V_DETALLE,V_FACTUR_NVO,V_CUOTAS,
                  V_ARRIENDO,V_CARGOS,V_PENALIZA, V_CARGOPRO);
    END IF;
EXCEPTION
    WHEN OTHERS THEN
         VP_SQLCODE := SQLCODE;
         VP_SQLERRM := SQLERRM;
         VP_ERROR := '4';
END;
/
SHOW ERRORS
