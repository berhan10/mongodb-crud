

mongo --port 27017 --configdb rs-config-server/configsvr01:27017,configsvr02:27017,configsvr03:27017 --bind_ip_all

mongo <<EOF
  rs.initiate(
    {
        _id: "rs-config-server",
        configsvr: true,
        version: 1,
        members: [
            { _id: 0, host: 'configsvr01:27017' },
            { _id: 1, host: 'configsvr02:27017' },
            { _id: 2, host: 'configsvr03:27017' }
        ]
    }
)
EOF
sleep 10

mongo <<EOF
rs.initiate(
    {
        _id: "rs-shard-01",
        version: 1,
        members:
            [
                { _id: 0, host: "shard01-a:27017" },
                { _id: 1, host: "shard01-b:27017" },
                { _id: 2, host: "shard01-c:27017" },
            ]
    })
EOF
sleep 10

mongo <<EOF
rs.initiate(
    {
        _id: "rs-shard-02", version: 1,
        members: [
            { _id: 0, host: "shard02-a:27017" },
            { _id: 1, host: "shard02-b:27017" },
            { _id: 2, host: "shard02-c:27017" },]
    })
EOF
sleep 10

mongo <<EOF
    rs.initiate(
    {
        _id: "rs-shard-03",
        version: 1, members:
            [
                { _id: 0, host: "shard03-a:27017" },
                { _id: 1, host: "shard03-b:27017" },
                { _id: 2, host: "shard03-c:27017" },
            ]
    }
)
EOF
sleep 10
    
mongo <<EOF
   sh.addShard("rs-shard-01/shard01-a:27017")
sh.addShard("rs-shard-01/shard01-b:27017")
sh.addShard("rs-shard-01/shard01-c:27017")
sh.addShard("rs-shard-02/shard02-a:27017")
sh.addShard("rs-shard-02/shard02-b:27017")
sh.addShard("rs-shard-02/shard02-c:27017")
sh.addShard("rs-shard-03/shard03-a:27017")
sh.addShard("rs-shard-03/shard03-b:27017")
sh.addShard("rs-shard-03/shard03-c:27017")
EOF
sleep 10

mongo <<EOF
   use admin;
   admin = db.getSiblingDB("admin");
   admin.createUser(
     {
	user: "admin",
        pwd: "password",
        roles: [ { role: "root", db: "test" } ]
     });
     db.getSiblingDB("admin").auth("admin", "password");
     rs.status();
EOF