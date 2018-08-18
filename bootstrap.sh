#!/bin/ash
set -e
TS3_DATABASE="/opt/teamspeak/ts3server.sqlitedb"
# Functions
sig_int () {
    echo "SIGINT received"
    kill -2 ${pid}
}

sig_term () {
    echo "SIGTERM received"
    kill -15 ${pid}
}

install_ts3() {
  TS3_VERSION="$(w3m -dump https://www.teamspeak.com/downloads | grep -m 1 'Server 64-bit ' | awk '{print $NF}')" && \
  echo "Installing Teamspeak version: ${TS3_VERSION}"
  wget http://dl.4players.de/ts/releases/${TS3_VERSION}/teamspeak3-server_linux_amd64-${TS3_VERSION}.tar.bz2 -O /tmp/teamspeak.tar.bz2 && \
  apk del w3m wget
  mkdir -p /opt/teamspeak
  touch /opt/teamspeak/.ts3server_license_accepted
  tar jxf /tmp/teamspeak.tar.bz2 -C /opt/teamspeak --strip-components=1
  rm -f /tmp/teamspeak.tar.bz2
  echo "Teamspeak version: ${TS3_VERSION} installed."
}

if [[ ! -e ${TS3_DATABASE} ]]; then
  install_ts3
fi

./opt/teamspeak/ts3server_minimal_runscript.sh $@ &
pid=$!
trap sig_int  INT
trap sig_term TERM

wait $pid
