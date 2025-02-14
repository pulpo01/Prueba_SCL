#!/bin/awk -f

BEGIN {
	DOCUM_SIZE = 48
	LINE_SIZE  = 105
}
{
	ROW_POS = NR % DOCUM_SIZE
	
	if(ROW_POS == 13)
	{
		Nom_Cliente   = substr($0,19,45)
		Nom_ApeClien1 = substr($0,64,20)
		Nom_ApeClien2 = substr($0,84,20)
		gsub(/[ ][ ]+/, " " , Nom_Cliente)
		gsub(/[ ][ ]+/, " " , Nom_ApeClien1)
		gsub(/[ ][ ]+/, " " , Nom_ApeClien2)
		Id_Cliente = "                  " Nom_Cliente Nom_ApeClien1 Nom_ApeClien2
		
		while(LINE_SIZE - length(Id_Cliente) > 0)
		{
			Id_Cliente = Id_Cliente " "
		}
		print Id_Cliente 
	}
	else
	{
		if(ROW_POS == 14)
		{
			Rut_Cliente = substr($0,1,29)
			Direccion   = substr($0,50,55)
			gsub(/[ ][ ]+/, " " , Direccion)
			Id_Rut_Direccion = Rut_Cliente "                    " Direccion  
			
			while(LINE_SIZE - length(Id_Rut_Direccion) > 0)
			{
				Id_Rut_Direccion = Id_Rut_Direccion " "
			}
			print Id_Rut_Direccion                  
		} 
		else
		{
			if(ROW_POS == 15)
			{
				Relleno = substr($0,1,49)
				Comuna_Ciudad = substr($0,50,55)
				gsub(/[ ][ ]+/, " " , Comuna_Ciudad)
				Id_Comuna = Relleno Comuna_Ciudad
			
				while(LINE_SIZE - length(Id_Comuna) > 0)
				{
					Id_Comuna = Id_Comuna " "
				}
				print Id_Comuna                 
			}
			else	
			{
				print $0
			}
		}
	}
}