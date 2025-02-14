CREATE OR REPLACE PACKAGE Gc_Contactos_Pg
AS

    TYPE tNumAbonado     IS TABLE OF ga_traspabo.num_abonado%TYPE INDEX BY BINARY_INTEGER;
	TYPE tFecModifica    IS TABLE OF ga_traspabo.fec_modifica%TYPE INDEX BY BINARY_INTEGER;
	TYPE tIndTraspaso    IS TABLE OF ga_traspabo.ind_traspaso%TYPE INDEX BY BINARY_INTEGER;
	TYPE tDesIndTraspaso IS TABLE OF ged_codigos.des_valor%TYPE INDEX BY BINARY_INTEGER;
	TYPE tCodPlantarif   IS TABLE OF ga_traspabo.cod_plantarif_orig%TYPE INDEX BY BINARY_INTEGER;
	TYPE tDesPlantarif   IS TABLE OF ta_plantarif.des_plantarif%TYPE INDEX BY BINARY_INTEGER;
    TYPE tCodVendedor    IS TABLE OF ga_traspabo.cod_vendedor%TYPE INDEX BY BINARY_INTEGER;
	TYPE tNomVendedor    IS TABLE OF ve_vendedores.nom_vendedor%TYPE INDEX BY BINARY_INTEGER;
	TYPE tNumTerminal    IS TABLE OF ga_traspabo.num_terminal%TYPE INDEX BY BINARY_INTEGER;
    TYPE tCodCuenta      IS TABLE OF ga_traspabo.cod_cuentaant%TYPE INDEX BY BINARY_INTEGER;



