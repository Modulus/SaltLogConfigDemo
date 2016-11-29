# Demonstration of Saltstack 2016.11.0 docker log_config
This shows how to setup a docker container with log_config in the 2016.11.0 release of Saltstack

## Test setup
The test setup consist of a salt-master which also has the salt-minion installed and configured.

## How do i run this?
1. git clone https://github.com/Modulus/SaltLogConfigDemo.git
2. cd into folder
3. vagrant up
4. vagrant ssh master
5. salt "*" state.highstate
6. Inspect the container

## Inspecing the container
1. sudo docker ps
2. sudo docker inspect container
3. sudo docker logs container

*should have log config on inspect*
![Inspect Image](/image/logconfig.PNG)

### Where is the state file?
In salt/container/init.sls
