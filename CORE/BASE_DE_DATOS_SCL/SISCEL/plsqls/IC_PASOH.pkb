CREATE OR REPLACE PACKAGE BODY IC_PASOH AS
  -- Paso a historico de movimientos de Page --

-- Modificación : 29-11-2004
-- Modificación : Se aplica proceso motor de interfaz comercial, y se migra, como primera actuación, la actuación 'VA'
-- Modificación : a la nueva configuración, por lo que es extraida del proceso P_GA_RESPUESTA
-- Responsable  : Fabián Aedo R.


  PROCEDURE P_IC_PASOHB(V_PRODUCTO IN GE_PRODUCTOS.COD_PRODUCTO%TYPE,
                        V_OLD_BMOV IN ICB_MOVIMIENTO%ROWTYPE,
                        V_NEW_BMOV IN ICB_MOVIMIENTO%ROWTYPE) IS
    V_TABLA VARCHAR2(35):= NULL;
    V_BMOV ICB_MOVIMIENTO%ROWTYPE;
    BEGIN

      IF V_OLD_BMOV.COD_ESTADO = 9 OR V_NEW_BMOV.COD_ESTADO = 10 THEN
         V_BMOV.COD_ESTADO := 10;
         V_BMOV.DES_RESPUESTA := 'CANCELADO';
      ELSE
         V_BMOV.COD_ESTADO := V_NEW_BMOV.COD_ESTADO;
         V_BMOV.DES_RESPUESTA := V_NEW_BMOV.DES_RESPUESTA;
      END IF;

      V_BMOV.NUM_MOVIMIENTO   := V_NEW_BMOV.NUM_MOVIMIENTO;
      V_BMOV.NUM_ABONADO      := V_NEW_BMOV.NUM_ABONADO;
      V_BMOV.COD_ACTUACION    := V_NEW_BMOV.COD_ACTUACION;
      V_BMOV.COD_ACTABO       := V_NEW_BMOV.COD_ACTABO;
      V_BMOV.COD_CENTRAL      := V_NEW_BMOV.COD_CENTRAL;
      V_BMOV.COD_CENTRAL_NUE  := V_NEW_BMOV.COD_CENTRAL_NUE;
      V_BMOV.COD_MODULO       := V_NEW_BMOV.COD_MODULO;
      V_BMOV.NUM_INTENTOS     := V_NEW_BMOV.NUM_INTENTOS;
      V_BMOV.FEC_INGRESO      := V_NEW_BMOV.FEC_INGRESO;
      V_BMOV.NOM_USUARORA     := V_NEW_BMOV.NOM_USUARORA;
      V_BMOV.FEC_LECTURA      := V_NEW_BMOV.FEC_LECTURA;
      V_BMOV.FEC_EJECUCION    := V_NEW_BMOV.FEC_EJECUCION;
      V_BMOV.TS               := V_NEW_BMOV.TS;
      V_BMOV.ID               := V_NEW_BMOV.ID;
      V_BMOV.ID_NUE           := V_NEW_BMOV.ID_NUE;
      V_BMOV.CC               := V_NEW_BMOV.CC;
      V_BMOV.PRO              := V_NEW_BMOV.PRO;
      V_BMOV.VEL              := V_NEW_BMOV.VEL;
      V_BMOV.FRE              := V_NEW_BMOV.FRE;
      V_BMOV.COB              := V_NEW_BMOV.COB;
      V_BMOV.NOM              := V_NEW_BMOV.NOM;
      V_BMOV.GM1              := V_NEW_BMOV.GM1;
      V_BMOV.GM2              := V_NEW_BMOV.GM2;
      V_BMOV.GM3              := V_NEW_BMOV.GM3;
      V_BMOV.GM4              := V_NEW_BMOV.GM4;
      V_BMOV.GM5              := V_NEW_BMOV.GM5;
      V_BMOV.NUM_IDENT         := V_NEW_BMOV.NUM_IDENT;
      V_BMOV.STA              := V_NEW_BMOV.STA;
      V_BMOV.MARP             := V_NEW_BMOV.MARP;
      V_BMOV.MODP             := V_NEW_BMOV.MODP;
      V_BMOV.NSER             := V_NEW_BMOV.NSER;
      V_BMOV.TCUE             := V_NEW_BMOV.TCUE;
      V_BMOV.TIP_TERMINAL     := V_NEW_BMOV.TIP_TERMINAL;
      V_BMOV.COD_SERVICIOS    := V_NEW_BMOV.COD_SERVICIOS;
      V_BMOV.COD_SUSPREHA     := V_NEW_BMOV.COD_SUSPREHA;
      V_BMOV.NUM_MOVPOS       := V_NEW_BMOV.NUM_MOVPOS;
      V_BMOV.TGRP             := V_NEW_BMOV.TGRP;
      V_BMOV.EMP              := V_NEW_BMOV.EMP;
      V_BMOV.COD_MENSAJE      := V_NEW_BMOV.COD_MENSAJE;
      V_BMOV.PARAM1_MENS      := V_NEW_BMOV.PARAM1_MENS;
      V_BMOV.PARAM2_MENS      := V_NEW_BMOV.PARAM2_MENS;
      V_BMOV.PARAM3_MENS      := V_NEW_BMOV.PARAM3_MENS;


    -- INSERTAR EL MOVIMIENTO EN EL HISTORICO --
      V_TABLA := 'ICB_HISTMOVIMIENTO';
      INSERT INTO ICB_HISTMOVIMIENTO
                (
                 NUM_MOVIMIENTO,
                 NUM_ABONADO,
                 COD_ACTUACION,
                 COD_ACTABO,
                 COD_CENTRAL,
                 COD_CENTRAL_NUE,
                 COD_ESTADO,
                 COD_MODULO,
                 NUM_INTENTOS,
                 FEC_INGRESO,
                 NOM_USUARORA,
                 FEC_LECTURA,
                 FEC_EJECUCION,
                 DES_RESPUESTA,
                 TS,
                 ID,
                 ID_NUE,
                 CC,
                 PRO,
                 VEL,
                 FRE,
                 COB,
                 NOM,
                 GM1,
                 GM2,
                 GM3,
                 GM4,
                 GM5,
                 NUM_IDENT,
                 STA,
                 MARP,
                 MODP,
                 NSER,
                 TCUE,
                 TIP_TERMINAL,
                 COD_SERVICIOS,
                 COD_SUSPREHA,
                 NUM_MOVPOS,
                 FEC_HISTORICO,
                 TGRP,
                 EMP,
                 COD_MENSAJE,
                 PARAM1_MENS,
                 PARAM2_MENS,
                 PARAM3_MENS
                )
          VALUES
                (
                V_BMOV.NUM_MOVIMIENTO,
                 V_BMOV.NUM_ABONADO,
                 V_BMOV.COD_ACTUACION,
                 V_BMOV.COD_ACTABO,
                 V_BMOV.COD_CENTRAL,
                 V_BMOV.COD_CENTRAL_NUE,
                 V_BMOV.COD_ESTADO,
                 V_BMOV.COD_MODULO,
                 V_BMOV.NUM_INTENTOS,
                 V_BMOV.FEC_INGRESO,
                 V_BMOV.NOM_USUARORA,
                 V_BMOV.FEC_LECTURA,
                 V_BMOV.FEC_EJECUCION,
                 V_BMOV.DES_RESPUESTA,
                 V_BMOV.TS,
                 V_BMOV.ID,
                 V_BMOV.ID_NUE,
                 V_BMOV.CC,
                 V_BMOV.PRO,
                 V_BMOV.VEL,
                 V_BMOV.FRE,
                 V_BMOV.COB,
                 V_BMOV.NOM,
                 V_BMOV.GM1,
                 V_BMOV.GM2,
                 V_BMOV.GM3,
                 V_BMOV.GM4,
                 V_BMOV.GM5,
                 V_BMOV.NUM_IDENT,
                 V_BMOV.STA,
                 V_BMOV.MARP,
                 V_BMOV.MODP,
                 V_BMOV.NSER,
                 V_BMOV.TCUE,
                 V_BMOV.TIP_TERMINAL,
                 V_BMOV.COD_SERVICIOS,
                 V_BMOV.COD_SUSPREHA,
                 V_BMOV.NUM_MOVPOS,
                 SYSDATE,
                 V_BMOV.TGRP,
                 V_BMOV.EMP,
                 V_BMOV.COD_MENSAJE,
                 V_BMOV.PARAM1_MENS,
                 V_BMOV.PARAM2_MENS,
                 V_BMOV.PARAM3_MENS
                );

    -- INSERTAR COMANDOS EN EL HISTORICO --
      V_TABLA := 'ICB_HISTCOMPROC';
      INSERT INTO ICB_HISTCOMPROC (
                       NUM_MOVIMIENTO,
                       NUM_ORDEN,
                       COD_LENGUAJE,
                       COD_CENTRAL,
                       COD_SISTEMA,
                       FEC_INGRESO,
                       FEC_EJECUCION,
                       DES_COMANDO,
                       DES_RESPUESTA,
                       COD_COMANDO,
                       FEC_HISTORICO
                       )
                (SELECT
                       NUM_MOVIMIENTO,
                       NUM_ORDEN,
                       COD_LENGUAJE,
                       COD_CENTRAL,
                       COD_SISTEMA,
                       FEC_INGRESO,
                       FEC_EJECUCION,
                       DES_COMANDO,
                       DES_RESPUESTA,
                       COD_COMANDO,
                       SYSDATE
                 FROM ICB_COMPROC
                 WHERE NUM_MOVIMIENTO = V_BMOV.NUM_MOVIMIENTO);

      DELETE ICB_COMPROC WHERE NUM_MOVIMIENTO = V_NEW_BMOV.NUM_MOVIMIENTO;

      V_TABLA := 'P_GE_RESPUESTA';
      IF V_BMOV.COD_ESTADO <> 10 THEN
	     GE_PROCED.P_GE_RESPUESTA(V_PRODUCTO,V_NEW_BMOV.COD_MODULO,V_BMOV,NULL,NULL,NULL);
      END IF;

      EXCEPTION WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR (-20002,'P_IC_PASOHB: ' || V_TABLA ||'-'|| SQLERRM,TRUE);
  END;


  --
  -- Paso a historico de movimientos de Celular --
  --
  PROCEDURE P_IC_PASOHC(V_PRODUCTO IN GE_PRODUCTOS.COD_PRODUCTO%TYPE,
                        V_OLD_CMOV IN ICC_MOVIMIENTO%ROWTYPE,
                        V_NEW_CMOV IN ICC_MOVIMIENTO%ROWTYPE) IS
  V_CMOV ICC_MOVIMIENTO%ROWTYPE;
  V_TABLA VARCHAR2(35):= NULL;
  v_b_retorno BOOLEAN := FALSE;	
  V_CANTIDAD_PENAL NUMBER; /*CAMBIO HECHO POR INSAB, INC. RA-200511100096 11/11/2005*/
  LV_cod_ser_act ICG_ACTUACION.COD_SERVICIO%TYPE;
  LV_cod_tipo ICG_ACTUACION.COD_TIPO%TYPE;
    
  BEGIN
   
      IF V_OLD_CMOV.COD_ESTADO = 9 OR V_NEW_CMOV.COD_ESTADO = 10 THEN
          V_CMOV.COD_ESTADO := 10;
          V_CMOV.DES_RESPUESTA := 'CANCELADO';
      ELSE
          V_CMOV.COD_ESTADO := V_NEW_CMOV.COD_ESTADO;
          V_CMOV.DES_RESPUESTA := V_NEW_CMOV.DES_RESPUESTA;
      END IF;
      
      V_CMOV.NUM_MOVIMIENTO   := V_NEW_CMOV.NUM_MOVIMIENTO;
      V_CMOV.NUM_ABONADO      := V_NEW_CMOV.NUM_ABONADO;
      V_CMOV.COD_ACTUACION    := V_NEW_CMOV.COD_ACTUACION;
      V_CMOV.COD_ACTABO       := V_NEW_CMOV.COD_ACTABO;
      V_CMOV.COD_CENTRAL      := V_NEW_CMOV.COD_CENTRAL;
      V_CMOV.COD_CENTRAL_NUE  := V_NEW_CMOV.COD_CENTRAL_NUE;
      V_CMOV.COD_MODULO       := V_NEW_CMOV.COD_MODULO;
      V_CMOV.NUM_INTENTOS     := V_NEW_CMOV.NUM_INTENTOS;
      V_CMOV.FEC_INGRESO      := V_NEW_CMOV.FEC_INGRESO;
      V_CMOV.NOM_USUARORA     := V_NEW_CMOV.NOM_USUARORA;
      V_CMOV.FEC_LECTURA      := V_NEW_CMOV.FEC_LECTURA;
      V_CMOV.FEC_EJECUCION    := V_NEW_CMOV.FEC_EJECUCION;
      V_CMOV.NUM_CELULAR      := V_NEW_CMOV.NUM_CELULAR;
      V_CMOV.NUM_MSNB         := V_NEW_CMOV.NUM_MSNB;
      V_CMOV.NUM_SERIE        := V_NEW_CMOV.NUM_SERIE;
      V_CMOV.NUM_PERSONAL     := V_NEW_CMOV.NUM_PERSONAL;
      V_CMOV.TIP_TERMINAL     := V_NEW_CMOV.TIP_TERMINAL;
      V_CMOV.NUM_CELULAR_NUE  := V_NEW_CMOV.NUM_CELULAR_NUE;
      V_CMOV.NUM_MSNB_NUE     := V_NEW_CMOV.NUM_MSNB_NUE;
      V_CMOV.NUM_SERIE_NUE    := V_NEW_CMOV.NUM_SERIE_NUE;
      V_CMOV.NUM_PERSONAL_NUE := V_NEW_CMOV.NUM_PERSONAL_NUE;
      V_CMOV.TIP_TERMINAL_NUE := V_NEW_CMOV.TIP_TERMINAL_NUE;
      V_CMOV.COD_SERVICIOS    := V_NEW_CMOV.COD_SERVICIOS;
      V_CMOV.COD_SUSPREHA     := V_NEW_CMOV.COD_SUSPREHA;
      V_CMOV.NUM_MOVPOS       := V_NEW_CMOV.NUM_MOVPOS;
      V_CMOV.NUM_MIN          := V_NEW_CMOV.NUM_MIN;
      V_CMOV.NUM_MIN_NUE      := V_NEW_CMOV.NUM_MIN_NUE;
      V_CMOV.STA              := V_NEW_CMOV.STA;
      V_CMOV.COD_MENSAJE      := V_NEW_CMOV.COD_MENSAJE;
      V_CMOV.PARAM1_MENS      := V_NEW_CMOV.PARAM1_MENS;
      V_CMOV.PARAM2_MENS      := V_NEW_CMOV.PARAM2_MENS;
      V_CMOV.PARAM3_MENS      := V_NEW_CMOV.PARAM3_MENS;
      V_CMOV.PLAN             := V_NEW_CMOV.PLAN;
      V_CMOV.CARGA            := V_NEW_CMOV.CARGA;
      V_CMOV.VALOR_PLAN       := V_NEW_CMOV.VALOR_PLAN;
      V_CMOV.PIN              := V_NEW_CMOV.PIN;
      V_CMOV.FEC_EXPIRA       := V_NEW_CMOV.FEC_EXPIRA;

      V_CMOV.COD_PIN          := V_NEW_CMOV.COD_PIN;
      V_CMOV.DES_MENSAJE      := V_NEW_CMOV.DES_MENSAJE;
      V_CMOV.DES_ORIGEN_PIN   := V_NEW_CMOV.DES_ORIGEN_PIN;
      V_CMOV.NUM_LOTE_PIN     := V_NEW_CMOV.NUM_LOTE_PIN;
      V_CMOV.NUM_SERIE_PIN    := V_NEW_CMOV.NUM_SERIE_PIN;
      V_CMOV.COD_IDIOMA       := V_NEW_CMOV.COD_IDIOMA;
      V_CMOV.COD_ENRUTAMIENTO := V_NEW_CMOV.COD_ENRUTAMIENTO;
      V_CMOV.TIP_ENRUTAMIENTO := V_NEW_CMOV.TIP_ENRUTAMIENTO;
      V_CMOV.TIP_TECNOLOGIA   := V_NEW_CMOV.TIP_TECNOLOGIA;
      V_CMOV.IMSI             := V_NEW_CMOV.IMSI;
      V_CMOV.IMSI_NUE         := V_NEW_CMOV.IMSI_NUE;
      V_CMOV.IMEI             := V_NEW_CMOV.IMEI;
      V_CMOV.IMEI_NUE         := V_NEW_CMOV.IMEI_NUE;
      V_CMOV.ICC              := V_NEW_CMOV.ICC;
      V_CMOV.ICC_NUE          := V_NEW_CMOV.ICC_NUE;
	  V_CMOV.FEC_ACTIVACION   := V_NEW_CMOV.FEC_ACTIVACION;
	  V_CMOV.COD_ESPEC_PROV   := V_NEW_CMOV.COD_ESPEC_PROV;
	  V_CMOV.COD_PROD_CONTRATADO  := V_NEW_CMOV.COD_PROD_CONTRATADO;
      V_CMOV.IND_BAJATRANS    := V_NEW_CMOV.IND_BAJATRANS;
      
      
      -- INSERTAR EL MOVIMIENTO EN EL HISTORICO --
      V_TABLA := 'ICC_HISTMOVIMIENTO';
      
      BEGIN
      INSERT INTO ICC_HISTMOVIMIENTO
                (
                 NUM_MOVIMIENTO,
                 NUM_ABONADO,
                 COD_ACTUACION,
                 COD_ACTABO,
                 COD_CENTRAL,
                 COD_CENTRAL_NUE,
                 COD_ESTADO,
                 COD_MODULO,
                 NUM_INTENTOS,
                 FEC_INGRESO,
                 NOM_USUARORA,
                 FEC_LECTURA,
                 FEC_EJECUCION,
                 DES_RESPUESTA,
                 NUM_CELULAR,
                 NUM_MSNB,
                 NUM_SERIE,
                 NUM_PERSONAL,
                 TIP_TERMINAL,
                 NUM_CELULAR_NUE,
                 NUM_MSNB_NUE,
                 NUM_SERIE_NUE,
                 NUM_PERSONAL_NUE,
                 TIP_TERMINAL_NUE,
                 COD_SERVICIOS,
                 COD_SUSPREHA,
                 NUM_MOVPOS,
                 FEC_HISTORICO,
                 NUM_MIN,
                 NUM_MIN_NUE,
                 STA,
                 COD_MENSAJE,
                 PARAM1_MENS,
                 PARAM2_MENS,
                 PARAM3_MENS,
                 PLAN,
                 CARGA,
                 VALOR_PLAN,
                 PIN,
                 FEC_EXPIRA,
                 COD_PIN,
                 DES_MENSAJE,
                 DES_ORIGEN_PIN,
                 NUM_LOTE_PIN,
                 NUM_SERIE_PIN,
                 COD_IDIOMA,
                 COD_ENRUTAMIENTO,
                 TIP_ENRUTAMIENTO,
                 TIP_TECNOLOGIA,
                 IMSI,
                 IMSI_NUE,
                 IMEI,
                 IMEI_NUE,
                 ICC,
                 ICC_NUE,
				 FEC_ACTIVACION,
				 COD_ESPEC_PROV,
				 COD_PROD_CONTRATADO,
				 IND_BAJATRANS
                )
          VALUES
                (
                 V_CMOV.NUM_MOVIMIENTO,
                 V_CMOV.NUM_ABONADO,
                 V_CMOV.COD_ACTUACION,
                 V_CMOV.COD_ACTABO,
                 V_CMOV.COD_CENTRAL,
                 V_CMOV.COD_CENTRAL_NUE,
                 V_CMOV.COD_ESTADO,
                 V_CMOV.COD_MODULO,
                 V_CMOV.NUM_INTENTOS,
                 V_CMOV.FEC_INGRESO,
                 V_CMOV.NOM_USUARORA,
                 V_CMOV.FEC_LECTURA,
                 V_CMOV.FEC_EJECUCION,
                 V_CMOV.DES_RESPUESTA,
                 V_CMOV.NUM_CELULAR,
                 V_CMOV.NUM_MSNB,
                 V_CMOV.NUM_SERIE,
                 V_CMOV.NUM_PERSONAL,
                 V_CMOV.TIP_TERMINAL,
                 V_CMOV.NUM_CELULAR_NUE,
                 V_CMOV.NUM_MSNB_NUE,
                 V_CMOV.NUM_SERIE_NUE,
                 V_CMOV.NUM_PERSONAL_NUE,
                 V_CMOV.TIP_TERMINAL_NUE,
                 V_CMOV.COD_SERVICIOS,
                 V_CMOV.COD_SUSPREHA,
                 V_CMOV.NUM_MOVPOS,
                 SYSDATE,
                 V_CMOV.NUM_MIN,
                 V_CMOV.NUM_MIN_NUE,
                 V_CMOV.STA,
                 V_CMOV.COD_MENSAJE,
                 V_CMOV.PARAM1_MENS,
                 V_CMOV.PARAM2_MENS,
                 V_CMOV.PARAM3_MENS,
                 V_CMOV.PLAN,
                 V_CMOV.CARGA,
                 V_CMOV.VALOR_PLAN,
                 V_CMOV.PIN,
                 V_CMOV.FEC_EXPIRA,
                 V_CMOV.COD_PIN,
                 V_CMOV.DES_MENSAJE,
                 V_CMOV.DES_ORIGEN_PIN,
                 V_CMOV.NUM_LOTE_PIN,
                 V_CMOV.NUM_SERIE_PIN,
                 V_CMOV.COD_IDIOMA,
                 V_CMOV.COD_ENRUTAMIENTO,
                 V_CMOV.TIP_ENRUTAMIENTO,
                 V_CMOV.TIP_TECNOLOGIA,
                 V_CMOV.IMSI,
                 V_CMOV.IMSI_NUE,
                 V_CMOV.IMEI,
                 V_CMOV.IMEI_NUE,
                 V_CMOV.ICC,
                 V_CMOV.ICC_NUE,
				 V_CMOV.FEC_ACTIVACION,
				 V_CMOV.COD_ESPEC_PROV,
				 V_CMOV.COD_PROD_CONTRATADO,
				 V_CMOV.IND_BAJATRANS);
       
       EXCEPTION WHEN OTHERS THEN
       	      RAISE_APPLICATION_ERROR(-20002,'ICC_HISTMOVIMIENTO:'||'-'||SQLERRM,TRUE);
       END;	      
       
       
      -- INSERTAR COMANDOS EN EL HISTORICO --
      V_TABLA := 'ICC_HISTCOMPROC';
      
      BEGIN
          INSERT INTO ICC_HISTCOMPROC (
                       NUM_MOVIMIENTO,
                       NUM_ORDEN,
                       COD_LENGUAJE,
                       COD_CENTRAL,
                       COD_SISTEMA,
                       FEC_INGRESO,
                       FEC_EJECUCION,
                       DES_COMANDO,
                       DES_RESPUESTA,
                       COD_COMANDO,
                       FEC_HISTORICO
                       )
                (SELECT
                       NUM_MOVIMIENTO,
                       NUM_ORDEN,
                       COD_LENGUAJE,
                       COD_CENTRAL,
                       COD_SISTEMA,
                       FEC_INGRESO,
                       FEC_EJECUCION,
                       DES_COMANDO,
                       DES_RESPUESTA,
                       COD_COMANDO,
                       SYSDATE
                FROM ICC_COMPROC
                WHERE NUM_MOVIMIENTO = V_CMOV.NUM_MOVIMIENTO);
      EXCEPTION WHEN OTHERS THEN
  	      RAISE_APPLICATION_ERROR(-20002,'ICC_COMPROC:'||'-'||SQLERRM,TRUE);
      END;
      
      BEGIN  	      
          DELETE ICC_COMPROC WHERE NUM_MOVIMIENTO = V_NEW_CMOV.NUM_MOVIMIENTO;
      EXCEPTION WHEN OTHERS THEN
  	      RAISE_APPLICATION_ERROR(-20002,'P_IC_PASOHC: '||'ICC_COMPROC'||'-'||SQLERRM,TRUE);
      END;  	      
      
      IF V_CMOV.COD_ESTADO <> 10 THEN
          --29-11-2004 MAS-04064 REINGENIERIA DE INTERFAZ COMERICAL TECNICA
	      --Decide si sigue conesquema antiguo o nuevo
		  v_b_retorno := IC_ACTRESPUESTAS_PG.ic_nuevomodulo_fn(V_PRODUCTO,V_CMOV.COD_ACTABO,V_CMOV.COD_MODULO,V_CMOV.TIP_TECNOLOGIA);
		  IF v_b_retorno THEN
              --29-11-2004 MAS-04064 REINGENIERIA DE INTERFAZ COMERICAL TECNICA
		      V_TABLA := 'IC_ACTRESPUESTAS_PG';
		 	  IC_ACTRESPUESTAS_PG.IC_PRINCIPAL_PR(V_PRODUCTO,V_CMOV);
		  ELSE
      	      V_TABLA := 'P_GE_RESPUESTA';
		 	  GE_PROCED.P_GE_RESPUESTA(V_PRODUCTO,V_NEW_CMOV.COD_MODULO,NULL,V_CMOV, NULL,NULL);
	          
	          -- Inicio 36137 23/01/2007 
              BEGIN
                  SELECT COD_TIPO
	              INTO LV_cod_tipo
	              FROM ICG_ACTUACION
	              WHERE COD_PRODUCTO=1 AND COD_ACTUACION = V_CMOV.COD_ACTUACION;
	          END;
	          
	          IF LV_cod_tipo = 'R' THEN
                  Ic_Pr_Penalizacion(V_CMOV.NUM_ABONADO,V_CMOV.COD_MODULO,V_CMOV.COD_SUSPREHA,2,V_CMOV.COD_ACTUACION);	 
	          END IF;
              -- Fin 36137
	     
          END IF;
      END IF;
    EXCEPTION WHEN OTHERS THEN
		RAISE;
    END;



  --
  -- Paso a historico de movimientos de Trek --
  --
  PROCEDURE P_IC_PASOHM(V_PRODUCTO IN GE_PRODUCTOS.COD_PRODUCTO%TYPE ,
                        V_OLD_MMOV IN ICM_MOVIMIENTO%ROWTYPE ,
                        V_NEW_MMOV IN ICM_MOVIMIENTO%ROWTYPE )
  IS
    V_MMOV ICM_MOVIMIENTO%ROWTYPE;
    V_TABLA VARCHAR2(35):= NULL;
    BEGIN
      IF V_OLD_MMOV.COD_ESTADO = 9 OR V_NEW_MMOV.COD_ESTADO = 10 THEN
         V_MMOV.COD_ESTADO := 10;
         V_MMOV.DES_RESPUESTA := 'CANCELADO';
      ELSE
         V_MMOV.COD_ESTADO := V_NEW_MMOV.COD_ESTADO;
         V_MMOV.DES_RESPUESTA := V_NEW_MMOV.DES_RESPUESTA;
      END IF;
      V_MMOV.NUM_MOVIMIENTO   := V_NEW_MMOV.NUM_MOVIMIENTO;
      V_MMOV.NUM_ABONADO      := V_NEW_MMOV.NUM_ABONADO;
      V_MMOV.COD_ACTUACION    := V_NEW_MMOV.COD_ACTUACION;
      V_MMOV.COD_ACTABO       := V_NEW_MMOV.COD_ACTABO;
      V_MMOV.COD_CENTRAL      := V_NEW_MMOV.COD_CENTRAL;
      V_MMOV.COD_CENTRAL_NUE  := V_NEW_MMOV.COD_CENTRAL_NUE;
      V_MMOV.COD_MODULO       := V_NEW_MMOV.COD_MODULO;
      V_MMOV.NUM_INTENTOS     := V_NEW_MMOV.NUM_INTENTOS;
      V_MMOV.FEC_INGRESO      := V_NEW_MMOV.FEC_INGRESO;
      V_MMOV.NOM_USUARORA     := V_NEW_MMOV.NOM_USUARORA;
      V_MMOV.FEC_LECTURA      := V_NEW_MMOV.FEC_LECTURA;
      V_MMOV.FEC_EJECUCION    := V_NEW_MMOV.FEC_EJECUCION;
      V_MMOV.COD_SERVICIOS    := V_NEW_MMOV.COD_SERVICIOS;
      V_MMOV.COD_SUSPREHA     := V_NEW_MMOV.COD_SUSPREHA;
      V_MMOV.NUM_MOVPOS       := V_NEW_MMOV.NUM_MOVPOS;
      V_MMOV.NUM_MAN          := V_NEW_MMOV.NUM_MAN;
      V_MMOV.NUM_MAN_NUE      := V_NEW_MMOV.NUM_MAN_NUE;
      V_MMOV.NUM_SERIE        := V_NEW_MMOV.NUM_SERIE;
      V_MMOV.NUM_SERIE_NUE    := V_NEW_MMOV.NUM_SERIE_NUE;
      V_MMOV.COD_MODELO       := V_NEW_MMOV.COD_MODELO;
      V_MMOV.COD_MODELO_NUE   := V_NEW_MMOV.COD_MODELO_NUE;
      V_MMOV.DIR_X25          := V_NEW_MMOV.DIR_X25;
      V_MMOV.DIR_X25_NUE      := V_NEW_MMOV.DIR_X25_NUE;
      V_MMOV.TIP_TERMINAL     := V_NEW_MMOV.TIP_TERMINAL;
      V_MMOV.TIP_TERMINAL_NUE := V_NEW_MMOV.TIP_TERMINAL_NUE;
      V_TABLA := 'ICM_HISTMOVIMIENTO';
    -- INSERTAR EL MOVIMIENTO EN EL HISTORICO
      INSERT INTO ICM_HISTMOVIMIENTO
                (
                 NUM_MOVIMIENTO,
                 NUM_ABONADO,
                 COD_ACTUACION,
                 COD_ACTABO,
                 COD_CENTRAL,
                 COD_CENTRAL_NUE,
                 COD_ESTADO,
                 COD_MODULO,
                 NUM_INTENTOS,
                 FEC_INGRESO,
                 NOM_USUARORA,
                 FEC_LECTURA,
                 FEC_EJECUCION,
                 DES_RESPUESTA,
                 COD_SERVICIOS,
                 COD_SUSPREHA,
                 NUM_MOVPOS,
                 NUM_MAN,
                 NUM_MAN_NUE,
                 NUM_SERIE,
                 NUM_SERIE_NUE,
                 TIP_TERMINAL,
                 TIP_TERMINAL_NUE,
                 COD_MODELO,
                 COD_MODELO_NUE,
                 DIR_X25,
                 DIR_X25_NUE,
                 FEC_HISTORICO
                )
          VALUES
                (
                 V_MMOV.NUM_MOVIMIENTO,
                 V_MMOV.NUM_ABONADO,
                 V_MMOV.COD_ACTUACION,
                 V_MMOV.COD_ACTABO,
                 V_MMOV.COD_CENTRAL,
                 V_MMOV.COD_CENTRAL_NUE,
                 V_MMOV.COD_ESTADO,
                 V_MMOV.COD_MODULO,
                 V_MMOV.NUM_INTENTOS,
                 V_MMOV.FEC_INGRESO,
                 V_MMOV.NOM_USUARORA,
                 V_MMOV.FEC_LECTURA,
                 V_MMOV.FEC_EJECUCION,
                 V_MMOV.DES_RESPUESTA,
                 V_MMOV.COD_SERVICIOS,
                 V_MMOV.COD_SUSPREHA,
                 V_MMOV.NUM_MOVPOS,
                 V_MMOV.NUM_MAN,
                 V_MMOV.NUM_MAN_NUE,
                 V_MMOV.NUM_SERIE,
                 V_MMOV.NUM_SERIE_NUE,
                 V_MMOV.TIP_TERMINAL,
                 V_MMOV.TIP_TERMINAL_NUE,
                 V_MMOV.COD_MODELO,
                 V_MMOV.COD_MODELO_NUE,
                 V_MMOV.DIR_X25,
                 V_MMOV.DIR_X25_NUE,
                 SYSDATE
                );
      V_TABLA := 'ICM_COMPROC';
      INSERT INTO
       ICM_HISTCOMPROC (
                       NUM_MOVIMIENTO,
                       NUM_ORDEN,
                       COD_LENGUAJE,
                       COD_CENTRAL,
                       COD_SISTEMA,
                       FEC_INGRESO,
                       FEC_EJECUCION,
                       DES_COMANDO,
                       DES_RESPUESTA,
                       COD_COMANDO,
                       FEC_HISTORICO
                       )
                (SELECT
                       NUM_MOVIMIENTO,
                       NUM_ORDEN,
                       COD_LENGUAJE,
                       COD_CENTRAL,
                       COD_SISTEMA,
                       FEC_INGRESO,
                       FEC_EJECUCION,
                       DES_COMANDO,
                       DES_RESPUESTA,
                       COD_COMANDO,
                       SYSDATE
        FROM ICM_COMPROC
       WHERE NUM_MOVIMIENTO = V_MMOV.NUM_MOVIMIENTO);
      DELETE ICM_COMPROC WHERE NUM_MOVIMIENTO = V_NEW_MMOV.NUM_MOVIMIENTO;
      V_TABLA := 'P_GE_RESPUESTA';
      IF V_MMOV.COD_ESTADO <> 10 THEN
         GE_PROCED.P_GE_RESPUESTA(V_PRODUCTO,V_NEW_MMOV.COD_MODULO,NULL,NULL,
                               V_MMOV,NULL);
      END IF;
      EXCEPTION WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR (-20002,'P_IC_PASOHM: '||V_TABLA||
                                 '  '||SQLERRM,TRUE);
    END;
  --
  -- Paso a historico de movimientos deTrunk --
  --
  PROCEDURE P_IC_PASOHR(V_PRODUCTO IN GE_PRODUCTOS.COD_PRODUCTO%TYPE,
                        V_OLD_RMOV IN ICR_MOVIMIENTO%ROWTYPE,
                        V_NEW_RMOV IN ICR_MOVIMIENTO%ROWTYPE)
  IS
    V_RMOV ICR_MOVIMIENTO%ROWTYPE;
    V_TABLA VARCHAR2(35):= NULL;
    BEGIN
      IF V_OLD_RMOV.COD_ESTADO = 9 OR V_NEW_RMOV.COD_ESTADO = 10 THEN
         V_RMOV.COD_ESTADO := 10;
         V_RMOV.DES_RESPUESTA := 'CANCELADO';
      ELSE
         V_RMOV.COD_ESTADO := V_NEW_RMOV.COD_ESTADO;
         V_RMOV.DES_RESPUESTA := V_NEW_RMOV.DES_RESPUESTA;
      END IF;
      V_RMOV.NUM_MOVIMIENTO   := V_NEW_RMOV.NUM_MOVIMIENTO;
      V_RMOV.NUM_ABONADO      := V_NEW_RMOV.NUM_ABONADO;
      V_RMOV.COD_ACTUACION    := V_NEW_RMOV.COD_ACTUACION;
      V_RMOV.COD_ACTABO       := V_NEW_RMOV.COD_ACTABO;
      V_RMOV.COD_CENTRAL      := V_NEW_RMOV.COD_CENTRAL;
      V_RMOV.COD_CENTRAL_NUE  := V_NEW_RMOV.COD_CENTRAL_NUE;
      V_RMOV.COD_MODULO       := V_NEW_RMOV.COD_MODULO;
      V_RMOV.NUM_INTENTOS     := V_NEW_RMOV.NUM_INTENTOS;
      V_RMOV.FEC_INGRESO      := V_NEW_RMOV.FEC_INGRESO;
      V_RMOV.NOM_USUARORA     := V_NEW_RMOV.NOM_USUARORA;
      V_RMOV.FEC_LECTURA      := V_NEW_RMOV.FEC_LECTURA;
      V_RMOV.FEC_EJECUCION    := V_NEW_RMOV.FEC_EJECUCION;
      V_RMOV.COD_SERVICIOS    := V_NEW_RMOV.COD_SERVICIOS;
      V_RMOV.COD_SUSPREHA     := V_NEW_RMOV.COD_SUSPREHA;
      V_RMOV.NUM_MOVPOS       := V_NEW_RMOV.NUM_MOVPOS;
      V_RMOV.NUM_RADIO        := V_NEW_RMOV.NUM_RADIO;
      V_RMOV.NUM_RADIO_NUE    := V_NEW_RMOV.NUM_RADIO_NUE;
      V_RMOV.TIP_TERMINAL     := V_NEW_RMOV.TIP_TERMINAL;
      V_RMOV.TIP_TERMINAL_NUE := V_NEW_RMOV.TIP_TERMINAL_NUE;
      V_TABLA := 'ICR_HISTMOVIMIENTO';
    -- INSERTAR EL MOVIMIENTO EN EL HISTORICO
      INSERT INTO ICR_HISTMOVIMIENTO
                (
                 NUM_MOVIMIENTO,
                 NUM_ABONADO,
                 COD_ACTUACION,
                 COD_ACTABO,
                 COD_CENTRAL,
                 COD_CENTRAL_NUE,
                 COD_ESTADO,
                 COD_MODULO,
                 NUM_INTENTOS,
                 FEC_INGRESO,
                 NOM_USUARORA,
                 FEC_LECTURA,
                 FEC_EJECUCION,
                 DES_RESPUESTA,
                 NUM_RADIO,
                 NUM_RADIO_NUE,
                 TIP_TERMINAL,
                 TIP_TERMINAL_NUE,
                 COD_SERVICIOS,
                 COD_SUSPREHA,
                 NUM_MOVPOS,
                 FEC_HISTORICO
                )
          VALUES
                (
                 V_RMOV.NUM_MOVIMIENTO,
                 V_RMOV.NUM_ABONADO,
                 V_RMOV.COD_ACTUACION,
                 V_RMOV.COD_ACTABO,
                 V_RMOV.COD_CENTRAL,
                 V_RMOV.COD_CENTRAL_NUE,
                 V_RMOV.COD_ESTADO,
                 V_RMOV.COD_MODULO,
                 V_RMOV.NUM_INTENTOS,
                 V_RMOV.FEC_INGRESO,
                 V_RMOV.NOM_USUARORA,
                 V_RMOV.FEC_LECTURA,
                 V_RMOV.FEC_EJECUCION,
                 V_RMOV.DES_RESPUESTA,
                 V_RMOV.NUM_RADIO,
                 V_RMOV.NUM_RADIO_NUE,
                 V_RMOV.TIP_TERMINAL,
                 V_RMOV.TIP_TERMINAL_NUE,
                 V_RMOV.COD_SERVICIOS,
                 V_RMOV.COD_SUSPREHA,
                 V_RMOV.NUM_MOVPOS,
                 SYSDATE
                );
      V_TABLA := 'ICR_COMPROC';
      INSERT INTO
       ICR_HISTCOMPROC (
                       NUM_MOVIMIENTO,
                       NUM_ORDEN,
                       COD_LENGUAJE,
                       COD_CENTRAL,
                       COD_SISTEMA,
                       FEC_INGRESO,
                       FEC_EJECUCION,
                       DES_COMANDO,
                       DES_RESPUESTA,
                       COD_COMANDO,
                       FEC_HISTORICO
                       )
                (SELECT
                       NUM_MOVIMIENTO,
                       NUM_ORDEN,
                       COD_LENGUAJE,
                       COD_CENTRAL,
                       COD_SISTEMA,
                       FEC_INGRESO,
                       FEC_EJECUCION,
                       DES_COMANDO,
                       DES_RESPUESTA,
                       COD_COMANDO,
                       SYSDATE
        FROM ICR_COMPROC
       WHERE NUM_MOVIMIENTO = V_RMOV.NUM_MOVIMIENTO);
      DELETE ICR_COMPROC WHERE NUM_MOVIMIENTO = V_NEW_RMOV.NUM_MOVIMIENTO;
      V_TABLA := 'P_GE_RESPUESTA';
      IF V_RMOV.COD_ESTADO <> 10 THEN
         GE_PROCED.P_GE_RESPUESTA(V_PRODUCTO,V_NEW_RMOV.COD_MODULO,NULL,NULL,
                               NULL,V_RMOV);
      END IF;
      EXCEPTION WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR (-20002,'P_IC_PASOHR: '||V_TABLA||'-'||SQLERRM,TRUE);
    END;
END IC_PASOH;
/
SHOW ERRORS