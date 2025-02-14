nawk -F"|" <  subtel_suscriptores_min.txt -v  ARCH_MIN_0=subtel_suscriptores_t_$1.txt ' 
{
num_sub 	= gsub(/\?/, "N")
num_celular	= substr($1,1, 8)
if ($2 == " E ") {
	tip_cuentac	= "2"
	nom_apeclien1	= substr($5, 2, 20)
	nom_apeclien2	= substr($3, 2, 15)
	nom_cliente	= substr($4, 2, 14)
	num_sub 	= gsub(/^ *\. *$/, "", nom_apeclien2)
	num_sub 	= gsub(/^ *\. *$/, "", nom_apeclien1)
} else {
	tip_cuentac	= "1"
	nom_apeclien1	= substr($3, 2, 20)
	nom_apeclien2	= substr($4, 2, 15)
	nom_cliente	= substr($5, 2, 14)
}
num_rut		= substr($6, 1, index($6, "-") - 1)
dig_rut		= substr($6, index($6, "-") + 1, 1)
cod_region	= substr($7, 2, 2)
des_ciudad	= substr($8, 2, 16)
des_comuna	= substr($9, 2, 16)
nom_calle	= substr($10, 2)
num_calle	= substr($11, 2)
num_piso	= substr($12, 2) 
num_sub 	= gsub(/ *$/, "", nom_calle)
num_sub         = gsub(/ *$/, "", num_calle)
num_sub         = gsub(/ *$/, "", num_piso)
num_sub 	= gsub(/^ *\. *$/, "", num_calle)
num_sub 	= gsub(/^ *\. *$/, "", num_piso)
des_direc	= substr(nom_calle, 1, length(nom_calle)) "  " substr(num_calle, 1, length(num_calle)) " " substr(num_piso, 1, length(num_piso)) "                              "
des_direc	= substr(des_direc, 1, 30)
fec_actcen	= substr($13, 2, 10)
cod_carrier     = $14
if (cod_carrier ~ /^ *$/) {
	cod_carrier = "N"
} else {
	cod_carrier = "S"
}
cod_estado	= $15
if (cod_estado == " BF ") {
	cod_estado = "S"
} else {
	cod_estado = "N"
} 
cod_ciclo	= substr($16, 10, 2)
min_inter	= substr($17, 2, 5)
a=sprintf("%d",min_inter)
#
if (a != 0)
{
  printf(" %8s%1s%20s%15s%14s%013d %1s%2s%16s%16s%-30s%2s%16s%16s%-30s%10s%1s%1s00000%5s%02d        \n", num_celular, tip_cuentac, nom_apeclien1, nom_apeclien2, nom_cliente, num_rut, dig_rut, cod_region, des_ciudad, des_comuna, des_direc, cod_region, des_ciudad, des_comuna, des_direc, fec_actcen, cod_carrier, cod_estado, min_inter, cod_ciclo)
}else{
  printf(" %8s%1s%20s%15s%14s%013d %1s%2s%16s%16s%-30s%2s%16s%16s%-30s%10s%1s%1s00000%5s%02d        \n", num_celular, tip_cuentac, nom_apeclien1, nom_apeclien2, nom_cliente, num_rut, dig_rut, cod_region, des_ciudad, des_comuna, des_direc, cod_region, des_ciudad, des_comuna, des_direc, fec_actcen, cod_carrier, cod_estado, min_inter, cod_ciclo) > ARCH_MIN_0
  }
#
}'
