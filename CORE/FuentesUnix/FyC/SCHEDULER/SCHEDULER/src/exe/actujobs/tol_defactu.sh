#ini_jobs=0
#end_jobs=1
#err_jobs=2
#ini_profile=3
#end_profile=4
#err_profile=5
#-------------------------------------------------------------------------
# MACRO de actulizacion de SCH_JOBS
#-------------------------------------------------------------------------
#Parte fija al momento de llamar se anexara el parametro adicional

EXEACTUJOBSINI="$SCH_PRO/actujobs/marca $cod_usua $cod_pass $cod_proc $cod_spro $num_jobs 0 "
EXEACTUJOBSFIN="$SCH_PRO/actujobs/marca $cod_usua $cod_pass $cod_proc $cod_spro $num_jobs 1 "
EXEACTUJOBSERR="$SCH_PRO/actujobs/marca $cod_usua $cod_pass $cod_proc $cod_spro $num_jobs 2 "
#-------------------------------------------------------------------------
# MACRO de actulizacion de SCH_PROFILES
#-------------------------------------------------------------------------
EXEACTUPROFINI="$SCH_PRO/actujobs/marca $cod_usua $cod_pass $cod_proc $cod_spro $num_jobs 3 X "
EXEACTUPROFFIN="$SCH_PRO/actujobs/marca $cod_usua $cod_pass $cod_proc $cod_spro $num_jobs 4 X "
EXEACTUPROFERR="$SCH_PRO/actujobs/marca $cod_usua $cod_pass $cod_proc $cod_spro $num_jobs 5 X "
#-------------------------------------------------------------------------
# MACRO de actulizacion de obtencion parametro para ejecucion tareas 
#-------------------------------------------------------------------------
#Parte fija al momento de llamar se anexara el parametro adicional
EXEINDTAREA="$SCH_PRO/actujobs/det_ejecuta $cod_usua $cod_pass $cod_proc $cod_spro " 
