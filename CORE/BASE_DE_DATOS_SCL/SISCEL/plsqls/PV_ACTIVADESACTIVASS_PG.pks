CREATE OR REPLACE PACKAGE PV_ACTIVADESACTIVASS_PG IS

PROCEDURE PV_INICIOSS_PR (
                          EV_NUMABONADO       IN  VARCHAR2,	-- Numero de Abonado
                          EV_NUMCELULAROLD    IN  VARCHAR2,	-- Celular Viejo
                          EV_NUMCELULARNEW    IN  VARCHAR2,	-- Celular Nuevo
                          EV_CODACTABO        IN  VARCHAR2,	-- ACTUACION
                          EV_CODOOSS          IN  VARCHAR2,	-- Codigo OOSS
                          EV_CLASEACT         IN  VARCHAR2,	-- SS ACTIVAR
                          EV_CLASEDES         IN  VARCHAR2,	-- SS DESACTIVAR
                          EV_SUMACARGOS       IN  VARCHAR2,	-- Valor de Cargos
                          EV_SALDOABO         IN  VARCHAR2,	-- Saldo Abonado (Prepago)
                          EV_USUARIO          IN  VARCHAR2, -- Usuario
                          EV_BDATOS           IN  VARCHAR2, -- Base de Datos
                          EV_CODMODULO        IN  VARCHAR2,	-- por GC
                          EV_NUMTAREA         IN  VARCHAR2, -- por GC
                          EV_INDFLAG          IN  VARCHAR2, -- FLAG DE INSERCION (1=SI, 0=NO)
                          EV_FECEJEC          IN  VARCHAR2, -- FECHA DE EJECUCION DEL SS
                          EV_FECPROG          IN  VARCHAR2, -- FECHA DE PROGRAMACION DEL SS
                          SV_NUMOOSS          OUT VARCHAR2, -- OOSS cuando SS es Activado
                          SV_CODERROR         OUT VARCHAR2,
                          SV_MENERROR         OUT VARCHAR2,
                          SV_ORAERROR         OUT VARCHAR2
                         );

PROCEDURE PV_INSOS_INS_PVIORSERV (
                                  EV_NUMOOSS        IN  VARCHAR2, -- Nro.OOSS
                                  EV_CODOOSS        IN  VARCHAR2, -- OOSS Servicio Suplementario
                                  EV_CODPRODUCTO    IN  VARCHAR2, -- Producto
                                  EV_FECHAEJEC      IN  VARCHAR2, -- Fecha Ejecucion OOSS
                                  EV_FECHAPROG      IN  VARCHAR2, -- Fecha Programacion OOSS
                                  EV_USUARIO        IN  VARCHAR2, -- Usuario
                                  EV_CODMODULO      IN  VARCHAR2, -- por GC, POR DEFECTO ' '
                                  EV_NUMTAREA       IN  VARCHAR2, -- por GC, POR DEFECTO '0'
                                  SV_CODERROR       OUT VARCHAR2,
                                  SV_MENERROR       OUT VARCHAR2,
                                  SV_ORAERROR       OUT VARCHAR2
                                 );

PROCEDURE PV_INSOS_INS_PVERECORRIDO (
                                     EV_NUMOOSS        IN  VARCHAR2, -- Nro.OOSS
                                     SV_CODERROR       OUT VARCHAR2,
                                     SV_MENERROR       OUT VARCHAR2,
                                     SV_ORAERROR       OUT VARCHAR2
                                    );

PROCEDURE PV_INSOS_INS_PVPROG (
                               EV_NUMOOSS        IN  VARCHAR2, -- Nro.OOSS
                               EV_FECHAPROG      IN  VARCHAR2, -- Fecha Programacion OOSS
                               EV_USUARIO        IN  VARCHAR2, -- Usuario
                               SV_CODERROR       OUT VARCHAR2,
                               SV_MENERROR       OUT VARCHAR2,
                               SV_ORAERROR       OUT VARCHAR2
                              );

PROCEDURE PV_INSOS_INS_PVMOVIMIENTOS (
                                      EV_NUMOOSS        IN  VARCHAR2, -- Nro.OOSS
                                      EV_CODACTABO      IN  VARCHAR2, -- Actuacion
                                      EV_SUMACARGOS     IN  VARCHAR2, -- Suma Cargos
                                      SV_CODERROR       OUT VARCHAR2,
                                      SV_MENERROR       OUT VARCHAR2,
                                      SV_ORAERROR       OUT VARCHAR2
                                     );

PROCEDURE PV_INSOS_INS_PVCAMCOM (
                                 EV_NUMOOSS        IN  VARCHAR2, -- Nro.OOSS
                                 EV_NUMABONADO     IN  VARCHAR2, -- Numero de Abonado
                                 EV_NUMCELULAR     IN  VARCHAR2, -- Numero de Celular
                                 EV_CODCLIENTE     IN  VARCHAR2, -- Cliente
                                 EV_CODCUENTA      IN  VARCHAR2, -- Cuenta
                                 EV_CODPRODUCTO    IN  VARCHAR2, -- Producto
                                 EV_BDATOS         IN  VARCHAR2, -- Base de Datos
                                 EV_NUMTRANS       IN  VARCHAR2, -- Nro. Transaccion
                                 EV_CODACTABO      IN  VARCHAR2, -- Actuacion
                                 EV_FECHAPROG      IN  VARCHAR2, -- Fecha Programacion OOSS
                                 EV_CLASEACT       IN  VARCHAR2, -- SS a Activar
                                 EV_CLASEDES       IN  VARCHAR2, -- SS a Desactivar
                                 EV_INDCENTRAL     IN  VARCHAR2, -- Ind.Central
                                 SV_CODERROR       OUT VARCHAR2,
                                 SV_MENERROR       OUT VARCHAR2,
                                 SV_ORAERROR       OUT VARCHAR2
                                );

PROCEDURE PV_INSOS_UPD_PVIORSERV (
                                  EV_NUMOOSS        IN  VARCHAR2, -- Nro.OOSS
                                  EV_CLASEDES       IN  VARCHAR2, -- SS a Desactivar
                                  EV_CODACTABO      IN  VARCHAR2, -- Actuacion
                                  SV_CODERROR       OUT VARCHAR2,
                                  SV_MENERROR       OUT VARCHAR2,
                                  SV_ORAERROR       OUT VARCHAR2
                                 );


PROCEDURE PV_INSOS_UPD_PVERECORRIDO (
                                     EV_NUMOOSS        IN  VARCHAR2, -- Nro.OOSS
                                     SV_CODERROR       OUT VARCHAR2,
                                     SV_MENERROR       OUT VARCHAR2,
                                     SV_ORAERROR       OUT VARCHAR2
                                    );

END PV_ACTIVADESACTIVASS_PG;
/
SHOW ERRORS
