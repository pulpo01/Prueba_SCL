CREATE OR REPLACE PACKAGE BODY GA_SERV911CORREOFAX_PG AS


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_INSERT_GACONTACTO_PR (   EN_NUM_ABONADO      IN   GA_ABOCEL.NUM_ABONADO%TYPE,
                                      EN_COD_SERVICIO     IN   GA_CONTACTO_ABONADO_TO.COD_SERVICIO%TYPE,
                                      EN_NUM_CONTACTO     IN   GA_CONTACTO_ABONADO_TO.NUM_CONTACTO%TYPE,
                                      EV_NOM_CONTACTO     IN   GA_CONTACTO_ABONADO_TO.NOMBRE_CONTACTO%TYPE,
                                      EV_APELLIDO         IN   GA_CONTACTO_ABONADO_TO.APELLIDO1_CONTACTO%TYPE,
                                      EV_APELLIDO2        IN   GA_CONTACTO_ABONADO_TO.APELLIDO2_CONTACTO%TYPE,
                                      EV_PARENTESCO       IN   GA_CONTACTO_ABONADO_TO.COD_PARENTESCO%TYPE,
                                      EN_COD_DIRECCION    IN   GA_CONTACTO_ABONADO_TO.COD_DIRECCION%TYPE,
                                      EV_PLACA_VEHICULAR  IN   GA_CONTACTO_ABONADO_TO.PLACA_VEHICULAR%TYPE,
                                      EV_COLOR_VEHICULO   IN   GA_CONTACTO_ABONADO_TO.COLOR_VEHICULO%TYPE,
                                      EV_ANIO_VEHICULO    IN   GA_CONTACTO_ABONADO_TO.ANIO_VEHICULO%TYPE,
                                      EV_OBSERVACION      IN   GA_CONTACTO_ABONADO_TO.OBSERVACION%TYPE,
                                      EV_NOM_USUARORA     IN   GA_CONTACTO_ABONADO_TO.NOM_USUAORA%TYPE,
                                      EN_NUM_TELEFONO     IN   GA_CONTACTO_ABONADO_TO.NUM_TELEFONO%TYPE,
                                      SN_cod_retorno      OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
                                      SV_mens_retorno     OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
                                      SN_num_evento       OUT NOCOPY  ge_errores_pg.evento)
IS
  LV_des_error    ge_errores_pg.DesEvent;
  LV_sSql      ge_errores_pg.vQuery;
 BEGIN
         sn_cod_retorno  := 0;
         sv_mens_retorno := NULL;
         sn_num_evento  := 0;

         LV_sSql:= '  INSERT INTO GA_CONTACTO_ABONADO_TO (NUM_ABONADO,FEC_MODIFICACION,COD_SERVICIO,NUM_CONTACTO,'||
                                                                              '  NOMBRE_CONTACTO,APELLIDO1_CONTACTO,APELLIDO2_CONTACTO,PARENTESCO,'||
                                                                              '  COD_DIRECCION,PLACA_VEHICULAR,COLOR_VEHICULO,'||
                                                                              '  ANIO_VEHICULO,OBSERVACION,IND_VIGENTE,NOM_USUAORA,NUM_TELEFONO)'||

                      ' VALUES('||EN_NUM_ABONADO||',SYSDATE' ||','||EN_COD_SERVICIO||','||EN_NUM_CONTACTO||','||
                      EV_NOM_CONTACTO||','||EV_APELLIDO||','||EV_APELLIDO2||','||EV_PARENTESCO||','||
                      EN_COD_DIRECCION||','||EV_PLACA_VEHICULAR||','||EV_COLOR_VEHICULO||','||
                      EV_ANIO_VEHICULO||','||EV_OBSERVACION||',1'||','||EV_NOM_USUARORA||','||EN_NUM_TELEFONO||');';




          INSERT INTO GA_CONTACTO_ABONADO_TO (NUM_ABONADO,FEC_MODIFICACION,COD_SERVICIO,NUM_CONTACTO,
                NOMBRE_CONTACTO,APELLIDO1_CONTACTO,APELLIDO2_CONTACTO,COD_PARENTESCO,
                COD_DIRECCION,PLACA_VEHICULAR,COLOR_VEHICULO,
                ANIO_VEHICULO,OBSERVACION,IND_VIGENTE,NOM_USUAORA, NUM_TELEFONO)

          VALUES(EN_NUM_ABONADO,SYSDATE,EN_COD_SERVICIO,EN_NUM_CONTACTO,EV_NOM_CONTACTO,EV_APELLIDO,EV_APELLIDO2,EV_PARENTESCO
          ,EN_COD_DIRECCION,EV_PLACA_VEHICULAR,EV_COLOR_VEHICULO,EV_ANIO_VEHICULO,EV_OBSERVACION,1,EV_NOM_USUARORA,EN_NUM_TELEFONO);

 EXCEPTION
   WHEN OTHERS THEN
       SN_cod_retorno := 156;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := ' GA_INSERT_GACONTACTO_PR ('||EN_NUM_ABONADO||'); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'GA_SERV911CORREOFAX.GA_INSERT_GACONTACTO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END GA_INSERT_GACONTACTO_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE GA_INSERT_CONTACTOABONADOTT_PR (EN_NUM_ABONADO         IN   PV_CONTACTO_ABONADO_TO.NUM_ABONADO%TYPE,
                                      EV_COD_SERVICIO        IN   PV_CONTACTO_ABONADO_TO.COD_SERVICIO%TYPE,
                                      EN_NUM_CONTACTO        IN   PV_CONTACTO_ABONADO_TO.NUM_CONTACTO%TYPE,
                                      EV_NOMBRE_CONTACTO     IN   PV_CONTACTO_ABONADO_TO.NOMBRE_CONTACTO%TYPE,
                                      EV_APELLIDO1_CONTACTO  IN   PV_CONTACTO_ABONADO_TO.APELLIDO1_CONTACTO%TYPE,
                                      EV_APELLIDO2_CONTACTO  IN   PV_CONTACTO_ABONADO_TO.APELLIDO2_CONTACTO%TYPE,
                                      EV_COD_PARENTESCO      IN   PV_CONTACTO_ABONADO_TO.COD_PARENTESCO%TYPE,
                                      EN_COD_DIRECCION       IN   PV_CONTACTO_ABONADO_TO.COD_DIRECCION%TYPE,
                                      EV_PLACA_VEHICULAR     IN   PV_CONTACTO_ABONADO_TO.PLACA_VEHICULAR%TYPE,
                                      EV_COLOR_VEHICULO      IN   PV_CONTACTO_ABONADO_TO.COLOR_VEHICULO%TYPE,
                                      EN_ANIO_VEHICULO       IN   PV_CONTACTO_ABONADO_TO.ANIO_VEHICULO%TYPE,
                                      EV_OBSERVACION         IN   PV_CONTACTO_ABONADO_TO.OBSERVACION%TYPE,
                                      EV_IND_VIGENTE         IN   PV_CONTACTO_ABONADO_TO.IND_VIGENTE%TYPE,
                                      EV_NOM_USUAORA         IN   PV_CONTACTO_ABONADO_TO.NOM_USUAORA%TYPE,
                                      EV_COD_PROVINCIA       IN   PV_CONTACTO_ABONADO_TO.COD_PROVINCIA%TYPE,
                                      EV_COD_REGION          IN   PV_CONTACTO_ABONADO_TO.COD_REGION%TYPE,
                                      EV_COD_CIUDAD          IN   PV_CONTACTO_ABONADO_TO.COD_CIUDAD%TYPE,
                                      EV_COD_COMUNA          IN   PV_CONTACTO_ABONADO_TO.COD_COMUNA%TYPE,
                                      EV_NOM_CALLE           IN   PV_CONTACTO_ABONADO_TO.NOM_CALLE%TYPE,
                                      EV_NUM_CALLE           IN   PV_CONTACTO_ABONADO_TO.NUM_CALLE%TYPE,
                                      EV_NUM_PISO            IN   PV_CONTACTO_ABONADO_TO.NUM_PISO%TYPE,
                                      EV_NUM_CASILLA         IN   PV_CONTACTO_ABONADO_TO.NUM_CASILLA%TYPE,
                                      EV_OBS_DIRECCION       IN   PV_CONTACTO_ABONADO_TO.OBS_DIRECCION%TYPE,
                                      EV_DES_DIREC1          IN   PV_CONTACTO_ABONADO_TO.DES_DIREC1%TYPE,
                                      EV_DES_DIREC2          IN   PV_CONTACTO_ABONADO_TO.DES_DIREC2%TYPE,
                                      EV_COD_PUEBLO          IN   PV_CONTACTO_ABONADO_TO.COD_PUEBLO%TYPE,
                                      EV_COD_ESTADO          IN   PV_CONTACTO_ABONADO_TO.COD_ESTADO%TYPE,
                                      EV_ZIP                 IN   PV_CONTACTO_ABONADO_TO.ZIP%TYPE,
                                      EV_COD_TIPOCALLE       IN   PV_CONTACTO_ABONADO_TO.COD_TIPOCALLE%TYPE,
                                      EN_NUM_TELEFONO       IN   PV_CONTACTO_ABONADO_TO.NUM_TELEFONO%TYPE,
                                      SN_cod_retorno      OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
                                      SV_mens_retorno     OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
                                      SN_num_evento       OUT NOCOPY  ge_errores_pg.evento)
IS
  LV_des_error    ge_errores_pg.DesEvent;
  LV_sSql      ge_errores_pg.vQuery;
 BEGIN
         sn_cod_retorno  := 0;
         sv_mens_retorno := NULL;
         sn_num_evento  := 0;

         LV_sSql:= ' INSERT INTO PV_CONTACTO_ABONADO_TO '||
            ' (num_abonado, cod_servicio, num_contacto,'||
            '  nombre_contacto, apellido1_contacto,'||
            '  apellido2_contacto, cod_parentesco, cod_direccion,'||
            '  placa_vehicular, color_vehiculo, anio_vehiculo,'||
            '  observacion, ind_vigente, fec_modificacion, nom_usuaora,'||
            '  cod_provincia, cod_region, cod_ciudad, cod_comuna,'||
            '  nom_calle, num_calle, num_piso, num_casilla,'||
            '  obs_direccion, des_direc1, des_direc2, cod_pueblo,'||
            '  cod_estado, zip, cod_tipocalle, num_telefono'||
            '  )'||
          ' VALUES ('||en_num_abonado||','||ev_cod_servicio||','||en_num_contacto||','||
             ev_nombre_contacto||','||ev_apellido1_contacto||','||
             ev_apellido2_contacto||','|| ev_cod_parentesco||','||en_cod_direccion||','||
             ev_placa_vehicular||','||ev_color_vehiculo||','||en_anio_vehiculo||','||
             ev_observacion||','||ev_ind_vigente||','||SYSDATE||','||ev_nom_usuaora||','||
             ev_cod_provincia||','||ev_cod_region||','||ev_cod_ciudad||','||ev_cod_comuna||','||
             ev_nom_calle||','||ev_num_calle||','||ev_num_piso||','||ev_num_casilla||','||
             ev_obs_direccion||','||ev_des_direc1||','||ev_des_direc2||','||ev_cod_pueblo||','||
             ev_cod_estado||','||ev_zip||','||ev_cod_tipocalle||','||en_num_telefono||');';



          INSERT INTO PV_CONTACTO_ABONADO_TO
            (num_abonado, cod_servicio, num_contacto,
             nombre_contacto, apellido1_contacto,
             apellido2_contacto, cod_parentesco, cod_direccion,
             placa_vehicular, color_vehiculo, anio_vehiculo,
             observacion, ind_vigente, fec_modificacion, nom_usuaora,
             cod_provincia, cod_region, cod_ciudad, cod_comuna,
             nom_calle, num_calle, num_piso, num_casilla,
             obs_direccion, des_direc1, des_direc2, cod_pueblo,
             cod_estado, zip, cod_tipocalle, num_telefono
            )
          VALUES (en_num_abonado, ev_cod_servicio, en_num_contacto,
             ev_nombre_contacto, ev_apellido1_contacto,
             ev_apellido2_contacto, ev_cod_parentesco, en_cod_direccion,
             ev_placa_vehicular, ev_color_vehiculo, en_anio_vehiculo,
             ev_observacion, ev_ind_vigente, SYSDATE, ev_nom_usuaora,
             ev_cod_provincia, ev_cod_region, ev_cod_ciudad, ev_cod_comuna,
             ev_nom_calle, ev_num_calle, ev_num_piso, ev_num_casilla,
             ev_obs_direccion, ev_des_direc1, ev_des_direc2, ev_cod_pueblo,
             ev_cod_estado, ev_zip, ev_cod_tipocalle, en_num_telefono
            );

 EXCEPTION
   WHEN OTHERS THEN
       SN_cod_retorno := 156;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := ' GA_INSERT_GACONTACTO_PR ('||EN_NUM_ABONADO||'); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'GA_SERV911CORREOFAX.GA_INSERT_GACONTACTO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END GA_INSERT_CONTACTOABONADOTT_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE GA_GET_GACONTACTO_PR ( EN_num_abonado         IN   ga_contacto_abonado_to.num_abonado% TYPE,
                                                                     SC_cursordatos    OUT NOCOPY  REFCURSOR,
                                                                    SN_cod_retorno      OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
                                                                    SV_mens_retorno     OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
                                                                    SN_num_evento       OUT NOCOPY  ge_errores_pg.evento)
IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "GA_GET_GACONTACTO_PR "
       Lenguaje="PL/SQL"
       Fecha="02-12-2009"
       Versión="La del package"
       Diseñador="rlozano"
       Programador="rlozano"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="EO_CONTACTO.NUM_ABONADO" Tipo="estructura">Estructura de datos Numero Abonado </param>>
          </Entrada>
          <Salida>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
  LV_des_error    ge_errores_pg.DesEvent;
  LV_sSql      ge_errores_pg.vQuery;
 BEGIN
         sn_cod_retorno  := 0;
         sv_mens_retorno := NULL;
         sn_num_evento  := 0;

         LV_sSql:= '  SELECT  NUM_ABONADO,FEC_MODIFICACION,COD_SERVICIO,NUM_CONTACTO,'||
                                        '  NOMBRE_CONTACTO,APELLIDO1_CONTACTO,APELLIDO2_CONTACTO,PARENTESCO,'||
                                        '  COD_DIRECCION,PLACA_VEHICULAR,COLOR_VEHICULO,'||
                                        '  ANIO_VEHICULO,OBSERVACION,IND_VIGENTE,NOM_USUAORA'||
                            ' FROM  GA_CONTACTO_ABONADO_TO  '||
                            ' WHERE  NUM_ABONADO ='||EN_num_abonado;


           	OPEN SC_cursordatos FOR
                       SELECT  NUM_ABONADO,FEC_MODIFICACION,COD_SERVICIO,NUM_CONTACTO,NOMBRE_CONTACTO,
                                      APELLIDO1_CONTACTO,APELLIDO2_CONTACTO,COD_PARENTESCO,COD_DIRECCION,
                                      PLACA_VEHICULAR,COLOR_VEHICULO,ANIO_VEHICULO,OBSERVACION,IND_VIGENTE,NOM_USUAORA
                       FROM     GA_CONTACTO_ABONADO_TO
                       WHERE  NUM_ABONADO=EN_num_abonado;


 EXCEPTION
   WHEN OTHERS THEN
       SN_cod_retorno := 156;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := ' GA_GET_GACONTACTO_PR ('||EN_num_abonado ||'); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'GA_SERV911CORREOFAX.GA_GET_GACONTACTO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END GA_GET_GACONTACTO_PR;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE GA_GET_GACANTAC_GEDIRECC_PR ( EN_num_abonado  IN   ga_contacto_abonado_to.num_abonado% TYPE,
                                                                    EV_cod_servicio  IN   ga_contacto_abonado_to.cod_servicio% TYPE,
                                                                     SC_cursordatos    OUT NOCOPY  REFCURSOR,
                                                                    SN_cod_retorno      OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
                                                                    SV_mens_retorno     OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
                                                                    SN_num_evento       OUT NOCOPY  ge_errores_pg.evento)
IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "GA_GET_GACANTAC_GEDIRECC_PR"
       Lenguaje="PL/SQL"
       Fecha="03-29-2010"
       Versión="La del package"
       Diseñador="sventura"
       Programador="santiago ventura"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="ga_contacto_abonado_to.num_abonado" Tipo="estructura">Estructura de datos NUM_ABONADO </param>>
          </Entrada>
          <Salida>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
  LV_des_error    ge_errores_pg.DesEvent;
  LV_sSql      ge_errores_pg.vQuery;
 BEGIN
         sn_cod_retorno  := 0;
         sv_mens_retorno := NULL;
         sn_num_evento  := 0;

         LV_sSql:= 'SELECT a.num_abonado, a.cod_servicio, a.num_contacto, a.nombre_contacto,'||
                          ' a.apellido1_contacto, a.apellido2_contacto, a.cod_parentesco,'||
                          ' a.cod_direccion, a.placa_vehicular, a.color_vehiculo, a.anio_vehiculo,'||
                          ' a.observacion, a.ind_vigente, a.fec_modificacion, a.nom_usuaora, a.num_telefono,'||
                          ' b.cod_provincia, (SELECT des_provincia FROM ge_provincias WHERE cod_provincia = b.cod_provincia) AS des_provincia,'||
                          ' b.cod_region, (SELECT des_region FROM ge_regiones WHERE cod_region = b.cod_region) AS des_region,'||
                          ' b.cod_ciudad, (SELECT des_ciudad FROM ge_ciudades WHERE cod_ciudad = b.cod_ciudad) AS des_ciudad,'||
                          ' b.cod_comuna, (SELECT des_comuna FROM ge_comunas WHERE cod_comuna = b.cod_comuna) AS des_comuna,'||
                          ' b.nom_calle, b.num_calle, b.num_piso, b.num_casilla, b.obs_direccion,'||
                          ' b.des_direc1, b.des_direc2, b.cod_pueblo,(SELECT des_pueblo FROM ge_pueblos WHERE cod_pueblo = b.cod_pueblo) AS des_pueblo,'||
                          ' b.cod_estado, (SELECT des_estado FROM ge_estados WHERE cod_estado = b.cod_estado) AS des_estado, b.zip,'||
                          ' b.cod_tipocalle FROM ga_contacto_abonado_to a, ge_direcciones b'||
                    	  ' WHERE a.cod_direccion = b.cod_direccion AND a.num_abonado='||EN_num_abonado||' AND a.cod_servicio='||EV_cod_servicio;



           	OPEN SC_cursordatos FOR
                 SELECT a.num_abonado, a.cod_servicio, a.num_contacto, a.nombre_contacto,
                        a.apellido1_contacto, a.apellido2_contacto, a.cod_parentesco,
                        a.cod_direccion, a.placa_vehicular, a.color_vehiculo, a.anio_vehiculo,
                        a.observacion, a.ind_vigente, a.fec_modificacion, a.nom_usuaora, a.num_telefono,
                        b.cod_provincia,(SELECT des_provincia FROM ge_provincias WHERE cod_provincia = b.cod_provincia) AS des_provincia,
                        b.cod_region, (SELECT des_region FROM ge_regiones WHERE cod_region = b.cod_region) AS des_region,
                        b.cod_ciudad, (SELECT des_ciudad FROM ge_ciudades WHERE cod_ciudad = b.cod_ciudad) AS des_ciudad,
                        b.cod_comuna, (SELECT des_comuna FROM ge_comunas WHERE cod_comuna = b.cod_comuna) AS des_comuna,
                        b.nom_calle, b.num_calle, b.num_piso, b.num_casilla, b.obs_direccion, b.des_direc1, b.des_direc2,
                        b.cod_pueblo, (SELECT des_pueblo FROM ge_pueblos WHERE cod_pueblo = b.cod_pueblo) AS des_pueblo,
                        b.cod_estado, (SELECT des_estado FROM ge_estados WHERE cod_estado = b.cod_estado) AS des_estado,
                        b.zip,b.cod_tipocalle
                 FROM ga_contacto_abonado_to a, ge_direcciones b
                 WHERE a.cod_direccion = b.cod_direccion AND a.num_abonado=EN_num_abonado AND a.cod_servicio=EV_cod_servicio;


 EXCEPTION
   WHEN OTHERS THEN
       SN_cod_retorno := 156;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := ' GA_GET_GACANTAC_GEDIRECC_PR ('||EN_num_abonado ||'); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'GA_SERV911CORREOFAX.GA_GET_GACANTAC_GEDIRECC_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END GA_GET_GACANTAC_GEDIRECC_PR;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE GA_UPDATE_GACONTACTO_PR (   EN_NUM_ABONADO      IN   GA_ABOCEL.NUM_ABONADO%TYPE,
                                      EN_COD_SERVICIO     IN   GA_CONTACTO_ABONADO_TO.COD_SERVICIO%TYPE,
                                      EN_NUM_CONTACTO     IN   GA_CONTACTO_ABONADO_TO.NUM_CONTACTO%TYPE,
                                      EV_NOM_CONTACTO     IN   GA_CONTACTO_ABONADO_TO.NOMBRE_CONTACTO%TYPE,
                                      EV_APELLIDO         IN   GA_CONTACTO_ABONADO_TO.APELLIDO1_CONTACTO%TYPE,
                                      EV_APELLIDO2        IN   GA_CONTACTO_ABONADO_TO.APELLIDO2_CONTACTO%TYPE,
                                      EV_PARENTESCO       IN   GA_CONTACTO_ABONADO_TO.COD_PARENTESCO%TYPE,
                                      EN_COD_DIRECCION    IN   GA_CONTACTO_ABONADO_TO.COD_DIRECCION%TYPE,
                                      EV_PLACA_VEHICULAR  IN   GA_CONTACTO_ABONADO_TO.PLACA_VEHICULAR%TYPE,
                                      EV_COLOR_VEHICULO   IN   GA_CONTACTO_ABONADO_TO.COLOR_VEHICULO%TYPE,
                                      EV_ANIO_VEHICULO    IN   GA_CONTACTO_ABONADO_TO.ANIO_VEHICULO%TYPE,
                                      EV_OBSERVACION      IN   GA_CONTACTO_ABONADO_TO.OBSERVACION%TYPE,
                                      EV_NOM_USUARORA     IN   GA_CONTACTO_ABONADO_TO.NOM_USUAORA%TYPE,
                                      EV_IND_VIGENTE      IN   GA_CONTACTO_ABONADO_TO.IND_VIGENTE%TYPE,
                                      SN_cod_retorno      OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
                                      SV_mens_retorno     OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
                                      SN_num_evento       OUT NOCOPY  ge_errores_pg.evento)
