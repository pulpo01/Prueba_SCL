CREATE OR REPLACE PACKAGE BODY VE_CREA_LINEA_VENTA_QUIOSCO_PG IS
   PROCEDURE ve_obtiene_secuencia_pr (
      ev_nomsecuencia   IN              VARCHAR2,
      sv_secuencia      OUT NOCOPY      VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento)
                                                             /*
                                                             <Documentación
                                                               TipoDoc = "Procedimiento">
                                                                <Elemento
                                                                   Nombre = "VE_OBTIENE_SECUENCIA_PR"
                                                                   Lenguaje="PL/SQL"
                                                                   Fecha="15-11-2005"
                                                                   Versión="1.0"
                                                                   Diseñador="Rayen Ceballos"
                                                                  Programador="Roberto Perez"
                                                                   Ambiente Desarrollo="BD">
                                                                   <Retorno>Valor de Secuencia</Retorno>
                                                                      <Descripción>Obtiene valor de secuencia</Descripción>
                                                                    <Parámetros>
                                                                      <Entrada>
                                                                      <param nom="EV_nomsecuencia" Tipo="VARCHAR2>nombre de la secuencia a rescatar</param>
                                                                      </Entrada>
                                                                      <Salida>
                                                                         <param nom="SV_secuencia"     Tipo="VARCHAR2">secuencia rescatada</param>
                                                                      <param nom="SN_cod_retorno"    Tipo="NUMBER">Codigo error de negocio Retornado</param>
                                                                         <param nom="SV_mens_retorno"   Tipo="VARCHAR2">Mensaje error de negocio Retornado</param>
                                                                         <param nom="SN_num_evento"    Tipo="NUMBER">Nro de evento</param>
                                                                      </Salida>
                                                                   </Parámetros>
                                                               </Elemento>
                                                             </Documentación>
                                                             */
   AS
      lv_des_error   ge_errores_pg.desevent;
      ssql           ge_errores_pg.vquery;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      ssql := 'SELECT ' || ev_nomsecuencia || '.NEXTVAL FROM DUAL';

      EXECUTE IMMEDIATE ssql
                   INTO sv_secuencia;
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno := 10800;
         sv_mens_retorno := 'Error al obtener valor de la secuencia';

         lv_des_error := 'OTHERS:VE_CREA_LINEA_VENTA_QUIOSCO_PG.VE_OBTIENE_SECUENCIA_PR(' || ev_nomsecuencia || ');- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 'VE_CREA_LINEA_VENTA_QUIOSCO_PG.VE_OBTIENE_SECUENCIA_PR', ssql, SQLCODE, lv_des_error);
   END ve_obtiene_secuencia_pr;

   PROCEDURE ve_obtiene_datos_vendedor_pr (
      ev_codvendedor     IN              ve_vendedores.cod_vendedor%TYPE,
      sv_codvende_raiz   OUT NOCOPY      ve_vendedores.cod_vende_raiz%TYPE,
      sv_codvendealer    OUT NOCOPY      ve_vendealer.cod_vendealer%TYPE,
      sn_cod_retorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento)
                                                              /*
                                                              <Documentación
                                                                TipoDoc = "Procedimiento">
                                                                 <Elemento
                                                                    Nombre = "VE_OBTIENE_DATOS_VENDEDOR_PR"
                                                                    Lenguaje="PL/SQL"
                                                                    Fecha="15-11-2005"
                                                                    Versión="1.0"
                                                                    Diseñador="Rayen Ceballos"
                                                                   Programador="Roberto Perez"
                                                                    Ambiente Desarrollo="BD">
                                                                    <Retorno>datos de vendedor</Retorno>
                                                                       <Descripción>Obtiene datos de vendedor por codigo</Descripción>
                                                                     <Parámetros>
                                                                       <Entrada>
                                                                       <param nom="EV_codvendedor" Tipo="VARCHAR2>codigo del vendedor</param>
                                                                       </Entrada>
                                                                       <Salida>
                                                                          <param nom="SV_codvende_raiz"     Tipo="VARCHAR2">codigo vendedor raiz rescatado</param>
                                                                          <param nom="SV_codvendealer"     Tipo="VARCHAR2">codigo vendedor dealer rescatado</param>
                                                                       <param nom="SN_cod_retorno"    Tipo="NUMBER">Codigo error de negocio Retornado</param>
                                                                          <param nom="SV_mens_retorno"   Tipo="VARCHAR2">Mensaje error de negocio Retornado</param>
                                                                          <param nom="SN_num_evento"    Tipo="NUMBER">Nro de evento</param>
                                                                       </Salida>
                                                                    </Parámetros>
                                                                </Elemento>
                                                              </Documentación>
                                                              */
   IS
      lv_des_error   ge_errores_pg.desevent;
      lv_sql         ge_errores_pg.vquery;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_sql := 'SELECT a.cod_vende_raiz, b.cod_vendealer' || ' FROM   ve_vendedores a, ve_vendealer b' || ' WHERE  a.cod_vendedor=' || ev_codvendedor || ' AND a.cod_vendedor=b.cod_vendedor(+)';

      SELECT a.cod_vende_raiz, b.cod_vendealer
        INTO sv_codvende_raiz, sv_codvendealer
        FROM ve_vendedores a, ve_vendealer b
       WHERE a.cod_vendedor = ev_codvendedor AND a.cod_vendedor = b.cod_vendedor(+);
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno := 1;
         sv_mens_retorno := 'No se pudo recuperar datos.';

         lv_des_error := 'NO_DATA_FOUND:VE_CREA_LINEA_VENTA_QUIOSCO_PG.VE_obtiene_datos_vendedor_PR(' || ev_codvendedor || ');- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 'VE_CREA_LINEA_VENTA_QUIOSCO_PG.VE_obtiene_datos_vendedor_PR(' || ev_codvendedor || ')', lv_sql, SQLCODE, lv_des_error);
      WHEN OTHERS THEN
         sn_cod_retorno := 10801;
         sv_mens_retorno := 'Error al obtener datos de vendedor por código';

         lv_des_error := 'OTHERS;VE_CREA_LINEA_VENTA_QUIOSCO_PG.VE_obtiene_datos_vendedor_PR(' || ev_codvendedor || ');- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 'VE_CREA_LINEA_VENTA_QUIOSCO_PG.VE_obtiene_datos_vendedor_PR(' || ev_codvendedor || ')', lv_sql, SQLCODE, lv_des_error);
   END ve_obtiene_datos_vendedor_pr;

   PROCEDURE ve_obtiene_datos_cliente_pr (
      ev_codcliente     IN              ge_clientes.cod_cliente%TYPE,
      sv_codcuenta      OUT NOCOPY      ge_clientes.cod_cuenta%TYPE,
      sv_codsubcuenta   OUT NOCOPY      ga_subcuentas.cod_subcuenta%TYPE,
      sv_nomusuario     OUT NOCOPY      ge_clientes.nom_cliente%TYPE,
      sv_nomapellido1   OUT NOCOPY      ge_clientes.nom_apeclien1%TYPE,
      sv_numident       OUT NOCOPY      ge_clientes.num_ident%TYPE,
      sv_codtipident    OUT NOCOPY      ge_clientes.cod_tipident%TYPE,
      sv_nomapellido2   OUT NOCOPY      ge_clientes.nom_apeclien2%TYPE,
      sv_fecnaciomien   OUT NOCOPY      ge_clientes.fec_nacimien%TYPE,
      sv_indestcivil    OUT NOCOPY      ge_clientes.ind_estcivil%TYPE,
      sv_indsexo        OUT NOCOPY      ge_clientes.ind_sexo%TYPE,
      sv_codactividad   OUT NOCOPY      ge_clientes.cod_actividad%TYPE,
      sv_codregion      OUT NOCOPY      ge_direcciones.cod_region%TYPE,
      sv_codciudad      OUT NOCOPY      ge_direcciones.cod_ciudad%TYPE,
      sv_codprovincia   OUT NOCOPY      ge_direcciones.cod_provincia%TYPE,
      sv_codcelda       OUT NOCOPY      ge_ciudades.cod_celda%TYPE,
      sv_codcalclien    OUT NOCOPY      ge_clientes.cod_calclien%TYPE,
      sv_indfactur      OUT NOCOPY      ge_clientes.ind_factur%TYPE,
      sv_codciclo       OUT NOCOPY      ge_clientes.cod_ciclo%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento)
                                                             /*
                                                             <Documentación
                                                               TipoDoc = "Procedimiento">
                                                                <Elemento
                                                                   Nombre = "VE_OBTIENE_DATOS_CLIENTE_PR"
                                                                   Lenguaje="PL/SQL"
                                                                   Fecha="15-11-2005"
                                                                   Versión="1.0"
                                                                   Diseñador="Rayen Ceballos"
                                                                  Programador="Roberto Perez"
                                                                   Ambiente Desarrollo="BD">
                                                                   <Retorno>Datos de cliente/Retorno>
                                                                      <Descripción>Obtiene datos de cliente por codigo</Descripción>
                                                                    <Parámetros>
                                                                      <Entrada>
                                                                      <param nom="EV_codcliente" Tipo="VARCHAR2>codigo del cleinte</param>
                                                                      </Entrada>
                                                                      <Salida>
                                                                         <param nom="SV_codcuenta" Tipo="NUMBER">codigo cuenta cliente</param>
                                                                         <param nom="SV_codsubcuenta" Tipo="VARCHAR2">codigo subcuenta cliente</param>
                                                                         <param nom="SV_nomusuario" Tipo="VARCHAR2">nombre usuario cliente</param>
                                                                         <param nom="SV_nomapellido1" Tipo="VARCHAR2">apellido 1 cliente</param>
                                                                         <param nom="SV_numident" Tipo="VARCHAR2">numero identificacion cliente</param>
                                                                         <param nom="SV_codtipident" Tipo="VARCHAR2">codigo tipo identificacion</param>
                                                                         <param nom="SV_nomapellido2" Tipo="VARCHAR2">apellido 2 cliente</param>
                                                                         <param nom="SV_fecnaciomien" Tipo="DATE">codigo tipo identificacion</param>
                                                                         <param nom="SV_indestcivil" Tipo="VARCHAR2">indicador estado civil cliente(C|S|D|V|O)</param>
                                                                         <param nom="SV_indsexo" Tipo="VARCHAR2">indicador sexo cliente (M|F)</param>
                                                                         <param nom="SV_codactividad" Tipo="NUMBER">codigo actividad cliente</param>
                                                                         <param nom="SV_codregion" Tipo="NUMBER">codigo region cliente</param>
                                                                         <param nom="SV_codciudad" Tipo="NUMBER">codigo ciudad cliente</param>
                                                                         <param nom="SV_codprovincia" Tipo="NUMBER">codigo provincia cliente</param>
                                                                         <param nom="SV_codcelda" Tipo="VARCHAR2">codigo celda cliente</param>
                                                                         <param nom="SV_codcalclien" Tipo="VARCHAR2">codigo calidad cliente</param>
                                                                         <param nom="SV_indfactur" Tipo="VARCHAR2">Indicativo de Facturable ; Si(1), No(0)</param>
                                                                         <param nom="SV_codciclo" Tipo="NUMBER">codigo ciclo cliente</param>
                                                                      <param nom="SN_cod_retorno"   Tipo="NUMBER">Codigo error de negocio Retornado</param>
                                                                         <param nom="SV_mens_retorno"  Tipo="VARCHAR2">Mensaje error de negocio Retornado</param>
                                                                         <param nom="SN_num_evento"    Tipo="NUMBER">Nro de evento</param>
                                                                      </Salida>
                                                                   </Parámetros>
                                                               </Elemento>
                                                             </Documentación>
                                                             */
   IS
      lv_sql         ge_errores_pg.vquery;
      lv_des_error   ge_errores_pg.desevent;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_sql :=
         'SELECT a.cod_cuenta, b.cod_subcuenta, a.nom_cliente,' || ' a.nom_apeclien1, a.num_ident, a.cod_tipident,' || ' a.nom_apeclien2, a.fec_nacimien, a.ind_estcivil,' || ' a.ind_sexo, a.cod_actividad, c.cod_region, c.cod_ciudad,'
         || ' c.cod_provincia, e.cod_celda, a.cod_calclien,' || ' a.ind_factur, a.cod_ciclo' || ' FROM     ge_clientes a, ga_subcuentas b,' || ' ge_direcciones c, ga_direccli d,' || ' ge_ciudades e' || ' WHERE    a.cod_cliente=' || ev_codcliente
         || ' AND b.cod_cuenta=a.cod_cuenta' || ' AND d.cod_cliente=a.cod_cliente' || ' AND d.cod_tipdireccion=' || cv_tipodireccion || ' AND c.cod_direccion=d.cod_direccion' || ' AND e.cod_ciudad=c.cod_ciudad' || ' AND e.cod_provincia=c.cod_provincia'
         || ' AND e.cod_region=c.cod_region';

      SELECT a.cod_cuenta, b.cod_subcuenta, a.nom_cliente, a.nom_apeclien1, a.num_ident, a.cod_tipident, a.nom_apeclien2, a.fec_nacimien, a.ind_estcivil, a.ind_sexo, a.cod_actividad, c.cod_region, c.cod_ciudad, c.cod_provincia, e.cod_celda,
             a.cod_calclien, a.ind_factur, a.cod_ciclo
        INTO sv_codcuenta, sv_codsubcuenta, sv_nomusuario, sv_nomapellido1, sv_numident, sv_codtipident, sv_nomapellido2, sv_fecnaciomien, sv_indestcivil, sv_indsexo, sv_codactividad, sv_codregion, sv_codciudad, sv_codprovincia, sv_codcelda,
             sv_codcalclien, sv_indfactur, sv_codciclo
        FROM ge_clientes a, ga_subcuentas b, ge_direcciones c, ga_direccli d, ge_ciudades e
       WHERE a.cod_cliente = ev_codcliente AND b.cod_cuenta = a.cod_cuenta AND d.cod_cliente = a.cod_cliente AND d.cod_tipdireccion = cv_tipodireccion AND c.cod_direccion = d.cod_direccion AND e.cod_ciudad = c.cod_ciudad
             AND e.cod_provincia = c.cod_provincia AND e.cod_region = c.cod_region;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno := 1;
         sv_mens_retorno := 'No se pudo recuperar datos.';

         lv_des_error := 'NO_DATA_FOUND:VE_CREA_LINEA_VENTA_QUIOSCO_PG.VE_obtiene_datos_cliente_PR(' || ev_codcliente || '); ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 'VE_CREA_LINEA_VENTA_QUIOSCO_PG.VE_obtiene_datos_cliente_PR(' || ev_codcliente || ')', lv_sql, SQLCODE, lv_des_error);
      WHEN OTHERS THEN
         sn_cod_retorno := 10802;
         sv_mens_retorno := 'Error al obtener datos de cliente por código';

         lv_des_error := 'OTHERS:VE_CREA_LINEA_VENTA_QUIOSCO_PG.VE_obtiene_datos_cliente_PR(' || ev_codcliente || '); ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 'VE_CREA_LINEA_VENTA_QUIOSCO_PG.VE_obtiene_datos_cliente_PR(' || ev_codcliente || ')', lv_sql, SQLCODE, lv_des_error);
   END ve_obtiene_datos_cliente_pr;

   PROCEDURE ve_in_ga_usuarios_pr (
      ev_codusuario     IN              ga_usuarios.cod_usuario%TYPE,
      ev_codcuenta      IN              ga_usuarios.cod_cuenta%TYPE,
      ev_codsubcuenta   IN              ga_usuarios.cod_subcuenta%TYPE,
      ev_nomusuario     IN              ga_usuarios.nom_usuario%TYPE,
      ev_nomapellido1   IN              ga_usuarios.nom_apellido1%TYPE,
      ev_nomapellido2   IN              ga_usuarios.nom_apellido2%TYPE,
      ev_numident       IN              ga_usuarios.num_ident%TYPE,
      ev_codtipident    IN              ga_usuarios.cod_tipident%TYPE,
      ev_indestado      IN              ga_usuarios.ind_estado%TYPE,
      ev_fecnacimien    IN              VARCHAR2,
      ev_codestcivil    IN              VARCHAR2,
      ev_indsexo        IN              VARCHAR2,
      ev_indtipotrab    IN              ga_usuarios.ind_tipotrab%TYPE,
      ev_nomempresa     IN              ga_usuarios.nom_empresa%TYPE,
      ev_codactemp      IN              ga_usuarios.cod_actemp%TYPE,
      ev_codocupacion   IN              ga_usuarios.cod_ocupacion%TYPE,
      en_numpercargo    IN              ga_usuarios.num_percargo%TYPE,
      en_impbruto       IN              ga_usuarios.imp_bruto%TYPE,
      ev_indprocoper    IN              ga_usuarios.ind_procoper%TYPE,
      ev_codoperador    IN              ga_usuarios.cod_operador%TYPE,
      ev_nomconyuge     IN              ga_usuarios.nom_conyuge%TYPE,
      ev_codpinusuar    IN              ga_usuarios.cod_pinusuar%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento)
                                                             /*
                                                             <Documentación
                                                               TipoDoc = "Procedimiento">
                                                                <Elemento
                                                                   Nombre = "VE_IN_ga_usuarios_PR"
                                                                   Lenguaje="PL/SQL"
                                                                   Fecha="15-11-2005"
                                                                   Versión="1.0"
                                                                   Diseñador="Rayen Ceballos"
                                                                  Programador="Roberto Perez"
                                                                   Ambiente Desarrollo="BD">
                                                                   <Retorno>NA</Retorno>
                                                                      <Descripción>Ingresa Usuario</Descripción>
                                                                    <Parámetros>
                                                                      <Entrada>
                                                                      <param nom="EV_codusuario" Tipo="NUMBER">codigo de usuario</param>
                                                                      <param nom="EV_codcuenta" Tipo="NUMBER">codigo de cuenta</param>
                                                                      <param nom="EV_codsubcuenta" Tipo="NUMBER">codigo de subcuenta</param>
                                                                      <param nom="EV_nomusuario" Tipo="VARCHAR2">nombre de usuario</param>
                                                                      <param nom="EV_nomapellido1" Tipo="VARCHAR2">apellido 1 de usuario</param>
                                                                      <param nom="EV_nomapellido2" Tipo="VARCHAR2">apellido 2 de usuario</param>
                                                                      <param nom="EV_numident" Tipo="VARCHAR2">numero identificacion usuario</param>
                                                                      <param nom="EV_codtipident" Tipo="VARCHAR2">codigo tipo identificacion usuario</param>
                                                                      <param nom="EV_indestado" Tipo="VARCHAR2">Indicativo de Estado (C)umplimentado/(S)in Cumplimentar</param>
                                                                      <param nom="EV_fecnacimien" Tipo="VARCHAR2">fecha nacimiento usuario</param>
                                                                      <param nom="EV_codestcivil" Tipo="VARCHAR2">codigo estado civil usuario</param>
                                                                      <param nom="EV_indsexo" Tipo="VARCHAR2">codigo sexo (M/F) usuario</param>
                                                                      <param nom="EV_indtipotrab" Tipo="VARCHAR2">Tipo de Trabajador (E)mpleado/(A)utonomo</param>
                                                                      <param nom="EV_nomempresa" Tipo="VARCHAR2">Nombre empresa usuario</param>
                                                                      <param nom="EV_codactemp" Tipo="NUMBER">Código de Actividad Empresa</param>
                                                                      <param nom="EV_codocupacion" Tipo="NUMBER">Código de ocupacion usuario</param>
                                                                      <param nom="EN_numpercargo" Tipo="NUMBER">numero de persona a cargo</param>
                                                                      <param nom="EN_impbruto" Tipo="NUMBER">ingresos brutos anuales</param>
                                                                      <param nom="EV_indprocoper" Tipo="NUMBER">Indicativo de Procedencia de otra Operadora Si(1)/No(0)</param>
                                                                      <param nom="EV_codoperador" Tipo="NUMBER">codigo operador</param>
                                                                      <param nom="EV_nomconyuge" Tipo="VARCHAR2">nombre conyuge</param>
                                                                      <param nom="EV_codoperador" Tipo="VARCHAR2">Código identificación del usuario</param>
                                                                      </Entrada>
                                                                      <Salida>
                                                                      <param nom="SN_cod_retorno"    Tipo="NUMBER">Codigo error de negocio Retornado</param>
                                                                         <param nom="SV_mens_retorno"   Tipo="VARCHAR2">Mensaje error de negocio Retornado</param>
                                                                         <param nom="SN_num_evento"    Tipo="NUMBER">Nro de evento</param>
                                                                      </Salida>
                                                                   </Parámetros>
                                                               </Elemento>
                                                             </Documentación>
                                                             */
   IS
      lv_des_error   ge_errores_pg.desevent;
      lv_sql         ge_errores_pg.vquery;
      --Incidencia 62391
      lv_est_civil   VARCHAR2 (10);
      lv_sexo        VARCHAR2 (10);
   --Fin 62391
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;

      --Incidencia 62391 se valide que las variables no contengan espacios en blanco [PAAA 19-02-2008, soporte]
      IF LENGTH (ev_codestcivil) > 0 THEN
         lv_est_civil := RTRIM (ev_codestcivil);
         lv_est_civil := LTRIM (lv_est_civil);
      ELSE
         lv_est_civil := NULL;
      END IF;

      IF LENGTH (ev_indsexo) > 0 THEN
         lv_sexo := RTRIM (ev_indsexo);
         lv_sexo := LTRIM (lv_sexo);
      ELSE
         lv_sexo := NULL;
      END IF;

      --Fin 62391
      lv_sql :=
         'INSERT INTO ga_usuarios (cod_usuario, cod_cuenta, cod_subcuenta, nom_usuario, nom_apellido1, ' || 'fec_alta, cod_tipident, num_ident, ind_estado, nom_apellido2, fec_nacimien, '
         || 'cod_estcivil, ind_sexo, ind_tipotrab, nom_empresa, cod_actemp, cod_ocupacion, ' || 'num_percargo, imp_bruto, ind_procoper, cod_operador, nom_conyuge, cod_pinusuar) ' || 'VALUES (' || ev_codusuario || ',' || ev_codcuenta || ','
         || ev_codsubcuenta || ',' || ev_nomusuario || ',' || ev_nomapellido1 || ',' || SYSDATE || ',' || ev_codtipident || ',' || ev_numident || ',' || ev_indestado || ',' || ev_nomapellido2 || ',' || 'TO_DATE(' || ev_fecnacimien || ',' || 'DD-MM-YYYY'
         || ')' || ',' || lv_est_civil || ',' || lv_sexo || ',' || ev_indtipotrab || ',' || ev_nomempresa || ',' || ev_codactemp || ',' || ev_codocupacion || ',' || en_numpercargo || ',' || en_impbruto || ',' || ev_indprocoper || ',' || ev_codoperador
         || ',' || ev_nomconyuge || ',' || ev_codpinusuar || ')';

      INSERT INTO ga_usuarios
                  (cod_usuario, cod_cuenta, cod_subcuenta, nom_usuario, nom_apellido1, fec_alta, cod_tipident, num_ident, ind_estado, nom_apellido2, fec_nacimien, cod_estcivil, ind_sexo, ind_tipotrab,
                   nom_empresa, cod_actemp, cod_ocupacion, num_percargo, imp_bruto, ind_procoper, cod_operador, nom_conyuge, cod_pinusuar)
      VALUES      (ev_codusuario, ev_codcuenta, ev_codsubcuenta, ev_nomusuario, NVL(ev_nomapellido1,'NN'), SYSDATE, ev_codtipident, ev_numident, ev_indestado, ev_nomapellido2,
                                                                                                                                                                     --Incidencia 62391 [PAAA 19-02-2008]
                                                                                                                                                                     --TO_DATE(EV_fecnacimien, 'DD-MM-YYYY'), EV_codestcivil, EV_indsexo, EV_indtipotrab,
                                                                                                                                                                     TO_DATE (ev_fecnacimien, 'DD-MM-YYYY'), lv_est_civil, lv_sexo, ev_indtipotrab,
                   --Fin 62391
                   ev_nomempresa, ev_codactemp, ev_codocupacion, en_numpercargo, en_impbruto, ev_indprocoper, ev_codoperador, ev_nomconyuge, ev_codpinusuar);
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno := 10803;
         sv_mens_retorno := 'Error al ingresar usuario';

         lv_des_error := 'OTHERS:VE_CREA_LINEA_VENTA_QUIOSCO_PG.VE_IN_ga_usuarios_PR(' || ev_codusuario || '); ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 'VE_CREA_LINEA_VENTA_QUIOSCO_PG.VE_IN_ga_usuarios_PR(' || ev_codusuario || ')', lv_sql, SQLCODE, lv_des_error);
   END ve_in_ga_usuarios_pr;

   PROCEDURE ve_obtiene_datos_generales_pr (
      ev_codproducto    IN              ga_grpserv.cod_producto%TYPE,
      sv_cod_calclien   OUT NOCOPY      ga_datosgener.cod_calclien%TYPE,
      sv_cod_abc        OUT NOCOPY      ga_datosgener.cod_abc%TYPE,
      sn_cod_123        OUT NOCOPY      ga_datosgener.cod_123%TYPE,
      sn_codestcobros   OUT NOCOPY      ga_datosgener.cod_estcobros%TYPE,
      sv_codgrpsrv      OUT NOCOPY      ga_grpserv.cod_grupo%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento)
                                                             /*
                                                             <Documentación
                                                               TipoDoc = "Procedimiento">
                                                                <Elemento
                                                                   Nombre = "VE_OBTIENE_DATOS_GENERALES_PR"
                                                                   Lenguaje="PL/SQL"
                                                                   Fecha="30-08-2005"
                                                                   Versión="1.0"
                                                                   Diseñador="Roberto Pérez"
                                                                  Programador="Roberto Perez"
                                                                   Ambiente Desarrollo="BD">
                                                                   <Retorno>NA</Retorno>
                                                                   <Descripción>Obtener datos desde la tabla de datos generales</Descripción>
                                                                   <Parámetros>
                                                                      <Entrada>
                                                                         <param nom="EV_codproducto"  Tipo="VARCHAR2">codigo de producto</param>
                                                                    </Entrada>
                                                                <Salida>
                                                                         <param nom="SV_cod_calclien"  Tipo="VARCHAR2">Código de calidad de cliente defecto </param>
                                                                         <param nom="SV_cod_abc"       Tipo="VARCHAR2">Código inicial clasificación abc</param>
                                                                         <param nom="SN_cod_123"       Tipo="NUMBER">Código inicial clasificación 123</param>
                                                                         <param nom="SN_codestcobros"  Tipo="NUMBER">Código de Estado Inicial de Cobros</param>
                                                                         <param nom="SN_codgrpsrv"     Tipo="NUMBER">Código de Grupo</param>
                                                                         <param nom="SN_cod_retorno"   Tipo="NUMBER">Codigo de Retorno</param>
                                                                         <param nom="SV_mens_retorno"  Tipo="VARCHAR2">Mensaje de Retorno</param>
                                                                         <param nom="SN_num_evento"    Tipo="NUMBER">Nro de evento</param>
                                                                      </Salida>
                                                                   </Parámetros>
                                                                </Elemento>
                                                             </Documentación>
                                                             */
   AS
      lv_des_error   ge_errores_pg.desevent;
      ssql           ge_errores_pg.vquery;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      sv_cod_calclien := NULL;
      sv_cod_abc := NULL;
      sn_cod_123 := NULL;
      ssql := 'SELECT m.cod_calclien, m.cod_abc, m.cod_123, m.cod_estcobros,' || ' n.cod_grupo ' || ' FROM   ga_datosgener m, ga_grpserv n' || ' WHERE  n.cod_producto=' || ev_codproducto;

      SELECT m.cod_calclien, m.cod_abc, m.cod_123, m.cod_estcobros, n.cod_grupo
        INTO sv_cod_calclien, sv_cod_abc, sn_cod_123, sn_codestcobros, sv_codgrpsrv
        FROM ga_datosgener m, ga_grpserv n
       WHERE n.cod_producto = ev_codproducto;
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno := 10804;
         sv_mens_retorno := 'Error al obtener datos desde la tabla de datos generales';

         lv_des_error := 'OTHERS:VE_CREA_LINEA_VENTA_QUIOSCO_PG.VE_OBTIENE_DATOS_GENERALES_PR;- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 'VE_CREA_LINEA_VENTA_QUIOSCO_PG.VE_OBTIENE_DATOS_GENERALES_PR', ssql, SQLCODE, lv_des_error);
   END ve_obtiene_datos_generales_pr;

   PROCEDURE ve_obtiene_subalm_pr (
      ev_codregion      IN              ge_regiones.cod_region%TYPE,
      ev_codprovincia   IN              ge_provincias.cod_provincia%TYPE,
      ev_codciudad      IN              ge_ciudades.cod_ciudad%TYPE,
      sv_codsubalm      OUT NOCOPY      ge_celdas.cod_subalm%TYPE,
      sv_codsubalm2     OUT NOCOPY      ge_celdas.cod_subalm2%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento)
                                                             /*
                                                             <Documentación
                                                               TipoDoc = "Procedimiento">
                                                                <Elemento
                                                                   Nombre = "VE_obtiene_subalm_PR"
                                                                   Lenguaje="PL/SQL"
                                                                   Fecha="30-08-2005"
                                                                   Versión="1.0"
                                                                   Diseñador="Roberto Pérez"
                                                                  Programador="Roberto Perez"
                                                                   Ambiente Desarrollo="BD">
                                                                   <Retorno>NA</Retorno>
                                                                   <Descripción>Obtener datos desde la tabla de datos generales</Descripción>
                                                                   <Parámetros>
                                                                      <Entrada>
                                                                         <param nom="EV_codregion"  Tipo="VARCHAR2">codigo de region</param>
                                                                         <param nom="EV_codprovincia"  Tipo="VARCHAR2">codigo de provincia</param>
                                                                         <param nom="EV_codciudad"  Tipo="VARCHAR2">codigo de ciudad</param>
                                                                    </Entrada>
                                                                <Salida>
                                                                         <param nom="SN_codsubalm"     Tipo="NUMBER">Código de subalimentador</param>
                                                                         <param nom="SN_codsubalm2"     Tipo="NUMBER">Código de subalimentador alternativo</param>
                                                                         <param nom="SN_cod_retorno"   Tipo="NUMBER">Codigo de Retorno</param>
                                                                         <param nom="SV_mens_retorno"  Tipo="VARCHAR2">Mensaje de Retorno</param>
                                                                         <param nom="SN_num_evento"    Tipo="NUMBER">Nro de evento</param>
                                                                      </Salida>
                                                                   </Parámetros>
                                                                </Elemento>
                                                             </Documentación>
                                                             */
   IS
      lv_des_error   ge_errores_pg.desevent;
      lv_sql         ge_errores_pg.vquery;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_sql :=
         'SELECT a.cod_subalm, a.cod_subalm2' || ' FROM      ge_celdas a, ge_ciudades b, ge_ciuceldas_td c' || ' WHERE  a.cod_celda = c.cod_celda' || ' AND b.cod_region = c.cod_region' || ' AND b.cod_provincia = c.cod_provincia'
         || ' AND b.cod_ciudad = c.cod_ciudad' || ' AND b.cod_region = ' || ev_codregion || ' AND b.cod_provincia = ' || ev_codprovincia || ' AND b.cod_ciudad = ' || ev_codciudad;

      SELECT a.cod_subalm, a.cod_subalm2
        INTO sv_codsubalm, sv_codsubalm2
        FROM ge_celdas a, ge_ciudades b, ge_ciuceldas_td c
       WHERE a.cod_celda = c.cod_celda AND b.cod_region = c.cod_region AND b.cod_provincia = c.cod_provincia AND b.cod_ciudad = c.cod_ciudad AND b.cod_region = ev_codregion AND b.cod_provincia = ev_codprovincia AND b.cod_ciudad = ev_codciudad;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno := 1;
         sv_mens_retorno := 'No se pudo recuperar datos.';

         lv_des_error := 'NO_DATA_FOUND:VE_CREA_LINEA_VENTA_QUIOSCO_PG.VE_obtiene_subalm_PR(' || ev_codregion || ',' || ev_codprovincia || ',' || ev_codciudad || '); ' || SQLERRM;
         sn_num_evento :=
                      ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 'VE_CREA_LINEA_VENTA_QUIOSCO_PG.VE_obtiene_subalm_PR(' || ev_codregion || ',' || ev_codprovincia || ',' || ev_codciudad || ')', lv_sql, SQLCODE, lv_des_error);
      WHEN TOO_MANY_ROWS THEN
         sn_cod_retorno := 10805;
         sv_mens_retorno := 'Error al obtener datos SubALM - Demasiados registros retornados';

         lv_des_error := 'TOO_MANY_ROWS:VE_CREA_LINEA_VENTA_QUIOSCO_PG.VE_obtiene_subalm_PR(' || ev_codregion || ',' || ev_codprovincia || ',' || ev_codciudad || '); ' || SQLERRM;
         sn_num_evento :=
                      ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 'VE_CREA_LINEA_VENTA_QUIOSCO_PG.VE_obtiene_subalm_PR(' || ev_codregion || ',' || ev_codprovincia || ',' || ev_codciudad || ')', lv_sql, SQLCODE, lv_des_error);
      WHEN OTHERS THEN
         sn_cod_retorno := 10806;
         sv_mens_retorno := 'Error al obtener datos SubALM';

         lv_des_error := 'OTHERS:VE_CREA_LINEA_VENTA_QUIOSCO_PG.VE_obtiene_subalm_PR(' || ev_codregion || ',' || ev_codprovincia || ',' || ev_codciudad || '); ' || SQLERRM;
         sn_num_evento :=
                      ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 'VE_CREA_LINEA_VENTA_QUIOSCO_PG.VE_obtiene_subalm_PR(' || ev_codregion || ',' || ev_codprovincia || ',' || ev_codciudad || ')', lv_sql, SQLCODE, lv_des_error);
   END ve_obtiene_subalm_pr;

   PROCEDURE ve_obtiene_subcuentas_pr (
      en_codcuenta      IN              ga_subcuentas.cod_cuenta%TYPE,
      sv_codsubcuenta   OUT NOCOPY      ga_subcuentas.cod_subcuenta%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*
      <Documentación
        TipoDoc = "Procedimiento">
         <Elemento
            Nombre = "VE_obtiene_subcuentas_PR"
            Lenguaje="PL/SQL"
            Fecha="15-03-2007"
            Versión="1.0"
            Diseñador="Héctor Hermosilla"
           Programador="Héctor Hermosilla"
            Ambiente Desarrollo="BD">
            <Retorno>NA</Retorno>
            <Descripción>Obtiene una subcuenta de una cuenta especifica</Descripción>
            <Parámetros>
              <Entrada>
                 <param nom="EN_codcuenta"  Tipo="NUMBER">Código de cuenta</param>
             </Entrada>
             <Salida>
                  <param nom="SV_codsubcuenta"  Tipo="VARCHAR2">Código de subcuenta</param>
                  <param nom="SN_cod_retorno"   Tipo="NUMBER">Codigo de Retorno</param>
                  <param nom="SV_mens_retorno"  Tipo="VARCHAR2">Mensaje de Retorno</param>
                  <param nom="SN_num_evento"    Tipo="NUMBER">Nro de evento</param>
               </Salida>
            </Parámetros>
         </Elemento>
      </Documentación>
      */
      lv_des_error   ge_errores_pg.desevent;
      lv_sql         ge_errores_pg.vquery;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_sql := 'SELECT subcuentas.cod_subcuenta' || ' FROM ga_subcuentas subcuentas' || ' WHERE subcuentas.cod_cuenta =' || en_codcuenta || ' AND ROWNUM <2';

      SELECT subcuentas.cod_subcuenta
        INTO sv_codsubcuenta
        FROM ga_subcuentas subcuentas
       WHERE subcuentas.cod_cuenta = en_codcuenta AND ROWNUM < 2;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno := 1;
         sv_mens_retorno := 'No se pudo recuperar datos.';

         lv_des_error := 'NO_DATA_FOUND:VE_CREA_LINEA_VENTA_QUIOSCO_PG.VE_obtiene_subcuentas_PR(' || en_codcuenta || '); ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 'VE_CREA_LINEA_VENTA_QUIOSCO_PG.VE_obtiene_subcuentas_PR(' || en_codcuenta || ')', lv_sql, SQLCODE, lv_des_error);
      WHEN TOO_MANY_ROWS THEN
         sn_cod_retorno := 10807;
         sv_mens_retorno := 'Error al obtener una subcuenta de la cuenta especificada - Demasiados registros retornados';

         lv_des_error := 'TOO_MANY_ROWS:VE_CREA_LINEA_VENTA_QUIOSCO_PG.VE_obtiene_subcuentas_PR(' || en_codcuenta || '); ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 'VE_CREA_LINEA_VENTA_QUIOSCO_PG.VE_obtiene_subcuentas_PR(' || en_codcuenta || ')', lv_sql, SQLCODE, lv_des_error);
      WHEN OTHERS THEN
         sn_cod_retorno := 10808;
         sv_mens_retorno := 'Error al obtener una subcuenta de la cuenta especificada';

         lv_des_error := 'OTHERS:VE_CREA_LINEA_VENTA_QUIOSCO_PG.VE_obtiene_subcuentas_PR(' || en_codcuenta || '); ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 'VE_CREA_LINEA_VENTA_QUIOSCO_PG.VE_obtiene_subcuentas_PR(' || en_codcuenta || ')', lv_sql, SQLCODE, lv_des_error);
   END ve_obtiene_subcuentas_pr;

   PROCEDURE ve_in_ga_abocel_pr (
      ev_num_abonado             IN              ga_abocel.num_abonado%TYPE,
      ev_num_celular             IN              ga_abocel.num_celular%TYPE,
      ev_cod_producto            IN              ga_abocel.cod_producto%TYPE,
      ev_cod_cliente             IN              ga_abocel.cod_cliente%TYPE,
      ev_cod_cuenta              IN              ga_abocel.cod_cuenta%TYPE,
      ev_cod_subcuenta           IN              ga_abocel.cod_subcuenta%TYPE,
      ev_cod_usuario             IN              ga_abocel.cod_usuario%TYPE,
      ev_cod_region              IN              ga_abocel.cod_region%TYPE,
      ev_cod_provincia           IN              ga_abocel.cod_provincia%TYPE,
      ev_cod_ciudad              IN              ga_abocel.cod_ciudad%TYPE,
      ev_cod_celda               IN              ga_abocel.cod_celda%TYPE,
      ev_cod_central             IN              ga_abocel.cod_central%TYPE,
      ev_cod_uso                 IN              ga_abocel.cod_uso%TYPE,
      ev_cod_situacion           IN              ga_abocel.cod_situacion%TYPE,
      ev_ind_procalta            IN              ga_abocel.ind_procalta%TYPE,
      ev_ind_procequi            IN              ga_abocel.ind_procequi%TYPE,
      ev_cod_vendedor            IN              ga_abocel.cod_vendedor%TYPE,
      ev_cod_vendedor_agente     IN              ga_abocel.cod_vendedor_agente%TYPE,
      ev_tip_plantarif           IN              ga_abocel.tip_plantarif%TYPE,
      ev_tip_terminal            IN              ga_abocel.tip_terminal%TYPE,
      ev_cod_plantarif           IN              ga_abocel.cod_plantarif%TYPE,
      ev_cod_cargobasico         IN              ga_abocel.cod_cargobasico%TYPE,
      ev_cod_planserv            IN              ga_abocel.cod_planserv%TYPE,
      ev_cod_limconsumo          IN              ga_abocel.cod_limconsumo%TYPE,
      ev_num_serie               IN              ga_abocel.num_serie%TYPE,
      ev_num_seriehex            IN              ga_abocel.num_seriehex%TYPE,
      ev_nom_usuarora            IN              ga_abocel.nom_usuarora%TYPE,
      ev_fec_alta                IN              VARCHAR2,
      ev_num_percontrato         IN              ga_abocel.num_percontrato%TYPE,
      ev_cod_estado              IN              ga_abocel.cod_estado%TYPE,
      ev_num_seriemec            IN              ga_abocel.num_seriemec%TYPE,
      ev_cod_holding             IN              ga_abocel.cod_holding%TYPE,
      ev_cod_empresa             IN              ga_abocel.cod_empresa%TYPE,
      ev_cod_grpserv             IN              ga_abocel.cod_grpserv%TYPE,
      ev_ind_supertel            IN              ga_abocel.ind_supertel%TYPE,
      ev_num_telefija            IN              ga_abocel.num_telefija%TYPE,
      ev_cod_opredfija           IN              ga_abocel.cod_opredfija%TYPE,
      ev_cod_carrier             IN              ga_abocel.cod_carrier%TYPE,
      ev_ind_prepago             IN              ga_abocel.ind_prepago%TYPE,
      ev_ind_plexsys             IN              ga_abocel.ind_plexsys%TYPE,
      ev_cod_central_plex        IN              ga_abocel.cod_central_plex%TYPE,
      ev_num_celular_plex        IN              ga_abocel.num_celular_plex%TYPE,
      ev_num_venta               IN              ga_abocel.num_venta%TYPE,
      ev_cod_modventa            IN              ga_abocel.cod_modventa%TYPE,
      ev_cod_tipcontrato         IN              ga_abocel.cod_tipcontrato%TYPE,
      ev_num_contrato            IN              ga_abocel.num_contrato%TYPE,
      ev_num_anexo               IN              ga_abocel.num_anexo%TYPE,
      ev_fec_cumplan             IN              VARCHAR2,
      ev_cod_credmor             IN              ga_abocel.cod_credmor%TYPE,
      ev_cod_credcon             IN              ga_abocel.cod_credcon%TYPE,
      ev_cod_ciclo               IN              ga_abocel.cod_ciclo%TYPE,
      ev_ind_factur              IN              ga_abocel.ind_factur%TYPE,
      ev_ind_suspen              IN              ga_abocel.ind_suspen%TYPE,
      ev_ind_rehabi              IN              ga_abocel.ind_rehabi%TYPE,
      ev_ind_insguias            IN              ga_abocel.ind_insguias%TYPE,
      ev_fec_fincontra           IN              VARCHAR2,
      ev_fec_recdocum            IN              VARCHAR2,
      ev_fec_cumplimen           IN              VARCHAR2,
      ev_fec_acepventa           IN              VARCHAR2,
      ev_fec_actcen              IN              VARCHAR2,
      ev_fec_baja                IN              VARCHAR2,
      ev_fec_bajacen             IN              VARCHAR2,
      ev_fec_ultmod              IN              VARCHAR2,
      ev_cod_causabaja           IN              ga_abocel.cod_causabaja%TYPE,
      ev_num_personal            IN              ga_abocel.num_personal%TYPE,
      ev_ind_seguro              IN              ga_abocel.ind_seguro%TYPE,
      ev_clase_servicio          IN              ga_abocel.clase_servicio%TYPE,
      ev_perfil_abonado          IN              ga_abocel.perfil_abonado%TYPE,
      ev_num_min                 IN              ga_abocel.num_min%TYPE,
      ev_cod_vendealer           IN              ga_abocel.cod_vendealer%TYPE,
      ev_ind_disp                IN              ga_abocel.ind_disp%TYPE,
      ev_cod_password            IN              ga_abocel.cod_password%TYPE,
      ev_ind_password            IN              ga_abocel.ind_password%TYPE,
      ev_cod_afinidad            IN              ga_abocel.cod_afinidad%TYPE,
      ev_fec_prorroga            IN              VARCHAR2,
      ev_ind_eqprestado          IN              ga_abocel.ind_eqprestado%TYPE,
      ev_flg_contdigi            IN              ga_abocel.flg_contdigi%TYPE,
      ev_fec_altantras           IN              VARCHAR2,
      ev_cod_indemnizacion       IN              ga_abocel.cod_indemnizacion%TYPE,
      ev_num_imei                IN              ga_abocel.num_imei%TYPE,
      ev_cod_tecnologia          IN              ga_abocel.cod_tecnologia%TYPE,
      ev_num_min_mdn             IN              ga_abocel.num_min_mdn%TYPE,
      ev_fec_activacion          IN              VARCHAR2,
      ev_ind_telefono            IN              ga_abocel.ind_telefono%TYPE,
      ev_cod_oficina_principal   IN              ga_abocel.cod_oficina_principal%TYPE,
      ev_cod_causa_venta         IN              ga_abocel.cod_causa_venta%TYPE,
      sn_cod_retorno             OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno            OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento              OUT NOCOPY      ge_errores_pg.evento)
                                                                      /*
                                                                      <Documentación
                                                                        TipoDoc = "Procedimiento">
                                                                         <Elemento
                                                                            Nombre = "VE_IN_ga_abocel_PR"
                                                                            Lenguaje="PL/SQL"
                                                                            Fecha="15-03-2007"
                                                                            Versión="1.0"
                                                                            Diseñador="Héctor Hermosilla"
                                                                           Programador="Héctor Hermosilla"
                                                                            Ambiente Desarrollo="BD">
                                                                            <Retorno>NA</Retorno>
                                                                            <Descripción>Obtiene una subcuenta de una cuenta especifica</Descripción>
                                                                            <Parámetros>
                                                                              <Entrada>
                                                                               <param nom="EV_num_abonado" Tipo="NUMBER">Numero de Abonado</param>
                                                                               <param nom="EV_num_celular" Tipo="NUMBER">Numero de celular</param>
                                                                               <param nom="EV_cod_producto" Tipo="NUMBER">codigo de producto</param>
                                                                               <param nom="EV_cod_cliente" Tipo="NUMBER">codigo cliente</param>
                                                                               <param nom="EV_cod_cuenta" Tipo="VARCHAR2">codigo cuenta</param>
                                                                               <param nom="EV_cod_subcuenta" Tipo="VARCHAR2">codigo subcuenta</param>
                                                                               <param nom="EV_cod_usuario" Tipo="NUMBER">codigo usuario</param>
                                                                               <param nom="EV_cod_region" Tipo="NUMBER">codigo region</param>
                                                                               <param nom="EV_cod_provincia" Tipo="NUMBER">codigo provincia</param>
                                                                               <param nom="EV_cod_ciudad" Tipo="VARCHAR2">codigo ciudad</param>
                                                                               <param nom="EV_cod_celda" Tipo="NUMBER">codigo celda</param>
                                                                               <param nom="EV_cod_central" Tipo="NUMBER">codigo central</param>
                                                                               <param nom="EV_cod_uso" Tipo="NUMBER">codigo uso</param>
                                                                               <param nom="EV_cod_situacion" Tipo="NUMBER">codigo situacion</param>
                                                                               <param nom="EV_ind_procalta" Tipo="NUMBER">Indicador procedencia alta</param>
                                                                               <param nom="EV_ind_procequi" Tipo="NUMBER">Indicador procedencia equipo</param>
                                                                               <param nom="EV_cod_vendedor" Tipo="NUMBER">codigo vendedor</param>
                                                                               <param nom="EV_cod_vendedor_agente" Tipo="NUMBER">codigo vendedor agente</param>
                                                                               <param nom="EV_tip_plantarif" Tipo="VARCHAR2">tipo plan tarifario</param>
                                                                               <param nom="EV_tip_terminal" Tipo="NUMBER">tipo terminal</param>
                                                                               <param nom="EV_cod_plantarif" Tipo="VARCHAR2">codigo plan tarifario</param>
                                                                               <param nom="EV_cod_cargobasico" Tipo="VARCHAR2">codigo cargo basico</param>
                                                                               <param nom="EV_cod_planserv" Tipo="VARCHAR2">codigo plan servicio</param>
                                                                               <param nom="EV_cod_limconsumo" Tipo="VARCHAR2">codigo limite consumo</param>
                                                                               <param nom="EV_num_serie" Tipo="VARCHAR2">numero de serie decimal</param>
                                                                               <param nom="EV_num_seriehex" Tipo="VARCHAR2">numero de serie hexadecimal</param>
                                                                               <param nom="EV_nom_usuarora" Tipo="VARCHAR2">nombre usuario</param>
                                                                               <param nom="EV_fec_alta" Tipo="VARCHAR2">fecha alta</param>
                                                                               <param nom="EV_num_percontrato" Tipo="NUMBER">numero de periodo de contrato</param>
                                                                               <param nom="EV_cod_estado" Tipo="NUMBER">codigo estado</param>
                                                                               <param nom="EV_num_seriemec" Tipo="NUMBER">numero serie mecanico</param>
                                                                               <param nom="EV_cod_holding" Tipo="NUMBER">codigo holding</param>
                                                                               <param nom="EV_cod_empresa" Tipo="NUMBER">codigo empresa</param>
                                                                               <param nom="EV_cod_grpserv" Tipo="NUMBER">codigo grupo servicio</param>
                                                                               <param nom="EV_ind_supertel" Tipo="NUMBER">indicativo modalidad supertelefono</param>
                                                                               <param nom="EV_num_telefija" Tipo="NUMBER">numero de telefonia fija</param>
                                                                               <param nom="EV_cod_opredfija" Tipo="NUMBER">codigo de operacion</param>
                                                                               <param nom="EV_cod_carrier" Tipo="NUMBER">codigo carrier</param>
                                                                               <param nom="EV_ind_prepago" Tipo="NUMBER">indicagtivo de prepago</param>
                                                                               <param nom="EV_ind_plexsys" Tipo="NUMBER">indicativo abonado zona plexsys</param>
                                                                               <param nom="EV_cod_central_plex" Tipo="NUMBER">codigo central plexsys</param>
                                                                               <param nom="EV_num_celular_plex" Tipo="NUMBER">numero celular plexsys</param>
                                                                               <param nom="EV_num_venta" Tipo="NUMBER">numero de venta</param>
                                                                               <param nom="EV_cod_modventa" Tipo="NUMBER">codigo modalidad venta</param>
                                                                               <param nom="EV_cod_tipcontrato" Tipo="NUMBER">codigo tipo contrato</param>
                                                                               <param nom="EV_num_contrato" Tipo="NUMBER">numero contrato</param>
                                                                               <param nom="EV_num_anexo" Tipo="NUMBER">numero anexo</param>
                                                                               <param nom="EV_fec_cumplan" Tipo="VARCHAR2">fecha posible cambio pplan tarifario</param>
                                                                               <param nom="EV_cod_credmor" Tipo="NUMBER">Código de Límite Crédito de Morosidad</param>
                                                                               <param nom="EV_cod_credcon" Tipo="NUMBER">Código de Límite Crédito de Consumo</param>
                                                                               <param nom="EV_cod_ciclo" Tipo="NUMBER">Código de Ciclo Facturación</param>
                                                                               <param nom="EV_ind_factur" Tipo="NUMBER">Indicativo de Facturable ; No (0), Si (1)</param>
                                                                               <param nom="EV_ind_suspen" Tipo="NUMBER">Indicativo de Suspendible ; No (0), Si (1)</param>
                                                                               <param nom="EV_ind_rehabi" Tipo="NUMBER">Indicativo de Rehabilitable ; No (0), Si (1)</param>
                                                                               <param nom="EV_ind_insguias" Tipo="NUMBER">Indicativo de Inserción en Guias ; No (0), Si (1)</param>
                                                                               <param nom="EV_fec_fincontra" Tipo="NUMBER">Fecha de Fin Contrato</param>
                                                                               <param nom="EV_fec_recdocum" Tipo="VARCHAR2">Fecha de Recepción Documentación</param>
                                                                               <param nom="EV_fec_cumplimen" Tipo="VARCHAR2">Fecha de Cumplimentación Datos</param>
                                                                               <param nom="EV_fec_acepventa" Tipo="VARCHAR2">Fecha de Aceptación Venta</param>
                                                                               <param nom="EV_fec_actcen" Tipo="VARCHAR2">Fecha de Activación en Central</param>
                                                                               <param nom="EV_fec_baja" Tipo="VARCHAR2">Fecha de Baja</param>
                                                                               <param nom="EV_fec_bajacen" Tipo="VARCHAR2">Fecha de Baja en Central</param>
                                                                               <param nom="EV_fec_ultmod" Tipo="VARCHAR2">Fecha de Última Modificación</param>
                                                                               <param nom="EV_cod_causabaja" Tipo="VARCHAR2">Código de Causa de Baja</param>
                                                                               <param nom="EV_num_personal" Tipo="NUMBER">Código de Bloqueo de Terminal</param>
                                                                               <param nom="EV_ind_seguro" Tipo="NUMBER">Indicativo de Seguro ; Si (0), No (1)</param>
                                                                               <param nom="EV_clase_servicio" Tipo="NUMBER">Matricula de Servicios contratados por el Abonado</param>
                                                                               <param nom="EV_perfil_abonado" Tipo="VARCHAR2">Matricula de Servicios Activos del Abonado</param>
                                                                               <param nom="EV_num_min" Tipo="VARCHAR2">Prefijo MIN</param>
                                                                               <param nom="EV_cod_vendealer" Tipo="NUMBER">codigo vendealer</param>
                                                                               <param nom="EV_ind_disp" Tipo="NUMBER">Indicativo de Disponibilidad 0:No disponible (STP) 1:Disponible</param>
                                                                               <param nom="EV_cod_password" Tipo="VARCHAR2">Password de acceso via Internet.</param>
                                                                               <param nom="EV_ind_password" Tipo="NUMBER">Indicador de validez de password: 0=valida | 1=invalida.</param>
                                                                               <param nom="EV_cod_afinidad" Tipo="NUMBER">Código de afinidad</param>
                                                                               <param nom="EV_fec_prorroga" Tipo="VARCHAR2">Fecha de Prorroga de Contrato</param>
                                                                               <param nom="EV_ind_eqprestado" Tipo="NUMBER">Indicador de equipo prestado</param>
                                                                               <param nom="EV_flg_contdigi" Tipo="NUMBER">Indica si el contrato esta digitalizado.</param>
                                                                               <param nom="EV_fec_altantras" Tipo="VARCHAR2">Indica la fecha de alta anterior, dado que se hizo un traspaso..</param>
                                                                               <param nom="EV_cod_indemnizacion" Tipo="NUMBER">codigo indemnizacion</param>
                                                                               <param nom="EV_num_imei" Tipo="VARCHAR2">Número Serie Terminal GSM</param>
                                                                               <param nom="EV_cod_tecnologia" Tipo="NUMBER">Código Tecnología</param>
                                                                               <param nom="EV_num_min_mdn" Tipo="VARCHAR2">MIN asociado al Número Celular (función logística).</param>
                                                                               <param nom="EV_fec_activacion" Tipo="VARCHAR2">fecha activacion</param>
                                                                               <param nom="EV_ind_telefono" Tipo="NUMBER">indicador telefono</param>
                                                                               <param nom="EV_cod_oficina_principal" Tipo="VARCHAR2">Código Oficina Principal</param>
                                                                               <param nom="EV_cod_causa_venta" Tipo="VARCHAR2">Código de Causa deVenta</param>
                                                                               <param nom="EV_cod_operacion" Tipo="VARCHAR2">Código de Operación</param>
																			   <param nom="EV_cod_prestacion" Tipo="VARCHAR2">Código de Prestación</param>
                                                                             </Entrada>
                                                                             <Salida>
                                                                                  <param nom="SN_cod_retorno"   Tipo="NUMBER">Codigo de Retorno</param>
                                                                                  <param nom="SV_mens_retorno"  Tipo="VARCHAR2">Mensaje de Retorno</param>
                                                                                  <param nom="SN_num_evento"    Tipo="NUMBER">Nro de evento</param>
                                                                               </Salida>
                                                                            </Parámetros>
                                                                         </Elemento>
                                                                      </Documentación>
                                                                      */
   IS
      lv_sql            ge_errores_pg.vquery;
      lv_des_error      ge_errores_pg.desevent;
      lv_sqlejecutarc   ge_errores_pg.vquery;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_sql :=
         'INSERT INTO ga_abocel (num_abonado, num_celular, cod_producto, cod_cliente, cod_cuenta, ' || 'cod_subcuenta, cod_usuario, cod_region, cod_provincia, cod_ciudad, ' || 'cod_celda, cod_central, cod_uso, cod_situacion, ind_procalta, '
         || 'ind_procequi, cod_vendedor, cod_vendedor_agente, tip_plantarif, ' || 'tip_terminal, cod_plantarif, cod_cargobasico, cod_planserv, cod_limconsumo, ' || 'num_serie, num_seriehex, nom_usuarora, fec_alta, num_percontrato, cod_estado, '
         || 'num_seriemec, cod_holding, cod_empresa, cod_grpserv, ind_supertel, num_telefija, ' || 'cod_opredfija, cod_carrier, ind_prepago, ind_plexsys, cod_central_plex, ' || 'num_celular_plex, num_venta, cod_modventa, cod_tipcontrato, num_contrato, '
         || 'num_anexo, fec_cumplan, cod_credmor, cod_credcon, cod_ciclo, ind_factur, ind_suspen, ' || 'ind_rehabi,ind_insguias, fec_fincontra, fec_recdocum, fec_cumplimen, fec_acepventa, '
         || 'fec_actcen, fec_baja, fec_bajacen, fec_ultmod, cod_causabaja, num_personal, ind_seguro, ' || 'clase_servicio, perfil_abonado, num_min, cod_vendealer, ind_disp, cod_password, '
         || 'ind_password, cod_afinidad, fec_prorroga, ind_eqprestado, flg_contdigi, fec_altantras, ' || 'cod_indemnizacion, num_imei, cod_tecnologia, num_min_mdn, fec_activacion, ' || 'cod_oficina_principal, cod_causa_venta)'
         || ' VALUES (''' || ev_num_abonado || ''',''' || ev_num_celular || ''',''' || ev_cod_producto || ''',''' || ev_cod_cliente || ''',''' || ev_cod_cuenta || ''',''' || ev_cod_subcuenta || ''',''' || ev_cod_usuario || ''',''' || ev_cod_region
         || ''',''' || ev_cod_provincia || ''',''' || ev_cod_ciudad || ''',''' || ev_cod_celda || ''',''' || ev_cod_central || ''',''' || ev_cod_uso || ''',''' || ev_cod_situacion || ''',''' || ev_ind_procalta || ''',''' || ev_ind_procequi || ''','''
         || ev_cod_vendedor || ''',''' || ev_cod_vendedor_agente || ''',''' || ev_tip_plantarif || ''',''' || ev_tip_terminal || ''',''' || ev_cod_plantarif || ''',''' || ev_cod_cargobasico || ''',''' || ev_cod_planserv || ''',''' || ev_cod_limconsumo
         || ''',''' || ev_num_serie || ''',''' || ev_num_seriehex || ''',''' || ev_nom_usuarora || ''',TO_DATE(''' || ev_fec_alta || ''',''' || 'DD-MM-YYYY HH24:MI:SS' || '''),''' || ev_num_percontrato || ''',''' || ev_cod_estado || ''','''
         || ev_num_seriemec || ''',''' || ev_cod_holding || ''',''' || ev_cod_empresa || ''',''' || ev_cod_grpserv || ''',''' || ev_ind_supertel || ''',''' || ev_num_telefija || ''',''' || ev_cod_opredfija || ''',''' || ev_cod_carrier || ''','''
         || ev_ind_prepago || ''',''' || ev_ind_plexsys || ''',''' || NULL || ''',''' || NULL || ''',''' || ev_num_venta || ''',''' || ev_cod_modventa || ''',''' || ev_cod_tipcontrato || ''',''' || ev_num_contrato || ''',''' || ev_num_anexo || ''','
         || 'TO_DATE(''' || ev_fec_cumplan || ''',''' || 'DD-MM-YYYY HH24:MI:SS' || '''),''' || ev_cod_credmor || ''',''' || ev_cod_credcon || ''',''' || ev_cod_ciclo || ''',''' || ev_ind_factur || ''',''' || ev_ind_suspen || ''',''' || ev_ind_rehabi
         || ''',''' || ev_ind_insguias || ''',' || ' TO_DATE(''' || ev_fec_fincontra || ''',''' || 'DD-MM-YYYY HH24:MI:SS' || '''), TO_DATE( ''' || ev_fec_recdocum || ''',''' || 'DD-MM-YYYY HH24:MI:SS' || '''),' || ' TO_DATE(''' || ev_fec_cumplimen
         || ''',''' || 'DD-MM-YYYY HH24:MI:SS' || '''), TO_DATE(''' || ev_fec_acepventa || ''',''' || 'DD-MM-YYYY HH24:MI:SS' || '''),' || ' TO_DATE(''' || ev_fec_actcen || ''',''' || 'DD-MM-YYYY HH24:MI:SS' || '''), TO_DATE(''' || ev_fec_baja || ''','''
         || 'DD-MM-YYYY HH24:MI:SS' || '''),' || ' TO_DATE(''' || ev_fec_bajacen || ''',''' || 'DD-MM-YYYY HH24:MI:SS' || '''), TO_DATE(''' || ev_fec_ultmod || ''',''' || 'DD-MM-YYYY HH24:MI:SS' || '''),''' || ev_cod_causabaja || ''','''
         || ev_num_personal || ''',''' || ev_ind_seguro || ''',''' || ev_clase_servicio || ''',''' || ev_perfil_abonado || ''',''' || ev_num_min || ''',''' || ev_cod_vendealer || ''',''' || ev_ind_disp || ''',''' || ev_cod_password || ''','''
         || ev_ind_password || ''',''' || ev_cod_afinidad || ''', TO_DATE(''' || ev_fec_prorroga || ''',''' || 'DD-MM-YYYY HH24:MI:SS' || '''),''' || ev_ind_eqprestado || ''',''' || ev_flg_contdigi || ''',TO_DATE(''' || ev_fec_altantras || ''','''
         || 'DD-MM-YYYY HH24:MI:SS' || '''),''' || ev_cod_indemnizacion || ''',''' || ev_num_imei || ''',''' || ev_cod_tecnologia || ''',''' || ev_num_min_mdn || ''',    TO_DATE(''' || ev_fec_activacion || ''',''' || 'DD-MM-YYYY HH24:MI:SS' || '''),'
         || ev_cod_oficina_principal || ''',''' || ev_cod_causa_venta || ''')';
      lv_sqlejecutarc := lv_sql;

      INSERT INTO ga_abocel
                  (num_abonado, num_celular, cod_producto, cod_cliente, cod_cuenta, cod_subcuenta, cod_usuario, cod_region, cod_provincia, cod_ciudad, cod_celda, cod_central, cod_uso, cod_situacion,
                   ind_procalta, ind_procequi, cod_vendedor, cod_vendedor_agente, tip_plantarif, tip_terminal, cod_plantarif, cod_cargobasico, cod_planserv, cod_limconsumo, num_serie, num_seriehex, nom_usuarora,
                   fec_alta, num_percontrato, cod_estado, num_seriemec, cod_holding, cod_empresa, cod_grpserv, ind_supertel, num_telefija, cod_opredfija, cod_carrier, ind_prepago,
                   ind_plexsys, cod_central_plex, num_celular_plex, num_venta, cod_modventa, cod_tipcontrato, num_contrato, num_anexo, fec_cumplan, cod_credmor, cod_credcon, cod_ciclo, ind_factur,
                   ind_suspen, ind_rehabi, ind_insguias, fec_fincontra, fec_recdocum, fec_cumplimen,
                   fec_acepventa, fec_actcen, fec_baja, fec_bajacen,
                   fec_ultmod, cod_causabaja, num_personal, ind_seguro, clase_servicio, perfil_abonado, num_min, cod_vendealer, ind_disp, cod_password, ind_password, cod_afinidad,
                   fec_prorroga, ind_eqprestado, flg_contdigi, fec_altantras, cod_indemnizacion, num_imei, cod_tecnologia, num_min_mdn,
                   fec_activacion, cod_oficina_principal, cod_causa_venta)
      VALUES      (ev_num_abonado, ev_num_celular, ev_cod_producto, ev_cod_cliente, ev_cod_cuenta, ev_cod_subcuenta, ev_cod_usuario, ev_cod_region, ev_cod_provincia, ev_cod_ciudad, ev_cod_celda, ev_cod_central, ev_cod_uso, ev_cod_situacion,
                   ev_ind_procalta, ev_ind_procequi, ev_cod_vendedor, ev_cod_vendedor_agente, ev_tip_plantarif, ev_tip_terminal, ev_cod_plantarif, ev_cod_cargobasico, ev_cod_planserv, ev_cod_limconsumo, ev_num_serie, ev_num_seriehex, ev_nom_usuarora,
                   TO_DATE (ev_fec_alta, 'DD-MM-YYYY HH24:MI:SS'), ev_num_percontrato, ev_cod_estado, ev_num_seriemec, ev_cod_holding, ev_cod_empresa, ev_cod_grpserv, ev_ind_supertel, ev_num_telefija, ev_cod_opredfija, ev_cod_carrier, ev_ind_prepago,
                   ev_ind_plexsys, NULL, NULL, ev_num_venta, ev_cod_modventa, ev_cod_tipcontrato, ev_num_contrato, ev_num_anexo, TO_DATE (ev_fec_cumplan, 'DD-MM-YYYY HH24:MI:SS'), ev_cod_credmor, ev_cod_credcon, ev_cod_ciclo, ev_ind_factur,
                   ev_ind_suspen, ev_ind_rehabi, ev_ind_insguias, TO_DATE (ev_fec_fincontra, 'DD-MM-YYYY HH24:MI:SS'), TO_DATE (ev_fec_recdocum, 'DD-MM-YYYY HH24:MI:SS'), TO_DATE (ev_fec_cumplimen, 'DD-MM-YYYY HH24:MI:SS'),
                   TO_DATE (ev_fec_acepventa, 'DD-MM-YYYY HH24:MI:SS'), TO_DATE (ev_fec_actcen, 'DD-MM-YYYY HH24:MI:SS'), TO_DATE (ev_fec_baja, 'DD-MM-YYYY HH24:MI:SS'), TO_DATE (ev_fec_bajacen, 'DD-MM-YYYY HH24:MI:SS'),
                   TO_DATE (ev_fec_ultmod, 'DD-MM-YYYY HH24:MI:SS'), ev_cod_causabaja, ev_num_personal, ev_ind_seguro, ev_clase_servicio, ev_perfil_abonado, ev_num_min, ev_cod_vendealer, ev_ind_disp, ev_cod_password, ev_ind_password, ev_cod_afinidad,
                   TO_DATE (ev_fec_prorroga, 'DD-MM-YYYY HH24:MI:SS'), ev_ind_eqprestado, ev_flg_contdigi, TO_DATE (ev_fec_altantras, 'DD-MM-YYYY HH24:MI:SS'), ev_cod_indemnizacion, ev_num_imei, ev_cod_tecnologia, ev_num_min_mdn,
                   TO_DATE (ev_fec_activacion, 'DD-MM-YYYY HH24:MI:SS'), ev_cod_oficina_principal, ev_cod_causa_venta);
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno := 10809;
         sv_mens_retorno := 'Error al ingresar abonado';

         lv_des_error := 'OTHERS:VE_CREA_LINEA_VENTA_QUIOSCO_PG.VE_IN_ga_abocel_PR(' || ev_num_abonado || '); ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 'VE_CREA_LINEA_VENTA_QUIOSCO_PG.VE_IN_ga_abocel_PR(' || ev_num_abonado || ')', lv_sql, SQLCODE, lv_des_error);
   END ve_in_ga_abocel_pr;

   PROCEDURE ve_obtiene_datos_contrato_pr (
      ev_codproducto      IN              ga_tipcontrato.cod_producto%TYPE,
      ev_codtipcontrato   IN              ga_tipcontrato.cod_tipcontrato%TYPE,
      sn_indcomodato      OUT NOCOPY      ga_tipcontrato.ind_comodato%TYPE,
      sn_cod_retorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento) IS
      /*
      <Documentación
        TipoDoc = "Procedimiento">
         <Elemento
            Nombre = "VE_obtiene_datos_contrato_PR"
            Lenguaje="PL/SQL"
            Fecha="30-08-2005"
            Versión="1.0"
            Diseñador="Roberto Pérez"
           Programador="Roberto Perez"
            Ambiente Desarrollo="BD">
            <Retorno>NA</Retorno>
            <Descripción>Obtener datos de contratos</Descripción>
            <Parámetros>
               <Entrada>
                  <param nom="EV_codproducto"  Tipo="VARCHAR2">codigo de producto</param>
                  <param nom="EV_codtipcontrato"  Tipo="VARCHAR2">codigo de tipo de contrato</param>
             </Entrada>
         <Salida>
                  <param nom="SN_indcomodato"   Tipo="NUMBER">Contrato comodato si o no</param>
                  <param nom="SN_cod_retorno"   Tipo="NUMBER">Codigo de Retorno</param>
                  <param nom="SV_mens_retorno"  Tipo="VARCHAR2">Mensaje de Retorno</param>
                  <param nom="SN_num_evento"    Tipo="NUMBER">Nro de evento</param>
               </Salida>
            </Parámetros>
         </Elemento>
      </Documentación>
      */
      lv_sql         ge_errores_pg.vquery;
      lv_des_error   ge_errores_pg.desevent;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_sql := 'SELECT ind_comodato FROM ga_tipcontrato' || ' WHERE  SYSDATE BETWEEN fec_desde AND NVL(fec_hasta, SYSDATE)' || ' AND cod_producto =' || ev_codproducto || ' AND cod_tipcontrato =' || ev_codtipcontrato;

      SELECT ind_comodato
        INTO sn_indcomodato
        FROM ga_tipcontrato
       WHERE SYSDATE BETWEEN fec_desde AND NVL (fec_hasta, SYSDATE) AND cod_producto = ev_codproducto AND cod_tipcontrato = ev_codtipcontrato;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno := 1;
         sv_mens_retorno := 'No se pudo recuperar datos.';

         lv_des_error := 'NO_DATA_FOUND:VE_CREA_LINEA_VENTA_QUIOSCO_PG.VE_obtiene_datos_contrato_PR(' || ev_codproducto || ',' || ev_codtipcontrato || '); ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 'VE_CREA_LINEA_VENTA_QUIOSCO_PG.VE_obtiene_datos_contrato_PR(' || ev_codproducto || ',' || ev_codtipcontrato || ')', lv_sql, SQLCODE, lv_des_error);
      WHEN OTHERS THEN
         sn_cod_retorno := 10810;
         sv_mens_retorno := 'Error al obtener datos de contrato';

         lv_des_error := 'OTHERS:VE_CREA_LINEA_VENTA_QUIOSCO_PG.VE_obtiene_datos_contrato_PR(' || ev_codproducto || ',' || ev_codtipcontrato || '); ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 'VE_CREA_LINEA_VENTA_QUIOSCO_PG.VE_obtiene_datos_contrato_PR(' || ev_codproducto || ',' || ev_codtipcontrato || ')', lv_sql, SQLCODE, lv_des_error);
   END ve_obtiene_datos_contrato_pr;

   PROCEDURE ve_obtiene_planserv_pr (
      ev_codproducto     IN              ga_planserv.cod_producto%TYPE,
      ev_codtecnologia   IN              ga_plantecplserv.cod_tecnologia%TYPE,
      ev_codplantarif    IN              ga_plantecplserv.cod_plantarif%TYPE,
      sv_codplanserv     OUT NOCOPY      ga_planserv.cod_planserv%TYPE,
      sn_cod_retorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento) IS
      /*
      <Documentación
        TipoDoc = "Procedimiento">
         <Elemento
            Nombre = "VE_obtiene_planserv_PR"
            Lenguaje="PL/SQL"
            Fecha="15-03-2007"
            Versión="1.0"
            Diseñador="Héctor Hermosilla"
           Programador="Héctor Hermosilla"
            Ambiente Desarrollo="BD">
            <Retorno>NA</Retorno>
            <Descripción>Obtiene plan de servicio de una cuenta especifica</Descripción>
            <Parámetros>
              <Entrada>
                 <param nom="EN_codproducto"  Tipo="NUMBER">Código de producto</param>
                 <param nom="EV_codtecnologia"  Tipo="VARCHAR2">Código de tecnologia</param>
                 <param nom="EV_codplantarif"  Tipo="VARCHAR2">Código de plan tarifario</param>
             </Entrada>
             <Salida>
                  <param nom="SV_codplanserv"  Tipo="VARCHAR2">Código de plan de servicio</param>
                  <param nom="SN_cod_retorno"   Tipo="NUMBER">Codigo de Retorno</param>
                  <param nom="SV_mens_retorno"  Tipo="VARCHAR2">Mensaje de Retorno</param>
                  <param nom="SN_num_evento"    Tipo="NUMBER">Nro de evento</param>
               </Salida>
            </Parámetros>
         </Elemento>
      </Documentación>
      */
      lv_sql         ge_errores_pg.vquery;
      lv_des_error   ge_errores_pg.desevent;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_sql :=
         'SELECT a.cod_planserv FROM ga_planserv a' || ' WHERE     SYSDATE BETWEEN a.fec_desde' || ' AND NVL(a.fec_hasta, SYSDATE)' || ' AND a.cod_producto =' || ev_codproducto || ' AND a.cod_planserv IN' || ' (SELECT b.cod_planserv'
         || ' FROM ga_plantecplserv b' || ' WHERE b.cod_tecnologia = ' || ev_codtecnologia || ' AND b.cod_plantarif =' || ev_codplantarif || ')';

      SELECT a.cod_planserv
        INTO sv_codplanserv
        FROM ga_planserv a
       WHERE SYSDATE BETWEEN a.fec_desde AND NVL (a.fec_hasta, SYSDATE) AND a.cod_producto = ev_codproducto AND a.cod_planserv IN (SELECT b.cod_planserv
                                                                                                                                     FROM ga_plantecplserv b
                                                                                                                                    WHERE b.cod_tecnologia = ev_codtecnologia AND b.cod_plantarif = ev_codplantarif);
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno := 1;
         sv_mens_retorno := 'No se pudo recuperar datos.';

         lv_des_error := 'NO_DATA_FOUND:VE_CREA_LINEA_VENTA_QUIOSCO_PG.VE_obtiene_planserv_PR(' || ev_codproducto || ',' || ev_codtecnologia || ',' || ev_codplantarif || '); ' || SQLERRM;
         sn_num_evento :=
              ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 'VE_CREA_LINEA_VENTA_QUIOSCO_PG.VE_obtiene_planserv_PR(' || ev_codproducto || ',' || ev_codtecnologia || ',' || ev_codplantarif || ')', lv_sql, SQLCODE, lv_des_error);
      WHEN OTHERS THEN
         sn_cod_retorno := 10811;
         sv_mens_retorno :='Error al obtener plan de servicio de la cuenta especificada';

         lv_des_error := 'OTHERS:VE_CREA_LINEA_VENTA_QUIOSCO_PG.VE_obtiene_planserv_PR(' || ev_codproducto || ',' || ev_codtecnologia || ',' || ev_codplantarif || '); ' || SQLERRM;
         sn_num_evento :=
              ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 'VE_CREA_LINEA_VENTA_QUIOSCO_PG.VE_obtiene_planserv_PR(' || ev_codproducto || ',' || ev_codtecnologia || ',' || ev_codplantarif || ')', lv_sql, SQLCODE, lv_des_error);
   END ve_obtiene_planserv_pr;

   PROCEDURE ve_in_ga_equipaboser_pr (
      en_numabonado       IN              ga_equipaboser.num_abonado%TYPE,
      ev_num_serie        IN              ga_equipaboser.num_serie%TYPE,
      en_cod_producto     IN              ga_equipaboser.cod_producto%TYPE,
      ev_ind_procequi     IN              ga_equipaboser.ind_procequi%TYPE,
      ev_fec_alta         IN              VARCHAR2,
      ev_ind_propiedad    IN              ga_equipaboser.ind_propiedad%TYPE,
      en_cod_bodega       IN              ga_equipaboser.cod_bodega%TYPE,
      en_tipstock         IN              ga_equipaboser.tip_stock%TYPE,
      en_codarticulo      IN              ga_equipaboser.cod_articulo%TYPE,
      ev_indequiacc       IN              ga_equipaboser.ind_equiacc%TYPE,
      en_cod_modventa     IN              ga_equipaboser.cod_modventa%TYPE,
      ev_tip_terminal     IN              ga_equipaboser.tip_terminal%TYPE,
      en_coduso           IN              ga_equipaboser.cod_uso%TYPE,
      ev_cod_cuota        IN              ga_equipaboser.cod_cuota%TYPE,
      en_cod_estado       IN              ga_equipaboser.cod_estado%TYPE,
      en_capcode          IN              ga_equipaboser.cap_code%TYPE,
      ev_cod_protocolo    IN              ga_equipaboser.cod_protocolo%TYPE,
      en_num_velocidad    IN              ga_equipaboser.num_velocidad%TYPE,
      en_cod_frecuencia   IN              ga_equipaboser.cod_frecuencia%TYPE,
      en_cod_version      IN              ga_equipaboser.cod_version%TYPE,
      ev_num_seriemec     IN              ga_equipaboser.num_seriemec%TYPE,
      ev_des_equipo       IN              ga_equipaboser.des_equipo%TYPE,
      en_cod_paquete      IN              ga_equipaboser.cod_paquete%TYPE,
      en_num_movimiento   IN              ga_equipaboser.num_movimiento%TYPE,
      ev_cod_causa        IN              ga_equipaboser.cod_causa%TYPE,
      ev_ind_eqprestado   IN              ga_equipaboser.ind_eqprestado%TYPE,
      ev_num_imei         IN              ga_equipaboser.num_imei%TYPE,
      ev_cod_tecnologia   IN              ga_equipaboser.cod_tecnologia%TYPE,
      sn_cod_retorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "VE_IN_GA_EQUIPABOSER_PR"
      Lenguaje="PL/SQL"
      Fecha="02-09-2005"
      Versión="1.0"
      Diseñador="Roberto Perez"
     Programador="Roberto Perez"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Insertar en Tabla Equipos Seriados de Abonados de Productos</Descripción>
      <Parámetros>
         <Entrada>
              <param nom="EN_numabonado"     Tipo="NUMBER">Nro de Abonado</param>
              <param nom="EV_num_serie"      Tipo="VARCHAR2" >Nro de serie</param>
              <param nom="EN_cod_producto"   Tipo="NUMBER" >Codigo del producto</param>
              <param nom="EV_ind_procequi"   Tipo="VARCHAR2" >Indicador de procedencia del equipo</param>
              <param nom="EV_ind_propiedad"  Tipo="VARCHAR2" >Indicador de propiedad </param>
              <param nom="EN_cod_bodega"     Tipo="NUMBER" >Codigo de bodega</param>
              <param nom="EN_tipstock"       Tipo="NUMBER" >Tipo del stock del almacen</param>
              <param nom="EN_codarticulo"    Tipo="NUMBER" >Codigo articulo</param>
              <param nom="EV_indequiacc"     Tipo="VARCHAR2" >Indicativo equipo/accesorio</param>
              <param nom="EN_cod_modventa"   Tipo="NUMBER" >Codigo modalidad de venta</param>
              <param nom="EV_tip_terminal"   Tipo="VARCHAR2" >Tipo de terminal</param>
              <param nom="EN_coduso"         Tipo="NUMBER" >Codigo de uso</param>
              <param nom="EV_cod_cuota"      Tipo="VARCHAR2" >Codigo de la cuota</param>
              <param nom="EN_cod_estado"     Tipo="NUMBER" >Estado del equipo</param>
              <param nom="EN_capcode"        Tipo="NUMBER" >Codigo cap code beeper</param>
              <param nom="EV_cod_protocolo"  Tipo="VARCHAR2" >Protocolo del equipo</param>
              <param nom="EN_num_velocidad"  Tipo="NUMBER" >Velocidad </param>
              <param nom="EN_cod_frecuencia" Tipo="NUMBER" >Codigo de frecuencia</param>
              <param nom="EN_cod_version"    Tipo="NUMBER" >Codigo de version</param>
              <param nom="EV_num_seriemec"   Tipo="VARCHAR2" >Serie mecanica del equipo</param>
              <param nom="EV_des_equipo"     Tipo="VARCHAR2" >Propiedad del equipo</param>
              <param nom="EN_cod_paquete"    Tipo="NUMBER" >Codigo del paquete</param>
              <param nom="EN_num_movimiento" Tipo="NUMBER" >Nro de movimiento de stock</param>
              <param nom="EV_cod_causa"      Tipo="VARCHAR2" >Codigo causa cambio de equipo</param>
              <param nom="EV_ind_eqprestado" Tipo="VARCHAR2" >Indicador de equipo en prestamo</param>
              <param nom="EV_num_imei"       Tipo="VARCHAR2" >Nro de terminal GSM</param>
              <param nom="EV_cod_tecnologia" Tipo="VARCHAR2" >Codigo de tecnologia</param>
              <param nom="EN_imp_cargo"      Tipo="NUMBER" >Cargo</param>
              <param nom="EV_tip_dto"       Tipo="VARCHAR2" >Tipo dto</param>
              <param nom="EV_val_dto"       Tipo="VARCHAR2" >Valor dto</param>
         </Entrada>
        </Entrada>
        <Salida>
            <param nom="SN_cod_retorno"    Tipo="NUMBER">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"   Tipo="VARCHAR2">Mensaje de Retorno</param>
            <param nom="SN_num_evento"    Tipo="NUMBER">Nro de evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
   IS
      ssql              ge_errores_pg.vquery;
      lv_des_error      ge_errores_pg.desevent;
      lv_sqlejecutarc   ge_errores_pg.vquery;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      ssql :=
         'INSERT INTO ga_equipaboser (num_abonado, num_serie, cod_producto, ind_procequi, fec_alta, ind_propiedad,' || ' cod_bodega, tip_stock, cod_articulo, ind_equiacc, cod_modventa, tip_terminal, cod_uso, cod_cuota,'
         || ' cod_estado, cap_code, cod_protocolo, num_velocidad, cod_frecuencia, cod_version, num_seriemec,' || ' des_equipo, cod_paquete, num_movimiento, cod_causa, ind_eqprestado, num_imei, cod_tecnologia,' || ' imp_cargo, tip_dto, val_dto) VALUES ('
         || en_numabonado || ',''' || ev_num_serie || ''',' || en_cod_producto || ',' || ev_ind_procequi || ', TO_DATE(''' || ev_fec_alta || ''',''' || 'DD-MM-YYYY HH24:MI:SS' || '''), ''' || ev_ind_propiedad || ''',' || en_cod_bodega || ','
         || en_tipstock || ',' || en_codarticulo || ',''' || ev_indequiacc || ''',' || en_cod_modventa || ',''' || ev_tip_terminal || ''',' || en_coduso || ',''' || ev_cod_cuota || ''',' || en_cod_estado || ',' || en_capcode || ',''' || ev_cod_protocolo
         || ''',' || en_num_velocidad || ',' || en_cod_frecuencia || ',' || en_cod_version || ',''' || ev_num_seriemec || ''',''' || ev_des_equipo || ''',' || en_cod_paquete || ',' || en_num_movimiento || ',''' || ev_cod_causa || ''','''
         || ev_ind_eqprestado || ''',''' || ev_num_imei || ''',''' || ev_cod_tecnologia || ''')';
      lv_sqlejecutarc := ssql;

      INSERT INTO ga_equipaboser
                  (num_abonado, num_serie, cod_producto, ind_procequi, fec_alta, ind_propiedad, cod_bodega, tip_stock, cod_articulo, ind_equiacc, cod_modventa, tip_terminal, cod_uso,
                   cod_cuota, cod_estado, cap_code, cod_protocolo, num_velocidad, cod_frecuencia, cod_version, num_seriemec, des_equipo, cod_paquete, num_movimiento, cod_causa, ind_eqprestado, num_imei,
                   cod_tecnologia)
      VALUES      (en_numabonado, ev_num_serie, en_cod_producto, ev_ind_procequi, TO_DATE (ev_fec_alta, 'DD-MM-YYYY HH24:MI:SS'), ev_ind_propiedad, en_cod_bodega, en_tipstock, en_codarticulo, ev_indequiacc, en_cod_modventa, ev_tip_terminal, en_coduso,
                   ev_cod_cuota, en_cod_estado, en_capcode, ev_cod_protocolo, en_num_velocidad, en_cod_frecuencia, en_cod_version, ev_num_seriemec, ev_des_equipo, en_cod_paquete, en_num_movimiento, ev_cod_causa, ev_ind_eqprestado, ev_num_imei,
                   ev_cod_tecnologia);
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno := 10812;
         sv_mens_retorno := 'Error al insertar en Tabla Equipos Seriados de Abonados de Productos';

         lv_des_error := 'OTHERS:VE_CREA_LINEA_VENTA_QUIOSCO_PG.VE_IN_GA_EQUIPABOSER_PR(' || en_numabonado || ',' || ev_num_serie || ',' || ev_num_imei || ');- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 'VE_CREA_LINEA_VENTA_QUIOSCO_PG.VE_IN_GA_EQUIPABOSER_PR', ssql, SQLCODE, lv_des_error);
   END ve_in_ga_equipaboser_pr;

--------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------
   PROCEDURE ve_upd_ga_equipaboser_pr (
      en_numabonado     IN              ga_equipaboser.num_abonado%TYPE,
      ev_num_serie      IN              ga_equipaboser.num_serie%TYPE,
      ev_num_imei       IN              ga_equipaboser.num_imei%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento)
/*
      <Documentación
        TipoDoc = "Procedimiento">
         <Elemento
            Nombre = "VE_UPD_GA_EQUIPABOSER_PR"
            Lenguaje="PL/SQL"
            Fecha="02-09-2005"
            Versión="1.0"
            Diseñador="Roberto Perez"
           Programador="Roberto Perez"
            Ambiente Desarrollo="BD">
            <Retorno>NA</Retorno>
            <Descripción>Modificar Tabla Equipos Seriados de Abonados de Productos</Descripción>
            <Parámetros>
               <Entrada>
               <param nom="EN_numabonado" Tipo="NUMBER">Nro del abonado</param>
               <param nom="EV_num_serie" Tipo="VARCHAR2">Numero de serie</param>
               <param nom="EV_num_imei" Tipo="VARCHAR2">Numero de la simcard</param>
               </Entrada>
              </Entrada>
              <Salida>
                  <param nom="SN_cod_retorno"    Tipo="NUMBER">Codigo de Retorno</param>
                  <param nom="SV_mens_retorno"   Tipo="VARCHAR2">Mensaje de Retorno</param>
                  <param nom="SN_num_evento"    Tipo="NUMBER">Nro de evento</param>
               </Salida>
            </Parámetros>
         </Elemento>
      </Documentación>
*/
   AS
      lv_des_error   ge_errores_pg.desevent;
      ssql           ge_errores_pg.vquery;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      ssql := 'UPDATE ga_equipaboser';
      ssql := ssql || ' SET num_imei=' || ev_num_imei;
      ssql := ssql || ' WHERE  num_abonado=' || en_numabonado;
      ssql := ssql || ' AND num_serie=' || ev_num_serie;

      UPDATE ga_equipaboser
         SET num_imei = ev_num_imei
       WHERE num_abonado = en_numabonado AND num_serie = ev_num_serie;
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno := 10813;
         sv_mens_retorno := 'Error al modificar Tabla Equipos Seriados de Abonados de Productos';

         lv_des_error := 'OTHERS:VE_CREA_LINEA_VENTA_QUIOSCO_PG.VE_UPD_GA_EQUIPABOSER_PR(' || en_numabonado || ',' || ev_num_serie || ',' || ev_num_imei || ');- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 'VE_CREA_LINEA_VENTA_QUIOSCO_PG.VE_UPD_GA_EQUIPABOSER_PR', ssql, SQLCODE, lv_des_error);
   END ve_upd_ga_equipaboser_pr;

------------------------------------------------------------
/*Se comenta el procedimiento ve_marca_abonado_port_pr por pertenecer a portabilidad*/  
/*  
 PROCEDURE ve_marca_abonado_port_pr (
      ev_num_celular    IN              ga_abocel.num_celular%TYPE,
      ev_perfil         IN              VARCHAR2,
      sn_cod_retorno    IN OUT NOCOPY   ge_errores_pg.coderror,
      sv_mens_retorno   IN OUT NOCOPY   ge_errores_pg.msgerror,
      sn_num_evento     IN OUT NOCOPY   ge_errores_pg.evento)
      */
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "VE_MARCA_ABONADO_PORT_PR"
      Lenguaje="PL/SQL"
      Fecha="02-09-2005"
      Versión="1.0"
      Diseñador=""
     Programador=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Actualizar tabla de abonado segun la opcion de marca</Descripción>
      <Parámetros>
         <Entrada>
         <param nom="EV_num_celular" Tipo="NUMERICO">Nro de celular</param>
         <param nom="EV_perfil" Tipo="CARACTER">Perfil, corresponde  a prepago o pospago</param>
         <param nom="EV_opcion_marca" Tipo="CARACTER">Opcion demraca, marcar o desmarcar</param>
         </Entrada>
        </Entrada>
        <Salida>
            <param nom="SN_cod_retorno"    Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"   Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Nro de evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
/*
   AS
      lv_des_error      ge_errores_pg.desevent;
      ssql              ge_errores_pg.vquery;
      lv_ind_portado    NUMBER;
      lv_opcion_marca   NUMBER;
      le_exception      EXCEPTION;
      lv_situacionabo   VARCHAR2 (3)                      := 'AAA';
      lv_situacionbap   VARCHAR2 (3)                      := 'BAP';
      ln_abonado        icc_movimiento.num_abonado%TYPE;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;

      IF ev_perfil = 1 OR ev_perfil = 2 OR ev_perfil = 3 THEN
         IF ev_perfil = 2 OR ev_perfil = 3 THEN
            ssql := 'SELECT ind_portado  , num_abonado';
            ssql := ssql || 'FROM   ga_abocel';
            ssql := ssql || ' WHERE  num_celular=' || ev_num_celular;
            ssql := ssql || ' AND cod_situacion=' || lv_situacionabo || ' OR AND cod_situacion=' || lv_situacionbap;

            SELECT ind_portado, num_abonado
              INTO lv_ind_portado, ln_abonado
              FROM ga_abocel
             WHERE num_celular = ev_num_celular AND cod_situacion NOT IN ('BAA', 'BAP');

            IF lv_ind_portado IS NULL OR lv_ind_portado = 0 THEN
               lv_opcion_marca := 2;
            END IF;

            IF lv_ind_portado = 1 THEN
               lv_opcion_marca := 3;
            END IF;

            IF lv_ind_portado = 2 OR lv_ind_portado = 3 THEN
               sn_cod_retorno := 2386;
               sv_mens_retorno := 'Abonado no tiene el indicador de marca adecuado, debe tener 0 ó 1.';
               RAISE le_exception;
            END IF;
            
            IF lv_ind_portado < 0 OR lv_ind_portado > 3 THEN
               sn_cod_retorno := 2388;
               sv_mens_retorno := 'Indicador de marca invalido. Debe ser 0, 1, 2 o 3.';
               RAISE le_exception;
            END IF;

            ssql := 'UPDATE ga_abocel ';
            ssql := ssql || 'SET ind_portado=' || lv_opcion_marca;
            ssql := ssql || ' WHERE  num_celular=' || ev_num_celular;
            ssql := ssql || ' AND num_abonado=' || ln_abonado;

            UPDATE ga_abocel
               SET ind_portado = lv_opcion_marca
             WHERE num_celular = ev_num_celular AND num_abonado = ln_abonado;
         END IF;

         IF ev_perfil = 1 THEN
            ssql := 'SELECT ind_portado , num_abonado';
            ssql := ssql || 'FROM   ga_aboamist';
            ssql := ssql || ' WHERE  num_celular=' || ev_num_celular;
            ssql := ssql || ' AND cod_situacion=NOT IN (BAA,BAP)';

            SELECT ind_portado, num_abonado
              INTO lv_ind_portado, ln_abonado
              FROM ga_aboamist
             WHERE num_celular = ev_num_celular AND cod_situacion NOT IN ('BAA', 'BAP');

            IF lv_ind_portado IS NULL OR lv_ind_portado = 0 THEN
               lv_opcion_marca := 2;
            END IF;

            IF lv_ind_portado = 1 THEN
               lv_opcion_marca := 3;
            END IF;

            IF lv_ind_portado = 2 OR lv_ind_portado = 3 THEN
               sn_cod_retorno := 2386;
               sv_mens_retorno := 'Abonado no tiene el indicador de marca adecuado, debe tener 0 ó 1.';
               RAISE le_exception;
            END IF;
            
            IF lv_ind_portado < 0 OR lv_ind_portado > 3 THEN
               sn_cod_retorno := 2388;
               sv_mens_retorno := 'Indicador de marca invalido. Debe ser 0, 1, 2 o 3.';
               RAISE le_exception;
            END IF;

            ssql := 'UPDATE ga_aboamist ';
            ssql := ssql || 'SET ind_portado=' || lv_opcion_marca;
            ssql := ssql || ' WHERE  num_celular=' || ev_num_celular;
            ssql := ssql || ' AND num_bonado=' || ln_abonado;

            UPDATE ga_aboamist
               SET ind_portado = lv_opcion_marca
             WHERE num_celular = ev_num_celular AND num_abonado = ln_abonado;
         END IF;
      ELSE
         ssql := 'Validacion Perfil - Debe ser 1,2,3';
         sn_cod_retorno := 2384;
         sv_mens_retorno := 'Opción de marca debe ser 1,2 ó 3.';
         RAISE le_exception;
      END IF;
   EXCEPTION
      WHEN le_exception THEN

         lv_des_error := 'VE_CREA_LINEA_VENTA_QUIOSCO_PG.VE_MARCA_ABONADO_PORT_PR(' || ev_num_celular || ',' || ev_perfil || ',' || lv_opcion_marca || ');- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 'VE_CREA_LINEA_VENTA_QUIOSCO_PG.VE_MARCA_ABONADO_PORT_PR', ssql, SQLCODE, lv_des_error);
      WHEN OTHERS THEN
         sn_cod_retorno := 2383;
         sv_mens_retorno := 'Problemas al marcar al abonado portado.';

         lv_des_error := 'VE_CREA_LINEA_VENTA_QUIOSCO_PG.VE_MARCA_ABONADO_PORT_PR(' || ev_num_celular || ',' || ev_perfil || ',' || lv_opcion_marca || ');- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 'VE_CREA_LINEA_VENTA_QUIOSCO_PG.VE_MARCA_ABONADO_PORT_PR', ssql, SQLCODE, lv_des_error);
   END ve_marca_abonado_port_pr;
*/
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*Se comenta el procedimiento ve_desmarca_abonado_port_pr por pertenecer a portabilidad*/  
/*  
 PROCEDURE ve_desmarca_abonado_port_pr (
      ev_num_celular    IN              ga_abocel.num_celular%TYPE,
      ev_perfil         IN              VARCHAR2,
      sn_ind_portado    OUT NOCOPY      ga_abocel.ind_portado%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento)
      */
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "VE_DESMARCA_ABONADO_PORT_PR"
      Lenguaje="PL/SQL"
      Fecha="02-09-2005"
      Versión="1.0"
      Diseñador=""
     Programador="
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Actualizar tabla de abonado segun la opcion de desmarcar</Descripción>
      <Parámetros>
         <Entrada>
         <param nom="EV_num_celular" Tipo="NUMERICO">Nro de celular</param>
         <param nom="EV_perfil" Tipo="CARACTER">Perfil, corresponde  a prepago o pospago</param>
         </Entrada>
        </Entrada>
        <Salida>
            <param nom="SN_cod_retorno"    Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"   Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Nro de evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
/*
   AS
      lv_des_error      ge_errores_pg.desevent;
      ssql              ge_errores_pg.vquery;
      lv_ind_portado    NUMBER;
      lv_opcion_marca   NUMBER;
      le_exception      EXCEPTION;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      sn_ind_portado := NULL;

      IF ev_perfil = 1 OR ev_perfil = 2 OR ev_perfil = 3 THEN
         IF ev_perfil = 2 OR ev_perfil = 3 THEN
            ssql := 'SELECT ind_portado ';
            ssql := ssql || 'FROM   ga_abocel';
            ssql := ssql || ' WHERE  num_celular=' || ev_num_celular;
            ssql := ssql || ' AND fec_alta in (select max(fec_alta) from ga_abocel where num_celular=' || ev_num_celular || ')';

            SELECT ind_portado
              INTO lv_ind_portado
              FROM ga_abocel
             WHERE num_celular = ev_num_celular AND fec_alta IN (SELECT MAX (fec_alta)
                                                                   FROM ga_abocel
                                                                  WHERE num_celular = ev_num_celular);

            IF lv_ind_portado IS NULL OR lv_ind_portado = 0 THEN
               sn_cod_retorno := 2387;
               sv_mens_retorno := 'Abonado no tiene el indicador de marca adecuado, debe tener 2 ó 3.';
               RAISE le_exception;
            END IF;

            IF lv_ind_portado = 2 THEN
               lv_opcion_marca := 0;
            END IF;

            IF lv_ind_portado = 3 THEN
               lv_opcion_marca := 1;
            END IF;

            ssql := 'UPDATE ga_abocel ';
            ssql := ssql || 'SET ind_portado=' || lv_opcion_marca;
            ssql := ssql || ' WHERE  num_celular=' || ev_num_celular;
            ssql := ssql || ' AND fec_alta in (select max(fec_alta) from ga_abocel where num_celular=' || ev_num_celular || ')';

            UPDATE ga_abocel
               SET ind_portado = lv_opcion_marca
             WHERE num_celular = ev_num_celular AND fec_alta IN (SELECT MAX (fec_alta)
                                                                   FROM ga_abocel
                                                                  WHERE num_celular = ev_num_celular);
         END IF;

         IF ev_perfil = 1 THEN
            ssql := 'SELECT ind_portado';
            ssql := ssql || 'FROM   ga_aboamist';
            ssql := ssql || 'WHERE  num_celular=' || ev_num_celular;
            ssql := ssql || ' AND fec_alta in (select max(fec_alta) from ga_aboamist where num_celular=' || ev_num_celular || ')';

            SELECT ind_portado
              INTO lv_ind_portado
              FROM ga_aboamist
             WHERE num_celular = ev_num_celular AND fec_alta IN (SELECT MAX (fec_alta)
                                                                   FROM ga_aboamist
                                                                  WHERE num_celular = ev_num_celular);

            IF lv_ind_portado IS NULL OR lv_ind_portado = 0 THEN
               sn_cod_retorno := 2387;
               sv_mens_retorno := 'Abonado no tiene el indicador de marca adecuado, debe tener 2 ó 3.';
               RAISE le_exception;
            END IF;

            IF lv_ind_portado = 2 THEN
               lv_opcion_marca := 0;
            END IF;

            IF lv_ind_portado = 3 THEN
               lv_opcion_marca := 1;
            END IF;

            ssql := 'UPDATE ga_aboamist ';
            ssql := ssql || 'SET ind_portado=' || lv_opcion_marca;
            ssql := ssql || ' WHERE  num_celular=' || ev_num_celular;
            ssql := ssql || ' AND fec_alta in (select max(fec_alta) from ga_aboamist where num_celular=' || ev_num_celular || ')';

            UPDATE ga_aboamist
               SET ind_portado = lv_opcion_marca
             WHERE num_celular = ev_num_celular AND fec_alta IN (SELECT MAX (fec_alta)
                                                                   FROM ga_aboamist
                                                                  WHERE num_celular = ev_num_celular);
         END IF;
      ELSE
         ssql := 'Validacion Perfil - Debe ser 1,2,3';
         sn_cod_retorno := 2384;
         sv_mens_retorno := 'Opción de marca debe ser 1,2 ó 3.';
         RAISE le_exception;
      END IF;

      sn_ind_portado := lv_ind_portado;
   EXCEPTION
      WHEN le_exception THEN

         lv_des_error := 'VE_CREA_LINEA_VENTA_QUIOSCO_PG.VE_DESMARCA_ABONADO_PORT_PR(' || ev_num_celular || ',' || ev_perfil || ',' || lv_opcion_marca || ');- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 'VE_CREA_LINEA_VENTA_QUIOSCO_PG.VE_DESMARCA_ABONADO_PORT_PR', ssql, SQLCODE, lv_des_error);
      WHEN OTHERS THEN
         sn_cod_retorno := 2385;
         sv_mens_retorno := 'Problemas al realizar la desmarca del abonado.';

         lv_des_error := 'VE_CREA_LINEA_VENTA_QUIOSCO_PG.VE_DESMARCA_ABONADO_PORT_PR(' || ev_num_celular || ',' || ev_perfil || ',' || lv_opcion_marca || ');- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 'VE_CREA_LINEA_VENTA_QUIOSCO_PG.VE_DESMARCA_ABONADO_PORT_PR', ssql, SQLCODE, lv_des_error);
   END ve_desmarca_abonado_port_pr;
*/
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*Se comenta el procedimiento ve_in_pospago_portado_pr por pertenecer a portabilidad*/ 
/*
   PROCEDURE ve_in_pospago_portado_pr (
      ev_num_abonado             IN              ga_abocel.num_abonado%TYPE,
      ev_num_celular             IN              ga_abocel.num_celular%TYPE,
      ev_cod_producto            IN              ga_abocel.cod_producto%TYPE,
      ev_cod_cliente             IN              ga_abocel.cod_cliente%TYPE,
      ev_cod_cuenta              IN              ga_abocel.cod_cuenta%TYPE,
      ev_cod_subcuenta           IN              ga_abocel.cod_subcuenta%TYPE,
      ev_cod_usuario             IN              ga_abocel.cod_usuario%TYPE,
      ev_cod_region              IN              ga_abocel.cod_region%TYPE,
      ev_cod_provincia           IN              ga_abocel.cod_provincia%TYPE,
      ev_cod_ciudad              IN              ga_abocel.cod_ciudad%TYPE,
      ev_cod_celda               IN              ga_abocel.cod_celda%TYPE,
      ev_cod_central             IN              ga_abocel.cod_central%TYPE,
      ev_cod_uso                 IN              ga_abocel.cod_uso%TYPE,
      ev_cod_situacion           IN              ga_abocel.cod_situacion%TYPE,
      ev_ind_procalta            IN              ga_abocel.ind_procalta%TYPE,
      ev_ind_procequi            IN              ga_abocel.ind_procequi%TYPE,
      ev_cod_vendedor            IN              ga_abocel.cod_vendedor%TYPE,
      ev_cod_vendedor_agente     IN              ga_abocel.cod_vendedor_agente%TYPE,
      ev_tip_plantarif           IN              ga_abocel.tip_plantarif%TYPE,
      ev_tip_terminal            IN              ga_abocel.tip_terminal%TYPE,
      ev_cod_plantarif           IN              ga_abocel.cod_plantarif%TYPE,
      ev_cod_cargobasico         IN              ga_abocel.cod_cargobasico%TYPE,
      ev_cod_planserv            IN              ga_abocel.cod_planserv%TYPE,
      ev_cod_limconsumo          IN              ga_abocel.cod_limconsumo%TYPE,
      ev_num_serie               IN              ga_abocel.num_serie%TYPE,
      ev_num_seriehex            IN              ga_abocel.num_seriehex%TYPE,
      ev_nom_usuarora            IN              ga_abocel.nom_usuarora%TYPE,
      ev_fec_alta                IN              VARCHAR2,
      ev_num_percontrato         IN              ga_abocel.num_percontrato%TYPE,
      ev_cod_estado              IN              ga_abocel.cod_estado%TYPE,
      ev_num_seriemec            IN              ga_abocel.num_seriemec%TYPE,
      ev_cod_holding             IN              ga_abocel.cod_holding%TYPE,
      ev_cod_empresa             IN              ga_abocel.cod_empresa%TYPE,
      ev_cod_grpserv             IN              ga_abocel.cod_grpserv%TYPE,
      ev_ind_supertel            IN              ga_abocel.ind_supertel%TYPE,
      ev_num_telefija            IN              ga_abocel.num_telefija%TYPE,
      ev_cod_opredfija           IN              ga_abocel.cod_opredfija%TYPE,
      ev_cod_carrier             IN              ga_abocel.cod_carrier%TYPE,
      ev_ind_prepago             IN              ga_abocel.ind_prepago%TYPE,
      ev_ind_plexsys             IN              ga_abocel.ind_plexsys%TYPE,
      ev_cod_central_plex        IN              ga_abocel.cod_central_plex%TYPE,
      ev_num_celular_plex        IN              ga_abocel.num_celular_plex%TYPE,
      ev_num_venta               IN              ga_abocel.num_venta%TYPE,
      ev_cod_modventa            IN              ga_abocel.cod_modventa%TYPE,
      ev_cod_tipcontrato         IN              ga_abocel.cod_tipcontrato%TYPE,
      ev_num_contrato            IN              ga_abocel.num_contrato%TYPE,
      ev_num_anexo               IN              ga_abocel.num_anexo%TYPE,
      ev_fec_cumplan             IN              VARCHAR2,
      ev_cod_credmor             IN              ga_abocel.cod_credmor%TYPE,
      ev_cod_credcon             IN              ga_abocel.cod_credcon%TYPE,
      ev_cod_ciclo               IN              ga_abocel.cod_ciclo%TYPE,
      ev_ind_factur              IN              ga_abocel.ind_factur%TYPE,
      ev_ind_suspen              IN              ga_abocel.ind_suspen%TYPE,
      ev_ind_rehabi              IN              ga_abocel.ind_rehabi%TYPE,
      ev_ind_insguias            IN              ga_abocel.ind_insguias%TYPE,
      ev_fec_fincontra           IN              VARCHAR2,
      ev_fec_recdocum            IN              VARCHAR2,
      ev_fec_cumplimen           IN              VARCHAR2,
      ev_fec_acepventa           IN              VARCHAR2,
      ev_fec_actcen              IN              VARCHAR2,
      ev_fec_baja                IN              VARCHAR2,
      ev_fec_bajacen             IN              VARCHAR2,
      ev_fec_ultmod              IN              VARCHAR2,
      ev_cod_causabaja           IN              ga_abocel.cod_causabaja%TYPE,
      ev_num_personal            IN              ga_abocel.num_personal%TYPE,
      ev_ind_seguro              IN              ga_abocel.ind_seguro%TYPE,
      ev_clase_servicio          IN              ga_abocel.clase_servicio%TYPE,
      ev_perfil_abonado          IN              ga_abocel.perfil_abonado%TYPE,
      ev_num_min                 IN              ga_abocel.num_min%TYPE,
      ev_cod_vendealer           IN              ga_abocel.cod_vendealer%TYPE,
      ev_ind_disp                IN              ga_abocel.ind_disp%TYPE,
      ev_cod_password            IN              ga_abocel.cod_password%TYPE,
      ev_ind_password            IN              ga_abocel.ind_password%TYPE,
      ev_cod_afinidad            IN              ga_abocel.cod_afinidad%TYPE,
      ev_fec_prorroga            IN              VARCHAR2,
      ev_ind_eqprestado          IN              ga_abocel.ind_eqprestado%TYPE,
      ev_flg_contdigi            IN              ga_abocel.flg_contdigi%TYPE,
      ev_fec_altantras           IN              VARCHAR2,
      ev_cod_indemnizacion       IN              ga_abocel.cod_indemnizacion%TYPE,
      ev_num_imei                IN              ga_abocel.num_imei%TYPE,
      ev_cod_tecnologia          IN              ga_abocel.cod_tecnologia%TYPE,
      ev_num_min_mdn             IN              ga_abocel.num_min_mdn%TYPE,
      ev_fec_activacion          IN              VARCHAR2,
      ev_ind_telefono            IN              ga_abocel.ind_telefono%TYPE,
      ev_cod_oficina_principal   IN              ga_abocel.cod_oficina_principal%TYPE,
      ev_cod_causa_venta         IN              ga_abocel.cod_causa_venta%TYPE,
      ev_ind_portado             IN              ga_abocel.ind_portado%TYPE,
      ev_cod_operador            IN              ga_abocel.cod_operador%TYPE,
      sn_cod_retorno             OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno            OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento              OUT NOCOPY      ge_errores_pg.evento)
      */
                                                                      /*
                                                                      <Documentación
                                                                        TipoDoc = "Procedimiento">
                                                                         <Elemento
                                                                            Nombre = "VE_IN_ga_abocel_PR"
                                                                            Lenguaje="PL/SQL"
                                                                            Fecha="15-03-2007"
                                                                            Versión="1.0"
                                                                            Diseñador="Héctor Hermosilla"
                                                                           Programador="Héctor Hermosilla"
                                                                            Ambiente Desarrollo="BD">
                                                                            <Retorno>NA</Retorno>
                                                                            <Descripción>Obtiene una subcuenta de una cuenta especifica</Descripción>
                                                                            <Parámetros>
                                                                              <Entrada>
                                                                               <param nom="EV_num_abonado" Tipo="NUMBER">Numero de Abonado</param>
                                                                               <param nom="EV_num_celular" Tipo="NUMBER">Numero de celular</param>
                                                                               <param nom="EV_cod_producto" Tipo="NUMBER">codigo de producto</param>
                                                                               <param nom="EV_cod_cliente" Tipo="NUMBER">codigo cliente</param>
                                                                               <param nom="EV_cod_cuenta" Tipo="VARCHAR2">codigo cuenta</param>
                                                                               <param nom="EV_cod_subcuenta" Tipo="VARCHAR2">codigo subcuenta</param>
                                                                               <param nom="EV_cod_usuario" Tipo="NUMBER">codigo usuario</param>
                                                                               <param nom="EV_cod_region" Tipo="NUMBER">codigo region</param>
                                                                               <param nom="EV_cod_provincia" Tipo="NUMBER">codigo provincia</param>
                                                                               <param nom="EV_cod_ciudad" Tipo="VARCHAR2">codigo ciudad</param>
                                                                               <param nom="EV_cod_celda" Tipo="NUMBER">codigo celda</param>
                                                                               <param nom="EV_cod_central" Tipo="NUMBER">codigo central</param>
                                                                               <param nom="EV_cod_uso" Tipo="NUMBER">codigo uso</param>
                                                                               <param nom="EV_cod_situacion" Tipo="NUMBER">codigo situacion</param>
                                                                               <param nom="EV_ind_procalta" Tipo="NUMBER">Indicador procedencia alta</param>
                                                                               <param nom="EV_ind_procequi" Tipo="NUMBER">Indicador procedencia equipo</param>
                                                                               <param nom="EV_cod_vendedor" Tipo="NUMBER">codigo vendedor</param>
                                                                               <param nom="EV_cod_vendedor_agente" Tipo="NUMBER">codigo vendedor agente</param>
                                                                               <param nom="EV_tip_plantarif" Tipo="VARCHAR2">tipo plan tarifario</param>
                                                                               <param nom="EV_tip_terminal" Tipo="NUMBER">tipo terminal</param>
                                                                               <param nom="EV_cod_plantarif" Tipo="VARCHAR2">codigo plan tarifario</param>
                                                                               <param nom="EV_cod_cargobasico" Tipo="VARCHAR2">codigo cargo basico</param>
                                                                               <param nom="EV_cod_planserv" Tipo="VARCHAR2">codigo plan servicio</param>
                                                                               <param nom="EV_cod_limconsumo" Tipo="VARCHAR2">codigo limite consumo</param>
                                                                               <param nom="EV_num_serie" Tipo="VARCHAR2">numero de serie decimal</param>
                                                                               <param nom="EV_num_seriehex" Tipo="VARCHAR2">numero de serie hexadecimal</param>
                                                                               <param nom="EV_nom_usuarora" Tipo="VARCHAR2">nombre usuario</param>
                                                                               <param nom="EV_fec_alta" Tipo="VARCHAR2">fecha alta</param>
                                                                               <param nom="EV_num_percontrato" Tipo="NUMBER">numero de periodo de contrato</param>
                                                                               <param nom="EV_cod_estado" Tipo="NUMBER">codigo estado</param>
                                                                               <param nom="EV_num_seriemec" Tipo="NUMBER">numero serie mecanico</param>
                                                                               <param nom="EV_cod_holding" Tipo="NUMBER">codigo holding</param>
                                                                               <param nom="EV_cod_empresa" Tipo="NUMBER">codigo empresa</param>
                                                                               <param nom="EV_cod_grpserv" Tipo="NUMBER">codigo grupo servicio</param>
                                                                               <param nom="EV_ind_supertel" Tipo="NUMBER">indicativo modalidad supertelefono</param>
                                                                               <param nom="EV_num_telefija" Tipo="NUMBER">numero de telefonia fija</param>
                                                                               <param nom="EV_cod_opredfija" Tipo="NUMBER">codigo de operacion</param>
                                                                               <param nom="EV_cod_carrier" Tipo="NUMBER">codigo carrier</param>
                                                                               <param nom="EV_ind_prepago" Tipo="NUMBER">indicagtivo de prepago</param>
                                                                               <param nom="EV_ind_plexsys" Tipo="NUMBER">indicativo abonado zona plexsys</param>
                                                                               <param nom="EV_cod_central_plex" Tipo="NUMBER">codigo central plexsys</param>
                                                                               <param nom="EV_num_celular_plex" Tipo="NUMBER">numero celular plexsys</param>
                                                                               <param nom="EV_num_venta" Tipo="NUMBER">numero de venta</param>
                                                                               <param nom="EV_cod_modventa" Tipo="NUMBER">codigo modalidad venta</param>
                                                                               <param nom="EV_cod_tipcontrato" Tipo="NUMBER">codigo tipo contrato</param>
                                                                               <param nom="EV_num_contrato" Tipo="NUMBER">numero contrato</param>
                                                                               <param nom="EV_num_anexo" Tipo="NUMBER">numero anexo</param>
                                                                               <param nom="EV_fec_cumplan" Tipo="VARCHAR2">fecha posible cambio pplan tarifario</param>
                                                                               <param nom="EV_cod_credmor" Tipo="NUMBER">Código de Límite Crédito de Morosidad</param>
                                                                               <param nom="EV_cod_credcon" Tipo="NUMBER">Código de Límite Crédito de Consumo</param>
                                                                               <param nom="EV_cod_ciclo" Tipo="NUMBER">Código de Ciclo Facturación</param>
                                                                               <param nom="EV_ind_factur" Tipo="NUMBER">Indicativo de Facturable ; No (0), Si (1)</param>
                                                                               <param nom="EV_ind_suspen" Tipo="NUMBER">Indicativo de Suspendible ; No (0), Si (1)</param>
                                                                               <param nom="EV_ind_rehabi" Tipo="NUMBER">Indicativo de Rehabilitable ; No (0), Si (1)</param>
                                                                               <param nom="EV_ind_insguias" Tipo="NUMBER">Indicativo de Inserción en Guias ; No (0), Si (1)</param>
                                                                               <param nom="EV_fec_fincontra" Tipo="NUMBER">Fecha de Fin Contrato</param>
                                                                               <param nom="EV_fec_recdocum" Tipo="VARCHAR2">Fecha de Recepción Documentación</param>
                                                                               <param nom="EV_fec_cumplimen" Tipo="VARCHAR2">Fecha de Cumplimentación Datos</param>
                                                                               <param nom="EV_fec_acepventa" Tipo="VARCHAR2">Fecha de Aceptación Venta</param>
                                                                               <param nom="EV_fec_actcen" Tipo="VARCHAR2">Fecha de Activación en Central</param>
                                                                               <param nom="EV_fec_baja" Tipo="VARCHAR2">Fecha de Baja</param>
                                                                               <param nom="EV_fec_bajacen" Tipo="VARCHAR2">Fecha de Baja en Central</param>
                                                                               <param nom="EV_fec_ultmod" Tipo="VARCHAR2">Fecha de Última Modificación</param>
                                                                               <param nom="EV_cod_causabaja" Tipo="VARCHAR2">Código de Causa de Baja</param>
                                                                               <param nom="EV_num_personal" Tipo="NUMBER">Código de Bloqueo de Terminal</param>
                                                                               <param nom="EV_ind_seguro" Tipo="NUMBER">Indicativo de Seguro ; Si (0), No (1)</param>
                                                                               <param nom="EV_clase_servicio" Tipo="NUMBER">Matricula de Servicios contratados por el Abonado</param>
                                                                               <param nom="EV_perfil_abonado" Tipo="VARCHAR2">Matricula de Servicios Activos del Abonado</param>
                                                                               <param nom="EV_num_min" Tipo="VARCHAR2">Prefijo MIN</param>
                                                                               <param nom="EV_cod_vendealer" Tipo="NUMBER">codigo vendealer</param>
                                                                               <param nom="EV_ind_disp" Tipo="NUMBER">Indicativo de Disponibilidad 0:No disponible (STP) 1:Disponible</param>
                                                                               <param nom="EV_cod_password" Tipo="VARCHAR2">Password de acceso via Internet.</param>
                                                                               <param nom="EV_ind_password" Tipo="NUMBER">Indicador de validez de password: 0=valida | 1=invalida.</param>
                                                                               <param nom="EV_cod_afinidad" Tipo="NUMBER">Código de afinidad</param>
                                                                               <param nom="EV_fec_prorroga" Tipo="VARCHAR2">Fecha de Prorroga de Contrato</param>
                                                                               <param nom="EV_ind_eqprestado" Tipo="NUMBER">Indicador de equipo prestado</param>
                                                                               <param nom="EV_flg_contdigi" Tipo="NUMBER">Indica si el contrato esta digitalizado.</param>
                                                                               <param nom="EV_fec_altantras" Tipo="VARCHAR2">Indica la fecha de alta anterior, dado que se hizo un traspaso..</param>
                                                                               <param nom="EV_cod_indemnizacion" Tipo="NUMBER">codigo indemnizacion</param>
                                                                               <param nom="EV_num_imei" Tipo="VARCHAR2">Número Serie Terminal GSM</param>
                                                                               <param nom="EV_cod_tecnologia" Tipo="NUMBER">Código Tecnología</param>
                                                                               <param nom="EV_num_min_mdn" Tipo="VARCHAR2">MIN asociado al Número Celular (función logística).</param>
                                                                               <param nom="EV_fec_activacion" Tipo="VARCHAR2">fecha activacion</param>
                                                                               <param nom="EV_ind_telefono" Tipo="NUMBER">indicador telefono</param>
                                                                               <param nom="EV_cod_oficina_principal" Tipo="VARCHAR2">Código Oficina Principal</param>
                                                                               <param nom="EV_cod_causa_venta" Tipo="VARCHAR2">Código de Causa deVenta</param>
                                                                               <param nom="EV_cod_operacion" Tipo="VARCHAR2">Código de Operación</param>
																			   <param nom="EV_cod_prestacion" Tipo="VARCHAR2">Código de Prestación</param>
                                                                             </Entrada>
                                                                             <Salida>
                                                                                  <param nom="SN_cod_retorno"   Tipo="NUMBER">Codigo de Retorno</param>
                                                                                  <param nom="SV_mens_retorno"  Tipo="VARCHAR2">Mensaje de Retorno</param>
                                                                                  <param nom="SN_num_evento"    Tipo="NUMBER">Nro de evento</param>
                                                                               </Salida>
                                                                            </Parámetros>
                                                                         </Elemento>
                                                                      </Documentación>
                                                                      */
                                                                      /*
   IS
      lv_sql            ge_errores_pg.vquery;
      lv_des_error      ge_errores_pg.desevent;
      lv_sqlejecutarc   ge_errores_pg.vquery;
	  v_cuenta_serie	number(1);	  
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
	  v_cuenta_serie := 0;
	  
      lv_sql :=
         'INSERT INTO ga_abocel (num_abonado, num_celular, cod_producto, cod_cliente, cod_cuenta, ' || 'cod_subcuenta, cod_usuario, cod_region, cod_provincia, cod_ciudad, ' || 'cod_celda, cod_central, cod_uso, cod_situacion, ind_procalta, '
         || 'ind_procequi, cod_vendedor, cod_vendedor_agente, tip_plantarif, ' || 'tip_terminal, cod_plantarif, cod_cargobasico, cod_planserv, cod_limconsumo, ' || 'num_serie, num_seriehex, nom_usuarora, fec_alta, num_percontrato, cod_estado, '
         || 'num_seriemec, cod_holding, cod_empresa, cod_grpserv, ind_supertel, num_telefija, ' || 'cod_opredfija, cod_carrier, ind_prepago, ind_plexsys, cod_central_plex, ' || 'num_celular_plex, num_venta, cod_modventa, cod_tipcontrato, num_contrato, '
         || 'num_anexo, fec_cumplan, cod_credmor, cod_credcon, cod_ciclo, ind_factur, ind_suspen, ' || 'ind_rehabi,ind_insguias, fec_fincontra, fec_recdocum, fec_cumplimen, fec_acepventa, '
         || 'fec_actcen, fec_baja, fec_bajacen, fec_ultmod, cod_causabaja, num_personal, ind_seguro, ' || 'clase_servicio, perfil_abonado, num_min, cod_vendealer, ind_disp, cod_password, '
         || 'ind_password, cod_afinidad, fec_prorroga, ind_eqprestado, flg_contdigi, fec_altantras, ' || 'cod_indemnizacion, num_imei, cod_tecnologia, num_min_mdn, fec_activacion, ' || 'cod_oficina_principal, cod_causa_venta, cod_operacion)'
         || ' VALUES (''' || ev_num_abonado || ''',''' || ev_num_celular || ''',''' || ev_cod_producto || ''',''' || ev_cod_cliente || ''',''' || ev_cod_cuenta || ''',''' || ev_cod_subcuenta || ''',''' || ev_cod_usuario || ''',''' || ev_cod_region
         || ''',''' || ev_cod_provincia || ''',''' || ev_cod_ciudad || ''',''' || ev_cod_celda || ''',''' || ev_cod_central || ''',''' || ev_cod_uso || ''',''' || ev_cod_situacion || ''',''' || ev_ind_procalta || ''',''' || ev_ind_procequi || ''','''
         || ev_cod_vendedor || ''',''' || ev_cod_vendedor_agente || ''',''' || ev_tip_plantarif || ''',''' || ev_tip_terminal || ''',''' || ev_cod_plantarif || ''',''' || ev_cod_cargobasico || ''',''' || ev_cod_planserv || ''',''' || ev_cod_limconsumo
         || ''',''' || ev_num_serie || ''',''' || ev_num_seriehex || ''',''' || ev_nom_usuarora || ''',TO_DATE(''' || ev_fec_alta || ''',''' || 'DD-MM-YYYY HH24:MI:SS' || '''),''' || ev_num_percontrato || ''',''' || ev_cod_estado || ''','''
         || ev_num_seriemec || ''',''' || ev_cod_holding || ''',''' || ev_cod_empresa || ''',''' || ev_cod_grpserv || ''',''' || ev_ind_supertel || ''',''' || ev_num_telefija || ''',''' || ev_cod_opredfija || ''',''' || ev_cod_carrier || ''','''
         || ev_ind_prepago || ''',''' || ev_ind_plexsys || ''',''' || NULL || ''',''' || NULL || ''',''' || ev_num_venta || ''',''' || ev_cod_modventa || ''',''' || ev_cod_tipcontrato || ''',''' || ev_num_contrato || ''',''' || ev_num_anexo || ''','
         || 'TO_DATE(''' || ev_fec_cumplan || ''',''' || 'DD-MM-YYYY HH24:MI:SS' || '''),''' || ev_cod_credmor || ''',''' || ev_cod_credcon || ''',''' || ev_cod_ciclo || ''',''' || ev_ind_factur || ''',''' || ev_ind_suspen || ''',''' || ev_ind_rehabi
         || ''',''' || ev_ind_insguias || ''',' || ' TO_DATE(''' || ev_fec_fincontra || ''',''' || 'DD-MM-YYYY HH24:MI:SS' || '''), TO_DATE( ''' || ev_fec_recdocum || ''',''' || 'DD-MM-YYYY HH24:MI:SS' || '''),' || ' TO_DATE(''' || ev_fec_cumplimen
         || ''',''' || 'DD-MM-YYYY HH24:MI:SS' || '''), TO_DATE(''' || ev_fec_acepventa || ''',''' || 'DD-MM-YYYY HH24:MI:SS' || '''),' || ' TO_DATE(''' || ev_fec_actcen || ''',''' || 'DD-MM-YYYY HH24:MI:SS' || '''), TO_DATE(''' || ev_fec_baja || ''','''
         || 'DD-MM-YYYY HH24:MI:SS' || '''),' || ' TO_DATE(''' || ev_fec_bajacen || ''',''' || 'DD-MM-YYYY HH24:MI:SS' || '''), TO_DATE(''' || ev_fec_ultmod || ''',''' || 'DD-MM-YYYY HH24:MI:SS' || '''),''' || ev_cod_causabaja || ''','''
         || ev_num_personal || ''',''' || ev_ind_seguro || ''',''' || ev_clase_servicio || ''',''' || ev_perfil_abonado || ''',''' || ev_num_min || ''',''' || ev_cod_vendealer || ''',''' || ev_ind_disp || ''',''' || ev_cod_password || ''','''
         || ev_ind_password || ''',''' || ev_cod_afinidad || ''', TO_DATE(''' || ev_fec_prorroga || ''',''' || 'DD-MM-YYYY HH24:MI:SS' || '''),''' || ev_ind_eqprestado || ''',''' || ev_flg_contdigi || ''',TO_DATE(''' || ev_fec_altantras || ''','''
         || 'DD-MM-YYYY HH24:MI:SS' || '''),''' || ev_cod_indemnizacion || ''',''' || ev_num_imei || ''',''' || ev_cod_tecnologia || ''',''' || ev_num_min_mdn || ''',    TO_DATE(''' || ev_fec_activacion || ''',''' || 'DD-MM-YYYY HH24:MI:SS' || '''),'
         || ev_cod_oficina_principal || ''',''' || ev_cod_causa_venta || ''')';
      lv_sqlejecutarc := lv_sql;

	  
      INSERT INTO ga_abocel
                  (num_abonado, num_celular, cod_producto, cod_cliente, cod_cuenta, cod_subcuenta, cod_usuario, cod_region, cod_provincia, cod_ciudad, cod_celda, cod_central, cod_uso, cod_situacion,
                   ind_procalta, ind_procequi, cod_vendedor, cod_vendedor_agente, tip_plantarif, tip_terminal, cod_plantarif, cod_cargobasico, cod_planserv, cod_limconsumo, num_serie, num_seriehex, nom_usuarora,
                   fec_alta, num_percontrato, cod_estado, num_seriemec, cod_holding, cod_empresa, cod_grpserv, ind_supertel, num_telefija, cod_opredfija, cod_carrier, ind_prepago,
                   ind_plexsys, cod_central_plex, num_celular_plex, num_venta, cod_modventa, cod_tipcontrato, num_contrato, num_anexo, fec_cumplan, cod_credmor, cod_credcon, cod_ciclo, ind_factur,
                   ind_suspen, ind_rehabi, ind_insguias, fec_fincontra, fec_recdocum, fec_cumplimen,
                   fec_acepventa, fec_actcen, fec_baja, fec_bajacen,
                   fec_ultmod, cod_causabaja, num_personal, ind_seguro, clase_servicio, perfil_abonado, num_min, cod_vendealer, ind_disp, cod_password, ind_password, cod_afinidad,
                   fec_prorroga, ind_eqprestado, flg_contdigi, fec_altantras, cod_indemnizacion, num_imei, cod_tecnologia, num_min_mdn,
                   fec_activacion, cod_oficina_principal, cod_causa_venta,  ind_portado, cod_operador)
      VALUES      (ev_num_abonado, ev_num_celular, ev_cod_producto, ev_cod_cliente, ev_cod_cuenta, ev_cod_subcuenta, ev_cod_usuario, ev_cod_region, ev_cod_provincia, ev_cod_ciudad, ev_cod_celda, ev_cod_central, ev_cod_uso, ev_cod_situacion,
                   ev_ind_procalta, ev_ind_procequi, ev_cod_vendedor, ev_cod_vendedor_agente, ev_tip_plantarif, ev_tip_terminal, ev_cod_plantarif, ev_cod_cargobasico, ev_cod_planserv, ev_cod_limconsumo, ev_num_serie, ev_num_seriehex, ev_nom_usuarora,
                   TO_DATE (ev_fec_alta, 'DD-MM-YYYY HH24:MI:SS'), ev_num_percontrato, ev_cod_estado, ev_num_seriemec, ev_cod_holding, ev_cod_empresa, ev_cod_grpserv, ev_ind_supertel, ev_num_telefija, ev_cod_opredfija, ev_cod_carrier, ev_ind_prepago,
                   ev_ind_plexsys, NULL, NULL, ev_num_venta, ev_cod_modventa, ev_cod_tipcontrato, ev_num_contrato, ev_num_anexo, TO_DATE (ev_fec_cumplan, 'DD-MM-YYYY HH24:MI:SS'), ev_cod_credmor, ev_cod_credcon, ev_cod_ciclo, ev_ind_factur,
                   ev_ind_suspen, ev_ind_rehabi, ev_ind_insguias, TO_DATE (ev_fec_fincontra, 'DD-MM-YYYY HH24:MI:SS'), TO_DATE (ev_fec_recdocum, 'DD-MM-YYYY HH24:MI:SS'), TO_DATE (ev_fec_cumplimen, 'DD-MM-YYYY HH24:MI:SS'),
                   TO_DATE (ev_fec_acepventa, 'DD-MM-YYYY HH24:MI:SS'), TO_DATE (ev_fec_actcen, 'DD-MM-YYYY HH24:MI:SS'), TO_DATE (ev_fec_baja, 'DD-MM-YYYY HH24:MI:SS'), TO_DATE (ev_fec_bajacen, 'DD-MM-YYYY HH24:MI:SS'),
                   TO_DATE (ev_fec_ultmod, 'DD-MM-YYYY HH24:MI:SS'), ev_cod_causabaja, ev_num_personal, ev_ind_seguro, ev_clase_servicio, ev_perfil_abonado, ev_num_min, ev_cod_vendealer, ev_ind_disp, ev_cod_password, ev_ind_password, ev_cod_afinidad,
                   TO_DATE (ev_fec_prorroga, 'DD-MM-YYYY HH24:MI:SS'), ev_ind_eqprestado, ev_flg_contdigi, TO_DATE (ev_fec_altantras, 'DD-MM-YYYY HH24:MI:SS'), ev_cod_indemnizacion, ev_num_imei, ev_cod_tecnologia, ev_num_min_mdn,
                   TO_DATE (ev_fec_activacion, 'DD-MM-YYYY HH24:MI:SS'), ev_cod_oficina_principal, ev_cod_causa_venta,  ev_ind_portado, ev_cod_operador);
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno := 10814;
         sv_mens_retorno := 'Error al ingresar abonado postpago portado';

         lv_des_error := 'OTHERS:VE_CREA_LINEA_VENTA_QUIOSCO_PG.VE_IN_ga_abocel_PR(' || ev_num_abonado || '); ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 'VE_CREA_LINEA_VENTA_QUIOSCO_PG.VE_IN_ga_abocel_PR(' || ev_num_abonado || ')', lv_sql, SQLCODE, lv_des_error);
   END ve_in_pospago_portado_pr;
