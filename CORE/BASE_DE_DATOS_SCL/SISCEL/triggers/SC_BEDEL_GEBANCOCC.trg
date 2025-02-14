CREATE OR REPLACE TRIGGER SC_BEDEL_GEBANCOCC
BEFORE  DELETE
ON GE_BANCO_CTA_CTE
FOR EACH ROW
DECLARE
v_cantidad PLS_INTEGER;
v_ind_grupo PLS_INTEGER;
v_cod_grp_dominio SC_GRP_DOMINIO.COD_GRP_DOMINIO%TYPE;
v_cod_dominio_cto SC_GRP_DOMINIO.COD_DOMINIO_CTO%TYPE;
v_largo SC_DOMINIO_CTO.LEN_CONCEPTO%TYPE;
v_Concepto_Grp SC_GRP_DOMINIO_DET.COD_CTO_GRP%TYPE;
v_In_Cto_Cta BOOLEAN := FALSE;

ELIMINA EXCEPTION;
IN_CTO_CTA EXCEPTION;
-------------------------------------
-- Busca códigos de Grupo de Dominio
-------------------------------------
CURSOR BuscaDominio (dominio SC_DOMINIO_CTO.COD_DOMINIO_CTO%TYPE) IS
SELECT COD_GRP_DOMINIO
FROM SC_GRP_DOMINIO
WHERE  COD_DOMINIO_CTO = dominio;

---------------------------------------------------
-- Busca conceptos Agrupados asociados al concepto
---------------------------------------------------
CURSOR BuscaConceptoGrp(grp_dominio SC_GRP_DOMINIO.COD_GRP_DOMINIO%TYPE, dominio SC_DOMINIO_CTO.COD_DOMINIO_CTO%TYPE, concepto SC_CONCEPTO.COD_CONCEPTO%TYPE, largo SC_DOMINIO_CTO.LEN_CONCEPTO%TYPE) IS
SELECT COD_CTO_GRP
FROM SC_GRP_DOMINIO_DET
WHERE COD_GRP_DOMINIO = grp_dominio
AND COD_DOMINIO_CTO = dominio
AND COD_CONCEPTO = LPAD(concepto,largo,'0');

