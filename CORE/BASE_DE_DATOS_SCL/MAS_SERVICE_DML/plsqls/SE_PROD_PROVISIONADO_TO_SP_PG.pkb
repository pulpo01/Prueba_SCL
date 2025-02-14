CREATE OR REPLACE PACKAGE BODY SE_PROD_PROVISIONADO_TO_SP_PG AS

PROCEDURE SE_PROD_OFER_PR ( EN_NUM_ABONADO IN icc_movimiento.num_abonado%TYPE,
                            EN_COD_PROD_CONTRATADO IN icc_movimiento.cod_prod_contratado%TYPE,
                            SN_COD_PROD_OFER  OUT pr_productos_contratados_to.cod_prod_ofertado%TYPE,
                            SV_DES_PROD_OFER  OUT pf_productos_ofertados_td.des_prod_ofertado%TYPE,
                            SN_COD_RETORNO  OUT NOCOPY  ge_errores_pg.CodError,
                            SV_MENS_RETORNO OUT NOCOPY  ge_errores_pg.MsgError,
                            SN_NUM_EVENTO   OUT NOCOPY  ge_errores_pg.evento )                           
/*
<Documentación
   TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "SE_PROD_OFER_PR"
      Lenguaje="PL/SQL"
      Fecha creación="11-05-2010"
      Creado por="Carlos Sellao H."
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>n/a</Retorno>
      <Descripción>Rescata el producto ofertado que representa al PA.</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_NUM_ABONADO"         Tipo="NUMERICO"> Numero de Abonado </param>
            <param nom="EN_COD_PROD_CONTRATADO"         Tipo="NUMERICO"> Codigo de producto contratado </param>
         </Entrada>
         <Salida>
            <param nom="SN_COD_PROD_OFER"       Tipo="NUMERICO">Codigo de producto ofertado</param>
            <param nom="SV_DES_PROD_OFER"       Tipo="CARACTER">Descripcion de producto ofertado</param>
            <param nom="SN_COD_RETORNO"       Tipo="NUMERICO">Codigo de retorno o Error</param>
            <param nom="SV_MENS_RETORNO"       Tipo="CARACTER">Mensaje de retorno</param>
            <param nom="SN_NUM_EVENTO"      Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
LV_des_error    ge_errores_pg.DesEvent;
LV_Sql VARCHAR2(1000);
LN_cod_prod_ofertado pr_productos_contratados_to.cod_prod_ofertado%TYPE;
LV_des_prod_ofertado pf_productos_ofertados_td.des_prod_ofertado%TYPE;

BEGIN
sn_cod_retorno := 0;
sv_mens_retorno := NULL;
sn_num_evento := 0;

    -- Lee el producto ofertado que representa al PA.-        
    LV_Sql := 'SELECT b.cod_prod_ofertado, b.des_prod_ofertado';
    LV_Sql := LV_Sql||' INTO LN_cod_prod_ofertado, LV_des_prod_ofertado';
    LV_Sql := LV_Sql||' FROM pr_productos_contratados_to  a, pf_productos_ofertados_td b';
    LV_Sql := LV_Sql||' WHERE a.cod_prod_contratado = '||EN_cod_prod_contratado;
    LV_Sql := LV_Sql||' AND a.num_abonado_beneficiario = '||EN_num_abonado;
    LV_Sql := LV_Sql||' AND a.cod_prod_ofertado = b.cod_prod_ofertado;';

    SELECT b.cod_prod_ofertado, b.des_prod_ofertado
    INTO  LN_cod_prod_ofertado, LV_des_prod_ofertado
    FROM pr_productos_contratados_to a, pf_productos_ofertados_td b 
    WHERE a.cod_prod_contratado = EN_cod_prod_contratado 
    AND a.num_abonado_beneficiario = EN_num_abonado
    AND a.cod_prod_ofertado = b.cod_prod_ofertado;

    SN_cod_prod_ofer := LN_cod_prod_ofertado;
    SV_des_prod_ofer := LV_des_prod_ofertado;

EXCEPTION
    WHEN OTHERS THEN
        SN_cod_retorno := CN_Err_Usuario;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(sn_cod_retorno,sv_mens_retorno) THEN
               sv_mens_retorno := CV_error_no_clasif;
        END IF;
        LV_des_error   := ' SE_PROD_PROVISIONADO_TO_SP_PG.SE_GRABA_PA_PR('||EN_NUM_ABONADO||','||EN_COD_PROD_CONTRATADO||');['||SQLERRM||']';
        sn_num_evento  := Ge_Errores_Pg.Grabarpl( sn_num_evento, CV_cod_modulo, sv_mens_retorno, CV_version, USER, 'SE_PROD_PROVISIONADO_TO_SP_PG.SE_GRABA_PA_PR', LV_Sql, sn_cod_retorno, LV_des_error );
END SE_PROD_OFER_PR;

PROCEDURE SE_GRABA_PA_PR ( EN_NUM_ABONADO IN icc_movimiento.num_abonado%TYPE,
                           EN_COD_PROD_CONTRATADO IN icc_movimiento.cod_prod_contratado%TYPE,
                           EN_COD_ESPEC_PROV IN se_espec_provisionamiento_td.cod_espec_prov%TYPE,
                           SN_COD_RETORNO  OUT NOCOPY  ge_errores_pg.CodError,
                           SV_MENS_RETORNO OUT NOCOPY  ge_errores_pg.MsgError,
                           SN_NUM_EVENTO   OUT NOCOPY  ge_errores_pg.evento )                           
/*
<Documentación
   TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "SE_GRABA_PA_PR"
      Lenguaje="PL/SQL"
      Fecha creación="05-05-2010"
      Creado por="Carlos Sellao H."
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>n/a</Retorno>
      <Descripción>Inserta Datos en tabla SE_PROD_PROVISIONADO_TO </Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_NUM_ABONADO"         Tipo="NUMERICO"> Numero de Abonado </param>
            <param nom="EN_COD_PROD_CONTRATADO"         Tipo="NUMERICO"> Codigo de producto contratado </param>
            <param nom="EN_COD_ESPEC_PROV"         Tipo="NUMERICO"> Codigo de especificacion de aprovisionamiento </param>
         </Entrada>
         <Salida>
            <param nom="SN_COD_RETORNO"       Tipo="NUMERICO">Codigo de retorno o Error</param>
            <param nom="SV_MENS_RETORNO"       Tipo="CARACTER">Mensaje de retorno</param>
            <param nom="SN_NUM_EVENTO"      Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
LV_des_error    ge_errores_pg.DesEvent;
LV_Sql VARCHAR2(1000);
fec_ingreso date := SYSDATE;
LN_cant_pa  number := 0;
LN_cod_prod_ofertado pr_productos_contratados_to.cod_prod_ofertado%TYPE;
LV_des_prod_ofertado pf_productos_ofertados_td.des_prod_ofertado%TYPE;
error_controlado  exception;

BEGIN
sn_cod_retorno := 0;
sv_mens_retorno := NULL;
sn_num_evento := 0;

    -- Lee el producto ofertado que representa al PA.-        
    LV_Sql := 'SE_PROD_OFER_PR( '||EN_num_abonado||','||EN_cod_prod_contratado||' )';
    SE_PROD_OFER_PR ( EN_num_abonado,EN_cod_prod_contratado,LN_cod_prod_ofertado,LV_des_prod_ofertado,SN_cod_retorno,SV_mens_retorno,SN_num_evento );

    IF SN_cod_retorno != 0 THEN
       RAISE error_controlado;
    END IF;

    LV_Sql := ' SELECT count(1)';
    LV_Sql := LV_Sql ||' INTO LN_cant_pa';
    LV_Sql := LV_Sql ||' FROM SE_PROD_PROVISIONADO_TO';
    LV_Sql := LV_Sql ||' WHERE num_abonado = '||EN_num_abonado;
    LV_Sql := LV_Sql ||' AND cod_prod_ofertado = '||LN_cod_prod_ofertado;
    LV_Sql := LV_Sql ||' AND cod_prod_contratado = '||EN_cod_prod_contratado;

    SELECT count(1)
    INTO LN_cant_pa
    FROM SE_PROD_PROVISIONADO_TO
    WHERE num_abonado = EN_num_abonado
    AND cod_prod_ofertado = LN_cod_prod_ofertado
    AND cod_prod_contratado = EN_cod_prod_contratado;

    IF LN_cant_pa = 0 THEN
    
        --Graba registro de tabla de productos aprovisionados.-
        LV_Sql := ' INSERT INTO SE_PROD_PROVISIONADO_TO';
        LV_Sql := LV_Sql ||' (';
        LV_Sql := LV_Sql ||' NUM_ABONADO,';
        LV_Sql := LV_Sql ||' COD_PROD_OFERTADO,';
        LV_Sql := LV_Sql ||' DES_PROD_OFERTADO,';
        LV_Sql := LV_Sql ||' COD_PROD_CONTRATADO,';
        LV_Sql := LV_Sql ||' COD_ESPEC_PROV';
        LV_Sql := LV_Sql ||' NIVEL_CAPA';
        LV_Sql := LV_Sql ||' ESTADO';
        LV_Sql := LV_Sql ||' FECHA';
        LV_Sql := LV_Sql ||' )';
        LV_Sql := LV_Sql ||' VALUES';
        LV_Sql := LV_Sql ||' (';
        LV_Sql := LV_Sql ||' '|| EN_NUM_ABONADO;
        LV_Sql := LV_Sql ||', '|| LN_cod_prod_ofertado;
        LV_Sql := LV_Sql ||', '|| LV_des_prod_ofertado;
        LV_Sql := LV_Sql ||', '|| EN_COD_PROD_CONTRATADO;
        LV_Sql := LV_Sql ||', '|| EN_COD_ESPEC_PROV;
        LV_Sql := LV_Sql ||', 0';
        LV_Sql := LV_Sql ||', ''P''';
        LV_Sql := LV_Sql ||', '|| fec_ingreso;
        LV_Sql := LV_Sql ||' )';


        INSERT INTO SE_PROD_PROVISIONADO_TO
        (
            NUM_ABONADO,
            COD_PROD_OFERTADO,
            DES_PROD_OFERTADO,
            COD_PROD_CONTRATADO,
            COD_ESPEC_PROV,
            NIVEL_CAPA,
            ESTADO,
            FECHA
        )
        VALUES
        (
            EN_NUM_ABONADO,
            LN_cod_prod_ofertado,
            LV_des_prod_ofertado,
            EN_COD_PROD_CONTRATADO,
            EN_COD_ESPEC_PROV,
            0,                 -- Nivel inicial. solo para ingreso de PA.-
            'P',               -- Estado Pendiente. En paso a historico cambia a 'A' activo.
            fec_ingreso
        );
    
    END IF;    
    
EXCEPTION
    WHEN error_controlado THEN
        SN_cod_retorno := CN_Err_Usuario;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(sn_cod_retorno,sv_mens_retorno) THEN
               sv_mens_retorno := CV_error_no_clasif;
        END IF;
        LV_des_error   := ' SE_PROD_PROVISIONADO_TO_SP_PG.SE_GRABA_PA_PR('||EN_NUM_ABONADO||','||EN_COD_PROD_CONTRATADO||','||EN_COD_ESPEC_PROV ||');['||SQLERRM||']';
        sn_num_evento  := Ge_Errores_Pg.Grabarpl( sn_num_evento, CV_cod_modulo, sv_mens_retorno, CV_version, USER, 'SE_PROD_PROVISIONADO_TO_SP_PG.SE_GRABA_PA_PR', LV_Sql, sn_cod_retorno, LV_des_error );

    WHEN OTHERS THEN
        SN_cod_retorno := CN_Err_Cli;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(sn_cod_retorno,sv_mens_retorno) THEN
               sv_mens_retorno := CV_error_no_clasif;
        END IF;
        LV_des_error   := ' SE_PROD_PROVISIONADO_TO_SP_PG.SE_GRABA_PA_PR('||EN_NUM_ABONADO||','||EN_COD_PROD_CONTRATADO||','||EN_COD_ESPEC_PROV ||');['||SQLERRM||']';
        sn_num_evento  := Ge_Errores_Pg.Grabarpl( sn_num_evento, CV_cod_modulo, sv_mens_retorno, CV_version, USER, 'SE_PROD_PROVISIONADO_TO_SP_PG.SE_GRABA_PA_PR', LV_Sql, sn_cod_retorno, LV_des_error );        
END SE_GRABA_PA_PR;


PROCEDURE SE_BORRA_PA_PR ( EN_NUM_MOVIMIENTO IN icc_movimiento.num_movimiento%TYPE)                           
/*
<Documentación
   TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "SE_BORRA_PA_PR"
      Lenguaje="PL/SQL"
      Fecha creación="05-05-2010"
      Creado por="Carlos Sellao H."
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>n/a</Retorno>
      <Descripción>Elimina registros de PA en tabla SE_PROD_PROVISIONADO_TO </Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_NUM_MOVIMIENTO"         Tipo="NUMERICO"> Numero de Movimiento </param>
         </Entrada>
         <Salida>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
LV_des_error    ge_errores_pg.DesEvent;
LV_Sql VARCHAR2(1000);
LN_num_abonado     icc_movimiento.num_abonado%TYPE;
LN_cod_prod_cont   icc_movimiento.cod_prod_contratado%TYPE;
LN_cod_espec_prov  icc_movimiento.cod_espec_prov%TYPE;
LN_cod_prod_ofertado pr_productos_contratados_to.cod_prod_ofertado%TYPE;
LV_des_prod_ofertado pf_productos_ofertados_td.des_prod_ofertado%TYPE;
error_controlado   exception;
LN_cod_retorno     ge_errores_pg.CodError;
LV_mens_retorno    ge_errores_pg.MsgError;
LN_num_evento      ge_errores_pg.Evento;

BEGIN

     LN_cod_retorno  := 0;
     LN_num_evento   := 0;
     LV_mens_retorno := '';

        -- Lee el datos basicos desde el movimiento.-        
        LV_Sql := 'SELECT num_abonado, cod_prod_contratado, cod_espec_prov';
        LV_Sql := LV_Sql||' INTO LN_num_abonado, LN_cod_prod_cont, LN_cod_espec_prov';
        LV_Sql := LV_Sql||' FROM icc_movimiento';
        LV_Sql := LV_Sql||' WHERE num_movimiento = '||EN_num_movimiento;
       
        SELECT num_abonado, cod_prod_contratado, cod_espec_prov
        INTO LN_num_abonado, LN_cod_prod_cont, LN_cod_espec_prov
        FROM icc_movimiento
        WHERE num_movimiento = EN_num_movimiento;

        -- Elimina registro de tabla de productos aprovisionados.-
        LV_Sql := 'DELETE FROM SE_PROD_PROVISIONADO_TO';
        LV_Sql := LV_Sql||' WHERE num_abonado = '||LN_num_abonado;
        LV_Sql := LV_Sql||' AND cod_prod_contratado = '||LN_cod_prod_cont;

        DELETE FROM SE_PROD_PROVISIONADO_TO
        WHERE num_abonado = LN_num_abonado
        AND cod_prod_contratado = LN_cod_prod_cont;

EXCEPTION
    WHEN error_controlado THEN
        LN_cod_retorno := CN_Err_Usuario;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,LV_mens_retorno) THEN
               LV_mens_retorno := CV_error_no_clasif;
        END IF;
        LV_des_error   := ' SE_PROD_PROVISIONADO_TO_SP_PG.SE_BORRA_PA_PR('||EN_NUM_MOVIMIENTO||');['||SQLERRM||']';
        LN_num_evento  := Ge_Errores_Pg.Grabarpl( LN_num_evento, CV_cod_modulo, LV_mens_retorno, CV_version, USER, 'SE_PROD_PROVISIONADO_TO_SP_PG.SE_BORRA_PA_PR', LV_Sql, LN_cod_retorno, LV_des_error );
    WHEN OTHERS THEN
        LN_cod_retorno := CN_Err_Cli;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,LV_mens_retorno) THEN
               LV_mens_retorno := CV_error_no_clasif;
        END IF;
        LV_des_error   := ' SE_PROD_PROVISIONADO_TO_SP_PG.SE_BORRA_PA_PR('||EN_NUM_MOVIMIENTO||');['||SQLERRM||']';
        LN_num_evento  := Ge_Errores_Pg.Grabarpl( LN_num_evento, CV_cod_modulo, LV_mens_retorno, CV_version, USER, 'SE_PROD_PROVISIONADO_TO_SP_PG.SE_BORRA_PA_PR', LV_Sql, LN_cod_retorno, LV_des_error );
END SE_BORRA_PA_PR;


PROCEDURE SE_ESTADOACTIVO_PA_PR ( EN_NUM_MOVIMIENTO IN icc_movimiento.num_movimiento%TYPE)                           
/*
<Documentación
   TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "SE_ESTADOACTIVO_PA_PR"
      Lenguaje="PL/SQL"
      Fecha creación="05-05-2010"
      Creado por="Carlos Sellao H."
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>n/a</Retorno>
      <Descripción>Cambia el estado de PA a Activo en tabla SE_PROD_PROVISIONADO_TO </Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_NUM_MOVIMIENTO"         Tipo="NUMERICO"> Numero de Movimiento </param>
         </Entrada>
         <Salida>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
LV_des_error    ge_errores_pg.DesEvent;
LV_Sql VARCHAR2(1000);
LN_num_abonado     icc_movimiento.num_abonado%TYPE;
LN_cod_prod_cont   icc_movimiento.cod_prod_contratado%TYPE;
LN_cod_espec_prov  icc_movimiento.cod_espec_prov%TYPE;
LN_cod_prod_ofertado pr_productos_contratados_to.cod_prod_ofertado%TYPE;
LV_des_prod_ofertado pf_productos_ofertados_td.des_prod_ofertado%TYPE;
error_controlado   exception;
LN_cod_retorno     ge_errores_pg.CodError;
LV_mens_retorno    ge_errores_pg.MsgError;
LN_num_evento      ge_errores_pg.Evento;

BEGIN

     LN_cod_retorno  := 0;
     LN_num_evento   := 0;
     LV_mens_retorno := '';

        -- Lee el datos basicos desde el movimiento.-        
        LV_Sql := 'SELECT num_abonado, cod_prod_contratado, cod_espec_prov';
        LV_Sql := LV_Sql||' INTO LN_num_abonado, LN_cod_prod_cont, LN_cod_espec_prov';
        LV_Sql := LV_Sql||' FROM icc_movimiento';
        LV_Sql := LV_Sql||' WHERE num_movimiento = '||EN_num_movimiento;
       
        SELECT num_abonado, cod_prod_contratado, cod_espec_prov
        INTO LN_num_abonado, LN_cod_prod_cont, LN_cod_espec_prov
        FROM icc_movimiento
        WHERE num_movimiento = EN_num_movimiento;

        -- Lee el producto ofertado que representa al PA.-        
        LV_Sql := 'SE_PROD_OFER_PR( '||LN_num_abonado||','||LN_cod_prod_cont||' )';
        SE_PROD_OFER_PR ( LN_num_abonado,LN_cod_prod_cont,LN_cod_prod_ofertado,LV_des_prod_ofertado,LN_cod_retorno,LV_mens_retorno,LN_num_evento );

        IF LN_cod_retorno != 0 THEN
           RAISE error_controlado;
        END IF;

        -- Cambia estado a Activo de registro de tabla de productos aprovisionados.-
        LV_Sql := 'UPDATE SE_PROD_PROVISIONADO_TO';
        LV_Sql := LV_Sql||' SET estado = ''A''';
        LV_Sql := LV_Sql||' WHERE num_abonado = '||LN_num_abonado;
        LV_Sql := LV_Sql||' AND cod_prod_ofertado = '||LN_cod_prod_ofertado;
        LV_Sql := LV_Sql||' AND cod_prod_contratado = '||LN_cod_prod_cont;
                
        UPDATE SE_PROD_PROVISIONADO_TO
        SET estado = 'A'
        WHERE num_abonado = LN_num_abonado
        AND cod_prod_ofertado = LN_cod_prod_ofertado
        AND cod_prod_contratado = LN_cod_prod_cont;

EXCEPTION
    WHEN error_controlado THEN
        LN_cod_retorno := CN_Err_Usuario;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,LV_mens_retorno) THEN
               LV_mens_retorno := CV_error_no_clasif;
        END IF;
        LV_des_error   := ' SE_PROD_PROVISIONADO_TO_SP_PG.SE_ESTADOACTIVO_PA_PR('||EN_NUM_MOVIMIENTO||');['||SQLERRM||']';
        LN_num_evento  := Ge_Errores_Pg.Grabarpl( LN_num_evento, CV_cod_modulo, LV_mens_retorno, CV_version, USER, 'SE_PROD_PROVISIONADO_TO_SP_PG.SE_ESTADOACTIVO_PA_PR', LV_Sql, LN_cod_retorno, LV_des_error );

    WHEN OTHERS THEN
        LN_cod_retorno := CN_Err_Cli;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,LV_mens_retorno) THEN
               LV_mens_retorno := CV_error_no_clasif;
        END IF;
        LV_des_error   := ' SE_PROD_PROVISIONADO_TO_SP_PG.SE_ESTADOACTIVO_PA_PR('||EN_NUM_MOVIMIENTO||');['||SQLERRM||']';
        LN_num_evento  := Ge_Errores_Pg.Grabarpl( LN_num_evento, CV_cod_modulo, LV_mens_retorno, CV_version, USER, 'SE_PROD_PROVISIONADO_TO_SP_PG.SE_ESTADOACTIVO_PA_PR', LV_Sql, LN_cod_retorno, LV_des_error );
END SE_ESTADOACTIVO_PA_PR;


PROCEDURE SE_APROVISIONA_PA_PR ( EN_NUM_ABONADO    IN icc_movimiento.num_abonado%TYPE,
                              EN_cod_prod_cont  IN se_prod_provisionado_to.cod_prod_contratado%TYPE,
                              SN_cod_prod_ofer  OUT se_prod_provisionado_to.cod_prod_ofertado%TYPE,
                              SV_des_prod_ofer  OUT se_prod_provisionado_to.des_prod_ofertado%TYPE,
                              SN_COD_RETORNO  OUT NOCOPY  ge_errores_pg.CodError,
                              SV_MENS_RETORNO OUT NOCOPY  ge_errores_pg.MsgError,
                              SN_NUM_EVENTO   OUT NOCOPY  ge_errores_pg.evento
)
/*
<Documentación
   TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "SE_APROVISIONA_PA_PR"
      Lenguaje="PL/SQL"
      Fecha creación="17-05-2010"
      Creado por="Carlos Sellao H."
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>n/a</Retorno>
      <Descripción>Rescata producto ofertado del abonado en tabla SE_PROD_PROVISIONADO_TO </Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_NUM_MOVIMIENTO"         Tipo="NUMERICO"> Numero de Movimiento </param>
            <param nom="EN_COD_PROD_CONT"         Tipo="NUMERICO"> Código de producto contratado </param>
         </Entrada>
         <Salida>
            <param nom="SN_COD_PROD_OFER"       Tipo="NUMERICO">Codigo de producto ofertado</param>
            <param nom="SN_DES_PROD_OFER"       Tipo="CARACTER">Descripcion de producto ofertado</param>                        
            <param nom="SN_COD_RETORNO"       Tipo="NUMERICO">Codigo de retorno o Error</param>
            <param nom="SV_MENS_RETORNO"       Tipo="CARACTER">Mensaje de retorno</param>
            <param nom="SN_NUM_EVENTO"      Tipo="NUMERICO">Numero de Evento</param>         
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
LV_des_error    ge_errores_pg.DesEvent;
LV_Sql VARCHAR2(1000);

LN_cod_prod   se_prod_provisionado_to.cod_prod_ofertado%TYPE;
LV_des_prod   se_prod_provisionado_to.des_prod_ofertado%TYPE;
LN_cod_retorno     ge_errores_pg.CodError;
LV_mens_retorno    ge_errores_pg.MsgError;
LN_num_evento      ge_errores_pg.Evento;

BEGIN

    LN_cod_retorno  := 0;
    LN_num_evento   := 0;
    LV_mens_retorno := '';

    -- Lee el datos del PA.-        
    LV_Sql := 'SELECT cod_prod_ofertado, des_prod_ofertado';
    LV_Sql := LV_Sql||' INTO LN_cod_prod, LV_des_prod';
    LV_Sql := LV_Sql||' FROM se_prod_provisionado_to';    
    LV_Sql := LV_Sql||' WHERE num_abonado = '||EN_num_abonado;
    LV_Sql := LV_Sql||' AND cod_prod_contratado = '||EN_cod_prod_cont;

    SELECT cod_prod_ofertado, des_prod_ofertado
    INTO LN_cod_prod, LV_des_prod
    FROM se_prod_provisionado_to
    WHERE num_abonado = EN_num_abonado 
    AND cod_prod_contratado = EN_cod_prod_cont;
    
    SN_cod_prod_ofer := LN_cod_prod;
    SV_des_prod_ofer := LV_des_prod;
     
EXCEPTION
    WHEN OTHERS THEN
        LN_cod_retorno := CN_Err_Usuario;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,LV_mens_retorno) THEN
               LV_mens_retorno := CV_error_no_clasif;
        END IF;
        LV_des_error   := ' SE_PROD_PROVISIONADO_TO_SP_PG.SE_APROVISIONA_PA_PR('||EN_NUM_ABONADO||');['||SQLERRM||']';
        LN_num_evento  := Ge_Errores_Pg.Grabarpl( LN_num_evento, CV_cod_modulo, LV_mens_retorno, CV_version, USER, 'SE_PROD_PROVISIONADO_TO_SP_PG.SE_APROVISIONA_PA_PR', LV_Sql, LN_cod_retorno, LV_des_error );
END SE_APROVISIONA_PA_PR;

END SE_PROD_PROVISIONADO_TO_SP_PG;
/
SHOW ERRORS