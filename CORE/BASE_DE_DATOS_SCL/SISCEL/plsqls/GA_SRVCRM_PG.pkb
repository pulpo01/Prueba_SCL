CREATE OR REPLACE PACKAGE BODY GA_SRVCRM_PG AS

       FUNCTION GA_DocumentarErrores_FN (
                                           EN_COD_RETORNO  IN OUT     ge_errores_pg.coderror,
                                           EV_des_error    IN         ge_errores_pg.desevent,
                                           EV_Usuario      IN         VARCHAR2,
                                           EV_Objeto       IN         VARCHAR2,
                                           EV_sql          IN         ge_errores_pg.vQuery,
                                           EV_modulo_scl   IN         VARCHAR2,
                                           ESV_NUM_EVENTO  IN OUT     ge_errores_pg.msgerror,
                                           SV_MENS_RETORNO OUT NOCOPY ge_errores_pg.msgerror
                                         )
                                         RETURN BOOLEAN
                                         IS
           /*
           <Documentacion TipoDoc = "PrivateFunction">
              <Elemento
                 Nombre = "GA_DocumentarErrores_FN"
                 Lenguaje="PL/SQL"
                 Fecha="18-12-2008"
                 Version="1.0"
                 Dise馻dor= "Fernando Garcia"
                 Programador="Fernando Garcia"
                 Ambiente_Desarrollo="BD">
                 <Retorno>"Boolean"</Retorno>
                 <Descripci贸n>"Procedimiento privado que registra el detalle t茅cnico de un error. Un valor False de retorno indica que no se pudo realisar el registro"</Descripci贸n>
                 <Par谩metros>
                    <EntradaSalida>
                       <param nom="EN_COD_RETORNO" Tipo="VARCHAR2" Descripcion="C贸digo de error de negocio a registrar"></param>
                    </EntradaSalida>
                    <Entrada>
                       <param nom="EV_des_error" Tipo="ge_errores_pg.desevent" Descripcion="Forma en que fue invocado el procedimiento o funci贸n donde ocurre el error"></param>
                       <param nom="EV_Usuario" Tipo="VARCHAR2" Descricion="Usuario de la sesion cuando ocurre el error"></param>
                       <param nom="EV_Objeto" Tipo="VARCHAR2" Descripcion ="Objeto donde ocurre el error"></param>
                       <param nom="EV_sql" Tipo="ge_errores_pg.vQuery" Descripcion ="Intrucci贸n de BD que causa el error"></param>
                       <param nom="EV_modulo_scl" Tipo="VARCHAR2" Descripcion ="M贸dulo asociado al error"></param>
                    </Entrada>
                    <EntradaSalida>
                       <param nom="ESV_NUM_EVENTO" Tipo="ge_errores_pg.msgerror" Descripcion="Identificador del registro tecnico del error"></param>>
                    </EntradaSalida>
                   <Salida>
                       <param nom="SV_MENS_RETORNO" Tipo="ge_errores_pg.msgerror" Descripcion="Descripcion del error de negocio"></param>>
                    </Salida>
                 </Parametros>
              </Elemento>
           </Documentacion>
           */
                 BEGIN
                        IF NOT ge_errores_pg.mensajeerror(EN_COD_RETORNO,SV_MENS_RETORNO) THEN
                           SV_MENS_RETORNO := CV_error_no_clasif;
                        END IF;
                        ESV_NUM_EVENTO := ge_errores_pg.grabarpl (ESV_NUM_EVENTO, EV_modulo_scl, SV_MENS_RETORNO, CV_version, EV_Usuario, EV_Objeto, EV_sql, EN_COD_RETORNO, EV_des_error);
                        RETURN TRUE;
                 EXCEPTION
                        WHEN OTHERS THEN
                          RETURN FALSE;
       END GA_DocumentarErrores_FN;

       PROCEDURE GA_CorreoUserPwd_PR (
                                      EV_plataforma   IN  VARCHAR2,
                                      SV_usuario      OUT NOCOPY VARCHAR2,
                                      SV_pwd          OUT NOCOPY VARCHAR2,
                                      SN_COD_RETORNO  OUT NOCOPY ge_errores_pg.coderror,
                                      SV_MENS_RETORNO OUT NOCOPY ge_errores_pg.msgerror,
                                      SV_NUM_EVENTO   OUT NOCOPY ge_errores_pg.evento
                                     ) IS
           /*
           <Documentacion TipoDoc = "Procedure">
              <Elemento
                 Nombre = "GA_CorreoUserPwd_PR"
                 Lenguaje="PL/SQL"
                 Fecha="18-12-2008"
                 Versi贸n="1.0"
                 Dise帽ador= "Fernando Garcia"
                 Programador="Fernando Garcia"
                 Ambiente_Desarrollo="BD">
                 <Retorno>N/A</Retorno>
                 <Descripci贸n>Retonar El usuario y contrase帽a de una determinada plataforma proveedora de servicios de correo</Descripci贸n>
                 <Par谩metros>
                    <Entrada>
                       <param nom="EV_plataforma" Tipo="VARCHAR2" Descripcion="Nombre de la plataforma de correo a consultar"></param>
                    </Entrada>
                   <Salida>
                       <param nom="SV_usuario" Tipo="VARCHAR2" Descripcion ="Usuario para conectar a la plataforma"></param>
                       <param nom="SV_pwd" Tipo="VARCHAR2" Descripcion ="Contrase帽a para conectar a la plataforma"></param>
                       <param nom="SN_cod_retorno" Tipo="NUMERICO" Descripcion ="C贸digo de error de Negocio. Valor cero indica ausencia de error"></param>
                       <param nom="SV_mens_retorno" Tipo="CARACTER" Descripcion ="Descripci贸n del error de Negocio. Un texto vacio indica aunsencia de error"></param>
                       <param nom="SN_num_evento" Tipo="NUMERICO" Descripcion="Identificador asociado al detalle t茅cnico del error"></param>
                    </Salida>
                 </Par谩metros>
              </Elemento>
           </Documentacion>
           */
                   LV_sql  ge_errores_pg.vQuery;
                   LV_des_error ge_errores_pg.desevent;
                 BEGIN

                   SV_NUM_EVENTO:= 0;
                   SN_COD_RETORNO:=0;
                   SV_MENS_RETORNO:='';

                   LV_sql:= 'SELECT parametros.val_parametro' ||
                            'INTO SV_usuario' ||
                            'FROM GED_PARAMETROS parametros' ||
                            'WHERE parametros.nom_parametro = ''USUARIO_'' ||' || EV_plataforma ||
                            'AND parametros.cod_modulo = ''GE''' ||
                            'AND parametros.cod_producto = 1''';

                   SN_COD_RETORNO := 0;
                   SELECT parametros.val_parametro
                   INTO SV_usuario
                   FROM GED_PARAMETROS parametros
                   WHERE parametros.nom_parametro = 'USUARIO_' || EV_plataforma
                   AND parametros.cod_modulo = 'GE'
                   AND parametros.cod_producto = 1;

                   LV_sql:= 'SELECT parametros.val_parametro' ||
                            'INTO SV_pwd' ||
                            'FROM GED_PARAMETROS parametros' ||
                            'WHERE parametros.nom_parametro = ''PWD_'' ||' || EV_plataforma ||
                            'AND parametros.cod_modulo = ''GE''' ||
                            'AND parametros.cod_producto = 1''';

                   SELECT parametros.val_parametro
                   INTO SV_pwd
                   FROM GED_PARAMETROS parametros
                   WHERE parametros.nom_parametro = 'PWD_' || EV_plataforma
                   AND parametros.cod_modulo = 'GE'
                   AND parametros.cod_producto = 1;

                 EXCEPTION

                   WHEN NO_DATA_FOUND THEN
                        SN_COD_RETORNO := 1;
                        LV_des_error := 'GA_CorreoUserPwd_PR(' || EV_plataforma || ',' || SV_usuario || ',' || SV_pwd || '.. parametros de error):' || SQLERRM;
                        IF NOT GA_DocumentarErrores_FN(SN_COD_RETORNO,LV_des_error,USER, 'GA_SRVCRM_PG.GA_CorreoUserPwd_PR',LV_sql,'GA',SV_NUM_EVENTO,SV_MENS_RETORNO) THEN
                           SV_MENS_RETORNO := CV_ERROR_NO_DOCUMENTADO;
                        END IF;
                   WHEN OTHERS THEN
                        SN_COD_RETORNO := 309;
                        LV_des_error := 'GA_CorreoUserPwd_PR(' || EV_plataforma || ',' || SV_usuario || ',' || SV_pwd || '.. parametros de error):' || SQLERRM;
                        IF NOT GA_DocumentarErrores_FN(SN_COD_RETORNO,LV_des_error,USER, 'GA_SRVCRM_PG.GA_CorreoUserPwd_PR',LV_sql,'GA',SV_NUM_EVENTO,SV_MENS_RETORNO) THEN
                           SV_MENS_RETORNO := CV_ERROR_NO_DOCUMENTADO;
                        END IF;
                 END GA_CorreoUserPwd_PR;

       PROCEDURE GA_EstadoSrvCorreoData_PR (
                                             EN_NumAbonado     IN  ga_abocel.num_abonado%TYPE,
                                             EV_Descontratar   IN  varchar2,
                                             EV_GrupoSrvCorreo OUT NOCOPY ga_servsupl.cod_servsupl%TYPE,
                                             EV_NivelSrvCorreo OUT NOCOPY ga_servsupl.cod_nivel%TYPE,
                                             EV_Plataforma     OUT NOCOPY varchar2,
                                             SN_COD_RETORNO    OUT NOCOPY GE_ERRORES_PG.coderror,
                                             SV_MENS_RETORNO   OUT NOCOPY GE_ERRORES_PG.msgerror,
                                             SV_NUM_EVENTO     OUT NOCOPY GE_ERRORES_PG.evento
                                            )IS
          /*
          <Documentaci贸n TipoDoc = "Procedure">
             <Elemento
                Nombre = "GA_EstadoSrvCorreoData_PR"
                Lenguaje="PL/SQL"
                Fecha="18-12-2008"
                Versi贸n="1.0"
                Dise帽ador= "Fernando Garcia"
                Programador="Fernando Garcia"
                Ambiente_Desarrollo="BD">
                <Retorno>"Boolean"</Retorno>
                <Descripci贸n>"Procedimiento que retorna los datos del servicio de correo contratado para un abonado. Cuando los datos retornados valen NULL, significa que no esta contratato el servicio de correo. La rutina asume que el abonado existe en SCL"</Descripci贸n>
                <Par谩metros>
                   <Entrada>
                      <param nom="EN_NumAbonado" Tipo="ga_abocel.num_abonado" Descripcion ="N煤mero de abonado a consultar"></param>
                      <param nom="EV_Descontratar" Tipo="VARCHAR2(1)" Descripcion ="Indica el tipo de registro a consultar. C = contratado, D = descontratado"></param>
                   </Entrada>
                  <Salida>
                      <param nom="EV_GrupoSrvCorreo" Tipo="ga_servsupl.cod_servsupl" Descripcion ="Grupo del servicio de correo contratado"></param>
                      <param nom="EV_NivelSrvCorreo" Tipo="ga_servsupl.cod_nivel" Descripcion ="Nivel del servicio de correo contratado"></param>
                      <param nom="EV_Plataforma" Tipo="varchar2" Descripcion ="Nombre de la plataforma a la cual pertenece el servicio de correo contratado"></param>
                      <param nom="SN_COD_RETORNO" Tipo="GE_ERRORES_PG.coderror" Descripcion ="C贸digo de error de negocio. Un valor igual a cero indica ausencia de error"></param>
                      <param nom="SV_MENS_RETORNO" Tipo="GE_ERRORES_PG.msgerror" Descripcion ="Descripcion del error de negocio"></param>
                     <param nom="SV_NUM_EVENTO" Tipo="GE_ERRORES_PG.evento" Descripcion ="Identificador asociado al registro del detalle t茅cnico del error de negocio"></param>
                   </Salida>
                </Par谩metros>
             </Elemento>
          </Documentaci贸n>
          */
                   LV_sql  ge_errores_pg.vQuery;
                   LV_des_error ge_errores_pg.desevent;
                   LE_ParametroIncorrecto EXCEPTION;

                 BEGIN
                   SV_NUM_EVENTO:= 0;
                   SN_COD_RETORNO:=0;
                   SV_MENS_RETORNO:='';

                   EV_GrupoSrvCorreo := NULL;
                   EV_NivelSrvCorreo := NULL;
                   EV_Plataforma := NULL;

                   IF EV_Descontratar = 'C' THEN

                      LV_sql := 'SELECT ssabonados.cod_servsupl, ssabonados.cod_nivel, codigos.des_valor ' ||
                                'INTO EV_GrupoSrvCorreo, EV_NivelSrvCorreo, EV_Plataforma' ||
                                'FROM ga_servsuplabo ssabonados, ged_codigos codigos' ||
                                'WHERE ssabonados.num_abonado = ' || EN_NumAbonado || ' ' ||
                                'AND ssabonados.ind_estado < 3' ||
                                'AND codigos.cod_modulo = ''GA''' ||
                                'AND codigos.nom_tabla = ''GA_SERVSUPL''' ||
                                'AND codigos.nom_columna = ''COD_SERVICIO''' ||
                                'AND codigos.cod_valor = ssabonados.cod_servicio';

                      SELECT ssabonados.cod_servsupl, ssabonados.cod_nivel, codigos.des_valor
                      INTO EV_GrupoSrvCorreo, EV_NivelSrvCorreo, EV_Plataforma
                      FROM ga_servsuplabo ssabonados, ged_codigos codigos
                      WHERE ssabonados.num_abonado = EN_NumAbonado
                      AND ssabonados.ind_estado < 3
                      AND codigos.cod_modulo = 'GA'
                      AND codigos.nom_tabla = 'GA_SERVSUPL'
                      AND codigos.nom_columna = 'COD_SERVICIO'
                      AND codigos.cod_valor = ssabonados.cod_servicio;
                   ELSIF EV_Descontratar = 'D' THEN

                      LV_sql := 'SELECT ssabonados.cod_servsupl, ssabonados.cod_nivel, codigos.des_valor ' ||
                                'INTO EV_GrupoSrvCorreo, EV_NivelSrvCorreo, EV_Plataforma' ||
                                'FROM ga_servsuplabo ssabonados, ged_codigos codigos' ||
                                'WHERE ssabonados.num_abonado = ' || EN_NumAbonado || ' ' ||
                                'AND ssabonados.ind_estado = 3' ||
                                'AND codigos.cod_modulo = ''GA''' ||
                                'AND codigos.nom_tabla = ''GA_SERVSUPL''' ||
                                'AND codigos.nom_columna = ''COD_SERVICIO''' ||
                                'AND codigos.cod_valor = ssabonados.cod_servicio';

                      SELECT ssabonados.cod_servsupl, ssabonados.cod_nivel, codigos.des_valor
                      INTO EV_GrupoSrvCorreo, EV_NivelSrvCorreo, EV_Plataforma
                      FROM ga_servsuplabo ssabonados, ged_codigos codigos
                      WHERE ssabonados.num_abonado = EN_NumAbonado
                      AND ssabonados.ind_estado = 3
                      AND codigos.cod_modulo = 'GA'
                      AND codigos.nom_tabla = 'GA_SERVSUPL'
                      AND codigos.nom_columna = 'COD_SERVICIO'
                      AND codigos.cod_valor = ssabonados.cod_servicio;
                   ELSE
                      RAISE LE_ParametroIncorrecto;
                   END IF;


                 EXCEPTION
                   WHEN LE_ParametroIncorrecto THEN
                        SN_COD_RETORNO := 203;
                        LV_des_error := 'GA_EstadoSrvCorreoData_PR(' || EN_NumAbonado || ',' || EV_GrupoSrvCorreo || ',' || EV_NivelSrvCorreo || ',' || EV_NivelSrvCorreo || ',' || EV_Plataforma || ',.. parametros de error):' || SQLERRM;
                        IF NOT GA_DocumentarErrores_FN(SN_COD_RETORNO,LV_des_error,USER, 'GA_SRVCRM_PG.GA_EstadoSrvCorreoData_PR',LV_sql,'GA',SV_NUM_EVENTO,SV_MENS_RETORNO) THEN
                           SV_MENS_RETORNO := CV_ERROR_NO_DOCUMENTADO;
                        END IF;
                   WHEN NO_DATA_FOUND THEN
                        NULL;
                   WHEN OTHERS THEN
                        SN_COD_RETORNO := 203;
                        LV_des_error := 'GA_EstadoSrvCorreoData_PR(' || EN_NumAbonado || ',' || EV_GrupoSrvCorreo || ',' || EV_NivelSrvCorreo || ',' || EV_NivelSrvCorreo || ',' || EV_Plataforma || ',.. parametros de error):' || SQLERRM;
                        IF NOT GA_DocumentarErrores_FN(SN_COD_RETORNO,LV_des_error,USER, 'GA_SRVCRM_PG.GA_EstadoSrvCorreoData_PR',LV_sql,'GA',SV_NUM_EVENTO,SV_MENS_RETORNO) THEN
                           SV_MENS_RETORNO := CV_ERROR_NO_DOCUMENTADO;
                        END IF;

                 END GA_EstadoSrvCorreoData_PR;

