# run this on validator to register PDO
sawset proposal create --url http://rest-api:8008 --key /root/.sawtooth/keys/my_key.priv sawtooth.validator.transaction_families='[{"family": "intkey", "version": "1.0"}, {"family":"sawtooth_settings", "version":"1.0"}, {"family": "pdo_contract_enclave_registry", "version": "1.0"}, {"family":  "pdo_contract_instance_registry", "version": "1.0"}, {"family": "ccl_contract", "version": "1.0"}]'
sawset proposal create pdo.test.registry.measurements='c99f21955e38dbb03d2ca838d3af6e43ef438926ed02db4cc729380c8c7a174e'  --url http://rest-api:8008 --key /root/.sawtooth/keys/my_key.priv
sawset proposal create pdo.test.registry.basenames='b785c58b77152cbe7fd55ee3851c499000000000000000000000000000000000' --url http://rest-api:8008 --key /root/.sawtooth/keys/my_key.priv
sawset proposal create pdo.test.registry.public_key="$(cat /mnt/pdo/test_ias_pub_key.pem)" --url http://rest-api:8008 --key /root/.sawtooth/keys/my_key.priv


