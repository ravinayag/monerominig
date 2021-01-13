### entrypoint
#!/bin/sh

minexmr_wallet="49szjjsAJxbdQnYTB4U5miTPx18FQAS3eSckd6ZArJtu429oHXtLa485G45CWPXuP2SX5fsNQhSgw4ALKGWdeShfU8gFyFZ" 

### Environment variables.
export - POOL_URL=us-west.minexmr.com:443
export - POOL_USER=49szjjsAJxbdQnYTB4U5miTPx18FQAS3eSckd6ZArJtu429oHXtLa485G45CWPXuP2SX5fsNQhSgw4ALKGWdeShfU8gFyFZ
export - POOL_PASS=
export - DONATE_LEVEL=5
export - CPU_PRIORITY=0
export - CPU_THREADS=2
export - ACCESS_TOKEN=
export - ALGO=rx/0
export - COIN=monero
export - WORKER_PASS=xmRwallet786    # a99e697a280c8fb5e35cbc1d682c8884192a240aa00fad8bc5e4793a0c7913ee
export - PORT=8000
export - HHOST=0.0.0.0



####################################################
if [ "$POOL_USER" == ${minexmr_wallet} ]; then
    sha=$(echo -n "$WORKER_PASS" | sha256sum | awk '{print $1}')
    if [ "$WORKER_PASS" != "" ]; then
        echo -e "\033[32mSHA verified\033[0m"
        echo "Worker name is $WORKER_PASS"
    else
        # there, it's for donators, so the password is "donator + uuid"
        WORKER_PASS="donator-$(uuidgen)"
        echo
        echo -e "\033[36mYour a donator \033[0m Thanks a lot, your donation id is \033[34m$WORKER_PASS\033[0m"
        echo
    fi
fi


# API access token to get xmrig information
if [ "$ACCESS_TOKEN" == "" ]; then
    ACCESS_TOKEN=$(uuidgen)
    echo
    echo -e "You didn't set ACCESS_TOKEN environment variable,"
    echo -e "we generated that one: \033[32m${ACCESS_TOKEN}\033[0m"
    echo 
    echo -e "\033[31m ⚠ Waring, this token will change the next time you will restart docker container, it's recommended to provide one and keep it secret\033[0m"
    echo 
fi

if [ "${WORKER_PASS}" != "" ]; then
    PASS_OPTS="--pass=${WORKER_PASS}"
fi


if [ "$CPU_THREADS" -gt 0 ]; then
    CPU_THREADS="-t $CPU_THREADS"
fi


if [ "$CPU_PRIORITY" -ge 0 ] && [ "$CPU_PRIORITY" -le 5 ]; then
    CPU_PRIORITY=$CPU_PRIORITY
fi

# for others parameters
if [ "$COIN" != "" ]; then
    OTHERS_OPTS=$OTHERS_OPTS" --coin=$COIN"
fi

if [ "$ALGO" != "" ]; then
    OTHERS_OPTS=$OTHERS_OPTS" --algo=$ALGO"
fi
