CREATE OR REPLACE PACKAGE            EBZ_PAC_GA_CTES_CTAS
 AS
    TYPE tNom_Cliente is TABLE of varchar2(70)
    INDEX BY BINARY_INTEGER;
        TYPE tCatTribut is TABLE of varchar2(10)
    INDEX BY BINARY_INTEGER;
        TYPE tCodCliente is TABLE of ge_clientes.COD_CLIENTE%type
        INDEX BY BINARY_INTEGER;
    TYPE tNum_Abonado is TABLE of ga_abocel.num_abonado%type
    INDEX BY BINARY_INTEGER;
        TYPE tNum_Celular is TABLE of ga_abocel.num_celular%type
    INDEX BY BINARY_INTEGER;
        TYPE tCod_Situacion is TABLE of varchar2(50)
        INDEX BY BINARY_INTEGER;
--        TYPE tFec_Alta is TABLE of ga_abocel.fec_alta%type
        TYPE tFec_Alta is TABLE of varchar2(10)
        INDEX BY BINARY_INTEGER;
    PROCEDURE EBZ_PAC_GA_CTES_CTAS(cod_cta in number, cod_cliente out tCodCliente, nom_cliente out tNom_Cliente,
                            catribut out tCatTribut);
        PROCEDURE GA_ABONADOS_CTES(cod_cte in number,  Num_Celular out tNum_Celular,Num_Abonado out tNum_Abonado,
                                Cod_Situacion out tCod_Situacion, Fec_Alta out tFec_Alta);
END EBZ_PAC_GA_CTES_CTAS;
/
SHOW ERRORS
