CREATE OR REPLACE TRIGGER ICC_BEIN_HISTMOV
 BEFORE INSERT ON ICC_HISTMOVIMIENTO
 FOR EACH ROW

DECLARE
  V_SENTENCIA VARCHAR2(32000):= NULL;
  V_TABLA VARCHAR2(17):= '000000';
  cursor_name INTEGER;
  rows INTEGER;
BEGIN

  cursor_name := dbms_sql.open_cursor;

  V_TABLA := 'ICC_HISTMOV' || TO_CHAR(:NEW.FEC_HISTORICO,'MMYYYY');

  V_SENTENCIA := 'INSERT INTO ' || V_TABLA ||
                             '(cod_actabo
                                 ,num_movimiento
                                 ,fec_historico
                                 ,num_abonado
                                 ,cod_actuacion
                                 ,nom_usuarora
                                 ,cod_estado
                                 ,cod_modulo
                                 ,num_intentos
                                 ,fec_ingreso
                                 ,cod_central
                                 ,tip_terminal
                                 ,num_celular
                                 ,num_serie
                                 ,tip_tecnologia
                                 ,imsi
                                 ,imsi_nue
                                 ,imei
                                 ,imei_nue
                                 ,icc
                                 ,icc_nue
                                 ,cod_central_nue
                                 ,des_respuesta
                                 ,fec_lectura
                                 ,cod_act
                                 ,num_movpos
                                 ,fec_ejecucion
                                 ,tip_terminal_nue
                                 ,num_personal
                                 ,num_celular_nue
                                 ,num_serie_nue
                                 ,num_personal_nue
                                 ,num_msnb
                                 ,num_msnb_nue
                                 ,cod_suspreha
                                 ,cod_servicios
                                 ,num_min
                                 ,num_min_nue
                                 ,sta
                                 ,cod_mensaje
                                 ,param1_mens
                                 ,param2_mens
                                 ,param3_mens
                                 ,plan
                                 ,carga
                                 ,valor_plan
                                 ,pin
                                 ,fec_expira
                                 ,cod_pin
                                 ,des_mensaje
                                 ,des_origen_pin
                                 ,num_lote_pin
                                 ,num_serie_pin
                                 ,cod_idioma
                                 ,cod_enrutamiento
                                 ,tip_enrutamiento)
                                 values( :x1,:x2,:x3,:x4,:x5,:x6,:x7,
                                                 :x8,:x9,:x10,:x11,:x12,:x13,
                                                 :x14,:x15,:x16,:x17,:x18,:x19,
                                                 :x20,:x21,:x22,:x23,:x24,:x25,
                                                 :x26,:x27,:x28,:x29,:x30,:x31,
                                                 :x32,:x33,:x34,:x35,:x36,:x37,
                                                 :x38,:x39,:x40,:x41,:x42,:x43,
                                                 :x44,:x45,:x46,:x47,:x48,:x49,
                                                 :x50,:x51,:x52,:x53,:x54,:x55,
                                                 :x56)';

        dbms_sql.parse(cursor_name,V_SENTENCIA,dbms_sql.v7);
    :NEW.cod_act := '';
        dbms_sql.bind_variable(cursor_name,'x1',:NEW.COD_ACTABO);
        dbms_sql.bind_variable(cursor_name,'x2',:NEW.NUM_MOVIMIENTO);
        dbms_sql.bind_variable(cursor_name,'x3',:NEW.FEC_HISTORICO);
        dbms_sql.bind_variable(cursor_name,'x4',:NEW.NUM_ABONADO);
        dbms_sql.bind_variable(cursor_name,'x5',:NEW.COD_ACTUACION);
        dbms_sql.bind_variable(cursor_name,'x6',:NEW.NOM_USUARORA);
        dbms_sql.bind_variable(cursor_name,'x7',:NEW.COD_ESTADO);
        dbms_sql.bind_variable(cursor_name,'x8',:NEW.COD_MODULO);
        dbms_sql.bind_variable(cursor_name,'x9',:NEW.NUM_INTENTOS);
        dbms_sql.bind_variable(cursor_name,'x10',:NEW.FEC_INGRESO);
        dbms_sql.bind_variable(cursor_name,'x11',:NEW.COD_CENTRAL);
        dbms_sql.bind_variable(cursor_name,'x12',:NEW.TIP_TERMINAL);
        dbms_sql.bind_variable(cursor_name,'x13',:NEW.NUM_CELULAR);
        dbms_sql.bind_variable(cursor_name,'x14',:NEW.NUM_SERIE);
        dbms_sql.bind_variable(cursor_name,'x15',:NEW.TIP_TECNOLOGIA);
        dbms_sql.bind_variable(cursor_name,'x16',:NEW.IMSI);
        dbms_sql.bind_variable(cursor_name,'x17',:NEW.IMSI_NUE);
        dbms_sql.bind_variable(cursor_name,'x18',:NEW.IMEI);
        dbms_sql.bind_variable(cursor_name,'x19',:NEW.IMEI_NUE);
        dbms_sql.bind_variable(cursor_name,'x20',:NEW.ICC);
        dbms_sql.bind_variable(cursor_name,'x21',:NEW.ICC_NUE);
        dbms_sql.bind_variable(cursor_name,'x22',:NEW.COD_CENTRAL_NUE);
        dbms_sql.bind_variable(cursor_name,'x23',:NEW.DES_RESPUESTA);
        dbms_sql.bind_variable(cursor_name,'x24',:NEW.FEC_LECTURA);
        dbms_sql.bind_variable(cursor_name,'x25',:NEW.COD_ACT);
        dbms_sql.bind_variable(cursor_name,'x26',:NEW.NUM_MOVPOS);
        dbms_sql.bind_variable(cursor_name,'x27',:NEW.FEC_EJECUCION);
        dbms_sql.bind_variable(cursor_name,'x28',:NEW.TIP_TERMINAL_NUE);
        dbms_sql.bind_variable(cursor_name,'x29',:NEW.NUM_PERSONAL);
        dbms_sql.bind_variable(cursor_name,'x30',:NEW.NUM_CELULAR_NUE);
        dbms_sql.bind_variable(cursor_name,'x31',:NEW.NUM_SERIE_NUE);
        dbms_sql.bind_variable(cursor_name,'x32',:NEW.NUM_PERSONAL_NUE);
        dbms_sql.bind_variable(cursor_name,'x33',:NEW.NUM_MSNB);
        dbms_sql.bind_variable(cursor_name,'x34',:NEW.NUM_MSNB);
        dbms_sql.bind_variable(cursor_name,'x35',:NEW.COD_SUSPREHA);
        dbms_sql.bind_variable(cursor_name,'x36',:NEW.COD_SERVICIOS);
        dbms_sql.bind_variable(cursor_name,'x37',:NEW.NUM_MIN);
        dbms_sql.bind_variable(cursor_name,'x38',:NEW.NUM_MIN_NUE);
        dbms_sql.bind_variable(cursor_name,'x39',:NEW.STA);
        dbms_sql.bind_variable(cursor_name,'x40',:NEW.COD_MENSAJE);
        dbms_sql.bind_variable(cursor_name,'x41',:NEW.PARAM1_MENS);
        dbms_sql.bind_variable(cursor_name,'x42',:NEW.PARAM2_MENS);
        dbms_sql.bind_variable(cursor_name,'x43',:NEW.PARAM3_MENS);
        dbms_sql.bind_variable(cursor_name,'x44',:NEW.PLAN);
        dbms_sql.bind_variable(cursor_name,'x45',:NEW.CARGA);
        dbms_sql.bind_variable(cursor_name,'x46',:NEW.VALOR_PLAN);
        dbms_sql.bind_variable(cursor_name,'x47',:NEW.PIN);
        dbms_sql.bind_variable(cursor_name,'x48',:NEW.FEC_EXPIRA);
        dbms_sql.bind_variable(cursor_name,'x49',:NEW.COD_PIN);
        dbms_sql.bind_variable(cursor_name,'x50',:NEW.DES_MENSAJE);
        dbms_sql.bind_variable(cursor_name,'x51',:NEW.DES_ORIGEN_PIN);
        dbms_sql.bind_variable(cursor_name,'x52',:NEW.NUM_LOTE_PIN);
        dbms_sql.bind_variable(cursor_name,'x53',:NEW.NUM_SERIE_PIN);
        dbms_sql.bind_variable(cursor_name,'x54',:NEW.COD_IDIOMA);
        dbms_sql.bind_variable(cursor_name,'x55',:NEW.COD_ENRUTAMIENTO);
        dbms_sql.bind_variable(cursor_name,'x56',:NEW.TIP_ENRUTAMIENTO);

  rows := dbms_sql.execute(cursor_name);

  dbms_sql.close_cursor(cursor_name);

  :new.cod_act := 'BO';

  EXCEPTION WHEN OTHERS THEN
    dbms_sql.close_cursor(cursor_name);
    RAISE_APPLICATION_ERROR(-20006,'ERROR TRIGGER ICC_BEIN_HISTMOV SCL: '|| V_TABLA ||' ORA'||TO_CHAR(SQLCODE),TRUE);
END;
/
SHOW ERRORS