IS
  LV_des_error    ge_errores_pg.DesEvent;
  LV_sSql      ge_errores_pg.vQuery;
 BEGIN
         sn_cod_retorno  := 0;
         sv_mens_retorno := NULL;
         sn_num_evento  := 0;

         LV_sSql:= ' 	UPDATE GA_CONTACTO_ABONADO_TO SET'||
                                                    '      FEC_MODIFICACION =SYSDATE' ||
                                                    --'      COD_SERVICIO    ='||EO_CONTACTO.COD_SERVICIO||','||
                                                    '      NUM_CONTACTO    ='||EN_NUM_CONTACTO||','||
                                                    '      NOMBRE_CONTACTO	='||EV_NOM_CONTACTO||','||
                                                    '      APELLIDO1_CONTACTO ='||EV_APELLIDO||','||
                                                    '      APELLIDO2_CONTACTO ='||EV_APELLIDO2||','||
                                                    '      COD_PARENTESCO	='||EV_PARENTESCO||','||
                                                    --'      COD_TIPDIRECCION ='||EV_COD_TIPDIRECCION||','||
                                                    '      COD_DIRECCION	='||EN_COD_DIRECCION||','||
                                                    '      PLACA_VEHICULAR	='||EV_PLACA_VEHICULAR||','||
                                                    '      COLOR_VEHICULO	='||EV_COLOR_VEHICULO||','||
                                                    '      ANIO_VEHICULO	='||EV_ANIO_VEHICULO||','||
                                                    '      OBSERVACION	='||EV_OBSERVACION||','||
                                                    '      IND_VIGENTE	='||EV_IND_VIGENTE||','||
                                                    '  WHERE 	NUM_ABONADO='||EN_NUM_ABONADO||','||
                                                    '      AND NUM_CONTACTO='||EN_NUM_CONTACTO;




                            	UPDATE GA_CONTACTO_ABONADO_TO SET
                                              FEC_MODIFICACION =SYSDATE,
                                              NUM_CONTACTO    =EN_NUM_CONTACTO,
                                              NOMBRE_CONTACTO	=EV_NOM_CONTACTO,
                                              APELLIDO1_CONTACTO =EV_APELLIDO,
                                              APELLIDO2_CONTACTO =EV_APELLIDO2,
                                              COD_PARENTESCO	=EV_PARENTESCO,
                                              COD_DIRECCION	=EN_COD_DIRECCION,
                                              PLACA_VEHICULAR	=EV_PLACA_VEHICULAR,
                                              COLOR_VEHICULO	=EV_COLOR_VEHICULO,
                                              ANIO_VEHICULO	=EV_ANIO_VEHICULO,
                                              OBSERVACION	=EV_OBSERVACION,
                                              IND_VIGENTE	=EV_IND_VIGENTE
                               WHERE 	      NUM_ABONADO=EN_NUM_ABONADO AND
                                              NUM_CONTACTO= EN_NUM_CONTACTO;

 EXCEPTION
   WHEN OTHERS THEN
       SN_cod_retorno := 156;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := ' GA_UPDATE_GACONTACTO_PR ('||EN_NUM_ABONADO||'); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'GA_SERV911CORREOFAX.GA_UPDATE_GACONTACTO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END GA_UPDATE_GACONTACTO_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE GA_DELETE_GACONTACTO_PR (  EN_NUM_ABONADO       IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                      EN_NUM_CONTACTO       IN GA_CONTACTO_ABONADO_TO.NUM_CONTACTO%TYPE,
                                      SN_cod_retorno      OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
                                      SV_mens_retorno     OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
                                      SN_num_evento       OUT NOCOPY  ge_errores_pg.evento)
