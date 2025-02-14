sub fnFreedom{
        if($szTipo_Registro eq $szTIPREG_A1000){
                &prAsignaValor($_, $szPlan_Tarifario      ,85     ,3    ,$CHAR);
                if($szPlan_Tarifario eq $szPLAN_TARIFARIO_FREEDOM){
                        #printf "es a1000 el el plan es freedon(%s)\n",$szPlan_Tarifario;
                        $bImprimeReg_BD=$FALSE;
                }
                else{
                        $bImprimeReg_BD=$TRUE;
                        #printf "es a1000 el el plan NO es freedon(%s)\n",$szPlan_Tarifario;
                }
        }

        if((substr($szTipo_Registro,0,1) eq "B")||(substr($szTipo_Registro,0,1) eq "D")){
                if($bImprimeReg_BD==$FALSE){
                        #printf "el bxxxxx o dxxxxx no imprimir\n";
                        return($TRUE);
                }
                else{
                        #printf "el bxxxxx o dxxxxx imprimir(%d)\n",$bImprimeReg_BD;
                        return($FALSE);
                }
        }

        return($FALSE);
}

#cod_default,des_default,cod_concepto


sub prReAsignacionConceptos{
        if($CONCEPTOS_A_AGRUPAR{$_[2]}==1){
                printf "el concepto es (%s) FOUNDED\n",$_[2];
                $_[2]=$_[0];
                $_[3]=$_[1];
        }
        else{
                printf "el concepto es (%s) NO FOUNDED\n",$_[2];
        }

}

#================================================================================================================
#
#================================================================================================================

#       perl -e '
#         while(<>){
#          $llave_act=substr($_,0,5);
#
#          if($llave_act ne "D1000"){
#           if($llave_ant eq "D1000"){
#             if($llave_act ne "D1111"){
#               printf "%s", $linea_ant;
#               printf "%s", $_;
#             }
#           }
#           else{ printf "%s", $_; }
#          }
#          $llave_ant=$llave_act;
#          $linea_ant=$_;
#          }
#
#       '  ImprScl_10000_01_2_DESNO.dat.final > out &
sub fnFiltraLLamadasVacias
{
    $bRc=$TRUE;
        #printf FD_ARCHIMP_OUT "\tbRegistroAnteriorEraUnD1000(%d)\n",bRegistroAnteriorEraUnD1000;
        #-----------------------------------------------------------------------------
        #
        if($szTipo_Registro ne $szTIPREG_D1000){
                if($LlaveAnterior eq $szTIPREG_D1000) {
                        if($szTipo_Registro ne $szTIPREG_D1111){
                                printf FD_ARCHIMP_OUT "%s",$LineaAnterior;
                                $bRc=$FALSE;
                        }
                }
                else{$bRc=$FALSE;}
        }
        $LlaveAnterior=$szTipo_Registro;
        $LineaAnterior=$_;
        #-----------------------------------------------------------------------------
        #

        return($bRc);
}

