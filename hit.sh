count=0
while true;
do
    curl -s 'http://192.168.60.10:30443/' \
        -H "Host: whoami.mbcaas.com" \
        -o /dev/null \
        -w "time_total:  %{time_total}s\n" \
        --insecure;
   (( count++ ))
    #    echo -ne "\r$count"
   sleep 0.1
done;
