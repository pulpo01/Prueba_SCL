date
export XPC_LOG=$XPF_LOG
export XPC_DAT=$XPF_DAT
file=AT$(date +%d%m%y).txt
print $file
~/facturacion/exe/atrer -u/ -l3 -ex
cd ~/facturacion/dat/Atrer
ftp -v -n -i 10.10.100.2 <<!
user startel fonoestrella2010
put $file
bye
date
