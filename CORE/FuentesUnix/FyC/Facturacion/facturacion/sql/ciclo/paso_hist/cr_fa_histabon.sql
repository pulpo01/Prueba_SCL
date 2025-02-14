set echo off verify off
prompt Creando tabla  fa_histabon_&1
spool $WORKDIR/tab_fa_histabon_&1.log
create table siscel.fa_histabon_&1 
storage(initial 10M next 3M pctincrease 0)
tablespace FACTURACION_CICLOS_HTAB
as
select IND_ORDENTOTAL
      ,COD_CLIENTE
      ,NUM_ABONADO
      ,COD_PRODUCTO
      ,COD_SITUACION
      ,TOT_CARGOSME
      ,ACUM_CARGO
      ,ACUM_DTO
      ,ACUM_IVA
      ,COD_DETFACT
      ,FEC_FINCONTRA
      ,IND_FACTUR
      ,COD_CREDMOR
      ,NOM_USUARIO
      ,NOM_APELLIDO1
      ,NOM_APELLIDO2
      ,LIM_CREDITO
      ,NUM_CELULAR
      ,NUM_BEEPER
      ,CAP_CODE
      ,IND_SUPERTEL
      ,NUM_TELEFIJA
      ,COD_BARRAS
      ,COD_ZONAABON
      ,IND_COBRODETLLAM
from fa_factabon_&1
/
spool off
exit;

