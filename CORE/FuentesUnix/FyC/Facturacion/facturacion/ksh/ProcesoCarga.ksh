#
# Hugo Sánchez D.
# menu item
#


path_origen="${XPF_DAT}/carrier/origen"
path_destino="${XPF_DAT}/carrier/entrada"
path_exe="${XPF_EXE}"
fileo=""
fileo_ext=""
file_origen=""
filed="destino.dat"
file_destino=""
path_xml="${XPF_CFG}"
xml_origen="PlantillaOrigen.xml"
xml_destino="PlantillaDestino.xml"
ejecutable="FaConvertCarrier"
path_err="${XPF_LOG}/carrier/FaConvertCarrier"


CambiarPathOrigen()  
{
echo "Ingrese el nombre del Path de Origen : "
echo ""
read path_origen
echo "presione una tecla para volver al menú principal"
return
}
 
CambiarPathDestino()   
{
echo "Ingrese el nombre del Path de Destino : "
echo ""
read path_destino
echo "presione una tecla para volver al menú principal"
return
}

CambiarPathXML()
{
echo "Ingrese el nombre del Path de la Plantilla Origen : "
echo ""
read path_xml
echo "presione una tecla para volver al menú principal"
return
}

CambiarPlantillaOrigen()
{
echo "Ingrese el nombre de la Plantilla de Origen : "
echo ""
read xml_origen
echo "presione una tecla para volver al menú principal"
return
}

CambiarPlantillaDestino()
{
echo "Ingrese el nombre de la Plantilla de Destino : "
echo ""
read xml_destino
echo "presione una tecla para volver al menú principal"
return
}

CambiarArchivoOrigen()
{
echo "Ingrese el nombre del archivo de Origen (sin Path) : "
echo ""
read file_origen
file_destino="$file_origen"_"$filed"
echo "presione una tecla para volver al menú principal"
return
}

CambiarArchivoDestino()
{
echo "Ingrese el nombre del archivo de Destino (sin Path) : "
echo ""
read file_destino
echo "presione una tecla para volver al menú principal"
return
}
Verificar()
{
    archivorigen="$path_origen/$file_origen"
    
    if [ ! -f $archivorigen ]
	then
    	echo "Archivo de origen [$archivorigen] no encontrado - Aborting"
    	exit
    fi
    
    xmlorigen="$path_xml/$xml_origen"
    if [ ! -f $xmlorigen ]
	then
    	echo "Archivo origen XML [$xmlorigen] no encontrado - Aborting"
    	exit
    fi
    
    xmldestino="$path_xml/$xml_destino"
    if [ ! -f $xmldestino ]
	then
    	echo "Archivo destino XML [$xmldestino] no encontrado - Aborting"
    	exit
    fi
    
    if [ ! -d $path_destino ]
	then
    	echo "Path destino [$path_destino] no encontrado - Aborting"
    	exit
    fi 
    
    if [ ! -d $path_err ]
	then
    	echo "Path de Log de error [$path_err] no encontrado - Aborting"
    	exit
    fi
    
    exe="$path_exe/$ejecutable"
    if [ ! -f $exe ]
	then
    	echo "Ejecutable [$exe] no encontrado - Aborting"
    	exit
    fi
    
    if [ -f $file_destino ]
	then
    	echo "Ya existe un archivo de destino [$file_destino]"
    	echo "Desea sobreescribir? ( s/n ) : \c"
    	read answer
    	if [ "$answer" = "n" ] || [ "$answer" = "N" ]
    	then
		echo "Aborting"
		exit
    	fi
    fi
}
Comenzar()
{
     clear
     $path_exe/$ejecutable ${path_xml}/${xml_origen} ${path_xml}/${xml_destino} ${path_origen}/${file_origen} ${path_destino}/${file_destino} $path_err

     
     if [ $? == 0 ]
      then
        echo "Ejecución exitosa de $path_exe/$ejecutable"
    	${path_exe}/fortas_2000 -u${USERPASS} ${file_destino}
      else
      	echo "Salida anormal de $path_exe/$ejecutable"
      exit
     fi
echo ""
echo "presione una tecla para volver al menú principal"
return
}

Comenzar_reproceso()
{
     $path_exe/$ejecutable ${path_xml}/${xml_origen} ${path_xml}/${xml_destino} ${path_origen}/${file_origen} ${path_destino}/${file_destino} $path_err
         
     if [ $? == 0 ]
      then
        echo "Ejecución exitosa de $path_exe/$ejecutable"
    	${path_exe}/fortas_2000 -u${USERPASS} -r ${file_destino}
      else
      	echo "Salida anormal de $path_exe/$ejecutable"
      exit
     fi
       
return
}


while :
 do
    clear
    echo "-------------------Parser XML-------------------"
    echo ""
    echo "----------Defaults---------"
    echo "Path Archivo Origen       : ${path_origen}"
    echo "Path Archivo Destino      : ${path_destino}"
    echo "Path Plantillas XML       : ${path_xml}"
    echo " - - - - - - - - - - - - -"
    echo "Plantilla XML de Origen   : ${xml_origen}"
    echo "Plantilla XML de Destino  : ${xml_destino}"
    echo "Archivo Origen            : ${file_origen}" 
    echo "Archivo Destino           : ${file_destino}"
    echo "---------------------------"
    echo ""
#   echo "[0] Cambiar Path origen"
#   echo "[1] Cambiar Path destino"
#   echo "[2] Cambiar Path de Plantillas"
#   echo " - - - - - - - - - - - - - - - - - - - - -"      
#   echo "[3] Cambiar nombre Plantilla XML origen"
#   echo "[4] Cambiar nombre Plantilla XML destino"
    echo "[1] Cambiar nombre de archivo de origen"
    echo "[2] Cambiar nombre de archivo de destino"
    echo " - - - - - - - - - - - - - - - - - - - - -" 
    echo "[3] Ejecutar Proceso de Carga de Datos"
    echo "[4] Ejecutar Proceso de Carga de Datos modo Reproceso"
    echo "[5] Salir/Detener"
    echo "================================================"
    echo "Ingrese la opción del menú [1-5]: \c"
    read menu
    case ${menu} in
#     0) CambiarPathOrigen ; read ;;
#     1) CambiarPathDestino ; read ;;
#     2) CambiarPathXML; read ;;
#     3) CambiarPlantillaOrigen ; read ;;
#     4) CambiarPlantillaDestino ; read ;;
      1) CambiarArchivoOrigen ; read ;;
      2) CambiarArchivoDestino ; read ;;
      3) Verificar; Comenzar ;read ;;
      4) Verificar; Comenzar_reproceso ; read ;;
      5) exit 0 ;;
      *) echo "Por favor ingrese opcion válida (desde 1 al 5)";
         echo "Presione una tecla. . ." ; read ;;
 esac



done

