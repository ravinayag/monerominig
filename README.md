# monero minig

# Xmrig - Monero minner in Docker / Docker Compose

Here, you can launch xmrig as a docker container to make it easy to launch it on local computer using standard docker command.

[Xmrig](https://xmrig.com/) is an opensource project to mine Monero cryptocurrency.

The image is based on Alpine for light weight and works, for now, only on Linux hosts.

- Note: To make the container mining for **your wallet**, you'll need to have a monero wallet (see https://supportxmr.com/) and follow instructions. 
- Note: The Xmrig API is set to port 8000, see documentation: https://github.com/xmrig/xmrig/blob/v3.2.0/doc/API.md
- Note: this is a CPU version of Xmrig.

If you would like to customize and want to donate for project, here is my Wallet address:

'49szjjsAJxbdQnYTB4U5miTPx18FQAS3eSckd6ZArJtu429oHXtLa485G45CWPXuP2SX5fsNQhSgw4ALKGWdeShfU8gFyFZ'

## Launch it

Simple as a pie:

```bash
docker run --rm -it ravinayag/xmrig:latest
```

You can set up the container to **mine for your wallet**, You have to change your wallet id at POOL_USER.

simply change following options using environment variables:

```bash
export POOL_URL="here, pool url"
export POOL_USER="Your public monero address"
export POOL_PASS="can be empty for some pool, other use that as miner id"
export DONATE_LEVEL="xmrig project donation in percent, default is 5"

# launch docker container
docker run --name miner --rm -it \
    -e POOL_URL=$POOL_URL \
    -e POOL_USER=$POOL_USER \
    -e POOL_PASS=$POOL_PASS \
    -e DONATE_LEVEL=$DONATE_LEVEL \ 
    metal3d/xmrig
```
`DONATE_LEVEL` is **not a donation to me**, it's the donation included in xmrig project to help developers to continue the project. Please, to help them, let the donation to 5.

Press CTRL+C to stop container, and it will be removed.

See below for complete environment variable list.

# Default

By default:

- user is mine
- password is "donator" + uuid
- donation level to xmrig project is "5" (5%)

To not make your CPU burning, this container set:

- number of threads = number CPU / 2
- priority to CPU idle (0) - that makes mining process to be activated only when CPU is not used

Complete list of supported environment variable:

- `POOL_USER`: your wallet address, default to mine
- `POOL_URL`: the pool address
- `POOL_PASS`: the pool password, or worker id, following the pool documentation
- `DONATE_LEVEL`: percentage of donation to Xmrig.com project (please, leave the default that is 5 or above, XMrig is a nice project, give'em a bit CPU time)
- `PRIORITY`: CPU priority. 0=idle, 1=normal, 2 to 5 for higher priority
- `THREADS`: number of thread to start, default to number CPU / 2
- `ACCESS_TOKEN`: Bearer access token to access to xmrig API (served on 8000 port), default is a generated token (uuid)
- `ALGO`: mining algorithm https://xmrig.com/docs/algorithms (default is empty)
- `COIN`: that is the coin option instead of algorithm (default is empty)

