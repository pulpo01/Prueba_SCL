CREATE OR REPLACE function sp_fn_retorna_qry(v_cod_reporte varchar2,v_cod_idioma varchar2, v_tipo_qry varchar2)
return varchar2
is
 error_salida EXCEPTION;
 v_qry_salida varchar2(3000):='' ;
 v_qry_p1     varchar2(3000);
 v_codreporte    varchar2(25);
 v_nomreporte    varchar2(25);
 v_idioma     varchar2(10);
 v_query      varchar2(500);
 lv_valor_texto   varchar2(100);


BEGIN

    
    
    SELECT  vw.valor_texto
    INTO    lv_valor_texto
    FROM  ge_parametros_sistema_vw vw
    WHERE  vw.nom_parametro = 'COD_OPERADORA_LOCAL'
    AND    vw.cod_modulo    = 'GE';
    
    
   v_codreporte:=''''||v_cod_reporte||'''';
   v_idioma:=''''||v_cod_idioma||'''';
   v_query := 'Select '|| v_tipo_qry || ',nom_reporte from sp_qry_reportes  ';
   v_query:=v_query || 'where cod_reporte   = '|| v_codreporte|| '  ';
   v_query:=v_query || 'and cod_operadora = '||''''||lv_valor_texto|| '''' ;

   dbms_output.put_line(v_query);
   execute immediate v_query INTO v_qry_p1,v_nomreporte;
   dbms_output.put_line('Rescata Query');


   if sqlcode <> 0 then
      v_qry_salida:= '0000000000000' ;
      raise  error_salida;
   end if;

   v_nomreporte:=''''||v_nomreporte||'''';
   dbms_output.put_line(v_nomreporte);

   v_qry_salida:=replace (v_qry_p1,':NOM_REP',v_nomreporte);
   dbms_output.put_line('Reemplaza Reporte');
   v_qry_salida:= replace(v_qry_salida,':COD_IDIOMA',v_idioma);
   dbms_output.put_line('Reemplaza Idioma');

  return v_qry_salida;

exception
   When error_salida Then
   return v_qry_salida;
   When no_data_found Then
   return 'Error reporte No existe en tabla....';
   when others Then
    --return 'xxxxxxxxxxxxxxxxxxxxx';
    Return 'ERROR Retorna_qry,SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM;
end;
/
SHOW ERRORS