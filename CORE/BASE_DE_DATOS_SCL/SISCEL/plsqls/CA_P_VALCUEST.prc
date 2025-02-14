CREATE OR REPLACE PROCEDURE        ca_p_valcuest(
  vp_num_error IN varchar2 )
IS
 begin
 /*
   Insertamos en CA_ERRORES aquellas preguntas que no tienen ninguna fila
   asociada en CA_RESPUESTAS
 */
 insert into ca_errores (num_error, cod_cuestionario,
    num_pregunta, num_respuesta)
  (select vp_num_error, a.cod_cuestionario,b.num_pregunta,00
   from ca_cuestionarios a, ca_preguntas b
   where a.cod_cuestionario = b.cod_cuestionario and
          b.num_pregunta not in
           (select c.num_pregunta
    from ca_respuestas c
    where a.cod_cuestionario = c.cod_cuestionario));
 /*
   Insertamos en CA_ERRORES aquellas respuetas que tienen como enlace una
   pregunta que no existe
 */
 insert into ca_errores (num_error, cod_cuestionario,
    num_pregunta, num_respuesta,
    cod_cuestionario_new, num_pregunta_new)
  (select vp_num_error, b.cod_cuestionario,
   a.num_pregunta, a.num_respuesta,
   a.cod_cuestionario_new, a.num_pregunta_new
   from ca_respuestas a, ca_cuestionarios b
   where a.cod_cuestionario = b.cod_cuestionario and
          a.cod_cuestionario_new || to_char(a.num_pregunta_new) not in
     (select d.cod_cuestionario || to_char(c.num_pregunta)
      from ca_preguntas c,ca_cuestionarios d
      where c.cod_cuestionario = a.cod_cuestionario_new
      and c.cod_cuestionario = d.cod_cuestionario));
 commit;
 end;
/
SHOW ERRORS
