CREATE OR REPLACE TRIGGER ca_tbefup_incidencias
BEFORE UPDATE
ON CA_INCIDENCIAS
FOR EACH ROW
 
WHEN (
NEW.COD_ESTADO='CE'
      )
DECLARE
 v_record ca_incidencias%rowtype;
begin
 /*
   Volcamos los valores en v_record
 */
  v_record.num_incidencia    := :new.num_incidencia;
  v_record.tip_inter         := :new.tip_inter;
  v_record.per_contacto      := :new.per_contacto;
  v_record.tip_incidencia    := :new.tip_incidencia;
  v_record.ind_urgente       := :new.ind_urgente;
  v_record.num_llamada       := :new.num_llamada;
  v_record.usu_creador       := :new.usu_creador;
  v_record.fec_creacion      := :new.fec_creacion;
  v_record.fec_estimada      := :new.fec_estimada;
  v_record.cod_estado        := :new.cod_estado;
  v_record.cod_interlocutor  := :new.cod_interlocutor;
  v_record.fec_real          := :new.fec_real;
  v_record.usu_solucion      := :new.usu_solucion;
  v_record.fec_comunica      := :new.fec_comunica;
  v_record.usu_comunica      := :new.usu_comunica;
 /*
  Llamada al procedimiento que se encargara de grabar en CA_HINCIDENCIAS,
  CA_HINCISECTORES, CA_HINCICOMNENTARIOS, CA_HVALINCIDENCIAS y
  borrar de CA_INCIDENCIAS, CA_INCISECTORES, CA_INCICOMENTARIOS,
  CA_VALINCIDENCIAS
 */
   ca_pac_historico.ca_p_historico_incidencias (v_record);
 /*
  En caso de error el procedimiento hara saltar los errores comprendidos
  entre -20700 y -20707 siendo:
  -20700 : Insert en CA_HINCIDENCIAS
  -20701 : Insert en CA_HINCICOMENTARIOS
  -20702 : Insert en CA_HINCISECTORES
  -20703 : Insert en CA_HVALINCIDENCIAS
 */
 :new.cod_estado := 'TH';
end;
/
SHOW ERRORS
