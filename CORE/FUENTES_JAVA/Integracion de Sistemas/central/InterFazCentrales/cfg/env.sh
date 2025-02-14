#!/usr/bin/sh
echo Configuracion de Entorno para Lanzamiento de Procesos de IC
TWO_TASK=<CONFIGURAR>; export TWO_TASK
ORACLE_BASE=/app10/oracle/OracleHomes/db_1; export ORACLE_BASE
ORACLE_SID=<CONFIGURAR>; export ORACLE_SID
ORACLE_HOME=/app10/oracle/OracleHomes/db_1; export ORACLE_HOME
NLS_LANG=AMERICAN_AMERICA.WE8DEC; export NLS_LANG
ORA_NLS=$ORACLE_HOME/ocommon/nls/admin/data; export ORA_NLS
ORA_NLS33=$ORACLE_HOME/ocommon/nls/admin/data; export ORA_NLS33
TNS_ADMIN=$ORACLE_HOME/network/admin; export TNS_ADMIN
#LD_LIBRARY_PATH=$ORACLE_HOME/lib64; export LD_LIBRARY_PATH
#LD_LIBRARY_PATH=$ORACLE_HOME/lib; export LD_LIBRARY_PATH
#PATH=/usr/bin::::/oracle/app/oracle/product/8.1.7/bin::/usr/sbin:/produccion/explotacion/central/ICC/bin:.; export PATH
PATH=/usr/bin::::$ORACLE_HOME/bin::/usr/sbin:<CONFIGURAR>/ICC/bin:.; export PATH
XMENCLISDT_PATH_CFG=<CONFIGURAR>/ICC/cfg; export XMENCLISDT_PATH_CFG
XSDT_PATH_CFG=<CONFIGURAR>/ICC/cfg; export XSDT_PATH_CFG
HOME=<CONFIGURAR>; export HOME

