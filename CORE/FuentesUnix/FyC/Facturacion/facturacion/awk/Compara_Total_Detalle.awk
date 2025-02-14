BEGIN {
    FS="|"
    arch_1= FILENAME
    Actualiza_Cabecera=(szDirDat == "" ? "Llamadas_Act.sql" : szDirDat "/Llamadas_Act.sql")
    Inserta_Errores=(szDirDat == "" ? "Llamadas_Ins.sql" : szDirDat "/Llamadas_Ins.sql")
    printf("") > Actualiza_Cabecera
    printf("") > Inserta_Errores
    
    printf("set feedback off \n") > Actualiza_Cabecera
    printf("set feedback off \n") > Inserta_Errores
}
{
	if (arch_1 == FILENAME )
	{
		tot_clientes_file[$2]   =$3
		tot_tlocales_file[$2]   =$4
		tot_tinterzona_file[$2] =$5
		tot_troaming_file[$2]   =$6
		tot_tcarrier_file[$2]   =$7
		tot_tespeciales_file[$2]=$8
	}
	else
	{
		tot_clientes_data[$2]   =$3
		tot_tlocales_data[$2]   =$4
		tot_tinterzona_data[$2] =$5
		tot_troaming_data[$2]   =$6
		tot_tcarrier_data[$2]   =$7
		tot_tespeciales_data[$2]=$8
	}
}
END {
	for (archivo in tot_clientes_file)
	{
          Error=0
          Arr_Ind=split(archivo,Arr_File,"/")
          Archivo_Afectado2=Arr_File[Arr_Ind]
          Archivo_Afectado1=archivo
          gsub(" ","",Archivo_Afectado1)
          gsub(" ","",Archivo_Afectado2)
		# COMPARACION DE CAMPOS DE ARCHIVOS
		if (tot_clientes_data[archivo] != tot_clientes_file[archivo])
		{
		  if (Error==0){
		     printf("UPDATE FAD_CTLIMPRES SET COD_ESTADO=1 WHERE NUM_SECUINFO= %ld AND NOM_ARCHIVO='%s';\n",NumSecuInfo,Archivo_Afectado1) >> Actualiza_Cabecera
		     Error=1
		  }
		     printf("INSERT INTO FAD_CTLERRIMPRE (NUM_SECUINFO,NOM_ARCHIVO,GLS_ERROR,COD_TIPIMPRES,COD_CLIENTE,TOT_CORRECTO,TOT_ERRONEO) VALUES (%ld,'%s','El Total de Clientes del Archivo de Detalle de Llamadas No Coincide Con Total del Ciclo de Facturacion',3,0,%9ld,%9ld);\n",NumSecuInfo, Archivo_Afectado2,tot_clientes_data[archivo],tot_clientes_file[archivo]) >> Inserta_Errores
		}
		if (tot_tlocales_data[archivo] != tot_tlocales_file[archivo])
		{
		  if (Error==0){
   		     printf("UPDATE FAD_CTLIMPRES SET COD_ESTADO=1 WHERE NUM_SECUINFO= %ld AND NOM_ARCHIVO='%s';\n",NumSecuInfo,Archivo_Afectado1) >> Actualiza_Cabecera
		     Error=1
		  }
		     printf("INSERT INTO FAD_CTLERRIMPRE (NUM_SECUINFO,NOM_ARCHIVO,GLS_ERROR,COD_TIPIMPRES,COD_CLIENTE,TOT_CORRECTO,TOT_ERRONEO) VALUES (%ld,'%s','El Total de Trafico Local del Archivo de Detalle de Llamadas No Coincide Con Total del Ciclo de Facturacion',3,0,%9ld,%9ld);\n",NumSecuInfo, Archivo_Afectado2,tot_tlocales_data[archivo],tot_tlocales_file[archivo]) >> Inserta_Errores
		}
		if (tot_tinterzona_data[archivo] != tot_tinterzona_file[archivo])
		{
		  if (Error==0){
		     printf("UPDATE FAD_CTLIMPRES SET COD_ESTADO=1 WHERE NUM_SECUINFO= %ld AND NOM_ARCHIVO='%s';\n",NumSecuInfo,Archivo_Afectado1) >> Actualiza_Cabecera
		     Error=1
		  }
		     printf("INSERT INTO FAD_CTLERRIMPRE (NUM_SECUINFO,NOM_ARCHIVO,GLS_ERROR,COD_TIPIMPRES,COD_CLIENTE,TOT_CORRECTO,TOT_ERRONEO) VALUES (%ld,'%s','El Total de Trafico Interzonas del Archivo de Detalle de Llamadas No Coincide Con Total del Ciclo de Facturacion',3,0,%9ld,%9ld);\n",NumSecuInfo, Archivo_Afectado2,tot_tinterzona_data[archivo],tot_tinterzona_file[archivo]) >> Inserta_Errores
		}
		if (tot_troaming_data[archivo] != tot_troaming_file[archivo])
		{
		  if (Error==0){
   		     printf("UPDATE FAD_CTLIMPRES SET COD_ESTADO=1 WHERE NUM_SECUINFO= %ld AND NOM_ARCHIVO='%s';\n",NumSecuInfo,Archivo_Afectado1) >> Actualiza_Cabecera
		     Error=1
		  }
		     printf("INSERT INTO FAD_CTLERRIMPRE (NUM_SECUINFO,NOM_ARCHIVO,GLS_ERROR,COD_TIPIMPRES,COD_CLIENTE,TOT_CORRECTO,TOT_ERRONEO) VALUES (%ld,'%s','El Total de Trafico Roaming del Archivo de Detalle de Llamadas No Coincide Con Total del Ciclo de Facturacion',3,0,%9ld,%9ld);\n",NumSecuInfo, Archivo_Afectado2,tot_troaming_data[archivo],tot_troaming_file[archivo]) >> Inserta_Errores
		}
		if (tot_tcarrier_data[archivo] != tot_tcarrier_file[archivo])
		{
		  if (Error==0){
		     printf("UPDATE FAD_CTLIMPRES SET COD_ESTADO=1 WHERE NUM_SECUINFO= %ld AND NOM_ARCHIVO='%s';\n",NumSecuInfo,Archivo_Afectado1) >> Actualiza_Cabecera
		     Error=1
		  }
		     printf("INSERT INTO FAD_CTLERRIMPRE (NUM_SECUINFO,NOM_ARCHIVO,GLS_ERROR,COD_TIPIMPRES,COD_CLIENTE,TOT_CORRECTO,TOT_ERRONEO) VALUES (%ld,'%s','El Total de Trafico Carrier del Archivo de Detalle de Llamadas No Coincide Con Total del Ciclo de Facturacion',3,0,%9ld,%9ld);\n",NumSecuInfo, Archivo_Afectado2,tot_tcarrier_data[archivo],tot_tcarrier_file[archivo]) >> Inserta_Errores
		}
		if (tot_tespeciales_data[archivo] != tot_tespeciales_file[archivo])
		{
		  if (Error==0){
		     printf("UPDATE FAD_CTLIMPRES SET COD_ESTADO=1 WHERE NUM_SECUINFO= %ld AND NOM_ARCHIVO='%s';\n",NumSecuInfo,Archivo_Afectado1) >> Actualiza_Cabecera
		     Error=1
		  }
  		     printf("INSERT INTO FAD_CTLERRIMPRE (NUM_SECUINFO,NOM_ARCHIVO,GLS_ERROR,COD_TIPIMPRES,COD_CLIENTE,TOT_CORRECTO,TOT_ERRONEO) VALUES (%ld,'%s','El Total de Trafico Especiales del Archivo de Detalle de Llamadas No Coincide Con Total del Ciclo de Facturacion',3,0,%9ld,%9ld);\n",NumSecuInfo, Archivo_Afectado2,tot_tespeciales_data[archivo],tot_tespeciales_file[archivo]) >> Inserta_Errores
		}

	}
	printf("COMMIT WORK;\n") >> Actualiza_Cabecera
	printf("QUIT;\n") >> Actualiza_Cabecera
	printf("COMMIT WORK;\n") >> Inserta_Errores
	printf("QUIT;\n") >> Inserta_Errores
}
