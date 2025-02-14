CREATE OR REPLACE PROCEDURE ICC_INSMOVIMIENTO_PR
(
--
-- <NOMBRE>	 : ICC_INSMOVIMIENTO_PR
-- <FECHACREA>	 : 28/04/2004
-- <MODULO >	 : IC
-- <AUTOR >      : SCL
-- <VERSION >    : 1.0
-- <DESCRIPCION> : Inserta Movimiento con datos enviados a traves de la cadena de entrada
-- <FECHAMOD >   :
-- <DESCMOD >    :
-- <ParamEntr>   : EV_param_entrada (cadena de datos separados por "|"
-- <ParamSal >   : SV_nom_tabla  ---> Nombre de Tabla Involucrada en el proceso
--		   SV_cod_act	 ---> Accion involucrada en el proceso
--		   SV_cod_sqlcode --> Codigo de error cuando se produce (segun estandar)
--		   SV_cod_sqlerrm --> Descripcion de error cuando se produce (segun estandar)
--
EV_param_entrada     IN VARCHAR2,
SV_nom_tabla		OUT VARCHAR2,
SV_cod_act	 		OUT VARCHAR2,
SV_cod_sqlcode		OUT VARCHAR2,
SV_cod_sqlerrm		OUT VARCHAR2
)

IS

string SISCEL.GE_TABTYPE_VCH2ARRAY:= SISCEL.GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');


TV_cod_actabo       ICC_MOVIMIENTO.COD_ACTABO%TYPE;
TV_cod_modulo		ICC_MOVIMIENTO.COD_MODULO%TYPE;
TN_cod_actuacion	ICC_MOVIMIENTO.COD_ACTUACION%TYPE;
TV_nom_usuario 		ICC_MOVIMIENTO.NOM_USUARORA%TYPE;
TV_tip_terminal 	ICC_MOVIMIENTO.TIP_TERMINAL%TYPE;
TV_tip_tecnologia	ICC_MOVIMIENTO.TIP_TECNOLOGIA%TYPE;
TN_num_celular		ICC_MOVIMIENTO.NUM_CELULAR%TYPE;
TV_num_serie		ICC_MOVIMIENTO.NUM_SERIE%TYPE;
TV_num_serie_nue	ICC_MOVIMIENTO.NUM_SERIE_NUE%TYPE;
TN_num_abonado		ICC_MOVIMIENTO.NUM_ABONADO%TYPE;
TN_cod_estado       ICC_MOVIMIENTO.COD_ESTADO%TYPE;
TN_num_intentos		ICC_MOVIMIENTO.NUM_INTENTOS%TYPE;
TV_suspreha	        ICC_MOVIMIENTO.COD_SUSPREHA%TYPE;
TN_cod_central      ICC_MOVIMIENTO.COD_CENTRAL%TYPE;
TN_saldo		    ICC_MOVIMIENTO.CARGA%TYPE;
TV_imei             ICC_MOVIMIENTO.IMEI%TYPE;
TV_icc              ICC_MOVIMIENTO.ICC%TYPE;
TV_imsi             ICC_MOVIMIENTO.IMSI%TYPE;
TV_plan_conver		ICC_MOVIMIENTO.PLAN%TYPE;
TN_carga		    ICC_MOVIMIENTO.CARGA%TYPE;
--TN_num_movimientos  ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE;
TV_cadena           ICC_MOVIMIENTO.COD_SERVICIOS%TYPE;
TD_sysdate  		ICC_MOVIMIENTO.FEC_INGRESO%TYPE;
GV_nom_tabla		VARCHAR2(20);

ERROR_PROCESO EXCEPTION;
BEGIN
	 		    --Asigna Valores a las Variables Locales
	 		  	SISCEL.GE_PAC_ArregloPR.GE_PR_RetornaArreglo(EV_param_entrada, string);
				GV_nom_tabla := 'ICC_MOVIMIENTO';
				TV_cod_actabo:=string(18);
				TV_cod_modulo:=string(22);
				TN_cod_actuacion:=TO_NUMBER(string(19));
				TV_nom_usuario:=string(21);
				TV_tip_terminal:=string(11);
				TV_tip_tecnologia:=string(24);
				TN_num_celular:=nvl(TO_NUMBER(string(16)),0);
				TN_cod_estado:=1;
				TN_num_intentos:=0;
				TN_saldo:=string(23);
				TN_num_abonado:=nvl(ltrim(rtrim(string(15))),0);
				TV_imei:=NULL;
				TV_imsi:=NULL;
				TV_plan_conver:=NULL;
				TN_carga:=NULL;
				TV_suspreha:=ltrim(rtrim(string(32)));
				TV_cadena:=NULL;
				TV_icc:='';
				TV_num_serie_nue :=string(8);
				TD_sysdate:=sysdate;
				TN_cod_central:=TO_NUMBER(string(30));

				-- Valida el Tipo de Tecnologia
		        IF (TV_tip_tecnologia='CDMA') THEN
				   TV_num_serie:=string(17);
				   IF (TV_num_serie='') THEN
				     SV_cod_act := 'SELECT';
  		 		     RAISE_APPLICATION_ERROR(-20002,'NO VIENE NUMERO DE SERIE PARA TECNOLOGIA CDMA ');
				   END IF;
		        END IF;
	   			IF (TV_tip_tecnologia='GSM') THEN
			           TV_icc:=string(17);
				   TV_num_serie:=string(17);
				   IF (TV_icc='') THEN
				      SV_cod_act := 'SELECT';
   		 		     RAISE_APPLICATION_ERROR(-20001,'NO VIENE NUMERO DE SERIE PARA TECNOLOGIA GSM');
				   END IF;
			    END IF;

				-- Realiza Insert a la Tabla
				BEGIN

                   INSERT INTO ICC_MOVIMIENTO
                     (NUM_ABONADO, COD_ACTABO, COD_ESTADO, NUM_MOVIMIENTO, COD_MODULO,
                      COD_ACTUACION, TIP_TERMINAL, COD_CENTRAL,
                      NUM_CELULAR, NUM_SERIE, TIP_TECNOLOGIA, NOM_USUARORA, IMEI,
                      ICC, IMSI,PLAN,CARGA,COD_SUSPREHA,COD_SERVICIOS,FEC_INGRESO,NUM_INTENTOS,NUM_SERIE_NUE,IND_BLOQUEO)
                   VALUES
                     (TN_num_abonado,TV_cod_actabo,TN_cod_estado,ICC_SEQ_NUMMOV.NEXTVAL,TV_cod_modulo,
				      TN_cod_actuacion,TV_tip_terminal,TN_cod_central,TN_num_celular,TV_num_serie,
					  TV_tip_tecnologia,TV_nom_usuario,TV_imei, TV_icc,TV_imsi,TV_plan_conver,TN_saldo,
					  TV_suspreha,TV_cadena,TD_sysdate,TN_num_intentos, TV_num_serie_nue, TN_num_intentos);
				EXCEPTION
				   WHEN OTHERS THEN
				        SV_cod_act := 'INSERT';
  		 		       RAISE_APPLICATION_ERROR(-20003,sqlerrm);
				END;

EXCEPTION
    WHEN ERROR_PROCESO THEN
		 SV_nom_tabla:='';
	     SV_cod_act:='';
		 SV_cod_sqlcode := '0';
		 SV_cod_sqlerrm := 'OK';
    WHEN OTHERS THEN
		 SV_cod_sqlcode := SQLCODE;
		 SV_cod_sqlerrm := SQLERRM;
		 SV_nom_tabla  := GV_nom_tabla;
END;
/
SHOW ERRORS
