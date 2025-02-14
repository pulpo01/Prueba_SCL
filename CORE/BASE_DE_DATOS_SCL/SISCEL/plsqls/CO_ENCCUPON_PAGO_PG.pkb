CREATE OR REPLACE PACKAGE BODY        Co_Enccupon_Pago_Pg IS

        FUNCTION CO_DESC_OPERADORA_FN(EV_operadora IN VARCHAR2) RETURN VARCHAR2 IS
        -- <Documentacisn TipoDoc = "Funcisn">
        -- <Elemento Nombre = "CO_DESC_OPERADORA_FN" Lenguaje="PL/SQL" Fecha="20-04-2005" Versisn="2.0.0" Diseqador="MQ" Programador="HQ" Ambiente="BD">
        -- <Retorno>NA</Retorno>
        -- <Descripcisn> Funcion que retorna la descripcion de una operadora determianda </Descripcisn>
        -- <Parametros>
        -- <Entrada>
        -- <param nom="EV_operadora" Tipo="STRING">Descripcisn= Codigo de Operadora</param>
        -- </Entrada>
        -- <Salida>
        -- <param nom="TV_nomoperadora" Tipo="STRING">Descripcisn= Descripcion de la Operadora</param>
        -- </Salida>
        -- </Parametros>

                TV_nomoperadora GE_OPERADORA_SCL.DES_OPERADORA_SCL%TYPE;
                LV_error VARCHAR2(100);

                BEGIN

                         LV_error := 'SELECT des_operadora_scl FROM ge_operadora_scl. ';

                         SELECT
                                 ope.des_operadora_scl
                         INTO
                                 TV_nomoperadora
                         FROM
                                 ge_operadora_scl ope
                         WHERE
                                 ope.cod_operadora_scl = EV_operadora;

                         RETURN TV_nomoperadora;

                EXCEPTION
                        WHEN OTHERS THEN
                                 LV_error := LV_error || SQLERRM;
                                 RAISE_APPLICATION_ERROR(-20104,LV_error);

        END CO_DESC_OPERADORA_FN;

        FUNCTION CO_IDEN_OPERADORA_FN(EV_operadora IN VARCHAR2) RETURN VARCHAR2 IS
        -- <Documentacisn TipoDoc = "Funcisn">
        -- <Elemento Nombre = "CO_IDEN_OPERADORA_FN" Lenguaje="PL/SQL" Fecha="20-04-2005" Versisn="2.0.0" Diseqador="MQ" Programador="HQ" Ambiente="BD">
        -- <Retorno>NA</Retorno>
        -- <Descripcisn> Funcion que retorna el identificador de una operadora determianda </Descripcisn>
        -- <Parametros>
        -- <Entrada>
        -- <param nom="EV_operadora" Tipo="STRING">Descripcisn = Codigo de la Operadora</param>
        -- </Entrada>
        -- <Salida>
        -- <param nom="TV_identificador" Tipo="STRING">Descripcisn = Identificador de la Operadora</param>
        -- </Salida>
        -- </Parametros>

                TV_identificador GE_CLIENTES.NUM_IDENT%TYPE;
                LV_error VARCHAR2(100);

                BEGIN

                         LV_error := 'SELECT cli.num_ident FROM ge_clientes cli, ge_operadora_scl ope. ';

                         SELECT
                                 cli.num_ident
                         INTO
                                 TV_identificador
                         FROM
                                 ge_clientes cli, ge_operadora_scl ope
                         WHERE
                                         ope.cod_cliente = cli.cod_cliente
                                 AND ope.cod_operadora_scl = EV_operadora;

                         RETURN TV_identificador;

                EXCEPTION
                        WHEN OTHERS THEN
                                 LV_error := LV_error || SQLERRM;
                                 RAISE_APPLICATION_ERROR(-20104,LV_error);

        END CO_IDEN_OPERADORA_FN;

        FUNCTION CO_NTEL_OPERADORA_FN(EV_operadora IN VARCHAR2) RETURN VARCHAR2 IS
        -- <Documentacisn TipoDoc = "Funcisn">
        -- <Elemento Nombre = "CO_NTEL_OPERADORA_FN" Lenguaje="PL/SQL" Fecha="20-04-2005" Versisn="1.0.0" Diseqador="MQ" Programador="HQ" Ambiente="BD">
        -- <Retorno>NA</Retorno>
        -- <Descripcisn> Funcion que retorna el numero de telefono de una operadora determianda </Descripcisn>
        -- <Parametros>
        -- <Entrada>
        -- <param nom="EV_operadora" Tipo="STRING">Descripcisn = Codigo de la Operadora</param>
        -- </Entrada>
        -- <Salida>
        -- <param nom="TV_telefono" Tipo="STRING">Descripcisn = Telefono de la Operadora</param>
        -- </Salida>
        -- </Parametros>

                TV_telefono GE_CLIENTES.TEF_CLIENTE1%TYPE;
                LV_error VARCHAR2(100);

                BEGIN

                         LV_error := 'SELECT cli.tef_cliente1 FROM ge_clientes cli, ge_operadora_scl ope. ';

                         SELECT
                                 cli.tef_cliente1
                         INTO
                                 TV_telefono
                         FROM
                                 ge_clientes cli, ge_operadora_scl ope
                         WHERE
                                         ope.cod_cliente = cli.cod_cliente
                                 AND ope.cod_operadora_scl = EV_operadora;

                         RETURN TV_telefono;

                EXCEPTION
                        WHEN OTHERS THEN
                                 LV_error := LV_error || SQLERRM;
                                 RAISE_APPLICATION_ERROR(-20104,LV_error);

        END CO_NTEL_OPERADORA_FN;

        FUNCTION CO_CIUD_SUCURSAL_FN(EV_operadora IN VARCHAR2, EV_sucursal IN VARCHAR2) RETURN VARCHAR2 IS
        -- <Documentacisn TipoDoc = "Funcisn">
        -- <Elemento Nombre = "CO_CIUD_SUCURSAL_FN" Lenguaje="PL/SQL" Fecha="20-04-2005" Versisn="1.0.0" Diseqador="MQ" Programador="HQ" Ambiente="BD">
        -- <Retorno>NA</Retorno>
        -- <Descripcisn> Funcion que retorna la ciudad y pais de una sucursal determianda </Descripcisn>
        -- <Parametros>
        -- <Entrada>
        -- <param nom="EV_operadora"  Tipo="STRING">Descripcisn = Codigo de la Operadora</param>
        -- <param nom="EV_sucursal"   Tipo="STRING">Descripcisn = Codigo de la Sucursal determinada</param>
        -- </Entrada>
        -- <Salida>
        -- <param nom="LV_ciudadpais" Tipo="STRING">Descripcisn = Nombre de Ciudad y Pais, en el formato ciudad-pais </param>
        -- </Salida>
        -- </Parametros>

                LV_ciudadpais VARCHAR2(100);
                LV_error VARCHAR2(100);

                BEGIN

                         LV_error := 'SELECT cli.tef_cliente1 FROM ge_clientes cli, ge_operadora_scl ope. ';

                         SELECT
                                 ciu.des_ciudad || ' - ' ||pais.des_pais
                         INTO
                                 LV_ciudadpais
                         FROM
                                 ge_clientes cli, ge_direcciones dir, ge_ciudades ciu,
                                 ge_paises pais, ge_operadora_scl ope, ge_oficinas ofi
                         WHERE
                                 ope.cod_operadora_scl = EV_operadora AND
                                 ofi.cod_oficina = EV_sucursal AND
                                 ope.cod_cliente = cli.cod_cliente AND
                                 cli.cod_pais = pais.cod_pais AND
                                 ofi.cod_direccion = dir.cod_direccion AND
                                 dir.cod_region = ciu.cod_region AND
                                 dir.cod_provincia = ciu.cod_provincia AND
                                 dir.cod_ciudad = ciu.cod_ciudad;

                         RETURN LV_ciudadpais;

                EXCEPTION
                        WHEN OTHERS THEN
                                 LV_error := LV_error || SQLERRM;
                                 RAISE_APPLICATION_ERROR(-20104,LV_error);

        END CO_CIUD_SUCURSAL_FN;

END Co_Enccupon_Pago_Pg; -- Package Body CO_ENCCUPON_PAGO_PG
/
SHOW ERRORS
