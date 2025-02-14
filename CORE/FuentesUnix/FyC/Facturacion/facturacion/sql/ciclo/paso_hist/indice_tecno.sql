set ver off
prompt Primary key PK_FA_HISTECNO_TH_&1

alter table FA_HISTECNO_TH_&1
add constraint PK_FA_HISTECNO_TH_&1 PRIMARY KEY
(IND_ORDENTOTAL, COD_CONCEPTO, COLUMNA, COD_TECNOLOGIA
)
using index
pctfree     5
initrans    8
maxtrans    255
tablespace   FACTURACION_CICLOS_HIND
storage
(initial    10M   
next        2M   
minextents  1
maxextents  256
pctincrease 0
freelists   8)
/

prompt foreign key FK_HISTEC_&1._HISTCONC_&1 

alter table FA_HISTECNO_TH_&1 add constraint
FK_HISTEC_&1._HISTCONC_&1 foreign key
( IND_ORDENTOTAL, COD_CONCEPTO, COLUMNA)
references FA_HISTCONC_&1 ( IND_ORDENTOTAL, COD_CONCEPTO, COLUMNA)
on delete cascade
/

exit;
