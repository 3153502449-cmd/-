ulimit -n 65535
###### stop Login ######
LOGINPID=`ps aux | grep "./Login" | grep -v grep | awk '{print $2}'`
kill -9 $LOGINPID
echo " Login is stopping ......"

until
[ "$?" = "1" ]
do
  ps aux | grep -i "./Login" | grep -v grep >/dev/null 2>&1
done
echo " Login stoped completely !!!!!!"

  ###### start Login ######
  cd Server
  ./Login >/dev/null 2>&1 &
  echo " start Login ......"
  sleep 3
  echo " Login started completely !!!!!!"
