BEGIN{
#
    Arr_Ind=split(FILENAME,Arr_File,"/")
    Archivo_Totales=Arr_File[Arr_Ind]
#    
    Index_Punto= index(Archivo_Totales,".")
    FileName_Base=substr(Archivo_Totales,1,(Index_Punto>0?Index_Punto-1:99999))
#    
    FileName_Totales=(szDirDat == "" ? "LLAMADAS.tot" : szDirDat "/" "LLAMADAS.tot")
    FileName_Cliente=(szDirDat == "" ? "LLAMADAS.cli" : szDirDat "/" "LLAMADAS.cli")
    FileName_Errores=(szDirDat == "" ? "LLAMADASerr.sql" : szDirDat "/" "LLAMADASerr.sql")

    Largo_RT    =  150
    TOTAL_ARCHIVO_CLIENTES  =0
    TOTAL_ARCHIVO_LOCALES   =0
    TOTAL_ARCHIVO_INTERZONA =0
    TOTAL_ARCHIVO_ESPECIALCN=0
    TOTAL_ARCHIVO_ESPECIALSN=0
    TOTAL_ARCHIVO_LDI       =0
    TOTAL_ARCHIVO_ROAMING   =0
    
}
{
    Tipo_Registro=substr($0,1,3)
    if ( Tipo_Registro == "D01" )
    {
        if (NR>1){
           if (RD1_cod_cliente>0) {
              printf("%10ld|%10ld|%-250.250s|%-11.11s|%-70.70s|%-6.6s|%11s|%11s|%11s\n",NumSecuInfo,RD1_cod_cliente,FILENAME,\
                      RD1_rut_cliente,RD1_nom_cliente,RD1_cod_despacho,RD1_per_desde,RD1_per_hasta,RD1_fec_emision) >> FileName_Cliente
           }
           Valida_Total_Detalle("Error de Cuadratura entre Detalle y SubTotal de LLamadas Locales"       ,RD1_cod_cliente,acumdet_locales   ,subtotal_locales)
           Valida_Total_Detalle("Error de Cuadratura entre Detalle y SubTotal de Llamadas Interzona"     ,RD1_cod_cliente,acumdet_interzona ,subtotal_interzona)
           Valida_Total_Detalle("Error de Cuadratura entre Detalle y SubTotal de Llamadas Especiales C/N",RD1_cod_cliente,acumdet_especialCN,subtotal_especialCN)
           Valida_Total_Detalle("Error de Cuadratura entre Detalle y SubTotal de Llamadas Especiales S/N",RD1_cod_cliente,acumdet_especialSN,subtotal_especialSN)
           Valida_Total_Detalle("Error de Cuadratura entre Detalle y SubTotal de Llamadas LDI"           ,RD1_cod_cliente,acumdet_ldi       ,subtotal_ldi)
           Valida_Total_Detalle("Error de Cuadratura entre Detalle y SubTotal de Llamadas Roaming"       ,RD1_cod_cliente,acumdet_roaming   ,subtotal_roaming)

#           Valida_Total_Detalle("Error de Cuadratura entre SubTotal y Total de LLamadas Locales"       ,RD1_cod_cliente,subtotal_locales   ,total_locales)
#           Valida_Total_Detalle("Error de Cuadratura entre SubTotal y Total de Llamadas Interzona"     ,RD1_cod_cliente,subtotal_interzona ,total_interzona)
#           Valida_Total_Detalle("Error de Cuadratura entre SubTotal y Total de Llamadas Especiales C/N",RD1_cod_cliente,subtotal_especialCN,total_especialCN )
#           Valida_Total_Detalle("Error de Cuadratura entre SubTotal y Total de Llamadas Especiales S/N",RD1_cod_cliente,subtotal_especialSN,total_especialSN)
#           Valida_Total_Detalle("Error de Cuadratura entre SubTotal y Total de Llamadas LDI"           ,RD1_cod_cliente,subtotal_ldi       ,total_ldi)
#           Valida_Total_Detalle("Error de Cuadratura entre SubTotal y Total de Llamadas Roaming"       ,RD1_cod_cliente,subtotal_roaming   ,total_roaming)

           Valida_Total_Detalle("Error de Cuadratura entre Detalle Total Cliente y Sub Total Cliente"  ,RD1_cod_cliente,ACUMULA_DETALLE    ,ACUMULA_SUBTOTAL)
           Valida_Total_Detalle("Error de Cuadratura entre SubTotal y Total Cliente "                  ,RD1_cod_cliente,ACUMULA_SUBTOTAL   ,ACUMULA_TOTAL)

        }

        ###########################################################################################################
        # Descripcion del Registro  :         Cabecera                                                            #
        ###########################################################################################################
                                
        RD1_tipo_reg             = substr($0,1,3)
        RD1_cod_cliente          = substr($0,4,8)
        RD1_rut_cliente          = substr($0,12,11)
        RD1_nom_cliente          = substr($0,23,70)
        RD1_cod_despacho         = substr($0,93,6)
        RD1_per_desde            = substr($0,99,11)
        RD1_per_hasta            = substr($0,110,11)
        RD1_fec_emision          = substr($0,121,11)

        ###########################################################################################################
        #   Totalizadores para el archivo final
        ###########################################################################################################
        TOTAL_ARCHIVO_CLIENTES   ++
        TOTAL_ARCHIVO_LOCALES    += round(total_locales)
        TOTAL_ARCHIVO_INTERZONA  += round(total_interzona) 
        TOTAL_ARCHIVO_ESPECIALCN += round(total_especialCN)
        TOTAL_ARCHIVO_ESPECIALSN += round(total_especialSN)
        TOTAL_ARCHIVO_LDI        += round(total_ldi)
        TOTAL_ARCHIVO_ROAMING    += round(total_roaming)
        
        ###########################################################################################################
        #   Inicializacion de Acumuladores por Cliente
        ###########################################################################################################
        acumdet_locales    =0
        acumdet_interzona  =0
        acumdet_especialCN =0
        acumdet_especialSN =0
        acumdet_ldi        =0
        acumdet_roaming    =0

        subtotal_locales   =0  
        subtotal_interzona =0   
        subtotal_especialCN=0 
        subtotal_especialSN=0 
        subtotal_ldi       =0 
        subtotal_roaming   =0 

        total_locales      =0
        total_interzona    =0
        total_especialCN   =0
        total_especialSN   =0
        total_ldi          =0
        total_roaming      =0

        ACUMULA_DETALLE    =0
        ACUMULA_SUBTOTAL   =0
        ACUMULA_TOTAL      =0
        ###########################################################################################################
        Valida_Total_Detalle("Error de Formato en el Registro de Cabezera del Detalle", RD1_cod_cliente, Largo_RT, length($0))
        ###########################################################################################################

        next
    }
    
    if ( Tipo_Registro == "D02" )
    {
        RD2_tipo_reg            = substr($0,1,3)
        RD2_des_agrupa          = substr($0,4,50)
        ###########################################################################################################
        Valida_Total_Detalle("Error de Formato en el Registro de Agrupacion de Llamadas", RD1_cod_cliente, Largo_RT, length($0))
        ###########################################################################################################

        next

    }

    if ( Tipo_Registro == "D03" )
    {
        RD3_tipo_reg              = substr($0,1,3)
        RD3_tip_llamada           = substr($0,4,3)
        RD3_num_abonado           = substr($0,7,8)
        RD3_num_celular           = substr($0,15,10)
        RD3_cod_operador          = substr($0,25,5)
        RD3_num_destino           = substr($0,30,20)
        RD3_local_destino         = substr($0,50,20)
        RD3_fec_llamada           = substr($0,70,10)
        RD3_hora_llamada          = substr($0,80,8)
        RD3_ind_estsal            = substr($0,88,1)
        RD3_tip_horario           = substr($0,89,1)
        RD3_dur_llamada           = substr($0,90,14)
        RD3_valor_neto            = str_to_int(substr($0,104,15))
           
        ###########################################################################################################
        Valida_Total_Detalle("Error de Formato en el Registro de Detalle de Llamadas", RD1_cod_cliente, Largo_RT, length($0))
        ###########################################################################################################

        if (RD3_tip_llamada == "T01")   acumdet_locales    += RD3_valor_neto
        if (RD3_tip_llamada == "T02")   acumdet_interzona  += RD3_valor_neto
        if (RD3_tip_llamada == "T03")   acumdet_especialCN += RD3_valor_neto
        if (RD3_tip_llamada == "T04")   acumdet_especialSN += RD3_valor_neto
        if (RD3_tip_llamada == "T05")   acumdet_ldi        += RD3_valor_neto
        if (RD3_tip_llamada == "T06")   acumdet_roaming    += RD3_valor_neto
        
        ACUMULA_DETALLE += RD3_valor_neto
        next

    }
    
    if ( Tipo_Registro == "D04" )
    {
        RD4_tipo_reg             = substr($0,1,3)
        RD4_tip_llamada          = substr($0,4,3)
        RD4_num_celular          = substr($0,7,10)
        RD4_des_subtotal         = substr($0,17,50)
        RD4_dur_llamada          = substr($0,67,14)
        RD4_valor_neto           = str_to_int(substr($0,81,15))
        RD4_num_llamadas         = str_to_int(substr($0,96,15))

        if (RD4_tip_llamada == "T01")   subtotal_locales    += RD4_valor_neto
        if (RD4_tip_llamada == "T02")   subtotal_interzona  += RD4_valor_neto
        if (RD4_tip_llamada == "T03")   subtotal_especialCN += RD4_valor_neto
        if (RD4_tip_llamada == "T04")   subtotal_especialSN += RD4_valor_neto
        if (RD4_tip_llamada == "T05")   subtotal_ldi        += RD4_valor_neto
        if (RD4_tip_llamada == "T06")   subtotal_roaming    += RD4_valor_neto

        ###########################################################################################################
        Valida_Total_Detalle("Error de Formato en el Registro del Sub-total de Llamadas", RD1_cod_cliente, Largo_RT, length($0))
        ###########################################################################################################

        ACUMULA_SUBTOTAL += RD4_valor_neto
        next
    }

    if ( Tipo_Registro == "D05" )
    {
        RD5_tipo_reg             = substr($0,1,3)
        RD5_tip_llamada          = substr($0,4,3)
        RD5_num_celular          = substr($0,7,10)
        RD5_des_subtotal         = substr($0,17,50)
        RD5_dur_llamada          = substr($0,67,14)
        RD5_valor_neto           = str_to_int(substr($0,81,15))
        RD5_num_llamadas         = str_to_int(substr($0,96,15))

        ###########################################################################################################
        Valida_Total_Detalle("Error de Formato en el Registro del Total de Llamadas", RD1_cod_cliente, Largo_RT, length($0))
        ###########################################################################################################

        if (RD5_tip_llamada == "T01")   total_locales    += RD5_valor_neto
        if (RD5_tip_llamada == "T02")   total_interzona  += RD5_valor_neto
        if (RD5_tip_llamada == "T03")   total_especialCN += RD5_valor_neto
        if (RD5_tip_llamada == "T04")   total_especialSN += RD5_valor_neto
        if (RD5_tip_llamada == "T05")   total_ldi        += RD5_valor_neto
        if (RD5_tip_llamada == "T06")   total_roaming    += RD5_valor_neto

        ACUMULA_TOTAL  += RD5_valor_neto
        next
    }

}
END {

        Valida_Total_Detalle("Error de Cuadratura entre Detalle y SubTotal de LLamadas Locales"       ,RD1_cod_cliente,acumdet_locales   ,subtotal_locales)
        Valida_Total_Detalle("Error de Cuadratura entre Detalle y SubTotal de Llamadas Interzona"     ,RD1_cod_cliente,acumdet_interzona ,subtotal_interzona)
        Valida_Total_Detalle("Error de Cuadratura entre Detalle y SubTotal de Llamadas Especiales C/N",RD1_cod_cliente,acumdet_especialCN,subtotal_especialCN)
        Valida_Total_Detalle("Error de Cuadratura entre Detalle y SubTotal de Llamadas Especiales S/N",RD1_cod_cliente,acumdet_especialSN,subtotal_especialSN)
        Valida_Total_Detalle("Error de Cuadratura entre Detalle y SubTotal de Llamadas LDI"           ,RD1_cod_cliente,acumdet_ldi       ,subtotal_ldi)
        Valida_Total_Detalle("Error de Cuadratura entre Detalle y SubTotal de Llamadas Roaming"       ,RD1_cod_cliente,acumdet_roaming   ,subtotal_roaming)
        
#        Valida_Total_Detalle("Error de Cuadratura entre SubTotal y Total de LLamadas Locales"       ,RD1_cod_cliente,subtotal_locales   ,total_locales)
#        Valida_Total_Detalle("Error de Cuadratura entre SubTotal y Total de Llamadas Interzona"     ,RD1_cod_cliente,subtotal_interzona ,total_interzona)
#        Valida_Total_Detalle("Error de Cuadratura entre SubTotal y Total de Llamadas Especiales C/N",RD1_cod_cliente,subtotal_especialCN,total_especialCN )
#        Valida_Total_Detalle("Error de Cuadratura entre SubTotal y Total de Llamadas Especiales S/N",RD1_cod_cliente,subtotal_especialSN,total_especialSN)
#        Valida_Total_Detalle("Error de Cuadratura entre SubTotal y Total de Llamadas LDI"           ,RD1_cod_cliente,subtotal_ldi       ,total_ldi)
#        Valida_Total_Detalle("Error de Cuadratura entre SubTotal y Total de Llamadas Roaming"       ,RD1_cod_cliente,subtotal_roaming   ,total_roaming)
        
        Valida_Total_Detalle("Error de Cuadratura entre Detalle Total Cliente y Sub Total Cliente"  ,RD1_cod_cliente,ACUMULA_DETALLE    ,ACUMULA_SUBTOTAL)
        Valida_Total_Detalle("Error de Cuadratura entre SubTotal y Total Cliente "                  ,RD1_cod_cliente,ACUMULA_SUBTOTAL   ,ACUMULA_TOTAL)
        
        if (RD1_cod_cliente > 0){
            printf("%10ld|%10ld|%-250.250s|%-11.11s|%-70.70s|%-6.6s|%11s|%11s|%11s\n",NumSecuInfo,RD1_cod_cliente,FILENAME,\
                    RD1_rut_cliente,RD1_nom_cliente,RD1_cod_despacho,RD1_per_desde,RD1_per_hasta,RD1_fec_emision) >> FileName_Cliente
        }

        printf("%10ld|%-250.250s|%10ld|%15.f|%15.f|%15.f|%15.f|%15.f\n" , NumSecuInfo, FILENAME, TOTAL_ARCHIVO_CLIENTES, \
               TOTAL_ARCHIVO_LOCALES, TOTAL_ARCHIVO_INTERZONA,(TOTAL_ARCHIVO_ESPECIALCN+TOTAL_ARCHIVO_ESPECIALSN),TOTAL_ARCHIVO_LDI,TOTAL_ARCHIVO_ROAMING) >> FileName_Totales



        if (Archivo_Error==1){
            Archivo_Afectado1=FILENAME
            gsub(" ","",Archivo_Afectado1)
		    printf("UPDATE FAD_CTLIMPRES SET COD_ESTADO=1 WHERE NUM_SECUINFO= %ld AND NOM_ARCHIVO='%s';\n",NumSecuInfo,Archivo_Afectado1) >> FileName_Errores
        } 

}

