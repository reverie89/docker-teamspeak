# Teamspeak server in a Docker image for x86/x64
Repo forked from [pozgo's docker-teamspeak](https://github.com/pozgo/docker-teamspeak)

This fork is modified to always use the latest version available from [Teamspeak website](https://www.teamspeak.com/downloads)


Tested successfully on latest Alpine 3.8, teamspeak 3.3.0

If ts3server.sqlitedb is not found in the mounted volume, the started container will attempt to download and install the latest Teamspeak server version available at https://www.teamspeak.com/downloads

Docker image can also be pulled on [Docker Hub](https://hub.docker.com/r/reverie89/teamspeak/)

## Deploy
```bash
docker run -d \
  --name teamspeak \
  --restart=unless-stopped \
  -p 9987:9987/udp \
  -p 10011:10011 \
  -p 30033:30033 \
  -v /opt/docker/teamspeak:/opt/teamspeak \
  reverie89/teamspeak
```

## Server administrator access and ServerAdmin privilege key
Admin login details can be found on first run in logs of running container. It will only appear once, so make sure you save them! After restarting the container those details will not available anymore. See logs by typing `docker logs -f teamspeak`  

Example output:  

```bash
2018-08-14 14:39:54.578139|INFO    |ServerLibPriv |   |TeamSpeak 3 Server 3.3.0 (2018-07-31 16:10:01)
2018-08-14 14:39:54.580070|INFO    |ServerLibPriv |   |SystemInformation: Linux 4.4.0-122-generic #146-Ubuntu SMP Mon Apr 23 15:34:04 UTC 2018 x86_64 Binary: 64bit
2018-08-14 14:39:54.580134|WARNING |ServerLibPriv |   |The system locale is set to "C" this can cause unexpected behavior. We advice you to repair your locale!
2018-08-14 14:39:54.580185|INFO    |ServerLibPriv |   |Using hardware aes
2018-08-14 14:39:54.583158|INFO    |DatabaseQuery |   |dbPlugin name:    SQLite3 plugin, Version 3, (c)TeamSpeak Systems GmbH
2018-08-14 14:39:54.583239|INFO    |DatabaseQuery |   |dbPlugin version: 3.11.1
2018-08-14 14:39:54.586241|INFO    |DatabaseQuery |   |checking database integrity (may take a while)
2018-08-14 14:39:54.625605|INFO    |SQL           |   |database updated successfully to revision: 28
2018-08-14 14:39:54.630780|INFO    |SQL           |   |database updated successfully to revision: 29
2018-08-14 14:39:54.633131|INFO    |DatabaseQuery |   |database busy, waiting for finishing index tasks, may take some time!
2018-08-14 14:40:34.704436|WARNING |Accounting    |   |Unable to open licensekey.dat, falling back to limited functionality
2018-08-14 14:40:34.716966|INFO    |Accounting    |   |Licensing Information
2018-08-14 14:40:34.717075|INFO    |Accounting    |   |licensed to       : Anonymous
2018-08-14 14:40:34.717138|INFO    |Accounting    |   |type              : No License
2018-08-14 14:40:34.717215|INFO    |Accounting    |   |starting date     : Sun Jul  1 00:00:00 2018
2018-08-14 14:40:34.717296|INFO    |Accounting    |   |ending date       : Wed Jul 31 00:00:00 2019
2018-08-14 14:40:34.717340|INFO    |Accounting    |   |max virtualservers: 1
2018-08-14 14:40:34.717378|INFO    |Accounting    |   |max slots         : 32
2018-08-14 14:40:34.867677|INFO    |              |   |myTeamSpeak identifier revocation list was downloaded successfully - all related features are activated
2018-08-14 14:40:38.316477|INFO    |              |   |Puzzle precompute time: 3476
2018-08-14 14:40:38.323000|INFO    |FileManager   |   |listening on 0.0.0.0:30033, [::]:30033
2018-08-14 14:40:38.323367|INFO    |VirtualSvrMgr |   |executing monthly interval
2018-08-14 14:40:38.326195|INFO    |VirtualSvrMgr |   |reset virtualserver traffic statistics
2018-08-14 14:40:38.420123|INFO    |VirtualServer |1  |listening on 0.0.0.0:9987, [::]:9987
2018-08-14 14:40:38.424605|INFO    |Query         |   |listening for query on 0.0.0.0:10011, [::]:10011
2018-08-14 14:40:38.426304|INFO    |CIDRManager   |   |updated query_ip_whitelist ips: 127.0.0.1/32, ::1/128,
```

## Docker troubleshooting
Check logs of gitbucket server container:
```bash
$ docker logs teamspeak
```

Review how things are deployed inside a running container, you can do this by executing a _bash shell_ through _docker's exec_ command:
```bash
docker exec -it teamspeak /bin/bash
```
