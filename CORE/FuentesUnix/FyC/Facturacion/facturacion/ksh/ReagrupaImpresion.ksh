a=${1:?"Debe ingresar el nombre del archivo .dat"}
p=$HOME/facturacion/perl/ReagrupaImpresionScl_PTR.pl

a=$1
if [ -s "$a" ] ;then
        b=`dirname $a`"/"`basename $a ".dat"`"_reagrup.dat"
        c=`dirname $a`"/"`basename $a ".dat"`"_dos.dat"
        rm -f $b $c
        perl $p $a $b
        unix2dos $b $c 2>&-
        rm $b
        if [ -s "$c" ] ;then
                echo "\tarchivo de salida ($c)"
        fi
else
        echo "archivo ($a) no existe o es nulo"

fi  
