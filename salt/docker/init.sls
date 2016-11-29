include:
  - docker.groups

python-pip-whl:
  pkg.removed

pip-install:
  pkg.installed:
    - name: python-pip
    - require:
      - pkg: python-pip-whl
    - stateful: True

dockerpy:
  pip.installed:
    - name: docker-py == 1.5.0
    - require:
      - pkg: python-pip-whl
      - pkg: pip-install
    - unless: pip list | grep docker-py==1.5.0


docker.dependencies:
  pkg.installed:
    - pkgs:
      - apt-transport-https
      - ca-certificates

#For ubuntu 14.x LTS
docker.repository:
  pkgrepo.managed:
    - humanname: Docker Repository
    - name: deb https://apt.dockerproject.org/repo ubuntu-trusty main
    - keyserver: hkp://p80.pool.sks-keyservers.net:80
    - keyid: 58118E89F3A912897C070ADBF76221572C52609D
    - require:
      - pip: dockerpy
      - sls: docker.groups

# Remove old repo if it exists
docker.purge.lxc-docker:
  pkg.purged:
   - name: lxc-docker

docker.installed:
  pkg.installed:
    - name: docker-engine
    - require:
      - pkg: docker.dependencies
      - pkg: docker.purge.lxc-docker
      - pkgrepo: docker.repository
      - pip: dockerpy
      - sls: docker.groups


docker.expose.home:
  environ.setenv:
    - name: DOCKER_HOST
    - value: unix:///var/run/docker.sock
    - update_minion: True
    - require:
      - pkg: docker.installed