function str_to_int ( numero_aux)
{
    Numero=Regula_Espacios(numero_aux)

    Elementos = split(Numero,Arreglo,".")
    Variable=""
    for (x=1;x<=Elementos;x++){
        if (x>1)
           Variable = Variable Arreglo[x]
        else
           Variable= Arreglo[x]
    }       

    pos=index(Variable,"-")
    _numero_aux = substr(Variable,pos)
    return _numero_aux
}

function round ( numero_aux)
{
    return int(numero_aux+0.5)
}


function  Valida_Total_Detalle ( _string , _cliente, _total, _detalle)
{
    if (round(_total) != round(_detalle) )
    {
        #gsub(" ","",_string)        
        printf("INSERT INTO FAD_CTLERRIMPRE (NUM_SECUINFO,NOM_ARCHIVO,GLS_ERROR,COD_TIPIMPRES,COD_CLIENTE,TOT_CORRECTO,TOT_ERRONEO) VALUES (%ld,'%s','%s',3,%ld,%9ld,%9ld);\n",NumSecuInfo, Archivo_Totales,_string,_cliente,round(_total),round(_detalle)) >> FileName_Errores
        
    }
}

function  Regula_Espacios ( _string)
{
 #Transforma cadena de tipo: "xx           xx1     xx2     "
 #                   a tipo: "xx xx1 xx2"

    Elementos = split(_string,Arreglo," ")
    Variable=""
    for (x=1;x<=Elementos;x++){
        if (x>1)
              Variable = Variable " " Arreglo[x]
        else
           Variable= Arreglo[x]
    }       
    return (Variable)
}
