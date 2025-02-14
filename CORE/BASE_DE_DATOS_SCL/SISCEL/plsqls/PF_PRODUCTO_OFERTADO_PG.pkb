CREATE OR REPLACE PACKAGE BODY PF_PRODUCTO_OFERTADO_PG
AS

  PROCEDURE PF_PRODUCTO_S_PR(EO_Lista_productos      IN          PF_PROD_OFERT_LISTA_QT,
                          SO_Lista_Productos  OUT NOCOPY    refCursor,
                          SN_cod_retorno      OUT NOCOPY    ge_errores_pg.coderror,
                          SV_mens_retorno     OUT NOCOPY    ge_errores_pg.msgerror,
                          SN_num_evento       OUT NOCOPY    ge_errores_pg.evento)
    IS
    /*
    <Documentación
      TipoDoc = "Procedure">>
       <Elemento
          Nombre = "PF_PRODUCTO_S_PR"
          Lenguaje="PL/SQL"
          Fecha="20-07-2007"
          Versión="La del package"
          Diseñador="Andrés Osorio"
          Programador="Hilda Quezada"
          Ambiente Desarrollo="BD">
          <Retorno>N/A</Retorno>>
          <Descripción></Descripción>>
          <Parámetros>
             <Entrada>
                <param nom="EO_prod_padre" Tipo="estructura">Código de Producto Padre</param>>
             </Entrada>
             <Salida>
                <param nom="SO_Lista_Productos" Tipo="Cursor">Lista de Productos</param>>
                <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
             </Salida>
          </Parámetros>
       </Elemento>
    </Documentación>
    */

    LV_des_error       ge_errores_pg.DesEvent;
    LV_sSql               ge_errores_pg.vQuery;
    v_contador           number(9);
    ERROR_PARAMETROS EXCEPTION;

        BEGIN
            SN_cod_retorno     := 0;
            SV_mens_retorno := ' ';
            SN_num_evento     := 0;

            IF EO_Lista_productos IS NULL THEN
               RAISE ERROR_PARAMETROS;
            ELSE
                LV_sSql := ' SELECT a.COD_PROD_OFERTADO,a. COD_ESPEC_PROD, a.FEC_INICIO_VIGENCIA, ';
                LV_sSql := LV_sSql || ' a.IND_NIVEL_APLICA, a.COD_CATEGORIA, a.IND_PAQUETE, a.FEC_TERMINO_VIGENCIA, ';
                LV_sSql := LV_sSql || ' a.DES_PROD_OFERTADO, a.ID_PROD_OFERTADO, a.PERIODO_CONTRATACION ';
                LV_sSql := LV_sSql || ' a.tipo_plataforma, a.max_contrataciones, a.max_modificaciones ';
                LV_sSql := LV_sSql || ' FROM PF_PRODUCTOS_OFERTADOS_TD a ';
                LV_sSql := LV_sSql || ' WHERE a.COD_PROD_OFERTADO IN (SELECT COD_PROD FROM TABLE(EO_Lista_productos))';

                OPEN SO_Lista_Productos FOR
                SELECT a.COD_PROD_OFERTADO,a. COD_ESPEC_PROD, a.FEC_INICIO_VIGENCIA,
                       a.IND_NIVEL_APLICA, a.COD_CATEGORIA, a.IND_PAQUETE, a.FEC_TERMINO_VIGENCIA,
                       a.DES_PROD_OFERTADO, a.ID_PROD_OFERTADO, a.PERIODO_CONTRATACION,
                       a.tipo_plataforma, a.max_contrataciones, a.max_modificaciones
                FROM PF_PRODUCTOS_OFERTADOS_TD a
                WHERE a.COD_PROD_OFERTADO IN (SELECT COD_PROD FROM TABLE(EO_Lista_productos));

            END IF;

