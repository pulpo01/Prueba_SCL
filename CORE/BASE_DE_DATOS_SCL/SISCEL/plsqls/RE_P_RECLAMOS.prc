CREATE OR REPLACE procedure re_p_reclamos
(fec_desde in varchar2, fec_hasta in varchar2, SALIDA in varchar2, ARCHIVO in varchar2) IS
 v_fec_reclamo varchar2(10);
 v_num_reclamo re_reclamos.num_reclamo%type;
 v_tip_categoria re_reclamos.tip_categoria%type;
 v_tip_reclamo re_reclamos.tip_reclamo%type;
 v_des_incidencia ca_tipincidencias.des_incidencia%type;
 v_cod_estado re_reclamos.cod_estado%type;
 v_num_terminal re_terminales.num_terminal%type;
 v_num_identclie re_reclamos.num_identclie%type;
 v_cod_username re_reclamos.cod_username%type;
 v_des_sector ge_sectores.des_sector%type;
 v_des_oficina varchar2(40);
 v_ofic varchar2(40);
 v_fec_estimada varchar2(10);
 v_fec_solucion varchar2(10);
 v_cod_username1 re_propuesta.cod_username%type;
 v_rec_descripcion re_reclamos.rec_descripcion%type;
 v_nom_cliente varchar2(150);
 v_tef_cliente1 ge_clientes.tef_cliente1%type;
 v_fec_alta varchar2(10);
 v_fec_fincontra varchar2(10);
 v_fec_cierre varchar2(10);
 v_fecha varchar2(10);
 v_sol_username re_reclamos.sol_username%type;
 v_des_solucion re_reclamos.des_solucion%type;
 v_cer_username re_hreclamos.cer_username%type;
 v_cod_cliente re_reclamos.cod_cliente%type;
 v_glosa varchar2(50);
  sFormatoFecha varchar2(12);
 v_cuentas_impagas number(6);
 v_promedio number(12);
 v_titulo varchar2(500);
 v_file UTL_FILE.FILE_TYPE;
 arch varchar2(50);
 arv varchar2(50);
 file varchar2(50);

 CURSOR ccp(vformatoFecha varchar2, vfec_desde in varchar2, vfec_hasta in varchar2) IS					-- parametros
 select /*+ PARALLEL(a,8,1) */
 to_char(a.fec_reclamo, vformatoFecha), a.num_reclamo , a.tip_categoria, a.tip_reclamo, b.des_incidencia,
 a.cod_estado, c.num_terminal, a.num_identclie, a.cod_username, d.des_sector, f.des_oficina,
 to_char(a.fec_estimada,vformatoFecha), to_char(a.fec_solucion, vformatoFecha), to_char(a.fec_estimada,vformatoFecha),
 g.cod_username, i.des_oficina, a.rec_descripcion, l.nom_cliente || ' ' || l.nom_apeclien1 || ' ' || l.nom_apeclien2,
 l.tef_cliente1, to_char(min(n.fec_alta),vformatoFecha), to_char(max(n.fec_fincontra),vformatoFecha), a.sol_username,
 a.des_solucion, '', a.cod_cliente
 from
 ge_oficinas i, ge_seg_usuario h, re_propuesta g, ca_tipincidencias b, re_terminales c, ge_sectores d,
 ge_seg_usuario e, ge_oficinas f, re_reclamos a, ge_clientes l, ga_abocel n
 where
 a.tip_reclamo<>509 and a.fec_reclamo>=to_date(vfec_desde, vformatoFecha) and
 a.fec_reclamo<to_date(vfec_hasta, vformatoFecha) and  a.tip_reclamo = b.tip_incidencia and a.num_reclamo = c.num_reclamo and
 a.tip_categoria = c.tip_categoria and a.cod_arearesp = d.cod_sector and a.cod_username = e.nom_usuario and
 a.cod_oficina = f.cod_oficina(+) and a.num_reclamo = g.num_reclamo(+) and a.tip_categoria = g.tip_categoria(+)
 and g.cod_username = h.nom_usuario(+) and h.cod_oficina = i.cod_oficina(+) and l.cod_cliente=a.cod_cliente and
 n.cod_cliente=a.cod_cliente
 group by
 a.fec_reclamo, a.num_reclamo , a.tip_categoria, a.tip_reclamo, b.des_incidencia, a.cod_estado,
 c.num_terminal, a.num_identclie, a.cod_username, d.des_sector, f.des_oficina, a.fec_estimada, a.fec_solucion,
 a.fec_estimada, g.cod_username, i.des_oficina, a.rec_descripcion, l.nom_cliente, l.nom_apeclien1, l.nom_apeclien2,
 l.tef_cliente1, a.sol_username, a.des_solucion, a.cod_cliente
 union
 select
 to_char(a.fec_reclamo,vformatoFecha), a.num_reclamo, a.tip_categoria, a.tip_reclamo, b.des_incidencia,
 a.cod_estado, c.num_terminal, a.num_identclie, a.cod_username, d.des_sector, f.des_oficina,
 to_char(a.fec_estimada,vformatoFecha), to_char(a.fec_solucion,vformatoFecha), to_char(a.fec_cierre,vformatoFecha),
 g.cod_username, i.des_oficina, a.rec_descripcion, l.nom_cliente || ' ' || l.nom_apeclien1 || ' ' || l.nom_apeclien2,
 l.tef_cliente1, to_char(min(n.fec_alta), vformatoFecha), to_char(max(n.fec_fincontra), vformatoFecha), a.sol_username,
 a.des_solucion, a.cer_username, a.cod_cliente
 from
 ge_oficinas i, ge_seg_usuario h, re_propuesta g, ca_tipincidencias b, re_terminales c, ge_sectores d,
 ge_seg_usuario e, ge_oficinas f, re_hreclamos a, ge_clientes l, ga_abocel n
 where
 a.tip_reclamo<>509 and a.fec_reclamo>=to_date(vfec_desde,vformatoFecha) and
 a.fec_reclamo<to_date(vfec_hasta,vformatoFecha) and  a.tip_reclamo = b.tip_incidencia and
 a.num_reclamo = c.num_reclamo and a.tip_categoria = c.tip_categoria and
 a.cod_arearesp = d.cod_sector and a.cod_username = e.nom_usuario and a.cod_oficina = f.cod_oficina(+) and
 a.num_reclamo = g.num_reclamo(+) and a.tip_categoria = g.tip_categoria(+) and g.cod_username = h.nom_usuario(+) and
 h.cod_oficina = i.cod_oficina(+) and l.cod_cliente=a.cod_cliente and n.cod_cliente=a.cod_cliente
 group by
 a.fec_reclamo, a.num_reclamo, a.tip_categoria, a.tip_reclamo, b.des_incidencia, a.cod_estado,
 c.num_terminal, a.num_identclie, a.cod_username, d.des_sector, f.des_oficina, a.fec_estimada, a.fec_solucion,
 a.fec_cierre, g.cod_username, i.des_oficina, a.rec_descripcion, l.nom_cliente, l.nom_apeclien1, l.nom_apeclien2,
 l.tef_cliente1, a.sol_username,a.des_solucion, a.cer_username, a.cod_cliente;
 BEGIN

   sFormatoFecha := SP_FN_FORMATOFECHA('FORMATO_SEL2');

   select to_char(sysdate,sFormatoFecha) into v_fecha from dual;

   file:=ARCHIVO;
   arv:=SALIDA;
   arch:=file || '_' || v_fecha || '.txt';
   v_titulo:='FECHA RECLAMO|' || 'NUMERO RECLAMO|' || 'CATEGORIA RECLAMO|' || 'CODIGO TIPO RECLAMO|'
   || 'DESCRIPCION TIP. RECLAMO|' || 'ESTADO RECLAMO|' || 'NUMERO TERMINAL|' || 'RUT|' ||
   'USUARIO|' || 'AREA RESPONSABLE|' || 'OFICINA INGRESADORA|' || 'FECHA VENCIMINETO|' ||
   'FECHA SOLUCION|' || 'FECHA CIERRE|' || 'USUARIO SOLUCION PROPUESTA|' ||
   'OFICINA SOLUCION PROPUESTA|' || 'DESCRIPCION RECLAMO|' || 'NOMBRE CLIENTE|' ||
   'FONO CONTACTO|' || 'FECHA INICIO CONTRATO|' || 'FECHA TERMINO CONTRATO|' || 'USUARIO SOLUCION|' ||
   'SOLUCION|' || 'USUARIO CIERRE|' || 'CUENTAS IMPAGAS|' || 'FACTURACION PROMEDIO ULT. 6 MESES|' ||
   'SERVICIO ACT./DES.';
   v_file:=UTL_FILE.FOPEN(arv,arch,'w');
   UTL_FILE.PUT_LINE(v_file, v_titulo);
   UTL_FILE.FCLOSE(v_file);

   v_file:=UTL_FILE.FOPEN(arv,arch,'a');
   OPEN ccp(sFormatoFecha, fec_desde, fec_hasta);
   LOOP
     begin
       fetch ccp into v_fec_reclamo, v_num_reclamo, v_tip_categoria, v_tip_reclamo, v_des_incidencia,
       v_cod_estado, v_num_terminal, v_num_identclie, v_cod_username, v_des_sector, v_des_oficina,
       v_fec_estimada, v_fec_solucion, v_fec_cierre, v_cod_username1, v_ofic, v_rec_descripcion,
       v_nom_cliente, v_tef_cliente1, v_fec_alta, v_fec_fincontra, v_sol_username, v_des_solucion,
       v_cer_username, v_cod_cliente;
       exit when ccp%notfound;

       select count(1) into v_cuentas_impagas from co_cartera where cod_cliente=v_cod_cliente and importe_debe>importe_haber;

       select round((sum(tot_pagar))/6) into v_promedio from fa_histdocu where cod_cliente=v_cod_cliente
       AND FEC_VENCIMIE > ADD_MONTHS(SYSDATE,-6);

       if v_tip_reclamo=40 or v_tip_reclamo=41 then

           select decode (mov_callerid, 'ACT', 'ACTIVACION CALLER ID'
                                       , 'DES', 'DESACTIVACION CALLER ID'
                                       , 'AIN', 'ACTIVACION INFOBOX'
                                       , 'DIN', 'DESACTIVACION INFOBOX'
                                       , 'ALE', 'ACTIVACION LLAMADA EN ESPERA'
                                       , 'DLE', 'DESACTIVACION LLAMADA EN ESPERA'
                                       , 'AME', 'ACTIVACION MENSAJERIA'
                                       , 'DME', 'DESACTIVACION MENSAJERIA' )
           into v_glosa
           from re_movswitch where num_reclamo=v_num_reclamo;

           Utl_file.put_line(v_file,v_fec_reclamo || '|' || v_num_reclamo || '|' || v_tip_categoria || '|' ||
                 v_tip_reclamo || '|' || v_des_incidencia || '|' || v_cod_estado || '|' || v_num_terminal || '|' ||
                 v_num_identclie || '|' || v_cod_username || '|' || v_des_sector || '|' || v_des_oficina || '|' ||
                 v_fec_estimada || '|' || v_fec_solucion || '|' || v_fec_cierre || '|' || v_cod_username1 || '|' ||
                 v_ofic || '|' || v_rec_descripcion || '|' || v_nom_cliente || '|' || v_tef_cliente1 || '|' ||
                 v_fec_alta || '|' || v_fec_fincontra || '|' || v_sol_username || '|' || v_des_solucion || '|' ||
                 v_cer_username || '|' || v_cuentas_impagas || '|' || v_promedio || '|' || v_glosa);
       else
           Utl_file.put_line(v_file,v_fec_reclamo || '|' || v_num_reclamo || '|' || v_tip_categoria || '|' ||
                 v_tip_reclamo || '|' || v_des_incidencia || '|' || v_cod_estado || '|' || v_num_terminal || '|' ||
                 v_num_identclie || '|' || v_cod_username || '|' || v_des_sector || '|' || v_des_oficina || '|' ||
                 v_fec_estimada || '|' || v_fec_solucion || '|' || v_fec_cierre || '|' || v_cod_username1 || '|' ||
                 v_ofic || '|' || v_rec_descripcion || '|' || v_nom_cliente || '|' || v_tef_cliente1 || '|' ||
                 v_fec_alta || '|' || v_fec_fincontra || '|' || v_sol_username || '|' || v_des_solucion || '|' ||
                 v_cer_username || '|' || v_cuentas_impagas || '|' || v_promedio);
       end if;
       EXCEPTION
       when no_data_found then
       null;
     end;
   end loop;
   close ccp;
   UTL_FILE.FCLOSE(v_file);
 END re_p_reclamos;
/
SHOW ERRORS