BEGIN

    SELECT COD_DOMINIO_CTO, NVL(LEN_CONCEPTO,6)
	INTO v_cod_dominio_cto, v_largo
    FROM SC_DOMINIO_CTO
    WHERE DES_DOMINIO_CTO = 'GE_BANCO_CTA_CTE';

    SELECT COUNT(1) INTO v_ind_grupo
    FROM SC_GRP_DOMINIO
    WHERE  COD_DOMINIO_CTO = v_cod_dominio_cto
	AND ROWNUM = 1;

	IF v_ind_grupo = 0 THEN  -- Si el concepto es simple

		    SELECT COUNT(1) INTO v_cantidad
	        FROM SC_LOTE A , SC_CAB_LOTE B, SC_EVENTO C
            WHERE  A.COD_CONCEPTO = LPAD(:OLD.COD_CTA_CTE,v_largo,'0')
            AND A.NUM_LOTE = B.NUM_LOTE
	        AND B.COD_EVENTO=C.COD_EVENTO
	        AND C.COD_DOMINIO_CTO=v_cod_dominio_cto
			AND ROWNUM = 1;

			IF v_cantidad = 0 THEN
			   --Verifica si se asoció a alguna cuenta contable
			   SELECT COUNT(1) INTO v_cantidad
			   FROM SC_CTO_CTA
			   WHERE COD_DOMINIO_CTO = v_cod_dominio_cto
			   AND COD_CONCEPTO = LPAD(:OLD.COD_CTA_CTE,v_largo,'0')
			   AND ROWNUM = 1;

			   IF v_cantidad > 0 THEN
			   	  v_In_Cto_Cta := TRUE;
			   END IF;
			END IF;


    ELSE -- si el concepto es de grupo
        --Abrir Cursor
	  FOR RegBuscaGrupo IN BuscaDominio(v_cod_dominio_cto) LOOP

	   v_cod_grp_dominio:= RegBuscaGrupo.COD_GRP_DOMINIO;

	   SELECT COUNT(1) INTO v_cantidad
	   FROM SC_GRP_DOMINIO_DET A, SC_LOTE B, SC_CAB_LOTE C, SC_EVENTO D
	   WHERE A.COD_CONCEPTO = LPAD(:OLD.COD_CTA_CTE,v_largo,'0')
	   AND   B.COD_CONCEPTO = A.COD_CTO_GRP
	   AND   A.COD_GRP_DOMINIO = v_cod_grp_dominio
	   AND   A.COD_DOMINIO_CTO = v_cod_dominio_cto
	   AND   B.NUM_LOTE = C.NUM_LOTE
	   AND   C.COD_EVENTO=D.COD_EVENTO
	   AND   D.COD_DOMINIO_CTO=v_cod_grp_dominio
	   AND   ROWNUM = 1;

      IF v_cantidad > 0 THEN
		 EXIT; --Si por lo menos existe uno, no se borra
	  ELSE
	  	 --Verifica si se asoció a alguna cuenta contable
		 FOR RegBuscaConceptoGrp IN BuscaConceptoGrp(v_cod_grp_dominio, v_cod_dominio_cto, :OLD.COD_CTA_CTE, v_largo) LOOP
		 	 v_Concepto_Grp := RegBuscaConceptoGrp.COD_CTO_GRP;
	   	 	 SELECT COUNT(1) INTO v_cantidad
	   	 	 FROM SC_CTO_CTA
	   	 	 WHERE COD_DOMINIO_CTO = v_cod_grp_dominio
	   	 	 AND COD_CONCEPTO = v_Concepto_Grp
	   	 	 AND ROWNUM = 1;

   		 	 IF v_cantidad > 0 THEN
   		 	 	v_In_Cto_Cta := TRUE;
   		   		EXIT;
   		 	 END IF;
		  END LOOP;

	  END IF;

	  END LOOP;

    END IF ;

	IF v_cantidad = 0 THEN
	  IF v_ind_grupo > 0 THEN --Si es Grupo se elimina el Detalle
	  	FOR RegBuscaGrupo IN BuscaDominio(v_cod_dominio_cto) LOOP
			v_cod_grp_dominio:= RegBuscaGrupo.COD_GRP_DOMINIO;

			FOR RegBuscaConceptoGrp IN BuscaConceptoGrp(v_cod_grp_dominio, v_cod_dominio_cto, :OLD.COD_CTA_CTE, v_largo) LOOP
				v_Concepto_Grp := RegBuscaConceptoGrp.COD_CTO_GRP;
				--Elimina Concepto Agrupado
		  	 	DELETE FROM SC_GRP_DOMINIO_DET
		  	 	WHERE COD_CTO_GRP = v_Concepto_Grp
				AND COD_GRP_DOMINIO = v_cod_grp_dominio;
			END LOOP;
		END LOOP;
	  END IF;

	  DELETE FROM SC_CONCEPTO
	  WHERE COD_DOMINIO_CTO = v_cod_dominio_cto
	  AND COD_CONCEPTO = LPAD(:OLD.COD_CTA_CTE,v_largo,'0');

    ELSE
		IF v_In_Cto_Cta = TRUE THEN
		   RAISE IN_CTO_CTA;
		ELSE
		   RAISE ELIMINA;
		END IF;
    END IF;

EXCEPTION
	   WHEN IN_CTO_CTA THEN
	   RAISE_APPLICATION_ERROR(-20004,'LA CTA CTE A ELIMINAR TIENE ASOCIADA UNA CUENTA CONTABLE POR LO QUE NO SE PUEDE ELIMINAR.');

       WHEN  ELIMINA THEN
	   RAISE_APPLICATION_ERROR(-20003,'LA CTA CTE A ELIMINAR TIENE CONCEPTOS CONTABILIZADOS POR LO QUE NO SE PUEDE ELIMINAR.');

       WHEN NO_DATA_FOUND THEN
           RAISE_APPLICATION_ERROR  (-20002,'ERROR INESPERADO EN TRIGGER : ORA-'||TO_CHAR(SQLCODE)||'.',TRUE);
END;
/
SHOW ERRORS