PROCEDURE GA_ObtieneServPorDefecto_PR (
                                       EV_CodServicio  IN  GA_SERVSUP_DEF.COD_SERVICIO%TYPE,
                                       EN_TipRelacion  IN  GA_SERVSUP_DEF.TIP_RELACION%TYPE,
                                       SC_cursordatos  OUT NOCOPY  REFCURSOR,
                                       SN_COD_RETORNO  OUT NOCOPY GE_ERRORES_PG.coderror,
                                       SV_MENS_RETORNO OUT NOCOPY GE_ERRORES_PG.msgerror,
                                       SV_NUM_EVENTO   OUT NOCOPY GE_ERRORES_PG.evento
                                           ) IS


          /*
          <Documentaci髇 TipoDoc = "Procedure">
             <Elemento
                Nombre = "GA_ObtieneServPorDefecto_PR"
                Lenguaje="PL/SQL"
                Fecha="07-01-2009"
                Versi髇="1.0"
                Dise馻dor= "rlozano"
                Programador="rlozano"
                Ambiente_Desarrollo="BD">
                <Retorno>"cursor"</Retorno>
                <Descripci髇>"Procedimiento que retorna los servicios por defecto  para un codigo de servicio"</Descripci髇>
                <Par醡etros>
                   <Entrada>
                      <param nom="EV_CodServicio" Tipo="GA_SERVSUP_DEF.COD_SERVICIO" Descripcion ="Codigo de servicio suplementario a consultar"></param>
                      <param nom="EV_Descontratar" Tipo="GA_SERVSUP_DEF.TIP_RELACION" Descripcion ="Indica el tipo de relacion  5: servicio de datos"></param>
                   </Entrada>
                  <Salida>
                      <param nom="C_cursordatos " Tipo="cursor" Descripcion ="relacion de servicios asociados a la activacion por defecto"></param>
                      <param nom="SN_COD_RETORNO" Tipo="GE_ERRORES_PG.coderror" Descripcion ="C骴igo de error de negocio. Un valor igual a cero indica ausencia de error"></param>
                      <param nom="SV_MENS_RETORNO" Tipo="GE_ERRORES_PG.msgerror" Descripcion ="Descripcion del error de negocio"></param>
                     <param nom="SV_NUM_EVENTO" Tipo="GE_ERRORES_PG.evento" Descripcion ="Identificador asociado al registro del detalle t閏nico del error de negocio"></param>
                   </Salida>
                </Par醡etros>
             </Elemento>
          </Documentaci髇>
          */
                  LV_sql  ge_errores_pg.vQuery;
                  LV_des_error ge_errores_pg.desevent;

                 BEGIN
                     SV_NUM_EVENTO:= 0;
                     SN_COD_RETORNO:=0;
                     SV_MENS_RETORNO:='';

                     LV_sql:=' SELECT COD_SERVICIO,COD_SERVDEF,FEC_DESDE,NOM_USUARIO,FEC_HASTA,COD_SERVORIG,TIP_RELACION '||
                             ' FROM  GA_SERVSUP_DEF '||
                             ' WHERE COD_SERVICIO:=  ' ||EV_CodServicio ||
                             ' AND TIP_RELACION='||EN_TipRelacion;

                    OPEN SC_cursordatos FOR
                         SELECT cod_servicio, cod_servdef, fec_desde, nom_usuario, fec_hasta, cod_servorig, tip_relacion
                         FROM  ga_servsup_def
                         WHERE cod_servdef = EV_CodServicio
                         AND tip_relacion = EN_TipRelacion
                         ORDER BY cod_servicio;

                 EXCEPTION
                   WHEN NO_DATA_FOUND THEN
                        NULL;
                   WHEN OTHERS THEN
                        SN_COD_RETORNO := 150;/*No es posible recuperar servicios suplementarios activos.*/
                        LV_des_error := 'GA_ObtieneServPorDefecto_PR(' || EV_CodServicio || ',' || EN_TipRelacion || ','  || ',.. parametros de error):' || SQLERRM;
                        IF NOT GA_DocumentarErrores_FN(SN_COD_RETORNO,LV_des_error,USER, 'GA_SRVCRM_PG.GA_ObtieneServPorDefecto_PR',LV_sql,'GA',SV_NUM_EVENTO,SV_MENS_RETORNO) THEN
                           SV_MENS_RETORNO := CV_ERROR_NO_DOCUMENTADO;
                        END IF;

     END GA_ObtieneServPorDefecto_PR;

       PROCEDURE GA_RegDescontratacionCorreo_PR (
                                                  EN_NumAbonado       IN  ga_abocel.num_abonado%TYPE,
                                                  SN_COD_RETORNO      OUT NOCOPY GE_ERRORES_PG.coderror,
                                                  SV_MENS_RETORNO     OUT NOCOPY GE_ERRORES_PG.msgerror,
                                                  SV_NUM_EVENTO       OUT NOCOPY GE_ERRORES_PG.evento
                                                 ) IS
          /*
          <Documentacion TipoDoc = "Procedure">
             <Elemento
                Nombre = "GA_RegDescontratacionCorreo_PR"
                Lenguaje="PL/SQL"
                Fecha="16-01-2009"
                Version="1.0"
                Dise馻dor= "Fernando Garcia"
                Programador="Fernando Garcia"
                Ambiente_Desarrollo="BD">
                <Retorno>"Boolean"</Retorno>
                <Descripcion>"Procedimiento que marca como descontratado el servicio de correo de un abonado"</Descripcion>
                <Parametros>
                   <Entrada>
                      <param nom="EN_NumAbonado" Tipo="ga_abocel.num_abonado" Descripcion ="N鷐ero de abonado al cual se descontrata el servicio de correor"></param>
                   </Entrada>
                  <Salida>
                      <param nom="SN_COD_RETORNO" Tipo="GE_ERRORES_PG.coderror" Descripcion ="C骴igo de error de negocio. Un valor igual a cero indica ausencia de error"></param>
                      <param nom="SV_MENS_RETORNO" Tipo="GE_ERRORES_PG.msgerror" Descripcion ="Descripci髇 del error de negocio"></param>
                     <param nom="SV_NUM_EVENTO" Tipo="GE_ERRORES_PG.evento" Descripcion ="Identificador asociado al registro del detalle t閏nico del error de negocio"></param>
                   </Salida>
                </Parametros>
             </Elemento>
          </Documentacion>
          */
                   LV_sql  ge_errores_pg.vQuery;
                   LV_des_error ge_errores_pg.desevent;
                 BEGIN
                     SV_NUM_EVENTO:= 0;
                     SN_COD_RETORNO:=0;
                     SV_MENS_RETORNO:='';

                     LV_sql := 'UPDATE ga_abomail_to ' ||
                               'SET fec_baja = SYSDATE, ' ||
                               'ind_estado = 3 ' ||
                               'WHERE num_abonado = ' || EN_NumAbonado || ' ' ||
                               'AND ind_estado = 1';

                     UPDATE ga_abomail_to
                     SET fec_baja = SYSDATE,
                     ind_estado = 3
                     WHERE num_abonado = EN_NumAbonado
                     AND ind_estado = 1;

                 EXCEPTION
                   WHEN OTHERS THEN
                        SN_COD_RETORNO := 203;
                        LV_des_error := 'GA_RegDescontratacionCorreo_PR(' || EN_NumAbonado ||  ',.. parametros de error):' || SQLERRM;
                        IF NOT GA_DocumentarErrores_FN(SN_COD_RETORNO,LV_des_error,USER, 'GA_SRVCRM_PG.GA_RegDescontratacionCorreo_PR',LV_sql,'GA',SV_NUM_EVENTO,SV_MENS_RETORNO) THEN
                           SV_MENS_RETORNO := CV_ERROR_NO_DOCUMENTADO;
                        END IF;

                 END GA_RegDescontratacionCorreo_PR;


       PROCEDURE GA_GetSrvDatosBaja_PR (
                                        EN_NumAbonado   IN  ga_abocel.num_abonado%TYPE,
                                        SV_GrupoSrvDato OUT NOCOPY ga_servsupl.cod_servsupl%TYPE,
                                        SV_NivelSrvDato OUT NOCOPY ga_servsupl.cod_nivel%TYPE,
                                        SN_COD_RETORNO  OUT NOCOPY GE_ERRORES_PG.coderror,
                                        SV_MENS_RETORNO OUT NOCOPY GE_ERRORES_PG.msgerror,
                                        SV_NUM_EVENTO   OUT NOCOPY GE_ERRORES_PG.evento
                                       ) IS

          /*
          <Documentacion TipoDoc = "Procedure">
             <Elemento
                Nombre = "GA_GetSrvDatosBaja_PR"
                Lenguaje="PL/SQL"
                Fecha="19-01-2009"
                Versi贸n="1.0"
                Dise馻dor= "Fernando Garcia"
                Programador="Fernando Garcia"
                Ambiente_Desarrollo="BD">
                <Retorno>""</Retorno>
                <Descripcion>"Procedimiento que retorna el servicio de datos marcado comercialmente a la baja en SCL. Si no existe retorna NULL como grupo y nivel"</Descripcion>
                <Parametros>
                   <Entrada>
                      <param nom="EN_NumAbonado" Tipo="ga_abocel.num_abonado" Descripcion ="N鷐ero de abonado a consultar"></param>
                   </Entrada>
                  <Salida>
                      <param nom="SV_GrupoSrvDato" Tipo="ga_servsupl.cod_servsupl" Descripcion ="Grupo del servicio de datos marcado en baja comercial"></param>
                      <param nom="SV_NivelSrvDato" Tipo="ga_servsupl.cod_nivel" Descripcion ="Nivel del servicio de datos marcado en baja comercial"></param>
                      <param nom="SN_COD_RETORNO" Tipo="GE_ERRORES_PG.coderror" Descripcion ="C贸digo de error de negocio. Un valor igual a cero indica ausencia de error"></param>
                      <param nom="SV_MENS_RETORNO" Tipo="GE_ERRORES_PG.msgerror" Descripcion ="Descripcion del error de negocio"></param>
                     <param nom="SV_NUM_EVENTO" Tipo="GE_ERRORES_PG.evento" Descripcion ="Identificador asociado al registro del detalle t茅cnico del error de negocio"></param>
                   </Salida>
                </Parametros>
             </Elemento>
          </Documentacion>
          */



                   LV_sql  ge_errores_pg.vQuery;
                   LV_des_error ge_errores_pg.desevent;
                 BEGIN

                     SV_NUM_EVENTO:= 0;
                     SN_COD_RETORNO:=0;
                     SV_MENS_RETORNO:='';
                     SV_GrupoSrvDato := NULL;
                     SV_NivelSrvDato := NULL;

                     LV_sql := 'SELECT ss_abonado.cod_servsupl, ss_abonado.cod_nivel ' ||
                               'FROM ga_servsuplabo ss_abonado, ga_servsup_def ss_relaciones ' ||
                               'WHERE ss_abonado.num_abonado = ' || EN_NumAbonado || ' ' ||
                               'AND ss_relaciones.cod_servdef = ss_abonado.cod_servicio'  ||
                               'AND SYSDATE BETWEEN ss_relaciones.fec_desde AND ss_relaciones.fec_hasta' ||
                               'AND ss_relaciones.tip_relacion = 5' ||
                               'AND ss_relaciones.cod_producto = 1' ||
                               'AND ind_estado = 3'||
                               'AND ROWNUM < 2';

                     SELECT ss_abonado.cod_servsupl, ss_abonado.cod_nivel
                     INTO SV_GrupoSrvDato, SV_NivelSrvDato
                     FROM ga_servsuplabo ss_abonado, ga_servsup_def ss_relaciones
                     WHERE ss_abonado.num_abonado = EN_NumAbonado
                     AND ss_relaciones.cod_servdef = ss_abonado.cod_servicio
                     AND SYSDATE BETWEEN ss_relaciones.fec_desde AND ss_relaciones.fec_hasta
                     AND ss_relaciones.tip_relacion = 5
                     AND ss_relaciones.cod_producto = 1
                     AND ss_abonado.ind_estado = 3;

                 EXCEPTION
                   WHEN NO_DATA_FOUND THEN
                        NULL;
                   WHEN TOO_MANY_ROWS THEN
                        SN_COD_RETORNO := 214;
                        LV_des_error := 'GA_GetSrvDatosBaja_PR(' || EN_NumAbonado ||  ',.. parametros de error):' || SQLERRM;
                        IF NOT GA_DocumentarErrores_FN(SN_COD_RETORNO,LV_des_error,USER, 'GA_SRVCRM_PG.GA_GetSrvDatosBaja_PR',LV_sql,'GA',SV_NUM_EVENTO,SV_MENS_RETORNO) THEN
                           SV_MENS_RETORNO := CV_ERROR_NO_DOCUMENTADO;
                        END IF;
                   WHEN OTHERS THEN
                        SN_COD_RETORNO := 203;
                        LV_des_error := 'GA_GetSrvDatosBaja_PR(' || EN_NumAbonado ||  ',.. parametros de error):' || SQLERRM;
                        IF NOT GA_DocumentarErrores_FN(SN_COD_RETORNO,LV_des_error,USER, 'GA_SRVCRM_PG.GA_GetSrvDatosBaja_PR',LV_sql,'GA',SV_NUM_EVENTO,SV_MENS_RETORNO) THEN
                           SV_MENS_RETORNO := CV_ERROR_NO_DOCUMENTADO;
                        END IF;
                 END GA_GetSrvDatosBaja_PR;

       FUNCTION GA_IsPreRequisito_FN (
                                      EN_NumAbonado   IN  ga_abocel.num_abonado%TYPE,
                                      EV_GrupoSrvDato IN  ga_servsupl.cod_servsupl%TYPE,
                                      EV_NivelSrvDato IN  ga_servsupl.cod_nivel%TYPE,
                                      SN_COD_RETORNO  OUT NOCOPY GE_ERRORES_PG.coderror,
                                      SV_MENS_RETORNO OUT NOCOPY GE_ERRORES_PG.msgerror,
                                      SV_NUM_EVENTO   OUT NOCOPY GE_ERRORES_PG.evento
                                     ) RETURN BOOLEAN
                                       IS

          /*
          <Documentacion TipoDoc = "Function">
             <Elemento
                Nombre = "GA_IsPreRequisito_FN"
                Lenguaje="PL/SQL"
                Fecha="19-01-2009"
                Versi贸n="1.0"
                Dise馻dor= "Fernando Garcia"
                Programador="Fernando Garcia"
                Ambiente_Desarrollo="BD">
                <Retorno>"BOOLEAN"</Retorno>
                <Descripcion>"Funcion que indica si el servicio de datos informado es pre-requisito del servicio de correo contratado"</Descripcion>
                <Parametros>
                   <Entrada>
                      <param nom="EN_NumAbonado" Tipo="ga_abocel.num_abonado" Descripcion ="N鷐ero de abonado a consultar"></param>
                      <param nom="EV_GrupoSrvDato" Tipo="ga_servsupl.cod_servsupl" Descripcion ="Grupo del servicio de datos"></param>
                      <param nom="EV_NivelSrvDato" Tipo="ga_sertvsupl.cod_nivel" Descripcion ="Nivel del servicio de datos"></param>
                   </Entrada>
                  <Salida>
                      <param nom="SN_COD_RETORNO" Tipo="GE_ERRORES_PG.coderror" Descripcion ="C贸digo de error de negocio. Un valor igual a cero indica ausencia de error"></param>
                      <param nom="SV_MENS_RETORNO" Tipo="GE_ERRORES_PG.msgerror" Descripcion ="Descripcion del error de negocio"></param>
                     <param nom="SV_NUM_EVENTO" Tipo="GE_ERRORES_PG.evento" Descripcion ="Identificador asociado al registro del detalle t茅cnico del error de negocio"></param>
                   </Salida>
                </Parametros>
             </Elemento>
          </Documentacion>
          */


                   LB_Resultado BOOLEAN;
                   LV_GrupoSrvCorreo ga_servsupl.cod_servsupl%TYPE;
                   LV_NivelSrvCorreo ga_servsupl.cod_servsupl%TYPE;
                   LV_Plataforma ged_codigos.des_valor%TYPE;
                   LV_CodServicioCorreo ga_servsupl.cod_servicio%TYPE;
                   LV_CodServicioData ga_servsupl.cod_servicio%TYPE;
                   LV_Resultado VARCHAR2(1);
                   LN_COD_RETORNO GE_ERRORES_PG.coderror;
                   LV_MENS_RETORNO GE_ERRORES_PG.msgerror;
                   LV_NUM_EVENTO GE_ERRORES_PG.evento;
                   sin_correo EXCEPTION;
                   LV_sql  ge_errores_pg.vQuery;
                   LV_des_error ge_errores_pg.desevent;

                 BEGIN
                     SV_NUM_EVENTO:= 0;
                     SN_COD_RETORNO:=0;
                     SV_MENS_RETORNO:='';

                     LV_sql:= 'GA_EstadoSrvCorreoData_PR( ' || EN_NumAbonado|| ',''C'', ' || LV_GrupoSrvCorreo || ',' || LV_NivelSrvCorreo || ',' || LV_Plataforma || ',' || LN_COD_RETORNO || ',' || LV_MENS_RETORNO || ',' || LV_NUM_EVENTO || ')';
                     GA_EstadoSrvCorreoData_PR( EN_NumAbonado,'C',LV_GrupoSrvCorreo, LV_NivelSrvCorreo, LV_Plataforma, LN_COD_RETORNO, LV_MENS_RETORNO, LV_NUM_EVENTO);
                     IF LN_COD_RETORNO = 0 AND (LV_GrupoSrvCorreo IS NULL OR LV_NivelSrvCorreo IS NULL) THEN
                        RAISE sin_correo;
                     END IF;

                     LV_sql:= 'SELECT cod_servicio ' ||
                              'INTO LV_CodServicioCorreo ' ||
                              'FROM ga_servsupl ss ' ||
                              'WHERE ss.cod_producto = 1 ' ||
                              'AND ss.cod_servsupl = ' || LV_GrupoSrvCorreo || ' ' ||
                              'AND ss_cod_nivel = ' || LV_NivelSrvCorreo;

                     SELECT cod_servicio
                     INTO LV_CodServicioCorreo
                     FROM ga_servsupl ss
                     WHERE ss.cod_producto = 1
                     AND ss.cod_servsupl = LV_GrupoSrvCorreo
                     AND ss.cod_nivel = LV_NivelSrvCorreo;

                     LV_sql:= 'SELECT cod_servicio ' ||
                              'INTO LV_CodServicioCorreo ' ||
                              'FROM ga_servsupl ss ' ||
                              'WHERE ss.cod_producto = 1 ' ||
                              'AND ss.cod_servsupl = ' || EV_GrupoSrvDato || ' ' ||
                              'AND ss_cod_nivel = ' || EV_NivelSrvDato;

                     SELECT cod_servicio
                     INTO LV_CodServicioData
                     FROM ga_servsupl ss
                     WHERE ss.cod_producto = 1
                     AND ss.cod_servsupl = EV_GrupoSrvDato
                     AND ss.cod_nivel = EV_NivelSrvDato;

                     LV_sql:= 'SELECT ''T'' ' ||
                              'INTO LV_Resultado ' ||
                              'FROM ga_servsup_def ss_relaciones ' ||
                              'WHERE ss_relaciones.cod_servdef = ' || LV_CodServicioData || ' ' ||
                              'AND ss_relaciones.cod_servicio = ' || LV_CodServicioCorreo || ' ' ||
                              'AND ss_relaciones.cod_producto = 1 ' ||
                              'AND SYSDATE BETWEEN ss_relaciones.fec_desde AND ss_relaciones.fec_hasta';

                     SELECT 'T'
                     INTO LV_Resultado
                     FROM ga_servsup_def ss_relaciones
                     WHERE ss_relaciones.cod_servdef = LV_CodServicioData
                     AND ss_relaciones.cod_servicio = LV_CodServicioCorreo
                     AND ss_relaciones.cod_producto = 1
                     AND ss_relaciones.tip_relacion = 5
                     AND SYSDATE BETWEEN ss_relaciones.fec_desde AND ss_relaciones.fec_hasta;

                     RETURN TRUE;

                 EXCEPTION
                   WHEN sin_correo THEN
                        RETURN FALSE;
                   WHEN NO_DATA_FOUND THEN
                        SN_COD_RETORNO := 214;
                        LV_des_error := 'GA_IsPreRequisito_FN(' || EN_NumAbonado ||  ',.. parametros de error):' || SQLERRM;
                        IF NOT GA_DocumentarErrores_FN(SN_COD_RETORNO,LV_des_error,USER, 'GA_SRVCRM_PG.GA_IsPreRequisito_FN',LV_sql,'GA',SV_NUM_EVENTO,SV_MENS_RETORNO) THEN
                           SV_MENS_RETORNO := CV_ERROR_NO_DOCUMENTADO;
                        END IF;
                        RETURN FALSE;
                   WHEN OTHERS THEN
                        SN_COD_RETORNO := 203;
                        LV_des_error := 'GA_IsPreRequisito_FN(' || EN_NumAbonado || ',' || EV_GrupoSrvDato || ',' || EV_NivelSrvDato || ',.. parametros de error):' || SQLERRM;
                        IF NOT GA_DocumentarErrores_FN(SN_COD_RETORNO,LV_des_error,USER, 'GA_SRVCRM_PG.GA_IsPreRequisito_FN',LV_sql,'GA',SV_NUM_EVENTO,SV_MENS_RETORNO) THEN
                           SV_MENS_RETORNO := CV_ERROR_NO_DOCUMENTADO;
                        END IF;
                        RETURN FALSE;
                 END GA_IsPreRequisito_FN;

      FUNCTION GA_IsSrvDatos_FN (
                                 EV_GrupoSrvDato IN  ga_servsupl.cod_servsupl%TYPE,
                                 EV_NivelSrvDato IN  ga_servsupl.cod_nivel%TYPE,
                                 SN_COD_RETORNO  OUT NOCOPY GE_ERRORES_PG.coderror,
                                 SV_MENS_RETORNO OUT NOCOPY GE_ERRORES_PG.msgerror,
                                 SV_NUM_EVENTO   OUT NOCOPY GE_ERRORES_PG.evento
                                ) RETURN BOOLEAN
                                  IS

          /*
          <Documentacion TipoDoc = "Function">
             <Elemento
                Nombre = "GA_IsSrvDatos_FN"
                Lenguaje="PL/SQL"
                Fecha="19-01-2009"
                Versi贸n="1.0"
                Dise馻dor= "Fernando Garcia"
                Programador="Fernando Garcia"
                Ambiente_Desarrollo="BD">
                <Retorno>"BOOLEAN"</Retorno>
                <Descripcion>"Funcion que verifica si el servicio informado esta configurado como de dato para al menos 1 servicio de correo, entonces retorna True, de lo contrario False"</Descripcion>
                <Parametros>
                   <Entrada>
                      <param nom="EV_GrupoSrvDato" Tipo="ga_servsupl.cod_servsupl" Descripcion ="Grupo del servicio a evaluar"></param>
                      <param nom="EV_NivelSrvDato" Tipo="ga_sertvsupl.cod_nivel" Descripcion ="Nivel del servicio a evaluar"></param>
                   </Entrada>
                  <Salida>
                      <param nom="SN_COD_RETORNO" Tipo="GE_ERRORES_PG.coderror" Descripcion ="C贸digo de error de negocio. Un valor igual a cero indica ausencia de error"></param>
                      <param nom="SV_MENS_RETORNO" Tipo="GE_ERRORES_PG.msgerror" Descripcion ="Descripcion del error de negocio"></param>
                     <param nom="SV_NUM_EVENTO" Tipo="GE_ERRORES_PG.evento" Descripcion ="Identificador asociado al registro del detalle t茅cnico del error de negocio"></param>
                   </Salida>
                </Parametros>
             </Elemento>
          </Documentacion>
          */

                   LV_Resultado VARCHAR2(1);
                   LV_sql  ge_errores_pg.vQuery;
                   LV_des_error ge_errores_pg.desevent;
                 BEGIN

                   SV_NUM_EVENTO:= 0;
                   SN_COD_RETORNO:=0;
                   SV_MENS_RETORNO:='';

                    LV_sql := 'SELECT DISTINCT ''T'' ' ||
                              'INTO LV_Resultado ' ||
                              'FROM ga_servsupl ss, ga_servsup_def ss_relaciones ' ||
                              'WHERE ss.cod_servsupl = ' || EV_GrupoSrvDato || ' ' ||
                              'AND ss.cod_nivel = ' || EV_NivelSrvDato || ' ' ||
                              'AND ss_relaciones.cod_servdef = ss.cod_servicio ' ||
                              'AND ss_relaciones.cod_producto = 1 ' ||
                              'AND ss_relaciones.tip_relacion = 5 ' ||
                              'AND SYSDATE BETWEEN ss_relaciones.fec_desde AND ss_relaciones.fec_hasta';

                    SELECT DISTINCT 'T'
                    INTO LV_Resultado
                    FROM ga_servsupl ss, ga_servsup_def ss_relaciones
                    WHERE ss.cod_servsupl = EV_GrupoSrvDato
                    AND ss.cod_nivel = EV_NivelSrvDato
                    AND ss_relaciones.cod_servdef = ss.cod_servicio
                    AND ss_relaciones.cod_producto = 1
                    AND ss_relaciones.tip_relacion = 5
                    AND SYSDATE BETWEEN ss_relaciones.fec_desde AND ss_relaciones.fec_hasta;
                    RETURN TRUE;

                 EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                        RETURN FALSE;
                    WHEN OTHERS THEN
                        SN_COD_RETORNO := 629;
                        LV_des_error := 'GA_IsSrvDatos_FN(' || EV_GrupoSrvDato || ',' || EV_NivelSrvDato || ',.. parametros de error):' || SQLERRM;
                        IF NOT GA_DocumentarErrores_FN(SN_COD_RETORNO,LV_des_error,USER, 'GA_SRVCRM_PG.GA_IsSrvDatos_FN',LV_sql,'GA',SV_NUM_EVENTO,SV_MENS_RETORNO) THEN
                           SV_MENS_RETORNO := CV_ERROR_NO_DOCUMENTADO;
                        END IF;
                        RETURN FALSE;

                 END GA_IsSrvDatos_FN;


      FUNCTION GA_IsSrvCondicion_FN (
                                     EN_num_abonado  IN  ga_abocel.num_abonado%TYPE,
                                     EN_GrupoSrv     IN  ga_servsupl.cod_servsupl%TYPE,
                                     SN_COD_RETORNO  OUT NOCOPY GE_ERRORES_PG.coderror,
                                     SV_MENS_RETORNO OUT NOCOPY GE_ERRORES_PG.msgerror,
                                     SV_NUM_EVENTO   OUT NOCOPY GE_ERRORES_PG.evento
                                    ) RETURN BOOLEAN
                                      IS

      /*
      <Documentacion TipoDoc = "Function">
         <Elemento
            Nombre = "GA_IsSrvCondicion_FN"
            Lenguaje="PL/SQL"
            Fecha="22-01-2009"
            Versi贸n="1.0"
            Dise馻dor= "Carlos Sellao"
            Programador="Carlos Sellao"
            Ambiente_Desarrollo="BD">
            <Retorno>"BOOLEAN"</Retorno>
            <Descripcion>"Funcion que verifica si el servicio informado cumple condicion. La condicion es replicada de P_PROCESO_SERVICIOS. Retorna True, de lo contrario False"</Descripcion>
            <Parametros>
               <Entrada>
                  <param nom="EN_num_abonado" Tipo="ga_abocel.num_abonaod" Descripcion ="Numero de abonado"></param>
                  <param nom="EN_GrupoSrv" Tipo="ga_servsupl.cod_servsupl" Descripcion ="Grupo del servicio a evaluar"></param>
               </Entrada>
              <Salida>
                  <param nom="SN_COD_RETORNO" Tipo="GE_ERRORES_PG.coderror" Descripcion ="Codigo de error de negocio. Un valor igual a cero indica ausencia de error"></param>
                  <param nom="SV_MENS_RETORNO" Tipo="GE_ERRORES_PG.msgerror" Descripcion ="Descripcion del error de negocio"></param>
                 <param nom="SN_NUM_EVENTO" Tipo="GE_ERRORES_PG.evento" Descripcion ="Identificador asociado al registro del detalle t茅cnico del error de negocio"></param>
               </Salida>
            </Parametros>
         </Elemento>
      </Documentacion>
      */

      LV_Resultado VARCHAR2(1);
      LV_sql  ge_errores_pg.vQuery;
      LV_des_error ge_errores_pg.desevent;
      BEGIN

                   SV_NUM_EVENTO:= 0;
                   SN_COD_RETORNO:=0;
                   SV_MENS_RETORNO:='';

                   LV_sql := 'SELECT ''T'' ' ||
                             'INTO LV_Resultado ' ||
                             'FROM ga_servsuplabo ' ||
                             'WHERE num_abonado = ' || TO_CHAR(EN_num_abonado) ||
                             'AND cod_servsupl = ' || TO_CHAR(EN_GrupoSrv) ||
                             'AND cod_servicio IN (' ||
                             '       SELECT cod_servicio ' ||
                             '       FROM ga_servsup_def ' ||
                             '       WHERE tip_relacion = 5)'||
                             'AND cod_nivel <> 0'||
                             'AND ind_estado=2;)';

                 SELECT 'T'
                 INTO LV_Resultado
                 FROM ga_servsuplabo
                 WHERE num_abonado  = EN_num_abonado
                 AND cod_servsupl = EN_GrupoSrv
                 AND cod_servicio IN (
                                      SELECT cod_servicio
                                      FROM ga_servsup_def
                                      WHERE tip_relacion = 5)
                 AND cod_nivel <> 0
                 AND ind_estado=2;

                 RETURN TRUE;

      EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                        RETURN FALSE;
                    WHEN OTHERS THEN
                        SN_COD_RETORNO := 629;
                        LV_des_error := 'GA_IsSrvCondicion_FN('||EN_num_abonado||','||EN_GrupoSrv || ',.. parametros de error):' || SQLERRM;
                        IF NOT GA_DocumentarErrores_FN(SN_COD_RETORNO,LV_des_error,USER, 'GA_SRVCRM_PG.GA_IsSrvCondicion_FN',LV_sql,'GA',SV_NUM_EVENTO,SV_MENS_RETORNO) THEN
                           SV_MENS_RETORNO := CV_ERROR_NO_DOCUMENTADO;
                        END IF;
                        RETURN FALSE;

      END GA_IsSrvCondicion_FN;


      PROCEDURE GA_GetSrvDatosAboMailto_PR (
                                        EN_NumAbonado   IN  ga_abocel.num_abonado%TYPE,
                                        SC_cursordatos  OUT NOCOPY  REFCURSOR,
                                        SN_COD_RETORNO  OUT NOCOPY GE_ERRORES_PG.coderror,
                                        SV_MENS_RETORNO OUT NOCOPY GE_ERRORES_PG.msgerror,
                                        SV_NUM_EVENTO   OUT NOCOPY GE_ERRORES_PG.evento
                                       )  IS

          /*
          <Documentaci髇 TipoDoc = "Procedure">
             <Elemento
                Nombre = "GA_ObtieneServPorDefecto_PR"
                Lenguaje="PL/SQL"
                Fecha="07-01-2009"
                Versi髇="1.0"
                Dise馻dor= "rlozano"
                Programador="rlozano"
                Ambiente_Desarrollo="BD">
                <Retorno>"cursor"</Retorno>
                <Descripci髇>"Procedimiento que retorna los servicios por defecto  para un codigo de servicio"</Descripci髇>
                <Par醡etros>
                   <Entrada>
                      <param nom="EV_CodServicio" Tipo="GA_SERVSUP_DEF.COD_SERVICIO" Descripcion ="Codigo de servicio suplementario a consultar"></param>
                      <param nom="EV_Descontratar" Tipo="GA_SERVSUP_DEF.TIP_RELACION" Descripcion ="Indica el tipo de relacion  5: servicio de datos"></param>
                   </Entrada>
                  <Salida>
                      <param nom="C_cursordatos " Tipo="cursor" Descripcion ="relacion de servicios asociados a la activacion por defecto"></param>
                      <param nom="SN_COD_RETORNO" Tipo="GE_ERRORES_PG.coderror" Descripcion ="C骴igo de error de negocio. Un valor igual a cero indica ausencia de error"></param>
                      <param nom="SV_MENS_RETORNO" Tipo="GE_ERRORES_PG.msgerror" Descripcion ="Descripcion del error de negocio"></param>
                     <param nom="SV_NUM_EVENTO" Tipo="GE_ERRORES_PG.evento" Descripcion ="Identificador asociado al registro del detalle t閏nico del error de negocio"></param>
                   </Salida>
                </Par醡etros>
             </Elemento>
          </Documentaci髇>
          */
                  LV_sql  ge_errores_pg.vQuery;
                  LV_des_error ge_errores_pg.desevent;

                 BEGIN
                     SV_NUM_EVENTO:= 0;
                     SN_COD_RETORNO:=0;
                     SV_MENS_RETORNO:='';

                     lv_sQL:=' SELECT num_abonado ,  cod_producto,  cod_servicio,  abomail, username,passwabo,usuario,fecha_alta,observacion,ind_estado,fec_baja '||
                             ' FROM  ga_abomail_to  '||
                             ' WHERE num_abonado =  ' ||EN_NumAbonado ;


                    OPEN SC_cursordatos FOR
                    SELECT num_abonado ,  cod_producto,  cod_servicio,  abomail, username,passwabo,usuario,fecha_alta,observacion,ind_estado,fec_baja
                    FROM ga_abomail_to
                    WHERE num_abonado =EN_NumAbonado;

                 EXCEPTION
                   WHEN NO_DATA_FOUND THEN
                        NULL;
                   WHEN OTHERS THEN
                        SN_COD_RETORNO := 150;/*No es posible recuperar servicios suplementarios activos.*/
                        LV_des_error := 'GA_GetSrvDatosAboMailto_PR(' || EN_NumAbonado || ','   || ',.. parametros de error):' || SQLERRM;
                        IF NOT GA_DocumentarErrores_FN(SN_COD_RETORNO,LV_des_error,USER, 'GA_SRVCRM_PG.GA_GetSrvDatosAboMailto_PR',LV_sql,'GA',SV_NUM_EVENTO,SV_MENS_RETORNO) THEN
                           SV_MENS_RETORNO := CV_ERROR_NO_DOCUMENTADO;
                        END IF;

      END GA_GetSrvDatosAboMailto_PR;

      PROCEDURE GA_GetServicioCambioNivel_PR(
                                       EN_NumeroAbonado            IN ga_abocel.num_abonado%TYPE,
                                       EN_GrupoCadenaServicio      IN ga_servsupl.cod_servsupl%TYPE,
                                       SN_NivelServicio            OUT NOCOPY ga_servsupl.cod_nivel%TYPE,
                                       SV_CodigoComercialServicio  OUT NOCOPY ga_servsupl.cod_servicio%TYPE,
                                       SN_COD_RETORNO              OUT NOCOPY ge_errores_pg.coderror,
                                       SV_MENS_RETORNO             OUT NOCOPY ge_errores_pg.msgerror,
                                       SV_NUM_EVENTO               OUT NOCOPY ge_errores_pg.evento
                                       )IS

          /*
          <Documentacion TipoDoc = "Procedure">
             <Elemento
                Nombre = "GA_GetServicioCambioNivel_PR"
                Lenguaje="PL/SQL"
                Fecha="18-02-2009"
                Versi贸n="1.0"
                Dise馻dor= "Fernando Garcia"
                Programador="Fernando Garcia"
                Ambiente_Desarrollo="BD">
                <Retorno>""</Retorno>
                <Descripcion>"Procedimiento que verifica si para un abonado y Grupo de SS, existe un SS que esta siendo dado de baja. Usado para conocer si existe cambio de nivel en proceso"</Descripcion>
                <Parametros>
                   <Entrada>
                      <param nom="EN_NumeroAbonado" Tipo=" ga_abocel.num_abonado" Descripcion ="Abonado cuyos SS se quiere evaluar"></param>
                      <param nom="EN_GrupoCadenaServicio" Tipo="ga_servsupl.cod_servsupl" Descripcion ="Grupo de SS a Evaluar"></param>
                   </Entrada>
                  <Salida>
                      <param nom="SN_NivelServicio" Tipo="ga_servsupl.cod_nivel" Descripcion ="NIvel del SS que esta siendo dado de baja"></param>
                      <param nom="SV_CodigoComercialServicio" Tipo="ga_servsupl.cod_servicio" Descripcion ="C骴igo Comercial del SS que esta siendo dado de baja"></param>
                      <param nom="SN_COD_RETORNO" Tipo="GE_ERRORES_PG.coderror" Descripcion ="C骴igo de error de negocio. Un valor igual a cero indica ausencia de error"></param>
                      <param nom="SV_MENS_RETORNO" Tipo="GE_ERRORES_PG.msgerror" Descripcion ="Descripcion del error de negocio"></param>
                     <param nom="SV_NUM_EVENTO" Tipo="GE_ERRORES_PG.evento" Descripcion ="Identificador asociado al registro del detalle t茅cnico del error de negocio"></param>
                   </Salida>
                </Parametros>
             </Elemento>
          </Documentacion>
          */


                LV_sql  ge_errores_pg.vQuery;
                LV_des_error ge_errores_pg.desevent;
                BEGIN

                     SV_NUM_EVENTO:= 0;
                     SN_COD_RETORNO:=0;
                     SV_MENS_RETORNO:='';

                     LV_sql := 'SELECT ss_abonado.cod_nivel,ss_abonado.cod_servicio' ||
                               'FROM ga_servsuplabo ss_abonados ' ||
                               'WHERE ss_abonado.num_abonado = ' || EN_NumeroAbonado || ' ' ||
                               'AND ss_abonado.cod_servsupl = ' || EN_GrupoCadenaServicio || ' ' ||
                               'AND ss_abonado.ind_estado = 3 ';

                     SELECT ss_abonado.cod_nivel,ss_abonado.cod_servicio
                     INTO SN_NivelServicio, SV_CodigoComercialServicio
                     FROM ga_servsuplabo ss_abonado
                     WHERE ss_abonado.num_abonado = EN_NumeroAbonado
                     AND ss_abonado.cod_servsupl = EN_GrupoCadenaServicio
                     AND ss_abonado.ind_estado = 3;

                EXCEPTION

                    WHEN NO_DATA_FOUND THEN
                         SN_NivelServicio:= NULL;
                         SV_CodigoComercialServicio:= NULL;
                    WHEN OTHERS THEN
                        SN_COD_RETORNO := 629;
                        LV_des_error := 'GA_GetServicioCambioNivel_PR(' || EN_NumeroAbonado || ',' || EN_GrupoCadenaServicio || ',.. parametros de error):' || SQLERRM;
                        IF NOT GA_DocumentarErrores_FN(SN_COD_RETORNO,LV_des_error,USER, 'GA_SRVCRM_PG.GA_GetServicioCambioNivel_PR',LV_sql,'GA',SV_NUM_EVENTO,SV_MENS_RETORNO) THEN
                           SV_MENS_RETORNO := CV_ERROR_NO_DOCUMENTADO;
                        END IF;

      END GA_GetServicioCambioNivel_PR;

      PROCEDURE GA_CodigoComercialSS_PR (
                                        EN_GrupoServicio            IN ga_servsupl.cod_servsupl%TYPE,
                                        EN_NivelServicio            IN ga_servsupl.cod_nivel%TYPE,
                                        SV_CodigoComercialServicio  OUT NOCOPY ga_servsupl.cod_servicio%TYPE,
                                        SN_COD_RETORNO              OUT NOCOPY ge_errores_pg.coderror,
                                        SV_MENS_RETORNO             OUT NOCOPY ge_errores_pg.msgerror,
                                        SV_NUM_EVENTO               OUT NOCOPY ge_errores_pg.evento
                                       ) IS

          /*
          <Documentacion TipoDoc = "Procedure">
             <Elemento
                Nombre = "GA_CodigoComercialSS_PR"
                Lenguaje="PL/SQL"
                Fecha="18-02-2009"
                Versi贸n="1.0"
                Dise馻dor= "Fernando Garcia"
                Programador="Fernando Garcia"
                Ambiente_Desarrollo="BD">
                <Retorno>""</Retorno>
                <Descripcion>"Procedimiento que retorna el C骴igo Comercial de un SS dados su Grupo uy NIvel."</Descripcion>
                <Parametros>
                   <Entrada>
                      <param nom="EN_GrupoServicio" Tipo=" ga_servsupl.cod_servsupl" Descripcion ="Grupo del SS consultado"></param>
                      <param nom="EN_NivelServicio" Tipo="ga_servsupl.cod_servsupl" Descripcion ="NIvel del SS consultado"></param>
                   </Entrada>
                  <Salida>
                      <param nom="SV_CodigoComercialServicio" Tipo="ga_servsupl.cod_servicio" Descripcion ="C骴igo Comercial del SS consultado"></param>
                      <param nom="SN_COD_RETORNO" Tipo="GE_ERRORES_PG.coderror" Descripcion ="C骴igo de error de negocio. Un valor igual a cero indica ausencia de error"></param>
                      <param nom="SV_MENS_RETORNO" Tipo="GE_ERRORES_PG.msgerror" Descripcion ="Descripcion del error de negocio"></param>
                     <param nom="SV_NUM_EVENTO" Tipo="GE_ERRORES_PG.evento" Descripcion ="Identificador asociado al registro del detalle t茅cnico del error de negocio"></param>
                   </Salida>
                </Parametros>
             </Elemento>
          </Documentacion>
          */


               LV_sql  ge_errores_pg.vQuery;
               LV_des_error ge_errores_pg.desevent;
               BEGIN

                    SV_NUM_EVENTO:= 0;
                    SN_COD_RETORNO:=0;
                    SV_MENS_RETORNO:='';

                    LV_sql := 'SELECT ss.cod_servicio' ||
                              'FROM ga_servsupl ss ' ||
                              'WHERE cod_servsupl = ' || EN_GrupoServicio || ' ' ||
                              'AND cod_nivel = ' || EN_NivelServicio || ' ' ||
                              'AND cod_producto = 1 ';

                    SELECT ss.cod_servicio
                    INTO SV_CodigoComercialServicio
                    FROM ga_servsupl ss
                    WHERE cod_servsupl = EN_GrupoServicio
                    AND cod_nivel = EN_NivelServicio
                    AND cod_producto = 1;

               EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                         SV_CodigoComercialServicio:= NULL;
                    WHEN OTHERS THEN
                        SN_COD_RETORNO := 629;
                        LV_des_error := 'GA_CodigoComercialSS_PR(' || EN_GrupoServicio || ',' || EN_NivelServicio || ',.. parametros de error):' || SQLERRM;
                        IF NOT GA_DocumentarErrores_FN(SN_COD_RETORNO,LV_des_error,USER, 'GA_SRVCRM_PG.GA_CodigoComercialSS_PR',LV_sql,'GA',SV_NUM_EVENTO,SV_MENS_RETORNO) THEN
                           SV_MENS_RETORNO := CV_ERROR_NO_DOCUMENTADO;
                        END IF;

      END GA_CodigoComercialSS_PR;

      FUNCTION GA_IsPreRequisito_FN (
                                      EV_CodigoComercialCorreo IN ga_servsupl.cod_servicio%TYPE,
                                      EV_CodigoComercialDato IN ga_servsupl.cod_servicio%TYPE,
                                      SN_COD_RETORNO  OUT NOCOPY GE_ERRORES_PG.coderror,
                                      SV_MENS_RETORNO OUT NOCOPY GE_ERRORES_PG.msgerror,
                                      SV_NUM_EVENTO   OUT NOCOPY GE_ERRORES_PG.evento
                                    ) RETURN BOOLEAN
                                    IS

          /*
          <Documentacion TipoDoc = "Function">
             <Elemento
                Nombre = "GA_IsPreRequisito_FN"
                Lenguaje="PL/SQL"
                Fecha="18-02-2009"
                Versi贸n="1.0"
                Dise馻dor= "Fernando Garcia"
                Programador="Fernando Garcia"
                Ambiente_Desarrollo="BD">
                <Retorno>"BOOLEAN"</Retorno>
                <Descripcion>"Funci髇 que verifica si los dos c骴igos comerciales de SS si estan bajo una relaci髇 de ss de correo versus ss de pre-requisito. Un Valor TRUE indica que el segundo servicio es pre-requisito del primero, False indica lo contrario"</Descripcion>
                <Parametros>
                   <Entrada>
                      <param nom="EV_CodigoComercialCorreo" Tipo=" ga_servsupl.cod_servicio" Descripcion ="C骴igo Comercial del SS que actuar韆 en el rol de Serv de correo"></param>
                      <param nom="EV_CodigoComercialDato" Tipo="ga_servsupl.cod_servicio" Descripcion ="C骴igo Comercial del SS que actuar韆 en el rol de Serv de dato"></param>
                   </Entrada>
                  <Salida>
                      <param nom="SN_COD_RETORNO" Tipo="GE_ERRORES_PG.coderror" Descripcion ="C骴igo de error de negocio. Un valor igual a cero indica ausencia de error"></param>
                      <param nom="SV_MENS_RETORNO" Tipo="GE_ERRORES_PG.msgerror" Descripcion ="Descripcion del error de negocio"></param>
                     <param nom="SV_NUM_EVENTO" Tipo="GE_ERRORES_PG.evento" Descripcion ="Identificador asociado al registro del detalle t茅cnico del error de negocio"></param>
                   </Salida>
                </Parametros>
             </Elemento>
          </Documentacion>
          */


                 LI_Resultado INTEGER;
                 LV_sql  ge_errores_pg.vQuery;
                 LV_des_error ge_errores_pg.desevent;

               BEGIN

                    SV_NUM_EVENTO:= 0;
                    SN_COD_RETORNO:=0;
                    SV_MENS_RETORNO:='';

                    LV_sql := 'SELECT ss.1 ' ||
                              'ga_servsup_def ss_relaciones ' ||
                              'WHERE ss_relaciones.cod_servicio = ' || EV_CodigoComercialCorreo || ' ' ||
                              'AND ss_reaciones.cod_servdef = ' || EV_CodigoComercialDato || ' ' ||
                              'AND SYSDATE BETWEEN ss_relaciones.fec_desde AND ss_relaciones.NVL(ss_relaciones.fec_hasta,SYSDATE) ';

                   SELECT 1
                   INTO LI_Resultado
                   FROM ga_servsup_def ss_relaciones
                   WHERE ss_relaciones.cod_servicio = EV_CodigoComercialCorreo
                   AND ss_relaciones.cod_servdef = EV_CodigoComercialDato
                   AND SYSDATE BETWEEN ss_relaciones.fec_desde AND NVL(ss_relaciones.fec_hasta,SYSDATE);

                   RETURN TRUE;

               EXCEPTION

                    WHEN NO_DATA_FOUND THEN
                         RETURN FALSE;
                    WHEN OTHERS THEN
                        SN_COD_RETORNO := 629;
                        LV_des_error := 'GA_IsPreRequisito_FN(' || EV_CodigoComercialCorreo || ',' || EV_CodigoComercialDato || ',.. parametros de error):' || SQLERRM;
                        IF NOT GA_DocumentarErrores_FN(SN_COD_RETORNO,LV_des_error,USER, 'GA_SRVCRM_PG.GA_IsPreRequisito_FN',LV_sql,'GA',SV_NUM_EVENTO,SV_MENS_RETORNO) THEN
                           SV_MENS_RETORNO := CV_ERROR_NO_DOCUMENTADO;
                        END IF;
                        RETURN FALSE;

      END GA_IsPreRequisito_FN;

      FUNCTION GA_RetPlataforma_FN (
                                     EN_NUMABONADO ga_abocel.num_abonado%TYPE
                                    ) RETURN VARCHAR2
                                   IS

          /*
          <Documentacion TipoDoc = "Function">
             <Elemento
                Nombre = "GA_IsPreRequisito_FN"
                Lenguaje="PL/SQL"
                Fecha="Inicio del A駉 2009"
                Version="1.0"
                Dise馻dor= "Desconocido"
                Programador="Desconocido"
                Ambiente_Desarrollo="BD">
                <Retorno>"VARCHAR2"</Retorno>
                <Descripcion>"Funcion desarrollada en pre-produccion del P-COL-08034 Fase I, retorna la plataforma del servicio de correo que tiene contratado un abonado"</Descripcion>
                <Parametros>
                   <Entrada>
                      <param nom="EN_NUMABONADO" Tipo="ga_abocel.num_abonado" Descripcion ="Numero de abonado que tiene contratado el servicio de correo"></param>
                   </Entrada>
                </Parametros>
             </Elemento>
          </Documentacion>
          */



                 EV_GrupoSrvCorreo    GA_SERVSUPL.cod_servsupl%TYPE;
                 EV_NivelSrvCorreo    GA_SERVSUPL.cod_nivel%TYPE;
                 EV_Plataforma        ged_codigos.DES_VALOR%TYPE;
                 SN_COD_RETORNO       GE_ERRORES_PG.coderror;
                 SV_MENS_RETORNO      GE_ERRORES_PG.msgerror;
                 SV_NUM_EVENTO        GE_ERRORES_PG.evento;

               BEGIN

                Ga_Srvcrm_Pg.GA_ESTADOSRVCORREODATA_PR( EN_NUMABONADO, 'C', EV_GRUPOSRVCORREO, EV_NIVELSRVCORREO, EV_PLATAFORMA, SN_COD_RETORNO, SV_MENS_RETORNO, SV_NUM_EVENTO );
                RETURN EV_PLATAFORMA;

      END GA_RetPlataforma_FN;


END GA_SRVCRM_PG;
/
SHOW ERRORS