IS
  LV_des_error    ge_errores_pg.DesEvent;
  LV_sSql      ge_errores_pg.vQuery;
 BEGIN
         sn_cod_retorno  := 0;
         sv_mens_retorno := NULL;
         sn_num_evento  := 0;

         LV_sSql:= ' DELETE  FROM GA_CONTACTO_ABONADO_TO'||
                                     '     WHERE NUM_ABONADO= '||EN_NUM_ABONADO||
                                     '             AND NUM_CONTACTO= '|| EN_NUM_CONTACTO;


                            	DELETE  FROM GA_CONTACTO_ABONADO_TO
                                            WHERE NUM_ABONADO= EN_NUM_ABONADO
                                                  AND NUM_CONTACTO= EN_NUM_CONTACTO;

 EXCEPTION
   WHEN OTHERS THEN
       SN_cod_retorno := 156;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := ' GA_DELETE_GACONTACTO_PR ('||EN_NUM_ABONADO||'); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'GA_SERV911CORREOFAX.GA_DELETE_GACONTACTO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END GA_DELETE_GACONTACTO_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_TRATAMIENTOSS_911FAX_PR (EN_NUM_ABONADO      IN  ga_abocel.NUM_ABONADO%TYPE,
                                      EV_USER             IN  VARCHAR2
                                      )
        IS

        LV_des_error                    ge_errores_pg.DesEvent;
        LV_sSql                         ge_errores_pg.vQuery;
        LV_SS_ASISTENCIA_911            ged_parametros.val_parametro%TYPE;
        LV_SS_FAX                       ged_parametros.val_parametro%TYPE;
        LN_EXISTE_SS_911    NUMBER;
        LN_EXISTE_SS_FAX    NUMBER;
        LN_NUM_FAX GA_DATABONADO_TO.NUM_FAX%TYPE;
         LV_COD_SERVICIO        PV_CONTACTO_ABONADO_TO.COD_SERVICIO%TYPE;
        LV_IND_PROCNUM GA_RESNUMCEL.IND_PROCNUM%TYPE;
        LV_CODSUBALM 	   GA_RESNUMCEL.COD_SUBALM%TYPE;
	    LN_CENTRAL 	 	   GA_RESNUMCEL.COD_CENTRAL%TYPE;
	    LN_CATEGORIA 	   GA_RESNUMCEL.COD_CAT%TYPE;
	    LN_USO 		 	   GA_RESNUMCEL.COD_USO%TYPE;
        LN_contador        NUMBER;
        SN_cod_retorno     ge_errores_pg.CodError;
        SV_mens_retorno    ge_errores_pg.MsgError;
        SN_num_evento      ge_errores_pg.Evento;
        LN_pos             NUMBER(3);
        LN_MAX             NUMBER(3);
        LN_pos2            NUMBER(3);
        LN_MAX2            NUMBER(3);
        LV_CADENA          VARCHAR2(255);
        LV_CADENA2         VARCHAR2(5);
        LV_CADENA_FINAL    VARCHAR2(255);
        lv_cod_cliente     ga_abocel.cod_cliente%type;
        lv_cod_planserv    ga_abocel.cod_planserv%type;
        lv_COD_CONCEPTO    GA_SERV911CARGO_TD.cod_concepto%type;
        lv_COD_CARGO       GA_SERV911CARGO_TD.cod_cargo%type;
        flag_eli           NUMBER(1);


        /* OCB 24-05-2010 */
        CURSOR CURSOR_CONTACTO_SERVICIO  IS
        SELECT DISTINCT (B.COD_SERVICIO)
                FROM GA_SERVSUPLABO B , GA_SERVSUPL C
                WHERE  B.NUM_ABONADO =EN_NUM_ABONADO
                AND B.COD_SERVICIO = C.COD_SERVICIO
                AND B.COD_SERVICIO IN ( SELECT A.COD_SERVICIO
                FROM GA_SERVSUPL A
                WHERE A.COD_PRODUCTO = 1  )
                AND B.IND_ESTADO >= 3
                AND TRIM(B.COD_SERVSUPL)IN (SELECT  TRIM(COD_VALOR) FROM GED_CODIGOS WHERE COD_MODULO='GA'AND NOM_TABLA ='GA_CONTACTO_ABONADO_TO' AND NOM_COLUMNA ='COD_SERVICIO')
                AND B.FEC_ALTABD   = (
                                      SELECT MAX(B.FEC_ALTABD)
                                        FROM GA_SERVSUPLABO A
                                       WHERE A.NUM_ABONADO  = B.NUM_ABONADO
                                         AND A.COD_SERVSUPL = B.COD_SERVSUPL
                                         AND A.COD_NIVEL	= B.COD_NIVEL
                                         AND A.IND_ESTADO	= B.IND_ESTADO);


        /* OCB 24-05-2010 */









        BEGIN


 --Primero Contactos:
         LV_sSql:='SELECT VAL_PARAMETRO FROM GED_PARAMETROS WHERE NOM_PARAMETRO ='|| CV_PARAM_SS911;

         SELECT VAL_PARAMETRO
         INTO LV_SS_ASISTENCIA_911
         FROM GED_PARAMETROS
         WHERE NOM_PARAMETRO = CV_PARAM_SS911;


        /* OCB 24-05-2010 */


        DELETE
        GED_CODIGOS
        WHERE COD_MODULO='GA'AND
        NOM_TABLA ='GA_CONTACTO_ABONADO_TO' AND
        NOM_COLUMNA ='COD_SERVICIO' AND
        DES_VALOR='SERVICIO ASISTENCIA 911';



        LN_pos:=0;
        LN_MAX:=LENGTH(LV_SS_ASISTENCIA_911);


        WHILE (LN_pos< NVL(LN_MAX,0)) LOOP
                LN_pos2 :=INSTR(LV_SS_ASISTENCIA_911,',');
                IF LN_POS2= 0 THEN

                    IF  LN_pos> 0 THEN
                      LV_CADENA2:= SUBSTR(LV_SS_ASISTENCIA_911,1,LN_MAX -1);
                       LN_pos := lN_MAX+1;
                   END IF;

                   IF  LN_pos= 0 THEN
                      LV_CADENA2:= SUBSTR(LV_SS_ASISTENCIA_911,1,LN_MAX);
                       LN_pos := lN_MAX+1;
                   END IF;



                ELSE

                   LV_CADENA2:= SUBSTR(LV_SS_ASISTENCIA_911,1,LN_POS2 - 1);


                END IF;

                Insert into GED_CODIGOS
                (COD_MODULO, NOM_TABLA, NOM_COLUMNA, COD_VALOR, DES_VALOR, FEC_ULTMOD, NOM_USUARIO)
                Values
               ('GA', 'GA_CONTACTO_ABONADO_TO', 'COD_SERVICIO', LV_CADENA2, 'SERVICIO ASISTENCIA 911', SYSDATE,USER);


                dbms_output.PUT_LINE('  LV_CADENA2:'||  LV_CADENA2);
                if LN_pos < lN_MAX then
                LN_pos:=LN_pos + 1;
                LV_SS_ASISTENCIA_911:=SUBSTR(LV_SS_ASISTENCIA_911,LN_POS2+1,LN_MAX);
                end if;

        END LOOP;



        LN_EXISTE_SS_911 := 0;

        SELECT COUNT(1)
        INTO LN_EXISTE_SS_911
        FROM GA_SERVSUPLABO B
        WHERE  B.NUM_ABONADO =EN_NUM_ABONADO
        AND B.COD_SERVICIO IN ( SELECT A.COD_SERVICIO
        FROM GA_SERVSUPL A
        WHERE A.COD_PRODUCTO = 1
        )
        AND B.IND_ESTADO <3
        AND TRIM(B.COD_SERVSUPL) IN (SELECT  TRIM(COD_VALOR) FROM GED_CODIGOS
                                    WHERE COD_MODULO='GA'AND NOM_TABLA ='GA_CONTACTO_ABONADO_TO' AND NOM_COLUMNA ='COD_SERVICIO')
        AND B.FEC_ALTABD   = (
                                    SELECT MAX(B.FEC_ALTABD)
                                 FROM GA_SERVSUPLABO A
                               WHERE A.NUM_ABONADO  = B.NUM_ABONADO
                                 AND A.COD_SERVSUPL = B.COD_SERVSUPL
                                   AND A.COD_NIVEL    = B.COD_NIVEL
                                   AND A.IND_ESTADO    = B.IND_ESTADO);



        IF (LN_EXISTE_SS_911 = 0) THEN



                    SELECT COUNT(1)
                    INTO LN_EXISTE_SS_911
                    FROM GA_SERVSUPLABO B
                    WHERE  B.NUM_ABONADO =EN_NUM_ABONADO
                    AND B.COD_SERVICIO IN ( SELECT A.COD_SERVICIO
                    FROM GA_SERVSUPL A
                    WHERE A.COD_PRODUCTO = 1
                    )
                    AND B.IND_ESTADO >=3
                    AND TRIM(B.COD_SERVSUPL)IN (SELECT  TRIM(COD_VALOR) FROM GED_CODIGOS
                                                WHERE COD_MODULO='GA'AND NOM_TABLA ='GA_CONTACTO_ABONADO_TO' AND NOM_COLUMNA ='COD_SERVICIO')
                    AND B.FEC_ALTABD   = (
                                          SELECT MAX(B.FEC_ALTABD)
                                            FROM GA_SERVSUPLABO A
                                           WHERE A.NUM_ABONADO  = B.NUM_ABONADO
                                             AND A.COD_SERVSUPL = B.COD_SERVSUPL
                                             AND A.COD_NIVEL	= B.COD_NIVEL
                                             AND A.IND_ESTADO	= B.IND_ESTADO)
                    AND ROWNUM= 1                                 ;



                     /* OCB 24-05-2010 */







                     IF (LN_EXISTE_SS_911 > 0) THEN


                           /* OCB 24-05-2010 */
                        OPEN CURSOR_CONTACTO_SERVICIO;
                        LOOP
                          FETCH CURSOR_CONTACTO_SERVICIO INTO LV_COD_SERVICIO;
                          EXIT WHEN CURSOR_CONTACTO_SERVICIO%NOTFOUND;
                             /* OCB 24-05-2010 */



                                        LV_sSql:='SELECT NUM_ABONADO, COD_SERVICIO, NUM_CONTACTO, NOMBRE_CONTACTO, APELLIDO1_CONTACTO,';
                                        LV_sSql:= LV_sSql || ' APELLIDO2_CONTACTO, COD_PARENTESCO, COD_DIRECCION, PLACA_VEHICULAR, COLOR_VEHICULO,';
                                        LV_sSql:= LV_sSql || ' ANIO_VEHICULO, OBSERVACION, IND_VIGENTE, FEC_MODIFICACION, NOM_USUAORA, SYSDATE, EV_USER';
                                        LV_sSql:= LV_sSql || ' FROM ga_contacto_abonado_to';
                                        LV_sSql:= LV_sSql || ' WHERE NUM_ABONADO ='|| TO_CHAR(EN_NUM_ABONADO);

                                        --pasar a historicos
                                        INSERT INTO GA_CONTACTO_ABONADO_TH
                                            (NUM_ABONADO, COD_SERVICIO, NUM_CONTACTO, NOMBRE_CONTACTO, APELLIDO1_CONTACTO,
                                             APELLIDO2_CONTACTO, COD_PARENTESCO, COD_DIRECCION, PLACA_VEHICULAR, COLOR_VEHICULO,
                                             ANIO_VEHICULO, OBSERVACION, IND_VIGENTE, FEC_MODIFICACION, NOM_USUAORA, FEC_PASOHIST,USU_PASOHIST)
                                        SELECT NUM_ABONADO, COD_SERVICIO, NUM_CONTACTO, NOMBRE_CONTACTO, APELLIDO1_CONTACTO,
                                            APELLIDO2_CONTACTO, COD_PARENTESCO, COD_DIRECCION, PLACA_VEHICULAR, COLOR_VEHICULO,
                                            ANIO_VEHICULO, OBSERVACION, IND_VIGENTE, FEC_MODIFICACION, NOM_USUAORA, SYSDATE, EV_USER
                                        FROM ga_contacto_abonado_to
                                        WHERE NUM_ABONADO=EN_NUM_ABONADO AND COD_SERVICIO =LV_COD_SERVICIO; /* OCB 24-05-2010 */

                                        begin

                                        DELETE  ge_direcciones
                                        where cod_direcciOn in (select cod_direccion FROM ga_contacto_abonado_th
                                                                WHERE NUM_ABONADO=EN_NUM_ABONADO AND COD_SERVICIO =LV_COD_SERVICIO); /* OCB 24-05-2010 */

                                         EXCEPTION
                                           WHEN OTHERS THEN
                                             NULL;

                                        END;




                                        LV_sSql:='DELETE FROM GA_CONTACTO_ABONADO_TO WHERE NUM_ABONADO ='|| TO_CHAR(EN_NUM_ABONADO);

                                        begin
                                        DELETE FROM GA_CONTACTO_ABONADO_TO WHERE NUM_ABONADO=EN_NUM_ABONADO AND COD_SERVICIO=LV_COD_SERVICIO;  /* OCB 24-05-2010 */
                                         EXCEPTION
                                           WHEN OTHERS THEN
                                             NULL;

                                        END;




                                        LV_sSql:='GA_SERV911CORREOFAX_PG.PV_CARGO_DEL911_PR();';
                                        select  cod_cliente ,cod_planserv
                                        into lv_cod_cliente ,lv_cod_planserv
                                        from ga_abocel
                                        where  num_abonado = EN_NUM_ABONADO
                                        union
                                        select  cod_cliente ,cod_planserv
                                        from ga_aboamist
                                        where  num_abonado = EN_NUM_ABONADO;

                                        flag_eli:= 1;

                                        begin
                                        SELECT A.COD_CONCEPTO,A.COD_CARGO
                                        into lv_COD_CONCEPTO,lv_COD_CARGO
                                        FROM GA_SERV911CARGO_TD A, GA_servsuplabo B
                                        WHERE b.NUM_ABONADO=EN_NUM_ABONADO
                                        AND B.COD_servicio=LV_COD_SERVICIO
                                        AND B.COD_servicio=a.cod_servicio
                                        AND B.COD_servSUPL=a.cod_servSUPL
                                        --AND TRUNC(B.FEC_BAJABD)  = TRUNC(SYSDATE)
                                        AND B.IND_ESTADO >= 3
                                        AND ROWNUM = 1;

                                        exception
                                            when  no_data_found then
                                                    flag_eli:=0;
                                        end;




                                        if flag_eli= 1 then

                                            begin

                                            --GA_SERV911CORREOFAX_PG.PV_CARGO_DEL911_PR(EN_NUM_ABONADO,lv_cod_cliente,0,lv_COD_CONCEPTO,EN_NUM_ABONADO,lv_cod_cliente,lv_cod_planserv,0,lv_COD_CARGO,to_date(sysdate,'dd-mm-yyyy'),to_date(sysdate,'dd-mm-yyyy h24:mi:ss'),EV_USER,SN_cod_retorno, SV_mens_retorno,SN_num_evento    );
                                             DELETE FA_CARGOS_REC_TO
                                             WHERE
                                             NUM_ABONADOSERV=EN_NUM_ABONADO
                                             AND COD_CLIENTESERV=lv_cod_cliente
                                             AND COD_PROD_CONTRATADO=0
                                             AND COD_CONCEPTO= lv_COD_CONCEPTO
                                             AND COD_CARGO_CONTRATADO= lv_COD_CARGO;

                                            exception
                                                when others then
                                                    null;
                                            end ;
                                        end if;

                       END LOOP;

                       CLOSE CURSOR_CONTACTO_SERVICIO;   /* OCB 24-05-2010 */


                    /* OCB 24-05-2010 */
                            DELETE
                            GED_CODIGOS
                            WHERE COD_MODULO='GA'AND
                            NOM_TABLA ='GA_CONTACTO_ABONADO_TO' AND
                            NOM_COLUMNA ='COD_SERVICIO' AND
                            DES_VALOR='SERVICIO ASISTENCIA 911';

                    /* OCB 24-05-2010 */

                   END IF;

         END IF;

         DELETE
         GED_CODIGOS
         WHERE COD_MODULO='GA'AND
         NOM_TABLA ='GA_CONTACTO_ABONADO_TO' AND
         NOM_COLUMNA ='COD_SERVICIO' AND
         DES_VALOR='SERVICIO ASISTENCIA 911';

   --Servicio Fax
        LV_sSql:='SELECT VAL_PARAMETRO FROM GED_PARAMETROS WHERE NOM_PARAMETRO ='|| CV_PARAM_SSFAX;

         SELECT VAL_PARAMETRO
         INTO LV_SS_FAX
         FROM GED_PARAMETROS
         WHERE NOM_PARAMETRO = CV_PARAM_SSFAX;

        SELECT COUNT(1)
        INTO LN_EXISTE_SS_FAX
        FROM GA_SERVSUPLABO B
        WHERE  B.NUM_ABONADO =EN_NUM_ABONADO
        AND B.COD_SERVICIO IN ( SELECT A.COD_SERVICIO
        FROM GA_SERVSUPL A
        WHERE A.COD_PRODUCTO = 1
        )
        AND B.IND_ESTADO >= 3
        AND B.COD_SERVSUPL=LV_SS_FAX
        AND B.FEC_ALTABD   = (
				   		   	  SELECT MAX(B.FEC_ALTABD)
				     		    FROM GA_SERVSUPLABO A
					           WHERE A.NUM_ABONADO  = B.NUM_ABONADO
					             AND A.COD_SERVSUPL = B.COD_SERVSUPL
					  			 AND A.COD_NIVEL	= B.COD_NIVEL
					  			 AND A.IND_ESTADO	= B.IND_ESTADO);



    IF (LN_EXISTE_SS_FAX > 0) THEN
        --Devolucion de la númeracion.

        SELECT NUM_FAX
        INTO LN_NUM_FAX
        FROM GA_DATABONADO_TO
        WHERE NUM_ABONADO=EN_NUM_ABONADO;


             --Elimina reserva de numero celular
	    LN_contador := 0;
	    SELECT COUNT(1)
		INTO LN_contador
		FROM ga_resnumcel
		WHERE num_celular = LN_NUM_FAX;

		 IF (LN_contador > 0) THEN

             SELECT IND_PROCNUM
             INTO LV_IND_PROCNUM
             FROM GA_RESNUMCEL
             WHERE NUM_CELULAR=LN_NUM_FAX;


             SELECT a.cod_subalm, a.cod_central,a.cod_cat, a.cod_uso
		     INTO   LV_codsubalm, LN_central,LN_categoria, LN_uso
		     FROM   ga_resnumcel a
		     WHERE  a.num_celular = LN_NUM_FAX
		     AND ROWNUM <=1;

             IF LV_IND_PROCNUM<> CV_REPONE_CEL_RES THEN

                      VE_Numeracion_Pg.VE_P_REPONER_NUMERACION_PR(
                      CV_REPONE_CELULAR,
                      LV_codsubalm,
                      LN_central,
                      LN_categoria,
                      LN_uso ,
                      LN_NUM_FAX,
                      SN_COD_RETORNO,
                      SV_MENS_RETORNO,
                      SN_NUM_EVENTO
                       );


			 ELSE

                     VE_Numeracion_Pg.VE_P_REPONER_NUMERACION_PR(
                     CV_REPONE_CEL_RES,
                     LV_codsubalm,
                     LN_central,
                     LN_categoria,
                     LN_uso ,
                     LN_NUM_FAX,
                     SN_COD_RETORNO,
                     SV_MENS_RETORNO,
                     SN_NUM_EVENTO
                     );

			END IF;

             --Actualizacion Datos del Abonado
             DELETE
		     FROM ga_resnumcel
			 WHERE num_celular = LN_NUM_FAX;

             UPDATE GA_DATABONADO_TO SET NUM_FAX=0
             WHERE NUM_ABONADO= EN_NUM_ABONADO;
         END IF;
    END IF;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
         NULL;
    WHEN OTHERS THEN
         NULL;

END  PV_TRATAMIENTOSS_911FAX_PR;

FUNCTION getNumFax_FN
                            (EN_numMovimiento IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE)
                            RETURN VARCHAR2 IS

