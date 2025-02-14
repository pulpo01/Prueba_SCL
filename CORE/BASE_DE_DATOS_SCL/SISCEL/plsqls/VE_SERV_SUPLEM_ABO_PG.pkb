CREATE OR REPLACE PACKAGE BODY Ve_Serv_Suplem_Abo_Pg AS

         FUNCTION VE_codigoProceso_FN ( EV_PerfilProceso IN  gad_procesos_perfiles.nom_perfil_proceso%TYPE,
                                        SV_CodProceso    OUT NOCOPY gad_procesos_perfiles.cod_proceso%TYPE,
                                                                                SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                        SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                        SN_num_evento   OUT NOCOPY ge_errores_pg.Evento

                                      ) RETURN BOOLEAN IS
         /*
         <Documentacion
           TipoDoc = "FUNCTION">
            <Elemento
               Nombre = "VE_codigoProceso_FN"
               Lenguaje="PL/SQL"
               Fecha="07-03-2007"
               Version="1.0"
               Dise?ador="wjrc"
               Programador="wjrc"
               Ambiente Desarrollo="BD">
               <Retorno>BOOLEAN</Retorno>
               <Descripcion>Recuperar el codigo del poceso</Descripcion>
               <Parametros>
                  <Entrada>
                     <param nom="EV_PerfilProceso Tipo="VARCHAR2" Descripcion = "Nombre perfil proceso" </param>
                  </Entrada>
                  <Salida>
                     <param nom="SV_CodProceso"   Tipo="VARCHAR2" Descripcion = "Codigo del Proceso" </param>
                                         <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                                         <param nom="SV_mens_retorno" Tipo="STRING"> glosa mensaje error </param>
                                         <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
                  </Salida>
               </Parametros>
            </Elemento>
         </Documentacion>
         */

                           LV_des_error ge_errores_pg.DesEvent;
                           LV_sSql      ge_errores_pg.vQuery;
                 BEGIN

                                SN_num_evento:= 0;
                                SN_cod_retorno:=0;
                                SV_mens_retorno:='';
                                LV_sSql := 'SELECT a.cod_proceso'
                                                   ||' FROM gad_procesos_perfiles a'
                                                   ||' WHERE a.nom_perfil_proceso = '||EV_PerfilProceso;

                                SELECT a.cod_proceso
                                INTO SV_CodProceso
                                FROM gad_procesos_perfiles a
                                WHERE a.nom_perfil_proceso = EV_PerfilProceso;

                                RETURN TRUE;

         EXCEPTION
              WHEN OTHERS THEN
                                   SN_cod_retorno:=4;
                                   IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                  SV_mens_retorno := CV_error_no_clasIF;
                               END IF;
                           LV_des_error := SUBSTR('OTHERS:NO_DATA_FOUND; - '|| SQLERRM,1,CN_largoerrtec);
                           SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                           SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
                                   'NO_DATA_FOUND', LV_sSql, SN_cod_retorno, LV_des_error );
                   RETURN FALSE;
         END VE_codigoProceso_FN;

         FUNCTION VE_permisoUsuarioProceso_FN ( EV_NUsuario      IN  ge_seg_grpusuario.nom_usuario%TYPE,
                                                EV_CPrograma     IN  GE_SEG_PERFILES.cod_programa%TYPE,
                                                EV_NVersion      IN  GE_SEG_PERFILES.num_version%TYPE,
                                                EV_CProceso      IN  GE_SEG_PERFILES.cod_proceso%TYPE,
                                                SV_CProceso      OUT NOCOPY GE_SEG_PERFILES.cod_proceso%TYPE,
                                                                                                SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                                        SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                                        SN_num_evento    OUT NOCOPY ge_errores_pg.Evento
                                              ) RETURN BOOLEAN IS
         /*
         <Documentacion
           TipoDoc = "FUNCTION">
            <Elemento
               Nombre = "VE_permisoUsuarioProceso_FN"
               Lenguaje="PL/SQL"
               Fecha="07-03-2007"
               Version="1.0"
               Dise?ador="wjrc"
               Programador="wjrc"
               Ambiente Desarrollo="BD">
               <Retorno>BOOLEAN</Retorno>
               <Descripcion>Recuperar el codigo del poceso</Descripcion>
               <Parametros>
                  <Entrada>
                     <param nom="EV_NUsuario  Tipo="VARCHAR2" Descripcion = "Nombre del usuario </param>
                     <param nom="EV_CPrograma Tipo="VARCHAR2" Descripcion = "Codigo del programa" </param>
                     <param nom="EV_NVersion  Tipo="VARCHAR2" Descripcion = "Numero de la version" </param>
                     <param nom="EV_CProceso  Tipo="VARCHAR2" Descripcion = "Codigo del proceso" </param>
                  </Entrada>
                  <Salida>
                     <param nom="EV_CProceso  Tipo="VARCHAR2" Descripcion = "Codigo del proceso" </param>
                                        <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                                        <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
                                        <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
                  </Salida>
               </Parametros>
            </Elemento>
         </Documentacion>
         */
                           LV_des_error ge_errores_pg.DesEvent;
                           LV_sSql      ge_errores_pg.vQuery;
                 BEGIN

                                SN_num_evento:= 0;
                                SN_cod_retorno:=0;
                                SV_mens_retorno:='';
                                LV_sSql := 'SELECT a.cod_proceso'
                                                   ||' FROM GE_SEG_PERFILES a, ge_seg_grpusuario b'
                                                   ||' WHERE a.cod_grupo = b.cod_grupo'
                                                   ||' AND b.nom_usuario = '||EV_NUsuario
                                                   ||' AND a.cod_programa = '||EV_CPrograma
                                                   ||' AND a.num_version = '||EV_NVersion
                                                   ||' AND a.cod_proceso = '||EV_CProceso
                                                   ||' AND ROWNUM = 1';

                                SELECT a.cod_proceso
                                INTO SV_CProceso
                                FROM GE_SEG_PERFILES a, ge_seg_grpusuario b
                                WHERE a.cod_grupo = b.cod_grupo
                                  AND b.nom_usuario = EV_NUsuario
                                  AND a.cod_programa = EV_CPrograma
                                  AND a.num_version = EV_NVersion
                                  AND a.cod_proceso = EV_CProceso
                                  AND ROWNUM = 1;

                                RETURN TRUE;

         EXCEPTION
              WHEN NO_DATA_FOUND THEN
                                        SV_CProceso   := '';
                                    SN_cod_retorno:=4;
                                    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                   SV_mens_retorno := CV_error_no_clasIF;
                                END IF;
                            LV_des_error := SUBSTR('NO_DATA_FOUND:Ve_Serv_Suplem_Abo_Pg.VE_permisoUsuarioProceso_FN; - '|| SQLERRM,1,CN_largoerrtec);
                            SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                            SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
                                        'Ve_Serv_Suplem_Abo_Pg.VE_permisoUsuarioProceso_FN', LV_sSql, SN_cod_retorno, LV_des_error );
                                        RETURN TRUE;
              WHEN OTHERS THEN
                                    SN_cod_retorno:=4;
                                    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                   SV_mens_retorno := CV_error_no_clasIF;
                                END IF;
                            LV_des_error := SUBSTR('OTHERS:Ve_Serv_Suplem_Abo_Pg.VE_permisoUsuarioProceso_FN; - '|| SQLERRM,1,CN_largoerrtec);
                            SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                            SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
                                        'Ve_Serv_Suplem_Abo_Pg.VE_permisoUsuarioProceso_FN', LV_sSql, SN_cod_retorno, LV_des_error );
                                        RETURN FALSE;

         END VE_permisoUsuarioProceso_FN;

         FUNCTION VE_tipoPlan_FN ( EV_CPlanTarif    IN  ta_plantarif.cod_plantarif%TYPE,
                                   SV_CTiplan       OUT NOCOPY ta_plantarif.cod_tiplan%TYPE,
                                                                   SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                   SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_num_evento   OUT NOCOPY ge_errores_pg.Evento
                                 ) RETURN BOOLEAN IS
         /*
         <Documentacion
           TipoDoc = "FUNCTION">
            <Elemento
               Nombre = "VE_tipoPlan_FN"
               Lenguaje="PL/SQL"
               Fecha="07-03-2007"
               Version="1.0"
               Dise?ador="wjrc"
               Programador="wjrc"
               Ambiente Desarrollo="BD">
               <Retorno>BOOLEAN</Retorno>
               <Descripcion>Recuperar el codigo del poceso</Descripcion>
               <Parametros>
                  <Entrada>
                     <param nom="EV_CPlanTarif Tipo="VARCHAR2" Descripcion = "Codigo plan tarifario" </param>
                  </Entrada>
                  <Salida>
                     <param nom="SV_CTiplan"  Tipo="VARCHAR2" Descripcion = "Codigo tipo plan" </param>
                                         <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                                         <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
                                         <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
                  </Salida>
               </Parametros>
            </Elemento>
         </Documentacion>
         */
                           LV_des_error ge_errores_pg.DesEvent;
                           LV_sSql      ge_errores_pg.vQuery;
                 BEGIN

                                SN_num_evento:= 0;
                                SN_cod_retorno:=0;
                                SV_mens_retorno:='';
                                LV_sSql := 'SELECT a.cod_tiplan'
                                                   ||' FROM ta_plantarif a'
                                                   ||' WHERE a.cod_plantarif ='|| EV_CPlanTarif;

                                SELECT a.cod_tiplan
                                INTO SV_CTiplan
                                FROM ta_plantarif a
                                WHERE a.cod_plantarif = EV_CPlanTarif;

                                RETURN TRUE;

         EXCEPTION
              WHEN OTHERS THEN
                               SN_cod_retorno:=4;
                               IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                              SV_mens_retorno := CV_error_no_clasIF;
                           END IF;
                       LV_des_error := SUBSTR('OTHERS:Ve_Serv_Suplem_Abo_Pg.VE_tipoPlan_FN; - '|| SQLERRM,1,CN_largoerrtec);
                       SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                       SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
                                   'Ve_Serv_Suplem_Abo_Pg.VE_tipoPlan_FN', LV_sSql, SN_cod_retorno, LV_des_error );
                   RETURN FALSE;
         END VE_tipoPlan_FN;

         FUNCTION VE_codigoActCentral_FN ( EV_CProducto     IN  ga_actabo.cod_producto%TYPE,
                                           EV_CModulo       IN  ga_actabo.cod_modulo%TYPE,
                                           EV_CActAbo       IN  ga_actabo.cod_actabo%TYPE,
                                           EV_CTecnologia   IN  ga_actabo.cod_tecnologia%TYPE,
                                           SV_CActCentral   OUT NOCOPY ga_actabo.cod_actcen%TYPE,
                                                                                   SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                               SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                               SN_num_evento   OUT NOCOPY ge_errores_pg.Evento
                                         ) RETURN BOOLEAN IS
                 /*
                 <Documentacion
                   TipoDoc = "FUNCTION">
                    <Elemento
                       Nombre = "VE_codigoActCentral_FN"
                       Lenguaje="PL/SQL"
                       Fecha="07-03-2007"
                       Version="1.0"
                       Dise?ador="wjrc"
                       Programador="wjrc"
                       Ambiente Desarrollo="BD">
                       <Retorno>BOOLEAN</Retorno>
                       <Descripcion>Recuperar el Codigo de Actuacion en Central Asociado</Descripcion>
                       <Parametros>
                          <Entrada>
                             <param nom="EV_CProducto   Tipo="VARCHAR2" Descripcion = "Codigo producto" </param>
                             <param nom="EV_CModulo     Tipo="VARCHAR2" Descripcion = "Codigo modulo" </param>
                             <param nom="EV_CActAbo     Tipo="VARCHAR2" Descripcion = "Codigo actuacion abonado" </param>
                             <param nom="EV_CTecnologia Tipo="VARCHAR2" Descripcion = "Codigo tecnologia" </param>
                          </Entrada>
                          <Salida>
                             <param nom="SV_CActCentral"  Tipo="VARCHAR2" Descripcion = "Codigo actuacion central" </param>
                                                 <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                                                 <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
                                                 <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
                          </Salida>
                       </Parametros>
                    </Elemento>
                 </Documentacion>
                 */

                                   LV_des_error ge_errores_pg.DesEvent;
                                   LV_sSql      ge_errores_pg.vQuery;
                      BEGIN

                                        SN_num_evento:= 0;
                                        SN_cod_retorno:=0;
                                        SV_mens_retorno:='';
                                        SV_CActCentral := '';

                                        LV_sSql := 'SELECT a.cod_actcen '
                                                           ||' FROM ga_actabo a'
                                                           ||' WHERE a.cod_producto = '||EV_CProducto
                                                           ||' AND a.cod_modulo = '||EV_CModulo
                                                           ||' AND a.cod_actabo = '||EV_CActAbo
                                                           ||' AND a.cod_tecnologia = '||EV_CTecnologia;

                                        SELECT a.cod_actcen
                                        INTO SV_CActCentral
                                        FROM ga_actabo a
                                        WHERE a.cod_producto = EV_CProducto
                                        AND a.cod_modulo = EV_CModulo
                                        AND a.cod_actabo = EV_CActAbo
                                        AND a.cod_tecnologia = EV_CTecnologia;


                                        RETURN TRUE;

                 EXCEPTION
                      WHEN OTHERS THEN
                                       SN_cod_retorno:=4;
                                       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                      SV_mens_retorno := CV_error_no_clasIF;
                                   END IF;
                               LV_des_error := SUBSTR('OTHERS:Ve_Serv_Suplem_Abo_Pg.VE_codigoActCentral_FN; - '|| SQLERRM,1,CN_largoerrtec);
                               SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                               SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
                                           'Ve_Serv_Suplem_Abo_Pg.VE_codigoActCentral_FN', LV_sSql, SN_cod_retorno, LV_des_error );
                           RETURN FALSE;
         END VE_codigoActCentral_FN;

                 FUNCTION VE_serviciosCentrales_FN ( EV_CProducto     IN  icg_actuaciontercen.cod_producto%TYPE,
                                             EV_CModulo       IN  icg_actuacion.cod_modulo%TYPE,
                                             EV_CActuacion    IN  icg_actuaciontercen.cod_actuacion%TYPE,
                                             EV_CTipTerminal  IN  icg_actuaciontercen.tip_terminal%TYPE,
                                             EV_CSistema      IN  icg_actuaciontercen.cod_sistema%TYPE,
                                             SV_CServicios    OUT NOCOPY icg_actuaciontercen.cod_servicios%TYPE,
                                                                                         SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                                 SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                                 SN_num_evento   OUT NOCOPY ge_errores_pg.Evento
                                           ) RETURN BOOLEAN IS
                 /*
                 <Documentacion
                   TipoDoc = "FUNCTION">
                    <Elemento
                       Nombre = "VE_serviciosCentrales_FN"
                       Lenguaje="PL/SQL"
                       Fecha="07-03-2007"
                       Version="1.0"
                       Dise?ador="wjrc"
                       Programador="wjrc"
                       Ambiente Desarrollo="BD">
                       <Retorno>BOOLEAN</Retorno>
                       <Descripcion>Recuperar el Codigo de Actuacion en Central Asociado</Descripcion>
                       <Parametros>
                          <Entrada>
                             <param nom="EV_CProducto    Tipo="VARCHAR2" Descripcion = "Codigo producto" </param>
                             <param nom="EV_CModulo      Tipo="VARCHAR2" Descripcion = "Codigo modulo" </param>
                             <param nom="EV_CActuacion   Tipo="VARCHAR2" Descripcion = "Codigo actuacion abonado" </param>
                             <param nom="EV_CTipTerminal Tipo="VARCHAR2" Descripcion = "Codigo tipo terminal" </param>
                             <param nom="EV_CSistema     Tipo="VARCHAR2" Descripcion = "Codigo sistema" </param>
                          </Entrada>
                          <Salida>
                             <param nom="SV_CServicios"  Tipo="VARCHAR2" Descripcion = "Servicios central" </param>
                                                 <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                                                 <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
                                                 <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
                          </Salida>
                       </Parametros>
                    </Elemento>
                 </Documentacion>
                 */

                           LV_des_error ge_errores_pg.DesEvent;
                           LV_sSql      ge_errores_pg.vQuery;
                 BEGIN

                                        SN_num_evento:= 0;
                                        SN_cod_retorno:=0;
                                        SV_mens_retorno:='';
                                        SV_CServicios :='';

                                        LV_sSql := 'SELECT a.cod_servicios'
                                                           ||' FROM icg_actuaciontercen a'
                                                           ||' WHERE a.cod_producto = '||EV_CProducto
                                                           ||' AND a.cod_actuacion = '||EV_CActuacion
                                                           ||' AND a.tip_terminal = '||EV_CTipTerminal
                                                           ||' AND a.cod_sistema = '||EV_CSistema;

                                        BEGIN
                                        
                                        
                                        SELECT a.cod_servicios
                                        INTO SV_CServicios
                                        FROM icg_actuaciontercen a
                                        WHERE a.cod_producto = EV_CProducto
                                          AND a.cod_actuacion = EV_CActuacion
                                          AND a.tip_terminal = EV_CTipTerminal
                                          AND a.cod_sistema = EV_CSistema;
                                          
                                        EXCEPTION
                                        WHEN NO_DATA_FOUND THEN 
                                             NULL;  
                                        END;  

                                        IF SV_CServicios IS NULL OR SV_CServicios = '' THEN

                                                SV_CServicios :='';

                                                LV_sSql := 'SELECT cod_servicio'
                                                                   ||' FROM icg_actuacion a'
                                                                   ||' WHERE a.cod_producto ='||EV_CProducto
                                                                   ||' AND a.cod_modulo = '||EV_CModulo
                                                                   ||' AND a.cod_actuacion = '||EV_CActuacion;

                                                SELECT cod_servicio
                                                INTO SV_CServicios
                                                FROM icg_actuacion a
                                                WHERE a.cod_producto = EV_CProducto
                                                  AND a.cod_modulo = EV_CModulo
                                                  AND a.cod_actuacion = EV_CActuacion;

                                        END IF;

                                        RETURN TRUE;

                 EXCEPTION
                      WHEN OTHERS THEN
                                        SN_cod_retorno:=4;
                                        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                       SV_mens_retorno := CV_error_no_clasIF;
                                    END IF;
                                LV_des_error := SUBSTR('OTHERS:Ve_Serv_Suplem_Abo_Pg.VE_serviciosCentrales_FN; - '|| SQLERRM,1,CN_largoerrtec);
                                SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                                SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
                                                'Ve_Serv_Suplem_Abo_Pg.VE_serviciosCentrales_FN', LV_sSql, SN_cod_retorno, LV_des_error );
                                                RETURN FALSE;
                    END VE_serviciosCentrales_FN;


                 PROCEDURE VE_ObtieneSSdeIC_PR( EV_CProducto     IN  ga_servsuplabo.COD_PRODUCTO%TYPE,
                                              EV_CServsupl     IN  ga_servsuplabo.COD_SERVSUPL%TYPE,
                                              EV_CNivel        IN  ga_servsuplabo.COD_NIVEL%TYPE,
                                                                              SV_CServicio     OUT NOCOPY VARCHAR2,
                                                                                  SV_CConcepto     OUT NOCOPY VARCHAR2,
                                              SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                                              SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                                          SN_num_evento    OUT NOCOPY ge_errores_pg.Evento
                                          ) IS
                        /*
                        <Documentacion
                          TipoDoc = "PROCEDURE">
                           <Elemento
                              Nombre = "VE_ObtieneSSdeIC_PR"
                              Lenguaje="PL/SQL"
                              Fecha="08-03-2007"
                              Version="1.0"
                              Dise?ador="wjrc"
                              Programador="wjrc"
                              Ambiente Desarrollo="BD">
                              <Retorno>NA</Retorno>
                              <Descripcion>Obtiene los servicios suplementarios por defecto a interfaz con centrales</Descripcion>
                              <Parametros>
                                 <Entrada>
                                    <param nom="EV_CProducto" Tipo="VARCHAR2" Descripcion = "Codigo Producto" </param>
                                    <param nom="EV_CServsupl" Tipo="VARCHAR2" Descripcion = "Codigo Servicio Suplementario" </param>
                                    <param nom="EV_CNivel"    Tipo="VARCHAR2" Descripcion = "Codigo Nivel" </param>
                                 </Entrada>
                                 <Salida>
                             <param nom="SV_CServicio"  Tipo="VARCHAR2" Descripcion = "Codigo Servicio" </param>
                             <param nom="SV_CConcepto"  Tipo="VARCHAR2" Descripcion = "Codigo Concepto" </param>
                                                 <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                                                 <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
                                                 <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
                                 </Salida>
                              </Parametros>
                           </Elemento>
                        </Documentacion>
                        */

                    LV_des_error ge_errores_pg.DesEvent;
                        LV_sSql      ge_errores_pg.vQuery;
                        BEGIN

                                SV_CServicio := '';
                                SV_CConcepto := '';
                                SN_num_evento:= 0;
                                SN_cod_retorno:=0;
                                SV_mens_retorno:='';

                                LV_sSql := '   SELECT a.cod_servicio,NVL(b.cod_concepto,0)';
                            LV_sSql := LV_sSql||' FROM ga_servsupl a, ga_actuaserv b';
                            LV_sSql := LV_sSql||' WHERE a.cod_servsupl = '||EV_CServsupl;
                            LV_sSql := LV_sSql||'   AND a.cod_nivel = '|| EV_CNivel;
                                LV_sSql := LV_sSql||'   AND a.cod_producto = '|| EV_CProducto;
                                LV_sSql := LV_sSql||'   AND a.ind_comerc = '|| CV_INDCOMERCIAL;
                                LV_sSql := LV_sSql||'   AND a.tip_servicio = '|| CV_TIPSERVICIO_1;
                                LV_sSql := LV_sSql||'   AND a.cod_producto  = b.cod_producto(+)';
                                LV_sSql := LV_sSql||'   AND a.cod_servicio  = b.cod_servicio(+)';
                                LV_sSql := LV_sSql||'   AND b.cod_actabo(+) = '|| CV_CODACT_FAC;
                                LV_sSql := LV_sSql||'   AND b.cod_tipserv(+) = '|| CV_TIPSERVICIO_2;
                                
                                SELECT
                                         a.cod_servicio
                                        ,NVL(b.cod_concepto,0)
                                INTO
                                         SV_CServicio
                                        ,SV_CConcepto
                                FROM
                                         ga_servsupl a
                                        ,ga_actuaserv b
                                WHERE a.cod_servsupl = EV_CServsupl
                                        AND a.cod_nivel = EV_CNivel
                                        AND a.cod_producto = EV_CProducto
                                        AND a.ind_comerc = CV_INDCOMERCIAL
                                        AND a.tip_servicio = CV_TIPSERVICIO_1
                                        AND a.cod_producto = b.cod_producto(+)
                                        AND a.cod_servicio = b.cod_servicio(+)
                                        AND b.cod_actabo(+) = CV_CODACT_FAC
                                        AND b.cod_tipserv(+) = CV_TIPSERVICIO_2
                                        AND ROWNUM=1;

                        EXCEPTION
                              WHEN NO_DATA_FOUND THEN
                                           SV_CServicio := '';
                                           SV_CConcepto := '';
                                         SN_cod_retorno:=4;
                                         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                    SV_mens_retorno := CV_error_no_clasIF;
                                 END IF;
                                 LV_des_error := SUBSTR('NO_DATA_FOUND:Ve_Serv_Suplem_Abo_Pg.VE_ObtieneSSdeIC_PR; - '|| SQLERRM,1,CN_largoerrtec);
                                 SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                                 SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
                                         'Ve_Serv_Suplem_Abo_Pg.VE_ObtieneSSdeIC_PR', LV_sSql, SN_cod_retorno, LV_des_error );
                              WHEN OTHERS THEN
                                         SN_cod_retorno:=4;
                                         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                    SV_mens_retorno := CV_error_no_clasIF;
                                 END IF;
                                 LV_des_error := SUBSTR('OTHERS:Ve_Serv_Suplem_Abo_Pg.VE_ObtieneSSdeIC_PR; - '|| SQLERRM,1,CN_largoerrtec);
                                 SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                                 SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
                                         'Ve_Serv_Suplem_Abo_Pg.VE_ObtieneSSdeIC_PR', LV_sSql, SN_cod_retorno, LV_des_error );

                    END VE_ObtieneSSdeIC_PR;

                    FUNCTION VE_ExisteSS_FN( EV_abonado       IN  VARCHAR2,
                                                 EV_servicio      IN  VARCHAR2,
                                                                         EV_fecha         IN  VARCHAR2,
                                                                         SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                     SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_num_evento   OUT NOCOPY ge_errores_pg.Evento
                                     ) RETURN BOOLEAN IS
                        /*
                        <Documentacion
                          TipoDoc = "PROCEDURE">
                           <Elemento
                              Nombre = "VE_ExisteSS_FN"
                              Lenguaje="PL/SQL"
                              Fecha="08-03-2007"
                              Version="1.0"
                              Dise?ador="wjrc"
                              Programador="wjrc"
                              Ambiente Desarrollo="BD">
                              <Retorno> BOOLEAN </Retorno>
                              <Descripcion>Verifica si existe SS</Descripcion>
                              <Parametros>
                                 <Entrada>
                                    <param nom="EV_abonado"  Tipo="VARCHAR2" Descripcion = "Numero abonado" </param>
                                    <param nom="EV_servicio" Tipo="VARCHAR2" Descripcion = "Codigo de servicio" </param>
                                    <param nom="EV_fecha"    Tipo="VARCHAR2" Descripcion = "Fecha de alta" </param>
                                 </Entrada>
                                 <Salida>
                                                 <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                                                 <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
                                                 <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
                                 </Salida>
                              </Parametros>
                           </Elemento>
                        </Documentacion>
                        */

                    LV_des_error ge_errores_pg.DesEvent;
                    LV_sSql      ge_errores_pg.vQuery;
                        LN_contador NUMBER;
                        BEGIN
                                SN_num_evento:= 0;
                                SN_cod_retorno:=0;
                                SV_mens_retorno:='';
                                LV_sSql := 'SELECT COUNT(1)'
                                                   ||' FROM ga_servsuplabo a'
                                                   ||' WHERE a.num_abonado = '||EV_abonado
                                                   ||' AND a.cod_servicio = '||EV_servicio
                                                   --||' AND a.FEC_ALTABD = TO_DATE('||EV_fecha||','||CV_FORMATO_FECHA_SIS||')';
                                                   ||' AND a.FEC_BAJABD IS NULL';

                                LN_contador := 0;
                                SELECT COUNT(1)
                                INTO LN_contador
                                FROM ga_servsuplabo a
                                WHERE a.num_abonado = EV_abonado
                                  AND a.cod_servicio = EV_servicio
                                  --AND a.FEC_ALTABD = TO_DATE(EV_fecha,CV_FORMATO_FECHA_SIS);
                                  AND a.FEC_BAJABD IS NULL;

                                IF (LN_contador = 0) THEN
                                        RETURN FALSE;
                                ELSE
                                        RETURN TRUE;
                                END IF;

                        EXCEPTION
                              WHEN NO_DATA_FOUND THEN
                                    SN_cod_retorno:=4;
                                    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                   SV_mens_retorno := CV_error_no_clasIF;
                                END IF;
                            LV_des_error := SUBSTR('NO_DATA_FOUND:Ve_Serv_Suplem_Abo_Pg.VE_ExisteSS_FN; - '|| SQLERRM,1,CN_largoerrtec);
                            SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                            SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
                                        'Ve_Serv_Suplem_Abo_Pg.VE_ExisteSS_FN', LV_sSql, SN_cod_retorno, LV_des_error );
                                           RETURN FALSE;

                              WHEN OTHERS THEN
                                    SN_cod_retorno:=4;
                                    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                   SV_mens_retorno := CV_error_no_clasIF;
                                END IF;
                            LV_des_error := SUBSTR('OTHERS:Ve_Serv_Suplem_Abo_Pg.VE_ExisteSS_FN; - '|| SQLERRM,1,CN_largoerrtec);
                            SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                            SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
                                        'Ve_Serv_Suplem_Abo_Pg.VE_ExisteSS_FN', LV_sSql, SN_cod_retorno, LV_des_error );
                                        RETURN FALSE;

                    END VE_ExisteSS_FN;

                       PROCEDURE VE_InsertaSSAbonado_PR( EV_num_abonado      IN  VARCHAR2,
                                                         EV_cod_servicio     IN  VARCHAR2,
                                                         EV_cod_servsupl     IN  VARCHAR2,
                                                         EV_cod_nivel        IN  VARCHAR2,
                                                         EV_cod_producto     IN  VARCHAR2,
                                                         EV_num_terminal     IN  VARCHAR2,
                                                         EV_cod_concepto     IN  VARCHAR2,
                                                         EV_ind_estado       IN  VARCHAR2,
                                                         EV_num_diasnum      IN  VARCHAR2,
                                                         EV_fecha_alta       IN  VARCHAR2,
                                                         EV_usuario          IN  VARCHAR2,
                                                         SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
                                                         SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
                                                         SN_num_evento       OUT NOCOPY ge_errores_pg.Evento
                                                ) IS
                        /*
                        <Documentacion
                          TipoDoc = "PROCEDURE">
                           <Elemento
                              Nombre = "InsertaSSAbonado"
                              Lenguaje="PL/SQL"
                              Fecha="08-03-2007"
                              Version="1.0"
                              Dise?ador="wjrc"
                              Programador="wjrc"
                              Ambiente Desarrollo="BD">
                              <Retorno>NA</Retorno>
                              <Descripcion>Inserta servicio suplementario del abonado</Descripcion>
                              <Parametros>
                                 <Entrada>
                                    <param nom="EV_num_abonado" Tipo="VARCHAR2">Numero del Abonado A Crearle SS</param>
                                    <param nom="EV_cod_servicio" Tipo="VARCHAR2">codigo de servicio</param>
                                    <param nom="EV_cod_servsupl" Tipo="VARCHAR2">codigo servicio suplementario</param>
                                    <param nom="EV_cod_nivel" Tipo="VARCHAR2">codigo nivel</param>
                                    <param nom="EV_cod_producto" Tipo="VARCHAR2">codigo producto</param>
                                    <param nom="EV_num_terminal" Tipo="VARCHAR2">numero de terminal</param>
                                    <param nom="EV_cod_concepto" Tipo="VARCHAR2">codigo de concepto</param>
                                    <param nom="EV_ind_estado" Tipo="VARCHAR2">indicador de estado</param>
                                    <param nom="EV_num_diasnum" Tipo="VARCHAR2">Número de asociación con dias especiales o friends and family</param>
                                    <param nom="EV_fec_progbaja" Tipo="VARCHAR2">Fecha programada para baja del SS</param>
                                    <param nom="EV_cod_ssprogramado" Tipo="VARCHAR2">codigo servicio suplementario programado</param>
                                    <param nom="EV_fecha_alta" Tipo="VARCHAR2">Fecha de alta del SS</param>
                                 </Entrada>
                                 <Salida>
                                        <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo error de negocio Retornado</param>
                                        <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje error de negocio Retornado</param>
                                        <param nom="SN_num_evento"   Tipo="NUMBER">Nro de evento</param>
                                 </Salida>
                              </Parametros>
                           </Elemento>
                        </Documentacion>
                        */

                        LV_des_error ge_errores_pg.DesEvent;
                LV_sSql      ge_errores_pg.vQuery;
                LV_IND_IP  GA_SERVSUPL.IND_IP%TYPE;
                LV_COUNT NUMBER(9);
                 BEGIN

                                SN_num_evento:= 0;
                                SN_cod_retorno:=0;
                                SV_mens_retorno:='';

                                SELECT IND_IP 
                                INTO LV_IND_IP
                                FROM GA_SERVSUPL 
                                WHERE COD_SERVICIO=EV_cod_servicio;
                                
                SELECT COUNT(1) 
                INTO LV_COUNT
                FROM  GA_SERVSUPLABO 
                WHERE NUM_ABONADO=EV_num_abonado
                AND COD_SERVSUPL=EV_cod_servsupl;
                
                
                
                IF LV_COUNT=0 THEN 
                                
                                IF LV_IND_IP <> 0 THEN
                               
                                   PV_IPFIJA_PG.pv_generar_datos_ip_pr(EV_num_abonado,EV_num_terminal,EV_cod_producto,EV_cod_servicio,TO_DATE(EV_fecha_alta,CV_FORMATO_FECHA_SIS),
    		                       EV_cod_servsupl,EV_cod_nivel,'INS',1,3,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                               END IF; 
                                
                                   LV_sSql := '   INSERT INTO GA_SERVSUPLABO (NUM_ABONADO, COD_SERVICIO,FEC_ALTABD,';
                                   LV_sSql := LV_sSql||'COD_SERVSUPL,COD_NIVEL,COD_PRODUCTO,NUM_TERMINAL,NOM_USUARORA,';
                                   LV_sSql := LV_sSql||'IND_ESTADO,FEC_ALTACEN,FEC_BAJABD,FEC_BAJACEN,';
                                   LV_sSql := LV_sSql||'COD_CONCEPTO,NUM_DIASNUM)';
                                   LV_sSql := LV_sSql||' VALUES (';
                                   LV_sSql := LV_sSql||EV_num_abonado||','||EV_cod_servicio||',TO_DATE('||EV_fecha_alta||','||CV_FORMATO_FECHA_SIS||'),'||EV_cod_servsupl||',';
                                   LV_sSql := LV_sSql||EV_cod_nivel||','||EV_cod_producto||','||EV_num_terminal||','||EV_usuario||','||EV_ind_estado ||',';
                                   LV_sSql := LV_sSql||'NULL, NULL, NULL,'||EV_cod_concepto||','||EV_num_diasnum||')';

                                   INSERT INTO GA_SERVSUPLABO (NUM_ABONADO
                                                              ,COD_SERVICIO
                                                              ,FEC_ALTABD
                                                              ,COD_SERVSUPL
                                                              ,COD_NIVEL
                                                              ,COD_PRODUCTO
                                                              ,NUM_TERMINAL
                                                              ,NOM_USUARORA
                                                              ,IND_ESTADO
                                                              ,FEC_ALTACEN
                                                              ,FEC_BAJABD
                                                              ,FEC_BAJACEN
                                                              ,COD_CONCEPTO
                                                              ,NUM_DIASNUM
                                   )  VALUES (                 EV_num_abonado
                                                              ,EV_cod_servicio
                                                              ,TO_DATE(EV_fecha_alta,CV_FORMATO_FECHA_SIS)
                                                              ,EV_cod_servsupl
                                                              ,EV_cod_nivel
                                                              ,EV_cod_producto
                                                              ,EV_num_terminal
                                                              ,EV_usuario
                                                              ,EV_ind_estado
                                                              ,NULL
                                                              ,NULL
                                                              ,NULL
                                                              ,EV_cod_concepto
                                                              ,EV_num_diasnum
                                  );
                END IF;                                  
                      EXCEPTION
                      WHEN OTHERS THEN
                                         SN_cod_retorno:=4;
                                         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                    SV_mens_retorno := CV_error_no_clasIF;
                                 END IF;
                                 LV_des_error := SUBSTR('OTHERS:Ve_Serv_Suplem_Abo_Pg.VE_InsertaSSAbonado_PR; - '|| SQLERRM,1,CN_largoerrtec);
                                 SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                                 SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
                                         'Ve_Serv_Suplem_Abo_Pg.VE_InsertaSSAbonado_PR', LV_sSql, SN_cod_retorno, LV_des_error );

