if [ $# -eq 0 ]; then
    NodeId=$(curl -X POST --data '{
    "jsonrpc": "2.0",
    "method": "admin.getNodeID",
    "params":{},
    "id": 1
}' -H 'content-type:application/json;' 127.0.0.1:9650/ext/admin | jq -r '.result.nodeID')
else
   NodeId=$1
fi

starttime=$(curl -X POST --data '{
    "jsonrpc": "2.0",
    "method": "platform.getCurrentValidators",
    "params": {},
    "id": 1
}' -H 'content-type:application/json;' 127.0.0.1:9650/ext/P  |   jq -r --arg NodeID "$NodeId" '.result.validators[]  | select(.id == $NodeID) | .startTime')
datetimenow=$(date '+%s')
elapsed="$(($datetimenow-$starttime))"
printf "Geçen Süre: %02d Gün: %02d Saat: %02d Dk: %02d sn\n" "$((elapsed/86400))" "$((elapsed/3600%24))" "$((elapsed/60%60))" "$((elapsed%60))"

