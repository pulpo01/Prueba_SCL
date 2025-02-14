#! /usr/bin/awk -f

BEGIN{
      FS="|"
}

{
  if(substr($3,2,9)=="Descuento" && substr($4,2,7)=="Celular" && (substr($5,2,2)=="AL" || substr($5,2,2)=="ST"))
       printf("insert into fa_imp_grupotot values (22, %d);\n", $1)
       printf("insert into fa_imp_grupotot values (37, %d);\n", $1)
  if(substr($3,2,9)=="Descuento" && substr($4,2,7)=="Celular" && substr($5,2,2)=="GA")
       printf("insert into fa_imp_grupotot values (10, %d);\n", $1)
       printf("insert into fa_imp_grupotot values (37, %d);\n", $1)
  if(substr($3,2,5)=="Cargo" && substr($4,2,7)=="Celular" && substr($5,2,2)=="GA")
       printf("insert into fa_imp_grupotot values (10, %d);\n", $1)
       printf("insert into fa_imp_grupotot values (36, %d);\n", $1)
  if(substr($3,2,5)=="Cargo" && substr($4,2,7)=="Celular" && substr($2,2,8)=="Alquiler" && (substr($5,2,2)=="AL" || substr($5,2,2)=="ST"))
       printf("insert into fa_imp_grupotot values (21, %d);\n", $1)
       printf("insert into fa_imp_grupotot values (36, %d);\n", $1)
  if(substr($3,2,5)=="Cargo" && substr($4,2,7)=="Celular" && substr($2,2,8)!="Alquiler" && (substr($5,2,2)=="AL" || substr($5,2,2)=="ST"))
       printf("insert into fa_imp_grupotot values (20, %d);\n", $1)
       printf("insert into fa_imp_grupotot values (36, %d);\n", $1)
  if(substr($3,2,9)=="Descuento" && substr($4,2,6)=="Beeper" && substr($5,2,2)=="GA")
       printf("insert into fa_imp_grupotot values (10, %d);\n", $1)
       printf("insert into fa_imp_grupotot values (51, %d);\n", $1)
  if(substr($3,2,9)=="Descuento" && substr($4,2,6)=="Beeper" && (substr($5,2,2)=="AL" || substr($5,2,2)=="ST"))
       printf("insert into fa_imp_grupotot values (28, %d);\n", $1)
       printf("insert into fa_imp_grupotot values (51, %d);\n", $1)
  if(substr($3,2,5)=="Cargo" && substr($4,2,6)=="Beeper" && substr($5,2,2)=="GA")
       printf("insert into fa_imp_grupotot values (13, %d);\n", $1)
       printf("insert into fa_imp_grupotot values (50, %d);\n", $1)
  if(substr($3,2,5)=="Cargo" && substr($4,2,6)=="Beeper" && substr($2,2,8)!="Alquiler" && (substr($5,2,2)=="AL" || substr($5,2,2)=="ST"))
       printf("insert into fa_imp_grupotot values (26, %d);\n", $1)
       printf("insert into fa_imp_grupotot values (50, %d);\n", $1)
  if(substr($3,2,5)=="Cargo" && substr($4,2,6)=="Beeper" && substr($2,2,8)=="Alquiler" && (substr($5,2,2)=="AL" || substr($5,2,2)=="ST"))
       printf("insert into fa_imp_grupotot values (27, %d);\n", $1)
       printf("insert into fa_imp_grupotot values (50, %d);\n", $1)
}