LV_numFax GA_DATABONADO_TO.NUM_FAX%TYPE;
LV_NomCliente VARCHAR2(100);
LN_NUM_ABONADO GA_ABOCEL.NUM_ABONADO%TYPE;

BEGIN

     SELECT NUM_ABONADO
     INTO LN_NUM_ABONADO
     FROM ICC_MOVIMIENTO
     WHERE NUM_MOVIMIENTO=EN_numMovimiento;


     SELECT NUM_FAX
     INTO LV_numFax
     FROM GA_DATABONADO_TO
     WHERE NUM_ABONADO=LN_NUM_ABONADO;




--|  (pipe) se cambia por  <$>
--,  (coma) se cambia por  <#>
--;  (punto y coma) se cambia por  <@>

LV_nomCliente:=REPLACE(LV_numFax,'|','<$>' );
LV_nomCliente:=REPLACE(LV_numFax,',','<#>' );
LV_nomCliente:=REPLACE(LV_numFax,';','<@>' );

RETURN LV_numFax;

EXCEPTION
      WHEN OTHERS THEN
       RETURN 'ERROR AL OBTENER NUMERO DE FAX ASOCIADO AL ABONADO ' || SQLERRM;

END getNumFax_FN;
FUNCTION IC_NUMEROFAX_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_NUMEROFAX_FN"
                Lenguaje="PL/SQL"
                Fecha creación="02-2010"
                Creado por="Carlos Sellao H."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para obtener el numero de fax si aplica un servicio de FAX.</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS
        LN_num_abonado    icc_movimiento.num_abonado%TYPE;
        LV_cad_servIC     icc_movimiento.cod_servicios%TYPE;
        LV_cadserv        icc_movimiento.cod_servicios%TYPE;
        LV_serv           icc_movimiento.cod_servicios%TYPE;
        LV_nivel          icc_movimiento.cod_servicios%TYPE;
        LN_SSfax          icg_servicio.cod_servicio%TYPE;
        LV_num_fax        varchar2(20);
        LN_Found          number(2);
        LN_pos            number:=0;
        LN_cod_retorno    GE_Errores_PG.coderror;
        LV_mens_retorno   GE_Errores_PG.msgerror;
        LN_num_evento     GE_Errores_PG.evento;
        LV_des_error      VARCHAR2(512);
        sSql              GE_Errores_PG.vQuery;

BEGIN

        sSql := 'SELECT num_abonado, NVL(cod_servicios,CHR(0))';
        sSql := sSql||' INTO LN_num_abonado, LV_cad_servIC';
        sSql := sSql||' FROM icc_movimiento';
        sSql := sSql||' WHERE num_movimiento = '||EN_num_mov;

        SELECT num_abonado, NVL(cod_servicios,CHR(0))
        INTO LN_num_abonado, LV_cad_servIC
        FROM icc_movimiento
        WHERE num_movimiento = EN_num_mov;

        -- si no hay cod_servicios, no aplica, pero no es error.
        IF LV_cad_servIC = CHR(0) THEN
            RETURN CHR(0);
        END IF;


        -- Identifica el Servicio FAX.-
        sSql := 'SELECT to_number(val_parametro)';
        sSql := sSql||' INTO LN_SSfax';
        sSql := sSql||' FROM ged_parametros';
        sSql := sSql||' WHERE nom_parametro = '||CV_SS_FAX;
        sSql := sSql||' AND cod_modulo = '||CV_Modulo_GA;
        sSql := sSql||' AND cod_producto = '||CN_Producto;

        SELECT to_number(val_parametro)
        INTO LN_SSfax
        FROM ged_parametros
        WHERE nom_parametro = CV_SS_FAX
        AND cod_modulo = CV_Modulo_GA
        AND cod_producto = CN_Producto;


        -- Revisa los servicios de la cadena de servicios por si hay servicio FAX informado.
        LN_Found := 0;
        LN_pos :=1;
        -- Revisa servicio por servicio informado, para identificar si viene un servicio SDP.-
        WHILE (LN_pos< NVL(length(LV_cad_servIC),0)) LOOP
                LV_cadserv :=substr(LV_cad_servIC,LN_pos,6);
                LV_serv := substr(LV_cadserv,1,2);
                LV_nivel := substr(LV_cadserv,3,4);

                LN_Found := 0;

                -- Compara el servicio con el servicio FAX configurados en ged_parametros.
                IF TO_NUMBER(LV_serv) = LN_SSfax THEN
                    LN_Found := 1;  -- El servicio informado es un servicio FAX.-
                    EXIT;
                END IF;

                LN_pos:=LN_pos+6;
        END LOOP;


        LV_num_fax := CHR(0);

        IF LN_Found = 1 THEN
           LV_num_fax := GA_SERV911CORREOFAX_PG.getNumFax_FN(EN_num_mov);
        ELSE
           RETURN CHR(0);
        END IF;

        RETURN LV_num_fax;

EXCEPTION
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_Usuario;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_PARAMPROVISION_PG.IC_NUMEROFAX_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_PARAMPROVISION_PG.IC_NUMEROFAX_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE: NO SE PUDO OBTENER DATOS DE SERVICIO FAX-' || SQLERRM;
END;
PROCEDURE GA_UPDATE_FAX_PR        (   EN_NUM_ABONADO      IN   GA_ABOCEL.NUM_ABONADO%TYPE,
                                      EN_NUMFAX           IN   GA_DATABONADO_TO.NUM_FAX%TYPE,
                                      SN_cod_retorno      OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
                                      SV_mens_retorno     OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
                                      SN_num_evento       OUT NOCOPY  ge_errores_pg.evento)
IS
  LV_des_error    ge_errores_pg.DesEvent;
  LV_sSql      ge_errores_pg.vQuery;
 BEGIN
         sn_cod_retorno  := 0;
         sv_mens_retorno := NULL;
         sn_num_evento  := 0;

          LV_sSql:=' UPDATE GA_DATABONADO_TO'
          || ' SET NUM_FAX=' || EN_NUMFAX
          || ' WHERE NUM_ABONADO=' || EN_NUM_ABONADO;


          UPDATE GA_DATABONADO_TO
          SET NUM_FAX=EN_NUMFAX
          WHERE NUM_ABONADO=EN_NUM_ABONADO;

 EXCEPTION
   WHEN OTHERS THEN
       SN_cod_retorno := 156;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := ' GA_UPDATE_FAX_PR ('||EN_NUM_ABONADO||'); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'GA_SERV911CORREOFAX.GA_INSERT_GACONTACTO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END GA_UPDATE_FAX_PR;


PROCEDURE PV_CARGA_SS911_PR( EN_num_abonado  IN   ga_contacto_abonado_to.num_abonado% TYPE,
                                                                     SC_cursordatos    OUT NOCOPY  REFCURSOR
                                                                  )
IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_CARGA_SS911_PR"
       Lenguaje="PL/SQL"
       Fecha="03-29-2010"
       Versión="La del package"
       Diseñador="ORLANDO CABEZAS"
       Programador="ORLANDO CABEZAS"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="ga_contacto_abonado_to.num_abonado" Tipo="estructura">Estructura de datos NUM_ABONADO </param>>
          </Entrada>
          <Salida>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/

  SN_cod_retorno        ge_errores_td.cod_msgerror%TYPE;
                                                                    SV_mens_retorno      ge_errores_td.det_msgerror%TYPE;
                                                                    SN_num_evento      ge_errores_pg.evento;
        LV_des_error    ge_errores_pg.DesEvent;
        LV_sSql      ge_errores_pg.vQuery;
        LV_SS_ASISTENCIA_911            ged_parametros.val_parametro%TYPE;
        LN_EXISTE_SS_911    NUMBER;
        LN_contador         NUMBER;
        LN_pos              NUMBER(3);
        LN_MAX              NUMBER(3);
        LN_pos2             NUMBER(3);
        LN_MAX2            NUMBER(3);
        LV_CADENA          VARCHAR2(255);
        LV_CADENA2          VARCHAR2(5);
        LV_CADENA_FINAL    VARCHAR2(255);


 BEGIN
         sn_cod_retorno  := 0;
         sv_mens_retorno := NULL;
         sn_num_evento  := 0;

        LV_sSql:='SELECT VAL_PARAMETRO FROM GED_PARAMETROS WHERE NOM_PARAMETRO ='|| CV_PARAM_SS911;

        SELECT VAL_PARAMETRO
        INTO LV_SS_ASISTENCIA_911
        FROM GED_PARAMETROS
        WHERE NOM_PARAMETRO = CV_PARAM_SS911;

        LN_pos:=0;
        LN_MAX:=LENGTH(LV_SS_ASISTENCIA_911);


        WHILE (LN_pos< NVL(LN_MAX,0)) LOOP
                LN_pos2 :=INSTR(LV_SS_ASISTENCIA_911,',');


                IF LN_POS2= 0 THEN

                    IF  LN_pos> 0 THEN
                      LV_CADENA2:= SUBSTR(LV_SS_ASISTENCIA_911,1,LN_MAX -1);
                       LN_pos := lN_MAX+1;
                   END IF;

                   IF  LN_pos= 0 THEN
                      LV_CADENA2:= SUBSTR(LV_SS_ASISTENCIA_911,1,LN_MAX);
                       LN_pos := lN_MAX+1;
                   END IF;



                ELSE

                   LV_CADENA2:= SUBSTR(LV_SS_ASISTENCIA_911,1,LN_POS2 - 1);


                END IF;




                --IF LN_POS2= 0 THEN

                --  LV_CADENA2:= SUBSTR(LV_SS_ASISTENCIA_911,1,LN_MAX -1);
                --  LN_pos := lN_MAX+1;
                --LSE

                 -- LV_CADENA2:= SUBSTR(LV_SS_ASISTENCIA_911,1,LN_POS2 - 1);


                --END IF;

                Insert into GED_CODIGOS
                (COD_MODULO, NOM_TABLA, NOM_COLUMNA, COD_VALOR, DES_VALOR, FEC_ULTMOD, NOM_USUARIO)
                Values
               ('GA', 'GA_CONTACTO_ABONADO_TO', 'COD_SERVICIO', LV_CADENA2, 'SERVICIO ASISTENCIA 911', SYSDATE,USER);


                dbms_output.PUT_LINE('  LV_CADENA2:'||  LV_CADENA2);
                if LN_pos < lN_MAX then
                LN_pos:=LN_pos + 1;
                LV_SS_ASISTENCIA_911:=SUBSTR(LV_SS_ASISTENCIA_911,LN_POS2+1,LN_MAX);
                end if;

        END LOOP;



        SELECT COUNT(1)
        INTO LN_EXISTE_SS_911
        FROM GA_SERVSUPLABO B
        WHERE  B.NUM_ABONADO =EN_NUM_ABONADO
        AND B.COD_SERVICIO IN ( SELECT A.COD_SERVICIO
        FROM GA_SERVSUPL A
        WHERE A.COD_PRODUCTO = 1
        )
        AND B.IND_ESTADO <3
        AND TRIM(B.COD_SERVSUPL)IN (SELECT  TRIM(COD_VALOR) FROM GED_CODIGOS
                                    WHERE COD_MODULO='GA'AND NOM_TABLA ='GA_CONTACTO_ABONADO_TO' AND NOM_COLUMNA ='COD_SERVICIO')
        AND B.FEC_ALTABD   = (
				   		   	  SELECT MAX(B.FEC_ALTABD)
				     		    FROM GA_SERVSUPLABO A
					           WHERE A.NUM_ABONADO  = B.NUM_ABONADO
					             AND A.COD_SERVSUPL = B.COD_SERVSUPL
					  			 AND A.COD_NIVEL	= B.COD_NIVEL
					  			 AND A.IND_ESTADO	= B.IND_ESTADO);




         IF (LN_EXISTE_SS_911 > 0) THEN
                OPEN SC_cursordatos FOR
                SELECT B.COD_SERVICIO,C.DES_SERVICIO, B.COD_SERVSUPL,B.COD_NIVEL,B.FEC_ALTAbd,B.FEC_ALTACEN
                FROM GA_SERVSUPLABO B , GA_SERVSUPL C
                WHERE  B.NUM_ABONADO =EN_NUM_ABONADO
                AND B.COD_SERVICIO = C.COD_SERVICIO
                AND B.COD_SERVICIO IN ( SELECT A.COD_SERVICIO
                FROM GA_SERVSUPL A
                WHERE A.COD_PRODUCTO = 1  )
                AND B.IND_ESTADO < 3
               AND TRIM(B.COD_SERVSUPL)IN (SELECT  TRIM(COD_VALOR) FROM GED_CODIGOS WHERE COD_MODULO='GA'AND NOM_TABLA ='GA_CONTACTO_ABONADO_TO' AND NOM_COLUMNA ='COD_SERVICIO')
                AND B.FEC_ALTABD   = (
                                      SELECT MAX(B.FEC_ALTABD)
                                        FROM GA_SERVSUPLABO A
                                       WHERE A.NUM_ABONADO  = B.NUM_ABONADO
                                         AND A.COD_SERVSUPL = B.COD_SERVSUPL
                                         AND A.COD_NIVEL	= B.COD_NIVEL
                                         AND A.IND_ESTADO	= B.IND_ESTADO);
         ELSE

             OPEN SC_CURSORDATOS FOR
             SELECT NULL FROM DUAL;


         END IF;

         DELETE
         GED_CODIGOS
         WHERE COD_MODULO='GA'AND
         NOM_TABLA ='GA_CONTACTO_ABONADO_TO' AND
         NOM_COLUMNA ='COD_SERVICIO' AND
         DES_VALOR='SERVICIO ASISTENCIA 911';


 EXCEPTION
   WHEN OTHERS THEN
       SN_cod_retorno := 156;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;

       LV_des_error   := ' PV_CARGA_SS911_PR ('||EN_num_abonado ||'); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'GA_SERV911CORREOFAX.PV_CARGA_SS911_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_CARGA_SS911_PR;


