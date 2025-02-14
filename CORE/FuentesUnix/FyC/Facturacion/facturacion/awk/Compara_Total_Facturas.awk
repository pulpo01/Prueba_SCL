BEGIN {
    FS="|"
    arch_1= FILENAME
    Actualiza_Cabecera=(szDirDat == "" ? "Facturas_Act.sql" : szDirDat "/Facturas_Act.sql")
    Inserta_Errores=(szDirDat == "" ? "Facturas_Ins.sql" : szDirDat "/Facturas_Ins.sql")
    printf("") > Actualiza_Cabecera
    printf("") > Inserta_Errores
    printf("set feedback off \n") > Actualiza_Cabecera
    printf("set feedback off \n") > Inserta_Errores

}
{
	if (arch_1 == FILENAME )
	{
		tot_clientes_file[$2]  =$3
		tot_facturado_file[$2] =$4
	}
	else
	{
		tot_clientes_data[$2]=$3
		tot_facturado_data[$2]=$4
	}
}
END {
	for (archivo in tot_clientes_file)
	{
		# COMPARACION DE CAMPOS DE ARCHIVOS
		if (tot_clientes_data[archivo] != tot_clientes_file[archivo])
		{
          Arr_Ind=split(archivo,Arr_File,"/")
          Archivo_Afectado2=Arr_File[Arr_Ind]
          Archivo_Afectado1=archivo
          gsub(" ","",Archivo_Afectado1)
          gsub(" ","",Archivo_Afectado2)
		  printf("UPDATE FAD_CTLIMPRES SET COD_ESTADO=1 WHERE NUM_SECUINFO= %ld AND NOM_ARCHIVO='%s';\n",NumSecuInfo,Archivo_Afectado1) >> Actualiza_Cabecera
		  printf("INSERT INTO FAD_CTLERRIMPRE (NUM_SECUINFO,NOM_ARCHIVO,GLS_ERROR,COD_TIPIMPRES,COD_CLIENTE,TOT_CORRECTO,TOT_ERRONEO) VALUES (%ld,'%s','El Total de Clientes del Archivo de Facturas No Coincide con el Total del Ciclo de Facturacion',1,0,%9ld,%9ld);\n",NumSecuInfo, Archivo_Afectado2,tot_clientes_data[archivo],tot_clientes_file[archivo]) >> Inserta_Errores
		}
		if (tot_facturado_data[archivo] != tot_facturado_file[archivo])
		{
          Arr_Ind=split(archivo,Arr_File,"/")
          Archivo_Afectado2=Arr_File[Arr_Ind]
          Archivo_Afectado1=archivo
          gsub(" ","",Archivo_Afectado1)
          gsub(" ","",Archivo_Afectado2)
		  printf("UPDATE FAD_CTLIMPRES SET COD_ESTADO=1 WHERE NUM_SECUINFO= %ld AND NOM_ARCHIVO='%s';\n",NumSecuInfo,Archivo_Afectado1) >> Actualiza_Cabecera
		  printf("INSERT INTO FAD_CTLERRIMPRE (NUM_SECUINFO,NOM_ARCHIVO,GLS_ERROR,COD_TIPIMPRES,COD_CLIENTE,TOT_CORRECTO,TOT_ERRONEO) VALUES (%ld,'%s','El Total Facturado del Archivo de Facturas No Coincide con el Total del Ciclo de Facturacion',1,0,%9ld,%9ld);\n",NumSecuInfo, Archivo_Afectado2,tot_facturado_data[archivo],tot_facturado_file[archivo]) >> Inserta_Errores
		}
	}
	printf("COMMIT WORK;\n") >> Actualiza_Cabecera
	printf("QUIT;\n") >> Actualiza_Cabecera
	printf("COMMIT WORK;\n") >> Inserta_Errores
	printf("QUIT;\n") >> Inserta_Errores
}
