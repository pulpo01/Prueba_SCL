CREATE OR REPLACE PACKAGE GA_REGISTRO_ACCESO_PG
IS

   type tip_ga_traza_usuario_to    is table of ga_traza_usuario_to%rowtype index by pls_integer;
   type tip_ga_traza_usuario_th    is table of ga_traza_usuario_th%rowtype index by pls_integer;
   type tip_ga_desc_evento_td      is table of ga_desc_evento_td%rowtype   index by pls_integer;

   type tip_traza_record 		   is record (  cod_evento 			 ga_traza_usuario_to.cod_evento%type,
   								   	  		 	nom_usuario			 ga_traza_usuario_to.nom_usuario%type,
												tip_entidad			 ga_traza_usuario_to.tip_entidad%type,
												val_entidad			 ga_traza_usuario_to.val_entidad%type,
												fec_audit_ini		 ga_traza_usuario_to.fec_audit%type,
												fec_audit_fin		 ga_traza_usuario_to.fec_audit%type);
   type tip_traza             	  is table of tip_traza_record  index by pls_integer;


--------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ga_ingreso_evento_fn (
      EM_tabla                   IN  	 tip_ga_desc_evento_td,
	  SV_sqlcode		        OUT      NOCOPY ge_errores_td.cod_msgerror%TYPE,
	  SV_sqlerrm		        OUT      NOCOPY ge_errores_td.det_msgerror%TYPE
) RETURN BOOLEAN;
--------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ga_recupera_evento_fn (
      EM_tabla                   IN OUT  NOCOPY tip_ga_desc_evento_td,
	  SV_sqlcode		        OUT      NOCOPY ge_errores_td.cod_msgerror%TYPE,
	  SV_sqlerrm		        OUT      NOCOPY ge_errores_td.det_msgerror%TYPE
) RETURN BOOLEAN;
--------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ga_modifica_evento_fn (
      EM_tabla                   IN  	 tip_ga_desc_evento_td,
	  SV_sqlcode		        OUT      NOCOPY ge_errores_td.cod_msgerror%TYPE,
	  SV_sqlerrm		        OUT      NOCOPY ge_errores_td.det_msgerror%TYPE
) RETURN BOOLEAN;
--------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ga_registra_acceso_usuario_fn (
      EM_tabla                   IN  	 tip_ga_traza_usuario_to,
	  SV_sqlcode		        OUT      NOCOPY ge_errores_td.cod_msgerror%TYPE,
	  SV_sqlerrm		        OUT      NOCOPY ge_errores_td.det_msgerror%TYPE
) RETURN BOOLEAN;
--------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ga_historico_acceso_usuario_fn (
      EM_tabla                   IN  	 tip_ga_traza_usuario_th,
	  SV_sqlcode		        OUT      NOCOPY ge_errores_td.cod_msgerror%TYPE,
	  SV_sqlerrm		        OUT      NOCOPY ge_errores_td.det_msgerror%TYPE
) RETURN BOOLEAN;
--------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ga_registra_acceso_usuario_pr (
	  EV_cod_evento				 IN             ga_traza_usuario_to.cod_evento%TYPE,
	  EV_tip_entidad			 IN             ga_traza_usuario_to.tip_entidad%TYPE,
	  EN_val_entidad			 IN             ga_traza_usuario_to.val_entidad%TYPE,
	  SV_sqlcode		        OUT      NOCOPY ge_errores_td.cod_msgerror%TYPE,
	  SV_sqlerrm		        OUT      NOCOPY ge_errores_td.det_msgerror%TYPE
);
--------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ga_recupera_registro_actual_fn (
      EM_tabla                   IN OUT  NOCOPY tip_ga_traza_usuario_to,
	  ED_FechaFin                IN             ga_traza_usuario_to.fec_audit%type,
	  SV_sqlcode		        OUT      NOCOPY ge_errores_td.cod_msgerror%type,
	  SV_sqlerrm		        OUT      NOCOPY ge_errores_td.det_msgerror%type
) RETURN BOOLEAN;

PROCEDURE ga_historico_acceso_usuario_pr (
	  EM_tabla			         IN OUT  NOCOPY tip_ga_traza_usuario_to,
	  ED_FechaFin                IN             ga_traza_usuario_to.fec_audit%type,
	  SV_sqlcode		        OUT      NOCOPY ge_errores_td.cod_msgerror%TYPE,
	  SV_sqlerrm		        OUT      NOCOPY ge_errores_td.det_msgerror%TYPE
);
END GA_REGISTRO_ACCESO_PG;
/
SHOW ERRORS