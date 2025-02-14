mensaje=$(echo `hostname`":$LOGNAME : "$2)
length=$(echo "$mensaje" |awk '{printf ("%04d",length($0)+10)}')
comando=$(echo "d"$length"ID$1M$mensaje")
echo $comando
${REX_KSH}/xmens -s "$comando" -m 172.16.221.145 -p 11380
