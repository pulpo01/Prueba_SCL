BEGIN {
    FS="|"
    Arr_Ind=split(FILENAME,Arr_File,"/")
    Archivo_Totales=Arr_File[Arr_Ind]
    Index_Punto= index(Archivo_Totales,".")
    FileName_Base=substr(Archivo_Totales,1,(Index_Punto>0?Index_Punto-1:99999))
    print substr(FILENAME,1,index(FILENAME,Archivo_Totales)-1)
}
