CREATE OR REPLACE PROCEDURE        CE_P_CIERRE_CONCILIACION
IS
 v_comparar_transacciones number(1);
 v_suma_trans			  number(8);
 v_ConRechazoconcil		  number(8);
 v_ConDetconcil			  number(8);
 v_suma_transacciones	  number(8);
 v_numproceso  			  number(10);
		cursor c1 is
        select  num_proceso, num_transaccion from ceh_conciliacion
        where cod_conciliacion = 'CP';
BEGIN
        for R in c1
        Loop
     	 	v_comparar_transacciones:=0;
			v_suma_transacciones:=0;
			BEGIN
					SELECT  num_proceso into v_numproceso FROM
					  ceh_rechazoconcil
					WHERE
					  num_proceso = r.num_proceso and
     				  ind_inconsistencia in('2','3','4','5');
			EXCEPTION
				WHEN NO_DATA_FOUND THEN
				v_comparar_transacciones:=1;
			END;
			BEGIN
				  if v_comparar_transacciones = 0 then
						 SELECT  count(*) into v_ConRechazoconcil FROM  ceh_rechazoconcil
						 WHERE  num_proceso = r.num_proceso;
						 select count(*) into v_ConDetconcil from ceh_detconcil where
						 num_proceso = r.num_proceso;
						 v_suma_trans:= v_ConRechazoconcil + v_ConDetconcil ;
							 if  v_suma_trans = r.num_transaccion then
							 	--Actualizar CEH_CONCILIACION
								BEGIN
									update CEH_CONCILIACION set cod_conciliacion='CC' where
									num_proceso = r.num_proceso;
									commit;
								EXCEPTION
	                           		WHEN OTHERS THEN
	                                rollback;
								END;
							 end if;
				 end if;
			END;
        end loop;
END CE_P_CIERRE_CONCILIACION;
/
SHOW ERRORS
