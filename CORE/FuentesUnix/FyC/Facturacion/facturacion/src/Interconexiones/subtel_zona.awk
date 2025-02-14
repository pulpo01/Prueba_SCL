################################################################
# Proceso para totalizar archivos de llamadas por zona
#
# Parametros :
# $1 : carrier
# $2 : fecha desde
# $3 : fecha hasta
# $4 : "c" para contratado / "d" para discado
#
################################################################
#
{ FS ="|" }
{
if (substr($0, 1, 2) == "*R") {
	print $0
	zona = 0
} else if (substr($0, 1, 2) == "*T") {
	printf("ZONA%s|%10d|%10d|%10d|%10d|%10d|%10d|%10d|%10d\n",zona,lla_reg_a,seg_reg_a,lla_cur_a,seg_cur_a,lla_reg_b,seg_reg_b,lla_cur_b,seg_cur_b)
	print $0
} else {
	if (zona != $1) {
		if (NR > 2) 
			printf("ZONA%s|%10d|%10d|%10d|%10d|%10d|%10d|%10d|%10d\n",zona,lla_reg_a,seg_reg_a,lla_cur_a,seg_cur_a,lla_reg_b,seg_reg_b,lla_cur_b,seg_cur_b)                       		
		zona		= $1
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
	if (substr($4,1,1) == "A") {
		lla_reg_a	++
		lla_cur_a	++   		
		seg_reg_a	+= $2    
		seg_cur_a	+= $3
	} else {
	        lla_reg_b	++      
                lla_cur_b	++   	
                seg_reg_b	+= $2   
                seg_cur_b	+= $3                    
	}         
}
}
                        
