CREATE OR REPLACE PROCEDURE Swap_Int_Cont_75_76_78
IS

szhCuenta        SC_CTO_CTA.COD_CUENTA%TYPE;    
szhContra        SC_CTO_CTA.COD_CONTRAP%TYPE;    

  
--********************************************************

CURSOR CURSOR_CUENTA IS
SELECT COD_OPERADORA_SCL, COD_DOMINIO_CTO, COD_EVENTO_CTO, COD_CONCEPTO  
FROM SC_CTO_CTA 
WHERE 
COD_OPERADORA_SCL = 'TMM5' AND
COD_DOMINIO_CTO = 24       AND
SUBSTR(COD_CUENTA,14,4) IN ('1075','1076','1078') AND
COD_EVENTO_CTO IN (SELECT /*+ INDEX(B.AK_SCEVENTO_DOMINIOCTO)*/ 
                          B.COD_EVENTO FROM SC_EVENTO B WHERE 
						  B.COD_DOMINIO_CTO =24 AND B.IND_IMPUTACION <> 'D') AND
COD_CONCEPTO   IN (SELECT COD_CTO_GRP  FROM SC_GRP_DOMINIO_DET 								
                                  WHERE COD_DOMINIO_CTO = 7  AND 
							      COD_GRP_DOMINIO = 24 AND
                                        COD_CONCEPTO IN (
										SELECT /*+ INDEX(A,AK_FA_CONCEPTOS_TIPCONCE)*/
                                        SUBSTR(TO_CHAR(A.COD_CONCEPTO,'099999'),2,6)  
                                        FROM FA_CONCEPTOS A
                                        WHERE A.COD_TIPCONCE = 2 )) ;
--*********************************************************

BEGIN
     szhCuenta := 0; 
     szhContra := 0; 	
	
		 --************ CURSOR ****************************
		 
		 FOR REG_CUENTA IN CURSOR_CUENTA LOOP

		 	 SELECT COD_CUENTA , COD_CONTRAP 
			   INTO szhCuenta  , szhContra	   
               FROM SC_CTO_CTA 
              WHERE COD_OPERADORA_SCL = REG_CUENTA.COD_OPERADORA_SCL
                AND COD_DOMINIO_CTO   = REG_CUENTA.COD_DOMINIO_CTO 
                AND COD_EVENTO_CTO    = REG_CUENTA.COD_EVENTO_CTO  
                AND COD_CONCEPTO      = REG_CUENTA.COD_CONCEPTO;		 
		 

		 	UPDATE  SC_CTO_CTA 
                SET COD_CUENTA  = szhContra, 
                    COD_CONTRAP = szhCuenta
			  WHERE COD_OPERADORA_SCL = REG_CUENTA.COD_OPERADORA_SCL
                AND COD_DOMINIO_CTO   = REG_CUENTA.COD_DOMINIO_CTO 
                AND COD_EVENTO_CTO    = REG_CUENTA.COD_EVENTO_CTO  
                AND COD_CONCEPTO      = REG_CUENTA.COD_CONCEPTO;		 

		END LOOP;  /*CURSOR_CUENTA*/
     

	 COMMIT;

	 DBMS_OUTPUT.PUT_LINE( 'Proceso Termino Ok' );

	 --
END Swap_Int_Cont_75_76_78;
/
SHOW ERRORS
