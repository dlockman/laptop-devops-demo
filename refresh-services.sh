#!/usr/bin/env bash

show_help() {
    echo "Usage: $0 -s [Service Set (pas, pdp, accounts)]"
    echo 'Optional args: -l [Local Service on host machine, one arg for each local service (e.g. -l account -l user_auth)]'
    exit 1
}

use_docker_machine() {
    export PRIVATE_IP=$(docker-machine ip myDockerMachine)
    eval $(docker-machine env myDockerMachine)
    ./clear_dangling_docker_images.sh
}

start_services() {
    SERVICE_SET=`cat ./config/service_sets/${SERVICE_SET_NAME}`
    COMMON_DEPENDENCIES = "kafka,zookeeper,mongo,swagger"

    ruby generate_services_nginx.rb ${LOCAL_SET[@]}
    if [[ $? != 0 ]]; then
        echo "Nginx Services config generation failed"
        exit 1
    fi

    docker-compose up -d ${COMMON_DEPENDENCIES}

    docker-compose build ${SERVICE_SET}
    docker-compose up -d ${SERVICE_SET}
}

configure_local() {
    if [[ -n "$LOCAL_SET" ]]
    then
        docker-compose stop ${LOCAL_SET[@]}
    fi
}



while getopts "hs:e:l:" OPTION
do
    case $OPTION in
        h)
            show_help
            ;;
        s)
            SERVICE_SET_NAME="${OPTARG}"
            ;;
        l)
            LOCAL_SET+=("${OPTARG}")
            ;;
        *)
            show_help
            ;;
    esac
done

if [[ -z "$SERVICE_SET_NAME"  ]] || [[ -z "$ENVIRONMENT"  ]]
then
    show_help
fi

SERVICE_SET=`cat ./config/service_sets/${SERVICE_SET_NAME}`

use_docker_machine
start_services
configure_local LOCAL_SET

echo "-- Refreshed services in the set [${SERVICE_SET_NAME}]"
if [[ -n "$LOCAL_SET" ]]
then
    echo "-- Configured for following services to run locally on host machine: [${LOCAL_SET[@]}]"
fi