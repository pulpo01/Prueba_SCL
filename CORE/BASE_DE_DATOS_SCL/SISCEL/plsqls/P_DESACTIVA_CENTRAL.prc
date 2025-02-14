CREATE OR REPLACE PROCEDURE        P_DESACTIVA_CENTRAL
(
  v_actuacion IN icc_movimiento.cod_actuacion%type ,
  v_prefijo IN al_usos_min.num_min%type,
  v_central IN icc_movimiento.cod_central%type ,
  v_celular IN icc_movimiento.num_celular%type ,
  v_serie IN icc_movimiento.num_serie%type ,
  v_terminal IN icc_movimiento.tip_terminal%type )
IS
BEGIN
  insert into icc_movimiento (num_movimiento,
                              num_abonado,
                              cod_estado,
                              cod_modulo,
                              num_intentos,
                              des_respuesta,
                              cod_actuacion,
                              cod_actabo,
                              nom_usuarora,
                              fec_ingreso,
                              cod_central,
                              num_celular,
                              num_serie,
                              tip_terminal,
                              ind_bloqueo,
                                                          num_min)
                      values (icc_seq_nummov.nextval,
                              0,
                              1,
                              'AL',
                              0,
                              'PENDIENTE',
                              v_actuacion,
                              'XX',
                              USER,
                              SYSDATE,
                              v_central,
                              v_celular,
                              v_serie,
                              v_terminal,
                              0,
                                                          v_prefijo);
EXCEPTION
   when OTHERS then
        raise_application_error
         (-20191,'Error al generar movimiento desactivacion en central '
          || to_char(SQLCODE));
END p_desactiva_central;
/
SHOW ERRORS
