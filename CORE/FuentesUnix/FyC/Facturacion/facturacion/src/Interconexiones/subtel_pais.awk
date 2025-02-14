################################################################
# Proceso para totalizar archivos de llamadas por pais
#
# Parametros :
# $1 : carrier
# $2 : fecha desde
# $3 : fecha hasta
# $4 : "c" para contratado / "d" para discado
#
################################################################
#
# SAAM-20030507 Se modifica linea de awk
#
################################################################


{ FS ="|" }
{
if (substr($0, 1, 2) == "*R") {
	print $0
	cod_pais = 0
} else if (substr($0, 1, 2) == "*T") {
	printf("%s|%s|%10d|%10d|%10d|%10d|%10d|%10d|%10d|%10d|%10d\n", nom_pais,cod_pais,lla_reg_a,seg_reg_a,lla_cur_a,seg_cur_a,lla_reg_b,seg_reg_b,lla_cur_b,seg_cur_b,seg_total)
	print $0
} else {
	if (cod_pais != $1) {
		if (NR > 2) 
			printf("%s|%s|%10d|%10d|%10d|%10d|%10d|%10d|%10d|%10d|%10d\n",nom_pais,cod_pais,lla_reg_a,seg_reg_a,lla_cur_a,seg_cur_a,lla_reg_b,seg_reg_b,lla_cur_b,seg_cur_b,seg_total)
	        cod_pais	= $1
		nom_pais	= $2
		lla_reg_a	= 0
		seg_reg_a	= 0
		lla_cur_a	= 0
		seg_cur_a	= 0
		lla_reg_b	= 0
		seg_reg_b	= 0
		lla_cur_b	= 0
		seg_cur_b	= 0
		seg_total	= 0
	}
	if (substr($5,1,1) == "A") {
		lla_reg_a	++
		lla_cur_a	++   		
		seg_reg_a	+= $3    
		seg_cur_a	+= $4
	} else {
	        lla_reg_b	++      
                lla_cur_b	++   	
                seg_reg_b	+= $3   
                seg_cur_b	+= $4                    
	}         
        seg_total	+= $4
}
}
                        
