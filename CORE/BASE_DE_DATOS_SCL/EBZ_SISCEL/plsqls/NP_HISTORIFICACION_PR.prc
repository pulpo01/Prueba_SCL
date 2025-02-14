CREATE OR REPLACE PROCEDURE NP_HISTORIFICACION_PR
IS

--
-- *************************************************************
-- * procedimiento      : NP_HISTORIFICACION_PR
-- * Descripción        : Procedimiento encargado de generar el Historico de Notas de pedidos
-- * Fecha de creación  : 18-02-2004
-- * Responsable        : Freddy Zavala G
-- *************************************************************

   v_comenzar varchar2(255);
   v_dias	  number;
   v_error	  varchar2(500);
   v_runplhist varchar2(500);

	   BEGIN

	   		select valor_parametro
			into v_comenzar
			from npt_parametro
			where alias_parametro ='EJEPROHIS';

	   		select valor_parametro
			into v_dias
			from npt_parametro
			where alias_parametro ='DIAS_HISTO';

			--Para saber si el PL esta corriendo y asi no ejecutar en paralelo el trabajo.
			--v_runplhist=NO , no esta corriendo
			--v_runplhist=SI, esta ejecutando el PL
	   		select valor_parametro
			into v_runplhist
			from npt_parametro
			where alias_parametro ='RUNPLHIST';



			if v_comenzar <>'NO' and v_runplhist = 'NO' then

			 --Actualiza el dato para que no se ejecute en paralelo.
			 update npt_parametro
   			 set valor_parametro='SI'
   			 where  alias_parametro ='RUNPLHIST';
   			 commit;

             insert into npt_pedido_hist_th
             select distinct a.* from NPT_PEDIDO a, NPT_ESTADO_PEDIDO b
             where b.cod_estado_flujo in (select valor_parametro from npt_parametro where alias_parametro like'ESTPEDHIS%')
             and b.fec_cre_est_pedido < (sysdate - TO_NUMBER(v_dias))
             and a.cod_pedido = b.cod_pedido;


             insert into npt_detalle_pedido_hist_th
             select distinct a.* from NPT_DETALLE_PEDIDO a, NPT_ESTADO_PEDIDO b
             where b.cod_estado_flujo in (select valor_parametro from npt_parametro where alias_parametro like'ESTPEDHIS%')
             and b.fec_cre_est_pedido < (sysdate - v_dias)
             and a.cod_pedido = b.cod_pedido;



             insert into npt_estado_pedido_hist_th
			 select * from NPT_ESTADO_PEDIDO
			 where cod_pedido in ( select cod_pedido from NPT_ESTADO_PEDIDO
			  where cod_estado_flujo in (select valor_parametro from npt_parametro where alias_parametro like'ESTPEDHIS%')
			   and fec_cre_est_pedido < (sysdate - v_dias));

             insert into npt_serie_pedido_hist_th
             select distinct a.* from NPT_SERIE_PEDIDO a, NPT_ESTADO_PEDIDO b
             where b.cod_estado_flujo in (select valor_parametro from npt_parametro where alias_parametro like'ESTPEDHIS%')
             and b.fec_cre_est_pedido < (sysdate - v_dias)
             and a.cod_pedido = b.cod_pedido;

             insert into NP_DETALLE_CARGO_HIST_TH
             select distinct a.* from NP_DETALLE_CARGO_TO a, NPT_ESTADO_PEDIDO b
             where b.cod_estado_flujo in (select valor_parametro from npt_parametro where alias_parametro like'ESTPEDHIS%')
             and b.fec_cre_est_pedido < (sysdate - v_dias)
             and a.cod_pedido = b.cod_pedido;

 			 delete from NP_DETALLE_CARGO_TO
             where cod_pedido in ( select distinct a.cod_pedido from NP_DETALLE_CARGO_HIST_TH a, NPT_ESTADO_PEDIDO_hist_th b
             where b.cod_estado_flujo in (select valor_parametro from npt_parametro where alias_parametro like'ESTPEDHIS%')
             and b.fec_cre_est_pedido < (sysdate - TO_NUMBER(v_dias))
             and a.cod_pedido = b.cod_pedido);


             delete from npt_serie_pedido
             where cod_pedido in (select a.cod_pedido from npt_serie_pedido a, npt_estado_pedido b
             where b.cod_estado_flujo in (select valor_parametro from npt_parametro where alias_parametro like'ESTPEDHIS%')
             and b.fec_cre_est_pedido < (sysdate -v_dias)
             and a.cod_pedido = b.cod_pedido);



 			 delete from npt_pedido
             where cod_pedido in (select a.cod_pedido from
             npt_pedido a, NPT_ESTADO_PEDIDO b
             where b.cod_estado_flujo in (select valor_parametro from npt_parametro where alias_parametro like'ESTPEDHIS%')
             and b.fec_cre_est_pedido < (sysdate -v_dias)
             and a.cod_pedido = b.cod_pedido);

             delete from npt_detalle_pedido
             where cod_pedido in (select a.cod_pedido from npt_detalle_pedido a, npt_estado_pedido b
             where b.cod_estado_flujo in (select valor_parametro from npt_parametro where alias_parametro like'ESTPEDHIS%')
             and b.fec_cre_est_pedido < (sysdate -v_dias)
             and a.cod_pedido = b.cod_pedido);


			 delete from NPT_ESTADO_PEDIDO
             where cod_pedido in ( select distinct a.cod_pedido from NPT_PEDIDO_hist_th a, NPT_ESTADO_PEDIDO_hist_th b
             where b.cod_estado_flujo in (select valor_parametro from npt_parametro where alias_parametro like'ESTPEDHIS%')
             and b.fec_cre_est_pedido < (sysdate - TO_NUMBER(v_dias))
             and a.cod_pedido = b.cod_pedido);


			 update npt_parametro
			 set valor_parametro='NO'
			 where  alias_parametro ='EJEPROHIS';


			 COMMIT;

			 INSERT INTO NPT_ERRORES_PROC_HISTORICO_TH ( FECHA, ESTADO, DESC_ERROR)
			 VALUES (SYSDATE, 'ok', '');

			 COMMIT;

			 UPDATE NPT_PARAMETRO
   			 SET VALOR_PARAMETRO='NO'
   			 WHERE  ALIAS_PARAMETRO ='RUNPLHIST';
   			 COMMIT;




 end if;

