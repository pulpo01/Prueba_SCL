CREATE OR REPLACE TYPE PV_ANULA_SINIESTRO_OT AS OBJECT
(
  EJECUTA_RAISE NUMBER(1),
  COD_CLIENTE NUMBER(8),
  NUM_ABONADO NUMBER(8),
  COD_CARGOBASICO VARCHAR2(3),
  FEC_HORA DATE,
  FEC_SUSPENCION DATE,
  NUM_SINIESTRO NUMBER(8),
  NOM_USUARIO VARCHAR2(30),
  OBS_DETALLE VARCHAR2(255),
  CANT_SINIESTROS_ABO NUMBER(3),
  PAR_SIMCARD VARCHAR2(20),
  PAR_TECNOLOGIA_GSM VARCHAR2(10),
  PAR_TECNOLOGIA VARCHAR2(20),
  TIP_TERMINAL VARCHAR2(1),
  IND_SUSP NUMBER(1),
  CANT_SUSPENCIONES NUMBER(3),
  COD_MODULO VARCHAR2(2),
  COD_CAUSA VARCHAR2(2),
  COD_CARGOBASICO_CAUSA VARCHAR2(3),
  COD_SERVICIO_CAUSA VARCHAR2(3),
  COD_SERVICIOSUSP VARCHAR2(3),
  IND_SUSPENCION NUMBER(1),
  NUM_MIN VARCHAR2(3),
  COD_ACTABO VARCHAR2(2),
  MUM_MOV NUMBER(9),
  IMSI VARCHAR2(15),
  COD_ACT NUMBER(5),
  TAREA NUMBER(10),
  COD_PLANTARIF VARCHAR2(3),
  COD_CARGOBASICO_SINIE VARCHAR2(3),
  IMP_CARGOBASICO NUMBER(12,4),
  NUM_SERIE VARCHAR2(25),
  NUM_OOSS VARCHAR2(30),
  COD_OOSS VARCHAR2(30),
  IND_MANT_LISTA_NEGRA NUMBER(1),
  CONSTRUCTOR FUNCTION PV_ANULA_SINIESTRO_OT RETURN self AS result,
  MEMBER FUNCTION TO_DEBUG RETURN VARCHAR2
)  NOT FINAL
/
SHOW ERRORS
CREATE OR REPLACE TYPE BODY PV_ANULA_SINIESTRO_OT IS CONSTRUCTOR
FUNCTION PV_ANULA_SINIESTRO_OT RETURN  SELF AS RESULT
AS
   BEGIN
	ejecuta_raise         := 0;