END VE_InsertaSSAbonado_PR;

                 FUNCTION VE_ObtieneNumeroDiasNum_FN(EV_codservicio    IN  VARCHAR2,
                                                                                     EV_fecha          IN  VARCHAR2,
                                                                                 EV_diasespeciales IN  VARCHAR2,
                                                                                         SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                                 SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                                 SN_num_evento   OUT NOCOPY ge_errores_pg.Evento
                                                 ) RETURN VARCHAR2 IS
                        /*
                        <Documentacion
                          TipoDoc = "PROCEDURE">
                           <Elemento
                              Nombre = "VE_ObtieneNumeroDiasNum_FN"
                              Lenguaje="PL/SQL"
                              Fecha="12-03-2007"
                              Version="1.0"
                              Dise?ador="wjrc"
                              Programador="wjrc"
                              Ambiente Desarrollo="BD">
                              <Retorno> BOOLEAN </Retorno>
                              <Descripcion>Obtiene numeros de dias /Descripcion>
                              <Parametros>
                                 <Entrada>
                                    <param nom="EV_codservicio" Tipo="VARCHAR2">Codigo de servicio</param>
                                    <param nom="EV_fecha"       Tipo="VARCHAR2">Fecha de alta</param>
                                    <param nom="EV_diasespeciales"  Tipo="VARCHAR2">numero de dias especiales</param>
                                 </Entrada>
                                 <Salida>
                                                 <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                                                 <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
                                                 <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
                                 </Salida>
                              </Parametros>
                           </Elemento>
                        </Documentacion>*/
                         LV_CodeSql       ga_errores.cod_sqlcode%TYPE;
                     LV_ErrmSql       ga_errores.cod_sqlerrm%TYPE;
                         LN_NumEvento     NUMBER;
                         LV_numdias       VARCHAR2(5);
                         LV_GrupoTelEsp   VARCHAR2(10);
                         LV_PFriendFamily VARCHAR2(20);
                         LV_des_error ge_errores_pg.DesEvent;
                     LV_sSql      ge_errores_pg.vQuery;
                         LE_exception_final EXCEPTION;
                         BEGIN
                                 SN_num_evento:= 0;
                                 SN_cod_retorno:=0;
                                 SV_mens_retorno:='';

                                --  OBTENEMOS EL VALOR PARA FRIEND AND FAMILY
                        Ve_Intermediario_Pg.VE_OBTIENE_VALOR_PARAMETRO_PR(CV_NOMPAR_FRIENDFAMI,
                                                                                  CV_CODMODULO_GA,
                                                                                      CV_CODPRODUCTO,
                                                                                                                                  LV_PFriendFamily,
                                                                                                                                  LV_CodeSql,
                                                                                                                                  LV_ErrmSql,
                                                                                                                                  LN_NumEvento);
                                IF LV_CodeSql <> 0 THEN
                                    SN_cod_retorno := LV_CodeSql;
                                        SV_mens_retorno := LV_ErrmSql;
                                        SN_num_evento := LN_NumEvento;
                                    RAISE LE_exception_final;
                                END IF;

                                LV_sSql := 'SELECT a.cod_grupo'
                                                   ||' FROM ga_grupos_servsup a'
                                                   ||' WHERE a.cod_grupo = '||LV_PFriendFamily
                                                   ||' AND TO_DATE('||EV_fecha||','||CV_FORMATO_FECHA_SIS||') BETWEEN a.fec_desde AND a.fec_hasta'
                                                   ||' AND a.cod_servicio = '||EV_codservicio;

                                BEGIN
                                        LV_GrupoTelEsp := '';
                                        SELECT a.cod_grupo
                                        INTO LV_GrupoTelEsp
                                        FROM ga_grupos_servsup a
                                        WHERE a.cod_grupo = LV_PFriendFamily
                                          AND TO_DATE(EV_fecha,CV_FORMATO_FECHA_SIS) BETWEEN a.fec_desde AND a.fec_hasta
                                          AND a.cod_servicio = EV_codservicio;

                                EXCEPTION
                                                 WHEN OTHERS THEN
                                                          LV_GrupoTelEsp := '';
                                END;

                                -- DIAS ESPECIALES
                                IF ((EV_codservicio = EV_diasespeciales) OR (LENGTH(LV_GrupoTelEsp) > 0)) THEN
                                    LV_numdias := Ve_Intermediario_Pg.VE_ObtieneNumDiasNum_FN(SN_cod_retorno,SV_mens_retorno,SN_num_evento );
                                        IF SN_cod_retorno <> 0 THEN
                                            RAISE LE_exception_final;
                                        END IF;
                                ELSE
                                   LV_numdias := NULL;
                                END IF;

                                RETURN LV_numdias;

                        EXCEPTION
                                  WHEN LE_exception_final THEN
                                   LV_des_error := SUBSTR('LE_exception_final:Ve_Serv_Suplem_Abo_Pg.VE_ObtieneNumeroDiasNum_FN; - '|| SQLERRM,1,CN_largoerrtec);
                                   SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                                   SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
                                           'Ve_Serv_Suplem_Abo_Pg.VE_ObtieneNumeroDiasNum_FN', LV_sSql, SN_cod_retorno, LV_des_error );
                                           RETURN NULL;
                              WHEN OTHERS THEN
                                           SN_cod_retorno:=4;
                                           IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                          SV_mens_retorno := CV_error_no_clasIF;
                                       END IF;
                                   LV_des_error := SUBSTR('OTHERS:Ve_Serv_Suplem_Abo_Pg.VE_ObtieneNumeroDiasNum_FN; - '|| SQLERRM,1,CN_largoerrtec);
                                   SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                                   SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
                                           'Ve_Serv_Suplem_Abo_Pg.VE_ObtieneNumeroDiasNum_FN', LV_sSql, SN_cod_retorno, LV_des_error );
                                           RETURN NULL;
                 END VE_ObtieneNumeroDiasNum_FN;

                 FUNCTION VE_InsertaSSdelPlan_FN( EV_abonado        IN  VARCHAR2,
                                                                                  EV_plan           IN  VARCHAR2,
                                                      EV_numterminal    IN  VARCHAR2,
                                                  EV_CProducto      IN  VARCHAR2,
                                                                              EV_diasespeciales IN  VARCHAR2,
                                                                                  EV_fecha          IN  VARCHAR2,
                                                                                  EV_usuario        IN  VARCHAR2,
                                                                                  SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                          SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                          SN_num_evento   OUT NOCOPY ge_errores_pg.Evento
                                            ) RETURN BOOLEAN IS
                        /*
                        <Documentacion
                          TipoDoc = "PROCEDURE">
                           <Elemento
                              Nombre = "VE_InsertaSSdelPlan_FN"
                              Lenguaje="PL/SQL"
                              Fecha="08-03-2007"
                              Version="1.0"
                              Dise?ador="wjrc"
                              Programador="wjrc"
                              Ambiente Desarrollo="BD">
                              <Retorno> BOOLEAN </Retorno>
                              <Descripcion>Obtiene e inserta los servicios suplementarios por defecto al plan</Descripcion>
                              <Parametros>
                                 <Entrada>
                        <param nom="EV_abonado" Tipo="VARCHAR2">Numero del Abonado A Crearle SS</param>
                                    <param nom="EV_plan"    Tipo="VARCHAR2">Codigo producto</param>
                                    <param nom="EV_numterminal" Tipo="VARCHAR2">numero de terminal</param>
                                    <param nom="EV_CProducto" Tipo="VARCHAR2">codigo de producto</param>
                                    <param nom="EV_diasespeciales" Tipo="VARCHAR2">numero dias especiales</param>
                                    <param nom="EV_fecha"   Tipo="VARCHAR2>Fecha de alta</param>
                                 </Entrada>
                                 <Salida>
                                                 <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                                                 <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
                                                 <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
                                 </Salida>
                              </Parametros>
                           </Elemento>
                        </Documentacion>
                        */

                        LV_CodeSql       ga_errores.cod_sqlcode%TYPE;
                    LV_ErrmSql       ga_errores.cod_sqlerrm%TYPE;
                        LN_NumEvento     NUMBER;

                        LV_FormatoFecha  VARCHAR2(20);

                    LV_cod_servsupl  VARCHAR2(2);
                    LV_cod_nivel     VARCHAR2(4);
                        LV_CConcepto     VARCHAR2(4);
                        LV_CServicio     VARCHAR2(3);
                        LV_TipDuracion   VARCHAR2(2);
                        LV_CantDias      VARCHAR2(5);
                        LV_numdias       VARCHAR2(5);

                        LV_des_error ge_errores_pg.DesEvent;
                        LV_sSql      ge_errores_pg.vQuery;
                        
                        CURSOR curSSdelPlan IS
                                SELECT
                                        a.cod_servicio,
                                        a.cod_servsupl,
                                        a.cod_nivel,
                                        b.cod_concepto
                                FROM ga_servsupl a,
                                     ga_actuaserv b,
                                     gad_servsup_plan c
                                WHERE a.ind_comerc = CV_INDCOMERCIAL
                                  AND a.tip_servicio = CV_TIPSERVICIO_1
                                  AND a.cod_producto = EV_CProducto
                                  AND a.cod_producto = b.cod_producto(+)
                                  AND a.cod_servicio = b.cod_servicio(+)
                                  AND b.cod_actabo(+) = CV_CODACT_FAC
                                  AND b.cod_tipserv(+) = CV_TIPSERVICIO_2
                                  AND a.cod_producto = c.cod_producto
                                  AND a.cod_servicio = c.cod_servicio
                                  AND c.cod_plantarif = EV_plan
                                  AND A.TIP_RED IN (SELECT TIP_RED FROM TA_PLANTARIF WHERE COD_PLANTARIF=EV_plan)
                                  AND c.tip_relacion = CV_TIPO_RELACION
                                  AND SYSDATE BETWEEN c.fec_desde AND c.fec_hasta;

                        BEGIN
                                SN_num_evento:= 0;
                                SN_cod_retorno:=0;
                                SV_mens_retorno:='';
                                
                                
                                LV_sSql :='SELECT'
                                          ||' a.cod_servicio,'
                                          ||' a.cod_servsupl,'
                                          ||' a.cod_nivel,'
                                          ||' b.cod_concepto'
                                          ||' FROM ga_servsupl a,'
                                          || ' ga_actuaserv b,'
                                          || ' gad_servsup_plan c'
                                          ||' WHERE a.ind_comerc = '||CV_INDCOMERCIAL
                                          || ' AND a.tip_servicio = '||CV_TIPSERVICIO_1
                                          || ' AND a.cod_producto = '||EV_CProducto
                                          || ' AND a.cod_producto = b.cod_producto(+)'
                                          || ' AND a.cod_servicio = b.cod_servicio(+)'
                                          || ' AND b.cod_actabo(+) = '||CV_CODACT_FAC
                                          || ' AND b.cod_tipserv(+) = '||CV_TIPSERVICIO_2
                                          || ' AND a.cod_producto = c.cod_producto'
                                          || ' AND a.cod_servicio = c.cod_servicio'
                                          || ' AND c.cod_plantarif = '||EV_plan
                                          || ' AND c.tip_relacion = '||CV_TIPO_RELACION
                                          || ' AND SYSDATE BETWEEN c.fec_desde AND c.fec_hasta';
                                --  OBTENEMOS EL VALOR PARA EL TIPO DE PLAN HIBRIDO
                        Ve_Intermediario_Pg.VE_OBTIENE_VALOR_PARAMETRO_PR(CV_NOMPAR_FORMAFECHA,
                                                                                  CV_CODMODULO_GE,
                                                                                      CV_CODPRODUCTO,
                                                                                                                                  LV_FormatoFecha,
                                                                                                                                  LV_CodeSql,
                                                                                                                                  LV_ErrmSql,
                                                                                                                                  LN_NumEvento);

                                OPEN curSSdelPlan;

                                LOOP
                                        FETCH curSSdelPlan INTO LV_CServicio,
                                                                LV_cod_servsupl,
                                                                                        LV_cod_nivel,
                                                                                        LV_CConcepto;
                                        EXIT WHEN curSSdelPlan%NOTFOUND;

                                        IF (LV_CConcepto = '0') THEN
                                                LV_CConcepto := NULL;
                                        END IF;


                                        IF (NOT VE_ExisteSS_FN(EV_abonado,LV_CServicio,EV_fecha,SN_cod_retorno,SV_mens_retorno,SN_num_evento)) THEN

                                            LV_numdias := VE_ObtieneNumeroDiasNum_FN(LV_CServicio
                                                                                        ,EV_fecha
                                                                                                                                ,EV_diasespeciales
                                                                                                                                ,SN_cod_retorno
                                                                                                                                ,SV_mens_retorno
                                                                                                                                ,SN_num_evento);

                                                -- * INSERTAMOS SERV. SUPL. DEL ABONADO
                                                VE_InsertaSSAbonado_PR( EV_abonado
                                                                       ,LV_CServicio
                                                                       ,LV_cod_servsupl
                                                                       ,LV_cod_nivel
                                                                       ,CV_CODPRODUCTO
                                                                       ,EV_numterminal
                                                                       ,LV_CConcepto
                                                                       ,CV_INDESTADO_ALTBD
                                                                       ,LV_numdias
                                                                       ,EV_fecha
                                                                                           ,EV_usuario
                                                                       ,SN_cod_retorno
                                                                                           ,SV_mens_retorno
                                                                                           ,SN_num_evento);

                                                -- SI DURACION NO ES INFINITA, SE DEBE PROGRAMAR LA DESACTIVACION
                                                --if (LV_TipDuracion <> CV_DURACION_INFINITA) then
                                                --  if (not VE_RegistraDesactivacionSS_FN(EV_abonado,LV_CServicio,LV_CantDias,SV_LV_CodeSql,LV_ErrmSql)) then
                                                --        dbms_output.PUT_LINE('Problemas al registrar desactivacion del servicio: ' || LV_CServicio);
                                                --   end if;
                                                --end if;

                                        END IF;

                                END LOOP;

                        CLOSE curSSdelPlan;

                                RETURN TRUE;

                        EXCEPTION
                              WHEN OTHERS THEN
                                           SN_cod_retorno:=4;
                                           IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                          SV_mens_retorno := CV_error_no_clasIF;
                                       END IF;
                                   LV_des_error := SUBSTR('OTHERS:Ve_Serv_Suplem_Abo_Pg.VE_InsertaSSdelPlan_FN; - '|| SQLERRM,1,CN_largoerrtec);
                                   SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                                   SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
                                           'Ve_Serv_Suplem_Abo_Pg.VE_InsertaSSdelPlan_FN', LV_sSql, SN_cod_retorno, LV_des_error );
                                           RETURN FALSE;
                 END VE_InsertaSSdelPlan_FN;

                 FUNCTION VE_InsertaSSdeIC_FN( EV_abonado        IN  VARCHAR2,
                                                   EV_numterminal    IN  VARCHAR2,
                                               EV_servCentrales  IN  VARCHAR2,
                                                                           EV_fecha          IN  VARCHAR2,
                                                                           EV_diasespeciales IN  VARCHAR2,
                                                                           EV_usuario        IN  VARCHAR2,
                                                                           SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                       SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                       SN_num_evento     OUT NOCOPY ge_errores_pg.Evento
                                     ) RETURN BOOLEAN IS
                        /*
                        <Documentacion
                          TipoDoc = "PROCEDURE">
                           <Elemento
                              Nombre = "VE_InsertaSSdeIC_FN"
                              Lenguaje="PL/SQL"
                              Fecha="08-03-2007"
                              Version="1.0"
                              Dise?ador="wjrc"
                              Programador="wjrc"
                              Ambiente Desarrollo="BD">
                              <Retorno> BOOLEAN </Retorno>
                              <Descripcion>Obtiene e inserta los servicios suplementarios por defecto al plan</Descripcion>
                              <Parametros>
                                 <Entrada>
                                 <param nom="EV_abonado"        Tipo="STRING">Numero del Abonado A Crearle SS</param>
                                 <param nom="EV_numterminal"    Tipo="STRING">Numero del terminal</param>
                                 <param nom="EV_servCentrales"  Tipo="STRING">servidor centrales</param>
                                 <param nom="EV_fecha"          Tipo="STRING">fecha de creacion de los servicios suplementarios</param>
                                 <param nom="EV_diasespeciales" Tipo="STRING">dias especiales</param>
                                 <param nom="EV_usuario"        Tipo="STRING">usuario</param>
                                 </Entrada>
                                 <Salida>
                                                 <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                                                 <param nom="SV_mens_retorno" Tipo="STRING"> glosa mensaje error </param>
                                                 <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
                                 </Salida>
                              </Parametros>
                           </Elemento>
                        </Documentacion>
                        */

                        LI_largoString   INTEGER;
                        LI_cantservs     INTEGER;
                        LI_indice        INTEGER;
                    LV_cod_servsupl  VARCHAR2(2);
                    LV_cod_nivel     VARCHAR2(4);
                        LV_CConcepto     VARCHAR2(4);
                        LV_CServicio     ga_servsuplabo.COD_SERVICIO%TYPE;

                        LV_CodeSql       ga_errores.cod_sqlcode%TYPE;
                    LV_ErrmSql       ga_errores.cod_sqlerrm%TYPE;


                        LV_des_error ge_errores_pg.DesEvent;
                        LV_sSql      ge_errores_pg.vQuery;
                        BEGIN
                             SN_num_evento:= 0;
                                 SN_cod_retorno:=0;
                                 SV_mens_retorno:='';
                                 LV_sSql := '';

                                 LI_largoString := LENGTH(EV_servCentrales);
                                 LI_cantservs := LI_largoString / 6;

                                 -- * RECORRER CADENA DE SERVICIOS OBTENIDOS DE INTERFAZ CON CENTRALES
                                 LI_indice := 0;
                         LOOP

                             IF LI_indice >= LI_cantservs THEN
                                EXIT;
                             END IF;

                             LV_cod_servsupl := SUBSTR(EV_servCentrales,6*LI_indice+1,2);
                             LV_cod_nivel := SUBSTR(EV_servCentrales,6*LI_indice+1+2,4);

                                         -- * OBETNER SERVICIO SUPLEMENTARIO DE IC
                                     VE_ObtieneSSdeIC_PR(CV_CODPRODUCTO,
                                                             LV_cod_servsupl,
                                                                                 LV_cod_nivel,
                                                                                 LV_CServicio,
                                                                                 LV_CConcepto,
                                                                                 SN_cod_retorno,
                                         SV_mens_retorno,
                                         SN_num_evento);

                                         IF (LENGTH(LV_CServicio) > 0) THEN

                                                IF (LV_CConcepto = '0') THEN
                                                    LV_CConcepto := NULL;
                                                END IF;

                                                IF (NOT VE_ExisteSS_FN(EV_abonado,LV_CServicio,EV_fecha,SN_cod_retorno,SV_mens_retorno,SN_num_evento)) THEN
                                                        -- * INSERTAMOS SERV. SUPL. DEL ABONADO
                                                    VE_InsertaSSAbonado_PR( EV_abonado
                                                                                                   ,LV_CServicio
                                                                                                   ,LV_cod_servsupl
                                                                                                   ,LV_cod_nivel
                                                                                                   ,CV_CODPRODUCTO
                                                                           ,EV_numterminal
                                                                                                   ,LV_CConcepto
                                                                                                   ,CV_INDESTADO_ALTBD
                                                                                                   ,'99'                                 -- num_diasnum ?!!!
                                                                                                   ,EV_fecha
                                                                                                   ,EV_usuario
                                                                                                   ,SN_cod_retorno
                                                                                                   ,SV_mens_retorno
                                                                                                   ,SN_num_evento);
                                                END IF;

                                         END IF;

                             LI_indice := LI_indice + 1;

                         END LOOP;

                                 RETURN TRUE;

                        EXCEPTION
                              WHEN OTHERS THEN
                                           SN_cod_retorno:=4;
                                           IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                          SV_mens_retorno := CV_error_no_clasIF;
                                       END IF;
                                   LV_des_error := SUBSTR('OTHERS:Ve_Serv_Suplem_Abo_Pg.VE_InsertaSSdeIC_FN; - '|| SQLERRM,1,CN_largoerrtec);
                                   SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                                   SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
                                           'Ve_Serv_Suplem_Abo_Pg.VE_InsertaSSdeIC_FN', LV_sSql, SN_cod_retorno, LV_des_error );
                                           RETURN FALSE;
                    END VE_InsertaSSdeIC_FN;


                    PROCEDURE VE_ObtieneDatosGenerales_PR(SV_CServLlamInt     OUT NOCOPY VARCHAR2,
                                                                                          SV_CServDetLlam     OUT NOCOPY VARCHAR2,
                                                                                                  SV_CUSoCControlada  OUT NOCOPY VARCHAR2,
                                                                                                  SV_CDiasEspeciales  OUT NOCOPY VARCHAR2,
                                                                                                  SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                                                      SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                                                      SN_num_evento   OUT NOCOPY ge_errores_pg.Evento
                                                     ) IS
                        /*
                        <Documentacion
                          TipoDoc = "PROCEDURE">
                           <Elemento
                              Nombre = "VE_ObtieneDatosGenerales_PR"
                              Lenguaje="PL/SQL"
                              Fecha="08-03-2007"
                              Version="1.0"
                              Dise?ador="wjrc"
                              Programador="wjrc"
                              Ambiente Desarrollo="BD">
                              <Retorno>NA</Retorno>
                              <Descripcion>Obtiene los servicios para cuenta controlada</Descripcion>
                              <Parametros>
                                 <Entrada>NA</Entrada>
                                 <Salida>
                             <param nom="SV_CServLlamInt"     Tipo="VARCHAR2" Descripcion = "Codigo servicio llamada internacional" </param>
                             <param nom="SV_CServDetLlam"     Tipo="VARCHAR2" Descripcion = "Codigo servicio detalle de llamadas" </param>
                             <param nom="SV_CUSoCControlada"  Tipo="VARCHAR2" Descripcion = "Codigo Uso cuenta controlada" </param>
                             <param nom="SV_CDiasEspeciales"  Tipo="VARCHAR2" Descripcion = "Codigo dias especiales" </param>
                                                 <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                                                 <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
                                                 <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
                                 </Salida>
                              </Parametros>
                           </Elemento>
                        </Documentacion>
                        */

                        LV_des_error ge_errores_pg.DesEvent;
                    LV_sSql      ge_errores_pg.vQuery;
                        BEGIN

                                SV_CServLlamInt := '';
                                SV_CServDetLlam := '';
                                SV_CUSoCControlada := '';
                                SV_CDiasEspeciales := '';

                                SN_num_evento:= 0;
                                SN_cod_retorno:=0;
                                SV_mens_retorno:='';

                                LV_sSql := '   SELECT a.cod_serllaminter,a.cod_detcel,a.cod_usocontrolada,a.cod_diasespcel';
                            LV_sSql := LV_sSql||' FROM ga_datosgener a';

                                SELECT a.cod_serllaminter
                                      ,a.cod_detcel
                                          ,a.cod_usocontrolada
                                          ,a.cod_diasespcel
                                INTO SV_CServLlamInt
                                    ,SV_CServDetLlam
                                        ,SV_CUSoCControlada
                                        ,SV_CDiasEspeciales
                        FROM ga_datosgener a;

                                SN_cod_retorno := NULL;

                        EXCEPTION
                              WHEN NO_DATA_FOUND THEN
                                           SV_CServLlamInt := '';
                                           SV_CServDetLlam := '';
                                           SV_CUSoCControlada := '';
                                           SV_CDiasEspeciales := '';
                                           SN_cod_retorno:=4;
                                           IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                      SV_mens_retorno := CV_error_no_clasIF;
                                   END IF;
                                   LV_des_error := SUBSTR('NO_DATA_FOUND:Ve_Serv_Suplem_Abo_Pg.VE_ObtieneDatosGenerales_PR; - '|| SQLERRM,1,CN_largoerrtec);
                                   SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                                   SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
                                           'Ve_Serv_Suplem_Abo_Pg.VE_ObtieneDatosGenerales_PR', LV_sSql, SN_cod_retorno, LV_des_error );
                              WHEN OTHERS THEN
                                           SN_cod_retorno:=4;
                                           IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                      SV_mens_retorno := CV_error_no_clasIF;
                                   END IF;
                                   LV_des_error := SUBSTR('OTHERS:Ve_Serv_Suplem_Abo_Pg.VE_ObtieneDatosGenerales_PR; - '|| SQLERRM,1,CN_largoerrtec);
                                   SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                                   SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
                                           'Ve_Serv_Suplem_Abo_Pg.VE_ObtieneDatosGenerales_PR', LV_sSql, SN_cod_retorno, LV_des_error );

                        END VE_ObtieneDatosGenerales_PR;


        --------------------------
        -- * RUTINA PRINCIPAL * --
        --------------------------
        PROCEDURE VE_ProcesoSSAbonado_PR( EV_abonado       IN  VARCHAR2,
                                          EV_plan          IN  VARCHAR2,
                                          EV_numterminal   IN  VARCHAR2,
                                          EV_usuario       IN  VARCHAR2,
                                          EV_CodTecnologia IN  AL_TECNOLOGIA.COD_TECNOLOGIA%TYPE,
                                          EV_TipTerminal   IN  AL_TIPOS_TERMINALES.TIP_TERMINAL%TYPE, 
                                          SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                          SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                          SN_num_evento   OUT NOCOPY ge_errores_pg.Evento
                                                      ) IS
        /*
        <Documentacion
          TipoDoc = "PROCEDURE">
           <Elemento
              Nombre = "ProcesoSSAbonado"
              Lenguaje="PL/SQL"
              Fecha="08-03-2007"
              Version="1.0"
              Dise?ador="wjrc"
              Programador="wjrc"
              Ambiente Desarrollo="BD">
              <Retorno>NA</Retorno>
              <Descripcion>Activar y o Desactivar Servicios Suplementarios Aproviocionados en central</Descripcion>
              <Parametros>
                 <Entrada>
                    <param nom="EV_abonado" Tipo="VARCHAR2">Numero del Abonado A Crearle SS</param>
                    <param nom="EV_plan" Tipo="VARCHAR2">codigo de plan</param>
                    <param nom="EV_numterminal" Tipo="VARCHAR2">numero de terminal</param>
                 </Entrada>
                 <Salida>
                                 <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                                 <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
                                 <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
                 </Salida>
              </Parametros>
           </Elemento>
        </Documentacion>
        */
                -- * EXCEPCIONES
        error_parametros               EXCEPTION;

                -- * OTROS

            arrParametros    ArregloParametros;

                --              arrParametros(1) -> tipo de plan
                --              arrParametros(2) -> tipo de plan hibrido
                --              arrParametros(3) -> codigo actuacion interfaz centrales
                --              arrParametros(4) -> indicador de autentificacion
                --              arrParametros(5) -> codigo de proceso
                --              arrParametros(6) -> permisos usuarios para el proceso

            scode_error          ga_errores.cod_sqlcode%TYPE;
            sdes_error           ge_errores_pg.desevent;
                LV_des_error     ge_errores_pg.desevent;
            LV_sSql          ge_errores_pg.vquery;

                LV_servCentrales VARCHAR2(255);

                LN_CServSupl     ga_servsuplabo.COD_SERVSUPL%TYPE;
                LN_CNivel        ga_servsuplabo.COD_NIVEL%TYPE;

                LV_CodAct        VARCHAR2(2);
                LV_ValParametro  VARCHAR2(20);
                LB_CargaSS_IC    BOOLEAN; -- Indica si se deben cargar los SS definidos por Int.Centrales
                LB_permisosOK    BOOLEAN; -- permiso del usuario sobre el proceso
                LV_fecha         VARCHAR2(17);
        BEGIN
                SN_num_evento:= 0;
                SN_cod_retorno:=0;
                SV_mens_retorno:='';

                LV_fecha := TO_CHAR(SYSDATE,CV_FORMATO_FECHA_SIS);
                LV_sSql  := '';

                -- OBTENEMOS DATOS GENERALES
                --LV_sSql := 'VE_ObtieneDatosGenerales_PR()';
                VE_ObtieneDatosGenerales_PR(arrParametros(4),arrParametros(5),arrParametros(6),arrParametros(7),SN_cod_retorno,SV_mens_retorno,SN_num_evento );

                -----------------------------------------------------------------------
                -- * SERVICIOS SUPLEMENTARIOS POR DEFECTO A INTERFAZ CON CENTRALES * --
                -----------------------------------------------------------------------
                
                LV_CodAct := CV_CODACT_VEN;

                -- OBTENEMOS EL TIPO DE PLAN, SEGUN EL PLAN TARIFARIO

                --LV_sSql := 'VE_tipoPlan_FN('||EV_plan||','||arrParametros(1)||','||SN_cod_retorno||','||SV_mens_retorno||')';
                IF NOT VE_tipoPlan_FN(EV_plan,arrParametros(1),SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
                      RAISE error_parametros;
                   END IF;

                --  OBTENEMOS EL VALOR PARA EL TIPO DE PLAN HIBRIDO
                      --LV_sSql := 'Ve_Intermediario_Pg.VE_OBTIENE_VALOR_PARAMETRO_PR('||CV_NOMPAR_TIPPLANHIB||','||CV_CODMODULO_GA||','||CV_CODPRODUCTO||',';
                --LV_sSql := LV_sSql||LV_ValParametro||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||')';
                Ve_Intermediario_Pg.VE_OBTIENE_VALOR_PARAMETRO_PR(CV_NOMPAR_TIPPLANHIB,
                                                                   CV_CODMODULO_GA,
                                                                                                                   CV_CODPRODUCTO,
                                                                                                                   LV_ValParametro,
                                                                                                                   SN_cod_retorno,
                                                                                                                   SV_mens_retorno,
                                                                                                                   SN_num_evento);

                 arrParametros(2) := LV_ValParametro;

                 --SI EL TIPO DE PLAN ES HIBRIDO, CAMBIA EL CODIGO DE ACTUACION
                 IF (arrParametros(1) = arrParametros(2)) THEN
                         LV_CodAct := CV_CODACT_AAH;
                 END IF;
                 
                 IF (arrParametros(1) = 1) THEN
                         LV_CodAct := CV_CODACT_AAM;
                 END IF;
                 

                 -- OBTENEMOS EL CODIGO DE ACTUACION DE INTERFAZ CENTRALES
             --LV_sSql := 'VE_codigoActCentral_FN('||CV_CODPRODUCTO||','||CV_CODMODULO_GA||','||LV_CodAct||',';
                 --LV_sSql := LV_sSql||CV_TECNOLOGIA||','||arrParametros(3)||','||SN_cod_retorno||','||SV_mens_retorno||')';
                 IF NOT VE_codigoActCentral_FN(CV_CODPRODUCTO,CV_CODMODULO_GA,LV_CodAct,EV_CodTecnologia,arrParametros(3),SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
                RAISE error_parametros;
             END IF;

                 -- SI NO EXISTE CODIGO DE ACTUACION PARA CENTRALES, NO SE DEDE PROSEGUIR CON LA CARGA DE SS DE IC
                 IF (LENGTH(arrParametros(3)) > 0) THEN

                         -- * OBTENER CADENA CON SERV. SUPL. POR DEFECTO A INTERFAZ CON CENTRALES
                     --LV_sSql := 'VE_serviciosCentrales_FN('||CV_CODPRODUCTO||','||CV_CODMODULO_GA||','||arrParametros(3)||',';
                         --LV_sSql := LV_sSql||CV_TIPTERMINAL_SIMC||','||CV_SISTEMA||','||LV_servCentrales||','||SN_cod_retorno||','||SV_mens_retorno||')';
                         IF NOT VE_serviciosCentrales_FN(CV_CODPRODUCTO,CV_CODMODULO_GA,arrParametros(3),EV_TipTerminal,CV_SISTEMA,LV_servCentrales,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
                        RAISE error_parametros;
                     END IF;

                         --LV_sSql := 'VE_InsertaSSdeIC_FN('||EV_abonado||','||EV_numterminal||','||LV_servCentrales||',';
                         --LV_sSql := LV_sSql||LV_fecha||','||arrParametros(7)||','||SN_cod_retorno||','||SV_mens_retorno||')';
                         
                         IF LV_servCentrales is not null then 
                         
                            IF NOT VE_InsertaSSdeIC_FN(EV_abonado,                                 -- codigo del abonado
                                                       EV_numterminal,                             -- numero del terminal
                                                       LV_servCentrales,                       -- cadena con ss de ic
                                                       LV_fecha,                                       -- fecha sistema
                                                       arrParametros(7),                   -- codigo dias especiales
                                                       EV_usuario,                                     -- usuario
                                                       SN_cod_retorno,                         -- codigo error sql
                                                       SV_mens_retorno,                        -- descripcion error sql
                                                       SN_num_evento) THEN
                                RAISE error_parametros;
                            END IF;
                        END IF;    

                 END IF;

                 ------------------------------------------------------
                 -- * SERVICIOS SUPLEMENTARIOS POR DEFECTO AL PLAN * --
                 ------------------------------------------------------

                 IF (LENGTH(arrParametros(4)) > 0 AND LENGTH(arrParametros(5)) > 0) THEN

                         -- OBETNER SERVICIO SUPLEMENTARIO DEL PLAN
                     --LV_sSql := 'VE_InsertaSSdelPlan_FN('||EV_abonado||','||EV_plan||','||EV_numterminal||','||CV_CODPRODUCTO||',';
                         --LV_sSql := LV_sSql||arrParametros(7)||','||LV_fecha||','||SN_cod_retorno||','||SV_mens_retorno||')';
                         IF NOT VE_InsertaSSdelPlan_FN(EV_abonado,                        -- codigo del abonado
                                                                                   EV_plan,                       -- codigo plan tarifario
                                                       EV_numterminal,            -- numero del terminal
                                                       CV_CODPRODUCTO,            -- codigo producto
                                                       arrParametros(7),          -- codigo dias especiales
                                                                                   LV_fecha,                      -- fecha sistema
                                                                                   EV_usuario,                    -- usuario
                                                                           SN_cod_retorno,                -- codigo error sql
                                                                           SV_mens_retorno,               -- descripcion error sql
                                                                                   SN_num_evento
                                                                                   ) THEN
                                RAISE error_parametros;
                         END IF;

                 END IF;

                EXCEPTION
              WHEN error_parametros THEN
                   SN_cod_retorno:=4;
                           IF EV_abonado IS NOT NULL THEN
                      INSERT INTO GA_ERRORES
                      (COD_ACTABO,CODIGO,FEC_ERROR,COD_PRODUCTO,NOM_PROC,NOM_TABLA,COD_ACT,COD_SQLCODE,COD_SQLERRM)
                      VALUES
                      ('SS',TO_NUMBER(EV_abonado),SYSDATE,1,'VE_SERV_SUPLEM_ABO_PG.VE_ProcesoSSAbonado_PR',NULL,'P',SN_cod_retorno,SV_mens_retorno);
                   END IF;
                           IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasIF;
                   END IF;
                           LV_des_error := SUBSTR('error_parametros:Ve_Serv_Suplem_Abo_Pg.VE_ProcesoSSAbonado_PR; - '|| SQLERRM,1,CN_largoerrtec);
                   SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                   SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
                           'Ve_Serv_Suplem_Abo_Pg.VE_ProcesoSSAbonado_PR', LV_sSql, SN_cod_retorno, LV_des_error );
              WHEN NO_DATA_FOUND THEN
                   SV_mens_retorno:= SUBSTR(SQLERRM,1,60);
                   SN_cod_retorno:=5;
                           IF EV_abonado IS NOT NULL THEN
                      INSERT INTO GA_ERRORES
                      (COD_ACTABO,CODIGO,FEC_ERROR,COD_PRODUCTO,NOM_PROC,NOM_TABLA,COD_ACT,COD_SQLCODE,COD_SQLERRM)
                      VALUES
                      ('SS',TO_NUMBER(EV_abonado),SYSDATE,1,'VE_SERV_SUPLEM_ABO_PG.VE_ProcesoSSAbonado_PR',NULL,'F',SN_cod_retorno,SV_mens_retorno);
                   END IF;
                           IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasIF;
                   END IF;
                   LV_des_error := SUBSTR('NO_DATA_FOUND:Ve_Serv_Suplem_Abo_Pg.VE_ProcesoSSAbonado_PR; - '|| SQLERRM,1,CN_largoerrtec);
                   SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                   SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
                           'Ve_Serv_Suplem_Abo_Pg.VE_ProcesoSSAbonado_PR', LV_sSql, SN_cod_retorno, LV_des_error );

              WHEN OTHERS THEN
                           SN_cod_retorno:=6;
                   IF EV_abonado IS NOT NULL THEN
                      INSERT INTO GA_ERRORES
                      (COD_ACTABO,CODIGO,FEC_ERROR,COD_PRODUCTO,NOM_PROC,NOM_TABLA,COD_ACT,COD_SQLCODE,COD_SQLERRM)
                      VALUES
                      ('SS', TO_NUMBER(EV_abonado),SYSDATE,1,'VE_SERV_SUPLEM_ABO_PG.VE_ProcesoSSAbonado_PR',NULL,'F',SN_cod_retorno,SV_mens_retorno);

                   END IF;
                           IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasIF;
                   END IF;
                   LV_des_error := SUBSTR('OTHERS:Ve_Serv_Suplem_Abo_Pg.VE_ProcesoSSAbonado_PR; - '|| SQLERRM,1,CN_largoerrtec);
                           SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                   SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
                           'Ve_Serv_Suplem_Abo_Pg.VE_ProcesoSSAbonado_PR', LV_sSql, SN_cod_retorno, LV_des_error );
                           ROLLBACK;

        END VE_ProcesoSSAbonado_PR;

        PROCEDURE VE_obtiene_SS_abonado_PR( EV_num_abonado     IN NUMBER,
                                                                    SC_cursordatos         OUT NOCOPY REFCURSOR,
                                                                        SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                                        SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                                        SN_num_evento      OUT NOCOPY ge_errores_pg.Evento) IS

        /*--
        <Documentacion TipoDoc = "Procedimiento">
                Elemento Nombre = "VE_obtiene_SS_abonado_PR"
                Lenguaje="PL/SQL"
                Fecha="05-04-2007"
                Version="1.0.0"
                Dise?ador="mats"
                Programador="mats"
                Ambiente="BD"
        <Retorno>NA</Retorno>
        <Descripcion>
                Recupera ss para el numero de abonado ingresado
        </Descripcion>
        <Parametros>
        <Entrada>
                <param nom="EV_num_abonado"     Tipo="NUMBER> numero de abonado </param>
        </Entrada>
        <Salida>
                <param nom="SC_cursordatos"  Tipo="CURSOR"> cursor con abonados seleccionados </param>
                <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
                <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/
           no_data_found_cursor               EXCEPTION;
           LV_des_error ge_errores_pg.DesEvent;
           LV_sSql      ge_errores_pg.vQuery;
           cod_servicio1 ga_servsuplabo.cod_servicio%TYPE;
           cod_servsupl1 VARCHAR2(100);
           cod_nivel1 VARCHAR2(100);
           cod_concepto1 VARCHAR2(100);
           LN_contador NUMBER;
       LV_PLANTARIF GA_ABOCEL.COD_PLANTARIF%TYPE;
        BEGIN
                SN_num_evento:= 0;
                SN_cod_retorno:=0;
                SV_mens_retorno:='';


        SELECT COD_PLANTARIF
        INTO LV_PLANTARIF
        FROM GA_ABOCEL
        WHERE NUM_ABONADO=EV_num_abonado;


        LV_sSql := '   SELECT cod_servicio,cod_servsupl,cod_nivel,cod_concepto';
        LV_sSql := LV_sSql||' FROM ga_servsuplabo';
        LV_sSql := LV_sSql||' WHERE num_abonado = '||EV_num_abonado;
        LV_sSql := LV_sSql||' AND ind_estado IN( '||CV_ESTADO_1||','||CV_ESTADO_2||')';
        LV_sSql := LV_sSql||' AND a.cod_servicio NOT IN (select COD_SERVICIO FROM GAD_SERVSUP_PLAN WHERE COD_PLANTARIF =2T and TIP_RELACION=2 AND SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA ANd COD_SERVICIO NOT IN (SELECT cod_valor FROM GED_CODIGOS WHERE NOM_TABLA = GA_SS_COBRO_INMEDIATO AND NOM_COLUMNA = COD_SERVICIO))';

                LN_contador := 0;
                SELECT COUNT(1)
                INTO LN_contador
                FROM ga_servsuplabo a
                WHERE a.num_abonado = EV_num_abonado
            AND a.ind_estado IN (CV_ESTADO_1,CV_ESTADO_2)
            AND COD_SERVICIO IN (SELECT COD_SERVICIO FROM GA_SERVSUPL WHERE TIP_COBRO='A')
            AND ROWNUM <= 1;


        OPEN SC_cursordatos FOR

                SELECT a.cod_servicio
                           ,a.cod_servsupl
                           ,a.cod_nivel
                           ,a.cod_concepto
                FROM ga_servsuplabo a
                WHERE a.num_abonado = EV_num_abonado
                AND a.ind_estado IN (CV_ESTADO_1,CV_ESTADO_2)
                AND COD_SERVICIO IN (SELECT COD_SERVICIO FROM GA_SERVSUPL WHERE TIP_COBRO='A');

                IF (LN_contador = 0) THEN
                        NULL;
            --es decir no existen SS para cobro en una factura inmediata
                END IF;

        EXCEPTION
                WHEN no_data_found_cursor THEN
                         SN_cod_retorno:=99;
                 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := CV_error_no_clasIF;
                 END IF;
                 LV_des_error := SUBSTR('no_data_found_cursor:Ve_Serv_Suplem_Abo_Pg.VE_obtiene_SS_abonado_PR; - '|| SQLERRM,1,CN_largoerrtec);
                 SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                         SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
                         'Ve_Serv_Suplem_Abo_Pg.VE_obtiene_SS_abonado_PR', LV_sSql, SN_cod_retorno, LV_des_error );
                WHEN OTHERS THEN
                         SN_cod_retorno:=4;
                         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := CV_error_no_clasIF;
                 END IF;
                 LV_des_error := SUBSTR('OTHERS:Ve_Serv_Suplem_Abo_Pg.VE_obtiene_SS_abonado_PR; - '|| SQLERRM,1,CN_largoerrtec);
                 SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                 SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
                         'Ve_Serv_Suplem_Abo_Pg.VE_obtiene_SS_abonado_PR', LV_sSql, SN_cod_retorno, LV_des_error );
        END VE_obtiene_SS_abonado_PR;

        PROCEDURE VE_obtiene_SSabo_paracent_PR(EN_numabonado   IN ga_servsuplabo.num_abonado%TYPE,
                                               EN_indestado    IN ga_servsuplabo.ind_estado%TYPE,
                                               EV_codProducto  IN VARCHAR2,
                                               EV_codModulo    IN VARCHAR2,
                                               EV_codSistema   IN VARCHAR2,
                                               EV_codActuacion IN VARCHAR2,
                                               EV_TipTerminal  IN AL_TIPOS_TERMINALES.TIP_TERMINAL%TYPE,
                                               SC_cursordatos  OUT NOCOPY REFCURSOR,
                                               SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                               SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                               SN_num_evento   OUT NOCOPY ge_errores_pg.Evento) IS
                /*--
                <Documentacion TipoDoc = "Procedimiento">
                        Elemento Nombre = "VE_obtiene_SSabo_paracent_PR"
                        Lenguaje="PL/SQL"
                        Fecha="05-04-2007"
                        Version="1.0.0"
                        Dise?ador="mats"
                        Programador="mats"
                        Ambiente="BD"
                <Retorno>NA</Retorno>
                <Descripcion>
                        Recupera ss para el numero de abonado ingresado para el indicador ingresado
                </Descripcion>
                <Parametros>
                <Entrada>
                        <param nom="EN_numabonado"   Tipo="NUMBER> numero de abonado </param>
                        <param nom="EN_indestado"    Tipo="NUMBER> indicador estado</param>
                        <param nom="EV_codProducto"  Tipo="STRING"> codigo producto </param>
                        <param nom="EV_codModulo"    Tipo="STRING"> codigo modulo </param>
                        <param nom="EV_codSistema    Tipo="STRING"> codigo sistema </param>
                        <param nom="EV_codActuacion" Tipo="STRING"> codigo actuacion centrales </param>
                </Entrada>
                <Salida>
                        <param nom="SC_cursordatos"  Tipo="CURSOR"> cursor con abonados seleccionados </param>
                        <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                        <param nom="SV_mens_retorno" Tipo="STRING"> glosa mensaje error </param>
                        <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
                </Salida>
                </Parametros>
                </Elemento>
                </Documentacion>
                --*/
                LE_exception_fin         EXCEPTION;
                no_data_found_cursor EXCEPTION;

                CN_LARGOSUBSTRING    CONSTANT NUMBER  := 6;
                CC_CHAR                  CONSTANT CHAR    := ' ';

                LA_arreglo           VE_intermediario_PG.tipoArray := VE_intermediario_PG.tipoArray();

                LV_des_error         ge_errores_pg.DesEvent;
                LV_sSql              ge_errores_pg.vQuery;

                LN_contador          NUMBER;
                LN_indice            NUMBER;
                LV_ValParametro      VARCHAR2(20);
                LV_cadenaServicio    VARCHAR2(1000);
                LV_condicion         VARCHAR2(1000);
                LC_char1             CHAR;
        BEGIN
                SN_cod_retorno:=0;
                SV_mens_retorno:='';
                SN_num_evento:= 0;

                -- OBTENER TIPO TERMINAL
                --Ve_Intermediario_Pg.VE_OBTIENE_VALOR_PARAMETRO_PR(CV_NOMPAR_TIPTERMINALGSM,
                --                                                  CV_CODMODULO_AL,
                --                                                                                                  EV_codProducto,
                --                                                                                                  LV_ValParametro,
                --                                                                                                  SN_cod_retorno,
                --                                                                                                 SV_mens_retorno,
                --                                                                                                  SN_num_evento);
                --IF (SN_cod_retorno <> 0) THEN
                 --       RAISE LE_exception_fin;
                --END IF;

                -- BUSCA CADENA DE SERVICIOS POR DEFECTO A CENTRALES
                
                
            BEGIN    
                
                
                LV_cadenaServicio := '';
                SELECT a.cod_servicios
                INTO LV_cadenaServicio
                FROM icg_actuaciontercen a
                WHERE a.cod_producto = EV_codProducto
                AND a.tip_terminal = EV_TipTerminal
                AND a.cod_sistema = EV_codSistema
                AND a.cod_actuacion = EV_codActuacion;

                IF (LV_cadenaServicio = '' OR LV_cadenaServicio IS NULL) THEN
                        LV_cadenaServicio := '';
                        SELECT cod_servicio
                        INTO LV_cadenaServicio
                        FROM icg_actuacion
                        WHERE cod_actuacion = EV_codActuacion
                        AND cod_producto = EV_codProducto
                        AND cod_modulo = EV_codModulo;
                END IF;
            EXCEPTION
            WHEN NO_DATA_FOUND THEN 
                 NULL; 
            END;
                LA_arreglo := VE_intermediario_PG.VE_descompone_cadena_FN(LV_cadenaServicio,
                                                                          CN_LARGOSUBSTRING,
                                                                                                                      SN_cod_retorno,
                                                                                                                      SV_mens_retorno,
                                                                                                                      SN_num_evento);

                IF (SN_cod_retorno <> 0) THEN
                        RAISE LE_exception_fin;
                END IF;

        LV_condicion := '(';
                FOR LN_indice IN 1..LA_arreglo.COUNT LOOP
            LV_condicion := LV_condicion || '''' || LA_arreglo(LN_indice) || ''',';
                END LOOP;

        LV_condicion := SUBSTR(LV_condicion,1,LENGTH(LV_condicion)-1) || ')';

                IF (SN_cod_retorno <> 0) THEN
                        RAISE LE_exception_fin;
                END IF;

                LN_contador := 0;
                LV_sSql := 'SELECT COUNT(1)';
            LV_sSql := LV_sSql ||' FROM ga_servsuplabo a';
            LV_sSql := LV_sSql ||' WHERE a.num_abonado = '||EN_numabonado;
            LV_sSql := LV_sSql ||' AND a.ind_estado = '|| EN_indestado;
            IF TRIM(LV_CONDICION) <> '('''')' THEN 
                    LV_sSql := LV_sSql ||' AND replace(TO_CHAR(a.cod_servsupl,''09'')||'
                                       || 'TO_CHAR(a.cod_nivel, ''0999''),''' || CC_CHAR || ''','''') '
                                       || 'NOT IN' || LV_condicion;
            END IF;                                       

        EXECUTE IMMEDIATE LV_sSql INTO LN_contador;

                LV_sSql := 'SELECT a.cod_servicio,a.cod_servsupl,a.cod_nivel,a.cod_concepto';
            LV_sSql := LV_sSql ||' FROM ga_servsuplabo a';
            LV_sSql := LV_sSql ||' WHERE a.num_abonado = '||EN_numabonado;
            LV_sSql := LV_sSql ||' AND a.ind_estado = '|| EN_indestado;
            
            IF TRIM(LV_CONDICION) <> '('''')' THEN 
               LV_sSql := LV_sSql ||' AND replace(TO_CHAR(a.cod_servsupl,''09'')||'
                                  || 'TO_CHAR(a.cod_nivel, ''0999''),''' || CC_CHAR || ''','''') '
                                  || 'NOT IN' || LV_condicion;
            END IF;                                                    

                OPEN SC_cursordatos FOR LV_sSql;

                IF (LN_contador = 0) THEN
                        RAISE no_data_found_cursor;
                END IF;

        EXCEPTION
                WHEN LE_exception_fin THEN
                LV_des_error:='LE_exception_fin: VE_intermediario_PG.VE_ObtieneNumeroCelularAut_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, '1.0', USER,
                'VE_intermediario_PG.VE_ObtieneNumeroCelularAut_PR', LV_sSql, SQLCODE, LV_des_error );
                WHEN no_data_found_cursor THEN
                    SN_cod_retorno:=0;
                    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
               SV_mens_retorno := CV_error_no_clasIF;
            END IF;
            LV_des_error := SUBSTR('no_data_found_cursor:Ve_Serv_Suplem_Abo_Pg.VE_obtiene_SSabo_paracent_PR; - '|| SQLERRM,1,CN_largoerrtec);
            SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
            SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
                        'Ve_Serv_Suplem_Abo_Pg.VE_obtiene_SSabo_paracent_PR', LV_sSql, SN_cod_retorno, LV_des_error );
                WHEN OTHERS THEN
                    SN_cod_retorno:=4;
                    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
               SV_mens_retorno := CV_error_no_clasIF;
            END IF;
            LV_des_error := SUBSTR('OTHERS:Ve_Serv_Suplem_Abo_Pg.VE_obtiene_SSabo_paracent_PR; - '|| SQLERRM,1,CN_largoerrtec);
            SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
            SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
                        'Ve_Serv_Suplem_Abo_Pg.VE_obtiene_SSabo_paracent_PR', LV_sSql, SN_cod_retorno, LV_des_error );
        END VE_obtiene_SSabo_paracent_PR;

        PROCEDURE VE_insServSuplAdicionales_PR(EV_numAbonado   IN VARCHAR2,
                                                                                   EV_cadenaSS     IN VARCHAR2,
                                                                                   EV_numTerminal  IN VARCHAR2,
                                                                                   EV_usuario      IN VARCHAR2,
                                                                                   SV_cadenaSS     OUT NOCOPY VARCHAR2,
                                                                                   SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                                                                   SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                                                                   SN_num_evento   OUT NOCOPY ge_errores_pg.Evento) IS
        /*
        <Documentación TipoDoc = "Procedimiento">
        <Elemento Nombre = "VE_insServSuplAdicionales_PR"
        Lenguaje="PL/SQL"
        Fecha="24-09-2007"
        Versión="1.0.0"
        Diseñador="wjrc"
        Programador="wjrc"
        Ambiente="BD">
        <Retorno>
                          Cadena con Servicios y Niveles
        </Retorno>
        <Descripción>
                                  Inserta servicios suplementarios adicionales del abonado
        </Descripción>
        <Parámetros>
                <Entrada>
                        <param nom="EV_numAbonado"  Tipo="STRING"> numero abonado </param>
                        <param nom="EV_cadenaSS"    Tipo="STRING"> cadena con codigos de serv. supl. </param>
                        <param nom="EV_numTerminal" Tipo="STRING"> numero del terminal </param>
                        <param nom="EV_usuario"     Tipo="STRING"> usuario </param>
                </Entrada>
                <Salida>
                        <param nom="SV_cadenaSS"    Tipo="STRING"> cadena para ser insertada </param>
                        <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                        <param nom="SV_mens_retorno" Tipo="STRING"> glosa mensaje error </param>
                        <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
                </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        */

            CV_NOMBRE_PRODEDURE CONSTANT VARCHAR2(28) := 'VE_insServSuplAdicionales_PR';
                CN_LARGOSUBSTRING   CONSTANT NUMBER  := 3;

                LE_exception_fin EXCEPTION;

                LV_des_error     ge_errores_pg.desevent;
                LV_sql                   ge_errores_pg.vquery;

                LA_arreglo VE_intermediario_PG.tipoArray := VE_intermediario_PG.tipoArray();
                        -- (1) codigo servicio (largo 3)

                LV_fecha          VARCHAR2(17);
                LV_cadena         VARCHAR2(500);
                LV_var1           VARCHAR2(3);
                LV_var2           VARCHAR2(3);
                LV_var3           VARCHAR2(2);
                LV_diasEspeciales VARCHAR2(2);
                LV_numdias        VARCHAR2(5);

                LV_CServicio      VARCHAR2(10);

        LV_CConcepto      VARCHAR2(10);
                LV_string1        VARCHAR2(100);
                LV_string2        VARCHAR2(100);

        LN_CServSupl      NUMBER;
        LN_CNivel         NUMBER;
                LN_indice         NUMBER;

                LB_existeSS       BOOLEAN;
                LV_COUNT          NUMBER;

        BEGIN

                SN_cod_retorno := 0;
        SV_mens_retorno := '';
        SN_num_evento := 0;

                LV_fecha := TO_CHAR(SYSDATE,CV_FORMATO_FECHA_SIS);

                LV_cadena := EV_cadenaSS;

                LA_arreglo := VE_intermediario_PG.VE_descompone_cadena_FN(LV_cadena,
                                                                          CN_LARGOSUBSTRING,
                                                                                                                              SN_cod_retorno,
                                                                                                                              SV_mens_retorno,
                                                                                                                              SN_num_evento);

                        IF (SN_cod_retorno <> 0) THEN
                        RAISE LE_exception_fin;
                END IF;

                -- OBTENEMOS DATOS GENERALES : dias especiales
                VE_ObtieneDatosGenerales_PR(LV_var1
                                            ,LV_var2
                                                                        ,LV_var3
                                                                        ,LV_diasEspeciales
                                                                        ,SN_cod_retorno
                                                                        ,SV_mens_retorno
                                                                        ,SN_num_evento);

                IF (SN_cod_retorno <> 0) THEN
                        RAISE LE_exception_fin;
                END IF;

                SV_cadenaSS := '';

                FOR LN_indice IN 1..LA_arreglo.COUNT LOOP

                        -- CONTROLAMOS TIPO DE DATO
                        BEGIN
                                        LV_CServicio := LA_arreglo(LN_indice);
                                    LV_CServicio := TO_CHAR(Ltrim(TRIM(LV_CServicio),'-'));
                                EXCEPTION
                                                 WHEN OTHERS THEN
                                                          LV_CServicio := LV_CServicio;
                        END;

                        -- VERIFICAMOS SI EXISTE SS PARA EL ABONADO
                        LB_existeSS := VE_ExisteSS_FN(EV_numAbonado,
                                                      LV_CServicio,
                                                                                  LV_fecha,
                                                                                  SN_cod_retorno,
                                                                                  SV_mens_retorno,
                                                                                  SN_num_evento);

                        IF (SN_cod_retorno <> 0) THEN
                                RAISE LE_exception_fin;
                        END IF;

                        IF (NOT LB_existeSS) THEN

                                -- OBTENEMOS numero dias num.
                                LV_numdias := VE_ObtieneNumeroDiasNum_FN(LV_CServicio
                                                                        ,LV_fecha
                                                                                                                ,LV_diasEspeciales
                                                                                                                ,SN_cod_retorno
                                                                                                        ,SV_mens_retorno
                                                                                                                ,SN_num_evento);
                                IF (SN_cod_retorno <> 0) THEN
                                        RAISE LE_exception_fin;
                                END IF;

                                -- OBTENEMOS INFORMACION DEL SS
                                BEGIN
                                                SELECT a.cod_servsupl
                                                          ,a.cod_nivel
                                                          ,b.cod_concepto
                                                INTO LN_CServSupl
                                        ,LN_CNivel
                                    ,LV_CConcepto
                                                FROM ga_servsupl a
                                                    ,ga_actuaserv b
                                                WHERE a.cod_servicio = LV_CServicio
                                                  AND a.cod_producto = CV_CODPRODUCTO
                                                  AND a.cod_producto = b.cod_producto(+)
                                                  AND a.cod_servicio = b.cod_servicio(+)
                                                  AND b.cod_actabo(+) = CV_CODACT_VEN
                                                  AND b.cod_tipserv(+) = CV_TIPSERVICIO_2
                                                  AND ROWNUM < 2;

                                        EXCEPTION
                                                        WHEN NO_DATA_FOUND THEN
                                                                 LN_CServSupl := 0;
                                                 LN_CNivel    := 0;
                                END;


                                SELECT COUNT(1)
                                INTO LV_COUNT
                                FROM GA_SERVSUPLABO
                                WHERE NUM_ABONADO  =EV_numAbonado
                                AND COD_SERVSUPL=LN_CServSupl;

                                IF LV_COUNT >0 THEN
                                   DELETE FROM GA_SERVSUPLABO
                               WHERE NUM_ABONADO  =EV_numAbonado
                                   AND COD_SERVSUPL=LN_CServSupl;
                                END IF;





                                -- * INSERTAMOS SERV. SUPL. DEL ABONADO
                                VE_InsertaSSAbonado_PR( EV_numAbonado
                                                       ,LV_CServicio
                                                       ,LN_CServSupl
                                                       ,LN_CNivel
                                                       ,CV_CODPRODUCTO
                                                       ,EV_numTerminal
                                                       ,LV_CConcepto
                                                       ,CV_INDESTADO_ALTBD
                                                       ,LV_numdias
                                                       ,LV_fecha
                                                                           ,EV_usuario
                                                       ,SN_cod_retorno
                                                                           ,SV_mens_retorno
                                                                           ,SN_num_evento);

                                -- CONCADENAMOS CADENA DE SALIDA
                                LV_string1  := TO_CHAR(LN_CServSupl,'09');
                                LV_string2  := TO_CHAR(LN_CNivel,'0999');
                                SV_cadenaSS := SV_cadenaSS || TRIM(LV_string1) || TRIM(LV_string2);

                        END IF;

                END LOOP;

        EXCEPTION
                WHEN LE_exception_fin THEN
                         VE_intermediario_PG.VE_Others_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,EV_cadenaSS,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                WHEN OTHERS THEN
                         VE_intermediario_PG.VE_Others_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,EV_cadenaSS,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        END VE_insServSuplAdicionales_PR;

        PROCEDURE VE_obtiene_SSabo_nocent_PR(EN_numabonado   IN ga_servsuplabo.num_abonado%TYPE,
                                             EN_indestado    IN ga_servsuplabo.ind_estado%TYPE,
                                                                             EV_codProducto  IN VARCHAR2,
                                                                                 EV_codModulo    IN VARCHAR2,
                                                                                 EV_codSistema   IN VARCHAR2,
                                                                                 EV_codActuacion IN VARCHAR2,
                                                                     SC_cursordatos  OUT NOCOPY REFCURSOR,
                                                                         SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                                         SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                                         SN_num_evento   OUT NOCOPY ge_errores_pg.Evento) IS
                /*--
                <Documentacion TipoDoc = "Procedimiento">
                        Elemento Nombre = "VE_obtiene_SSabo_nocent_PR"
                        Lenguaje="PL/SQL"
                        Fecha="14-10-2007"
                        Version="1.0.0"
                        Dise?ador="Héctor Hermosilla"
                        Programador="Héctor Hermosilla"
                        Ambiente="BD"
                <Retorno>NA</Retorno>
                <Descripcion>
                        Recupera cadena de ss y nivel del abonado informado
                </Descripcion>
                <Parametros>
                <Entrada>
                        <param nom="EN_numabonado"   Tipo="NUMBER> numero de abonado </param>
                        <param nom="EN_indestado"    Tipo="NUMBER> indicador estado</param>
                        <param nom="EV_codProducto"  Tipo="STRING"> codigo producto </param>
                        <param nom="EV_codModulo"    Tipo="STRING"> codigo modulo </param>
                        <param nom="EV_codSistema    Tipo="STRING"> codigo sistema </param>
                        <param nom="EV_codActuacion" Tipo="STRING"> codigo actuacion centrales </param>
                </Entrada>
                <Salida>
                        <param nom="SC_cursordatos"  Tipo="CURSOR"> cursor con nivel y servicio asociado al abonado</param>
                        <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                        <param nom="SV_mens_retorno" Tipo="STRING"> glosa mensaje error </param>
                        <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
                </Salida>
                </Parametros>
                </Elemento>
                </Documentacion>
                --*/
                LE_exception_fin         EXCEPTION;
                no_data_found_cursor EXCEPTION;

                CN_LARGOSUBSTRING    CONSTANT NUMBER  := 6;
                CC_CHAR                  CONSTANT CHAR    := ' ';

                LA_arreglo           VE_intermediario_PG.tipoArray := VE_intermediario_PG.tipoArray();

                LV_des_error         ge_errores_pg.DesEvent;
                LV_sSql              ge_errores_pg.vQuery;

                LN_contador          NUMBER;
                LN_indice            NUMBER;
                LV_ValParametro      VARCHAR2(20);
                LV_cadenaServicio    VARCHAR2(1000);
                LV_condicion         VARCHAR2(1000);
                LC_char1             CHAR;
        BEGIN
                SN_cod_retorno:=0;
                SV_mens_retorno:='';
                SN_num_evento:= 0;

                -- OBTENER TIPO TERMINAL
                Ve_Intermediario_Pg.VE_OBTIENE_VALOR_PARAMETRO_PR(CV_NOMPAR_TIPTERMINALGSM,
                                                                  CV_CODMODULO_AL,
                                                                                                                  EV_codProducto,
                                                                                                                  LV_ValParametro,
                                                                                                                  SN_cod_retorno,
                                                                                                                  SV_mens_retorno,
                                                                                                                  SN_num_evento);
                IF (SN_cod_retorno <> 0) THEN
                        RAISE LE_exception_fin;
                END IF;

                -- BUSCA CADENA DE SERVICIOS POR DEFECTO A CENTRALES
                LV_cadenaServicio := '';
                SELECT a.cod_servicios
                INTO LV_cadenaServicio
                FROM icg_actuaciontercen a
                WHERE a.cod_producto = EV_codProducto
                AND a.tip_terminal = LV_ValParametro
                AND a.cod_sistema = EV_codSistema
                AND a.cod_actuacion = EV_codActuacion;

                IF (LV_cadenaServicio = '' OR LV_cadenaServicio IS NULL) THEN
                        LV_cadenaServicio := '';
                        SELECT cod_servicio
                        INTO LV_cadenaServicio
                        FROM icg_actuacion
                        WHERE cod_actuacion = EV_codActuacion
                        AND cod_producto = EV_codProducto
                        AND cod_modulo = EV_codModulo;
                END IF;

                LA_arreglo := VE_intermediario_PG.VE_descompone_cadena_FN(LV_cadenaServicio,
                                                                          CN_LARGOSUBSTRING,
                                                                                                                      SN_cod_retorno,
                                                                                                                      SV_mens_retorno,
                                                                                                                      SN_num_evento);

                IF (SN_cod_retorno <> 0) THEN
                        RAISE LE_exception_fin;
                END IF;

        LV_condicion := '(';
                FOR LN_indice IN 1..LA_arreglo.COUNT LOOP
            LV_condicion := LV_condicion || '''' || LA_arreglo(LN_indice) || ''',';
                END LOOP;

        LV_condicion := SUBSTR(LV_condicion,1,LENGTH(LV_condicion)-1) || ')';

                IF (SN_cod_retorno <> 0) THEN
                        RAISE LE_exception_fin;
                END IF;

                LN_contador := 0;
                LV_sSql := 'SELECT COUNT(1)';
            LV_sSql := LV_sSql ||' FROM ga_servsuplabo a';
            LV_sSql := LV_sSql ||' WHERE a.num_abonado = '||EN_numabonado;
            LV_sSql := LV_sSql ||' AND a.ind_estado = '|| EN_indestado;
            LV_sSql := LV_sSql ||' AND replace(TO_CHAR(a.cod_servsupl,''09'')||'
                                   || 'TO_CHAR(a.cod_nivel, ''0999''),''' || CC_CHAR || ''','''') '
                                                   || 'IN' || LV_condicion;

        EXECUTE IMMEDIATE LV_sSql INTO LN_contador;

                LV_sSql := 'SELECT replace(TO_CHAR(a.cod_servsupl,''09'')||';
                LV_sSql := LV_sSql ||'TO_CHAR(a.cod_nivel, ''0999''),''' || CC_CHAR || ''','''') ';
            LV_sSql := LV_sSql ||' FROM ga_servsuplabo a';
            LV_sSql := LV_sSql ||' WHERE a.num_abonado = '||EN_numabonado;
            LV_sSql := LV_sSql ||' AND a.ind_estado = '|| EN_indestado;
            LV_sSql := LV_sSql ||' AND replace(TO_CHAR(a.cod_servsupl,''09'')||'
                                   || 'TO_CHAR(a.cod_nivel, ''0999''),''' || CC_CHAR || ''','''') '
                                                   || 'IN' || LV_condicion;

                OPEN SC_cursordatos FOR LV_sSql;

                IF (LN_contador = 0) THEN
                        RAISE no_data_found_cursor;
                END IF;

        EXCEPTION
                WHEN LE_exception_fin THEN
                LV_des_error:='LE_exception_fin: Ve_Serv_Suplem_Abo_Pg.VE_obtiene_SSabo_nocent_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, '1.0', USER,
                'Ve_Serv_Suplem_Abo_Pg.VE_obtiene_SSabo_nocent_PR', LV_sSql, SQLCODE, LV_des_error );
                WHEN no_data_found_cursor THEN
                    SN_cod_retorno:=0;
                    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
               SV_mens_retorno := CV_error_no_clasIF;
            END IF;
            LV_des_error := SUBSTR('no_data_found_cursor:Ve_Serv_Suplem_Abo_Pg.VE_obtiene_SSabo_nocent_PR; - '|| SQLERRM,1,CN_largoerrtec);
            SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
            SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
                        'Ve_Serv_Suplem_Abo_Pg.VE_obtiene_SSabo_nocent_PR', LV_sSql, SN_cod_retorno, LV_des_error );
                WHEN OTHERS THEN
                    SN_cod_retorno:=4;
                    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
               SV_mens_retorno := CV_error_no_clasIF;
            END IF;
            LV_des_error := SUBSTR('OTHERS:Ve_Serv_Suplem_Abo_Pg.VE_obtiene_SSabo_nocent_PR; - '|| SQLERRM,1,CN_largoerrtec);
            SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
            SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
                        'Ve_Serv_Suplem_Abo_Pg.VE_obtiene_SSabo_nocent_PR', LV_sSql, SN_cod_retorno, LV_des_error );
        END VE_obtiene_SSabo_nocent_PR;
        PROCEDURE VE_obtiene_SS_abonadoEV_PR( EV_num_abonado     IN NUMBER,
                                              SC_cursordatos         OUT NOCOPY REFCURSOR,
                                              SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                              SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                              SN_num_evento      OUT NOCOPY ge_errores_pg.Evento) IS

 
           no_data_found_cursor               EXCEPTION;
           LV_des_error ge_errores_pg.DesEvent;
           LV_sSql      ge_errores_pg.vQuery;
           cod_servicio1 ga_servsuplabo.cod_servicio%TYPE;
           cod_servsupl1 VARCHAR2(100);
           cod_nivel1 VARCHAR2(100);
           cod_concepto1 VARCHAR2(100);
           LN_contador NUMBER;
       LV_PLANTARIF GA_ABOCEL.COD_PLANTARIF%TYPE;
        BEGIN
                SN_num_evento:= 0;
                SN_cod_retorno:=0;
                SV_mens_retorno:='';


        SELECT COD_PLANTARIF
        INTO LV_PLANTARIF
        FROM GA_ABOCEL
        WHERE NUM_ABONADO=EV_num_abonado;


        LV_sSql := '   SELECT cod_servicio,cod_servsupl,cod_nivel,cod_concepto';
        LV_sSql := LV_sSql||' FROM ga_servsuplabo';
        LV_sSql := LV_sSql||' WHERE num_abonado = '||EV_num_abonado;
        

                LN_contador := 0;
                SELECT COUNT(1)
                INTO LN_contador
                FROM ga_servsuplabo a
                WHERE a.num_abonado = EV_num_abonado
                AND a.ind_estado IN (CV_ESTADO_1,CV_ESTADO_2)
                AND ROWNUM <= 1;


        OPEN SC_cursordatos FOR

                SELECT a.cod_servicio
                           ,a.cod_servsupl
                           ,a.cod_nivel
                           ,a.cod_concepto
                FROM ga_servsuplabo a
                WHERE a.num_abonado = EV_num_abonado
                AND a.ind_estado IN (CV_ESTADO_1,CV_ESTADO_2);
              
                IF (LN_contador = 0) THEN
                    NULL;
            --es decir no existen SS para cobro en una factura inmediata
                END IF;

        EXCEPTION
                WHEN no_data_found_cursor THEN
                         SN_cod_retorno:=99;
                 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := CV_error_no_clasIF;
                 END IF;
                 LV_des_error := SUBSTR('no_data_found_cursor:Ve_Serv_Suplem_Abo_Pg.VE_obtiene_SS_abonadoEV_PR; - '|| SQLERRM,1,CN_largoerrtec);
                 SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                         SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
                         'Ve_Serv_Suplem_Abo_Pg.VE_obtiene_SS_abonado_PR', LV_sSql, SN_cod_retorno, LV_des_error );
                WHEN OTHERS THEN
                         SN_cod_retorno:=4;
                         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := CV_error_no_clasIF;
                 END IF;
                 LV_des_error := SUBSTR('OTHERS:Ve_Serv_Suplem_Abo_Pg.VE_obtiene_SS_abonadoEV_PR; - '|| SQLERRM,1,CN_largoerrtec);
                 SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                 SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
                         'Ve_Serv_Suplem_Abo_Pg.VE_obtiene_SS_abonadoEV_PR', LV_sSql, SN_cod_retorno, LV_des_error );
        END VE_obtiene_SS_abonadoEV_PR;        
END Ve_Serv_Suplem_Abo_Pg;
/
SHOW ERRORS