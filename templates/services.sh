#!/usr/bin/bash
# clone this to somewhere contains executable
# vim: ft=bash
# -----
# constants, change these
root="$HOME/repos/<your_repository>"
jdk=$JAVA_HOME
services=(
  '<service_1>'
  '<service_2>'
)
log_dir="$HOME/repos/logs"

if [ ! -d "$log_dir" ]; then
  echo "creating log dir"
  mkdir -p "$log_dir"
fi

function _run_jvm_service() {
  # relative path to module, must NOT include trailing / in the path if specified
  local path=${1:-''}
  cd $root/$path
  local mod="$(mvn help:evaluate -Dexpression=project.artifactId -q -DforceStdout)"
  cd $root
  # package module if needed
  if ! [[ -f "$root/$path/target/$mod-1.0-SNAPSHOT.jar" ]]; then
    echo "packaging $mod..."
    mvn package -T 5 -pl :$mod -am
    echo "finished packaging $mod"
  fi

  local props=''
  if [[ -f "$root/$path/configuration.properties" ]]; then
    props="$root/configuration.properties:$path/configuration.properties"
  elif [[ -f "$root/$path/configuration.properties.edn" ]]; then
    props="$path/configuration.properties.edn"
  fi

  echo "starting [$mod]"
  cmd="$jdk/bin/java -ea -Dlogback.configurationFile=file://$root/logback-dev.xml -Dic.configurationFile=$props -jar $root/$path/target/$mod-1.0-SNAPSHOT.jar"
  nohup $cmd > "$log_dir/$mod.log" 2>&1 &
}

function _stop_jvm_service() {
  # relative path to module, must NOT include trailing / in the path if specified
  local path=${1:-''}
  cd $root/$path
  local mod="$(mvn help:evaluate -Dexpression=project.artifactId -q -DforceStdout)"
  echo "stopping $mod..."
  ps -u $(whoami) -v | grep "$mod-1.0-SNAPSHOT.jar" | grep -v grep | awk '{print $1}' | xargs kill
  sleep 10
  ps -u $(whoami) -v | grep "$mod-1.0-SNAPSHOT.jar" | grep -v grep | awk '{print $1}' | xargs kill -9
  echo "$mod stopped"
}

function _clean_jvm_service() {
  # relative path to module, must NOT include trailing / in the path if specified
  local path=${1:-''}
  cd $root/$path
  local mod="$(mvn help:evaluate -Dexpression=project.artifactId -q -DforceStdout)"
  cd $root
  echo "cleaning $mod..."
  mvn clean -pl :$mod
  echo "finished cleaning $mod"
  rm -f "$log_dir/$mod.log"
}

function start() {
  rm -f $log_dir/*
  # start jvm services
  for service in "${services[@]}"; do
    _run_jvm_service $service
  done
  echo 'all done, use `status` command to verify'
}

function status() {
  ps -u $(whoami) -v | grep '1.0-SNAPSHOT.jar' | grep -v grep | awk '{printf "%s [%s] %s %s [%s]\n", $1, $3, $13, $14, $18}'
  local running=$(ps -u $(whoami) -v | grep '1.0-SNAPSHOT.jar' | grep -v grep | wc -l)
  total=${#services[@]}
  echo "expect [$total] services, [$running] are running"
}

function restart() {
  for index in "${!services[@]}"; do
    echo "[$index]: ${services[$index]}"
  done
  read -p "select service: " selected

  if [[ $selected =~ ^[0-9]+$ ]] && [ $selected -ge 0 ] && [ $selected -lt ${#services[@]} ]; then
    local service="${services[$selected]}"
    _stop_jvm_service "$service"
    _clean_jvm_service "$service"
    _run_jvm_service "$service"
  else
    echo "invalid index, please enter a number between 0 and $((${#services[@]} - 1))."
  fi
}

function stop() {
  echo 'stop all services gracefully'
  ps -u $(whoami) -v | grep '1.0-SNAPSHOT.jar' | grep -v grep | awk '{print $1}' | xargs kill
  echo 'done, use `status` command to verify'
}

function fstop() {
  echo 'force stop all services'
  ps -u $(whoami) -v | grep '1.0-SNAPSHOT.jar' | grep -v grep | awk '{print $1}' | xargs kill -9
  echo 'done, use `status` command to verify'
}

# run desired command
case $1 in
  start)
    start
    ;;
  status)
    status
    ;;
  stop)
    stop
    ;;
  fstop)
    fstop
    ;;
  restart)
    restart
    ;;
  *)
    echo "usage: $0 {start|status|stop|fstop|restart}"
    exit 1
    ;;
esac
