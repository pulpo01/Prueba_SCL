BEGIN {
    FS="|"
    arch_1= FILENAME
    Actualiza_Cabecera=(szDirDat == "" ? "Resumen_Act.sql" : szDirDat "/Resumen_Act.sql")
    Inserta_Errores=(szDirDat == "" ? "Resumen_Ins.sql" : szDirDat "/Resumen_Ins.sql")
    printf("") > Actualiza_Cabecera
    printf("") > Inserta_Errores
    printf("set feedback off \n") > Actualiza_Cabecera
    printf("set feedback off \n") > Inserta_Errores
    
}
{
	if (arch_1 == FILENAME )
	{
		tot_clientes_file[$2]   =$3
		tot_saldoant_file[$2]   =$4
		tot_cuotas_file[$2]     =$5		
		tot_facturado_file[$2]  =$6
		tot_pagar_file[$2]      =$8
		NombreArchivo[$2]       =0
	}
	else
	{
		tot_clientes_data[$2]   =$3
		tot_saldoant_data[$2]   =$4
		tot_cuotas_data[$2]     =$5		
		tot_facturado_data[$2]  =$6
		tot_pagar_data[$2]      =$8
	}
}
END {
	for (archivo in tot_clientes_file)
	{
        Arr_Ind=split(archivo,Arr_File,"/")
        Archivo_Afectado2=Arr_File[Arr_Ind]
        gsub(" ","",Archivo_Afectado2)
		# COMPARACION DE CAMPOS DE ARCHIVOS
		if (tot_clientes_data[archivo] != tot_clientes_file[archivo])
		{
		  printf("INSERT INTO FAD_CTLERRIMPRE (NUM_SECUINFO,NOM_ARCHIVO,GLS_ERROR,COD_TIPIMPRES,COD_CLIENTE,TOT_CORRECTO,TOT_ERRONEO) VALUES (%ld,'%s','El Total de Clientes de Archivo de Resumen de Consumos No Coincide con el Total de Ciclo de Facturacion',2,0,%9ld,%9ld);\n",NumSecuInfo, Archivo_Afectado2,tot_clientes_data[archivo],tot_clientes_file[archivo]) >> Inserta_Errores
		  NombreArchivo[archivo]=1
		}
		if (tot_saldoant_data[archivo] != tot_saldoant_file[archivo])
		{
		  printf("INSERT INTO FAD_CTLERRIMPRE (NUM_SECUINFO,NOM_ARCHIVO,GLS_ERROR,COD_TIPIMPRES,COD_CLIENTE,TOT_CORRECTO,TOT_ERRONEO) VALUES (%ld,'%s','El Total de Saldo Anterior de Archivo de Resumen de Consumos No Coincide con el Total de Ciclo de Facturacion',2,0,%9ld,%9ld);\n",NumSecuInfo, Archivo_Afectado2,tot_saldoant_data[archivo],tot_saldoant_file[archivo]) >> Inserta_Errores
		  NombreArchivo[archivo]=1
		}
		if (tot_cuotas_data[archivo] != tot_cuotas_file[archivo])
		{
		  printf("INSERT INTO FAD_CTLERRIMPRE (NUM_SECUINFO,NOM_ARCHIVO,GLS_ERROR,COD_TIPIMPRES,COD_CLIENTE,TOT_CORRECTO,TOT_ERRONEO) VALUES (%ld,'%s','El Numero de Total de Cuotas de Archivo de Resumen de Consumos No Coincide con el Total de Ciclo de Facturacion',2,0,%9ld,%9ld);\n",NumSecuInfo, Archivo_Afectado2,tot_cuotas_data[archivo],tot_cuotas_file[archivo]) >> Inserta_Errores
		  NombreArchivo[archivo]=1
		}
		if (tot_facturado_data[archivo] != tot_facturado_file[archivo])
		{
		  printf("INSERT INTO FAD_CTLERRIMPRE (NUM_SECUINFO,NOM_ARCHIVO,GLS_ERROR,COD_TIPIMPRES,COD_CLIENTE,TOT_CORRECTO,TOT_ERRONEO) VALUES (%ld,'%s','El Total Facturado de Archivo de Resumen de Consumos No Coincide con el Total de Ciclo de Facturacion',2,0,%9ld,%9ld);\n",NumSecuInfo, Archivo_Afectado2,tot_facturado_data[archivo],tot_facturado_file[archivo]) >> Inserta_Errores
		  NombreArchivo[archivo]=1
		}
		if (tot_pagar_data[archivo] != tot_pagar_file[archivo])
		{
		  printf("INSERT INTO FAD_CTLERRIMPRE (NUM_SECUINFO,NOM_ARCHIVO,GLS_ERROR,COD_TIPIMPRES,COD_CLIENTE,TOT_CORRECTO,TOT_ERRONEO) VALUES (%ld,'%s','El Total de a Pagarl del Archivo de Resumen de Consumos No Coincide con el Total de Ciclo de Facturacion',2,0,%9ld,%9ld);\n",NumSecuInfo, Archivo_Afectado2,tot_pagar_data[archivo],tot_pagar_file[archivo]) >> Inserta_Errores
		  NombreArchivo[archivo]=1
		}

	}
	for (archivo in NombreArchivo)
	{
	    if (NombreArchivo[archivo]==1){
          Archivo_Afectado1=archivo
          gsub(" ","",Archivo_Afectado1)
		  printf("UPDATE FAD_CTLIMPRES SET COD_ESTADO=1 WHERE NUM_SECUINFO= %ld AND NOM_ARCHIVO='%s';\n",NumSecuInfo,Archivo_Afectado1) >> Actualiza_Cabecera
	    }    
	}
	printf("COMMIT WORK;\n") >> Actualiza_Cabecera
	printf("QUIT;\n") >> Actualiza_Cabecera
	printf("COMMIT WORK;\n") >> Inserta_Errores
	printf("QUIT;\n") >> Inserta_Errores
}
