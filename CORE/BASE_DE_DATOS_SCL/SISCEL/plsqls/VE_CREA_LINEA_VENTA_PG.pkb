CREATE OR REPLACE PACKAGE BODY VE_crea_linea_venta_PG IS

           PROCEDURE VE_OBTIENE_SECUENCIA_PR(EV_nomsecuencia IN VARCHAR2,
                                                                  SV_secuencia    OUT NOCOPY VARCHAR2,
                                                                  SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                          SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                          SN_num_evento   OUT NOCOPY ge_errores_pg.Evento)
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

                        LV_des_error      ge_errores_pg.DesEvent;
                    sSql              ge_errores_pg.vQuery;
                BEGIN
                         SN_cod_retorno := 0;
             SV_mens_retorno := NULL;
             SN_num_evento := 0;

                         sSql:='SELECT ' || EV_nomsecuencia || '.NEXTVAL FROM DUAL';

                         EXECUTE IMMEDIATE sSql INTO SV_secuencia;

                         EXCEPTION
                                 WHEN OTHERS THEN
                                          SN_cod_retorno:=156;
                                     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                          SV_mens_retorno:=CV_error_no_clasif;
                                     END IF;
                                     LV_des_error:='OTHERS:VE_crea_linea_venta_PG.VE_OBTIENE_SECUENCIA_PR('||EV_nomsecuencia||');- ' || SQLERRM;
                                     SN_num_evento:=Ge_Errores_Pg.Grabarpl(SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                                                 'VE_crea_linea_venta_PG.VE_OBTIENE_SECUENCIA_PR', sSql, SQLCODE, LV_des_error );
                END VE_OBTIENE_SECUENCIA_PR;

           PROCEDURE VE_obtiene_datos_vendedor_PR(EV_codvendedor    IN ve_vendedores.cod_vendedor%TYPE,
                                                                                   SV_codvende_raiz      OUT NOCOPY ve_vendedores.cod_vende_raiz%TYPE,
                                                                                   SV_codvendealer       OUT NOCOPY ve_vendealer.cod_vendealer%TYPE,
                                                                                   SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                                           SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                                   SN_num_evento     OUT NOCOPY ge_errores_pg.Evento)
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
           LV_des_error      ge_errores_pg.DesEvent;
           LV_Sql            ge_errores_pg.vQuery;

           BEGIN
                        SN_cod_retorno := 0;
            SV_mens_retorno := NULL;
            SN_num_evento := 0;


                        LV_sql:='SELECT a.cod_vende_raiz, b.cod_vendealer'
                                        || ' FROM   ve_vendedores a, ve_vendealer b'
                                        || ' WHERE  a.cod_vendedor=' || EV_codvendedor
                                        || ' AND a.cod_vendedor=b.cod_vendedor(+)';


                        SELECT a.cod_vende_raiz, b.cod_vendealer
                        INTO   SV_codvende_raiz, SV_codvendealer
                        FROM   ve_vendedores a, ve_vendealer b
                        WHERE  a.cod_vendedor=EV_codvendedor
                                   AND a.cod_vendedor=b.cod_vendedor(+);

                        EXCEPTION
                                 WHEN NO_DATA_FOUND THEN
                                          SN_cod_retorno:=1;
                                     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                          SV_mens_retorno:=CV_error_no_clasif;
                                     END IF;
                                     LV_des_error:='NO_DATA_FOUND:VE_crea_linea_venta_PG.VE_obtiene_datos_vendedor_PR('||EV_codvendedor||');- ' || SQLERRM;
                                     SN_num_evento:=Ge_Errores_Pg.Grabarpl(SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                                                 'VE_crea_linea_venta_PG.VE_obtiene_datos_vendedor_PR('||EV_codvendedor||')', LV_sql, SQLCODE, LV_des_error );
                                 WHEN OTHERS THEN
                                          SN_cod_retorno:=156;
                                     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                          SV_mens_retorno:=CV_error_no_clasif;
                                     END IF;
                                     LV_des_error:='OTHERS;VE_crea_linea_venta_PG.VE_obtiene_datos_vendedor_PR('||EV_codvendedor||');- ' || SQLERRM;
                                     SN_num_evento:=Ge_Errores_Pg.Grabarpl(SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                                                 'VE_crea_linea_venta_PG.VE_obtiene_datos_vendedor_PR('||EV_codvendedor||')', LV_sql, SQLCODE, LV_des_error );

           END VE_obtiene_datos_vendedor_PR;


           PROCEDURE VE_obtiene_datos_cliente_PR(EV_codcliente    IN ge_clientes.cod_cliente%TYPE,
                                                                                  SV_codcuenta     OUT NOCOPY ge_clientes.cod_cuenta%TYPE,
                                                                                  SV_codsubcuenta  OUT NOCOPY ga_subcuentas.cod_subcuenta%TYPE,
                                                                                  SV_nomusuario    OUT NOCOPY ge_clientes.nom_cliente%TYPE,
                                                                                  SV_nomapellido1  OUT NOCOPY ge_clientes.nom_apeclien1%TYPE,
                                                                                  SV_numident      OUT NOCOPY ge_clientes.num_ident%TYPE,
                                                                                  SV_codtipident   OUT NOCOPY ge_clientes.cod_tipident%TYPE,
                                                                                  SV_nomapellido2  OUT NOCOPY ge_clientes.nom_apeclien2%TYPE,
                                                                                  SV_fecnaciomien  OUT NOCOPY ge_clientes.fec_nacimien%TYPE,
                                                                                  SV_indestcivil   OUT NOCOPY ge_clientes.ind_estcivil%TYPE,
                                                                                  SV_indsexo       OUT NOCOPY ge_clientes.ind_sexo%TYPE,
                                                                                  SV_codactividad  OUT NOCOPY ge_clientes.cod_actividad%TYPE,
                                                                                  SV_codregion     OUT NOCOPY ge_direcciones.cod_region%TYPE,
                                                                                  SV_codciudad     OUT NOCOPY ge_direcciones.cod_ciudad%TYPE,
                                                                                  SV_codprovincia  OUT NOCOPY ge_direcciones.cod_provincia%TYPE,
                                                                                  SV_codcelda      OUT NOCOPY ge_ciudades.cod_celda%TYPE,
                                                                                  SV_codcalclien   OUT NOCOPY ge_clientes.cod_calclien%TYPE,
                                                                                  SV_indfactur     OUT NOCOPY ge_clientes.ind_factur%TYPE,
                                                                                  SV_codciclo      OUT NOCOPY ge_clientes.cod_ciclo%TYPE,
                                                                                  SV_codoperadora  OUT NOCOPY VARCHAR2,
                                                                                  SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                                          SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                                  SN_num_evento    OUT NOCOPY ge_errores_pg.Evento)
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

                LV_sql            ge_errores_pg.vquery;
                LV_des_error  ge_errores_pg.desevent;

                BEGIN
                         SN_cod_retorno := 0;
             SV_mens_retorno := NULL;
             SN_num_evento := 0;


             VE_alta_cliente_PG.Ve_getOperadoraCliente_pr(SV_codoperadora,
                                                                   SN_cod_retorno,
                                           SV_mens_retorno,
                                           SN_num_evento);

                         IF SN_cod_retorno = 0 THEN

                                 LV_sql:='SELECT a.cod_cuenta, b.cod_subcuenta, a.nom_cliente,'
                                                 || ' a.nom_apeclien1, a.num_ident, a.cod_tipident,'
                                                 || ' a.nom_apeclien2, a.fec_nacimien, a.ind_estcivil,'
                                                 || ' a.ind_sexo, a.cod_actividad, c.cod_region, c.cod_ciudad,'
                                                 || ' c.cod_provincia, e.cod_celda, a.cod_calclien,'
                                                 || ' a.ind_factur, a.cod_ciclo'
                                                 || ' FROM      ge_clientes a, ga_subcuentas b,'
                                                 || ' ge_direcciones c, ga_direccli d,'
                                                 || ' ge_ciudades e'
                                                 || ' WHERE     a.cod_cliente='||EV_codcliente
                                                 || ' AND b.cod_cuenta=a.cod_cuenta'
                                                 || ' AND d.cod_cliente=a.cod_cliente'
                                                 || ' AND d.cod_tipdireccion='||CV_tipodireccion
                                                 || ' AND c.cod_direccion=d.cod_direccion'
                                                 || ' AND e.cod_ciudad=c.cod_ciudad'
                                                 || ' AND e.cod_provincia=c.cod_provincia'
                                                 || ' AND e.cod_region=c.cod_region'
                                                 || ' AND ROWNUM=1'
                         || ' ORDER BY b.fec_alta asc';


                                 SELECT a.cod_cuenta, b.cod_subcuenta, a.nom_cliente,
                                                a.nom_apeclien1, a.num_ident, a.cod_tipident,
                                                a.nom_apeclien2, a.fec_nacimien, a.ind_estcivil,
                                                a.ind_sexo, a.cod_actividad, c.cod_region, c.cod_ciudad,
                                                c.cod_provincia, e.cod_celda, a.cod_calclien,
                                                a.ind_factur, a.cod_ciclo
                                 INTO   SV_codcuenta, SV_codsubcuenta, SV_nomusuario,
                                                SV_nomapellido1, SV_numident, SV_codtipident,
                                                SV_nomapellido2, SV_fecnaciomien, SV_indestcivil,
                                                SV_indsexo, SV_codactividad, SV_codregion,
                                                SV_codciudad, SV_codprovincia, SV_codcelda,
                                                SV_codcalclien, SV_indfactur, SV_codciclo
                                 FROM   ge_clientes a, ga_subcuentas b,
                                                ge_direcciones c, ga_direccli d,
                                                ge_ciudades e
                                 WHERE  a.cod_cliente=EV_codcliente
                                                AND b.cod_cuenta=a.cod_cuenta
                                                AND d.cod_cliente=a.cod_cliente
                                                AND d.cod_tipdireccion=CV_tipodireccion
                                                AND c.cod_direccion=d.cod_direccion
                                                AND e.cod_ciudad=c.cod_ciudad
                                                AND e.cod_provincia=c.cod_provincia
                                                AND e.cod_region=c.cod_region
                                                AND ROWNUM=1
                        ORDER BY b.fec_alta asc;

                         END IF;


                        EXCEPTION
                                         WHEN NO_DATA_FOUND THEN
                                                  SN_cod_retorno:=1;
                                      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                           SV_mens_retorno:=CV_error_no_clasif;
                                      END IF;
                                      LV_des_error:='NO_DATA_FOUND:VE_crea_linea_venta_PG.VE_obtiene_datos_cliente_PR(' || EV_codcliente || '); ' || SQLERRM;
                                      SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                                                  'VE_crea_linea_venta_PG.VE_obtiene_datos_cliente_PR(' || EV_codcliente || ')', LV_Sql, SQLCODE, LV_des_error );
                                         WHEN OTHERS THEN
                                                  SN_cod_retorno:=156;
                                      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                           SV_mens_retorno:=CV_error_no_clasif;
                                      END IF;
                                      LV_des_error:='OTHERS:VE_crea_linea_venta_PG.VE_obtiene_datos_cliente_PR(' || EV_codcliente || '); ' || SQLERRM;
                                      SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                                                  'VE_crea_linea_venta_PG.VE_obtiene_datos_cliente_PR(' || EV_codcliente || ')', LV_Sql, SQLCODE, LV_des_error );


                END VE_obtiene_datos_cliente_PR;

                PROCEDURE VE_IN_ga_usuarios_PR(EV_codusuario    IN ga_usuarios.cod_usuario%TYPE,
                                                                           EV_codcuenta         IN ga_usuarios.cod_cuenta%TYPE,
                                                                           EV_codsubcuenta      IN ga_usuarios.cod_subcuenta%TYPE,
                                                                           EV_nomusuario        IN ga_usuarios.nom_usuario%TYPE,
                                                                           EV_nomapellido1      IN ga_usuarios.nom_apellido1%TYPE,
                                                                           EV_nomapellido2      IN ga_usuarios.nom_apellido2%TYPE,
                                                                           EV_numident          IN ga_usuarios.num_ident%TYPE,
                                                                           EV_codtipident       IN ga_usuarios.cod_tipident%TYPE,
                                                                           EV_indestado         IN ga_usuarios.ind_estado%TYPE,
                                                                           EV_fecnacimien       IN VARCHAR2,
                                                                           EV_codestcivil       IN ga_usuarios.cod_estcivil%TYPE,
                                                                           EV_indsexo           IN ga_usuarios.ind_sexo%TYPE,
                                                                           EV_indtipotrab       IN ga_usuarios.ind_tipotrab%TYPE,
                                                                           EV_nomempresa        IN ga_usuarios.nom_empresa%TYPE,
                                                                           EV_codactemp         IN ga_usuarios.cod_actemp%TYPE,
                                                                           EV_codocupacion      IN ga_usuarios.cod_ocupacion%TYPE,
                                                                           EN_numpercargo       IN ga_usuarios.num_percargo%TYPE,
                                                                           EN_impbruto          IN ga_usuarios.imp_bruto%TYPE,
                                                                           EV_indprocoper       IN ga_usuarios.ind_procoper%TYPE,
                                                                           EV_codoperador       IN ga_usuarios.cod_operador%TYPE,
                                                                           EV_nomconyuge        IN ga_usuarios.nom_conyuge%TYPE,
                                                                           EV_codpinusuar       IN ga_usuarios.cod_pinusuar%TYPE,
                                                                           EV_CodEstrato    IN ga_usuarios.cod_estrato%TYPE,
                                                                           EV_EMAIL         IN ga_usuarios.email%TYPE,
                                                                           EV_NUM_TEF       IN ga_usuarios.TELEF_CONTACTO%TYPE,
                                                                           SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                                                           SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                                                           SN_num_evento    OUT NOCOPY ge_errores_pg.Evento)
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

           LV_des_error      ge_errores_pg.DesEvent;
           LV_Sql            ge_errores_pg.vQuery;
       LV_FECNACIMIEN  DATE;
	   
	   --EV_EMAIL VARCHAR2(80);
	   
                BEGIN
                         SN_cod_retorno := 0;
             SV_mens_retorno := NULL;
             SN_num_evento := 0;
			 
			 --EV_EMAIL := 'nn@nn.cl';

                     IF EV_fecnacimien IS NOT NULL THEN
                            LV_FECNACIMIEN := TO_DATE(EV_fecnacimien,'''' || VE_intermediario_PG.CV_FORMATOFECHA || '''');
             END IF;



                         LV_sql:='INSERT INTO ga_usuarios (cod_usuario, cod_cuenta, cod_subcuenta, nom_usuario, nom_apellido1, '
                                         || 'fec_alta, cod_tipident, num_ident, ind_estado, nom_apellido2, fec_nacimien, '
                                         || 'cod_estcivil, ind_sexo, ind_tipotrab, nom_empresa, cod_actemp, cod_ocupacion, '
                                         || 'num_percargo, imp_bruto, ind_procoper, cod_operador, nom_conyuge, cod_pinusuar,cod_estrato,EMAIL,TELEF_CONTACTO) '
                                         || 'VALUES (' || EV_codusuario || ',' || EV_codcuenta || ',' || EV_codsubcuenta || ','
                                         || EV_nomusuario || ',' || EV_nomapellido1 || ',' || SYSDATE || ',' || EV_codtipident || ','
                                         || EV_numident || ',' || EV_indestado || ',' || EV_nomapellido2 || ','
                                         || LV_FECNACIMIEN || ',' || EV_codestcivil
                                         || ',' || EV_indsexo || ',' || EV_indtipotrab || ',' || EV_nomempresa || ',' || EV_codactemp
                                         || ',' || EV_codocupacion || ',' || EN_numpercargo || ',' || EN_impbruto || ','
                                         || EV_indprocoper || ',' || EV_codoperador || ',' || EV_nomconyuge || ',' || EV_codpinusuar || ',' || EV_codpinusuar || ',' || EV_EMAIL || ',' || ',' || EV_NUM_TEF || ' )';

                         INSERT INTO ga_usuarios (cod_usuario, cod_cuenta, cod_subcuenta, nom_usuario, nom_apellido1,
                                                                          fec_alta, cod_tipident, num_ident, ind_estado, nom_apellido2, fec_nacimien,
                                                                          cod_estcivil, ind_sexo, ind_tipotrab, nom_empresa, cod_actemp, cod_ocupacion,
                                                                          num_percargo, imp_bruto, ind_procoper, cod_operador, nom_conyuge, cod_pinusuar,cod_estrato,email,TELEF_CONTACTO)
                         VALUES                                  (EV_codusuario, EV_codcuenta, EV_codsubcuenta, EV_nomusuario, EV_nomapellido1,
                                                                          SYSDATE, EV_codtipident, EV_numident, EV_indestado, EV_nomapellido2,
                                                                          TO_DATE(EV_fecnacimien, 'DD-MM-YYYY'), EV_codestcivil, EV_indsexo, EV_indtipotrab,
                                                                          EV_nomempresa, EV_codactemp, EV_codocupacion, EN_numpercargo, EN_impbruto,
                                                                          EV_indprocoper, EV_codoperador, EV_nomconyuge, EV_codpinusuar,EV_CodEstrato,EV_EMAIL,EV_NUM_TEF);

                         EXCEPTION
                                         WHEN OTHERS THEN
                                                  SN_cod_retorno:=156;
                                      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                           SV_mens_retorno:=CV_error_no_clasif;
                                      END IF;
                                      LV_des_error:='OTHERS:VE_crea_linea_venta_PG.VE_IN_ga_usuarios_PR(' || EV_codusuario || '); ' || SQLERRM;
                                      SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                                                  'VE_crea_linea_venta_PG.VE_IN_ga_usuarios_PR(' || EV_codusuario || ')', LV_Sql, SQLCODE, LV_des_error );

                END VE_IN_ga_usuarios_PR;


                PROCEDURE VE_OBTIENE_DATOS_GENERALES_PR(
                                                   EV_codproducto          IN ga_grpserv.cod_producto%TYPE,
                                       SV_cod_calclien     OUT NOCOPY ga_datosgener.cod_calclien%TYPE,
                                                   SV_cod_abc          OUT NOCOPY ga_datosgener.cod_abc%TYPE,
                                                   SN_cod_123          OUT NOCOPY ga_datosgener.cod_123%TYPE,
                                                   SN_codestcobros         OUT NOCOPY ga_datosgener.cod_estcobros%TYPE,
                                                   SV_codgrpsrv            OUT NOCOPY ga_grpserv.cod_grupo%TYPE,
                                                   SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
                           SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
                           SN_num_evento       OUT NOCOPY ge_errores_pg.Evento)
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
                        LV_des_error      ge_errores_pg.DesEvent;
                        sSql             ge_errores_pg.vQuery;

                BEGIN
                           SN_cod_retorno := 0;
               SV_mens_retorno := NULL;
               SN_num_evento := 0;

                       SV_cod_calclien:=NULL;
                       SV_cod_abc:=NULL;
                       SN_cod_123:=NULL;

                       sSql:='SELECT m.cod_calclien, m.cod_abc, m.cod_123, m.cod_estcobros,'
                                        ||' n.cod_grupo '
                                        ||' FROM   ga_datosgener m, ga_grpserv n'
                                        ||' WHERE  n.cod_producto='||EV_codproducto;

                       SELECT m.cod_calclien, m.cod_abc, m.cod_123, m.cod_estcobros,
                                          n.cod_grupo
                       INTO   SV_cod_calclien,SV_cod_abc, SN_cod_123, SN_codestcobros,
                                          SV_codgrpsrv
                       FROM   ga_datosgener m, ga_grpserv n
                           WHERE  n.cod_producto=EV_codproducto;


                        EXCEPTION
                        WHEN OTHERS THEN
                                        SN_cod_retorno:=156; --ERROR_NO_DATA_DATOSGENER
                                        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                             SV_mens_retorno:=CV_error_no_clasif;
                                        END IF;
                                        LV_des_error:='OTHERS:VE_crea_linea_venta_PG.VE_OBTIENE_DATOS_GENERALES_PR;- ' || SQLERRM;
                                        SN_num_evento:=Ge_Errores_Pg.Grabarpl(SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                                                        'VE_crea_linea_venta_PG.VE_OBTIENE_DATOS_GENERALES_PR', sSql, SQLCODE, LV_des_error );
                END VE_OBTIENE_DATOS_GENERALES_PR;

                PROCEDURE VE_obtiene_subalm_PR(EV_codregion      IN ge_regiones.cod_region%TYPE,
                                                                           EV_codprovincia   IN ge_provincias.cod_provincia%TYPE,
                                                                           EV_codciudad          IN ge_ciudades.cod_ciudad%TYPE,
                                                                           SV_codsubalm          OUT NOCOPY ge_celdas.cod_subalm%TYPE,
                                                                           SV_codsubalm2         OUT NOCOPY ge_celdas.cod_subalm2%TYPE,
                                                                           SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                                   SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                                   SN_num_evento     OUT NOCOPY ge_errores_pg.Evento)
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

           LV_des_error      ge_errores_pg.DesEvent;
           LV_Sql            ge_errores_pg.vQuery;

                BEGIN
                                  SN_cod_retorno := 0;
                      SV_mens_retorno := NULL;
                      SN_num_evento := 0;

                                  LV_sql:='SELECT a.cod_subalm, a.cod_subalm2'
                                                ||' FROM         ge_celdas a, ge_ciudades b, ge_ciuceldas_td c'
                                                ||' WHERE  a.cod_celda = c.cod_celda'
                                                ||' AND b.cod_region = c.cod_region'
                                                ||' AND b.cod_provincia = c.cod_provincia'
                                                ||' AND b.cod_ciudad = c.cod_ciudad'
                                                ||' AND b.cod_region = ' || EV_codregion
                                                ||' AND b.cod_provincia = ' || EV_codprovincia
                                                ||' AND b.cod_ciudad = ' || EV_codciudad;

                                  SELECT a.cod_subalm, a.cod_subalm2
                                  INTO   SV_codsubalm, SV_codsubalm2
                                  FROM   ge_celdas a, ge_ciudades b, ge_ciuceldas_td c
                                  WHERE  a.cod_celda = c.cod_celda
                                                 AND b.cod_region = c.cod_region
                                                 AND b.cod_provincia = c.cod_provincia
                                                 AND b.cod_ciudad = c.cod_ciudad
                                                 AND b.cod_region = EV_codregion
                                                 AND b.cod_provincia = EV_codprovincia
                                                 AND b.cod_ciudad = EV_codciudad;

                                  EXCEPTION
                                                   WHEN NO_DATA_FOUND THEN
                                                            SN_cod_retorno:=1;
                                                    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                                         SV_mens_retorno:=CV_error_no_clasif;
                                                    END IF;
                                                    LV_des_error:='NO_DATA_FOUND:VE_crea_linea_venta_PG.VE_obtiene_subalm_PR(' || EV_codregion || ',' || EV_codprovincia || ',' || EV_codciudad  || '); ' || SQLERRM;
                                                    SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                                                                'VE_crea_linea_venta_PG.VE_obtiene_subalm_PR(' || EV_codregion || ',' || EV_codprovincia || ',' || EV_codciudad  || ')', LV_Sql, SQLCODE, LV_des_error );
                                                   WHEN TOO_MANY_ROWS THEN
                                                            SN_cod_retorno:=156;
                                                    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                                         SV_mens_retorno:=CV_error_no_clasif;
                                                    END IF;
                                                    LV_des_error:='TOO_MANY_ROWS:VE_crea_linea_venta_PG.VE_obtiene_subalm_PR(' || EV_codregion || ',' || EV_codprovincia || ',' || EV_codciudad  || '); ' || SQLERRM;
                                                    SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                                                                'VE_crea_linea_venta_PG.VE_obtiene_subalm_PR(' || EV_codregion || ',' || EV_codprovincia || ',' || EV_codciudad  || ')', LV_Sql, SQLCODE, LV_des_error );
                                                   WHEN OTHERS THEN
                                                            SN_cod_retorno:=156;
                                                    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                                         SV_mens_retorno:=CV_error_no_clasif;
                                                    END IF;
                                                    LV_des_error:='OTHERS:VE_crea_linea_venta_PG.VE_obtiene_subalm_PR(' || EV_codregion || ',' || EV_codprovincia || ',' || EV_codciudad  || '); ' || SQLERRM;
                                                    SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                                                                'VE_crea_linea_venta_PG.VE_obtiene_subalm_PR(' || EV_codregion || ',' || EV_codprovincia || ',' || EV_codciudad  || ')', LV_Sql, SQLCODE, LV_des_error );


                END VE_obtiene_subalm_PR;


                PROCEDURE VE_obtiene_subcuentas_PR(EN_codcuenta      IN ga_subcuentas.cod_cuenta%TYPE,
                                                   SV_codsubcuenta   OUT NOCOPY ga_subcuentas.cod_subcuenta%TYPE,
                                                                                   SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                                           SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                                   SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) IS


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
            LV_des_error      ge_errores_pg.DesEvent;
            LV_Sql            ge_errores_pg.vQuery;
                BEGIN
                                  SN_cod_retorno := 0;
                      SV_mens_retorno := NULL;
                      SN_num_evento := 0;

                                  LV_sql:='SELECT subcuentas.cod_subcuenta'
                                                  || ' FROM ga_subcuentas subcuentas'
                                                  || ' WHERE subcuentas.cod_cuenta =' || EN_codcuenta
                                                  || ' AND ROWNUM <2';


                  SELECT subcuentas.cod_subcuenta
                                  INTO SV_codsubcuenta
                                  FROM ga_subcuentas subcuentas
                                  WHERE subcuentas.cod_cuenta = EN_codcuenta
                                  AND ROWNUM <2;

                  EXCEPTION
                                                   WHEN NO_DATA_FOUND THEN
                                                            SN_cod_retorno:=1;
                                                    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                                         SV_mens_retorno:=CV_error_no_clasif;
                                                    END IF;
                                                    LV_des_error:='NO_DATA_FOUND:VE_crea_linea_venta_PG.VE_obtiene_subcuentas_PR(' || EN_codcuenta || '); ' || SQLERRM;
                                                    SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                                                                'VE_crea_linea_venta_PG.VE_obtiene_subcuentas_PR(' || EN_codcuenta || ')', LV_Sql, SQLCODE, LV_des_error );
                                                   WHEN TOO_MANY_ROWS THEN
                                                            SN_cod_retorno:=156;
                                                    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                                         SV_mens_retorno:=CV_error_no_clasif;
                                                    END IF;
                                                    LV_des_error:='TOO_MANY_ROWS:VE_crea_linea_venta_PG.VE_obtiene_subcuentas_PR(' || EN_codcuenta || '); ' || SQLERRM;
                                                    SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                                                                'VE_crea_linea_venta_PG.VE_obtiene_subcuentas_PR(' || EN_codcuenta || ')', LV_Sql, SQLCODE, LV_des_error );
                                                   WHEN OTHERS THEN
                                                            SN_cod_retorno:=156;
                                                    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                                         SV_mens_retorno:=CV_error_no_clasif;
                                                    END IF;
                                                    LV_des_error:='OTHERS:VE_crea_linea_venta_PG.VE_obtiene_subcuentas_PR(' || EN_codcuenta || '); ' || SQLERRM;
                                                    SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                                                                'VE_crea_linea_venta_PG.VE_obtiene_subcuentas_PR(' || EN_codcuenta || ')', LV_Sql, SQLCODE, LV_des_error );

                END VE_obtiene_subcuentas_PR;



                PROCEDURE VE_IN_ga_abocel_PR(EV_num_abonado               IN ga_abocel.num_abonado%TYPE,
                                                                         EV_num_celular                   IN ga_abocel.num_celular%TYPE,
                                                                         EV_cod_producto                  IN ga_abocel.cod_producto%TYPE,
                                                                         EV_cod_cliente                   IN ga_abocel.cod_cliente%TYPE,
                                                                         EV_cod_cuenta                    IN ga_abocel.cod_cuenta%TYPE,
                                                                         EV_cod_subcuenta             IN ga_abocel.cod_subcuenta%TYPE,
                                                                         EV_cod_usuario                   IN ga_abocel.cod_usuario%TYPE,
                                                                         EV_cod_region                    IN ga_abocel.cod_region%TYPE,
                                                                         EV_cod_provincia                 IN ga_abocel.cod_provincia%TYPE,
                                                                         EV_cod_ciudad                    IN ga_abocel.cod_ciudad%TYPE,
                                                                         EV_cod_celda                     IN ga_abocel.cod_celda%TYPE,
                                                                         EV_cod_central                   IN ga_abocel.cod_central%TYPE,
                                                                         EV_cod_uso                               IN ga_abocel.cod_uso%TYPE,
                                                                         EV_cod_situacion                 IN ga_abocel.cod_situacion%TYPE,
                                                                         EV_ind_procalta                  IN ga_abocel.ind_procalta%TYPE,
                                                                         EV_ind_procequi                  IN ga_abocel.ind_procequi%TYPE,
                                                                         EV_cod_vendedor                  IN ga_abocel.cod_vendedor%TYPE,
                                                                         EV_cod_vendedor_agente   IN ga_abocel.cod_vendedor_agente%TYPE,
                                                                         EV_tip_plantarif                 IN ga_abocel.tip_plantarif%TYPE,
                                                                         EV_tip_terminal                  IN ga_abocel.tip_terminal%TYPE,
                                                                         EV_cod_plantarif                 IN ga_abocel.cod_plantarif%TYPE,
                                                                         EV_cod_cargobasico               IN ga_abocel.cod_cargobasico%TYPE,
                                                                         EV_cod_planserv                  IN ga_abocel.cod_planserv%TYPE,
                                                                         EV_cod_limconsumo                IN ga_abocel.cod_limconsumo%TYPE,
                                                                         EV_num_serie                     IN ga_abocel.num_serie%TYPE,
                                                                         EV_num_seriehex                  IN ga_abocel.num_seriehex%TYPE,
                                                                         EV_nom_usuarora                  IN ga_abocel.nom_usuarora%TYPE,
                                                                         EV_fec_alta                      IN VARCHAR2,
                                                                         EV_num_percontrato               IN ga_abocel.num_percontrato%TYPE,
                                                                         EV_cod_estado                    IN ga_abocel.cod_estado%TYPE,
                                                                         EV_num_seriemec                  IN ga_abocel.num_seriemec%TYPE,
                                                                         EV_cod_holding                   IN ga_abocel.cod_holding%TYPE,
                                                                         EV_cod_empresa                   IN ga_abocel.cod_empresa%TYPE,
                                                                         EV_cod_grpserv                   IN ga_abocel.cod_grpserv%TYPE,
                                                                         EV_ind_supertel                  IN ga_abocel.ind_supertel%TYPE,
                                                                         EV_num_telefija                  IN ga_abocel.num_telefija%TYPE,
                                                                         EV_cod_opredfija                 IN ga_abocel.cod_opredfija%TYPE,
                                                                         EV_cod_carrier                   IN ga_abocel.cod_carrier%TYPE,
                                                                         EV_ind_prepago                   IN ga_abocel.ind_prepago%TYPE,
                                                                         EV_ind_plexsys                   IN ga_abocel.ind_plexsys%TYPE,
                                                                         EV_cod_central_plex      IN ga_abocel.cod_central_plex%TYPE,
                                                                         EV_num_celular_plex      IN ga_abocel.num_celular_plex%TYPE,
                                                                         EV_num_venta                     IN ga_abocel.num_venta%TYPE,
                                                                         EV_cod_modventa                  IN ga_abocel.cod_modventa%TYPE,
                                                                         EV_cod_tipcontrato               IN ga_abocel.cod_tipcontrato%TYPE,
                                                                         EV_num_contrato                  IN ga_abocel.num_contrato%TYPE,
                                                                         EV_num_anexo                     IN ga_abocel.num_anexo%TYPE,
                                                                         EV_fec_cumplan                   IN VARCHAR2,
                                                                         EV_cod_credmor                   IN ga_abocel.cod_credmor%TYPE,
                                                                         EV_cod_credcon                   IN ga_abocel.cod_credcon%TYPE,
                                                                         EV_cod_ciclo                     IN ga_abocel.cod_ciclo%TYPE,
                                                                         EV_ind_factur                    IN ga_abocel.ind_factur%TYPE,
                                                                         EV_ind_suspen                    IN ga_abocel.ind_suspen%TYPE,
                                                                         EV_ind_rehabi                    IN ga_abocel.ind_rehabi%TYPE,
                                                                         EV_ind_insguias                  IN ga_abocel.ind_insguias%TYPE,
                                                                         EV_fec_fincontra                 IN VARCHAR2,
                                                                         EV_fec_recdocum                  IN VARCHAR2,
                                                                         EV_fec_cumplimen                 IN VARCHAR2,
                                                                         EV_fec_acepventa                 IN VARCHAR2,
                                                                         EV_fec_actcen                    IN VARCHAR2,
                                                                         EV_fec_baja                      IN VARCHAR2,
                                                                         EV_fec_bajacen                   IN VARCHAR2,
                                                                         EV_fec_ultmod                    IN VARCHAR2,
                                                                         EV_cod_causabaja                 IN ga_abocel.cod_causabaja%TYPE,
                                                                         EV_num_personal                  IN ga_abocel.num_personal%TYPE,
                                                                         EV_ind_seguro                    IN ga_abocel.ind_seguro%TYPE,
                                                                         EV_clase_servicio                IN ga_abocel.clase_servicio%TYPE,
                                                                         EV_perfil_abonado                IN ga_abocel.perfil_abonado%TYPE,
                                                                         EV_num_min                               IN ga_abocel.num_min%TYPE,
                                                                         EV_cod_vendealer                 IN ga_abocel.cod_vendealer%TYPE,
                                                                         EV_ind_disp                      IN ga_abocel.ind_disp%TYPE,
                                                                         EV_cod_password                  IN ga_abocel.cod_password%TYPE,
                                                                         EV_ind_password                  IN ga_abocel.ind_password%TYPE,
                                                                         EV_cod_afinidad                  IN ga_abocel.cod_afinidad%TYPE,
                                                                         EV_fec_prorroga                  IN VARCHAR2,
                                                                         EV_ind_eqprestado                IN ga_abocel.ind_eqprestado%TYPE,
                                                                         EV_flg_contdigi                  IN ga_abocel.flg_contdigi%TYPE,
                                                                         EV_fec_altantras                 IN VARCHAR2,
                                                                         EV_cod_indemnizacion             IN ga_abocel.cod_indemnizacion%TYPE,
                                                                         EV_num_imei                      IN ga_abocel.num_imei%TYPE,
                                                                         EV_cod_tecnologia                IN ga_abocel.cod_tecnologia%TYPE,
                                                                         EV_num_min_mdn                   IN ga_abocel.num_min_mdn%TYPE,
                                                                         EV_fec_activacion                IN VARCHAR2,
                                                                         EV_ind_telefono                  IN ga_abocel.ind_telefono%TYPE,
                                                                         EV_cod_oficina_principal         IN ga_abocel.cod_oficina_principal%TYPE,
                                                                         EV_cod_causa_venta               IN ga_abocel.cod_causa_venta%TYPE,
                                                                         EV_cod_operacion                 IN ga_abocel.cod_operacion%TYPE,
                                                                         EV_cod_prestacion                IN ga_abocel.COD_PRESTACION%TYPE,
                                                                         EV_MTO_VALOR_REF                 IN GA_ABOCEL.MTO_VALOR_REFERENCIA%TYPE,
                                                                         EV_COD_MONEDA                    IN GA_ABOCEL.COD_MONEDA%TYPE,
                                                                         EV_OBS_INSTANCIA                 IN GA_ABOCEL.OBS_INSTANCIA%TYPE,
                                                                         EV_TipoPrimariaCarrier           IN GA_ABOCEL.TIPO_PRIMARIACARRIER%TYPE,
                                                                         EN_IMP_LIMCONSUMO                IN GA_LCABO_TO.IMP_LIMCONS%TYPE,
                                                                         SN_cod_retorno                   OUT NOCOPY ge_errores_pg.CodError,
                                                                         SV_mens_retorno                  OUT NOCOPY ge_errores_pg.MsgError,
                                                                         SN_num_evento                    OUT NOCOPY ge_errores_pg.Evento)

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

                LV_sql        ge_errores_pg.vQuery;
                LV_des_error  ge_errores_pg.DesEvent;
                LV_SqlEjecutarc ge_errores_pg.vQuery;

                BEGIN
                         SN_cod_retorno := 0;
             SV_mens_retorno := NULL;
             SN_num_evento := 0;

                         LV_sql:='INSERT INTO ga_abocel (num_abonado, num_celular, cod_producto, cod_cliente, cod_cuenta, '
                                         || 'cod_subcuenta, cod_usuario, cod_region, cod_provincia, cod_ciudad, '
                                         || 'cod_celda, cod_central, cod_uso, cod_situacion, ind_procalta, '
                                         || 'ind_procequi, cod_vendedor, cod_vendedor_agente, tip_plantarif, '
                                         || 'tip_terminal, cod_plantarif, cod_cargobasico, cod_planserv, cod_limconsumo, '
                                         || 'num_serie, num_seriehex, nom_usuarora, fec_alta, num_percontrato, cod_estado, '
                                         || 'num_seriemec, cod_holding, cod_empresa, cod_grpserv, ind_supertel, num_telefija, '
                                         || 'cod_opredfija, cod_carrier, ind_prepago, ind_plexsys, cod_central_plex, '
                                         || 'num_celular_plex, num_venta, cod_modventa, cod_tipcontrato, num_contrato, '
                                         || 'num_anexo, fec_cumplan, cod_credmor, cod_credcon, cod_ciclo, ind_factur, ind_suspen, '
                                         || 'ind_rehabi,ind_insguias, fec_fincontra, fec_recdocum, fec_cumplimen, fec_acepventa, '
                                         || 'fec_actcen, fec_baja, fec_bajacen, fec_ultmod, cod_causabaja, num_personal, ind_seguro, '
                                         || 'clase_servicio, perfil_abonado, num_min, cod_vendealer, ind_disp, cod_password, '
                                         || 'ind_password, cod_afinidad, fec_prorroga, ind_eqprestado, flg_contdigi, fec_altantras, '
                                         || 'cod_indemnizacion, num_imei, cod_tecnologia, num_min_mdn, fec_activacion, ind_telefono, '
                                         || 'cod_oficina_principal, cod_causa_venta, cod_operacion,cod_prestacion,cod_moneda,MTO_VALOR_REFERENCIA,OBS_INSTANCIA,TIPO_PRIMARIACARRIER)'
                                         || ' VALUES (''' || EV_num_abonado || ''',''' || EV_num_celular || ''',''' || EV_cod_producto || ''',''' || EV_cod_cliente || ''',''' || EV_cod_cuenta || ''','''
                     || EV_cod_subcuenta || ''',''' || EV_cod_usuario || ''',''' || EV_cod_region ||''',''' || EV_cod_provincia || ''',''' || EV_cod_ciudad || ''','''
                                         || EV_cod_celda || ''',''' || EV_cod_central || ''',''' || EV_cod_uso || ''',''' || EV_cod_situacion || ''',''' || EV_ind_procalta || ''','''
                                         || EV_ind_procequi || ''',''' || EV_cod_vendedor ||''',''' || EV_cod_vendedor_agente || ''',''' || EV_tip_plantarif || ''','''
                                         || EV_tip_terminal || ''',''' || EV_cod_plantarif || ''',''' || EV_cod_cargobasico || ''',''' || EV_cod_planserv || ''','''
                                         || EV_cod_limconsumo || ''',''' || EV_num_serie || ''',''' || EV_num_seriehex || ''',''' || EV_nom_usuarora || ''',TO_DATE(''' || EV_fec_alta ||''',''' || 'DD-MM-YYYY HH24:MI:SS' || '''),'''
                                         || EV_num_percontrato || ''',''' ||    EV_cod_estado || ''',''' || EV_num_seriemec || ''',''' || EV_cod_holding || ''',''' || EV_cod_empresa || ''','''
                                         || EV_cod_grpserv || ''',''' ||        EV_ind_supertel || ''',''' || EV_num_telefija || ''',''' || EV_cod_opredfija || ''',''' || EV_cod_carrier || ''','''
                                         ||     EV_ind_prepago || ''',''' ||    EV_ind_plexsys || ''',''' || EV_cod_central_plex || ''',''' || EV_num_celular_plex || ''','''
                                         ||     EV_num_venta || ''',''' || EV_cod_modventa || ''',''' || EV_cod_tipcontrato || ''',''' || EV_num_contrato || ''',''' || EV_num_anexo || ''','
                                         || 'TO_DATE(''' || EV_fec_cumplan || ''',''' || 'DD-MM-YYYY HH24:MI:SS' || '''),''' || EV_cod_credmor || ''','''       || EV_cod_credcon || ''',''' || EV_cod_ciclo || ''','''
                                         || EV_ind_factur || ''',''' || EV_ind_suspen || ''',''' || EV_ind_rehabi || ''',''' || EV_ind_insguias || ''','
                                         || ' DECODE(''' || EV_fec_fincontra || ''',NULL,NULL,TO_DATE(''' || EV_fec_fincontra || ''',''' || 'DD-MM-YYYY HH24:MI:SS' || ''')), DECODE(''' || EV_fec_recdocum || ''',NULL,NULL,TO_DATE( ''' || EV_fec_recdocum || ''',''' || 'DD-MM-YYYY HH24:MI:SS' || ''')),'
                                 ||     ' DECODE(''' || EV_fec_cumplimen || ''',NULL,NULL,TO_DATE(''' || EV_fec_cumplimen || ''',''' || 'DD-MM-YYYY HH24:MI:SS' || ''')), DECODE(''' || EV_fec_acepventa || ''',NULL,NULL,TO_DATE(''' || EV_fec_acepventa ||''',''' || 'DD-MM-YYYY HH24:MI:SS' || ''')),'
                                         || ' DECODE(''' || EV_fec_actcen || ''',NULL,NULL,TO_DATE(''' || EV_fec_actcen || ''',''' || 'DD-MM-YYYY HH24:MI:SS' || ''')), DECODE(''' || EV_fec_baja || ''',NULL,NULL,TO_DATE(''' || EV_fec_baja || ''',''' || 'DD-MM-YYYY HH24:MI:SS' || ''')),'
                                         || ' DECODE(''' || EV_fec_bajacen || ''',NULL,NULL,TO_DATE(''' || EV_fec_bajacen ||''',''' || 'DD-MM-YYYY HH24:MI:SS' || ''')),DECODE(''' || EV_fec_ultmod || ''',NULL,NULL,TO_DATE(''' || EV_fec_ultmod  || ''',''' || 'DD-MM-YYYY HH24:MI:SS' || ''')),''' ||  EV_cod_causabaja || ''',''' || EV_num_personal || ''','''
                                         || EV_ind_seguro || ''',''' || EV_clase_servicio || ''',''' ||  EV_perfil_abonado || ''',''' || EV_num_min || ''',''' || EV_cod_vendealer || ''','''
                                         || '0' || ''',''' || EV_cod_password || ''',''' || EV_ind_password || ''',''' || EV_cod_afinidad || ''',DECODE(''' || EV_fec_prorroga || ''',NULL,NULL,TO_DATE(''' || EV_fec_prorroga || ''',''' || 'DD-MM-YYYY HH24:MI:SS' || ''')),'''
                                         || EV_ind_eqprestado || ''',''' ||  EV_flg_contdigi || ''',DECODE(''' || EV_fec_altantras || ''',NULL,NULL,TO_DATE(''' || EV_fec_altantras || ''',''' || 'DD-MM-YYYY HH24:MI:SS' || ''')),''' ||  EV_cod_indemnizacion || ''',''' || EV_num_imei || ''','''
                                         || EV_cod_tecnologia || ''',''' ||     EV_num_min_mdn || ''',  DECODE(''' || EV_fec_activacion || ''',NULL,NULL,TO_DATE(''' ||EV_fec_activacion || ''',''' || 'DD-MM-YYYY HH24:MI:SS' || ''')),''' ||  EV_ind_telefono || ''','''
                                         || EV_cod_oficina_principal || ''',''' || EV_cod_causa_venta || ''',''' || EV_cod_operacion || ''',''' || EV_cod_prestacion || ''',''' || EV_COD_MONEDA || ''',''' || EV_MTO_VALOR_REF || ''',''' || EV_COD_MONEDA || ''',''' || EV_OBS_INSTANCIA || ''',''' || EV_TipoPrimariaCarrier || ''''')';



                         LV_SqlEjecutarc:=LV_Sql;

                         INSERT INTO ga_abocel (num_abonado, num_celular, cod_producto, cod_cliente, cod_cuenta,
                                                                    cod_subcuenta, cod_usuario, cod_region, cod_provincia, cod_ciudad,
                                                                        cod_celda, cod_central, cod_uso, cod_situacion, ind_procalta,
                                                                        ind_procequi, cod_vendedor, cod_vendedor_agente, tip_plantarif,
                                                                        tip_terminal, cod_plantarif, cod_cargobasico, cod_planserv, cod_limconsumo,
                                                                        num_serie, num_seriehex, nom_usuarora, fec_alta, num_percontrato, cod_estado,
                                                                        num_seriemec, cod_holding, cod_empresa, cod_grpserv, ind_supertel, num_telefija,
                                                                        cod_opredfija, cod_carrier, ind_prepago, ind_plexsys, cod_central_plex,
                                                                        num_celular_plex, num_venta, cod_modventa, cod_tipcontrato, num_contrato,
                                                                        num_anexo, fec_cumplan, cod_credmor, cod_credcon, cod_ciclo, ind_factur, ind_suspen,
                                                                        ind_rehabi,ind_insguias, fec_fincontra, fec_recdocum, fec_cumplimen, fec_acepventa,
                                                                        fec_actcen, fec_baja, fec_bajacen, fec_ultmod, cod_causabaja, num_personal, ind_seguro,
                                                                        clase_servicio, perfil_abonado, num_min, cod_vendealer, ind_disp, cod_password,
                                                                        ind_password, cod_afinidad, fec_prorroga, ind_eqprestado, flg_contdigi, fec_altantras,
                                                                        cod_indemnizacion, num_imei, cod_tecnologia, num_min_mdn, fec_activacion, ind_telefono,
                                                                        cod_oficina_principal, cod_causa_venta, cod_operacion,cod_prestacion,cod_moneda,MTO_VALOR_REFERENCIA,OBS_INSTANCIA,TIPO_PRIMARIACARRIER)
                                                        VALUES (EV_num_abonado, EV_num_celular, EV_cod_producto, EV_cod_cliente, EV_cod_cuenta,
                                                                        EV_cod_subcuenta, EV_cod_usuario, EV_cod_region, EV_cod_provincia, EV_cod_ciudad,
                                                                        EV_cod_celda, EV_cod_central, EV_cod_uso, EV_cod_situacion, EV_ind_procalta,
                                                                        EV_ind_procequi, EV_cod_vendedor, EV_cod_vendedor_agente, EV_tip_plantarif,
                                                                        EV_tip_terminal, EV_cod_plantarif, EV_cod_cargobasico, EV_cod_planserv,
                                                                        EV_cod_limconsumo, EV_num_serie, EV_num_seriehex, EV_nom_usuarora, TO_DATE(EV_fec_alta,'DD-MM-YYYY HH24:MI:SS'),
                                                                        EV_num_percontrato,     EV_cod_estado, EV_num_seriemec, EV_cod_holding, EV_cod_empresa,
                                                                        EV_cod_grpserv, EV_ind_supertel, EV_num_telefija, EV_cod_opredfija, EV_cod_carrier,
                                                                        -- Ini. Inc. 63465 Rodrigo Araneda 13-03-2008
                                                                        --EV_ind_prepago,       EV_ind_plexsys, EV_cod_central_plex, EV_num_celular_plex,
                                                                        EV_ind_prepago, EV_ind_plexsys, DECODE(EV_cod_central_plex,0,NULL), DECODE(EV_num_celular_plex,0,NULL),
                                                                        -- Fin Inc. 63465 Rodrigo Araneda 13-03-2008
                                                                        EV_num_venta, EV_cod_modventa, EV_cod_tipcontrato, EV_num_contrato,     EV_num_anexo,
                                                                        TO_DATE(EV_fec_cumplan, 'DD-MM-YYYY HH24:MI:SS'),       EV_cod_credmor, EV_cod_credcon, EV_cod_ciclo,
                                                                        EV_ind_factur, EV_ind_suspen, EV_ind_rehabi, EV_ind_insguias,
                                                                        TO_DATE(EV_fec_fincontra, 'DD-MM-YYYY HH24:MI:SS'), DECODE(EV_fec_recdocum,NULL,NULL,TO_DATE(EV_fec_recdocum,'DD-MM-YYYY HH24:MI:SS')),
                                                                        DECODE(EV_fec_cumplimen,NULL,NULL,TO_DATE(EV_fec_cumplimen,'DD-MM-YYYY HH24:MI:SS')), DECODE(EV_fec_acepventa,NULL,NULL,TO_DATE(EV_fec_acepventa,'DD-MM-YYYY HH24:MI:SS')),
                                                                        DECODE(EV_fec_actcen,NULL,NULL,TO_DATE(EV_fec_actcen,'DD-MM-YYYY HH24:MI:SS')), DECODE(EV_fec_baja,NULL,NULL,TO_DATE(EV_fec_baja,'DD-MM-YYYY HH24:MI:SS')),
                                                                        DECODE(EV_fec_bajacen,NULL,NULL,TO_DATE(EV_fec_bajacen,'DD-MM-YYYY HH24:MI:SS')),TO_DATE(EV_fec_ultmod,'DD-MM-YYYY HH24:MI:SS'), EV_cod_causabaja,EV_num_personal,
                                                                        EV_ind_seguro,  EV_clase_servicio, EV_perfil_abonado, EV_num_min, DECODE(EV_cod_vendealer,0,NULL,EV_cod_Vendealer),
                                                                        1, EV_cod_password, EV_ind_password, EV_cod_afinidad, DECODE(EV_fec_prorroga,NULL,NULL,TO_DATE(EV_fec_prorroga,'DD-MM-YYYY HH24:MI:SS')),
                                                                        EV_ind_eqprestado, EV_flg_contdigi,     DECODE(EV_fec_altantras,NULL,NULL,TO_DATE(EV_fec_altantras,'DD-MM-YYYY HH24:MI:SS')), EV_cod_indemnizacion, EV_num_imei,
                                                                        EV_cod_tecnologia,      EV_num_min_mdn, DECODE(EV_fec_activacion,NULL,NULL,TO_DATE(EV_fec_activacion,'DD-MM-YYYY HH24:MI:SS')), EV_ind_telefono,
                                                                        EV_cod_oficina_principal, EV_cod_causa_venta, EV_cod_operacion,EV_cod_prestacion,EV_COD_MONEDA,DECODE(EV_MTO_VALOR_REF,0,NULL,EV_MTO_VALOR_REF),EV_OBS_INSTANCIA,EV_TipoPrimariaCarrier);

                         --Se realiza insert para tabla Limite de consumo
                         INSERT INTO GA_LCABO_TO (NUM_ABONADO,IMP_LIMCONS) 
                         VALUES(EV_num_abonado,EN_IMP_LIMCONSUMO);
                         
                         
                         
                         EXCEPTION
                                         WHEN OTHERS THEN
                                                  SN_cod_retorno:=156;
                                      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                           SV_mens_retorno:=CV_error_no_clasif;
                                      END IF;
                                      LV_des_error:='OTHERS:VE_crea_linea_venta_PG.VE_IN_ga_abocel_PR(' || EV_num_abonado || '); ' || SQLERRM;
                                      SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                                                  'VE_crea_linea_venta_PG.VE_IN_ga_abocel_PR(' || EV_num_abonado || ')', LV_Sql, SQLCODE, LV_des_error );

                END VE_IN_ga_abocel_PR;

                PROCEDURE VE_obtiene_datos_contrato_PR(EV_codproducto    IN ga_tipcontrato.cod_producto%TYPE,
                                                                                           EV_codtipcontrato IN ga_tipcontrato.cod_tipcontrato%TYPE,
                                                                                           SN_indcomodato        OUT NOCOPY     ga_tipcontrato.ind_comodato%TYPE,
                                                                                           SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                                                   SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                                           SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) IS
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
                LV_sql        ge_errores_pg.vQuery;
                LV_des_error  ge_errores_pg.DesEvent;

                BEGIN
                         SN_cod_retorno := 0;
             SV_mens_retorno := NULL;
             SN_num_evento := 0;

                         LV_sql:='SELECT ind_comodato FROM ga_tipcontrato'
                                         || ' WHERE  SYSDATE BETWEEN fec_desde AND NVL(fec_hasta, SYSDATE)'
                                         || ' AND cod_producto =' || EV_codproducto
                                         || ' AND cod_tipcontrato =' || EV_codtipcontrato;

                         SELECT ind_comodato
                         INTO   SN_indcomodato
                         FROM   ga_tipcontrato
                         WHERE  SYSDATE BETWEEN fec_desde AND NVL(fec_hasta, SYSDATE)
                                    AND cod_producto = EV_codproducto
                                    AND cod_tipcontrato =EV_codtipcontrato;

                         EXCEPTION
                                         WHEN NO_DATA_FOUND THEN
                                                  SN_cod_retorno:=1;
                                      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                           SV_mens_retorno:=CV_error_no_clasif;
                                      END IF;
                                      LV_des_error:='NO_DATA_FOUND:VE_crea_linea_venta_PG.VE_obtiene_datos_contrato_PR(' || EV_codproducto || ',' || EV_codtipcontrato || '); ' || SQLERRM;
                                      SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                                                  'VE_crea_linea_venta_PG.VE_obtiene_datos_contrato_PR(' || EV_codproducto || ',' || EV_codtipcontrato || ')', LV_Sql, SQLCODE, LV_des_error );
                                         WHEN OTHERS THEN
                                                  SN_cod_retorno:=156;
                                      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                           SV_mens_retorno:=CV_error_no_clasif;
                                      END IF;
                                      LV_des_error:='OTHERS:VE_crea_linea_venta_PG.VE_obtiene_datos_contrato_PR(' || EV_codproducto || ',' || EV_codtipcontrato || '); ' || SQLERRM;
                                      SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                                                  'VE_crea_linea_venta_PG.VE_obtiene_datos_contrato_PR(' || EV_codproducto || ',' || EV_codtipcontrato || ')', LV_Sql, SQLCODE, LV_des_error );

                END VE_obtiene_datos_contrato_PR;

                PROCEDURE VE_obtiene_planserv_PR(EV_codproducto    IN ga_planserv.cod_producto%TYPE,
                                                                                 EV_codtecnologia  IN ga_plantecplserv.cod_tecnologia%TYPE,
                                                                                 EV_codplantarif   IN ga_plantecplserv.cod_plantarif%TYPE,
                                                                                 SV_codplanserv    OUT NOCOPY ga_planserv.cod_planserv%TYPE,
                                                                                 SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                                         SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                                 SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) IS
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
                LV_sql        ge_errores_pg.vQuery;
                LV_des_error  ge_errores_pg.DesEvent;

                BEGIN
                         SN_cod_retorno := 0;
             SV_mens_retorno := NULL;
             SN_num_evento := 0;

                         LV_sql:='SELECT a.cod_planserv FROM ga_planserv a'
                                         || ' WHERE     SYSDATE BETWEEN a.fec_desde'
                                         || ' AND NVL(a.fec_hasta, SYSDATE)'
                                         || ' AND a.cod_producto =' || EV_codproducto
                                         || ' AND a.cod_planserv IN'
                                         || ' (SELECT b.cod_planserv'
                                         || ' FROM ga_plantecplserv b'
                                         ||     ' WHERE b.cod_tecnologia = ' || EV_codtecnologia
                                         ||     ' AND b.cod_plantarif =' || EV_codplantarif || ')';

                         SELECT a.cod_planserv
                         INTO   SV_codplanserv
                         FROM   ga_planserv a
                         WHERE  SYSDATE BETWEEN a.fec_desde
                                        AND NVL(a.fec_hasta, SYSDATE)
                                        AND a.cod_producto = EV_codproducto
                                        AND a.cod_planserv IN
                                                                                (SELECT b.cod_planserv
                                                                                 FROM   ga_plantecplserv b
                                                                                 WHERE  b.cod_tecnologia = EV_codtecnologia
                                                                                                AND b.cod_plantarif = EV_codplantarif);

                        EXCEPTION
                                         WHEN NO_DATA_FOUND THEN
                                                  SN_cod_retorno:=1;
                                      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                           SV_mens_retorno:=CV_error_no_clasif;
                                      END IF;
                                      LV_des_error:='NO_DATA_FOUND:VE_crea_linea_venta_PG.VE_obtiene_planserv_PR(' || EV_codproducto || ',' || EV_codtecnologia || ',' || EV_codplantarif ||  '); ' || SQLERRM;
                                      SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                                                  'VE_crea_linea_venta_PG.VE_obtiene_planserv_PR(' || EV_codproducto || ',' || EV_codtecnologia || ',' || EV_codplantarif ||  ')', LV_Sql, SQLCODE, LV_des_error );
                                         WHEN OTHERS THEN
                                                  SN_cod_retorno:=156;
                                      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                           SV_mens_retorno:=CV_error_no_clasif;
                                      END IF;
                                      LV_des_error:='OTHERS:VE_crea_linea_venta_PG.VE_obtiene_planserv_PR(' || EV_codproducto || ',' || EV_codtecnologia || ',' || EV_codplantarif ||  '); ' || SQLERRM;
                                      SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                                                  'VE_crea_linea_venta_PG.VE_obtiene_planserv_PR(' || EV_codproducto || ',' || EV_codtecnologia || ',' || EV_codplantarif ||  ')', LV_Sql, SQLCODE, LV_des_error );

                END VE_obtiene_planserv_PR;

                PROCEDURE VE_IN_GA_EQUIPABOSER_PR(EN_numabonado      IN ga_equipaboser.num_abonado%TYPE,
                                                                  EV_num_serie       IN ga_equipaboser.num_serie%TYPE,
                                                                  EN_cod_producto    IN ga_equipaboser.cod_producto%TYPE,
                                                                  EV_ind_procequi    IN ga_equipaboser.ind_procequi%TYPE,
                                                                  EV_fec_alta        IN VARCHAR2,
                                                                  EV_ind_propiedad   IN ga_equipaboser.ind_propiedad%TYPE,
                                                                  EN_cod_bodega      IN ga_equipaboser.cod_bodega%TYPE,
                                                                  EN_tipstock        IN ga_equipaboser.tip_stock%TYPE,
                                                                  EN_codarticulo     IN ga_equipaboser.cod_articulo%TYPE,
                                                                  EV_indequiacc      IN ga_equipaboser.ind_equiacc%TYPE,
                                                                  EN_cod_modventa    IN ga_equipaboser.cod_modventa%TYPE,
                                                                  EV_tip_terminal    IN ga_equipaboser.tip_terminal%TYPE,
                                                                  EN_coduso          IN ga_equipaboser.cod_uso%TYPE,
                                                                  EV_cod_cuota       IN ga_equipaboser.cod_cuota%TYPE,
                                                                  EN_cod_estado      IN ga_equipaboser.cod_estado%TYPE,
                                                                  EN_capcode         IN ga_equipaboser.cap_code%TYPE,
                                                                  EV_cod_protocolo   IN ga_equipaboser.cod_protocolo%TYPE,
                                                                  EN_num_velocidad   IN ga_equipaboser.num_velocidad%TYPE,
                                                                  EN_cod_frecuencia  IN ga_equipaboser.cod_frecuencia%TYPE,
                                                                  EN_cod_version     IN ga_equipaboser.cod_version%TYPE,
                                                                  EV_num_seriemec    IN ga_equipaboser.num_seriemec%TYPE,
                                                                  EV_des_equipo      IN ga_equipaboser.des_equipo%TYPE,
                                                                  EN_cod_paquete     IN ga_equipaboser.cod_paquete%TYPE,
                                                                  EN_num_movimiento  IN ga_equipaboser.num_movimiento%TYPE,
                                                                  EV_cod_causa       IN ga_equipaboser.cod_causa%TYPE,
                                                                  EV_ind_eqprestado  IN ga_equipaboser.ind_eqprestado%TYPE,
                                                                  EV_num_imei            IN ga_equipaboser.num_imei%TYPE,
                                                                  EV_cod_tecnologia  IN ga_equipaboser.cod_tecnologia%TYPE,
                                                                  EN_imp_cargo           IN ga_equipaboser.imp_cargo%TYPE,
                                                                  EV_tip_dto             IN ga_equipaboser.tip_dto%TYPE,
                                                                  EV_val_dto             IN ga_equipaboser.val_dto%TYPE,
                                                                  EN_precioEquipo    IN  GA_EQUIPABOSER.PRC_VENTA%TYPE,  
                                                                  SN_cod_retorno         OUT NOCOPY ge_errores_pg.CodError,
                                                  SV_mens_retorno        OUT NOCOPY ge_errores_pg.MsgError,
                                                  SN_num_evento          OUT NOCOPY ge_errores_pg.Evento)
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
              <param nom="EV_tip_dto"        Tipo="VARCHAR2" >Tipo dto</param>
              <param nom="EV_val_dto"        Tipo="VARCHAR2" >Valor dto</param>
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
                sSql          ge_errores_pg.vQuery;
                LV_des_error  ge_errores_pg.DesEvent;
                LV_SqlEjecutarc   ge_errores_pg.vQuery;

BEGIN
           SN_cod_retorno := 0;
       SV_mens_retorno := NULL;
       SN_num_evento := 0;

           sSql:='INSERT INTO ga_equipaboser (num_abonado, num_serie, cod_producto, ind_procequi, fec_alta, ind_propiedad,'
           || ' cod_bodega, tip_stock, cod_articulo, ind_equiacc, cod_modventa, tip_terminal, cod_uso, cod_cuota,'
           || ' cod_estado, cap_code, cod_protocolo, num_velocidad, cod_frecuencia, cod_version, num_seriemec,'
           || ' des_equipo, cod_paquete, num_movimiento, cod_causa, ind_eqprestado, num_imei, cod_tecnologia,'
           || ' imp_cargo, tip_dto, val_dto,prc_venta) VALUES (' || EN_numabonado || ',''' || EV_num_serie || ''','
           || EN_cod_producto || ',' || EV_ind_procequi  || ', TO_DATE(''' || EV_fec_alta || ''',''' || 'DD-MM-YYYY HH24:MI:SS' || '''), ''' || EV_ind_propiedad || ''','
           || EN_cod_bodega || ',' || EN_tipstock || ',' || EN_codarticulo || ',''' || EV_indequiacc || ''','
           || EN_cod_modventa || ',''' || EV_tip_terminal || ''',' || EN_coduso || ',''' || EV_cod_cuota || ''','
           || EN_cod_estado || ',' || EN_capcode || ',''' || EV_cod_protocolo || ''',' || EN_num_velocidad || ','
           || EN_cod_frecuencia || ',' || EN_cod_version || ',''' || EV_num_seriemec || ''',''' || EV_des_equipo || ''','
           || EN_cod_paquete || ',' || EN_num_movimiento || ',''' || EV_cod_causa || ''',''' || EV_ind_eqprestado || ''','''
           || EV_num_imei || ''',''' || EV_cod_tecnologia || ''',' || EN_imp_cargo || ',''' || EV_tip_dto || ''',''' || EV_val_dto || ''',''' || EN_precioEquipo || ''')';

           LV_SqlEjecutarc:=sSql;

           INSERT INTO ga_equipaboser (num_abonado, num_serie, cod_producto, ind_procequi, fec_alta, ind_propiedad,
                                                                   cod_bodega, tip_stock, cod_articulo, ind_equiacc, cod_modventa, tip_terminal,
                                                                   cod_uso, cod_cuota, cod_estado, cap_code, cod_protocolo, num_velocidad,
                                                                   cod_frecuencia, cod_version, num_seriemec, des_equipo, cod_paquete, num_movimiento,
                                                                   cod_causa, ind_eqprestado, num_imei, cod_tecnologia, imp_cargo, tip_dto, val_dto,prc_venta)
           VALUES (EN_numabonado, EV_num_serie, EN_cod_producto, EV_ind_procequi, TO_DATE(EV_fec_alta,'DD-MM-YYYY HH24:MI:SS'), EV_ind_propiedad, EN_cod_bodega,
                           EN_tipstock, EN_codarticulo, EV_indequiacc, EN_cod_modventa, EV_tip_terminal, EN_coduso, EV_cod_cuota,
                           EN_cod_estado, EN_capcode, EV_cod_protocolo, EN_num_velocidad, EN_cod_frecuencia, EN_cod_version,
                           EV_num_seriemec, EV_des_equipo, EN_cod_paquete, EN_num_movimiento, EV_cod_causa, EV_ind_eqprestado,
                           EV_num_imei, EV_cod_tecnologia, EN_imp_cargo, EV_tip_dto, EV_val_dto,EN_precioEquipo);


EXCEPTION
WHEN OTHERS THEN
                             SN_cod_retorno:=156;
                             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                SV_mens_retorno:=CV_error_no_clasif;
                             END IF;
                             LV_des_error:='OTHERS:VE_crea_linea_venta_PG.VE_IN_GA_EQUIPABOSER_PR('||EN_numabonado||','||EV_num_serie||','||EV_num_imei||');- ' || SQLERRM;
                             SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                                 'VE_crea_linea_venta_PG.VE_IN_GA_EQUIPABOSER_PR', sSql, SQLCODE, LV_des_error );
END VE_IN_GA_EQUIPABOSER_PR;
--------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------
PROCEDURE VE_UPD_GA_EQUIPABOSER_PR(EN_numabonado      IN ga_equipaboser.num_abonado%TYPE,
                                                                   EV_num_serie       IN ga_equipaboser.num_serie%TYPE,
                                                                   EV_num_imei            IN ga_equipaboser.num_imei%TYPE,
                                                                   SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                                   SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                                   SN_num_evento      OUT NOCOPY ge_errores_pg.Evento)
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
        LV_des_error      ge_errores_pg.DesEvent;
        sSql              ge_errores_pg.vQuery;

BEGIN
           SN_cod_retorno := 0;
       SV_mens_retorno := NULL;
       SN_num_evento := 0;

           sSql:='UPDATE ga_equipaboser';
           sSql:=sSql || ' SET num_imei=' || EV_num_imei;
           sSql:=sSql || ' WHERE  num_abonado=' || EN_numabonado;
           sSql:=sSql || ' AND num_serie=' || EV_num_serie;

           UPDATE ga_equipaboser
              SET num_imei=EV_num_imei
            WHERE num_abonado=EN_numabonado
              AND num_serie=EV_num_serie;

EXCEPTION
WHEN OTHERS THEN
                             SN_cod_retorno:=156;
                             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                SV_mens_retorno:=CV_error_no_clasif;
                             END IF;
                             LV_des_error:='OTHERS:VE_crea_linea_venta_PG.VE_UPD_GA_EQUIPABOSER_PR('||EN_numabonado||','||EV_num_serie||','||EV_num_imei||');- ' || SQLERRM;
                             SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                                 'VE_crea_linea_venta_PG.VE_UPD_GA_EQUIPABOSER_PR', sSql, SQLCODE, LV_des_error );
END VE_UPD_GA_EQUIPABOSER_PR;

                PROCEDURE VE_GET_DATOS_GENERALES_PR(
                                       SV_cod_calclien     OUT NOCOPY ga_datosgener.cod_calclien%TYPE,
                                                   SV_cod_abc          OUT NOCOPY ga_datosgener.cod_abc%TYPE,
                                                   SN_cod_123          OUT NOCOPY ga_datosgener.cod_123%TYPE,
                                                   SN_codestcobros         OUT NOCOPY ga_datosgener.cod_estcobros%TYPE,
                                                   SV_codgrpsrv            OUT NOCOPY ga_grpserv.cod_grupo%TYPE,
                                                   SV_COD_DOCANEX      OUT NOCOPY ga_datosgener.COD_DOCANEX%TYPE,
                                                   SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
                           SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
                           SN_num_evento       OUT NOCOPY ge_errores_pg.Evento)
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
                        LV_des_error      ge_errores_pg.DesEvent;
                        sSql             ge_errores_pg.vQuery;

                BEGIN
                           SN_cod_retorno := 0;
               SV_mens_retorno := NULL;
               SN_num_evento := 0;

                       SV_cod_calclien:=NULL;
                       SV_cod_abc:=NULL;
                       SN_cod_123:=NULL;

                       sSql:='SELECT m.cod_calclien, m.cod_abc, m.cod_123, m.cod_estcobros,'
                                        ||' m.COD_DOCANEX'
                                        ||' FROM   ga_datosgener m';

                       SELECT m.cod_calclien, m.cod_abc, m.cod_123, m.cod_estcobros,
                                          m.COD_DOCANEX
                       INTO   SV_cod_calclien,SV_cod_abc, SN_cod_123, SN_codestcobros,
                                          SV_COD_DOCANEX
                       FROM   ga_datosgener m;


                        EXCEPTION
                        WHEN OTHERS THEN
                                        SN_cod_retorno:=156; --ERROR_NO_DATA_DATOSGENER
                                        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                             SV_mens_retorno:=CV_error_no_clasif;
                                        END IF;
                                        LV_des_error:='OTHERS:VE_crea_linea_venta_PG.VE_GET_DATOS_GENERALES_PR;- ' || SQLERRM;
                                        SN_num_evento:=Ge_Errores_Pg.Grabarpl(SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
                                                        'VE_crea_linea_venta_PG.VE_GET_DATOS_GENERALES_PR', sSql, SQLCODE, LV_des_error );
                END VE_GET_DATOS_GENERALES_PR;
                
PROCEDURE VE_INS_USUAMIST_PR (
      EV_num_abonado   IN   ga_aboamist.num_abonado%TYPE,
      EV_cod_tipident  IN   ge_clientes.cod_tipident%TYPE,
      EV_num_ident     IN   ge_clientes.num_ident%TYPE,
      EV_cod_usuario   IN   ga_usuarios.cod_usuario%TYPE,
	  ED_FecNacim      IN   VARCHAR2,
	  EV_Nombre       IN VARCHAR2,
	  EV_Apell1       IN VARCHAR2,
	  EV_Apell2       IN VARCHAR2,
      SN_cod_retorno   IN  OUT NOCOPY       ge_errores_pg.CodError,
      SV_mens_retorno  IN  OUT NOCOPY       ge_errores_pg.MsgError,
      SN_num_evento    IN  OUT NOCOPY       ge_errores_pg.Evento)
   IS
      v_nom_usuario     ga_usuarios.nom_usuario%TYPE;
      v_nom_apellido1   ga_usuarios.nom_apellido1%TYPE;
	  v_nom_apellido2   ga_usuarios.nom_apellido2%TYPE;
	  LV_des_error   VARCHAR2(2000);
	  LV_paso VARCHAR2(1000);
   BEGIN
      
      SN_cod_retorno := 0;
      SV_mens_retorno := NULL;
      SN_num_evento := 0;
   
   
      v_nom_usuario   :=EV_Nombre;
      v_nom_apellido1 :=EV_Apell1;
	  v_nom_apellido2 :=EV_Apell2;
      LV_paso:='INSERT INTO ga_usuamist (cod_usuario, num_abonado, nom_usuario,nom_apellido1,nom_apellido2, fec_alta, cod_tipident, num_ident, fec_nacimien)';
      LV_paso:=LV_paso||' VALUES ('||EV_cod_usuario||','|| EV_num_abonado||','||v_nom_usuario||','||v_nom_apellido1||','||v_nom_apellido2||', SYSDATE, '||EV_cod_tipident||','|| EV_num_ident||',TO_DATE(ED_FecNacim, DD-MM-YYYY) )';
	  INSERT INTO ga_usuamist (cod_usuario, num_abonado, nom_usuario,nom_apellido1,nom_apellido2, fec_alta, cod_tipident, num_ident, fec_nacimien)
      VALUES (EV_cod_usuario, EV_num_abonado,v_nom_usuario,v_nom_apellido1,v_nom_apellido2, SYSDATE, EV_cod_tipident, EV_num_ident,TO_DATE(ED_FecNacim, 'DD-MM-YYYY') );
   EXCEPTION
   WHEN OTHERS THEN
            SN_cod_retorno:=156; --ERROR_NO_DATA_DATOSGENER
            IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
               SV_mens_retorno:=CV_error_no_clasif;
            END IF;
            LV_des_error:='OTHERS:VE_crea_linea_venta_PG.VE_INS_USUAMIST_PR;- ' || SQLERRM;
            SN_num_evento:=Ge_Errores_Pg.Grabarpl(SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
           'VE_crea_linea_venta_PG.VE_INS_USUAMIST_PR', LV_paso, SQLCODE, LV_des_error );
    END  VE_INS_USUAMIST_PR;
PROCEDURE p_hex(v_num IN NUMBER,v_hex IN OUT varchar2) is
BEGIN
        if v_num > 9 then
            v_hex := chr(v_num - 9 + 64);
        else
            v_hex := to_char(v_num);
        end if;
END p_hex;
    PROCEDURE p_conv_serhex(v_serie IN al_series.num_serie%type ,v_serhex IN OUT VARCHAR2 )is
        v_ser8  varchar2(8);
        v_ser3  char(3);
        v_ind number(2);
        v_int number (8);
        v_aux varchar2(8);
BEGIN
        v_ser8 := substr(ltrim(rtrim(v_serie)),4,8);
        v_ser3 := substr(ltrim(rtrim(v_serie)),1,3);
        v_int := to_number (v_ser3);
        for v_ind in 1..2 loop
           p_hex(mod(v_int,16), v_aux);
           v_serhex := nvl(v_aux || v_serhex,v_aux);
           v_int := trunc(v_int / 16);
        end loop;
        v_int := to_number (v_ser8);
        v_ser8 := null;
        for v_ind in 1..6 loop
           p_hex(mod(v_int,16), v_aux);
           v_ser8 := nvl(v_aux || v_ser8,v_aux);
           v_int := trunc(v_int / 16) ;
        end loop;
        v_serhex := v_serhex || v_ser8;
END p_conv_serhex;
  
PROCEDURE ve_insertar_ga_aboamist (
      v_num_abonado           IN       ga_aboamist.num_abonado%TYPE,
      v_cod_articulo          IN       al_articulos.cod_articulo%TYPE,
      v_num_terminal          IN       al_series.num_telefono%TYPE,
      v_cod_producto          IN       ga_aboamist.cod_producto%TYPE,
      v_cod_cliente           IN       ge_clientes.cod_cliente%TYPE,
      v_cod_cuenta            IN       NUMBER,
      v_cod_central           IN       al_series.cod_central%TYPE,
      v_cod_uso               IN       al_series.cod_uso%TYPE,
      v_cod_vendedor          IN       ga_ventas.cod_vendedor%TYPE,
      v_cod_vendedor_agente   IN       ga_ventas.cod_vendedor_agente%TYPE,
      v_num_serie             IN       al_series.num_serie%TYPE,
      v_num_venta             IN       ga_ventas.num_venta%TYPE,
      v_cod_modventa          IN       ga_ventas.cod_modventa%TYPE,
      v_cod_servicios         IN OUT   VARCHAR2,
      v_ind_telefono          IN       al_series.ind_telefono%TYPE,
      v_cod_plantarif         IN       ga_aboamist.cod_plantarif%TYPE,
      v_tip_plantarif         IN       ga_aboamist.tip_plantarif%TYPE,
      v_cod_usuario           IN       ga_usuarios.cod_usuario%TYPE,
      vs_ind_telefono         IN       al_series.ind_telefono%TYPE,
      vs_plan                 IN       al_series.PLAN%TYPE,
      vs_carga                IN       al_series.carga%TYPE,
      v_cod_tecnologia        IN       al_tecnologia.cod_tecnologia%TYPE, -- GSM
      v_imei                  IN       icc_movimiento.imei%TYPE, -- GSM
      v_cod_bodega_det        IN       npt_detalle_pedido.cod_bodega%TYPE,
	  v_min_mdn				  IN	   ga_aboamist.NUM_MIN_MDN%TYPE,
	  v_cod_celda			  IN	   GA_ABOAMIST.COD_CELDA%TYPE,
	  EN_Cliente              IN       ge_clientes.cod_cliente%type,
	  EN_Vendealer            IN       ga_aboamist.cod_vendealer%type,
      Ev_clase_servicio       IN       GA_ABOAMIST.CLASE_SERVICIO%TYPE, 
	  EV_COD_SITUACION        IN       GA_ABOAMIST.COD_SITUACION%TYPE, 
      EV_NOM_USUARORA         IN       GA_ABOAMIST.NOM_USUARORA%TYPE, 
      EV_Cod_Planserv         IN       GA_ABOAMIST.COD_PLANSERV%TYPE,
      EV_codPrestacion        IN       GA_ABOAMIST.COD_PRESTACION%TYPE,  
      EV_tipTerminal          IN       GA_ABOAMIST.TIP_TERMINAL%TYPE,
      EV_CodOperacion         IN       GA_ABOAMIST.COD_OPERACION%TYPE,
      EV_CodCausaVenta        IN       GA_ABOAMIST.COD_CAUSA_VENTA%TYPE,  
      EV_codCargoBasico       IN       GA_ABOAMIST.COD_CARGOBASICO%TYPE,
      SN_cod_retorno          IN  OUT NOCOPY  ge_errores_pg.CodError,
      SV_mens_retorno         IN  OUT NOCOPY  ge_errores_pg.MsgError,
      SN_num_evento           IN  OUT NOCOPY  ge_errores_pg.Evento   )
IS


      v_tip_terminal       al_articulos.tip_terminal%TYPE;
      v_serhex             icc_movimiento.num_serie%TYPE;
      v_clase_servicio     ga_aboamist.clase_servicio%TYPE;
      v_perfil_abonado     ga_aboamist.perfil_abonado%TYPE;
      v_cod_ciudad         ga_aboamist.cod_ciudad%TYPE;
      v_cod_region         ga_aboamist.cod_region%TYPE;
      v_cod_provincia      ga_aboamist.cod_provincia%TYPE;
	  v_cod_oficinaPrin    ga_aboamist.cod_oficina_principal%TYPE;
	  GV_mens_retorno      ge_errores_pg.MsgError;
	  LN_ClienteVendedores ve_vendedores.cod_cliente%type;
      LV_cuenta_dist       GA_cuentas.cod_cuenta%TYPE;
      LV_min               GA_ABOAMIST.NUM_MIN%TYPE;
-- COD_PASWORD , 4 ultimos digitos de la serie
   BEGIN
        
             SN_cod_retorno := 0;
             SV_mens_retorno := NULL;
             SN_num_evento := 0;
        
        
        
        GV_sSql:='	SELECT tip_terminal ';
        GV_sSql:=GV_sSql||'FROM al_articulos ';
        GV_sSql:=GV_sSql||'WHERE cod_articulo = '||v_cod_articulo;
		
        SELECT tip_terminal
        INTO v_tip_terminal
        FROM al_articulos
        WHERE cod_articulo = v_cod_articulo;
        
        
        v_tip_terminal:=EV_tipTerminal;

		   GV_sSql:='	p_conv_serhex ('||v_num_serie||', v_serhex); ';
           p_conv_serhex (v_num_serie, v_serhex);
        
        SELECT AL_FN_PREFIJO_NUMERO(v_num_terminal) 
        INTO LV_min
        from dual;
      
	BEGIN
		GV_sSql:='	SELECT b.cod_provincia, b.cod_region, b.cod_comuna ';
		GV_sSql:=GV_sSql||'FROM ga_direccli a, ge_direcciones b ';
		GV_sSql:=GV_sSql||'WHERE a.cod_cliente='||EN_Cliente;
		GV_sSql:=GV_sSql||'  AND a.cod_tipdireccion in ('||CN_tres||','|| CN_dos||')';
		GV_sSql:=GV_sSql||'  AND a.cod_direccion=b.cod_direccion';
		GV_sSql:=GV_sSql||'  AND rownum='||CN_uno;
		SELECT b.cod_provincia, b.cod_region, b.cod_comuna
		INTO v_cod_provincia, v_cod_region, v_cod_ciudad
		FROM ga_direccli a, ge_direcciones b
		WHERE a.cod_cliente=EN_Cliente
		  AND a.cod_tipdireccion in (CN_tres, CN_dos)
		  AND a.cod_direccion=b.cod_direccion
		  AND rownum=CN_uno;
	EXCEPTION
	  WHEN OTHERS THEN
		 SN_cod_retorno := 275; -- No es posible recuperar el código de dirección
		 RAISE ERROR_FN;
    END;
    
    IF V_COD_CIUDAD IS NULL THEN 
       SELECT VAL_PARAMETRO 
       INTO v_cod_ciudad
       FROM ged_parametros 
       where nom_parametro = 'CIUDAD_DEFAULT';
    END IF;
    
	BEGIN
		GV_sSql:='	SELECT COD_OFICINA_PRINCIPAL ';
	    GV_sSql:=GV_sSql||'FROM GE_CIUDADES';
	    GV_sSql:=GV_sSql||'WHERE COD_REGION = '||v_cod_region;
	    GV_sSql:=GV_sSql||'AND COD_PROVINCIA = '||v_cod_provincia;
	    GV_sSql:=GV_sSql||'AND COD_CIUDAD ='|| v_cod_ciudad;
		SELECT COD_OFICINA_PRINCIPAL
		INTO v_cod_oficinaPrin
		FROM GE_CIUDADES
		WHERE COD_REGION = v_cod_region
		AND COD_PROVINCIA = v_cod_provincia
		AND COD_CIUDAD = v_cod_ciudad;
	      -- ind_procalta, 1-interno, 0-externo
    EXCEPTION
	    WHEN NO_DATA_FOUND THEN
		  GV_sSql:='	SELECT COD_OFICCENTRAL ';
		  GV_sSql:=GV_sSql||'FROM GE_DATOSGENER';
		  SELECT COD_OFICCENTRAL
		  INTO v_cod_oficinaPrin
		  FROM GE_DATOSGENER;
    END ;

	BEGIN
	    GV_sSql:='	SELECT cod_cliente ';
		GV_sSql:=GV_sSql||'FROM ve_vendedores';
		GV_sSql:=GV_sSql||'WHERE cod_vendedor='||v_cod_vendedor;
	    SELECT cod_cliente
		INTO LN_ClienteVendedores
		FROM ve_vendedores
		WHERE cod_vendedor=v_cod_vendedor;
	EXCEPTION
			 WHEN OTHERS THEN
			     SN_cod_retorno := 1247; --Problemas al Generar OC
				 RAISE ERROR_FN;
	END;
    
    BEGIN
        Select Cod_Cuenta 
        INTO LV_cuenta_dist
        From Ge_Clientes 
        Where Cod_Cliente=Ln_Clientevendedores;
    EXCEPTION
			 WHEN OTHERS THEN
			     SN_cod_retorno := 1247; --Problemas al Generar OC
				 RAISE ERROR_FN;
	END;

      GV_sSql:= 'INSERT INTO ga_aboamist(' || v_num_abonado || ' ' || v_num_terminal || ' ' || v_cod_producto; 
      GV_sSql:=GV_sSql          || ' ' ||  v_cod_cliente || ' ' ||  LN_ClienteVendedores || ' ' || v_cod_cuenta || ' ' || LV_cuenta_dist;
      GV_sSql:=GV_sSql          || ' ' ||   v_cod_central || ' ' || v_cod_uso || ' ' || EV_COD_SITUACION || ' ' || '1';
      GV_sSql:=GV_sSql          || ' ' ||   'I' || ' ' || v_cod_vendedor || ' ' || v_cod_vendedor_agente;
      GV_sSql:=GV_sSql          || ' ' ||   v_tip_terminal || ' ' || EV_Cod_Planserv || ' ' || v_num_serie || ' ' || v_serhex;
      GV_sSql:=GV_sSql          || ' ' ||   EV_NOM_USUARORA || ' ' || 'SYSDATE' || ' ' || 'NULL' || ' ' || v_num_venta;
      GV_sSql:=GV_sSql          || ' ' ||   v_cod_modventa || ' ' || '1' || ' ' || '1' || ' ' || 'NULL';
      GV_sSql:=GV_sSql          || ' ' ||   'NULL' || ' ' || 'NULL' || ' ' || 'NULL' || ' ' || 'NULL';
      GV_sSql:=GV_sSql          || ' ' ||   'NULL' || ' ' || v_clase_servicio || ' ' || v_perfil_abonado;
      GV_sSql:=GV_sSql          || ' ' ||   EN_Vendealer || ' ' || 'NULL';
      GV_sSql:=GV_sSql          || ' ' ||   SUBSTR (v_num_serie,   LENGTH (v_num_serie) - 3, 4) || ' ' || 'NULL';
      GV_sSql:=GV_sSql          || ' ' ||   v_cod_plantarif || ' ' || v_tip_plantarif || ' ' || v_cod_usuario || ' ' || vs_plan;
      GV_sSql:=GV_sSql          || ' ' ||   vs_carga || ' ' || vs_ind_telefono || ' ' || v_cod_tecnologia || ' ' || v_imei;
      GV_sSql:=GV_sSql          || ' ' ||   v_cod_ciudad || ' ' || v_cod_region || ' ' || v_cod_provincia || ' ' || v_min_mdn || ' ' || v_cod_celda || ' ' ||v_cod_oficinaPrin || ' ' ||EV_codPrestacion || ' ' ||EV_CodOperacion || ' ' ||EV_CodCausaVenta || ' ' ||EV_codCargoBasico || ' ' ||LV_min || ')' ;
	  
      
      
      INSERT INTO ga_aboamist
                  (num_abonado, num_celular, cod_producto,
                   cod_cliente, cod_cliente_dist, cod_cuenta, cod_cuenta_dist,
                   cod_central, cod_uso, cod_situacion, ind_procalta,
                   ind_procequi, cod_vendedor, cod_vendedor_agente,
                   tip_terminal, cod_planserv, num_serie, num_seriehex,
                   nom_usuarora, fec_alta, num_seriemec, num_venta,
                   cod_modventa, ind_suspen, ind_rehabi, fec_acepventa,
                   fec_actcen, fec_baja, fec_bajacen, fec_ultmod,
                   cod_causabaja, clase_servicio, perfil_abonado,
                   cod_vendealer, ind_disp,
                   cod_password, ind_password,
                   cod_plantarif, tip_plantarif, cod_usuario, plan_kit,
                   carga_inicial, ind_telefono, cod_tecnologia, num_imei,
                   cod_ciudad, cod_region, cod_provincia, num_min_mdn, cod_celda, cod_oficina_principal,cod_prestacion,cod_operacion,cod_causa_venta,cod_cargoBasico,num_min)
           VALUES (v_num_abonado, v_num_terminal, v_cod_producto,
                   v_cod_cliente, LN_ClienteVendedores, v_cod_cuenta, LV_cuenta_dist,
                   v_cod_central, v_cod_uso, EV_COD_SITUACION, '1',
                   'I', v_cod_vendedor, v_cod_vendedor_agente,
                   v_tip_terminal, EV_Cod_Planserv, v_num_serie, v_serhex,
                   EV_NOM_USUARORA, SYSDATE, NULL, v_num_venta,
                   v_cod_modventa, 1, 1, NULL,
                   NULL, NULL, NULL, NULL,
                   NULL, v_clase_servicio, v_perfil_abonado,
                   EN_Vendealer, 1,
                   SUBSTR (v_num_serie,   LENGTH (v_num_serie) - 3, 4), NULL,
                   v_cod_plantarif, v_tip_plantarif, v_cod_usuario, vs_plan,
                   vs_carga, vs_ind_telefono, v_cod_tecnologia, v_imei,
                   v_cod_ciudad, v_cod_region, v_cod_provincia, v_min_mdn, v_cod_celda,v_cod_oficinaPrin,EV_codPrestacion,EV_CodOperacion,EV_CodCausaVenta,EV_codCargoBasico,LV_min); -- C.A.A.D. INCIDENCIA 68119 11-07-2008
	    --EXCEPTION
		--  WHEN OTHERS THEN

		--		 SN_cod_retorno := 1565; --Problemas al Generar OC
	--			 RAISE ERROR_FN;
	--	END ;
EXCEPTION
WHEN ERROR_FN THEN
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      GV_des_error:='ve_insertar_ga_aboamist - '||SQLERRM;
      SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento,CV_codmodulo,SV_mens_retorno,'1.0',USER, 'insertar_ga_aboamist',GV_sSql , SQLCODE, GV_des_error );

WHEN OTHERS THEN
      GN_cod_retorno := 1565;
      SN_cod_retorno:=  1565;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      GV_des_error:='ve_insertar_ga_aboamist - '||SQLERRM;
      SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento,CV_codmodulo,sV_mens_retorno,'1.0',USER, 'insertar_ga_aboamist',GV_sSql , SQLCODE, GV_des_error );
END ve_insertar_ga_aboamist;
   
END VE_crea_linea_venta_PG;
/
SHOW ERRORS