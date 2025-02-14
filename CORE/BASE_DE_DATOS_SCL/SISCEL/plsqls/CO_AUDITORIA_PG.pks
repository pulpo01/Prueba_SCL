CREATE OR REPLACE PACKAGE CO_AUDITORIA_PG AS
/*
prueba GIT
<Documentación TipoDoc="Paquete">
<Elemento Nombre="CO_AUDITORIA_PG"
 Lenguaje="PL/SQL" Fecha="22-11-2005"
 Versión="1.0.0" Diseñador="****"
 Programador="César Palma" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción>NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN</Descripción>
<Parámetros>
<Entrada>
</Entrada>
<Salida>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

        PROCEDURE CO_INTERES_IN_PR (EVNum_Secuencia      VARCHAR2,
                                            ENcod_tasa            co_intereses.cod_tasa%type,
                                                    ENnum_secuencia       co_intereses.num_secuencia%type,
                                                                    ENfactor_int          co_intereses.factor_int%type,
                                                                    ENfactor_dia          co_intereses.factor_dia%type,
                                                                    EVind_fec_cobro       co_intereses.ind_fec_cobro%type,
                                                                    ENdias_aplicacion     co_intereses.dias_aplicacion%type,
                                    EDfec_vigencia_dd_dh  VARCHAR2,--co_intereses.fec_vigencia_dd_dh%type,
                                                                    EDfec_vigencia_hh_dh  VARCHAR2,--co_intereses.fec_vigencia_hh_dh%type,
                                                                    EDfec_creacion_dh     VARCHAR2,--co_intereses.fec_creacion_dh%type,
                                                                    EVnom_usuario         co_intereses.nom_usuario%type,
                                                                        EVGlosa_Error              OUT NOCOPY VARCHAR2);

        PROCEDURE CO_INTERES_UP_PR (EVNum_Secuencia       VARCHAR2,
                                            ENcod_tasa            co_intereses.cod_tasa%type,
                                                                    ENnum_secuencia       co_intereses.num_secuencia%type,
                                                                    ENfactor_int          co_intereses.factor_int%type,
                                                                    ENfactor_dia          co_intereses.factor_dia%type,
                                                                    EVind_fec_cobro       co_intereses.ind_fec_cobro%type,
                                                                    ENdias_aplicacion     co_intereses.dias_aplicacion%type,
                                                                    EDfec_vigencia_dd_dh  VARCHAR2,--co_intereses.fec_vigencia_dd_dh%type,
                                                                    EDfec_vigencia_hh_dh  VARCHAR2,--co_intereses.fec_vigencia_hh_dh%type,
                                                                    EDfec_creacion_dh     VARCHAR2,--co_intereses.fec_creacion_dh%type,
                                                                    EVnom_usuario         co_intereses.nom_usuario%type,
                                                                        EVGlosa_Error         OUT NOCOPY VARCHAR2);

        PROCEDURE CO_INTERES_DE_PR (EVNum_Secuencia       IN VARCHAR2,
                                        ENcod_tasa            co_intereses.cod_tasa%type,
                                    ENnum_secuencia       co_intereses.num_secuencia%type,
                                                                        EVGlosa_Error         OUT NOCOPY VARCHAR2);

        FUNCTION CO_TASA_INTERES_FN(ENcod_tasa co_intereses.cod_tasa%type)RETURN BOOLEAN;
-------------------------------------------------------------------------------------------

        PROCEDURE CO_CATEGORIAS_IN_PR (EVNum_Secuencia   IN VARCHAR2,
                                               ENcod_categoria   co_categorias_td.cod_categoria%type,
                                       EVdes_categoria   co_categorias_td.des_categoria%type,
                                       ENcod_tasa        co_categorias_td.cod_tasa%type,
                                                                   ENnro_dgracia     co_categorias_td.nro_dgracia%type,
                                       EVGlosa_Error     OUT NOCOPY VARCHAR2);

                PROCEDURE CO_CATEGORIAS_UP_PR (EVNum_Secuencia   IN VARCHAR2,
                                               ENcod_categoria   co_categorias_td.cod_categoria%type,
                                           EVdes_categoria   co_categorias_td.des_categoria%type,
                                           ENcod_tasa        co_categorias_td.cod_tasa%type,
                                           ENnro_dgracia     co_categorias_td.nro_dgracia%type,
                                       EVGlosa_Error     OUT NOCOPY VARCHAR2);

        PROCEDURE CO_CATEGORIAS_DE_PR (EVNum_Secuencia   IN VARCHAR2,
                                           ENcod_categoria   co_categorias_td.cod_categoria%type,
                                       EVGlosa_Error     OUT NOCOPY VARCHAR2);

        PROCEDURE CO_INTERES_REG_UP_PR(EVNum_Secuencia       IN VARCHAR2,
                                       ENcod_tasa            IN co_intereses.cod_tasa%type,
                                                               ENnum_secuencia       IN co_intereses.num_secuencia%type,
                                                                       EDfec_vigencia_hh_dh  IN VARCHAR2,
                                                               EDfec_creacion_dh     IN VARCHAR2,
                                                           EVnom_usuario         IN co_intereses.nom_usuario%type,
                                                                   EVGlosa_Error         OUT NOCOPY VARCHAR2);

                PROCEDURE CO_INTERES_PENULREG_UP_PR (EVNum_Secuencia       IN VARCHAR2,
                                             ENcod_tasa            IN co_intereses.cod_tasa%type,
                                                                 ENnum_secuencia       IN co_intereses.num_secuencia%type,
                                                                             EDfec_vigencia_hh_dh  IN VARCHAR2,
                                                                     EVGlosa_Error         OUT NOCOPY VARCHAR2);

END CO_AUDITORIA_PG;
/
SHOW ERRORS
