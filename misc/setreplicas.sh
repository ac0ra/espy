function getdate {
date=`date --date="$1 day ago" +%Y.%m.%d`
}
#curl -XPUT 'localhost:9200/logstash-2014.05.14/_settings' -d '{"index":{"number_of_replicas":3}}'
for n in `seq 0 7`
	do
	getdate $n
	echo $date"
	"
	curl -XPUT 'localhost:9200/logstash-'$date'/_settings' -d '{"index":{"number_of_replicas":3}}'
	echo "
	"
done
for n in `seq 8 31`
        do
        getdate $n
        echo $date"
	"
        curl -XPUT 'localhost:9200/logstash-'$date'/_settings' -d '{"index":{"number_of_replicas":2}}'
	curl -XPOST 'http://localhost:9200/logstash-'$date'/_optimize'
	echo "
	"
done
for n in `seq 32 380`
        do
        getdate $n
        echo $date"
	"
        curl -XPUT 'localhost:9200/logstash-'$date'/_settings' -d '{"index":{"number_of_replicas":1}}'
	curl -XPOST 'http://localhost:9200/logstash-'$date'/_optimize'
	echo "
	"
done
for n in `seq 380 700`
        do
        getdate $n
        echo $date"
	"
        curl -XPUT 'localhost:9200/logstash-'$date'/_settings' -d '{"index":{"number_of_replicas":1}}'
	curl -XPOST 'http://localhost:9200/logstash-'$date'/_optimize'
	#elasticdump --limit=1000 --input='http://localhost:9200/logstash-'$date --output=$ | gzip > /storage/backups/logstash-$date.json.gz
	echo "
	"
done

