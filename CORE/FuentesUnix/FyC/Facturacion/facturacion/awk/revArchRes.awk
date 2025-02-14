 ############################################################################################################################
 #       Procesador  :   revArchRes.awk
 #       Autor       :   M. Villagra
 #       Procesa los archivos de resumenes de pago generados en el modulo de facturacion generando un archivo formateando
 #       la salida con titulos para mayor visualizacion de los datos.
 #       Valida la cuadratura de los los montos y minutos reportando los errores al final de cada cliente.
 ############################################################################################################################
BEGIN{
#    
    Arr_Ind=split(FILENAME,Arr_File,"/")
    Archivo_Totales=Arr_File[Arr_Ind]
    Index_Punto= index(Archivo_Totales,".")
    FileName_Base=substr(Archivo_Totales,1,(Index_Punto>0?Index_Punto-1:99999))
    FileName_Totales=(szDirDat == "" ? "RESUMEN.tot" : szDirDat "/" "RESUMEN.tot")
    FileName_Cliente=(szDirDat == "" ? "RESUMEN.cli" : szDirDat "/" "RESUMEN.cli")
    FileName_Direcci=(szDirDat == "" ? "RESUMEN.dir" : szDirDat "/" "RESUMEN.dir")
    FileName_Errores=(szDirDat == "" ? "RESUMENerr.sql" : szDirDat "/" "RESUMENerr.sql")
#    
    Total_Clientes=0
    Largo_Reg   =  150
#    
    TOTAL_SALDO_ANT           =0
    TOTAL_CUOTAS              =0
    TOTAL_CARGOS_FACTURADOS   =0
    TOTAL_CARGOS_NOFACTURADOS =0
    TOTAL_PAGAR               =0
    Archivo_Error=0
}
{
    Id_Registro=substr($0,1,1)

    if (Id_Registro == "A")  {

        Tipo_Registro=substr($0,1,3)
        if ( Tipo_Registro == "A01" ) {  
            ###########################################################################################################
            #    VALIDACION DE TOTALES DE RESUMEN ANTES DE LEER EL SIGUIENTE REGISTRO
            ###########################################################################################################
    
            Valida_Total_Detalle("Error de Cuadratura entre Total a Pagar y Total de Cargos Mes, Saldo Ant. y Cuotas (A01)",   \
                                    R1_Cod_Clie, R1_Total_Pagar,  (R1_Total_Mes+R1_Saldo_Anterior+R1_Total_Cuotas))

            Valida_Total_Detalle("Error de Cuadratura entre Total del Mes (A01) y Total de Cargos Facturados (A09)", \
                                    R1_Cod_Clie, R1_Total_Mes,  R9_Val_Monto )

            Valida_Total_Detalle("Error de Cuadratura entre Total del Mes (A01) y Total de Cargos Facturados (A10)", \
                                    R1_Cod_Clie, R1_Total_Mes,  R10_Tot_Grupo )

            Valida_Total_Detalle("Error de Cuadratura entre Total Saldo Ant/Cuotas (A01) y Total de Cargos No Facturados (A11)", \
                                    R1_Cod_Clie, (R1_Saldo_Anterior+R1_Total_Cuotas),  R11_Tot_Grupo)

            Valida_Total_Detalle("Error de Cuadratura entre Total Detalle (A09) y Total Facturado (A10)", \
                                    R1_Cod_Clie, R9_Val_Monto, R10_Tot_Grupo )

            Valida_Total_Detalle("Error de Cuadratura entre Total a Pagar (A01) y Total de Cargos Facturados/No Fact.",   \
                                    R1_Cod_Clie, R1_Total_Pagar,  Total_Pagar_Cliente)

            Valida_Total_Detalle("Error de Cuadratura entre Total Facturado (A10) y Total Facturado (B)",  \
                                    R1_Cod_Clie,    R10_Tot_Grupo,       Total_Grupo_Facturado )

            Valida_Total_Detalle("Error de Cuadratura entre Total No Facturado (A11)  y Total No Facturado (B)", \
                                    R1_Cod_Clie,    R11_Tot_Grupo,       Total_Grupo_NoFacturado )

            Valida_Total_Detalle("Error de Cuadratura entre Total a Pagar (A10+A11) y Total de Pagar (S)", \
                                    R1_Cod_Clie,    Total_Pagar_Cliente,   Total_Registro_S1 )

            Valida_Total_Detalle("Error de Cuadratura entre Total a Pagar (A01) y Total a Pagar (S)", \
                                    R1_Cod_Clie,    R1_Total_Pagar,   Total_Registro_S1 )


        
            if (NR > 1){
                if (R1_Cod_Clie > 0){
                    if (R1_Cod_Docum == "02" || R1_Cod_Docum == "40") {
                        printf("%10ld|%11s|%2s|%9s|%6s|%15ld|%15ld|%15ld|%15ld|%10ld|%-250.250s\n", \
                                R1_Cod_Clie,R2_Rut_Clie,R1_Cod_Docum,R1_Num_Folio_Legal,R1_Codigo_Despacho,\
                                R1_Total_Mes,R1_Total_Cuotas,R1_Saldo_Anterior,R1_Total_Pagar,NumSecuInfo,FILENAME) >> FileName_Cliente
                
                        Dir_Cliente = Regula_Espacios(R3_Dir_Legal)
                        ComCiu_Legal = Regula_Espacios(R3_ComCiu_Legal)
        
                        printf("%10ld|%s|%s\n", R1_Cod_Clie,Dir_Cliente,ComCiu_Legal) >> FileName_Direcci
                    }
                }    
            }        
    
            ###########################################################################################################
            # Descripcion del Registro   1  :         Registro de Documento                                           #
            ###########################################################################################################
    
            R1_Cod_Clie                 = Regula_Espacios(substr($0,4,8))
            R1_Cod_Docum                = Regula_Espacios(substr($0,12,2))
            R1_Num_Folio_Legal          = Regula_Espacios(substr($0,14,9))
            R1_Num_Folio_Recaud         = Regula_Espacios(substr($0,23,12))
            R1_Codigo_Despacho          = Regula_Espacios(substr($0,35,6))
            R1_Periodo_desde            = Regula_Espacios(substr($0,41,11))
            R1_Periodo_hasta            = Regula_Espacios(substr($0,52,11))
            R1_Fecha_Emision            = Regula_Espacios(substr($0,63,11))
            R1_Fecha_Vencimien          = Regula_Espacios(substr($0,74,11))
            R1_Total_Mes                = str_to_int(substr($0,85,15))
            R1_Saldo_Anterior           = str_to_int(substr($0,100,15))
            R1_Total_Cuotas             = str_to_int(substr($0,115,15))
            R1_Total_Pagar              = str_to_int(substr($0,130,15))
            R1_Indicador_PAC            = Regula_Espacios(substr($0,145,1))
    

            Verifica_Campos_Validos("Error. No se Registra Numero de Folio para este Cliente",R1_Cod_Clie, R1_Num_Folio_Legal)
            Verifica_Campos_Validos("Error. No se Registra Numero de Folio de Recaud. para este Cliente",R1_Cod_Clie, R1_Num_Folio_Recaud)
            Verifica_Campos_Validos("Error. No se Registra Codigo de Despacho para este Cliente",R1_Cod_Clie, R1_Codigo_Despacho)
            Verifica_Campos_Validos("Error. No se Registra Fecha de Emision para este Cliente",R1_Cod_Clie, R1_Fecha_Emision)
            Verifica_Campos_Validos("Error. No se Registra Fecha de Vencimiento para este Cliente",R1_Cod_Clie, R1_Fecha_Vencimien)
            Verifica_Campos_Validos("Error. No se Registra Indicador de PAC para este Cliente",R1_Cod_Clie, R1_Indicador_PAC)
            ###########################################################################################################
            #    Totalizadores para Archivo de Resumen Total.Res y Total_Resumen.txt
            ###########################################################################################################
            Total_Clientes++
            TOTAL_SALDO_ANT           += R1_Saldo_Anterior
            TOTAL_CUOTAS              += R1_Total_Cuotas
            TOTAL_CARGOS_FACTURADOS   += R1_Total_Mes
            TOTAL_CARGOS_NOFACTURADOS += R1_Saldo_Anterior + R1_Total_Cuotas
            TOTAL_PAGAR               += (R1_Total_Mes + R1_Saldo_Anterior + R1_Total_Cuotas)
            ###########################################################################################################
            # Inicializa  Totalizadores por Cliente
            ###########################################################################################################
            R9_Val_Monto              = 0
            Total_Pagar_Cliente       = 0
            R11_Tot_Grupo             = 0
            TOT_NIVELB1_FACT          = 0
            TOT_NIVELB1_NOFACT        = 0
            TOT_NIVELB2_FACT          = 0
            TOT_NIVELB2_NOFACT        = 0
            TOT_NIVELB3_FACT          = 0
            TOT_NIVELB3_NOFACT        = 0
            Total_Grupo_Facturado     = 0
            Total_Grupo_NoFacturado   = 0
            Total_Registro_S1         = 0
            ###########################################################################################################
    
            ###########################################################################################################
            Valida_Total_Detalle("Error de Formato en el Registro de Documento", R1_Cod_Clie, Largo_Reg, length($0))
            ###########################################################################################################

            next
        }
        if ( Tipo_Registro == "A02" ) {
    
            ###########################################################################################################
            # Descripcion del Registro    2  :        Datos del Cliente                                               #
            ###########################################################################################################
    
            R2_Nom_Clie                  = Regula_Espacios(substr($0,4,90))
            R2_Rut_Clie                  = Regula_Espacios(substr($0,94,11))
            R2_Num_Terminal              = Regula_Espacios(substr($0,106,10))
    
            ###########################################################################################################
            Valida_Total_Detalle("Error de Formato en el Registro de Datos del Cliente", R1_Cod_Clie, Largo_Reg, length($0))
            ###########################################################################################################
            Verifica_Campos_Validos("Error. No se Registra Nombre para este Cliente",R1_Cod_Clie, R2_Nom_Clie)
            Verifica_Campos_Validos("Error. No se Registra Rut para este Cliente",R1_Cod_Clie, R2_Rut_Clie)
    
            next
        }
        if ( Tipo_Registro == "A03" ) {
    
            ###########################################################################################################
            # Descripcion del Registro    3  :        Direccion de Facturacion                                        #
            ###########################################################################################################
    
            R3_Dir_Legal                 = Regula_Espacios(substr($0,4,70))
            R3_ComCiu_Legal              = Regula_Espacios(substr($0,74,60))
    
            ###########################################################################################################
            Valida_Total_Detalle("Error de Formato en el Registro de Direccion de Facturacion", R1_Cod_Clie, Largo_Reg, length($0))
            ###########################################################################################################
            Verifica_Campos_Validos("Error. No se Registra Direccion Legal para este Cliente",R1_Cod_Clie, R3_Dir_Legal)
            Verifica_Campos_Validos("Error. No se Registra Comuna y/o Ciudad para este Cliente",R1_Cod_Clie, R3_ComCiu_Legal)
    
            next
        }
        if ( Tipo_Registro == "A05" ) {
    
            ###########################################################################################################
            # Descripcion del Registro    5  :        Direccion de Correspondencia                                   #
            ###########################################################################################################
    
            R5_Dir_Corresp               = Regula_Espacios(substr($0,4,70))
            R5_ComCiu_Corresp            = Regula_Espacios(substr($0,74,60))
    
            ###########################################################################################################
            Valida_Total_Detalle("Error de Formato en el Registro de Direccion de Correspondencia", R1_Cod_Clie, Largo_Reg, length($0))
            ###########################################################################################################
    
            next
        }
        if ( Tipo_Registro == "A06" ) {
    
            ###########################################################################################################
            # Descripcion del Registro    2  :        Direccion Correspondencia                                       #
            ###########################################################################################################
    
            R6_Obs_Direccion             = Regula_Espacios(substr($0,4,50))
            R6_Cod_Postal                = Regula_Espacios(substr($0,54,30))
            R6_Num_Casilla               = Regula_Espacios(substr($0,84,15))
    
            ###########################################################################################################
            Valida_Total_Detalle("Error de Formato en el Registro de Direccion de Correspondencia", R1_Cod_Clie, Largo_Reg, length($0))
            ###########################################################################################################
    
            next
        }
    
        if ( Tipo_Registro == "A07" ) {
    
            ###########################################################################################################
            # Descripcion del Registro    7  :        Informacion Comercial                                           #
            ###########################################################################################################
    
            R7_Cod_Plan_Tarif            = Regula_Espacios(substr($0,4,3))
            R7_Num_Minutos               = Regula_Espacios(substr($0,7,10))
            R7_Fec_FinContrato           = Regula_Espacios(substr($0,17,10))
    
            ###########################################################################################################
            Valida_Total_Detalle("Error de Formato en el Registro de Informacion Comercial", R1_Cod_Clie, Largo_Reg, length($0))
            ###########################################################################################################
    
            next
        }
    
        if ( Tipo_Registro == "A08" ) {
    
            ###########################################################################################################
            # Descripcion del Registro    8  :        Informacion Consumo                                             #
            ###########################################################################################################
    
            R8_Des_Mes_1                 = Regula_Espacios(substr($0,4,15))
            R8_Des_Mes_2                 = Regula_Espacios(substr($0,39,15))
            R8_Des_Mes_3                 = Regula_Espacios(substr($0,74,15))
    
            ###########################################################################################################
            Valida_Total_Detalle("Error de Formato en el Registro de Informacion de Consumo", R1_Cod_Clie, Largo_Reg, length($0))
            ###########################################################################################################
    
            next
        }
    
        if ( Tipo_Registro == "A09" ) {
    
            ###########################################################################################################
            # Descripcion del Registro      9   :           Total Resumen de Pago Por Concepto                        #
            ###########################################################################################################
    
            R9_Cod_Grupo                 = Regula_Espacios(substr($0,4,5))
            R9_Des_Grupo                 = Regula_Espacios(substr($0,9,50))
            R9_Min_Totales               = str_to_int(substr($0,59,14))
            R9_Tot_Grupo                 = str_to_int(substr($0,73,15))
    
            R9_Val_Monto   += R9_Tot_Grupo
    
            ###########################################################################################################
            Valida_Total_Detalle("Error de Formato en el Registro de Resumen de Pago por Concepto", R1_Cod_Clie, Largo_Reg, length($0))
            ###########################################################################################################
    
            next
        }
    
        if ( Tipo_Registro == "A10" ) {
    
            ###########################################################################################################
            # Descripcion del Registro    10   :           Total Facturado                                            #
            ###########################################################################################################
    
            R10_Des_Grupo                = Regula_Espacios(substr($0,4,50))
            R10_Min_Totales              = str_to_int(substr($0,54,14))
            R10_Tot_Grupo                = str_to_int(substr($0,69,15))
    
            Total_Pagar_Cliente += R10_Tot_Grupo
   
            ###########################################################################################################
            Valida_Total_Detalle("Error de Formato en el Registro del Total de Detalle de Consumo ", R1_Cod_Clie, Largo_Reg, length($0))
            ###########################################################################################################

            next
        }
    
        if ( Tipo_Registro == "A11" ) {
    
            ###########################################################################################################
            # Descripcion del Registro      11   :           Total No Facturado                                        #
            ###########################################################################################################
    
            R11_Des_Grupo                = Regula_Espacios(substr($0,4,50))
            R11_Min_Totales              = str_to_int(substr($0,54,14))
            R11_Tot_Grupo                = str_to_int(substr($0,69,15))
    
            Total_Pagar_Cliente += R11_Tot_Grupo
    
            ##########################################################################################################
            Valida_Total_Detalle("Error en el Formato del Registro de Cargos No Facturados", R1_Cod_Clie, Largo_Reg, length($0))
            ###########################################################################################################
    
            next
        }

        if ( Tipo_Registro == "A99" ) {
    
            ###########################################################################################################
            # Descripcion del Registro      99   :           Bloque de Mensajes                                       #
            ###########################################################################################################
    
            R99_Bloque_1                 = Regula_Espacios(substr($0,4,10))
            R99_Bloque_2                 = Regula_Espacios(substr($0,14,10))
            R99_Bloque_3                 = Regula_Espacios(substr($0,24,10))
            R99_Bloque_4                 = Regula_Espacios(substr($0,34,10))
    
            ##########################################################################################################
            Valida_Total_Detalle("Error en el Formato del Registro de Mensajes.", R1_Cod_Clie, Largo_Reg, length($0))
            ###########################################################################################################
    
            next
        }

    }

    ###################################################################################################################
    # Validacion de registros en niveles B1 - B2 - B3                                                                 #
    ###################################################################################################################
    if (Id_Registro == "B")  {

        Tipo_Registro=substr($0,1,2)
        if ( Tipo_Registro == "B1" ) {
    
            ###########################################################################################################
            # Descripcion del Registro      B1   :           Nivel de Grupo                                           #
            ###########################################################################################################
    
            RB1_Cod_Grupo                = Regula_Espacios(substr($0,4,5))
            RB1_Des_Grupo                = Regula_Espacios(substr($0,9,50))
            RB1_Total_Minutos            = str_to_int(substr($0,59,14))
            RB1_Total_Grupo              = str_to_int(substr($0,73,15))
    
            ##########################################################################################################
            Valida_Total_Detalle("Error en el Formato del Registro a Nivel de Grupo B1.", R1_Cod_Clie, Largo_Reg, length($0))
            ###########################################################################################################
            Pos= index(RB1_Des_Grupo,"CUOTA")
            if (Pos>0) {
                Total_Grupo_NoFacturado += RB1_Total_Grupo
                TOT_NIVELB1_NOFACT += RB1_Total_Grupo
            } else {
                Pos= index(RB1_Des_Grupo,"SALDO")
                if (Pos>0) {
                    Total_Grupo_NoFacturado += RB1_Total_Grupo
                    TOT_NIVELB1_NOFACT += RB1_Total_Grupo
                } else {
                    Total_Grupo_Facturado  += RB1_Total_Grupo        
                    TOT_NIVELB1_FACT += RB1_Total_Grupo
                }
            }

            next
        }

        if ( Tipo_Registro == "B2" ) {
    
            ###########################################################################################################
            # Descripcion del Registro      B2   :           Nivel de Sub-Grupo                                       #
            ###########################################################################################################
    
            RB2_Cod_SubGrupo             = Regula_Espacios(substr($0,3,5))
            RB2_Des_SubGrupo             = Regula_Espacios(substr($0,8,50))
            RB2_Total_SubGrupo           = str_to_int(substr($0,58,15))
            RB2_Total_Minutos            = str_to_int(substr($0,73,14))
            RB2_Num_Unidades             = str_to_int(substr($0,87,7))
    
            ##########################################################################################################
            Valida_Total_Detalle("Error en el Formato del Registro a Nivel de SubGrupo B2.", R1_Cod_Clie, Largo_Reg, length($0))
            ###########################################################################################################
            Pos= index(RB2_Des_SubGrupo,"CUOTA")
            if (Pos>0) {
                Total_Grupo_NoFacturado += RB2_Total_SubGrupo
                TOT_NIVELB2_NOFACT += RB2_Total_SubGrupo
                TOT_NIVELB1_NOFACT += RB2_Total_SubGrupo
            } else {
                Pos= index(RB2_Des_SubGrupo,"SALDO")
                if (Pos>0) {
                    Total_Grupo_NoFacturado += RB2_Total_SubGrupo
                    TOT_NIVELB2_NOFACT += RB2_Total_SubGrupo
                    TOT_NIVELB1_NOFACT += RB2_Total_SubGrupo
                } else {
                    Total_Grupo_Facturado  += RB2_Total_SubGrupo        
                    TOT_NIVELB2_FACT += RB2_Total_SubGrupo
                    TOT_NIVELB1_FACT += RB2_Total_SubGrupo
                }
            }
    
            next
        }
        if ( Tipo_Registro == "B3" ) {
    
            ###########################################################################################################
            # Descripcion del Registro      B2   :           Nivel de Sub-Grupo                                       #
            ###########################################################################################################
    
            RB3_Cod_SubGrupo             = Regula_Espacios(substr($0,3,5))
            RB3_Tipo_SubGrupo            = Regula_Espacios(substr($0,8,2))
    

            if (RB3_Tipo_SubGrupo == "1")  {
        		RB31_Num_abonado         = Regula_Espacios(substr($0,10,8))   
        		RB31_Num_Celular         = Regula_Espacios(substr($0,18,10))
        		RB31_Des_Concepto        = Regula_Espacios(substr($0,28,50))
        		RB31_Tot_Abonado         = str_to_int(substr($0,78,15))
        		RB31_Cod_PlanB           = Regula_Espacios(substr($0,93,5))
        		RB31_Tot_Minutos         = str_to_int(substr($0,98,14))

                Total_Grupo_Facturado  += RB31_Tot_Abonado
                TOT_NIVELB3_FACT       += RB31_Tot_Abonado
                TOT_NIVELB1_FACT       += RB31_Tot_Abonado

            }

            if (RB3_Tipo_SubGrupo == "2")  {
        		RB32_Num_abonado         = Regula_Espacios(substr($0,10,8))   
        		RB32_Num_Celular         = Regula_Espacios(substr($0,18,10))
        		RB32_Des_Concepto        = Regula_Espacios(substr($0,28,50))
        		RB32_Tot_Abonado         = str_to_int(substr($0,78,15))

                Total_Grupo_Facturado  += RB32_Tot_Abonado
                TOT_NIVELB3_FACT       += RB32_Tot_Abonado
                TOT_NIVELB1_FACT       += RB32_Tot_Abonado
            }

            if (RB3_Tipo_SubGrupo == "3")  {
        		RB33_Num_abonado         = Regula_Espacios(substr($0,10,8))   
        		RB33_Num_Celular         = Regula_Espacios(substr($0,18,10))
        		RB33_Des_Concepto        = Regula_Espacios(substr($0,28,50))
        		RB33_Cod_Concepto        = Regula_Espacios(substr($0,78,4))
        		RB33_Tot_Abonado         = str_to_int(substr($0,82,15))
        		RB33_Tot_Minutos         = str_to_int(substr($0,97,14))

                Total_Grupo_Facturado  += RB33_Tot_Abonado
                TOT_NIVELB3_FACT       += RB33_Tot_Abonado
                TOT_NIVELB1_FACT       += RB33_Tot_Abonado
            }

            if (RB3_Tipo_SubGrupo == "4")  {
        		RB34_Num_abonado         = Regula_Espacios(substr($0,10,8))   
        		RB34_Num_Celular         = Regula_Espacios(substr($0,18,10))
        		RB34_Des_Concepto        = Regula_Espacios(substr($0,28,50))
        		RB34_Tot_Abonado         = str_to_int(substr($0,78,15))
        		RB34_Num_Unidades        = Regula_Espacios(substr($0,93,7))
 
                Total_Grupo_Facturado  += RB34_Tot_Abonado
                TOT_NIVELB3_FACT       += RB34_Tot_Abonado
                TOT_NIVELB1_FACT       += RB34_Tot_Abonado
            }

            if (RB3_Tipo_SubGrupo == "5")  {
        		RB35_Num_abonado         = Regula_Espacios(substr($0,10,8))   
        		RB35_Num_Celular         = Regula_Espacios(substr($0,18,10))
        		RB35_Des_Concepto        = Regula_Espacios(substr($0,28,50))
        		RB35_Tot_Abonado         = str_to_int(substr($0,78,15))
        		RB35_Fec_Pago            = Regula_Espacios(substr($0,93,10))
        		RB35_Num_Folio           = Regula_Espacios(substr($0,103,10))

                Total_Grupo_Facturado  += RB35_Tot_Abonado
                TOT_NIVELB3_FACT       += RB35_Tot_Abonado
                TOT_NIVELB1_FACT       += RB35_Tot_Abonado
            }

            if (RB3_Tipo_SubGrupo == "6")  {
        		RB36_Des_Saldo           = Regula_Espacios(substr($0,10,50))   
        		RB36_Tot_Documento       = Regula_Espacios(substr($0,60,15))
        		RB36_Num_Folio           = Regula_Espacios(substr($0,75,10))
        		RB36_Fec_Emision         = str_to_int(substr($0,85,10))

                Total_Grupo_NoFacturado += RB36_Tot_Documento
                TOT_NIVELB3_NOFACT      += RB36_Tot_Documento
                TOT_NIVELB1_NOFACT      += RB36_Tot_Documento
             }

            if (RB3_Tipo_SubGrupo == "7")  {
        		RB37_Tip_Concepto        = Regula_Espacios(substr($0,10,1))   
        		RB37_Des_Cuota           = Regula_Espacios(substr($0,11,50))
        		RB37_Tot_Cuota           = str_to_int(substr($0,61,15))
        		RB37_Num_Cuotas          = Regula_Espacios(substr($0,76,3))
        		RB37_Seq_Cuotas          = Regula_Espacios(substr($0,79,3))
        		RB37_Num_Folio           = Regula_Espacios(substr($0,82,10))
        		RB37_Fec_Emision         = Regula_Espacios(substr($0,92,10))

                Total_Grupo_NoFacturado += RB37_Tot_Cuota
                TOT_NIVELB3_NOFACT      += RB37_Tot_Cuota
                TOT_NIVELB1_NOFACT      += RB37_Tot_Cuota
            }
            
            ##########################################################################################################
            Valida_Total_Detalle("Error en el Formato del Registro a Nivel de Abonados B3.", R1_Cod_Clie, Largo_Reg, length($0))
            ###########################################################################################################

            next
        }

    }

    ###################################################################################################################
    # Validacion de registros de totales S                                                                            #
    ###################################################################################################################
    if (Id_Registro == "S")  {
        
        Tipo_Registro=substr($0,1,2)
        if (Tipo_Registro == "S3" ) {
    		RS3_Des_RegSubtotal          = Regula_Espacios(substr($0,3,50))   
    		RS3_Tot_Transaccion          = str_to_int(substr($0,53,15))
    		RS3_Tot_Minutos              = str_to_int(substr($0,68,14))


            ##########################################################################################################
            Valida_Total_Detalle("Error en el Formato del Registro de Totales S3.", R1_Cod_Clie, Largo_Reg, length($0))
            ###########################################################################################################

            Pos= index(RS3_Des_RegSubtotal,"CUOTA")
            if (Pos>0) {
                Valida_Total_Detalle("Error de Cuadratura entre Total S3 y Total por Nivel Abonado No Facturable", \
                                      R1_Cod_Clie, RS3_Tot_Transaccion,  TOT_NIVELB3_NOFACT)
            } else {
                Valida_Total_Detalle("Error de Cuadratura entre Total S3 y Total por Nivel Abonado Facturable", \
                                          R1_Cod_Clie, RS3_Tot_Transaccion,  TOT_NIVELB3_FACT)
            }
            TOT_NIVELB3_FACT = 0
            TOT_NIVELB3_NOFACT  = 0
            next
        }
        if (Tipo_Registro == "S2" ) {
    		RS2_Des_RegSubtotal          = Regula_Espacios(substr($0,3,50))   
    		RS2_Tot_Transaccion          = str_to_int(substr($0,53,15))
    		RS2_Tot_Minutos              = str_to_int(substr($0,68,14))

            ##########################################################################################################
            Valida_Total_Detalle("Error en el Formato del Registro de Totales S2.", R1_Cod_Clie, Largo_Reg, length($0))
            ###########################################################################################################

            Pos= index(RS2_Des_RegSubtotal,"CUOTA")
            if (Pos>0) {
                Valida_Total_Detalle("Error de Cuadratura entre Total S2 y Total por Nivel de SubGrupo No Facturable", \
                                      R1_Cod_Clie, RS2_Tot_Transaccion,  TOT_NIVELB2_NOFACT)
            } else {
                Valida_Total_Detalle("Error de Cuadratura entre Total S2 y Total por Nivel de SubGrupo Facturable", \
                                      R1_Cod_Clie, RS2_Tot_Transaccion,  TOT_NIVELB2_FACT)
            }
            TOT_NIVELB2_FACT   = 0
            TOT_NIVELB2_NOFACT = 0
            
            next
        }
        if (Tipo_Registro == "S1" ) {
    		RS1_Des_RegTotal             = Regula_Espacios(substr($0,3,50))   
    		RS1_Tot_Transaccion          = str_to_int(substr($0,53,15))
    		RS1_Tot_Minutos              = str_to_int(substr($0,68,14))

            Total_Registro_S1 += RS1_Tot_Transaccion
            ##########################################################################################################
            Valida_Total_Detalle("Error en el Formato del Registro de Totales S1.", R1_Cod_Clie, Largo_Reg, length($0))
            ###########################################################################################################

            Pos= index(RS1_Des_RegTotal,"NO FAC")
            if (Pos>0) {
                Valida_Total_Detalle("Error de Cuadratura entre Total S1 y Total por Nivel de Grupo No Facturable", \
                                      R1_Cod_Clie, RS1_Tot_Transaccion, (TOT_NIVELB1_NOFACT+TOT_NIVELB2_NOFACT+TOT_NIVELB3_NOFACT))
            } else {
                Valida_Total_Detalle("Error de Cuadratura entre Total S1 y Total por Nivel de Grupo Facturable", \
                                      R1_Cod_Clie, RS1_Tot_Transaccion, (TOT_NIVELB1_FACT+TOT_NIVELB2_FACT+TOT_NIVELB3_FACT))
            }
            TOT_NIVELB1_FACT   = 0
            TOT_NIVELB1_NOFACT = 0

            next
        }

    }


}
END {

        ###########################################################################################################
        #    VALIDACION DE TOTALES DE RESUMEN DEL ULTIMO CLIENTE DEL ARCHIVO 
        ###########################################################################################################
    
        Valida_Total_Detalle("Error de Cuadratura entre Total a Pagar y Total de Cargos Mes, Saldo Ant. y Cuotas (A01)",   \
                                R1_Cod_Clie, R1_Total_Pagar,  (R1_Total_Mes+R1_Saldo_Anterior+R1_Total_Cuotas))

        Valida_Total_Detalle("Error de Cuadratura entre Total del Mes (A01) y Total de Cargos Facturados (A09)", \
                                R1_Cod_Clie, R1_Total_Mes,  R9_Val_Monto )

        Valida_Total_Detalle("Error de Cuadratura entre Total del Mes (A01) y Total de Cargos Facturados (A10)", \
                                R1_Cod_Clie, R1_Total_Mes,  R10_Tot_Grupo )

        Valida_Total_Detalle("Error de Cuadratura entre Total Saldo Ant/Cuotas (A01) y Total de Cargos No Facturados (A11)", \
                                R1_Cod_Clie, (R1_Saldo_Anterior+R1_Total_Cuotas),  R11_Tot_Grupo)

        Valida_Total_Detalle("Error de Cuadratura entre Total Detalle (A09) y Total Facturado (A10)", \
                                R1_Cod_Clie, R9_Val_Monto, R10_Tot_Grupo )

        Valida_Total_Detalle("Error de Cuadratura entre Total a Pagar (A01) y Total de Cargos Facturados/No Fact.",   \
                                R1_Cod_Clie, R1_Total_Pagar,  Total_Pagar_Cliente)

        Valida_Total_Detalle("Error de Cuadratura entre Total Facturado (A10) y Total Facturado (B)",  \
                                R1_Cod_Clie,    R10_Tot_Grupo,       Total_Grupo_Facturado )

        Valida_Total_Detalle("Error de Cuadratura entre Total No Facturado (A11)  y Total No Facturado (B)", \
                                R1_Cod_Clie,    R11_Tot_Grupo,       Total_Grupo_NoFacturado )

        Valida_Total_Detalle("Error de Cuadratura entre Total a Pagar (A10+A11) y Total de Pagar (S)", \
                                R1_Cod_Clie,    Total_Pagar_Cliente,   Total_Registro_S1 )

        Valida_Total_Detalle("Error de Cuadratura entre Total a Pagar (A01) y Total a Pagar (S)", \
                                R1_Cod_Clie,    R1_Total_Pagar,   Total_Registro_S1 )

        
        if (R1_Cod_Clie > 0){

            if (R1_Cod_Docum == "02" || R1_Cod_Docum == "40") {
                printf("%10ld|%11s|%2s|%9s|%6s|%15ld|%15ld|%15ld|%15ld|%10ld|%-250.250s\n", \
                        R1_Cod_Clie,R2_Rut_Clie,R1_Cod_Docum,R1_Num_Folio_Legal,R1_Codigo_Despacho,\
                        R1_Total_Mes,R1_Total_Cuotas,R1_Saldo_Anterior,R1_Total_Pagar,NumSecuInfo,FILENAME) >> FileName_Cliente
        
                Dir_Cliente = Regula_Espacios(R3_Dir_Legal)
                ComCiu_Legal = Regula_Espacios(R3_ComCiu_Legal)
    
                printf("%10ld|%s|%s\n", R1_Cod_Clie,Dir_Cliente,ComCiu_Legal) >> FileName_Direcci
    
                ###########################################################################################################
                #   Escribe Estadisticas de Totales por Archivo 
                ###########################################################################################################
    
                printf("%10ld|%-250.250s|%10ld|%15ld|%15ld|%15ld|%15ld|%15ld\n" , NumSecuInfo, FILENAME, Total_Clientes, \
                        TOTAL_SALDO_ANT,TOTAL_CUOTAS,TOTAL_CARGOS_FACTURADOS,TOTAL_CARGOS_NOFACTURADOS,TOTAL_PAGAR) >> FileName_Totales
            }
       }
       if (Archivo_Error==1){
            Archivo_Afectado1=FILENAME
            gsub(" ","",Archivo_Afectado1)
		    printf("UPDATE FAD_CTLIMPRES SET COD_ESTADO=1 WHERE NUM_SECUINFO= %ld AND NOM_ARCHIVO='%s';\n",NumSec,Archivo_Afectado1) >> FileName_Errores
       } 
}

# Convierte un String en Numero
# Elimina los '.'
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


function  Valida_Total_Detalle ( _string , _cliente, _total, _detalle)
{
    if (_total != _detalle )
    {
        printf("INSERT INTO FAD_CTLERRIMPRE (NUM_SECUINFO,NOM_ARCHIVO,GLS_ERROR,COD_TIPIMPRES,COD_CLIENTE,TOT_CORRECTO,TOT_ERRONEO) VALUES (%ld,'%s','%s',2,%ld,%9ld,%9ld);\n",NumSecuInfo, Archivo_Totales,_string,_cliente,_total,_detalle) >> FileName_Errores
        if (Archivo_Error==0){
           Archivo_Error=1
        }   
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

function  Verifica_Campos_Validos ( _string, _cliente, _param)
{
    if (_param == " " )
    {
        printf("INSERT INTO FAD_CTLERRIMPRE (NUM_SECUINFO,NOM_ARCHIVO,GLS_ERROR,COD_TIPIMPRES,COD_CLIENTE) VALUES (%ld,'%s','%s',2,%ld);\n",NumSecuInfo, Archivo_Totales,_string,_cliente) >> FileName_Errores
        if (Archivo_Error==0){
           Archivo_Error=1
        }   
    }
}
