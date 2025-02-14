 #Compara los archivos de clientes RESUMEN.cli y LLAMADAS.cli
 # awk -f $XPF_AWK/Compara_Resumen_Detalle.awk RESUMEN.cli LLAMADAS.cli
BEGIN {
    FS="|"
    arch_1= FILENAME
    Actualiza_Cabecera=(szDirDat == "" ? "Resumen_Llamadas_Act.sql" : szDirDat "/Resumen_Llamadas_Act.sql")
    Inserta_Errores=(szDirDat == "" ? "Resumen_Llamadas_Ins.sql" : szDirDat "/Resumen_Llamadas_Ins.sql")
    printf("") > Actualiza_Cabecera
    printf("") > Inserta_Errores
    printf("set feedback off \n") > Actualiza_Cabecera
    printf("set feedback off \n") > Inserta_Errores
}
{
	if (arch_1 == FILENAME )
	{
	    NumSec=$11
		Resumen_Archi[$1]   =$12

		Resumen_Local[$1]   =$6
		Resumen_Inter[$1]   =$7
		Resumen_Espec[$1]   =$8
		Resumen_Lardi[$1]   =$9
		Resumen_Roami[$1]   =$10
	}
	else
	{
		Llamadas_Archi[$2]   =$3

		Llamadas_Local[$2]   =round($4 * 1.18)
		Llamadas_Inter[$2]   =round($5 * 1.18)
		Llamadas_Espec[$2]   =round($8 * 1.18)
		Llamadas_Lardi[$2]   =round($7 * 1.18)
		Llamadas_Roami[$2]   =round($6 * 1.18)
	}
}
END {
	for (cliente in Resumen_Archi)
	{
          Arr_Ind=split(Resumen_Archi[cliente],Arr_File,"/")
          Archivo_Afectado2=Arr_File[Arr_Ind]
          gsub(" ","",Archivo_Afectado2)
		# COMPARACION DE CAMPOS DE ARCHIVOS
		if (Resumen_Local[cliente] != Llamadas_Local[cliente])
		{
		  if ((Llamadas_Archi[cliente] != "") && (absoluto(Resumen_Local[cliente] - Llamadas_Local[cliente]) > 5) && (Llamadas_Local[cliente] > 0)){
		     
		     Error_Archivo[Resumen_Archi[cliente]]=1
		     printf("INSERT INTO FAD_CTLERRIMPRE (NUM_SECUINFO,NOM_ARCHIVO,GLS_ERROR,COD_TIPIMPRES,COD_CLIENTE,TOT_CORRECTO,TOT_ERRONEO) VALUES (%ld,'%s','Total Trafico Local de Resumen de Consumo No coincide con Trafico Local de Detalle de Llamadas',2,%ld,%9ld,%9ld);\n",NumSec, Archivo_Afectado2,cliente,Resumen_Local[cliente],Llamadas_Local[cliente]) >> Inserta_Errores
		  }   
		}
		if ((Resumen_Inter[cliente] != Llamadas_Inter[cliente]) && (absoluto(Resumen_Inter[cliente] - Llamadas_Inter[cliente]) > 5))
		{
          Error_Archivo[Resumen_Archi[cliente]]=1
		  printf("INSERT INTO FAD_CTLERRIMPRE (NUM_SECUINFO,NOM_ARCHIVO,GLS_ERROR,COD_TIPIMPRES,COD_CLIENTE,TOT_CORRECTO,TOT_ERRONEO) VALUES (%ld,'%s','Total Trafico de Interzona de Resumen de Consumo No Coincide con Trafico de Interzona de Detalle de Llamadas',2,%ld,%9ld,%9ld);\n",NumSec, Archivo_Afectado2,cliente,Resumen_Inter[cliente],Llamadas_Inter[cliente]) >> Inserta_Errores
		}
		if ((Resumen_Espec[cliente] != Llamadas_Espec[cliente]) && (absoluto(Resumen_Espec[cliente] - Llamadas_Espec[cliente]) > 5))
		{
          Error_Archivo[Resumen_Archi[cliente]]=1
		  printf("INSERT INTO FAD_CTLERRIMPRE (NUM_SECUINFO,NOM_ARCHIVO,GLS_ERROR,COD_TIPIMPRES,COD_CLIENTE,TOT_CORRECTO,TOT_ERRONEO) VALUES (%ld,'%s','Total Trafico Especiales de Resumen de Consumo No Coincide con Trafico Especiales de Detalle de Llamadas',2,%ld,%9ld,%9ld);\n",NumSec, Archivo_Afectado2,cliente,Resumen_Espec[cliente],Llamadas_Espec[cliente]) >> Inserta_Errores
		}
		if ((Resumen_Lardi[cliente] != Llamadas_Lardi[cliente]) && (absoluto(Resumen_Lardi[cliente] - Llamadas_Lardi[cliente]) > 5))
		{
          Error_Archivo[Resumen_Archi[cliente]]=1
		  printf("INSERT INTO FAD_CTLERRIMPRE (NUM_SECUINFO,NOM_ARCHIVO,GLS_ERROR,COD_TIPIMPRES,COD_CLIENTE,TOT_CORRECTO,TOT_ERRONEO) VALUES (%ld,'%s','Total Trafico de Larga Distancia de Resumen de Consumo No Coincide con Trafico de Larga Distancia de Detalle de Llamadas',2,%ld,%9ld,%9ld);\n",NumSec, Archivo_Afectado2,cliente,Resumen_Lardi[cliente],Llamadas_Lardi[cliente]) >> Inserta_Errores
		}
		if ((Resumen_Roami[cliente] != Llamadas_Roami[cliente]) && (absoluto(Resumen_Roami[cliente] - Llamadas_Roami[cliente]) > 5))
		{
          Error_Archivo[Resumen_Archi[cliente]]=1
		  printf("INSERT INTO FAD_CTLERRIMPRE (NUM_SECUINFO,NOM_ARCHIVO,GLS_ERROR,COD_TIPIMPRES,COD_CLIENTE,TOT_CORRECTO,TOT_ERRONEO) VALUES (%ld,'%s','Total Trafico de Roaming de Resumen de Consumo No Coincide con Trafico de Roaming de Detalle de Llamadas',2,%ld,%9ld,%9ld);\n",NumSec, Archivo_Afectado2,cliente,Resumen_Roami[cliente],Llamadas_Roami[cliente]) >> Inserta_Errores
		}
	}
   for (ind_archivo in Error_Archivo) {
       Archivo_Afectado1=ind_archivo
       gsub(" ","",Archivo_Afectado1)
	   printf("UPDATE FAD_CTLIMPRES SET COD_ESTADO=1 WHERE NUM_SECUINFO= %ld AND NOM_ARCHIVO='%s';\n",NumSec,Archivo_Afectado1) >> Actualiza_Cabecera
   }   
   printf("COMMIT WORK;\n") >> Actualiza_Cabecera
   printf("QUIT;\n")        >> Actualiza_Cabecera

   printf("COMMIT WORK;\n") >> Inserta_Errores
   printf("QUIT;\n")        >> Inserta_Errores
}

function round ( numero_aux)
{
    return int(numero_aux+0.5)
}

function absoluto(numero_aux)
{
    return int(sqrt(numero_aux * numero_aux))
}
