set -A LISTA CritAsigDesp CritAsigMens FactOnline FolBatch FolOnline ImpreOnline LibroVta PHistOnline PHistorico QueueAdmin Scheduler abofact carrier cierrefact foliacion impdetalle impdetllam impresion impresion2 impresion_ncc informes loadtarif pac pasocobros pasohist prefac procCuotas pruebas rutinasgen supertel supertel_hist unloadtarif

print "\n Aplicacion         Archivos Pro-C       Archivos H "
for arch in "${LISTA[@]}"
do
    cd ${arch}
    ARCHIVOS_H=$(find . -name *.h | awk '{print "wc -l " $1}' | ksh |awk '{sum=sum+$1} ; END{print sum} ')
    ARCHIVOS_C=$(find . -name *.pc | awk '{print "wc -l " $1}' | ksh |awk '{sum=sum+$1} ; END{print sum} ')
    printf "%20s   %10d   %10d\n"   ${arch}  ${ARCHIVOS_C} ${ARCHIVOS_H}
    cd ..
done
