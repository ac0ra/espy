function getdate {
date=`date --date="$1 day ago" +%Y.%m.%d`
}
#curl -XPUT 'localhost:9200/logstash-2014.05.14/_settings' -d '{"index":{"number_of_replicas":3}}'
#for n in `seq 0 7`
#	do
#	getdate $n
#	echo $date"
#	"
#	curl -XPUT 'localhost:9200/logstash-'$date'/_settings' -d '{"index":{"number_of_replicas":1}}'
#	echo "
#	"
#done
#for n in `seq 8 31`
#        do
#        getdate $n
#        echo $date"
#	"
#        curl -XPUT 'localhost:9200/logstash-'$date'/_settings' -d '{"index":{"number_of_replicas":2}}'
#	curl -XPOST 'http://localhost:9200/logstash-'$date'/_optimize'
#	echo "
#	"
#done
#for n in `seq 8 380`
#        do
#        getdate $n
#        echo $date"
#	"
#        curl -XPUT 'localhost:9200/logstash-'$date'/_settings' -d '{"index":{"number_of_replicas":1}}'
#	curl -XPOST 'http://localhost:9200/logstash-'$date'/_optimize'
#	echo "
#	"
#done
for n in `seq 3 10`
        do
        getdate $n
        echo $date"
	"
#        curl -XPUT 'localhost:9200/logstash-'$date'/_settings' -d '{"index":{"number_of_replicas":1}}'
#	curl -XPOST 'http://localhost:9200/logstash-'$date'/_optimize'
	curl -XPOST 'http://172.24.33.8:9200/logstash-'$date'/_open'
#	elasticdump --limit=100 --input='http://localhost:9200/logstash-'$date --output=/storage/backups/logstash-$date.json'
	echo "
	"
done