EXCEPTION
   WHEN ERROR_PARAMETROS THEN
          SN_cod_retorno := 98;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_error_no_clasif;
          END IF;
          LV_des_error   := 'PF_PRODUCTO_S_PR(Lista Productos); '||SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_PRODUCTO_OFERTADO_PG.PF_PRODUCTO_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
    WHEN NO_DATA_FOUND THEN
          SN_cod_retorno := 1400;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_error_no_clasif;
          END IF;
          LV_des_error   := 'PF_PRODUCTO_S_PR(Lista Productos); '||SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_PRODUCTO_OFERTADO_PG.PF_PRODUCTO_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
    WHEN OTHERS THEN
          SN_cod_retorno := 156;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_error_no_clasif;
          END IF;
          LV_des_error   := 'PF_PRODUCTO_S_PR(Lista Productos); '||SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_PRODUCTO_OFERTADO_PG.PF_PRODUCTO_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

    END PF_PRODUCTO_S_PR;




     PROCEDURE PF_CATEGORIA_S_PR(EO_Lista_Categoria  IN          PF_PROD_OFERT_LISTA_QT,
                          SO_Lista_Categoria  OUT NOCOPY    refCursor,
                          SN_cod_retorno      OUT NOCOPY    ge_errores_pg.coderror,
                          SV_mens_retorno     OUT NOCOPY    ge_errores_pg.msgerror,
                          SN_num_evento       OUT NOCOPY    ge_errores_pg.evento)
    IS
    /*
    <Documentación
      TipoDoc = "Procedure">>
       <Elemento
          Nombre = "PF_PRODUCTO_S_PR"
          Lenguaje="PL/SQL"
          Fecha="20-07-2007"
          Versión="La del package"
          Diseñador="Andrés Osorio"
          Programador="Hilda Quezada"
          Ambiente Desarrollo="BD">
          <Retorno>N/A</Retorno>>
          <Descripción></Descripción>>
          <Parámetros>
             <Entrada>
                <param nom="EO_prod_padre" Tipo="estructura">Código de Producto Padre</param>>
             </Entrada>
             <Salida>
                <param nom="SO_Lista_Productos" Tipo="Cursor">Lista de Productos</param>>
                <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
             </Salida>
          </Parámetros>
       </Elemento>
    </Documentación>
    */

    LV_des_error       ge_errores_pg.DesEvent;
    LV_sSql               ge_errores_pg.vQuery;
    v_contador           number(9);

        BEGIN
            SN_cod_retorno     := 0;
            SV_mens_retorno := ' ';
            SN_num_evento     := 0;

            IF EO_Lista_Categoria IS NULL THEN
               SN_cod_retorno     := CN_LISTA_NULA;
               SV_mens_retorno  := 'Lista de Categoria es nula';
            ELSE
                LV_sSql := ' SELECT a.cod_categoria, A.COD_PROD_OFERTADO, A.IND_NIVEL_APLICA, ';
                LV_sSql := LV_sSql || ' a.ind_paquete, a.des_prod_ofertado ';
                LV_sSql := LV_sSql || ' FROM PF_PRODUCTOS_OFERTADOS_TD a ';
                LV_sSql := LV_sSql || ' WHERE a.cod_categoria IN (SELECT cod_categoria FROM TABLE(EO_Lista_Categoria))';

                OPEN SO_Lista_Categoria FOR
                SELECT a.cod_categoria, A.COD_PROD_OFERTADO, A.IND_NIVEL_APLICA,
                       a.ind_paquete, a.des_prod_ofertado
                FROM PF_PRODUCTOS_OFERTADOS_TD a
                WHERE a.cod_categoria IN (SELECT cod_categoria FROM TABLE(EO_Lista_Categoria));

            END IF;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
          SN_cod_retorno := 149;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_error_no_clasif;
          END IF;
          LV_des_error   := 'PF_CATEGORIA_S_PR(Lista Categorias); '||SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_PRODUCTO_OFERTADO_PG.PF_CATEGORIA_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
    WHEN OTHERS THEN
          SN_cod_retorno := 156;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_error_no_clasif;
          END IF;
          LV_des_error   := 'PF_CATEGORIA_S_PR(Lista Categorias); '||SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_PRODUCTO_OFERTADO_PG.PF_CATEGORIA_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

    END PF_CATEGORIA_S_PR;

    PROCEDURE PF_PA_OBLIGATORIO_PT_PR(EV_COD_PLANTARIF        IN  ta_plantarif.cod_plantarif%type,
                                      EV_COD_CANAL            IN  pf_catalogo_ofertado_td.cod_canal%type,
                                      EV_NIVEL                IN  pf_productos_ofertados_td.ind_nivel_aplica%type,
                                      EV_COD_PRESTACION       IN  ps_especprod_prestacion_td.cod_prestacion%type,
                                      SO_Lista_Producto       OUT NOCOPY    refCursor,
                                      SN_cod_retorno          OUT NOCOPY  ge_errores_pg.coderror,
                                      SV_mens_retorno         OUT NOCOPY  ge_errores_pg.msgerror,
                                      SN_num_evento           OUT NOCOPY    ge_errores_pg.evento)



    IS
    /*
    <Documentación
      TipoDoc = "Procedure">>
       <Elemento
          Nombre = "PF_PA_OBLIGATORIO_PT_PR"
          Lenguaje="PL/SQL"
          Fecha="16-11-2010"
          Versión="La del package"
          Diseñador="Jacqueline Mendez Ortega INC-155400"
          Programador="Jacqueline Mendez Ortega
          Ambiente Desarrollo="BD">
          <Retorno>N/A</Retorno>>
          <Descripción>Obtiene todos los planes opcionales obligatorios configurados al Plan Tarifario</Descripción>>
          <Parámetros>
             <Entrada>
                <param nom="EV_COD_PLANTARIF"        Tipo="CARACTER"> Código de Plan Tarifario  </param>
                <param nom="EV_COD_CANAL"            Tipo="CARACTER"> Código de canal           </param>
                <param nom="EV_NIVEL"                Tipo="CARACTER"> Ind Nivel Aplica          </param>
                <param nom="EV_COD_PRESTACION"       Tipo="CARACTER"> Código de la prestacion   </param>
             </Entrada>
             <Salida>
                <param nom="SO_Lista_Producto"       Tipo="Cursor">  Lista de Productos filtrada</param>
                <param nom="SN_cod_retorno"          Tipo="NUMERICO">Codigo de Retorno          </param>
                <param nom="SV_mens_retorno"         Tipo="CARACTER">Mensaje de Retorno         </param>
                <param nom="SN_num_evento"           Tipo="NUMERICO">Numero de Evento           </param>
             </Salida>
          </Parámetros>
       </Elemento>
    </Documentación>
    */

    LV_des_error       ge_errores_pg.DesEvent;
    LV_sSql               ge_errores_pg.vQuery;
    LV_cod_tiplan       ta_plantarif.cod_tiplan%type;

    BEGIN

            SN_cod_retorno     := 0;
            SV_mens_retorno := ' ';
            SN_num_evento     := 0;

            -- Obtener tipo de plan plantifario(1: prepago, 2:postpago, 3:hibrido)
            LV_sSQL := 'SELECT COD_TIPLAN FROM TA_PLANTARIF WHERE COD_PLANTARIF ='||EV_COD_PLANTARIF;

            SELECT COD_TIPLAN INTO LV_cod_tiplan
            FROM TA_PLANTARIF
            WHERE COD_PLANTARIF = EV_COD_PLANTARIF;

            LV_sSql:=  'SELECT DISTINCT a.cod_prod_ofertado, 1 '
                    || ' FROM pf_catalogo_ofertado_td a, '
                    || ' pf_productos_ofertados_td b, '
                    || ' ps_especprod_prestacion_td c, '
                    || ' ps_especificaciones_prod_td d, '
                    || ' ps_plantarif_planadic_td e '
                    || ' WHERE a.cod_prod_ofertado = b.cod_prod_ofertado '
                    || ' AND a.cod_canal = ''' || EV_COD_CANAL ||''' '
                    || ' AND SYSDATE >= a.fec_inicio_vigencia '
                    || ' AND a.fec_termino_vigencia >= TRUNC (SYSDATE) '
                    || ' AND a.cod_concepto > 0 '
                    || ' AND b.ind_nivel_aplica = ''' || EV_NIVEL || ''' '
                    || ' AND b.tipo_plataforma = ''' || LV_cod_tiplan || ''' '
                    || ' AND b.cod_espec_prod = c.cod_espec_prod '
                    || ' AND c.cod_prestacion = ''' || EV_COD_PRESTACION || ''' '
                    || ' AND b.cod_espec_prod = d.cod_espec_prod '
                    || ' AND e.cod_plantarif = '''|| EV_COD_PLANTARIF ||''' '
                    || ' AND SYSDATE BETWEEN e.fec_inicio_vigencia AND NVL (e.fec_termino_vigencia,SYSDATE) '
                    || ' AND b.cod_prod_ofertado = e.cod_prod_ofertado '
                    || ' AND e.tipo_relacion_pa = '||CN_pa_obligatorio||' '
                    || ' ORDER BY a.cod_prod_ofertado';

            OPEN SO_Lista_Producto FOR LV_sSql;


    EXCEPTION
    WHEN NO_DATA_FOUND THEN
          SN_cod_retorno := 0;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_error_no_clasif;
          END IF;
          LV_des_error   := 'PF_PA_OBLIGATORIO_PT_PR; '||SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_PRODUCTO_OFERTADO_PG.PF_PA_OBLIGATORIO_PT_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
    WHEN OTHERS THEN
          SN_cod_retorno := 156;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_error_no_clasif;
          END IF;
          LV_des_error   := 'PF_PA_OBLIGATORIO_PT_PR; '||SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_PRODUCTO_OFERTADO_PG.PF_PA_OBLIGATORIO_PT_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

    END PF_PA_OBLIGATORIO_PT_PR;

     PROCEDURE PF_PRODUCTO_FILTRADO_S_PR(EV_COD_PLANTARIF  IN      ta_plantarif.cod_plantarif%type,
                                         EV_COD_CANAL      IN      pf_catalogo_ofertado_td.cod_canal%type,
                                         EV_NIVEL          IN      pf_productos_ofertados_td.ind_nivel_aplica%type,
                                         EV_COD_PRESTACION  IN     ps_especprod_prestacion_td.cod_prestacion%type,
                                         EV_TIPOS_COMPORTAMIENTO  IN     VARCHAR2,
                                         SO_Lista_Producto  OUT NOCOPY    refCursor,
                                         SN_cod_retorno     OUT NOCOPY  ge_errores_pg.coderror,
                                         SV_mens_retorno    OUT NOCOPY  ge_errores_pg.msgerror,
                                         SN_num_evento      OUT NOCOPY    ge_errores_pg.evento)



    IS
    /*
    <Documentación
      TipoDoc = "Procedure">>
       <Elemento
          Nombre = "PF_PRODUCTO_FILTRADO_S_PR"
          Lenguaje="PL/SQL"
          Fecha="21-06-2010"
          Versión="La del package"
          Diseñador="Elizabeth Vera"
          Programador="Elizabeth Vera"
          Ambiente Desarrollo="BD">
          <Retorno>N/A</Retorno>>
          <Descripción></Descripción>>
          <Parámetros>
             <Entrada>
                <param nom="EV_COD_PLANTARIF" Tipo="CARACTER">Código de Plan Tarifario</param>>
                <param nom="EV_COD_CANAL" Tipo="CARACTER">Código de canal/param>>
                <param nom="EV_NIVEL" Tipo="CARACTER">Ind Nivel Aplica</param>>
                <param nom="EV_COD_PRESTACION" Tipo="CARACTER">Código de la prestacion</param>>
                <param nom="EV_TIPOS_COMPORTAMIENTO" Tipo="CARACTER">Cadena con tipos de comportamiento</param>>
             </Entrada>
             <Salida>
                <param nom="SO_Lista_Producto" Tipo="Cursor">Lista de Productos filtrada</param>>
                <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
             </Salida>
          </Parámetros>
       </Elemento>
    </Documentación>
    */

    LV_des_error       ge_errores_pg.DesEvent;
    LV_sSql               ge_errores_pg.vQuery;
    V_COD_TIPLAN       ta_plantarif.cod_tiplan%type;
    V_CADENA           VARCHAR2(200);

        BEGIN
            SN_cod_retorno     := 0;
            SV_mens_retorno := ' ';
            SN_num_evento     := 0;

            -- Obtener tipo de plan plantifario(1: prepago, 2:postpago, 3:hibrido)

            LV_sSQL := 'SELECT COD_TIPLAN FROM TA_PLANTARIF WHERE COD_PLANTARIF ='||EV_COD_PLANTARIF;

            SELECT COD_TIPLAN INTO V_COD_TIPLAN
            FROM TA_PLANTARIF
            WHERE COD_PLANTARIF = EV_COD_PLANTARIF;

            -- Obtener productos por prestacion y categoria
            V_CADENA := replace(EV_TIPOS_COMPORTAMIENTO, ',', ''',''');

            --**inicio INC-155400 JMO/05-11-2010
            --** Se agrega filtro para obtener todos los PA adicionales opcionales segun comportamiento
            --** y todos los PA adicionales opcionales obligatorios, al Plan tarifario

            /*LV_sSql := 'SELECT distinct A.COD_PROD_OFERTADO, B.ID_PROD_OFERTADO, b.COD_CATEGORIA, ';
            LV_sSql := LV_sSql || ' b.DES_PROD_OFERTADO, d.TIPO_COMPORTAMIENTO, b.MAX_CONTRATACIONES ';
            LV_sSql := LV_sSql || ' FROM   PF_CATALOGO_OFERTADO_TD a, PF_PRODUCTOS_OFERTADOS_TD b, ';
            LV_sSql := LV_sSql || ' PS_ESPECPROD_PRESTACION_TD c, PS_ESPECIFICACIONES_PROD_TD d ';
            LV_sSql := LV_sSql || ' WHERE  a.COD_CANAL = ''' || EV_COD_CANAL ||'''';
            LV_sSql := LV_sSql || ' AND    sysdate >= A.FEC_INICIO_VIGENCIA ';
            LV_sSql := LV_sSql || ' AND    A.FEC_TERMINO_VIGENCIA >=  trunc(sysdate) ';
            LV_sSql := LV_sSql || ' AND    B.IND_NIVEL_APLICA = ''' || EV_NIVEL || '''';
            LV_sSql := LV_sSql || ' AND    B.TIPO_PLATAFORMA = ''' || V_COD_TIPLAN || '''';
            LV_sSql := LV_sSql || ' AND    a.COD_PROD_OFERTADO = b.COD_PROD_OFERTADO ';
            LV_sSql := LV_sSql || ' AND    b.COD_ESPEC_PROD = c.COD_ESPEC_PROD ';
            LV_sSql := LV_sSql || ' AND    c.COD_PRESTACION = ''' || EV_COD_PRESTACION || '''';
            LV_sSql := LV_sSql || ' AND    b.COD_ESPEC_PROD = d.COD_ESPEC_PROD ';
            LV_sSql := LV_sSql || ' AND     d.TIPO_COMPORTAMIENTO IN (''' || V_CADENA || ''')';
            LV_sSql := LV_sSql || ' AND b.COD_CATEGORIA IN (SELECT A.COD_CATEGORIA ';
            LV_sSql := LV_sSql || '     FROM   PS_CATEGORIAS_CARGO_TD A, TA_PLANTARIF B, TA_CARGOSBASICO C ';
            LV_sSql := LV_sSql || '     WHERE  B.COD_CARGOBASICO = C.COD_CARGOBASICO ';
            LV_sSql := LV_sSql || '     AND    B.COD_PLANTARIF = ''' || EV_COD_PLANTARIF ||'''';
            LV_sSql := LV_sSql || '     AND    A.MIN_CARGO_REQUERIDO <=  C.IMP_CARGOBASICO )';
            LV_sSql := LV_sSql || ' ORDER BY d.TIPO_COMPORTAMIENTO, b.ID_PROD_OFERTADO, b.DES_PROD_OFERTADO';*/

            LV_sSql:=  'SELECT cod_prod_ofertado, id_prod_ofertado, cod_categoria, '
                        || ' des_prod_ofertado, tipo_comportamiento, max_contrataciones, tipo_relacion_pa, '
                        || ' cod_moneda, ' --P-CSR-11002 JLGN 26.10.2011
                        || ' monto_importe ' --P-CSR-11002 JLGN 01-07-2011                        
                        || ' FROM (SELECT DISTINCT a.cod_prod_ofertado, b.id_prod_ofertado, '
                        || ' b.cod_categoria, b.des_prod_ofertado, '
                        || ' d.tipo_comportamiento, b.max_contrataciones, '
                        || ' e.tipo_relacion_pa, '
                        || ' g.cod_moneda, ' -- P-CSR-11002 JLGN 26.10.2011
                        || ' f.monto_importe '--P-CSR-11002 JLGN 01-07-2011
                        || ' FROM pf_catalogo_ofertado_td a, '
                        || ' pf_productos_ofertados_td b, '
                        || ' ps_especprod_prestacion_td c, '
                        || ' ps_especificaciones_prod_td d, '
                        || ' ps_plantarif_planadic_td e, '
                        || ' pf_cargos_productos_td f, '--P-CSR 11002 JLGN 01-07-2011
                        || ' ge_monedas g '-- P-CSR-11002 JLGN 26.10.2011
                        || ' WHERE a.cod_prod_ofertado = b.cod_prod_ofertado '
                        || ' AND a.cod_canal = ''' || EV_COD_CANAL ||''' '
                        || ' AND SYSDATE >= a.fec_inicio_vigencia '
                        || ' AND a.fec_termino_vigencia >= TRUNC (SYSDATE) '
                        || ' AND a.cod_concepto > 0 '
                        || ' AND b.ind_nivel_aplica = ''' || EV_NIVEL || ''' '
                        || ' AND b.tipo_plataforma = ''' || V_COD_TIPLAN || ''' '
                        || ' AND b.cod_espec_prod = c.cod_espec_prod '
                        || ' AND c.cod_prestacion = ''' || EV_COD_PRESTACION || ''' '
                        || ' AND b.cod_espec_prod = d.cod_espec_prod '
                        || ' AND d.tipo_comportamiento IN (''' || V_CADENA || ''') '
                        || ' AND e.cod_plantarif = '''|| EV_COD_PLANTARIF ||''' '
                        || ' AND SYSDATE BETWEEN e.fec_inicio_vigencia AND NVL (e.fec_termino_vigencia, SYSDATE) '
                        || ' AND b.cod_prod_ofertado = e.cod_prod_ofertado '
                        || ' AND e.tipo_relacion_pa = '||CN_pa_opcional||' '
                        || ' AND a.cod_cargo = f.cod_cargo '--P-CSR-11002 JLGN 01-07-2011
                        || ' AND f.cod_moneda = g.cod_moneda '-- P-CSR-11002 JLGN 26.10.2011
                        || ' UNION '
                        || ' SELECT DISTINCT a.cod_prod_ofertado, b.id_prod_ofertado, '
                        || ' b.cod_categoria, b.des_prod_ofertado, '
                        || ' d.tipo_comportamiento, b.max_contrataciones, e.tipo_relacion_pa, '
                        || ' g.cod_moneda, ' -- P-CSR-11002 JLGN 26.10.2011
                        || ' f.monto_importe '--P-CSR-11002 JLGN 01-07-2011
                        || ' FROM pf_catalogo_ofertado_td a, '
                        || ' pf_productos_ofertados_td b, '
                        || ' ps_especprod_prestacion_td c, '
                        || ' ps_especificaciones_prod_td d, '
                        || ' ps_plantarif_planadic_td e, '
                        || ' pf_cargos_productos_td f, '--P-CSR-11002 JLGN 01-07-2011
                        || ' ge_monedas g '-- P-CSR-11002 JLGN 26.10.2011
                        || ' WHERE a.cod_prod_ofertado = b.cod_prod_ofertado '
                        || ' AND a.cod_canal = ''' || EV_COD_CANAL ||''' '
                        || ' AND SYSDATE >= a.fec_inicio_vigencia '
                        || ' AND a.fec_termino_vigencia >= TRUNC (SYSDATE) '
                        || ' AND a.cod_concepto > 0 '
                        || ' AND b.ind_nivel_aplica = ''' || EV_NIVEL || ''' '
                        || ' AND b.tipo_plataforma = ''' || V_COD_TIPLAN || ''' '
                        || ' AND b.cod_espec_prod = c.cod_espec_prod '
                        || ' AND c.cod_prestacion = ''' || EV_COD_PRESTACION || ''' '
                        || ' AND b.cod_espec_prod = d.cod_espec_prod '
                        || ' AND e.cod_plantarif = '''|| EV_COD_PLANTARIF ||''' '
                        || ' AND SYSDATE BETWEEN e.fec_inicio_vigencia AND NVL (e.fec_termino_vigencia,SYSDATE) '
                        || ' AND b.cod_prod_ofertado = e.cod_prod_ofertado '
                        || ' AND e.tipo_relacion_pa = '||CN_pa_obligatorio||' '
                        || ' AND a.cod_cargo = f.cod_cargo '--P-CSR-11002 JLGN 01-07-2011
                        || ' AND f.cod_moneda = g.cod_moneda) '-- P-CSR-11002 JLGN 26.10.2011
                        || ' ORDER BY tipo_comportamiento, id_prod_ofertado, des_prod_ofertado ';

            --**fin INC-155400 JMO/05-11-2010

            OPEN SO_Lista_Producto FOR LV_sSql;


EXCEPTION
    WHEN NO_DATA_FOUND THEN
          SN_cod_retorno := 0;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_error_no_clasif;
          END IF;
          LV_des_error   := 'PF_PRODUCTO_FILTRADO_S_PR; '||SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_PRODUCTO_OFERTADO_PG.PF_PRODUCTO_FILTRADO_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
    WHEN OTHERS THEN
          SN_cod_retorno := 156;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_error_no_clasif;
          END IF;
          LV_des_error   := 'PF_PRODUCTO_FILTRADO_S_PR; '||SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_PRODUCTO_OFERTADO_PG.PF_PRODUCTO_FILTRADO_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

    END PF_PRODUCTO_FILTRADO_S_PR;


    PROCEDURE PF_PRODUCTO_SCORING_S_PR(EN_NUM_ABONADO  IN   ga_abocel.num_abonado%type,
                                         SO_Lista_Producto  OUT NOCOPY    refCursor,
                                         SN_cod_retorno     OUT NOCOPY  ge_errores_pg.coderror,
                                         SV_mens_retorno    OUT NOCOPY  ge_errores_pg.msgerror,
                                         SN_num_evento      OUT NOCOPY    ge_errores_pg.evento)
    IS
    /*
    <Documentación
      TipoDoc = "Procedure">>
       <Elemento
          Nombre = "PF_PRODUCTO_SCORING_S_PR
          Lenguaje="PL/SQL"
          Fecha="30-08-2010"
          Versión="La del package"
          Diseñador="Elizabeth Vera"
          Programador="Elizabeth Vera"
          Ambiente Desarrollo="BD">
          <Retorno>N/A</Retorno>>
          <Descripción></Descripción>>
          <Parámetros>
             <Entrada>
                <param nom="EN_NUM_ABONADO" Tipo="NUMERICO">Numero de abonado</param>>
             </Entrada>
             <Salida>
                <param nom="SO_Lista_Producto" Tipo="Cursor">Lista de productos pre evaluados</param>>
                <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
             </Salida>
          </Parámetros>
       </Elemento>
    </Documentación>
    */

    LV_des_error       ge_errores_pg.DesEvent;
    LV_sSql               ge_errores_pg.vQuery;

    BEGIN
            SN_cod_retorno     := 0;
            SV_mens_retorno := ' ';
            SN_num_evento     := 0;

            OPEN SO_Lista_Producto FOR
                SELECT DISTINCT C.COD_PROD_OFERTADO, C.ID_PROD_OFERTADO, C.DES_PROD_OFERTADO, B.CANTIDAD
                FROM EV_PRESTSOLIC_SCORING_TO A, EV_PA_SCORING_TO B, PF_PRODUCTOS_OFERTADOS_TD C
                WHERE A.NUM_SOLSCORING = B.NUM_SOLSCORING
                AND A.NUM_LINEASCORING = B.NUM_LINEASSCORING
                AND A.NUM_ABONADO =  EN_NUM_ABONADO
                AND B.COD_PROD_OFERTADO = C.COD_PROD_OFERTADO
                ORDER BY C.ID_PROD_OFERTADO, C.DES_PROD_OFERTADO;

    EXCEPTION
    WHEN NO_DATA_FOUND THEN
          NULL;

    WHEN OTHERS THEN
          SN_cod_retorno := 156;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_error_no_clasif;
          END IF;
          LV_des_error   := 'PF_PRODUCTO_SCORING_S_PR; '||SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_PRODUCTO_OFERTADO_PG.PF_PRODUCTO_FILTRADO_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

    END PF_PRODUCTO_SCORING_S_PR;


END PF_PRODUCTO_OFERTADO_PG;
/