--	abonado               := new PV_DATOS_ABO_QT();
    cod_cliente           := NULL;
	num_abonado           := NULL;
	cod_cargobasico       := NULL;
	fec_hora              := NULL;
	fec_suspencion        := NULL;
	num_siniestro         := NULL;
	nom_usuario           := NULL;
	obs_detalle           := NULL;
	cant_siniestros_abo   := 0;
	par_simcard           := NULL;
	par_tecnologia        := NULL;
	tip_terminal          := NULL;
	ind_susp              := NULL;
	par_tecnologia_gsm    := NULL;
	cant_suspenciones     := NULL;
	cod_modulo            := NULL;
	cod_cargobasico_causa := NULL;
	cod_servicio_causa    := NULL;
	cod_causa             := NULL;
	cod_servicioSusp      := NULL;
	num_min               := NULL;
	cod_actabo            := NULL;
	mum_mov               := NULL;
	imsi                  := NULL;
	cod_act               := NULL;
	tarea                 := NULL;
	cod_plantarif         := NULL;
	cod_cargobasico_Sinie := NULL;
	imp_cargobasico       := NULL;
	num_serie             := NULL;
	ind_suspencion        := NULL;
	num_ooss       		  := NULL;
    cod_ooss       		  := NULL;
	ind_mant_lista_negra  := 0;
    RETURN;
  END;

  MEMBER FUNCTION to_debug RETURN VARCHAR2 IS
    ret VARCHAR2(4000);
    BEGIN
       ret :=
	   'EV_param.cod_cliente := '         ||  TO_CHAR(cod_cliente)         || ';'  || CHR(13) ||
	   'EV_param.num_abonado := '         ||  TO_CHAR(num_abonado)         || ';'  || CHR(13)   ||
	   'EV_param.cod_cargobasico := '     ||  cod_cargobasico              || ';'  || CHR(13)    ||
	   'EV_param.fec_hora := '            ||  TO_CHAR(fec_hora, 'dd-mm-yyyy hh24-mi-ss')  || ';' || CHR(13) ||
	   'EV_param.fec_suspencion := '      ||  TO_CHAR(fec_suspencion, 'dd-mm-yyyy hh24-mi-ss')  || ';' || CHR(13) ||
	   'EV_param.num_siniestro := '       ||  TO_CHAR(num_siniestro)       || ';'  || CHR(13)    ||
	   'EV_param.nom_usuario := '         ||  nom_usuario                  || ';'  || CHR(13)    ||
	   'EV_param.obs_detalle := '         ||  obs_detalle                  || ';'  || CHR(13)    ||
	   'EV_param.cant_siniestros_abo := ' ||  TO_CHAR(cant_siniestros_abo) || ';' || CHR(13)     ||
	   'EV_param.tip_terminal := '        ||  tip_terminal                 || ';'  || CHR(13)    ||
	   'EV_param.ind_susp := '            ||  TO_CHAR(ind_susp)            || ';'  || CHR(13)    ||
	   'EV_param.par_tecnologia_gsm := '  ||  par_tecnologia_gsm           || ';'  || CHR(13)    ||
	   'EV_param.cant_suspenciones := '   ||  TO_CHAR(cant_suspenciones)   || ';'  || CHR(13)    ||
	   'EV_param.cod_modulo := '          ||  cod_modulo                   || ';'  || CHR(13)    ||
	   'EV_param.cod_cargobasico_causa :='||  cod_cargobasico_causa        || ';'  || CHR(13)    ||
	   'EV_param.cod_servicio_causa := '  ||  cod_servicio_causa           || ';'  || CHR(13)    ||
	   'EV_param.cod_causa := '           ||  cod_causa                    || ';'  || CHR(13)    ||
	   'EV_param.cod_servicioSusp := '    ||  cod_servicioSusp             || ';'  || CHR(13)    ||
	   'EV_param.ind_suspencion := '      ||  TO_CHAR(ind_suspencion)      || ';'  || CHR(13)    ||
	   'EV_param.num_min          := '    ||  TO_CHAR(num_min)             || ';'  || CHR(13)    ||
  	   'EV_param.cod_actabo       := '    ||  TO_CHAR(cod_actabo)          || ';'  || CHR(13)    ||
	   'EV_param.mum_mov          := '    ||  TO_CHAR(mum_mov)             || ';'  || CHR(13)    ||
	   'EV_param.IMSI             := '    ||  IMSI                         || ';'  || CHR(13)    ||
	   'EV_param.cod_act          := '    ||  cod_act                      || ';'  || CHR(13)    ||
	   'EV_param.tarea            := '    ||  TO_CHAR(tarea)               || ';'  || CHR(13)    ||
	   'EV_param.cod_plantarif    := '    ||  cod_plantarif                || ';'  || CHR(13)    ||
	   'EV_param.cod_cargobasico_Sinie:= '||  cod_cargobasico_Sinie        || ';'  || CHR(13)    ||
	   'EV_param.imp_cargobasico := '     ||  TO_CHAR(imp_cargobasico)     || ';'  || CHR(13)    ||
	   'EV_param.num_serie := '           ||  TO_CHAR(num_serie)           || ';'  || CHR(13)    ||
	   'EV_param.num_ooss:= 	  	 	 '||  num_ooss					   || ';'  || CHR(13)    ||
	   'EV_param.cod_ooss		 := '     ||  cod_ooss					   || ';'  || CHR(13)    ||
	   'EV_param.ind_mant_lista_negra := '||  TO_CHAR(ind_mant_lista_negra)|| ';'  || CHR(13);
      RETURN ret;
  END;
END;
/
SHOW ERRORS
