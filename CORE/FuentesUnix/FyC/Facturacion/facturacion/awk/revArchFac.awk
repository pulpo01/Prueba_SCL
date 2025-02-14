BEGIN {
    LARGO_FACTURA   = 48
    Archivo_Totales = FILENAME
    Archivo_Salida  = "Total_Facturacion.txt"
    TOT_FACTURA     = 0
    Total_Clientes  = 0
    Archivo_Erroneo = 0
#
    Arr_Ind=split(FILENAME,Arr_File,"/")
    Archivo_Totales=Arr_File[Arr_Ind]
#    
    Index_Punto= index(Archivo_Totales,".")
    FileName_Base=substr(Archivo_Totales,1,(Index_Punto>0?Index_Punto-1:99999))
#    
    FileName_Totales=(szDirDat == "" ? "FACTURAS.tot" : szDirDat "/" "FACTURAS.tot")
    FileName_Cliente=(szDirDat == "" ? "FACTURAS.cli" : szDirDat "/" "FACTURAS.cli")
    FileName_Errores=(szDirDat == "" ? "FACTURASerr.sql" : szDirDat "/" "FACTURASerr.sql")
    FileName_Direcci=(szDirDat == "" ? "FACTURAS.dir" : szDirDat "/" "FACTURAS.dir")
}
{
    Linea_Factur = NR % LARGO_FACTURA 

###################################################################################################
    if ( Linea_Factur == 1 )
    {
# Inicializa Variables de Acumulacion
    Error = 0
    Val_Conceptos = 0
    Tot_Conceptos = 0
    if (Cod_Cliente > 0)
       printf("%10ld|%s|%s\n", Cod_Cliente,Regula_Espacios(Dir_Cliente),Regula_Espacios(Ciu_Cliente)) >> FileName_Direcci
    }
###################################################################################################
#    Registro de Fecha
#
    if ( Linea_Factur == 2)
    {
        Fec_Emision = substr($0,48,11)
        gsub(/DIC/,"12",Fec_Emision)
    }
#   
###################################################################################################
#    Registro de Cliente 
#
    if ( Linea_Factur == 4)
    {
        Num_FolioCTC = substr($0,31,11)
        Cod_Cliente  = substr($0,50,11)
    }
#
###################################################################################################
#    Registro de Rut del Cliente 
#
    if ( Linea_Factur == 14)
    {
        Rut_Cliente = substr($0,19,11)
        Dir_Cliente = substr($0,51)
        if ( Rut_Cliente == "           " )
        {
            printf(" Error ::    Rut Nulo Cliente  %9d     \n",Cod_Cliente)
            Error=1
        }
    }
#
#
    if ( Linea_Factur == 15)
    {
        Ciu_Cliente = substr($0,51)
    }
#
###################################################################################################
#    Acumulacion de Conceptos
#
    if ( Linea_Factur >= 19 && Linea_Factur <=36 )
    {
        Val_Conceptos   = str_to_int(substr($0,83))
        Tot_Conceptos  += Val_Conceptos
    }
#
###################################################################################################
#    Lectura del Registro Totalizador  
#
    if ( Linea_Factur == 37 )
    {
       if ( NF == 1 )  # Doc.  Exento o Boleta  / Sin Subtotales
       {
            Total_Factura      = str_to_int($1)
            Total_Factura_Aux  = str_to_int($1)

       }
       else
       {
            Total_Afecto       = str_to_int($1)
            Total_Iva          = str_to_int($2)
            Total_Exento       = str_to_int($3)
            Total_Factura      = str_to_int($4)
            Total_Factura_Aux  = Total_Afecto  + Total_Iva + Total_Exento  

            if (Total_Iva > 0){
               Monto = int((Total_Afecto * 0.18) + 0.5)
               if (Total_Iva != Monto){
                  #Registrar cliente con error
                  Archivo_Erroneo=1
                  Archivo_Afectado2=Archivo_Totales
                  gsub(" ","",Archivo_Afectado2)
		          printf("INSERT INTO FAD_CTLERRIMPRE (NUM_SECUINFO,NOM_ARCHIVO,GLS_ERROR,COD_TIPIMPRES,COD_CLIENTE,TOT_CORRECTO,TOT_ERRONEO) VALUES (%ld,'%s','El Monto IVA en Factura No Corresponde al Neto * 18 por ciento',1,%ld,%9ld,%9ld);\n",NumSecuInfo, Archivo_Afectado2,Cod_Cliente,Total_Iva,Monto) >> FileName_Errores
               } 
            }
       }
       SUM_AFECTO   += Total_Afecto 
       SUM_EXENTO   += Total_Exento 
       SUM_IVA      += Total_Iva    
       TOT_FACTURA  += Total_Factura
#       
       Total_Clientes++
       if (Cod_Cliente>0)
          printf("%10ld|%15ld|%10ld|%-250.250s\n",Cod_Cliente,Total_Factura_Aux,NumSecuInfo,FILENAME) >> FileName_Cliente
       
    }
#
###################################################################################################
#    Validacion de Totales
#
    if ( Linea_Factur == 47 )
    {
        Valida_Total_Detalle("Error de cuadratura entre el Total y la Suma de Conceptos",Cod_Cliente,Tot_Conceptos,Total_Factura)
        Valida_Total_Detalle("Error de cuadratura entre el Subtotal y Total deL Documento",Cod_Cliente,Total_Factura_Aux,Total_Factura)
        if ( Total_Factura < 0 )
            Valida_Total_Detalle("Error de cuadratura.El Total del Documento es Negativo",Cod_Cliente,Total_Factura,0)
    }
}
#
END  {
       printf("%10ld|%-250.250s|%10ld|%15.f\n" , NumSecuInfo, FILENAME, Total_Clientes,TOT_FACTURA) >> FileName_Totales
       if (Cod_Cliente > 0)
          printf("%10ld|%s|%s\n", Cod_Cliente,Regula_Espacios(Dir_Cliente),Regula_Espacios(Ciu_Cliente)) >> FileName_Direcci
       
       if (Archivo_Erroneo == 1){
          # Registrar archivo con error
          Archivo_Afectado1=FILENAME
          gsub(" ","",Archivo_Afectado1)
		  printf("UPDATE FAD_CTLIMPRES SET COD_ESTADO=1 WHERE NUM_SECUINFO= %ld AND NOM_ARCHIVO='%s';\n",NumSecuInfo,Archivo_Afectado1) >> FileName_Errores
       }
}

#
###################################################################################################
#    Convierte un String en Numero
#
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

    return (_numero_aux)
}

#
###################################################################################################
#    Validacion de Totales
#
function  Valida_Total_Detalle ( _string , _cliente, _total, _detalle)
{
    if (_total != _detalle )
    {
        Archivo_Erroneo=1
        printf("INSERT INTO FAD_CTLERRIMPRE (NUM_SECUINFO,NOM_ARCHIVO,GLS_ERROR,COD_TIPIMPRES,COD_CLIENTE,TOT_CORRECTO,TOT_ERRONEO) VALUES (%ld,'%s','%s',1,%ld,%9ld,%9ld);\n",NumSecuInfo, Archivo_Totales,_string,_cliente,_total,_detalle) >> FileName_Errores
        #printf("%10ld|%-28.28s %10.f %10.f|%10d|%-50.50s\n", _cliente,_string,_total, _detalle,NumSecuInfo, Archivo_Totales) >> FileName_Errores
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

