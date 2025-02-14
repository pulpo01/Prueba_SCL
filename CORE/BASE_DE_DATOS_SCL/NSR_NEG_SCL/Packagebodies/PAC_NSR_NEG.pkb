CREATE OR REPLACE PACKAGE BODY PAC_NSR_NEG IS
   /*
   <Documentacisn TipoDoc = "Package">
      <Elemento Nombre = "PAC_NSR_NEG" Lenguaje="PL/SQL" Fecha="06-11-2007" Versisn="1.2"
                Diseqador="****" Programador="FREDDY MELO ACOSTA" Ambiente="BD">
         <Retorno>NA</Retorno>
         <Descripcisn>PKG CON LAS FUNCIONES BASICAS DE APOYO AL PROCESO DE SERIALES NEGATIVOS .NET</Descripcisn>
         <Parametros>
             <Entrada>    </Entrada>
             <Salida>     </Salida>
         </Parametros>
      </Elemento>
   </Documentacisn>
   */
   PROCEDURE P_CONS_NSR_NEG(
      v_nsr               IN     VARCHAR2,
      v_es_negativo       IN OUT BOOLEAN,
      v_cod_error         IN OUT NUMBER,
      v_des_error         IN OUT VARCHAR2) IS
      v_cantidad                 NUMBER(5):=0;
   BEGIN
      v_des_error   := 'SEL PVC_NSNEGAT v_nsr: '||v_nsr;
      v_cod_error   := 20501;
      /*SELECT COUNT(1)
      INTO  v_cantidad
      FROM  PVC_NSNEGAT
      WHERE nsr_electronico = v_nsr;
      IF v_cantidad > 0 THEN
         v_es_negativo  := TRUE;
      ELSE
         v_es_negativo  := FALSE;
      END IF;
      v_des_error   := 'OK';
      v_cod_error   := 0;*/
   EXCEPTION WHEN OTHERS THEN
      v_des_error    := 'WO Falla en PAC_NSR_NEG.P_CONS_NSR_NEG, v_cod_error: '||TO_CHAR(v_cod_error)||', SQLERRM: '||SQLERRM;
   END P_CONS_NSR_NEG;

   PROCEDURE P_CONS_OP_MOVISTAR(
      v_cod_operador      OUT    NUMBER,
      v_cod_error         IN OUT NUMBER,
      v_des_error         IN OUT VARCHAR2) IS
   BEGIN
      v_des_error   := 'SEL v_cod_operador';
      v_cod_error   := 20601;
      /*SELECT COD_OPERADOR
      INTO   v_cod_operador
      FROM   PVC_PARANSNEGAT;
      v_des_error   := 'OK';
      v_cod_error   := 0;*/
   EXCEPTION  WHEN OTHERS THEN
      v_des_error := 'WO Falla en PAC_NSR_NEG.P_CONS_OP_MOVISTAR, v_cod_error: '||TO_CHAR(v_cod_error)||', SQLERRM: '||SQLERRM;
   END P_CONS_OP_MOVISTAR;


   PROCEDURE P_CONS_CAUSAS_GRALES(
      v_cod_causa_nsnegat OUT    NUMBER,
      v_cod_causa_fraude  OUT    NUMBER,
      v_cod_error         IN OUT NUMBER,
      v_des_error         IN OUT VARCHAR2) IS
   BEGIN
      v_des_error   := 'SEL v_cod_causa_nsnegat, v_cod_causa_fraude';
      v_cod_error   := 20701;
      /*SELECT COD_CAUSA_NSNEGAT, COD_CAUSA_FRAUDE
      INTO   v_cod_causa_nsnegat, v_cod_causa_fraude
      FROM   PVC_PARANSNEGAT;
      v_des_error   := 'OK';
      v_cod_error   := 0;*/
   EXCEPTION WHEN OTHERS THEN
      v_des_error   := 'WO Falla en PAC_NSR_NEG.P_CONS_CAUSAS_GRALES, v_cod_error: '||TO_CHAR(v_cod_error)||', SQLERRM: '||SQLERRM;
   END P_CONS_CAUSAS_GRALES;


   PROCEDURE P_CONS_FECSYS(
      v_fec_sys           OUT    DATE,
      v_cod_error         IN OUT NUMBER,
      v_des_error         IN OUT VARCHAR2) IS
   BEGIN
      v_des_error   := 'SEL v_fec_sys';
      v_cod_error   := 20801;
      /*SELECT SYSDATE
      INTO v_fec_sys
      FROM DUAL;
      v_des_error   := 'OK';
      v_cod_error   := 0;*/
   EXCEPTION WHEN OTHERS THEN
      v_des_error   := 'WO Falla en PAC_NSR_NEG.P_CONS_FECSYS, v_cod_error: '||TO_CHAR(v_cod_error)||', SQLERRM: '||SQLERRM;
   END P_CONS_FECSYS;
END PAC_NSR_NEG; -- PAC_NSR_NEG
/
SHOW ERROR