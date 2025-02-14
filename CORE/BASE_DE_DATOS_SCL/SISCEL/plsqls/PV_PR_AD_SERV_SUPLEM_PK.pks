CREATE OR REPLACE package pv_pr_ad_serv_suplem_pk is

	procedure inicial(
  					  s_num_os  in varchar2,
					  s_cs_act  in varchar2,
					  s_cs_des  in varchar2,
					  s_abonado in varchar2,
					  s_error   out varchar2
					 );
	procedure friend_family(
			  		 		s_abonado 	  in varchar2,
					 		scod_servicio in varchar2
						   );
	procedure cod_serv_sies_detalle(
			  						s_abonado 	  in varchar2,
									s_cod_nivel_d in varchar2,
									scod_servicio in varchar2,
									opcion		  in number,
									TABLA 		  in varchar2
								   );
	procedure existe_conc_fact(
			  				   scod_servicio in varchar2,
							   concepto_fa 	 out number
							  );
	procedure datos_compl_serv_act(
				  				   s_cod_servicio_a in varchar2,
								   s_cod_nivel_a 	in varchar2,
								   scod_servicio 	out varchar2
							  	  );
	procedure serv_soport_term(
			  				   s_cod_servicio_a in varchar2,
							   TipTerminal1 	in varchar2,
							   ncod_sistema 	in varchar2,
			  				   isoportable 		out integer
			  				  );
end pv_pr_ad_serv_suplem_pk;
/
SHOW ERRORS
