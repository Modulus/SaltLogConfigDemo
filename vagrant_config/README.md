# Demonstration of Saltstack 2016.11.0 docker log_config
This shows how to setup a docker container with log_config in the 2016.11.0 release of Saltstack
## How do i run this?
1. git clone https://github.com/Modulus/SaltLogConfigDemo.git
2. cd into folder
3. vagrant up
4. vagrant ssh
5. salt "*" state.highstate
6. Inspect the container

## Where is the state file?
Checkout salt/container/init.sls
