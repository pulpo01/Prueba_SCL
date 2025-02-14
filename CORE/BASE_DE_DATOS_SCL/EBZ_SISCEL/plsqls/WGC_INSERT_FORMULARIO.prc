CREATE OR REPLACE PROCEDURE            WGC_INSERT_FORMULARIO(
vp_cod_usuario_cre        in WGED_MENSAJERIA.NUM_IDENT_O%TYPE,
vp_cod_mensaje          out npt_mensaje.cod_mensaje%TYPE,
vp_nom_usuario_cre    in WGED_MENSAJERIA.ORIGEN%TYPE,
vp_nom_usuario_eje    in WGED_MENSAJERIA.DESTINO%TYPE,
vp_cod_usuario_eje        in WGED_MENSAJERIA.NUM_IDENT_D%TYPE,
vp_cod_topico       in WGED_MENSAJERIA.COD_TOPICO%TYPE,
vp_cod_estado       in WGED_MENSAJERIA.COD_ESTADO%TYPE,
vp_cuerpo         in WGED_MENSAJERIA.CUERPO%TYPE,
vp_motivo         in WGED_MENSAJERIA.MOTIVO%TYPE,
vp_cod_funcion      in WGED_MENSAJERIA.COD_FUNCION%TYPE,
vp_fec_propuesta     varchar2,
vp_lugar_propuesto    in WGED_MENSAJERIA.LUGAR_PROPUESTO%TYPE
)
as
v_fec_creacion      date;
BEGIN
 select sysdate into v_fec_creacion from dual;
 insert into WGED_MENSAJERIA (NUM_IDENT_O, ORIGEN, FECHA, DESTINO, NUM_IDENT_D, COD_TOPICO, COD_ESTADO, CUERPO, MOTIVO, COD_FUNCION,
        FEC_PROPUESTA, LUGAR_PROPUESTO)
 values (vp_cod_usuario_cre, vp_nom_usuario_cre, v_fec_creacion, vp_nom_usuario_eje, vp_cod_usuario_eje, vp_cod_topico, vp_cod_estado,
     vp_cuerpo, vp_motivo, vp_cod_funcion, to_date(vp_fec_propuesta,'dd-mm-yyyy hh24:mi'), vp_lugar_propuesto);
END;
/
SHOW ERRORS