------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	FUNCTION  GC_CreacionDeCliente_FN (
			  sCodTipIdent IN GC_CLIENTE_TO.cod_tipident%TYPE,
			  sNumIdent    IN GC_CLIENTE_TO.num_ident%TYPE,
			  sDesIdent	   IN GC_CLIENTE_TO.des_ident%TYPE,
			  sNumFonoContacto IN GC_CLIENTE_TO.num_fono_contacto%TYPE,
			  sNomUsuarora IN GC_CLIENTE_TO.nom_usuarora%TYPE,
			  sObservacion IN GC_CLIENTE_TO.gls_observacion%TYPE,
			  sCodCuenta IN GC_CLIENTE_TO.cod_cuenta%TYPE
			  )
			  RETURN GC_CLIENTE_TO.id_cliente_gc%TYPE;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    FUNCTION GC_ProximaFechaHabil_FN(
	   	  	 FECHAINICIAL DATE,
			 HORAS INTEGER
			 )
			 RETURN DATE;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    FUNCTION  GC_CreacionDeContacto_FN (
			  pCodSentido IN GC_CONTACTO_TO.cod_sentido%TYPE,
              pNomContacto IN GC_CONTACTO_TO.nom_contacto%TYPE,
			  pCodCanal    IN GC_CONTACTO_TO.cod_canal_contacto%TYPE,
			  pNumIPPC     IN GC_CONTACTO_TO.num_ip_pc%TYPE,
              pNumFono     IN GC_CONTACTO_TO.num_fono_contacto%TYPE,
			  pEMail       IN GC_CONTACTO_TO.e_mail_contacto%TYPE,
			  pObservacion IN GC_CONTACTO_TO.gls_observaciones%TYPE,
              pContactoPadre IN GC_CONTACTO_TO.id_contacto_padre%TYPE,
			  pIdCliente     IN GC_CONTACTO_TO.id_cliente_gc%TYPE,
			  pUsuario       IN GC_CONTACTO_TO.nom_usuarora%TYPE,
              pNombrePC      IN GC_CONTACTO_TO.nom_pc%TYPE
			  )
			  RETURN GC_CONTACTO_TO.id_contacto%TYPE;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    FUNCTION  GC_CreacionDeApunte_FN (
              pCodTripleta IN GC_APUNTE_TO.cod_tripleta%TYPE,
              pIdContacto IN GC_APUNTE_TO.id_contacto%TYPE,
              pIdCliente IN GC_APUNTE_TO.id_cliente_gc%TYPE,
              pCodNivel IN GC_APUNTE_TO.cod_nivel%TYPE,
			  pUsuario  IN GC_APUNTE_TO.usu_crea_apunte%TYPE,
			  pObservacion IN GC_APUNTE_TO.gls_observaciones%TYPE
              )
			  RETURN GC_APUNTE_TO.id_apunte%TYPE;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE GC_CreacionDeTareas_PR (
              pCodTripleta IN GC_TRIPLETA_TD.cod_tripleta%TYPE,
   			  pIdApunte IN GC_TAREA_APUNTE_TO.id_apunte%TYPE,
              pIdContacto IN GC_TAREA_APUNTE_TO.id_contacto%TYPE,
              pUsuario IN GC_TAREA_APUNTE_TO.usu_crea_tarea%TYPE,
              pCodNivel IN GC_TAREA_APUNTE_TO.cod_nivel%TYPE,
              pIdCliente IN GC_TAREA_APUNTE_TO.id_cliente_gc%TYPE,
			  pObservacion IN GC_TAREA_APUNTE_TO.gls_observaciones%TYPE );
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE GC_CrearDatoAdicionalApunte_PR (
              pIdApunte IN GC_DATOS_ADIC_APUNTE_TO.id_apunte%TYPE,
			  pCodDatoAdic IN GC_DATOS_ADIC_APUNTE_TO.cod_datadic%TYPE,
			  pNomDatoAdic IN GC_DATOS_ADIC_APUNTE_TO.nom_datadic%TYPE,
              pValorDatoAdic IN GC_DATOS_ADIC_APUNTE_TO.val_datadic%TYPE
			  );
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE GC_CreacionDeContactoSCL_PR (
	          pCodCtaSCL IN GC_CLIENTE_TO.cod_cuenta%TYPE,
			  sCodTripletaNogc IN GC_APUNTE_TO.cod_tripleta%TYPE,
              pCodNivel IN GC_APUNTE_TO.cod_nivel%TYPE,
			  pUsuario IN GC_APUNTE_TO.usu_crea_apunte%TYPE,
			  pObservacion IN VARCHAR2);
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE GC_agregarCambioEnBitacora_PR (
	          pNomTabla IN GC_BITACORA_TO.nom_tabla%TYPE,
			  pNomCampo IN GC_BITACORA_TO.nom_campo%TYPE,
			  pidTabla IN GC_BITACORA_TO.id_tabla%TYPE,
              pValorAnterior IN GC_BITACORA_TO.val_anterior%TYPE,
              pValorNuevo IN GC_BITACORA_TO.val_nuevo%TYPE,
			  pUsuModif IN GC_BITACORA_TO.usu_modif%TYPE,
			  pObservacion IN GC_BITACORA_TO.gls_observaciones%TYPE);
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE  GC_ModificacionTareas_PR (
			  opcion integer,
			  codestado      IN gc_tarea_apunte_to.cod_estado_tarea%TYPE,
			  sUsuarioasign  IN gc_tarea_apunte_to.usu_asig%TYPE,
			  indactiva      IN gc_tarea_apunte_to.ind_activa%TYPE,
			  iIdTarea       IN gc_tarea_apunte_to.id_tarea%TYPE,
			  iIdApunte      IN gc_apunte_to.id_apunte%TYPE,
			  glsobservaciones IN gc_apunte_to.gls_observaciones%TYPE,
			  sUsuarioestado   IN gc_tarea_apunte_to.usu_estado_tarea%TYPE
			  );
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  PROCEDURE  GC_ModificacionApunte_PR(
			  opcion INTEGER,
			  iIdApunte         IN GC_APUNTE_TO.id_apunte%TYPE,
			  sEstado           IN GC_APUNTE_TO.cod_estado_apunte%TYPE,
			  sUsuario          IN GC_APUNTE_TO.usu_estado_apunte%TYPE,
			  sEstadoCondic     IN GC_APUNTE_TO.cod_estado_apunte%TYPE,
			  glsobservaciones  IN GC_APUNTE_TO.gls_observaciones %TYPE,
			  indacepclie       IN GC_APUNTE_TO.ind_acepclie %TYPE,
			 -- Ptre              IN GC_APUNTE_TO.ind_acepclie %TYPE,
			  idcontacto        IN GC_APUNTE_TO.id_contacto %TYPE
			  );
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  PROCEDURE GC_ActualizacionEstadoApunt_PR (
		  sCodEstadoTarea IN gc_tarea_apunte_to.cod_estado_tarea%TYPE,
  		  IdTarea 		  IN gc_tarea_apunte_to.id_tarea%TYPE,
		  sUsuarioestado  IN gc_tarea_apunte_to.usu_estado_tarea%TYPE
		  );
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  PROCEDURE  GC_InsertarMensaje_PR (
			  sIdApunte  IN GC_TAREA_APUNTE_TO.id_apunte%TYPE,
			  sCodNivel  IN GC_TAREA_APUNTE_TO.cod_nivel%TYPE,
			  sCodTarea  IN GC_TAREA_APUNTE_TO.cod_tarea%TYPE,
			  sIdTarea   IN GC_TAREA_APUNTE_TO.id_tarea%TYPE
			  );
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  PROCEDURE  GC_CreacionDeTareaAdicional_PR (
			  idtarea			   IN GC_TAREA_APUNTE_TO.id_tarea%TYPE,
			  tiptarea			   IN GC_TAREA_APUNTE_TO.tip_tarea%TYPE,
			  codoperaciontiptarea IN GC_TAREA_TD.cod_operacion_tiptarea%TYPE,
			  codmoduloorigen      IN GC_TAREA_APUNTE_TO.cod_modulo_origen%TYPE,
			  usuario			   IN GC_TAREA_APUNTE_TO.usu_asig%TYPE,
			  codestadotarea       IN GC_TAREA_APUNTE_TO.cod_estado_tarea%TYPE
			  );
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  PROCEDURE GC_ActualizacionEstadoTarea_PR (
  		  opcion integer,
		  sCodEstadoTarea IN gc_tarea_apunte_to.cod_estado_tarea%TYPE,
  		  IdTarea 		IN gc_tarea_apunte_to.id_tarea%TYPE,
		  sUsuarioasig 	IN gc_tarea_apunte_to.usu_asig%TYPE,
		  sNumMovMsg      IN gc_tarea_apunte_to.num_mov_mensaje%TYPE,
		  sObservacion    IN gc_tarea_apunte_to.gls_observaciones%TYPE,
		  sUsuarioestado  IN gc_tarea_apunte_to.usu_estado_tarea%TYPE,
		  sCodSectorAsig    IN gc_tarea_apunte_to.cod_sector_asig%TYPE
		  );
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  PROCEDURE GC_ActualizarEstadoMensaje_PR (
   			 pREG_CMOV IN ICC_MOVIMIENTO%ROWTYPE
		  );
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE GC_MigracionesAbonado_PR(neNumAbonado        IN  ga_traspabo.num_abonado%TYPE,
 	                                   dsFecModifica       OUT tFecModifica,
	                                   nsNumabonado        OUT tNumAbonado,
	                                   vsNumTerminal       OUT tNumTerminal,
                                       nsNumabonadoAnt     OUT tNumAbonado,
									   nsCodCuenta         OUT tCodCuenta,
                                       vsIndTraspaso       OUT tIndTraspaso,
                                       vsDesIndTraspaso    OUT tDesIndTraspaso,
                                       vsCodPlantarifOrig  OUT tCodPlantarif,
                                       vsDesPlanTarifOrig  OUT tDesPlantarif,
                                       vsCodPlanTarifDest  OUT tCodPlantarif,
							           vsDesPlanTarifDest  OUT tDesPlantarif,
                                       nsCodVendedor       OUT tCodVendedor,
                                       vsNomVendedor       OUT tNomVendedor
								      );
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
END Gc_Contactos_Pg;
/
SHOW ERRORS
