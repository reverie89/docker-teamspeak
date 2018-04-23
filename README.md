# Teamspeak server in a Docker image for x86/x64
Repo forked from [pozgo's docker-teamspeak](https://github.com/pozgo/docker-teamspeak)

Instead of using 3.0.13.8, this fork is modified to always use the latest version available from [Teamspeak website](https://www.teamspeak.com/downloads)

Tested successfully on latest Alpine 3.7, teamspeak 3.1.1 (auto-updated to 3.1.8 on boot)

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
  -e TS3SERVER_LICENSE=accept
  reverie89/teamspeak
```

## Server administrator access and ServerAdmin privilege key
Admin login details can be found on first run in logs of running container. Make sure you save them. After restarting the container those details are not available anymore. See logs by typing `docker logs -f ts3`  

Example output:  

```bash
Installing Teamspeak version:
Teamspeak version:  installed.
2018-04-23 12:53:13.442803|INFO    |ServerLibPriv |   |TeamSpeak 3 Server 3.1.1 (2018-02-26 11:14:04)
2018-04-23 12:53:13.443667|INFO    |ServerLibPriv |   |SystemInformation: Linux 4.4.0-119-generic #143-Ubuntu SMP Mon Apr 2 16:08:24 UTC 2018 x86_64 Binary: 64bit
2018-04-23 12:53:13.443982|WARNING |ServerLibPriv |   |The system locale is set to "C" this can cause unexpected behavior. We advice you to repair your locale!
2018-04-23 12:53:13.444359|INFO    |ServerLibPriv |   |Using hardware aes
2018-04-23 12:53:13.446126|INFO    |DatabaseQuery |   |dbPlugin name:    SQLite3 plugin, Version 3, (c)TeamSpeak Systems GmbH
2018-04-23 12:53:13.446509|INFO    |DatabaseQuery |   |dbPlugin version: 3.11.1
2018-04-23 12:53:13.447311|INFO    |DatabaseQuery |   |checking database integrity (may take a while)
2018-04-23 12:53:13.482496|INFO    |SQL           |   |db_CreateTables() tables created

------------------------------------------------------------------
                      I M P O R T A N T
------------------------------------------------------------------
               Server Query Admin Account created
         loginname= "serveradmin", password= "rIF1JpHH"
------------------------------------------------------------------

2018-04-23 12:53:13.803817|WARNING |Accounting    |   |Unable to open licensekey.dat, falling back to limited functionality
2018-04-23 12:53:13.804891|INFO    |Accounting    |   |Licensing Information
2018-04-23 12:53:13.805194|INFO    |Accounting    |   |licensed to       : Anonymous
2018-04-23 12:53:13.805497|INFO    |Accounting    |   |type              : No License
2018-04-23 12:53:13.805817|INFO    |Accounting    |   |starting date     : Wed May 31 22:00:00 2017
2018-04-23 12:53:13.806120|INFO    |Accounting    |   |ending date       : Fri Aug 31 22:00:00 2018
2018-04-23 12:53:13.806417|INFO    |Accounting    |   |max virtualservers: 1
2018-04-23 12:53:13.806965|INFO    |Accounting    |   |max slots         : 32
2018-04-23 12:53:17.570585|INFO    |              |   |Puzzle precompute time: 3720
2018-04-23 12:53:17.577376|INFO    |FileManager   |   |listening on 0.0.0.0:30033, [::]:30033
2018-04-23 12:53:17.582353|INFO    |VirtualSvrMgr |   |executing monthly interval
2018-04-23 12:53:17.587470|INFO    |VirtualSvrMgr |   |reset virtualserver traffic statistics

------------------------------------------------------------------
                      I M P O R T A N T
------------------------------------------------------------------
      ServerAdmin privilege key created, please use it to gain
      serveradmin rights for your virtualserver. please
      also check the doc/privilegekey_guide.txt for details.

       token=RUduc+6xFZXGOQGulYYhUcR5PX+25TtevvY15TeY
------------------------------------------------------------------

2018-04-23 12:53:17.657711|INFO    |VirtualServer |1  |listening on 0.0.0.0:9987, [::]:9987
2018-04-23 12:53:17.661402|WARNING |VirtualServer |1  |--------------------------------------------------------
2018-04-23 12:53:17.662106|WARNING |VirtualServer |1  |ServerAdmin privilege key created, please use the line below
2018-04-23 12:53:17.662181|WARNING |VirtualServer |1  |token=RUduc+6xFZXGOQGulYYhUcR5PX+25TtevvY15TeY
2018-04-23 12:53:17.662239|WARNING |VirtualServer |1  |--------------------------------------------------------
2018-04-23 12:53:17.663244|INFO    |CIDRManager   |   |updated query_ip_whitelist ips: 127.0.0.1/32, ::1/128,
2018-04-23 12:53:17.664480|INFO    |Query         |   |listening on 0.0.0.0:10011, [::]:10011
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
