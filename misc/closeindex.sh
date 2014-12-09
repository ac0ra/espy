function reroute() {
#    curl -XPOST 'localhost:9200/_cluster/reroute?pretty' -d '{
#        "commands" : [ {
#                "allocate" : {
#                    "index" : "'$1'",
#                    "shard" : '$2'
#                    "allow_primary" : true,
                    #"node" : "<node>"
#                }
#            }
#        ]
#    }' > /dev/null
	curl -XPOST "localhost:9200/$1/_close"
	sleep 1
}
curl -s localhost:9200/_cluster/state?pretty | awk '
    BEGIN {more=1}
    {if (/"UNASSIGNED"/) unassigned=1}
    {if (/"routing_nodes"/) more=0}
    {if (unassigned && /"shard"/) shard=$3}
    {if (more && unassigned && /"index"/) {print "reroute",$3, shard; unassigned=false}}
' > runit.close
source runit.close