PROCEDURE PV_CARGO_REC911_PR(EO_NUM_ABONADO           IN             GA_ABOCEL.NUM_ABONADO%TYPE,
                               EO_COD_CLIENTE           IN              GA_ABOCEL.COD_CLIENTE%TYPE,
                               EO_COD_PROD_CONTRA       IN              PR_PRODUCTOS_CONTRATADOS_TO.COD_PROD_CONTRATADO%TYPE,
                               EO_COD_CONCEPTO          IN              FA_CONCEPTOS.COD_CONCEPTO%TYPE,
                               EO_NUM_ABONADO_PAGO      IN              GA_ABOCEL.NUM_ABONADO%TYPE,
                               EO_COD_CLIENTE_PAGO      IN              GA_ABOCEL.COD_CLIENTE%TYPE,
                               EO_COD_PLANSERV          IN              GA_ABOCEL.COD_PLANSERV%TYPE,
                               EO_IND_COBPRORRATEA      IN              NUMBER,
                               EO_COD_CARGO_PROD_CONTRA IN              FA_CARGOS_REC_TO.COD_CARGO_CONTRATADO%TYPE,
                               EO_FECHA_ALTA            IN              DATE,
                               EO_FECHA_BAJA            IN              DATE,
                               EO_USUARIO               IN              GA_ABOCEL.NOM_USUARORA%TYPE,
                               sn_cod_retorno           OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                               sv_mens_retorno          OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                               sn_num_evento            OUT NOCOPY      ge_errores_pg.evento)

IS

/*
 <Documentaci¿n
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = ""
       Lenguaje="PL/SQL"
       Fecha="29-03-2010"
       Versi¿n="PV_CARGO_REC911_PR
       Dise±ador="Orlando Cabezas"
       Programador="Orlando Cabezas"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripci¿n></Descripci¿n>>
       <Parßmetros>
          <Entrada>
             <Entrada>
             <param nom="EO_NUM_ABONADO" Tipo="NUMERICO">NUMERO ABONADO<param>>
          </Entrada>
          </Entrada>
          <Salida>
             <param nom=" SO_Lista_AbonadoTipo="ESTRUCTURA">REGISTRO RESUMEN LLAMADAS<param>>
          </Salida>
       </Parßmetros>
    </Elemento>
 </Documentaci¿n>
 */


 lv_des_error    ge_errores_pg.desevent;
 lv_ssql         ge_errores_pg.vquery;
 lo_cargos_rec     FA_CARGOS_REC_QT;





 error_exception1  EXCEPTION;



BEGIN
    sn_cod_retorno  := 0;
    sv_mens_retorno := NULL;
    sn_num_evento   := 0;
    lo_cargos_rec := FA_CARGOS_REC_QT('','','','','','','','','','','','','','','','','','','','','','','','');

    lo_cargos_rec.cod_clienteserv      := eo_cod_cliente;
    lo_cargos_rec.num_abonadoserv      := eo_num_abonado;
    lo_cargos_rec.cod_prod_contratado  := eo_cod_prod_contra;
    lo_cargos_rec.cod_cargo_contratado := eo_cod_cargo_prod_contra;
    lo_cargos_rec.cod_clientepago      := eo_cod_cliente_pago;
    lo_cargos_rec.num_abonadopago      := eo_num_abonado_pago;
    lo_cargos_rec.cod_planserv         := eo_cod_planserv;
    lo_cargos_rec.ind_cargopro         := eo_ind_cobprorratea;
    lo_cargos_rec.cod_concepto         := eo_cod_concepto;
    lo_cargos_rec.fec_alta             := eo_fecha_alta;
    lo_cargos_rec.fec_baja             := TO_DATE('31-12-3000','DD-MM-YYYY');
    lo_cargos_rec.fec_desdecobr        := eo_fecha_alta;
    lo_cargos_rec.fec_hastacobr        := TO_DATE('31-12-3000','DD-MM-YYYY');
    lo_cargos_rec.fec_desdebloc        := eo_fecha_alta;
    lo_cargos_rec.fec_hastabloc        := TO_DATE('31-12-3000','DD-MM-YYYY');
    lo_cargos_rec.nom_usuario          := eo_usuario;


    lv_ssql:= 'FA_CARGOS_REC_SN_PG.FA_CARGOS_REC_ALTA_PR('||eo_cod_cliente||', '||eo_num_abonado||', '||eo_cod_prod_contra||', '||eo_cod_cargo_prod_contra||', '||eo_cod_planserv||', '||eo_ind_cobprorratea||', '||eo_cod_concepto||')';
    fa_cargos_rec_sn_pg.fa_cargos_rec_alta_pr (lo_cargos_rec, sn_cod_retorno, sv_mens_retorno, sn_num_evento);
    if (sn_cod_retorno != 0) then
        RAISE error_exception1;
    end if;

EXCEPTION
            WHEN error_exception1 THEN
                SN_cod_retorno := -1;
                LV_des_error    :=  ' PV_CARGO_REC911_PR('||'); - ' || SQLERRM;
                SV_mens_retorno :=  CV_ERROR_NO_CLASIF;
                SN_num_evento   :=  Ge_Errores_Pg.Grabarpl(
                                    SN_num_evento,
                                    CV_COD_MODULO,
                                    SV_mens_retorno,
                                    '1.0',
                                    USER,
                                    'GA_SERV911CORREOFAX_PG.PV_CARGO_REC911_PR',
                                    LV_sSql,
                                    SN_cod_retorno,
                                    LV_des_error);


           WHEN OTHERS THEN
                SN_cod_retorno := -1;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                       SV_mens_retorno := CV_ERROR_NO_CLASIF;
                END IF;
                LV_des_error     :=  'PV_CARGO_REC911_PR('||'); - ' || SQLERRM;
                SV_mens_retorno  :=  CV_ERROR_NO_CLASIF;
                SN_num_evento    :=  Ge_Errores_Pg.Grabarpl(
                                     SN_num_evento,
                                     CV_COD_MODULO ,
                                     SV_mens_retorno,
                                     '1.0',
                                     USER,
                                     'GA_SERV911CORREOFAX_PG.PV_CARGO_REC911_PR ',
                                     LV_sSQL, SN_cod_retorno, LV_des_error );


END PV_CARGO_REC911_PR;

PROCEDURE PV_CARGO_DEL911_PR(EO_NUM_ABONADO           IN             GA_ABOCEL.NUM_ABONADO%TYPE,
                               EO_COD_CLIENTE           IN              GA_ABOCEL.COD_CLIENTE%TYPE,
                               EO_COD_PROD_CONTRA       IN              PR_PRODUCTOS_CONTRATADOS_TO.COD_PROD_CONTRATADO%TYPE,
                               EO_COD_CONCEPTO          IN              FA_CONCEPTOS.COD_CONCEPTO%TYPE,
                               EO_NUM_ABONADO_PAGO      IN              GA_ABOCEL.NUM_ABONADO%TYPE,
                               EO_COD_CLIENTE_PAGO      IN              GA_ABOCEL.COD_CLIENTE%TYPE,
                               EO_COD_PLANSERV          IN              GA_ABOCEL.COD_PLANSERV%TYPE,
                               EO_IND_COBPRORRATEA      IN              NUMBER,
                               EO_COD_CARGO_PROD_CONTRA IN              FA_CARGOS_REC_TO.COD_CARGO_CONTRATADO%TYPE,
                               EO_FECHA_ALTA            IN              DATE,
                               EO_FECHA_BAJA            IN              DATE,
                               EO_USUARIO               IN              GA_ABOCEL.NOM_USUARORA%TYPE,
                               sn_cod_retorno           OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                               sv_mens_retorno          OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                               sn_num_evento            OUT NOCOPY      ge_errores_pg.evento)

IS

/*
 <Documentaci¿n
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = ""
       Lenguaje="PL/SQL"
       Fecha="29-03-2010"
       Versi¿n="PV_CARGO_DEL911_PR
       Dise±ador="Orlando Cabezas"
       Programador="Orlando Cabezas"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripci¿n></Descripci¿n>>
       <Parßmetros>
          <Entrada>
             <Entrada>
             <param nom="EO_NUM_ABONADO" Tipo="NUMERICO">NUMERO ABONADO<param>>
          </Entrada>
          </Entrada>
          <Salida>
             <param nom=" SO_Lista_AbonadoTipo="ESTRUCTURA">REGISTRO RESUMEN LLAMADAS<param>>
          </Salida>
       </Parßmetros>
    </Elemento>
 </Documentaci¿n>
 */


 lv_des_error    ge_errores_pg.desevent;
 lv_ssql         ge_errores_pg.vquery;
 lo_cargos_rec     FA_CARGOS_REC_QT;





 error_exception1  EXCEPTION;