*/
/*Se comenta el procedimiento ve_in_prepago_portado_p por pertenecer a portabilidad*/    
/**/
 PROCEDURE ve_in_prepago_portado_pr (
      ev_num_abonado             IN              ga_abocel.num_abonado%TYPE,
      ev_num_celular             IN              ga_abocel.num_celular%TYPE,
      ev_cod_producto            IN              ga_abocel.cod_producto%TYPE,
      ev_cod_cliente             IN              ga_abocel.cod_cliente%TYPE,
      ev_cod_cuenta              IN              ga_abocel.cod_cuenta%TYPE,
      ev_cod_subcuenta           IN              ga_abocel.cod_subcuenta%TYPE,
      ev_cod_usuario             IN              ga_abocel.cod_usuario%TYPE,
      ev_cod_region              IN              ga_abocel.cod_region%TYPE,
      ev_cod_provincia           IN              ga_abocel.cod_provincia%TYPE,
      ev_cod_ciudad              IN              ga_abocel.cod_ciudad%TYPE,
      ev_cod_celda               IN              ga_abocel.cod_celda%TYPE,
      ev_cod_central             IN              ga_abocel.cod_central%TYPE,
      ev_cod_uso                 IN              ga_abocel.cod_uso%TYPE,
      ev_cod_situacion           IN              ga_abocel.cod_situacion%TYPE,
      ev_ind_procalta            IN              ga_abocel.ind_procalta%TYPE,
      ev_ind_procequi            IN              ga_abocel.ind_procequi%TYPE,
      ev_cod_vendedor            IN              ga_abocel.cod_vendedor%TYPE,
      ev_cod_vendedor_agente     IN              ga_abocel.cod_vendedor_agente%TYPE,
      ev_tip_plantarif           IN              ga_abocel.tip_plantarif%TYPE,
      ev_tip_terminal            IN              ga_abocel.tip_terminal%TYPE,
      ev_cod_plantarif           IN              ga_abocel.cod_plantarif%TYPE,
      ev_cod_cargobasico         IN              ga_abocel.cod_cargobasico%TYPE,
      ev_cod_planserv            IN              ga_abocel.cod_planserv%TYPE,
      ev_cod_limconsumo          IN              ga_abocel.cod_limconsumo%TYPE,
      ev_num_serie               IN              ga_abocel.num_serie%TYPE,
      ev_num_seriehex            IN              ga_abocel.num_seriehex%TYPE,
      ev_nom_usuarora            IN              ga_abocel.nom_usuarora%TYPE,
      ev_fec_alta                IN              VARCHAR2,
      ev_num_percontrato         IN              ga_abocel.num_percontrato%TYPE,
      ev_cod_estado              IN              ga_abocel.cod_estado%TYPE,
      ev_num_seriemec            IN              ga_abocel.num_seriemec%TYPE,
      ev_cod_holding             IN              ga_abocel.cod_holding%TYPE,
      ev_cod_empresa             IN              ga_abocel.cod_empresa%TYPE,
      ev_cod_grpserv             IN              ga_abocel.cod_grpserv%TYPE,
      ev_ind_supertel            IN              ga_abocel.ind_supertel%TYPE,
      ev_num_telefija            IN              ga_abocel.num_telefija%TYPE,
      ev_cod_opredfija           IN              ga_abocel.cod_opredfija%TYPE,
      ev_cod_carrier             IN              ga_abocel.cod_carrier%TYPE,
      ev_ind_prepago             IN              ga_abocel.ind_prepago%TYPE,
      ev_ind_plexsys             IN              ga_abocel.ind_plexsys%TYPE,
      ev_cod_central_plex        IN              ga_abocel.cod_central_plex%TYPE,
      ev_num_celular_plex        IN              ga_abocel.num_celular_plex%TYPE,
      ev_num_venta               IN              ga_abocel.num_venta%TYPE,
      ev_cod_modventa            IN              ga_abocel.cod_modventa%TYPE,
      ev_cod_tipcontrato         IN              ga_abocel.cod_tipcontrato%TYPE,
      ev_num_contrato            IN              ga_abocel.num_contrato%TYPE,
      ev_num_anexo               IN              ga_abocel.num_anexo%TYPE,
      ev_fec_cumplan             IN              VARCHAR2,
      ev_cod_credmor             IN              ga_abocel.cod_credmor%TYPE,
      ev_cod_credcon             IN              ga_abocel.cod_credcon%TYPE,
      ev_cod_ciclo               IN              ga_abocel.cod_ciclo%TYPE,
      ev_ind_factur              IN              ga_abocel.ind_factur%TYPE,
      ev_ind_suspen              IN              ga_abocel.ind_suspen%TYPE,
      ev_ind_rehabi              IN              ga_abocel.ind_rehabi%TYPE,
      ev_ind_insguias            IN              ga_abocel.ind_insguias%TYPE,
      ev_fec_fincontra           IN              VARCHAR2,
      ev_fec_recdocum            IN              VARCHAR2,
      ev_fec_cumplimen           IN              VARCHAR2,
      ev_fec_acepventa           IN              VARCHAR2,
      ev_fec_actcen              IN              VARCHAR2,
      ev_fec_baja                IN              VARCHAR2,
      ev_fec_bajacen             IN              VARCHAR2,
      ev_fec_ultmod              IN              VARCHAR2,
      ev_cod_causabaja           IN              ga_abocel.cod_causabaja%TYPE,
      ev_num_personal            IN              ga_abocel.num_personal%TYPE,
      ev_ind_seguro              IN              ga_abocel.ind_seguro%TYPE,
      ev_clase_servicio          IN              ga_abocel.clase_servicio%TYPE,
      ev_perfil_abonado          IN              ga_abocel.perfil_abonado%TYPE,
      ev_num_min                 IN              ga_abocel.num_min%TYPE,
      ev_cod_vendealer           IN              ga_abocel.cod_vendealer%TYPE,
      ev_ind_disp                IN              ga_abocel.ind_disp%TYPE,
      ev_cod_password            IN              ga_abocel.cod_password%TYPE,
      ev_ind_password            IN              ga_abocel.ind_password%TYPE,
      ev_cod_afinidad            IN              ga_abocel.cod_afinidad%TYPE,
      ev_num_imei                IN              ga_abocel.num_imei%TYPE,
      ev_cod_tecnologia          IN              ga_abocel.cod_tecnologia%TYPE,
      ev_num_min_mdn             IN              ga_abocel.num_min_mdn%TYPE,
      ev_fec_activacion          IN              VARCHAR2,
      ev_ind_telefono            IN              ga_abocel.ind_telefono%TYPE,
      ev_cod_oficina_principal   IN              ga_abocel.cod_oficina_principal%TYPE,
      ev_cod_causa_venta         IN              ga_abocel.cod_causa_venta%TYPE,
     /* ev_ind_portado             IN              ga_abocel.ind_portado%TYPE,*/
      ev_cod_cliente_dist        IN              ga_aboamist.cod_cliente_dist%TYPE,
      ev_cod_cuenta_dist         IN              ga_aboamist.cod_cuenta_dist%TYPE,
     /* ev_cod_operador            IN              ga_aboamist.cod_operador%TYPE,*/
	  ev_cod_operacion           IN              ga_aboamist.cod_operacion%TYPE,
	  ev_cod_prestacion          IN              ga_aboamist.cod_prestacion%TYPE,
      sn_cod_retorno             OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno            OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento              OUT NOCOPY      ge_errores_pg.evento)
      
                                                                      /*
                                                                      <Documentación
                                                                        TipoDoc = "Procedimiento">
                                                                         <Elemento
                                                                            Nombre = "VE_IN_ga_abocel_PR"
                                                                            Lenguaje="PL/SQL"
                                                                            Fecha="15-03-2007"
                                                                            Versión="1.0"
                                                                            Diseñador="Héctor Hermosilla"
                                                                           Programador="Héctor Hermosilla"
                                                                            Ambiente Desarrollo="BD">
                                                                            <Retorno>NA</Retorno>
                                                                            <Descripción>Obtiene una subcuenta de una cuenta especifica</Descripción>
                                                                            <Parámetros>
                                                                              <Entrada>
                                                                               <param nom="EV_num_abonado" Tipo="NUMBER">Numero de Abonado</param>
                                                                               <param nom="EV_num_celular" Tipo="NUMBER">Numero de celular</param>
                                                                               <param nom="EV_cod_producto" Tipo="NUMBER">codigo de producto</param>
                                                                               <param nom="EV_cod_cliente" Tipo="NUMBER">codigo cliente</param>
                                                                               <param nom="EV_cod_cuenta" Tipo="VARCHAR2">codigo cuenta</param>
                                                                               <param nom="EV_cod_subcuenta" Tipo="VARCHAR2">codigo subcuenta</param>
                                                                               <param nom="EV_cod_usuario" Tipo="NUMBER">codigo usuario</param>
                                                                               <param nom="EV_cod_region" Tipo="NUMBER">codigo region</param>
                                                                               <param nom="EV_cod_provincia" Tipo="NUMBER">codigo provincia</param>
                                                                               <param nom="EV_cod_ciudad" Tipo="VARCHAR2">codigo ciudad</param>
                                                                               <param nom="EV_cod_celda" Tipo="NUMBER">codigo celda</param>
                                                                               <param nom="EV_cod_central" Tipo="NUMBER">codigo central</param>
                                                                               <param nom="EV_cod_uso" Tipo="NUMBER">codigo uso</param>
                                                                               <param nom="EV_cod_situacion" Tipo="NUMBER">codigo situacion</param>
                                                                               <param nom="EV_ind_procalta" Tipo="NUMBER">Indicador procedencia alta</param>
                                                                               <param nom="EV_ind_procequi" Tipo="NUMBER">Indicador procedencia equipo</param>
                                                                               <param nom="EV_cod_vendedor" Tipo="NUMBER">codigo vendedor</param>
                                                                               <param nom="EV_cod_vendedor_agente" Tipo="NUMBER">codigo vendedor agente</param>
                                                                               <param nom="EV_tip_plantarif" Tipo="VARCHAR2">tipo plan tarifario</param>
                                                                               <param nom="EV_tip_terminal" Tipo="NUMBER">tipo terminal</param>
                                                                               <param nom="EV_cod_plantarif" Tipo="VARCHAR2">codigo plan tarifario</param>
                                                                               <param nom="EV_cod_cargobasico" Tipo="VARCHAR2">codigo cargo basico</param>
                                                                               <param nom="EV_cod_planserv" Tipo="VARCHAR2">codigo plan servicio</param>
                                                                               <param nom="EV_cod_limconsumo" Tipo="VARCHAR2">codigo limite consumo</param>
                                                                               <param nom="EV_num_serie" Tipo="VARCHAR2">numero de serie decimal</param>
                                                                               <param nom="EV_num_seriehex" Tipo="VARCHAR2">numero de serie hexadecimal</param>
                                                                               <param nom="EV_nom_usuarora" Tipo="VARCHAR2">nombre usuario</param>
                                                                               <param nom="EV_fec_alta" Tipo="VARCHAR2">fecha alta</param>
                                                                               <param nom="EV_num_percontrato" Tipo="NUMBER">numero de periodo de contrato</param>
                                                                               <param nom="EV_cod_estado" Tipo="NUMBER">codigo estado</param>
                                                                               <param nom="EV_num_seriemec" Tipo="NUMBER">numero serie mecanico</param>
                                                                               <param nom="EV_cod_holding" Tipo="NUMBER">codigo holding</param>
                                                                               <param nom="EV_cod_empresa" Tipo="NUMBER">codigo empresa</param>
                                                                               <param nom="EV_cod_grpserv" Tipo="NUMBER">codigo grupo servicio</param>
                                                                               <param nom="EV_ind_supertel" Tipo="NUMBER">indicativo modalidad supertelefono</param>
                                                                               <param nom="EV_num_telefija" Tipo="NUMBER">numero de telefonia fija</param>
                                                                               <param nom="EV_cod_opredfija" Tipo="NUMBER">codigo de operacion</param>
                                                                               <param nom="EV_cod_carrier" Tipo="NUMBER">codigo carrier</param>
                                                                               <param nom="EV_ind_prepago" Tipo="NUMBER">indicagtivo de prepago</param>
                                                                               <param nom="EV_ind_plexsys" Tipo="NUMBER">indicativo abonado zona plexsys</param>
                                                                               <param nom="EV_cod_central_plex" Tipo="NUMBER">codigo central plexsys</param>
                                                                               <param nom="EV_num_celular_plex" Tipo="NUMBER">numero celular plexsys</param>
                                                                               <param nom="EV_num_venta" Tipo="NUMBER">numero de venta</param>
                                                                               <param nom="EV_cod_modventa" Tipo="NUMBER">codigo modalidad venta</param>
                                                                               <param nom="EV_cod_tipcontrato" Tipo="NUMBER">codigo tipo contrato</param>
                                                                               <param nom="EV_num_contrato" Tipo="NUMBER">numero contrato</param>
                                                                               <param nom="EV_num_anexo" Tipo="NUMBER">numero anexo</param>
                                                                               <param nom="EV_fec_cumplan" Tipo="VARCHAR2">fecha posible cambio pplan tarifario</param>
                                                                               <param nom="EV_cod_credmor" Tipo="NUMBER">Código de Límite Crédito de Morosidad</param>
                                                                               <param nom="EV_cod_credcon" Tipo="NUMBER">Código de Límite Crédito de Consumo</param>
                                                                               <param nom="EV_cod_ciclo" Tipo="NUMBER">Código de Ciclo Facturación</param>
                                                                               <param nom="EV_ind_factur" Tipo="NUMBER">Indicativo de Facturable ; No (0), Si (1)</param>
                                                                               <param nom="EV_ind_suspen" Tipo="NUMBER">Indicativo de Suspendible ; No (0), Si (1)</param>
                                                                               <param nom="EV_ind_rehabi" Tipo="NUMBER">Indicativo de Rehabilitable ; No (0), Si (1)</param>
                                                                               <param nom="EV_ind_insguias" Tipo="NUMBER">Indicativo de Inserción en Guias ; No (0), Si (1)</param>
                                                                               <param nom="EV_fec_fincontra" Tipo="NUMBER">Fecha de Fin Contrato</param>
                                                                               <param nom="EV_fec_recdocum" Tipo="VARCHAR2">Fecha de Recepción Documentación</param>
                                                                               <param nom="EV_fec_cumplimen" Tipo="VARCHAR2">Fecha de Cumplimentación Datos</param>
                                                                               <param nom="EV_fec_acepventa" Tipo="VARCHAR2">Fecha de Aceptación Venta</param>
                                                                               <param nom="EV_fec_actcen" Tipo="VARCHAR2">Fecha de Activación en Central</param>
                                                                               <param nom="EV_fec_baja" Tipo="VARCHAR2">Fecha de Baja</param>
                                                                               <param nom="EV_fec_bajacen" Tipo="VARCHAR2">Fecha de Baja en Central</param>
                                                                               <param nom="EV_fec_ultmod" Tipo="VARCHAR2">Fecha de Última Modificación</param>
                                                                               <param nom="EV_cod_causabaja" Tipo="VARCHAR2">Código de Causa de Baja</param>
                                                                               <param nom="EV_num_personal" Tipo="NUMBER">Código de Bloqueo de Terminal</param>
                                                                               <param nom="EV_ind_seguro" Tipo="NUMBER">Indicativo de Seguro ; Si (0), No (1)</param>
                                                                               <param nom="EV_clase_servicio" Tipo="NUMBER">Matricula de Servicios contratados por el Abonado</param>
                                                                               <param nom="EV_perfil_abonado" Tipo="VARCHAR2">Matricula de Servicios Activos del Abonado</param>
                                                                               <param nom="EV_num_min" Tipo="VARCHAR2">Prefijo MIN</param>
                                                                               <param nom="EV_cod_vendealer" Tipo="NUMBER">codigo vendealer</param>
                                                                               <param nom="EV_ind_disp" Tipo="NUMBER">Indicativo de Disponibilidad 0:No disponible (STP) 1:Disponible</param>
                                                                               <param nom="EV_cod_password" Tipo="VARCHAR2">Password de acceso via Internet.</param>
                                                                               <param nom="EV_ind_password" Tipo="NUMBER">Indicador de validez de password: 0=valida | 1=invalida.</param>
                                                                               <param nom="EV_cod_afinidad" Tipo="NUMBER">Código de afinidad</param>
                                                                               <param nom="EV_fec_prorroga" Tipo="VARCHAR2">Fecha de Prorroga de Contrato</param>
                                                                               <param nom="EV_ind_eqprestado" Tipo="NUMBER">Indicador de equipo prestado</param>
                                                                               <param nom="EV_flg_contdigi" Tipo="NUMBER">Indica si el contrato esta digitalizado.</param>
                                                                               <param nom="EV_fec_altantras" Tipo="VARCHAR2">Indica la fecha de alta anterior, dado que se hizo un traspaso..</param>
                                                                               <param nom="EV_cod_indemnizacion" Tipo="NUMBER">codigo indemnizacion</param>
                                                                               <param nom="EV_num_imei" Tipo="VARCHAR2">Número Serie Terminal GSM</param>
                                                                               <param nom="EV_cod_tecnologia" Tipo="NUMBER">Código Tecnología</param>
                                                                               <param nom="EV_num_min_mdn" Tipo="VARCHAR2">MIN asociado al Número Celular (función logística).</param>
                                                                               <param nom="EV_fec_activacion" Tipo="VARCHAR2">fecha activacion</param>
                                                                               <param nom="EV_ind_telefono" Tipo="NUMBER">indicador telefono</param>
                                                                               <param nom="EV_cod_oficina_principal" Tipo="VARCHAR2">Código Oficina Principal</param>
                                                                               <param nom="EV_cod_causa_venta" Tipo="VARCHAR2">Código de Causa deVenta</param>
                                                                               <param nom="EV_cod_operacion" Tipo="VARCHAR2">Código de Operación</param>
																			   <param nom="EV_cod_prestacion" Tipo="VARCHAR2">Código de Prestación</param>
                                                                             </Entrada>
                                                                             <Salida>
                                                                                  <param nom="SN_cod_retorno"   Tipo="NUMBER">Codigo de Retorno</param>
                                                                                  <param nom="SV_mens_retorno"  Tipo="VARCHAR2">Mensaje de Retorno</param>
                                                                                  <param nom="SN_num_evento"    Tipo="NUMBER">Nro de evento</param>
                                                                               </Salida>
                                                                            </Parámetros>
                                                                         </Elemento>
                                                                      </Documentación>
                                                                      */
                                                                      
   IS
      lv_sql            ge_errores_pg.vquery;
      lv_des_error      ge_errores_pg.desevent;
      lv_sqlejecutarc   ge_errores_pg.vquery;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;


	 LV_sql:='INSERT INTO ga_aboamist'
            || ' (num_abonado, num_celular, cod_producto, cod_cliente,'
            || ' cod_cuenta, cod_subcuenta, cod_usuario, cod_region,'
            || ' cod_provincia, cod_ciudad, cod_celda, cod_central,'
            || ' cod_uso, cod_situacion, ind_procalta, ind_procequi,'
            || ' cod_vendedor, cod_vendedor_agente, tip_plantarif,'
            || ' tip_terminal, cod_plantarif, cod_cargobasico,'
            || ' cod_planserv, cod_limconsumo, num_serie,'
            || ' num_seriehex, nom_usuarora,'
            || ' fec_alta,'
            || ' num_percontrato, cod_estado, num_seriemec,'
            || ' cod_holding, cod_empresa, cod_grpserv, ind_supertel,'
            || ' num_telefija, cod_opredfija, cod_carrier,'
            || ' ind_prepago, ind_plexsys, cod_central_plex, num_celular_plex,'
            || ' num_venta, cod_modventa, cod_tipcontrato,'
            || ' num_contrato, num_anexo,'
            || ' fec_cumplan,'
            || ' cod_credmor, cod_credcon, cod_ciclo, ind_factur,'
            || ' ind_suspen, ind_rehabi, ind_insguias,'
            || ' fec_fincontra,'
            || ' fec_recdocum,'
            || ' fec_cumplimen,'
            || ' fec_acepventa,'
            || ' fec_actcen,'
            || ' fec_baja,'
            || ' fec_bajacen,'
            || ' fec_ultmod,'
            || ' cod_causabaja, num_personal, ind_seguro,'
            || ' clase_servicio, perfil_abonado, num_min,'
            || ' cod_vendealer, ind_disp, cod_password, ind_password,'
            || ' cod_afinidad, num_imei, cod_tecnologia, num_min_mdn,'
            || ' fec_activacion,'
            || ' cod_oficina_principal, cod_causa_venta, '/*ind_portado,cod_operador,*/
            || ' cod_cliente_dist, cod_cuenta_dist, cod_operacion, cod_prestacion) VALUES ('
			|| ev_num_abonado  || ''',''' || ev_num_celular        || ''',''' || ev_cod_producto    || ''',''' || ev_cod_cliente || ''',''' ||
             ev_cod_cuenta     || ''',''' || ev_cod_subcuenta      || ''',''' || ev_cod_usuario     || ''',''' || ev_cod_region  || ''',''' ||
             ev_cod_provincia  || ''',''' || ev_cod_ciudad         || ''',''' || ev_cod_celda       || ''',''' || ev_cod_central || ''',''' ||
             ev_cod_uso        || ''',''' || ev_cod_situacion      || ''',''' || ev_ind_procalta    || ''',''' || ev_ind_procequi|| ''',''' ||
             ev_cod_vendedor   || ''',''' || ev_cod_vendedor_agente|| ''',''' || ev_tip_plantarif   || ''',''' ||
             ev_tip_terminal   || ''',''' || ev_cod_plantarif      || ''',''' || ev_cod_cargobasico || ''',''' ||
             ev_cod_planserv   || ''',''' || ev_cod_limconsumo     || ''',''' || ev_num_serie       || ''',''' ||
             ev_num_seriehex   || ''',''' || ev_nom_usuarora       || ''',''' ||
             ' TO_DATE(''' || ev_fec_alta       || ''',''' || 'DD/MM/YYYY HH24:MI:SS' || ''')'|| ''',''' ||
             ev_num_percontrato|| ''',''' || ev_cod_estado         || ''',''' || ev_num_seriemec    || ''',''' ||
             ev_cod_holding    || ''',''' || ev_cod_empresa        || ''',''' || ev_cod_grpserv     || ''',''' || ev_ind_supertel|| ''',''' ||
             ev_num_telefija   || ''',''' || ev_cod_opredfija      || ''',''' || ev_cod_carrier     || ''',''' ||
             ev_ind_prepago    || ''',''' || ev_ind_plexsys        || ''',''' || NULL               || ''',''' || NULL           || ''',''' ||
             ev_num_venta      || ''',''' || ev_cod_modventa       || ''',''' || ev_cod_tipcontrato || ''',''' ||
             ev_num_contrato   || ''',''' || ev_num_anexo          || ''',''' ||
             ' TO_DATE(''' || ev_fec_cumplan    || ''',''' || 'DD/MM/YYYY HH24:MI:SS' || ''')'|| ''',''' ||
             ev_cod_credmor    || ''',''' || ev_cod_credcon        || ''',''' ||ev_cod_ciclo        || ''',''' ||ev_ind_factur   || ''',''' ||
             ev_ind_suspen     || ''',''' || ev_ind_rehabi         || ''',''' || ev_ind_insguias    || ''',''' ||
             ' TO_DATE(''' || ev_fec_fincontra  || ''',''' || 'DD/MM/YYYY HH24:MI:SS' || ''')'|| ''',''' ||
             ' TO_DATE(''' || ev_fec_recdocum   || ''',''' || 'DD/MM/YYYY HH24:MI:SS' || ''')'|| ''',''' ||
             ' TO_DATE(''' || ev_fec_cumplimen  || ''',''' || 'DD/MM/YYYY HH24:MI:SS' || ''')'|| ''',''' ||
             ' TO_DATE(''' || ev_fec_acepventa  || ''',''' || 'DD/MM/YYYY HH24:MI:SS' || ''')'|| ''',''' ||
             ' TO_DATE(''' || ev_fec_actcen     || ''',''' || 'DD/MM/YYYY HH24:MI:SS' || ''')'|| ''',''' ||
             ' TO_DATE(''' || ev_fec_baja       || ''',''' || 'DD/MM/YYYY HH24:MI:SS' || ''')'|| ''',''' ||
             ' TO_DATE(''' || ev_fec_bajacen    || ''',''' || 'DD/MM/YYYY HH24:MI:SS' || ''')'|| ''',''' ||
             ' TO_DATE(''' || ev_fec_ultmod     || ''',''' || 'DD/MM/YYYY HH24:MI:SS' || ''')'|| ''',''' ||
             ev_cod_causabaja || ''',''' || ev_num_personal  || ''',''' || ev_ind_seguro    || ''',''' ||
             ev_clase_servicio|| ''',''' || ev_perfil_abonado|| ''',''' || ev_num_min       || ''',''' ||
             ev_cod_vendealer || ''',''' || ev_ind_disp      || ''',''' || ev_cod_password  || ''',''' || ev_ind_password|| ''',''' ||
             ev_cod_afinidad  || ''',''' || ev_num_imei      || ''',''' || ev_cod_tecnologia|| ''',''' || ev_num_min_mdn || ''',''' ||
             ' TO_DATE(''' || ev_fec_activacion || ''',''' || 'DD/MM/YYYY HH24:MI:SS' || ''')'|| ''',''' ||
             ev_cod_oficina_principal|| ''',''' || ev_cod_causa_venta|| /*''',''' || ev_ind_portado||''',''' ||
             ev_cod_operador|| */''',''' || ev_cod_cliente_dist|| ''',''' || ev_cod_cuenta_dist||''',
			 '''|| ev_cod_operacion||''','''|| ev_cod_prestacion|| /*CSR-11002*/
            ')';



      lv_sqlejecutarc := lv_sql;

               INSERT INTO ga_aboamist
                         (num_abonado, num_celular, cod_producto, cod_cliente, cod_cuenta, cod_subcuenta, cod_usuario, cod_region, cod_provincia, cod_ciudad, cod_celda,
                          cod_central, cod_uso, cod_situacion, ind_procalta, ind_procequi, cod_vendedor, cod_vendedor_agente, tip_plantarif, tip_terminal, cod_plantarif,
                          cod_cargobasico, cod_planserv, cod_limconsumo, num_serie, num_seriehex, nom_usuarora, fec_alta, num_percontrato, cod_estado,
                          num_seriemec, cod_holding, cod_empresa, cod_grpserv, ind_supertel, num_telefija, cod_opredfija, cod_carrier, ind_prepago, ind_plexsys, cod_central_plex, num_celular_plex,
                          num_venta, cod_modventa, cod_tipcontrato, num_contrato, num_anexo, fec_cumplan, cod_credmor, cod_credcon, cod_ciclo,
                          ind_factur, ind_suspen, ind_rehabi, ind_insguias, fec_fincontra, fec_recdocum,
                          fec_cumplimen, fec_acepventa, fec_actcen,
                          fec_baja, fec_bajacen, fec_ultmod, cod_causabaja, num_personal,
                          ind_seguro, clase_servicio, perfil_abonado, num_min, cod_vendealer, ind_disp, cod_password, ind_password, cod_afinidad,
                           num_imei,
                          cod_tecnologia, num_min_mdn, fec_activacion, cod_oficina_principal, cod_causa_venta/*, ind_portado, cod_operador*/,cod_cliente_dist, cod_cuenta_dist, cod_operacion, cod_prestacion
                         )
                  VALUES (ev_num_abonado, ev_num_celular, ev_cod_producto, ev_cod_cliente, ev_cod_cuenta, ev_cod_subcuenta, ev_cod_usuario, ev_cod_region, ev_cod_provincia, ev_cod_ciudad, ev_cod_celda,
                          ev_cod_central, ev_cod_uso, ev_cod_situacion, ev_ind_procalta, ev_ind_procequi, ev_cod_vendedor, ev_cod_vendedor_agente, ev_tip_plantarif, ev_tip_terminal, ev_cod_plantarif,
                          ev_cod_cargobasico, ev_cod_planserv, ev_cod_limconsumo, ev_num_serie, ev_num_seriehex, ev_nom_usuarora, TO_DATE (ev_fec_alta, 'DD/MM/YYYY HH24:MI:SS'), ev_num_percontrato, ev_cod_estado,
                          ev_num_seriemec, ev_cod_holding, ev_cod_empresa, ev_cod_grpserv, ev_ind_supertel, ev_num_telefija, ev_cod_opredfija, ev_cod_carrier, ev_ind_prepago, ev_ind_plexsys, NULL, NULL,
                          ev_num_venta, ev_cod_modventa, ev_cod_tipcontrato, ev_num_contrato, ev_num_anexo, TO_DATE (ev_fec_cumplan, 'DD/MM/YYYY HH24:MI:SS'), ev_cod_credmor, ev_cod_credcon, ev_cod_ciclo,
                          ev_ind_factur, ev_ind_suspen, ev_ind_rehabi, ev_ind_insguias, TO_DATE (ev_fec_fincontra, 'DD/MM/YYYY HH24:MI:SS'), TO_DATE (ev_fec_recdocum, 'DD/MM/YYYY HH24:MI:SS'),
                          TO_DATE (ev_fec_cumplimen, 'DD/MM/YYYY HH24:MI:SS'), TO_DATE (ev_fec_acepventa, 'DD/MM/YYYY HH24:MI:SS'), TO_DATE (ev_fec_actcen, 'DD/MM/YYYY HH24:MI:SS'),
                          TO_DATE (ev_fec_baja, 'DD/MM/YYYY HH24:MI:SS'), TO_DATE (ev_fec_bajacen, 'DD/MM/YYYY HH24:MI:SS'), TO_DATE (ev_fec_ultmod, 'DD/MM/YYYY HH24:MI:SS'), ev_cod_causabaja, ev_num_personal,
                          ev_ind_seguro, ev_clase_servicio, ev_perfil_abonado, ev_num_min, ev_cod_vendealer, ev_ind_disp, ev_cod_password, ev_ind_password, ev_cod_afinidad,
                          ev_num_imei,
                          ev_cod_tecnologia, ev_num_min_mdn, TO_DATE (ev_fec_activacion, 'DD/MM/YYYY HH24:MI:SS'), ev_cod_oficina_principal, ev_cod_causa_venta/*, ev_ind_portado, ev_cod_operador*/,EV_cod_cliente_dist,EV_cod_cuenta_dist,
						  EV_cod_operacion, ev_cod_prestacion /*CSR-11002*/
                         );

   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno := 10815;
         sv_mens_retorno := 'Error al ingresar abonado prepago portado';

         lv_des_error := 'OTHERS:VE_CREA_LINEA_VENTA_QUIOSCO_PG.VE_IN_ga_abocel_PR(' || ev_num_abonado || '); ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 'VE_CREA_LINEA_VENTA_QUIOSCO_PG.VE_IN_ga_abocel_PR(' || ev_num_abonado || ')', lv_sql, SQLCODE, lv_des_error);
   END ve_in_prepago_portado_pr;

---------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_in_ga_usuamist_pr (
      en_num_abonado    IN              ga_usuamist.num_abonado%TYPE,
      ev_nomusuario     IN              ga_usuamist.nom_usuario%TYPE,
      ev_nomapellido1   IN              ga_usuamist.nom_apellido1%TYPE,
      ev_nomapellido2   IN              ga_usuamist.nom_apellido2%TYPE,
      ev_numident       IN              ga_usuamist.num_ident%TYPE,
      ev_codtipident    IN              ga_usuamist.cod_tipident%TYPE,
      ev_indestado      IN              ga_usuamist.ind_estado%TYPE,
      ev_fecnacimien    IN              VARCHAR2,
      ev_codestcivil    IN              VARCHAR2,
      ev_indsexo        IN              VARCHAR2,
      ev_indtipotrab    IN              ga_usuamist.ind_tipotrab%TYPE,
      ev_nomempresa     IN              ga_usuamist.nom_empresa%TYPE,
      ev_codactemp      IN              ga_usuamist.cod_actemp%TYPE,
      ev_codocupacion   IN              ga_usuamist.cod_ocupacion%TYPE,
      en_numpercargo    IN              ga_usuamist.num_percargo%TYPE,
      en_impbruto       IN              ga_usuamist.imp_bruto%TYPE,
      ev_indprocoper    IN              ga_usuamist.ind_procoper%TYPE,
      ev_codoperador    IN              ga_usuamist.cod_operador%TYPE,
      ev_nomconyuge     IN              ga_usuamist.nom_conyuge%TYPE,
      ev_codpinusuar    IN              ga_usuamist.cod_pinusuar%TYPE,
      ev_codusuario     IN              ga_usuamist.cod_usuario%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento)
                                                             /*
                                                             <Documentación
                                                               TipoDoc = "Procedimiento">
                                                                <Elemento
                                                                   Nombre = "VE_IN_ga_usuarios_PR"
                                                                   Lenguaje="PL/SQL"
                                                                   Fecha="15-11-2005"
                                                                   Versión="1.0"
                                                                   Diseñador="Rayen Ceballos"
                                                                  Programador="Roberto Perez"
                                                                   Ambiente Desarrollo="BD">
                                                                   <Retorno>NA</Retorno>
                                                                      <Descripción>Ingresa Usuario</Descripción>
                                                                    <Parámetros>
                                                                      <Entrada>

                                                                      </Entrada>
                                                                      <Salida>
                                                                      <param nom="SN_cod_retorno"    Tipo="NUMBER">Codigo error de negocio Retornado</param>
                                                                         <param nom="SV_mens_retorno"   Tipo="VARCHAR2">Mensaje error de negocio Retornado</param>
                                                                         <param nom="SN_num_evento"    Tipo="NUMBER">Nro de evento</param>
                                                                      </Salida>
                                                                   </Parámetros>
                                                               </Elemento>
                                                             </Documentación>
                                                             */
   IS
      lv_des_error   ge_errores_pg.desevent;
      lv_sql         ge_errores_pg.vquery;
      lv_est_civil   VARCHAR2 (10);
      lv_sexo        VARCHAR2 (10);
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;

      --Incidencia 62391 se valide que las variables no contengan espacios en blanco [PAAA 19-02-2008, soporte]
      IF LENGTH (ev_codestcivil) > 0 THEN
         lv_est_civil := RTRIM (ev_codestcivil);
         lv_est_civil := LTRIM (lv_est_civil);
      ELSE
         lv_est_civil := NULL;
      END IF;

      IF LENGTH (ev_indsexo) > 0 THEN
         lv_sexo := RTRIM (ev_indsexo);
         lv_sexo := LTRIM (lv_sexo);
      ELSE
         lv_sexo := NULL;
      END IF;

      lv_sql :=
         'INSERT INTO GA_USUAMIST (cod_usuario, num_abonado, nom_usuario,nom_apellido1, fec_alta, cod_tipident, num_ident,' || 'ind_estado, nom_apellido2, fec_nacimien, cod_estcivil, ind_sexo, ind_tipotrab, nom_empresa,'
         || 'cod_actemp, cod_ocupacion, num_percargo, imp_bruto, ind_procoper, cod_operador, nom_conyuge,' || 'cod_pinusuar)' || ' VALUES  (GA_SEQ_USUARIOS.NEXTVAL,' || en_num_abonado || ',' || ev_nomusuario || ',' || ev_nomapellido1 || ',' || SYSDATE
         || ',' || ev_codtipident || ',' || ev_numident || ',' || ev_indestado || ',' || ev_nomapellido2 || ',' || TO_DATE (ev_fecnacimien, 'DD-MM-YYYY') || ',' || lv_est_civil || ',' || lv_sexo || ',' || ev_indtipotrab || ',' || ev_nomempresa || ','
         || ev_codactemp || ',' || ev_codocupacion || ',' || en_numpercargo || ',' || en_impbruto || ',' || ev_indprocoper || ',' || ev_codoperador || ',' || ev_nomconyuge || ',' || ev_codpinusuar || ')';

      INSERT INTO ga_usuamist
                  (cod_usuario, num_abonado, nom_usuario, nom_apellido1, fec_alta, cod_tipident, num_ident, ind_estado, nom_apellido2, fec_nacimien, cod_estcivil, ind_sexo, ind_tipotrab, nom_empresa,
                   cod_actemp, cod_ocupacion, num_percargo, imp_bruto, ind_procoper, cod_operador, nom_conyuge, cod_pinusuar)
      VALUES      (ev_codusuario, en_num_abonado, ev_nomusuario, ev_nomapellido1, SYSDATE, ev_codtipident, ev_numident, ev_indestado, ev_nomapellido2, TO_DATE (ev_fecnacimien, 'DD-MM-YYYY'), lv_est_civil, lv_sexo, ev_indtipotrab, ev_nomempresa,
                   ev_codactemp, ev_codocupacion, en_numpercargo, en_impbruto, ev_indprocoper, ev_codoperador, ev_nomconyuge, ev_codpinusuar);
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno := 10816;
         sv_mens_retorno := 'Error al ingresar usuario amist';

         lv_des_error := 'OTHERS:VE_CREA_LINEA_VENTA_QUIOSCO_PG.VE_IN_ga_usuamist_PR(' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_codmodulo, sv_mens_retorno, '1.0', USER, 'VE_CREA_LINEA_VENTA_QUIOSCO_PG.VE_IN_ga_usuamist_PR', lv_sql, SQLCODE, lv_des_error);
   END ve_in_ga_usuamist_pr;

-------------------------------------------------------------------------------
   PROCEDURE ge_recupera_venta_pr (
      en_num_venta             IN              ga_ventas.num_venta%TYPE,
      sn_cod_producto          OUT NOCOPY      ga_ventas.cod_producto%TYPE,
      sv_cod_oficina           OUT NOCOPY      ga_ventas.cod_oficina%TYPE,
      sv_cod_tipcomis          OUT NOCOPY      ga_ventas.cod_tipcomis%TYPE,
      sn_cod_vendedor          OUT NOCOPY      ga_ventas.cod_vendedor%TYPE,
      sn_cod_vendedor_agente   OUT NOCOPY      ga_ventas.cod_vendedor_agente%TYPE,
      sn_num_unidades          OUT NOCOPY      ga_ventas.num_unidades%TYPE,
      sd_fec_venta             OUT NOCOPY      ga_ventas.fec_venta%TYPE,
      sv_cod_region            OUT NOCOPY      ga_ventas.cod_region%TYPE,
      sv_cod_provincia         OUT NOCOPY      ga_ventas.cod_provincia%TYPE,
      sv_cod_ciudad            OUT NOCOPY      ga_ventas.cod_ciudad%TYPE,
      sv_ind_estventa          OUT NOCOPY      ga_ventas.ind_estventa%TYPE,
      sn_num_transaccion       OUT NOCOPY      ga_ventas.num_transaccion%TYPE,
      sn_ind_pasocob           OUT NOCOPY      ga_ventas.ind_pasocob%TYPE,
      sv_nom_usuar_vta         OUT NOCOPY      ga_ventas.nom_usuar_vta%TYPE,
      sv_ind_venta             OUT NOCOPY      ga_ventas.ind_venta%TYPE,
      sv_cod_moneda            OUT NOCOPY      ga_ventas.cod_moneda%TYPE,
      sv_cod_causarec          OUT NOCOPY      ga_ventas.cod_causarec%TYPE,
      sn_imp_venta             OUT NOCOPY      ga_ventas.imp_venta%TYPE,
      sv_cod_tipcontrato       OUT NOCOPY      ga_ventas.cod_tipcontrato%TYPE,
      sv_num_contrato          OUT NOCOPY      ga_ventas.num_contrato%TYPE,
      sn_ind_tipventa          OUT NOCOPY      ga_ventas.ind_tipventa%TYPE,
      sn_cod_cliente           OUT NOCOPY      ga_ventas.cod_cliente%TYPE,
      sn_cod_modventa          OUT NOCOPY      ga_ventas.cod_modventa%TYPE,
      sn_tip_valor             OUT NOCOPY      ga_ventas.tip_valor%TYPE,
      sv_cod_cuota             OUT NOCOPY      ga_ventas.cod_cuota%TYPE,
      sv_cod_tiptarjeta        OUT NOCOPY      ga_ventas.cod_tiptarjeta%TYPE,
      sv_num_tarjeta           OUT NOCOPY      ga_ventas.num_tarjeta%TYPE,
      sv_cod_auttarj           OUT NOCOPY      ga_ventas.cod_auttarj%TYPE,
      sd_fec_vencitarj         OUT NOCOPY      ga_ventas.fec_vencitarj%TYPE,
      sv_cod_bancotarj         OUT NOCOPY      ga_ventas.cod_bancotarj%TYPE,
      sv_num_ctacorr           OUT NOCOPY      ga_ventas.num_ctacorr%TYPE,
      sv_num_cheque            OUT NOCOPY      ga_ventas.num_cheque%TYPE,
      sv_cod_banco             OUT NOCOPY      ga_ventas.cod_banco%TYPE,
      sv_cod_sucursal          OUT NOCOPY      ga_ventas.cod_sucursal%TYPE,
      sd_fec_cumplimenta       OUT NOCOPY      ga_ventas.fec_cumplimenta%TYPE,
      sd_fec_recdocum          OUT NOCOPY      ga_ventas.fec_recdocum%TYPE,
      sd_fec_aceprec           OUT NOCOPY      ga_ventas.fec_aceprec%TYPE,
      sv_nom_usuar_acerec      OUT NOCOPY      ga_ventas.nom_usuar_acerec%TYPE,
      sv_nom_usuar_recdoc      OUT NOCOPY      ga_ventas.nom_usuar_recdoc%TYPE,
      sv_nom_usuar_cumpl       OUT NOCOPY      ga_ventas.nom_usuar_cumpl%TYPE,
      sv_ind_ofiter            OUT NOCOPY      ga_ventas.ind_ofiter%TYPE,
      sn_ind_chkdicom          OUT NOCOPY      ga_ventas.ind_chkdicom%TYPE,
      sn_num_consulta          OUT NOCOPY      ga_ventas.num_consulta%TYPE,
      sn_cod_vendealer         OUT NOCOPY      ga_ventas.cod_vendealer%TYPE,
      sn_num_foldealer         OUT NOCOPY      ga_ventas.num_foldealer%TYPE,
      sn_cod_docdealer         OUT NOCOPY      ga_ventas.cod_docdealer%TYPE,
      sn_ind_doccomp           OUT NOCOPY      ga_ventas.ind_doccomp%TYPE,
      sv_obs_incump            OUT NOCOPY      ga_ventas.obs_incump%TYPE,
      sn_cod_causarep          OUT NOCOPY      ga_ventas.cod_causarep%TYPE,
      sd_fec_recprov           OUT NOCOPY      ga_ventas.fec_recprov%TYPE,
      sv_nom_usuar_recprov     OUT NOCOPY      ga_ventas.nom_usuar_recprov%TYPE,
      sn_num_dias              OUT NOCOPY      ga_ventas.num_dias%TYPE,
      sn_obs_recprov           OUT NOCOPY      ga_ventas.obs_recprov%TYPE,
      sn_imp_abono             OUT NOCOPY      ga_ventas.imp_abono%TYPE,
      sn_ind_abono             OUT NOCOPY      ga_ventas.ind_abono%TYPE,
      sd_fec_recep_admvtas     OUT NOCOPY      ga_ventas.fec_recep_admvtas%TYPE,
      sv_usu_recep_admvtas     OUT NOCOPY      ga_ventas.usu_recep_admvtas%TYPE,
      sv_obs_gralcumpl         OUT NOCOPY      ga_ventas.obs_gralcumpl%TYPE,
      sn_ind_cont_telef        OUT NOCOPY      ga_ventas.ind_cont_telef%TYPE,
      sd_fecha_cont_telef      OUT NOCOPY      ga_ventas.fecha_cont_telef%TYPE,
      sv_usuario_cont_telef    OUT NOCOPY      ga_ventas.usuario_cont_telef%TYPE,
      sn_mto_garantia          OUT NOCOPY      ga_ventas.mto_garantia%TYPE,
      sv_tip_foliacion         OUT NOCOPY      ga_ventas.tip_foliacion%TYPE,
      sn_cod_tipdocum          OUT NOCOPY      ga_ventas.cod_tipdocum%TYPE,
      sv_cod_plaza             OUT NOCOPY      ga_ventas.cod_plaza%TYPE,
      sv_cod_operadora         OUT NOCOPY      ga_ventas.cod_operadora%TYPE,
      sn_num_proceso           OUT NOCOPY      ga_ventas.num_proceso%TYPE,
      /*sn_ind_portado           OUT NOCOPY      ga_ventas.ind_portado%TYPE,*/
      sn_cod_error             OUT NOCOPY      NUMBER,
      sv_des_error             OUT NOCOPY      VARCHAR2,
      sn_num_evento            OUT NOCOPY      NUMBER) AS
      ln_sql   VARCHAR2 (1000);
   BEGIN
      sn_cod_error := 0;
      sv_des_error := NULL;
      sn_num_evento := 0;
      ln_sql := 'SELECT * FROM ga_ventas V WHERE v.num_venta =' || en_num_venta;

      SELECT cod_producto, cod_oficina, cod_tipcomis, cod_vendedor, cod_vendedor_agente, num_unidades, fec_venta, cod_region, cod_provincia, cod_ciudad, ind_estventa, num_transaccion, ind_pasocob, nom_usuar_vta,
             ind_venta, cod_moneda, cod_causarec, imp_venta, cod_tipcontrato, num_contrato, ind_tipventa, cod_cliente, cod_modventa, tip_valor, cod_cuota, cod_tiptarjeta, num_tarjeta, cod_auttarj,
             fec_vencitarj, cod_bancotarj, num_ctacorr, num_cheque, cod_banco, cod_sucursal, fec_cumplimenta, fec_recdocum, fec_aceprec, nom_usuar_acerec, nom_usuar_recdoc, nom_usuar_cumpl, ind_ofiter,
             ind_chkdicom, num_consulta, cod_vendealer, num_foldealer, cod_docdealer, ind_doccomp, obs_incump, cod_causarep, fec_recprov, nom_usuar_recprov, num_dias, obs_recprov, imp_abono, ind_abono,
             fec_recep_admvtas, usu_recep_admvtas, obs_gralcumpl, ind_cont_telef, fecha_cont_telef, usuario_cont_telef, mto_garantia, tip_foliacion, cod_tipdocum, cod_plaza, cod_operadora, num_proceso/*, ind_portado*/
        INTO sn_cod_producto, sv_cod_oficina, sv_cod_tipcomis, sn_cod_vendedor, sn_cod_vendedor_agente, sn_num_unidades, sd_fec_venta, sv_cod_region, sv_cod_provincia, sv_cod_ciudad, sv_ind_estventa, sn_num_transaccion, sn_ind_pasocob, sv_nom_usuar_vta,
             sv_ind_venta, sv_cod_moneda, sv_cod_causarec, sn_imp_venta, sv_cod_tipcontrato, sv_num_contrato, sn_ind_tipventa, sn_cod_cliente, sn_cod_modventa, sn_tip_valor, sv_cod_cuota, sv_cod_tiptarjeta, sv_num_tarjeta, sv_cod_auttarj,
             sd_fec_vencitarj, sv_cod_bancotarj, sv_num_ctacorr, sv_num_cheque, sv_cod_banco, sv_cod_sucursal, sd_fec_cumplimenta, sd_fec_recdocum, sd_fec_aceprec, sv_nom_usuar_acerec, sv_nom_usuar_recdoc, sv_nom_usuar_cumpl, sv_ind_ofiter,
             sn_ind_chkdicom, sn_num_consulta, sn_cod_vendealer, sn_num_foldealer, sn_cod_docdealer, sn_ind_doccomp, sv_obs_incump, sn_cod_causarep, sd_fec_recprov, sv_nom_usuar_recprov, sn_num_dias, sn_obs_recprov, sn_imp_abono, sn_ind_abono,
             sd_fec_recep_admvtas, sv_usu_recep_admvtas, sv_obs_gralcumpl, sn_ind_cont_telef, sd_fecha_cont_telef, sv_usuario_cont_telef, sn_mto_garantia, sv_tip_foliacion, sn_cod_tipdocum, sv_cod_plaza, sv_cod_operadora, sn_num_proceso/*, sn_ind_portado*/
        FROM ga_ventas v
       WHERE v.num_venta = en_num_venta;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_error := 10767;
         --IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_error,SV_des_error) THEN
         sv_des_error := 'Número de venta no existe';
         --END IF;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, 'GE', sv_des_error, '1.0', USER, 'GE_CONS_CATALAGO_PORTAB_PG.GE_RECUPERA_VENTA_PR', ln_sql, SQLCODE, SQLERRM);
      WHEN OTHERS THEN
         sn_cod_error := 10768;
         --IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_error,SV_des_error) THEN
         sv_des_error := 'Error al intentar recuperar venta';
         --END IF;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, 'GE', sv_des_error, '1.0', USER, 'GE_CONS_CATALAGO_PORTAB_PG.GE_RECUPERA_VENTA_PR', ln_sql, SQLCODE, SQLERRM);
   END;
/*Se comenta el procedimiento ve_in_prepago_portado_p por pertenecer a portabilidad*/  

 PROCEDURE ge_rec_venta_pr (
      en_num_venta             IN              ga_ventas.num_venta%TYPE,
      sn_cod_producto          OUT NOCOPY      ga_ventas.cod_producto%TYPE,
      sv_cod_oficina           OUT NOCOPY      ga_ventas.cod_oficina%TYPE,
      sv_cod_tipcomis          OUT NOCOPY      ga_ventas.cod_tipcomis%TYPE,
      sn_cod_vendedor          OUT NOCOPY      ga_ventas.cod_vendedor%TYPE,
      sn_cod_vendedor_agente   OUT NOCOPY      ga_ventas.cod_vendedor_agente%TYPE,
      sn_num_unidades          OUT NOCOPY      ga_ventas.num_unidades%TYPE,
      sd_fec_venta             OUT NOCOPY      ga_ventas.fec_venta%TYPE,
      sv_cod_region            OUT NOCOPY      ga_ventas.cod_region%TYPE,
      sv_cod_provincia         OUT NOCOPY      ga_ventas.cod_provincia%TYPE,
      sv_cod_ciudad            OUT NOCOPY      ga_ventas.cod_ciudad%TYPE,
      sv_ind_estventa          OUT NOCOPY      ga_ventas.ind_estventa%TYPE,
      sn_num_transaccion       OUT NOCOPY      ga_ventas.num_transaccion%TYPE,
      sn_ind_pasocob           OUT NOCOPY      ga_ventas.ind_pasocob%TYPE,
      sv_nom_usuar_vta         OUT NOCOPY      ga_ventas.nom_usuar_vta%TYPE,
      sv_ind_venta             OUT NOCOPY      ga_ventas.ind_venta%TYPE,
      sv_cod_moneda            OUT NOCOPY      ga_ventas.cod_moneda%TYPE,
      sv_cod_causarec          OUT NOCOPY      ga_ventas.cod_causarec%TYPE,
      sn_imp_venta             OUT NOCOPY      ga_ventas.imp_venta%TYPE,
      sv_cod_tipcontrato       OUT NOCOPY      ga_ventas.cod_tipcontrato%TYPE,
      sv_num_contrato          OUT NOCOPY      ga_ventas.num_contrato%TYPE,
      sn_ind_tipventa          OUT NOCOPY      ga_ventas.ind_tipventa%TYPE,
      sn_cod_cliente           OUT NOCOPY      ga_ventas.cod_cliente%TYPE,
      sn_cod_modventa          OUT NOCOPY      ga_ventas.cod_modventa%TYPE,
      sn_tip_valor             OUT NOCOPY      ga_ventas.tip_valor%TYPE,
      sv_cod_cuota             OUT NOCOPY      ga_ventas.cod_cuota%TYPE,
      sv_cod_tiptarjeta        OUT NOCOPY      ga_ventas.cod_tiptarjeta%TYPE,
      sv_num_tarjeta           OUT NOCOPY      ga_ventas.num_tarjeta%TYPE,
      sv_cod_auttarj           OUT NOCOPY      ga_ventas.cod_auttarj%TYPE,
      sd_fec_vencitarj         OUT NOCOPY      ga_ventas.fec_vencitarj%TYPE,
      sv_cod_bancotarj         OUT NOCOPY      ga_ventas.cod_bancotarj%TYPE,
      sv_num_ctacorr           OUT NOCOPY      ga_ventas.num_ctacorr%TYPE,
      sv_num_cheque            OUT NOCOPY      ga_ventas.num_cheque%TYPE,
      sv_cod_banco             OUT NOCOPY      ga_ventas.cod_banco%TYPE,
      sv_cod_sucursal          OUT NOCOPY      ga_ventas.cod_sucursal%TYPE,
      sd_fec_cumplimenta       OUT NOCOPY      ga_ventas.fec_cumplimenta%TYPE,
      sd_fec_recdocum          OUT NOCOPY      ga_ventas.fec_recdocum%TYPE,
      sd_fec_aceprec           OUT NOCOPY      ga_ventas.fec_aceprec%TYPE,
      sv_nom_usuar_acerec      OUT NOCOPY      ga_ventas.nom_usuar_acerec%TYPE,
      sv_nom_usuar_recdoc      OUT NOCOPY      ga_ventas.nom_usuar_recdoc%TYPE,
      sv_nom_usuar_cumpl       OUT NOCOPY      ga_ventas.nom_usuar_cumpl%TYPE,
      sv_ind_ofiter            OUT NOCOPY      ga_ventas.ind_ofiter%TYPE,
      sn_ind_chkdicom          OUT NOCOPY      ga_ventas.ind_chkdicom%TYPE,
      sn_num_consulta          OUT NOCOPY      ga_ventas.num_consulta%TYPE,
      sn_cod_vendealer         OUT NOCOPY      ga_ventas.cod_vendealer%TYPE,
      sn_num_foldealer         OUT NOCOPY      ga_ventas.num_foldealer%TYPE,
      sn_cod_docdealer         OUT NOCOPY      ga_ventas.cod_docdealer%TYPE,
      sn_ind_doccomp           OUT NOCOPY      ga_ventas.ind_doccomp%TYPE,
      sv_obs_incump            OUT NOCOPY      ga_ventas.obs_incump%TYPE,
      sn_cod_causarep          OUT NOCOPY      ga_ventas.cod_causarep%TYPE,
      sd_fec_recprov           OUT NOCOPY      ga_ventas.fec_recprov%TYPE,
      sv_nom_usuar_recprov     OUT NOCOPY      ga_ventas.nom_usuar_recprov%TYPE,
      sn_num_dias              OUT NOCOPY      ga_ventas.num_dias%TYPE,
      sn_obs_recprov           OUT NOCOPY      ga_ventas.obs_recprov%TYPE,
      sn_imp_abono             OUT NOCOPY      ga_ventas.imp_abono%TYPE,
      sn_ind_abono             OUT NOCOPY      ga_ventas.ind_abono%TYPE,
      sd_fec_recep_admvtas     OUT NOCOPY      ga_ventas.fec_recep_admvtas%TYPE,
      sv_usu_recep_admvtas     OUT NOCOPY      ga_ventas.usu_recep_admvtas%TYPE,
      sv_obs_gralcumpl         OUT NOCOPY      ga_ventas.obs_gralcumpl%TYPE,
      sn_ind_cont_telef        OUT NOCOPY      ga_ventas.ind_cont_telef%TYPE,
      sd_fecha_cont_telef      OUT NOCOPY      ga_ventas.fecha_cont_telef%TYPE,
      sv_usuario_cont_telef    OUT NOCOPY      ga_ventas.usuario_cont_telef%TYPE,
      sn_mto_garantia          OUT NOCOPY      ga_ventas.mto_garantia%TYPE,
      sv_tip_foliacion         OUT NOCOPY      ga_ventas.tip_foliacion%TYPE,
      sn_cod_tipdocum          OUT NOCOPY      ga_ventas.cod_tipdocum%TYPE,
      sv_cod_plaza             OUT NOCOPY      ga_ventas.cod_plaza%TYPE,
      sv_cod_operadora         OUT NOCOPY      ga_ventas.cod_operadora%TYPE,
      sn_num_proceso           OUT NOCOPY      ga_ventas.num_proceso%TYPE,
     /* sn_ind_portado           OUT NOCOPY      ga_ventas.ind_portado%TYPE,*/
      sn_cod_error             OUT NOCOPY      NUMBER,
      sv_des_error             OUT NOCOPY      VARCHAR2,
      sn_num_evento            OUT NOCOPY      NUMBER) AS
      ln_sql   VARCHAR2 (1000);
   BEGIN
      sn_cod_error := 0;
      sv_des_error := NULL;
      sn_num_evento := 0;
      ln_sql := 'VE_CREA_LINEA_VENTA_QUIOSCO_PG.ge_recupera_venta_pr';
      ge_recupera_venta_pr (en_num_venta, sn_cod_producto, sv_cod_oficina, sv_cod_tipcomis, sn_cod_vendedor, sn_cod_vendedor_agente, sn_num_unidades, sd_fec_venta, sv_cod_region, sv_cod_provincia, sv_cod_ciudad, sv_ind_estventa, sn_num_transaccion,
                            sn_ind_pasocob, sv_nom_usuar_vta, sv_ind_venta, sv_cod_moneda, sv_cod_causarec, sn_imp_venta, sv_cod_tipcontrato, sv_num_contrato, sn_ind_tipventa, sn_cod_cliente, sn_cod_modventa, sn_tip_valor, sv_cod_cuota,
                            sv_cod_tiptarjeta, sv_num_tarjeta, sv_cod_auttarj, sd_fec_vencitarj, sv_cod_bancotarj, sv_num_ctacorr, sv_num_cheque, sv_cod_banco, sv_cod_sucursal, sd_fec_cumplimenta, sd_fec_recdocum, sd_fec_aceprec, sv_nom_usuar_acerec,
                            sv_nom_usuar_recdoc, sv_nom_usuar_cumpl, sv_ind_ofiter, sn_ind_chkdicom, sn_num_consulta, sn_cod_vendealer, sn_num_foldealer, sn_cod_docdealer, sn_ind_doccomp, sv_obs_incump, sn_cod_causarep, sd_fec_recprov,
                            sv_nom_usuar_recprov, sn_num_dias, sn_obs_recprov, sn_imp_abono, sn_ind_abono, sd_fec_recep_admvtas, sv_usu_recep_admvtas, sv_obs_gralcumpl, sn_ind_cont_telef, sd_fecha_cont_telef, sv_usuario_cont_telef, sn_mto_garantia,
                            sv_tip_foliacion, sn_cod_tipdocum, sv_cod_plaza, sv_cod_operadora, sn_num_proceso/*, sn_ind_portado*/, sn_cod_error, sv_des_error, sn_num_evento);
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_error := 10769;
         --IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_error,SV_des_error) THEN
         sv_des_error := 'Error en proceso de recuperación de venta';
         --END IF;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, 'GE', sv_des_error, '1.0', USER, 'GE_CONS_CATALAGO_PORTAB_PG.GE_REC_VENTA_PR', ln_sql, SQLCODE, SQLERRM);
   END;

-----------------------------------------------------------------------------------------------------------------   
   
   PROCEDURE ve_reg_byp_prepago_pr (
      en_abonado           IN               ga_abocel.num_abonado%TYPE,
      ev_ind_procequi      IN               BP_PARAM_PREPAGO_TD.IND_PROCEQUI%TYPE,
      sn_cod_retorno       OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno      OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      sn_num_evento        OUT NOCOPY       ge_errores_pg.evento
   ) 
   AS    
      lv_sql             VARCHAR2 (1000);
      LV_des_error       VARCHAR2(300);
      lv_beneficio       VARCHAR2(300);
	  ln_num_transaccion NUMBER;
	  ln_cod_error       ga_transacabo.COD_RETORNO%TYPE;
	  lv_des_cadena      ga_transacabo.des_cadena%TYPE;
	  error_transacabo   EXCEPTION;
   BEGIN

      sn_cod_retorno  := 0;
      sn_num_evento   := 0;
      sv_mens_retorno := '';
		 		
	  lv_sql := 'BP_PROMOCIONES_QUIOSCO_PG.BP_PROMOCION_OMISION_FN ('||en_abonado||',''BP'','||1||')';		          
	  lv_beneficio := BP_PROMOCIONES_QUIOSCO_PG.BP_PROMOCION_OMISION_FN (en_abonado,'BP',1);
		 
	  IF (lv_beneficio <> '-1') THEN
		 
	     lv_sql := 'SELECT GA_SEQ_TRANSACABO.NEXTVAL FROM DUAL';
		  
		 SELECT GA_SEQ_TRANSACABO.NEXTVAL 
		   INTO ln_num_transaccion 
		   FROM DUAL;
		  
		 lv_sql := 'BP_PROMOCIONES_PG.BP_PROMOCION_OMISION_PR ('||ln_num_transaccion||', '||en_abonado||',''BP'',1,''A'', '||ev_ind_procequi||',NULL,NULL,''N'')'; 
		  
		 BP_PROMOCIONES_PG.BP_PROMOCION_OMISION_PR (ln_num_transaccion,en_abonado,'BP',1,'A',ev_ind_procequi,NULL,NULL,'N');						

	     lv_sql := 'SELECT a.cod_retorno, a.des_cadena FROM ga_transacabo a WHERE a.num_transaccion = '||ln_num_transaccion;
			
         SELECT a.cod_retorno, a.des_cadena
           INTO ln_cod_error, lv_des_cadena
           FROM ga_transacabo a
          WHERE a.num_transaccion = ln_num_transaccion;
			 
	     IF (ln_cod_error <> 0 ) THEN
		    RAISE error_transacabo;
		 END IF;
			
	  ELSE 
	     sv_mens_retorno := 'No existen Beneficios configurados';
	  END IF;
		
    EXCEPTION
	    WHEN error_transacabo THEN
		   sn_cod_retorno  := ln_cod_error;
           sv_mens_retorno := lv_des_cadena;
           LV_des_error    := 'VE_CREA_LINEA_VENTA_QUIOSCO_PG.ve_reg_byp_prepago_pr; - ' || SQLERRM;
           sn_num_evento   := Ge_Errores_Pg.Grabarpl( sn_num_evento, 'VE',sv_mens_retorno,'1.0', USER, 'VE_CREA_LINEA_VENTA_QUIOSCO_PG.ve_reg_byp_prepago_pr', lv_sql, SQLCODE, lv_des_error );
		
        WHEN NO_DATA_FOUND THEN
         
           sn_cod_retorno  := 12478;
           sv_mens_retorno := 'Error,numero de abonado no existe en SCL.';
           LV_des_error    := 'VE_CREA_LINEA_VENTA_QUIOSCO_PG.ve_reg_byp_prepago_pr; - ' || SQLERRM;
           sn_num_evento   := Ge_Errores_Pg.Grabarpl( sn_num_evento, 'VE',sv_mens_retorno,'1.0', USER, 'VE_CREA_LINEA_VENTA_QUIOSCO_PG.ve_reg_byp_prepago_pr', lv_sql, SQLCODE, lv_des_error );

        WHEN OTHERS THEN
         
           sn_cod_retorno  := 12477;
           sv_mens_retorno := 'Error al obtener indice de portabilidad.';
           LV_des_error    := 'VE_CREA_LINEA_VENTA_QUIOSCO_PG.ve_reg_byp_prepago_pr; - ' || SQLERRM;
           sn_num_evento   := Ge_Errores_Pg.Grabarpl( sn_num_evento, 'VE',sv_mens_retorno,'1.0', USER, 'VE_CREA_LINEA_VENTA_QUIOSCO_PG.ve_reg_byp_prepago_pr', lv_sql, SQLCODE, lv_des_error );


    END ve_reg_byp_prepago_pr;
-----------------------------------------------------------------------------------------------------------------   
   
   
END VE_CREA_LINEA_VENTA_QUIOSCO_PG;
/
SHOW ERRORS
