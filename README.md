# encointer-sdk
docker-based source development kit with simulated enclaves

## USAGE

```
host> docker-compose -f sawtooth-pdo.yaml up
```

in new terminal, connect to validator console

```
host> sudo docker exec -it sawtooth-validator-pdo bash
validator> /mnt/pdo/validator-register-pdo.sh
```

in new terminal, run tests

```
host> sudo docker exec -it sawtooth-pdo-build bash
pdo-build> cd src/eservice/tests/
pdo-build> python test-secrets.py
pdo-build> python test-request.py --ledger http://rest-api:8008
pdo-build> python test-contract.py --ledger http://rest-api:8008
```
