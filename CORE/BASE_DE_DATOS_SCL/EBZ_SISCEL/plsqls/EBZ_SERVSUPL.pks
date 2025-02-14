CREATE OR REPLACE PACKAGE            EBZ_SERVSUPL AS


/* tipos usados en procedure CO_SERV_SUPLEMENTARIO */
type t_celular        is table  of ga_abocel.NUM_CELULAR%type INDEX BY BINARY_INTEGER;
type t_cod_serv       is table  of ga_servsupl.COD_SERVICIO%type INDEX BY BINARY_INTEGER;
type t_descrip_serv   is table  of ga_servsupl.DES_SERVICIO%type INDEX BY BINARY_INTEGER;
type t_estado_serv    is table  of varchar2(13) INDEX BY BINARY_INTEGER;

/*tipos de uso general*/

type t_error          is table of varchar2(500)  INDEX BY BINARY_INTEGER;


/* tipos para CO_CLIENTES */

type t_cod_cliente_	  is table of ge_clientes.cod_cliente%type   INDEX BY BINARY_INTEGER;
type t_nom_cliente_	  is table of ge_clientes.nom_cliente%type   INDEX BY BINARY_INTEGER;


/* tipo para CO_HDSS */
type t_abonado_		   	  is table of ga_abocel.num_abonado%type INDEX BY BINARY_INTEGER;

/* tipos para CO_MOD_SERV_SUPLEM */

type t_des_diaesp		  is table of varchar2(1400) INDEX BY BINARY_INTEGER;
type t_dia				  is table of varchar2(1400) INDEX BY BINARY_INTEGER;

/* tipos para CO_HDSS */
type t_observ			  is table of varchar2(1400) INDEX BY BINARY_INTEGER;


procedure CO_SERV_SUPLEMENTARIO_V2(
		                        identificacion in varchar2,
								tip_identifica in varchar2,
								aplicacion     in varchar2,
								cod_cliente    out t_cod_cliente_,
								celular        out t_celular,
								cod_serv       out t_cod_serv,
								descrip_serv   out t_descrip_serv,
								estado_serv    out t_estado_serv,
								error          out t_error
								);

procedure CO_SERV_SUPLEMENTARIO_V2_RUT(
		                        identificacion in varchar2,
								--tip_identifica in varchar2,
								--aplicacion     in varchar2,
								cod_cliente    out t_cod_cliente_,
								--celular        out t_celular,
								cod_serv       out t_cod_serv,
								descrip_serv   out t_descrip_serv,
								estado_serv    out t_estado_serv,
								error          out t_error
								);


		PROCEDURE CO_HDSS
				  (
				   identificacion 	 in varchar2,
				   t_identifica		 in varchar2,
				   cod_serv			 in varchar2,
				   accion			 in varchar2,
				   des_diaesp		 in varchar2,
				   dia				 in varchar2,
				   f_family			 in varchar2,
				   cliente			 out t_cod_cliente_,
				   abonado 			 out t_abonado_,
				   observacion		 out t_observ,
				   error			 out t_error
				  );

		PROCEDURE CO_MOD_SERV_SUPLEM
				  (
				   identificacion 	 in varchar2,
				   t_identifica		 in varchar2,
				   cod_serv			 in varchar2,
				   accion 			 in varchar2,
				   des_diaesp		 in varchar2,
				   dia				 in varchar2,
				   f_family			 in varchar2,
				   n_filas			 out integer,
				   error			 out t_error
				  );


End EBZ_SERVSUPL;
/
SHOW ERRORS