BEGIN
    sn_cod_retorno  := 0;
    sv_mens_retorno := NULL;
    sn_num_evento   := 0;
    lo_cargos_rec := FA_CARGOS_REC_QT('','','','','','','','','','','','','','','','','','','','','','','','');

    lo_cargos_rec.cod_clienteserv      := eo_cod_cliente;
    lo_cargos_rec.num_abonadoserv      := eo_num_abonado;
    lo_cargos_rec.cod_prod_contratado  := eo_cod_prod_contra;
    lo_cargos_rec.cod_cargo_contratado := eo_cod_cargo_prod_contra;
    lo_cargos_rec.cod_clientepago      := eo_cod_cliente_pago;
    lo_cargos_rec.num_abonadopago      := eo_num_abonado_pago;
    lo_cargos_rec.cod_planserv         := eo_cod_planserv;
    lo_cargos_rec.ind_cargopro         := eo_ind_cobprorratea;
    lo_cargos_rec.cod_concepto         := eo_cod_concepto;
    lo_cargos_rec.fec_alta             := eo_fecha_alta;
    lo_cargos_rec.fec_baja             := eo_fecha_baja;
    lo_cargos_rec.fec_desdecobr        := eo_fecha_alta;
    lo_cargos_rec.fec_hastacobr        := eo_fecha_baja;
    lo_cargos_rec.fec_desdebloc        := eo_fecha_alta;
    lo_cargos_rec.fec_hastabloc        := eo_fecha_baja;
    lo_cargos_rec.nom_usuario          := eo_usuario;


    lv_ssql:= 'FA_CARGOS_REC_SN_PG.FA_CARGOS_REC_ELIMINA_PR('||eo_cod_cliente||', '||eo_num_abonado||', '||eo_cod_prod_contra||', '||eo_cod_cargo_prod_contra||', '||eo_cod_planserv||', '||eo_ind_cobprorratea||', '||eo_cod_concepto||')';
    fa_cargos_rec_sn_pg.FA_CARGOS_REC_ELIMINA_PR (lo_cargos_rec, sn_cod_retorno, sv_mens_retorno, sn_num_evento);
    if (sn_cod_retorno != 0) then
        RAISE error_exception1;
    end if;

EXCEPTION
            WHEN error_exception1 THEN
                SN_cod_retorno := -1;
                LV_des_error    :=  ' PV_CARGO_DEL911_PR('||'); - ' || SQLERRM;
                SV_mens_retorno :=  CV_ERROR_NO_CLASIF;
                SN_num_evento   :=  Ge_Errores_Pg.Grabarpl(
                                    SN_num_evento,
                                    CV_COD_MODULO,
                                    SV_mens_retorno,
                                    '1.0',
                                    USER,
                                    'GA_SERV911CORREOFAX_PG.PV_CARGO_DEL911_PR',
                                    LV_sSql,
                                    SN_cod_retorno,
                                    LV_des_error);


           WHEN OTHERS THEN
                SN_cod_retorno := -1;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                       SV_mens_retorno := CV_ERROR_NO_CLASIF;
                END IF;
                LV_des_error     :=  'PV_CARGO_DEL911_PR('||'); - ' || SQLERRM;
                SV_mens_retorno  :=  CV_ERROR_NO_CLASIF;
                SN_num_evento    :=  Ge_Errores_Pg.Grabarpl(
                                     SN_num_evento,
                                     CV_COD_MODULO ,
                                     SV_mens_retorno,
                                     '1.0',
                                     USER,
                                     'GA_SERV911CORREOFAX_PG.PV_CARGO_DEL911_PR ',
                                     LV_sSQL, SN_cod_retorno, LV_des_error );


END PV_CARGO_DEL911_PR;


PROCEDURE PV_DELETE_GACONTACTO_PR (  EN_NUM_ABONADO       IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                      EV_COD_SERVICIO      IN GA_CONTACTO_ABONADO_TO.COD_SERVICIO%TYPE,
                                      SN_cod_retorno      OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
                                      SV_mens_retorno     OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
                                      SN_num_evento       OUT NOCOPY  ge_errores_pg.evento)
IS


