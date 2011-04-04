# this script is necessary because
# my mythtv databases frequently become
# corrupted for reasons that I do not understand.

service mythbackend stop
service mysqld stop

for f in *MYI; do
	db=`basename $f .MYI`
	echo $db
	#myisamchk -r $db
	myisamchk -r -f $db
	myisamchk --safe-recover $db
done

service mysqld start
service mythbackend start
