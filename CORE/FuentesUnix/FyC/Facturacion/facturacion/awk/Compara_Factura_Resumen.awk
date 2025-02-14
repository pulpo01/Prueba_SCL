BEGIN {
    FS="|"
    arch_1= FILENAME
    Actualiza_Cabecera=(szDirDat == "" ? "Facturas_Resumen_Act.sql" : szDirDat "/Facturas_Resumen_Act.sql")
    Inserta_Errores=(szDirDat == "" ? "Facturas_Resumen_Ins.sql" : szDirDat "/Facturas_Resumen_Ins.sql")
    printf("") > Actualiza_Cabecera
    printf("") > Inserta_Errores
    printf("set feedback off \n") > Actualiza_Cabecera
    printf("set feedback off \n") > Inserta_Errores

}
{
	if (arch_1 == FILENAME )
	{
		Facturas_cliente[$1] =$1
		Facturas_Total[$1]   =$2
        NumSec               =$3
		Facturas_Archi[$1]   =$4
	}
	else
	{
		Resumen_Total[$1]   =$6
	}
}
END {
	for (cliente in Facturas_Total)
	{
		# COMPARACION DE CAMPOS DE ARCHIVOS
		if (Facturas_Total[cliente] != Resumen_Total[cliente])
		{
          Arr_Ind=split(Facturas_Archi[cliente],Arr_File,"/")
          Archivo_Afectado2=Arr_File[Arr_Ind]
          Archivo_Afectado1=Facturas_Archi[cliente]
          gsub(" ","",Archivo_Afectado1)
          gsub(" ","",Archivo_Afectado2)
		  printf("UPDATE FAD_CTLIMPRES SET COD_ESTADO=1 WHERE NUM_SECUINFO= %ld AND NOM_ARCHIVO='%s';\n",NumSec,Archivo_Afectado1) >> Actualiza_Cabecera
		  printf("INSERT INTO FAD_CTLERRIMPRE (NUM_SECUINFO,NOM_ARCHIVO,GLS_ERROR,COD_TIPIMPRES,COD_CLIENTE,TOT_CORRECTO,TOT_ERRONEO) VALUES (%ld,'%s','Total de Facturas No Coincide con Total del Resumen de Consumo.',1,%ld,%9ld,%9ld);\n",NumSec, Archivo_Afectado2,Facturas_cliente[cliente],Facturas_Total[cliente],Resumen_Total[cliente]) >> Inserta_Errores

		}
	}
	printf("COMMIT WORK;\n") >> Actualiza_Cabecera
	printf("QUIT;\n") >> Actualiza_Cabecera
	printf("COMMIT WORK;\n") >> Inserta_Errores
	printf("QUIT;\n") >> Inserta_Errores
}