#================================================================================================================
#
#================================================================================================================
sub fnReAgrupa_ResumenCargosUnid
{
        #-----------------------------------------------------------------------------
        #
        if($szTipo_Registro eq $szTIPREG_B3000){
                #-----------------------------------------------------------------------------
                # SI VIENE UN A1890, VACIAR ARREGLO ACUMULADOR
                #-----------------------------------------------------------------------------
                # imprimir registro, haciendo un return($FALSE)
                while($ee = each %ARR_ACUMULADOR)    { delete $ARR_ACUMULADOR{$ee}; }
                $iCod_Concepto_Agrupacion="";
                $iOrdenImpresion=0;
                printf FD_ARCHIMP_OUT "%s",$_;
                return($TRUE);
        }

    #-----------------------------------------------------------------------------
    # B4003
        #1      Tipo_Registro
        #2      Cod_Grupo
        #3      Cod_Subgrupo
        #4      Cod_Concepto
        #5      Desc_Concepto
        #6      Costo
        #7      Duracion
        #8      Costo_Impuesto
        #-----------------------------------------------------------------------------
        #
    if($szTipo_Registro eq $szTIPREG_B4003){
        #printf "%s",$_;

        &prAsignaValor($_, $iCod_Grupo      ,6     ,5    ,$NUMBER );
        &prAsignaValor($_, $iCod_Subgrupo   ,11    ,5    ,$NUMBER );

        &prAsignaValor($_, $iCod_Concepto   ,16    ,5    ,$NUMBER );
        &prAsignaValor($_, $szDes_Concepto  ,21    ,50   ,$CHAR   );
        &prAsignaValor($_, $dCosto              ,71    ,15   ,$DECIMAL);
        &prAsignaValor($_, $szDuracion          ,86    ,12   ,$CHAR   );
        &prAsignaValor($_, $dCosto_Impuesto ,98    ,15   ,$DECIMAL);

        $szPrefijo=substr($_,0,15);
        #printf "fnReAgrupa_ResumenCargosUnid\n";

                #if($iCod_Concepto_Agrupacion eq ""){
                #       $iCod_Concepto_Agrupacion=$iCod_Concepto;
                #       $szDes_Concepto_Agrupacion=$szDes_Concepto;
                #       printf "iCod_Concepto_Agrupacion(%s)szDes_Concepto_Agrupacion(%s)\n",$iCod_Concepto_Agrupacion,$szDes_Concepto_Agrupacion;
                #}
        #
        #&prReAsignacionConceptos($iCod_Concepto_Agrupacion,$$szDes_Concepto_Agrupacion,$iCod_Concepto,$szDes_Concepto);


        #if($CONCEPTOS_A_AGRUPAR{$iCod_Concepto}==1){
        $bSe_acumulo_B4003=$TRUE;
                $iDuracion=substr($szDuracion,0,9)*60+substr($szDuracion,10,2);

        if($ARR_ACUMULADOR{$iCod_Concepto,$DESCR} eq ""){
                        $ARR_ORDENIMPR{$iOrdenImpresion} = $iCod_Concepto;
                        printf "iOrdenImpresion(%d)iCod_Concepto(%s)\n",$iOrdenImpresion,$iCod_Concepto;
                        $iOrdenImpresion++;
                }

                $ARR_ACUMULADOR{$iCod_Concepto,$COSTO}+=$dCosto ;
                $ARR_ACUMULADOR{$iCod_Concepto,$COSTOIMP}+=$dCosto_Impuesto ;
                $ARR_ACUMULADOR{$iCod_Concepto,$PREFI}=$szPrefijo;
                $ARR_ACUMULADOR{$iCod_Concepto,$DURAC}+=$iDuracion;
                $ARR_ACUMULADOR{$iCod_Concepto,$DESCR}=$szDes_Concepto;
        #}
        #else{
        #       printf FD_ARCHIMP_OUT "%s",$_;
        #}
        #
            return($TRUE);

        }
        #-----------------------------------------------------------------------------
        #
        #printf "bSe_acumulo_B4003(%d)\n",$bSe_acumulo_B4003;
        if($szTipo_Registro eq $szTIPREG_B3333){
                if($bSe_acumulo_B4003==$TRUE){
                        #-----------------------------------------------------------------------------
                        # SI VIENE UN A1999, IMPRIMIR ARREGLO ACUMULADO Y LUEGO EL REGISTRO A1999
                        for($PosConce=0;$PosConce<$iOrdenImpresion;$PosConce++){
                                $iKeyConcepto=$ARR_ORDENIMPR{$PosConce};

                                $szDuracion=sprintf("%09ld:%02d",($ARR_ACUMULADOR{$iKeyConcepto,$DURAC}/60),(($ARR_ACUMULADOR{$iKeyConcepto,$DURAC})%60));
                                #printf FD_ARCHIMP_OUT "%s|%5.5d|%-50.50s|%015.4f|%-12.12s|%015.4f|\n",
                                printf FD_ARCHIMP_OUT "%s%5.5d%-50.50s%015.4f%-12.12s%015.4f\n",
                                $ARR_ACUMULADOR{$iKeyConcepto,$PREFI},
                                $iKeyConcepto,
                                $ARR_ACUMULADOR{$iKeyConcepto,$DESCR},
                                $ARR_ACUMULADOR{$iKeyConcepto,$COSTO},
                    $szDuracion,
                    $ARR_ACUMULADOR{$iKeyConcepto,$COSTOIMP};



                        }
                        $bSe_acumulo_B4003=$FALSE;
            }
                printf FD_ARCHIMP_OUT "%s",$_;

        return($TRUE);
        }
    return($FALSE);
}
#================================================================================================================
#
#================================================================================================================