EXCEPTION
	            WHEN NO_DATA_FOUND THEN
				BEGIN
  					 v_error:=SQLERRM;
	   				 ROLLBACK;

					 update npt_parametro
   				     set valor_parametro='NO'
   			         where  alias_parametro ='EJEPROHIS';
   					 commit;

					 update npt_parametro
		   			 set valor_parametro='NO'
		   			 where  alias_parametro ='RUNPLHIST';
		   			 commit;

				 	 INSERT INTO NPT_ERRORES_PROC_HISTORICO_TH ( FECHA, ESTADO, DESC_ERROR)
				 	 VALUES (SYSDATE, 'Error', 'NO_DATA_FOUND');
				  	 commit;

		        END;

				WHEN OTHERS THEN
				BEGIN
   					 v_error:=SQLERRM;
	   				 ROLLBACK;

					 update npt_parametro
   				     set valor_parametro='NO'
   			         where  alias_parametro ='EJEPROHIS';
   					 commit;

					 update npt_parametro
		   			 set valor_parametro='NO'
		   			 where  alias_parametro ='RUNPLHIST';
		   			 commit;

   				     INSERT INTO NPT_ERRORES_PROC_HISTORICO_TH ( FECHA, ESTADO, DESC_ERROR)
   				     VALUES (SYSDATE, 'Error', v_error);
   				     commit;

				END;

end NP_HISTORIFICACION_PR;
/
SHOW ERRORS