/*
 <Documentaci¿n
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = ""
       Lenguaje="PL/SQL"
       Fecha="29-03-2010"
       Versi¿n="PV_DELETE_GACONTACTO_PR
       Dise±ador="Orlando Cabezas"
       Programador="Orlando Cabezas"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripci¿n></Descripci¿n>>
       <Parßmetros>
          <Entrada>
             <Entrada>
             <param nom="EO_NUM_ABONADO" Tipo="NUMERICO">NUMERO ABONADO<param>>
          </Entrada>
          </Entrada>
          <Salida>
             <param nom=" SO_Lista_AbonadoTipo="ESTRUCTURA">REGISTRO RESUMEN LLAMADAS<param>>
          </Salida>
       </Parßmetros>
    </Elemento>
 </Documentaci¿n>
 */




  LV_des_error    ge_errores_pg.DesEvent;
  LV_sSql         ge_errores_pg.vQuery;
  LV_COD_SERVICIO        PV_CONTACTO_ABONADO_TO.COD_SERVICIO%TYPE;
  LN_NUM_CONTACTO        PV_CONTACTO_ABONADO_TO.NUM_CONTACTO%TYPE;
  LV_NOMBRE_CONTACTO     PV_CONTACTO_ABONADO_TO.NOMBRE_CONTACTO%TYPE;
  LV_APELLIDO1_CONTACTO  PV_CONTACTO_ABONADO_TO.APELLIDO1_CONTACTO%TYPE;
  LV_APELLIDO2_CONTACTO  PV_CONTACTO_ABONADO_TO.APELLIDO2_CONTACTO%TYPE;
  LV_COD_PARENTESCO      PV_CONTACTO_ABONADO_TO.COD_PARENTESCO%TYPE;
  LN_COD_DIRECCION       PV_CONTACTO_ABONADO_TO.COD_DIRECCION%TYPE;
  LV_PLACA_VEHICULAR     PV_CONTACTO_ABONADO_TO.PLACA_VEHICULAR%TYPE;
  LV_COLOR_VEHICULO      PV_CONTACTO_ABONADO_TO.COLOR_VEHICULO%TYPE;
  LN_ANIO_VEHICULO       PV_CONTACTO_ABONADO_TO.ANIO_VEHICULO%TYPE;
  LV_OBSERVACION         PV_CONTACTO_ABONADO_TO.OBSERVACION%TYPE;
  LV_IND_VIGENTE         PV_CONTACTO_ABONADO_TO.IND_VIGENTE%TYPE;
  LV_FEC_MODIF           PV_CONTACTO_ABONADO_TO.FEC_MODIFICACION%TYPE;
  LV_NOM_USUAORA         PV_CONTACTO_ABONADO_TO.NOM_USUAORA%TYPE;
  LV_COD_PROVINCIA       PV_CONTACTO_ABONADO_TO.COD_PROVINCIA%TYPE;
  LV_COD_REGION          PV_CONTACTO_ABONADO_TO.COD_REGION%TYPE;
  LV_COD_CIUDAD          PV_CONTACTO_ABONADO_TO.COD_CIUDAD%TYPE;
  LV_COD_COMUNA          PV_CONTACTO_ABONADO_TO.COD_COMUNA%TYPE;
  LV_NOM_CALLE           PV_CONTACTO_ABONADO_TO.NOM_CALLE%TYPE;
  LV_NUM_CALLE           PV_CONTACTO_ABONADO_TO.NUM_CALLE%TYPE;
  LV_NUM_PISO            PV_CONTACTO_ABONADO_TO.NUM_PISO%TYPE;
  LV_NUM_CASILLA         PV_CONTACTO_ABONADO_TO.NUM_CASILLA%TYPE;
  LV_OBS_DIRECCION       PV_CONTACTO_ABONADO_TO.OBS_DIRECCION%TYPE;
  LV_DES_DIREC1          PV_CONTACTO_ABONADO_TO.DES_DIREC1%TYPE;
  LV_DES_DIREC2          PV_CONTACTO_ABONADO_TO.DES_DIREC2%TYPE;
  LV_COD_PUEBLO          PV_CONTACTO_ABONADO_TO.COD_PUEBLO%TYPE;
  LV_COD_ESTADO          PV_CONTACTO_ABONADO_TO.COD_ESTADO%TYPE;
  LV_ZIP                 PV_CONTACTO_ABONADO_TO.ZIP%TYPE;
  LV_COD_TIPOCALLE       PV_CONTACTO_ABONADO_TO.COD_TIPOCALLE%TYPE;
  LV_COD_DIRECCION       PV_CONTACTO_ABONADO_TO.COD_DIRECCION%TYPE;
  LV_NUM_TELEFONO        PV_CONTACTO_ABONADO_TO.NUM_TELEFONO%TYPE;
   VN_SEQDIRECCION       NUMBER(20);
  LB_FLAG                BOOLEAN := TRUE;



  CURSOR CURSOR_CONTACTO  IS
     SELECT     COD_SERVICIO        ,
                NUM_CONTACTO        ,
                NOMBRE_CONTACTO     ,
                APELLIDO1_CONTACTO  ,
                APELLIDO2_CONTACTO  ,
                COD_PARENTESCO      ,
                PLACA_VEHICULAR     ,
                COLOR_VEHICULO      ,
                ANIO_VEHICULO       ,
                OBSERVACION         ,
                IND_VIGENTE         ,
                FEC_MODIFICACION    ,
                NOM_USUAORA         ,
                COD_PROVINCIA       ,
                COD_REGION          ,
                COD_CIUDAD          ,
                COD_COMUNA          ,
                NOM_CALLE           ,
                NUM_CALLE           ,
                NUM_PISO            ,
                NUM_CASILLA         ,
                OBS_DIRECCION       ,
                DES_DIREC1          ,
                DES_DIREC2          ,
                COD_PUEBLO          ,
                COD_ESTADO          ,
                ZIP                 ,
                COD_TIPOCALLE       ,
                COD_DIRECCION       ,
                NUM_TELEFONO
         FROM PV_CONTACTO_ABONADO_TO
         WHERE NUM_ABONADO= EN_NUM_ABONADO AND COD_SERVICIO =EV_COD_SERVICIO ;

 BEGIN
         sn_cod_retorno  := 0;
         sv_mens_retorno := NULL;
         sn_num_evento  := 0;



         OPEN CURSOR_CONTACTO;
         LOOP
          FETCH CURSOR_CONTACTO INTO LV_COD_SERVICIO       ,  LN_NUM_CONTACTO        ,  LV_NOMBRE_CONTACTO    ,  LV_APELLIDO1_CONTACTO ,
                                      LV_APELLIDO2_CONTACTO ,  LV_COD_PARENTESCO     ,  LV_PLACA_VEHICULAR    ,  LV_COLOR_VEHICULO     ,
                                      LN_ANIO_VEHICULO      ,  LV_OBSERVACION        ,  LV_IND_VIGENTE        ,  LV_FEC_MODIF          ,LV_NOM_USUAORA        ,
                                      LV_COD_PROVINCIA      ,  LV_COD_REGION         ,  LV_COD_CIUDAD         ,  LV_COD_COMUNA         ,
                                      LV_NOM_CALLE          ,  LV_NUM_CALLE          ,  LV_NUM_PISO           ,  LV_NUM_CASILLA        ,
                                      LV_OBS_DIRECCION      ,  LV_DES_DIREC1         ,  LV_DES_DIREC2         ,  LV_COD_PUEBLO         ,
                                      LV_COD_ESTADO         ,  LV_ZIP                ,  LV_COD_TIPOCALLE      ,  LV_COD_DIRECCION      , LV_NUM_TELEFONO  ;

         EXIT WHEN CURSOR_CONTACTO%NOTFOUND;

              IF LB_FLAG = TRUE THEN
                LV_sSql:='DELETE  FROM GA_CONTACTO_ABONADO_TO WHERE NUM_ABONADO= EN_NUM_ABONADO';

                /*
                INSERT INTO GA_CONTACTO_ABONADO_TH(
                NUM_ABONADO         ,                COD_SERVICIO        ,
                NUM_CONTACTO        ,                NOMBRE_CONTACTO     ,
                APELLIDO1_CONTACTO  ,                APELLIDO2_CONTACTO  ,
                COD_PARENTESCO      ,                PLACA_VEHICULAR     ,
                COLOR_VEHICULO      ,                ANIO_VEHICULO       ,
                OBSERVACION         ,                IND_VIGENTE         ,
                FEC_MODIFICACION    ,                NOM_USUAORA         ,FEC_PASOHIST,USU_PASOHIST)
                VALUES
                (EN_NUM_ABONADO        ,  LV_COD_SERVICIO       ,  LN_NUM_CONTACTO       ,  LV_NOMBRE_CONTACTO    ,  LV_APELLIDO1_CONTACTO ,
                 LV_APELLIDO2_CONTACTO ,  LV_COD_PARENTESCO     ,  LV_PLACA_VEHICULAR    ,  LV_COLOR_VEHICULO     ,  LN_ANIO_VEHICULO      ,
                 LV_OBSERVACION        ,  LV_IND_VIGENTE        ,  LV_FEC_MODIF          ,  LV_NOM_USUAORA        ,  SYSDATE,USER );

                LV_sSql:='DELETE  FROM GA_CONTACTO_ABONADO_TO WHERE NUM_ABONADO= EN_NUM_ABONADO';
             */
                DELETE  FROM GA_CONTACTO_ABONADO_TO
                WHERE NUM_ABONADO= EN_NUM_ABONADO AND COD_SERVICIO =EV_COD_SERVICIO ;


                LB_FLAG :=FALSE;
              END IF;





              LV_sSql:='INSERT INTO GA_CONTACTO_ABONADO_TO(NUM_ABONADO,COD_SERVICIO,NUM_CONTACTO,NOMBRE_CONTACTO, APELLIDO1_CONTACTO,APELLIDO2_CONTACTO,COD_PARENTESCO,PLACA_VEHICULAR,COLOR_VEHICULO,ANIO_VEHICULO,OBSERVACION,IND_VIGENTE,FEC_MODIFICACION,NOM_USUAORA)';
              LV_sSql:= LV_sSql || 'VALUES (EN_NUM_ABONADO        ,  LV_COD_SERVICIO       ,  LN_NUM_CONTACTO       ,  LV_NOMBRE_CONTACTO    ,  LV_APELLIDO1_CONTACTO ,';
              LV_sSql:= LV_sSql || 'LV_APELLIDO2_CONTACTO ,  LV_COD_PARENTESCO     ,  LV_PLACA_VEHICULAR    ,  LV_COLOR_VEHICULO     ,  LN_ANIO_VEHICULO      ,';
              LV_sSql:= LV_sSql || 'LV_OBSERVACION        ,  LV_IND_VIGENTE        ,  LV_FEC_MODIF          ,  LV_NOM_USUAORA        );';

              INSERT INTO GA_CONTACTO_ABONADO_TO(
                NUM_ABONADO         ,                COD_SERVICIO        ,
                NUM_CONTACTO        ,                NOMBRE_CONTACTO     ,
                APELLIDO1_CONTACTO  ,                APELLIDO2_CONTACTO  ,
                COD_PARENTESCO      ,                PLACA_VEHICULAR     ,
                COLOR_VEHICULO      ,                ANIO_VEHICULO       ,
                OBSERVACION         ,                IND_VIGENTE         ,
                FEC_MODIFICACION    ,                NOM_USUAORA         , NUM_TELEFONO)
                VALUES
                (EN_NUM_ABONADO        ,  LV_COD_SERVICIO       ,  LN_NUM_CONTACTO       ,  LV_NOMBRE_CONTACTO    ,  LV_APELLIDO1_CONTACTO ,
                 LV_APELLIDO2_CONTACTO ,  LV_COD_PARENTESCO     ,  LV_PLACA_VEHICULAR    ,  LV_COLOR_VEHICULO     ,  LN_ANIO_VEHICULO      ,
                 LV_OBSERVACION        ,  LV_IND_VIGENTE        ,  LV_FEC_MODIF          ,  LV_NOM_USUAORA        ,  LV_NUM_TELEFONO );


               IF LV_COD_DIRECCION IS NULL OR LV_COD_DIRECCION = '' OR LV_COD_DIRECCION ='0' THEN


                   SELECT GE_SEQ_DIRECCIONES.NEXTVAL
                   INTO   VN_SEQDIRECCION
                   FROM   DUAL;



                  LV_sSql:='INSERT INTO GE_DIRECCIONES ( COD_DIRECCION, COD_PROVINCIA, COD_REGION,';
                  LV_sSql:= LV_sSql || '                                                COD_CIUDAD, COD_COMUNA, NOM_CALLE,';
                  LV_sSql:= LV_sSql || '                              NUM_CALLE, NUM_PISO, NUM_CASILLA,';
                  LV_sSql:= LV_sSql || '                          OBS_DIRECCION, DES_DIREC1, DES_DIREC2,';
                  LV_sSql:= LV_sSql || '                               COD_PUEBLO, COD_ESTADO, ZIP,COD_TIPOCALLE)';
                  LV_sSql:= LV_sSql || 'VALUES (  VN_SEQDIRECCION ,  LV_COD_PROVINCIA, LV_COD_REGION,';
                  LV_sSql:= LV_sSql || '           LV_COD_CIUDAD   , LV_COD_COMUNA   , LV_NOM_CALLE,';
                  LV_sSql:= LV_sSql || '           LV_NUM_CALLE    , LV_NUM_PISO     , LV_NUM_CASILLA,';
                  LV_sSql:= LV_sSql || 'LV_OBS_DIRECCION, LV_DES_DIREC1   , LV_DES_DIREC2,';
                  LV_sSql:= LV_sSql || 'LV_COD_PUEBLO   , LV_COD_ESTADO   , LV_ZIP,LV_COD_TIPOCALLE)';



                   INSERT INTO GE_DIRECCIONES ( COD_DIRECCION, COD_PROVINCIA, COD_REGION,
                                                COD_CIUDAD, COD_COMUNA, NOM_CALLE,
                                                NUM_CALLE, NUM_PISO, NUM_CASILLA,
                                                OBS_DIRECCION, DES_DIREC1, DES_DIREC2,
                                                 COD_PUEBLO, COD_ESTADO, ZIP,COD_TIPOCALLE)
                  VALUES (  VN_SEQDIRECCION ,  LV_COD_PROVINCIA, LV_COD_REGION,
                             LV_COD_CIUDAD   , LV_COD_COMUNA   , LV_NOM_CALLE,
                             LV_NUM_CALLE    , LV_NUM_PISO     , LV_NUM_CASILLA,
                             LV_OBS_DIRECCION, LV_DES_DIREC1   , LV_DES_DIREC2,
                             LV_COD_PUEBLO   , LV_COD_ESTADO   , LV_ZIP,
                             LV_COD_TIPOCALLE);

                    UPDATE GA_CONTACTO_ABONADO_TO SET
                  COD_DIRECCION =VN_SEQDIRECCION
                  WHERE NUM_ABONADO =EN_NUM_ABONADO  AND COD_SERVICIO     =LV_COD_SERVICIO AND NUM_CONTACTO= LN_NUM_CONTACTO   ;
               ELSE


                  LV_sSql:='UPDATE GE_DIRECCIONES   SET';
                  LV_sSql:= LV_sSql || '  COD_PROVINCIA       =LV_COD_PROVINCIA,';
                  LV_sSql:= LV_sSql || '  COD_REGION          =LV_COD_REGION,';
                  LV_sSql:= LV_sSql || '  COD_CIUDAD          =LV_COD_CIUDAD,';
                  LV_sSql:= LV_sSql || '  COD_COMUNA          =LV_COD_COMUNA,';
                  LV_sSql:= LV_sSql || '  NOM_CALLE           =LV_NOM_CALLE,';
                  LV_sSql:= LV_sSql || '  NUM_CALLE           =LV_NUM_CALLE,';
                  LV_sSql:= LV_sSql || '  NUM_PISO            =LV_NUM_PISO,';
                  LV_sSql:= LV_sSql || '  NUM_CASILLA         =LV_NUM_CASILL,';
                  LV_sSql:= LV_sSql || '  OBS_DIRECCION       =LV_OBS_DIRECCION ,';
                  LV_sSql:= LV_sSql || '  DES_DIREC1          =LV_DES_DIREC1,';
                  LV_sSql:= LV_sSql || '  DES_DIREC2          =LV_DES_DIREC2,';
                  LV_sSql:= LV_sSql || '  COD_PUEBLO          =LV_COD_PUEBLO,';
                  LV_sSql:= LV_sSql || '  COD_ESTADO          =LV_COD_ESTADO,';
                  LV_sSql:= LV_sSql || '  ZIP                 =LV_ZIP,';
                  LV_sSql:= LV_sSql || '  COD_TIPOCALLE       =LV_COD_TIPOCALLE';
                  LV_sSql:= LV_sSql || 'WHERE   COD_DIRECCION  = LV_COD_DIRECCION';



                  UPDATE GE_DIRECCIONES
                  SET
                    COD_PROVINCIA       =LV_COD_PROVINCIA,
                    COD_REGION          =LV_COD_REGION,
                    COD_CIUDAD          =LV_COD_CIUDAD,
                    COD_COMUNA          =LV_COD_COMUNA,
                    NOM_CALLE           =LV_NOM_CALLE,
                    NUM_CALLE           =LV_NUM_CALLE,
                    NUM_PISO            =LV_NUM_PISO,
                    NUM_CASILLA         =LV_NUM_CASILLA,
                    OBS_DIRECCION       =LV_OBS_DIRECCION ,
                    DES_DIREC1          =LV_DES_DIREC1,
                    DES_DIREC2          =LV_DES_DIREC2,
                    COD_PUEBLO          =LV_COD_PUEBLO,
                    COD_ESTADO          =LV_COD_ESTADO,
                    ZIP                 =LV_ZIP,
                    COD_TIPOCALLE       =LV_COD_TIPOCALLE
                  WHERE
                  COD_DIRECCION  = LV_COD_DIRECCION;



                    UPDATE GA_CONTACTO_ABONADO_TO SET
                  COD_DIRECCION = LV_COD_DIRECCION
                  WHERE NUM_ABONADO =EN_NUM_ABONADO  AND COD_SERVICIO     =LV_COD_SERVICIO  AND NUM_CONTACTO= LN_NUM_CONTACTO   ;

               END IF;

         END LOOP;
         CLOSE CURSOR_CONTACTO;


 EXCEPTION
   WHEN OTHERS THEN
       SN_cod_retorno := 156;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := ' PV_DELETE_GACONTACTO_PR ('||EN_NUM_ABONADO||'); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'GA_SERV911CORREOFAX.PV_DELETE_GACONTACTO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_DELETE_GACONTACTO_PR;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE PV_DELETE_CONTACTOABONADOTT_PR (  EN_NUM_ABONADO       IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                        EV_cod_servicio  IN   ga_contacto_abonado_to.cod_servicio% TYPE,
                                      SN_cod_retorno      OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
                                      SV_mens_retorno     OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
                                      SN_num_evento       OUT NOCOPY  ge_errores_pg.evento)
IS
  LV_des_error    ge_errores_pg.DesEvent;
  LV_sSql      ge_errores_pg.vQuery;
 BEGIN
         sn_cod_retorno  := 0;
         sv_mens_retorno := NULL;
         sn_num_evento  := 0;


         LV_sSql:= ' DELETE  FROM PV_CONTACTO_ABONADO_TO  WHERE NUM_ABONADO= '||EN_NUM_ABONADO||' AND cod_servicio='||EV_cod_servicio;

         DELETE  FROM PV_CONTACTO_ABONADO_TO WHERE NUM_ABONADO= EN_NUM_ABONADO AND cod_servicio=EV_cod_servicio;

 EXCEPTION
   WHEN OTHERS THEN
       SN_cod_retorno := 156;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
    LV_des_error   := ' PV_DELETE_CONTACTOABONADOTT_PR ('||EN_NUM_ABONADO||'); '||SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'GA_SERV911CORREOFAX.PV_DELETE_CONTACTOABONADOTT_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_DELETE_CONTACTOABONADOTT_PR;

END GA_SERV911CORREOFAX_PG;
/
SHOW ERRORS