sub prAsignaValor {

    if($_[4] == $CHAR){$fmto="%s";}
    elsif($_[4] == $DECIMAL){$fmto="%.4f";}
    else{$fmto="%d";}
    if($_[5]==$SUMA){
        $_[1]+=sprintf($fmto,substr($_[0],(($_[2])-1),$_[3]));
    }
    else{
        $_[1]=sprintf($fmto,substr($_[0],(($_[2])-1),$_[3]));
    }
    #printf "formato de imrpsion (%s|%s|%s)\n",$fmto,$_[0],$_[1];

}
sub prCargaConstantes
{



    $iCOD_GRUPO_LLAMADAS=7;
    $szPLAN_TARIFARIO_FREEDOM="501";
        $COSTO=1;
        $DURAC=2;
        $COSTOIMP=3;
        $PREFI=4;
        $DESCR=5;



    $DECIMAL=1;
    $CHAR=2;
    $NUMBER=3;
    $SUMA=4;
    $HABILITADO=1;
    $TRUE=1;
    $FALSE=0;



    $szTIPREG_A1000="A1000"; #Registro de Documento cliente
    $szTIPREG_A1100="A1100"; #Registro Balance Anterior
    $szTIPREG_A1200="A1200"; #Registro de Documento totales
    $szTIPREG_A1300="A1300"; #Registro de Cliente
    $szTIPREG_A1400="A1400"; #Registro Dirección Facturación
    $szTIPREG_A1800="A1800"; #Registro Detalle Facturado NIVEL1
    $szTIPREG_A1890="A1890"; #Registro Cabecera Detalle Facturado NIVEL2
    $szTIPREG_A1900="A1900"; #Registro Detalle Facturado NIVEL2
    $szTIPREG_A1999="A1999"; #Registro Detalle Facturado NIVEL2
    $szTIPREG_A2000="A2000"; #Registro Bloques de Mensajes
    $szTIPREG_A2100="A2100"; #Total Facturado
    $szTIPREG_A2200="A2200"; #Total NO Facturado

    $szTIPREG_B1000="B1000"; #ABONADO   TERMINO:B1111
    $szTIPREG_B2000="B2000"; #GRUPO TERMINO:B2222
    $szTIPREG_B3000="B3000"; #SUB-GRUPO TERMINO:B3333
    $szTIPREG_B3333="B3333"; #SUB-GRUPO TERMINO:B3333
    $szTIPREG_B4001="B4001"; #CARGOS-BASICOS    Cargos_Basicos subtipo : 01
    $szTIPREG_B4002="B4002"; #CARGOS    Cargos_Varios subtipo : 02
    $szTIPREG_B4003="B4003"; #TRAFICO   Trafico : 03
    $szTIPREG_B4004="B4004"; #ARRIENDO-VENTA    Arriendo_Venta : 04
    $szTIPREG_B4005="B4005"; #COBRANZA  Cobranza subtipo : 05
    $szTIPREG_B4006="B4006"; #SALDO-ANTERIOR    Saldo_Anterior subtipo : 06
    $szTIPREG_B4007="B4007"; #CUOTAS-PAGARES    Cuotas_Pagare subtipo : 07

    $szTIPREG_D1000="D1000"; #Abonado
    $szTIPREG_D1111="D1111"; #Abonado
    $szTIPREG_D2000="D2000"; #Tipo de Llamada
    $szTIPREG_D3001="D3001"; #Llamadas locales
    $szTIPREG_D3002="D3002"; #Llamadas Interzona
    $szTIPREG_D3003="D3003"; #Llamadas Servicios Especiales
    $szTIPREG_D3004="D3004"; #Llamadas Carrier
    $szTIPREG_D3005="D3005"; #Llamadas Servicios Roaming
    $szTIPREG_D3006="D3006"; #Ldi




}

sub szBasename{
        @OnlyAnme=split(/\// ,"$_[0]");
        $Num=@OnlyAnme;
        return($OnlyAnme[$Num-1]);
}


################################################################################################################
# INVOCA LOGICA DEL PROCESO :
################################################################################################################
        #-----------------------------------------------------------------------------
        #
    &prCargaConstantes();

    #-----------------------------------------------------------------------------
    #
    open(FD_ARCHIMP,"$ARGV[0]");
    open(FD_ARCHIMP_OUT,">$ARGV[1]");
        printf "abriendo archivo (%s)\n",$ARGV[0];

        #$CONCEPTOS_A_AGRUPAR{67  }=1;
        #$CONCEPTOS_A_AGRUPAR{97  }=1;
        #$CONCEPTOS_A_AGRUPAR{67  }=1;
        #$CONCEPTOS_A_AGRUPAR{99  }=1;
        #$CONCEPTOS_A_AGRUPAR{1923}=1;
        #$CONCEPTOS_A_AGRUPAR{1949}=1;
        
    #-----------------------------------------------------------------------------
    #
        while(<FD_ARCHIMP>){
                $szTipo_Registro=substr($_,0,5);
                if(!&fnFreedom()){
                                if(!&fnReAgrupa_ResumenCargosUnid()){
                                        if(!&fnFiltraLLamadasVacias()){
                                    printf FD_ARCHIMP_OUT  "%s",$_;
                                    }
                            }
                }
        }


    close(FD_ARCHIMP);
    close(FD_ARCHIMP_OUT);









