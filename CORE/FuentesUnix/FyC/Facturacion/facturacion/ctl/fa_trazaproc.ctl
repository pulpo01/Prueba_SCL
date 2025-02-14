options (bindsize=1048576)
load data
append
into table fa_trazaproc
fields terminated by '|'
(
COD_CICLFACT,
COD_PROCESO,
COD_ESTAPROC,
FEC_INICIO date "yyyymmddhh24miss",
FEC_TERMINO date "yyyymmddhh24miss",
GLS_PROCESO,
COD_CLIENTE,
NUM_ABONADO,
NUM_REGISTROS
)
