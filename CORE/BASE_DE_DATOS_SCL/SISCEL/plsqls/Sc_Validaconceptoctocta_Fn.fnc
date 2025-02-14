CREATE OR REPLACE FUNCTION Sc_Validaconceptoctocta_Fn ( p_nCod_Evento IN NUMBER
                                                   , p_vCodOperadora IN VARCHAR2
                                                   , p_nPeriodo IN NUMBER
						   , p_dFechaLote IN DATE
                                                   )
/******************************************************************************
CREADO   : 28/05/2003
AUTOR    : Maricel Avalos L.
Funcion que rescata los conceptos NO asociados a Ctas, de la tabla sc_cto_cta
******************************************************************************/

RETURN VARCHAR2
IS
        v_cod_concepto SC_LOTE.COD_CONCEPTO%TYPE;
        v_retorno VARCHAR2(2000); /* Soporte RyC TM-200501271226 27-01-2005 capc*/

-- *******************Cursores*************************
        CURSOR cur_Concepto IS
        SELECT DISTINCT cod_concepto
        FROM SC_LOTE A, SC_CAB_LOTE B
        WHERE A.NUM_LOTE = B.num_lote
        AND B.COD_OPERADORA_SCL = p_vCodOperadora
        AND B.COD_EVENTO = p_nCod_Evento
        AND B.PER_CONTABLE = p_nPeriodo
        AND TRUNC(B.FEC_LOTE) = p_dFechaLote
      /*  AND NOT EXISTS (SELECT cod_concepto
                                        FROM sc_cto_cta C
                                        WHERE COD_OPERADORA_SCL = p_vCodOperadora
                                        AND cod_evento_cto = p_nCod_Evento
                                        AND c.cod_concepto = a.cod_concepto); Soporte RyC CGLagos TM-200501141210 14-01-2005*/
         AND NOT EXISTS 	(SELECT cod_concepto
                         FROM SC_CTO_CTA C, SC_EVENTO D
                         WHERE COD_OPERADORA_SCL = p_vCodOperadora
                         AND C.COD_EVENTO_CTO    = D.COD_EVENTO_CTO
                         AND C.COD_CONCEPTO      = A.COD_CONCEPTO
                         AND C.COD_DOMINIO_CTO   = D.COD_DOMINIO_CTO
                         AND D.COD_EVENTO        = p_nCod_Evento)
        AND ROWNUM <= 100;

-- ****************************************************

BEGIN
         --retorna Codigos de Conceptos no asociados a Ctas
         v_retorno:= 'EL EVENTO '||p_nCod_Evento||' TIENE CONCEPTOS SIN ASOCIAR (';

         OPEN cur_Concepto;
         LOOP
                 FETCH cur_Concepto INTO v_cod_concepto;
                 EXIT WHEN cur_Concepto%NOTFOUND;

                 v_retorno:=  v_retorno || v_cod_concepto ||',';
         END LOOP;

         IF CUR_CONCEPTO%ROWCOUNT = 0 THEN
                RETURN NULL;
         ELSE
                v_retorno:= SUBSTR(v_retorno,1,LENGTH(v_retorno)-1) ||')';
         END IF;

RETURN SUBSTR(v_retorno,1,2000); /* Soporte RyC TM-200501271226 27-01-2005 capc*/

--*********************************************************
        EXCEPTION
                 WHEN OTHERS THEN
                         RETURN SQLERRM;
END Sc_Validaconceptoctocta_Fn;
/
SHOW ERRORS
