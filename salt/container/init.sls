include:
  - docker

pull python:
  dockerng.image_present:
    - name: python
    - require_in:
      - dockerng: build container image
    - require:
      - sls: docker


/var/container/main.py:
  file.managed:
    - source: salt://container/main.py
    - makedirs: True
    - mode: 0770
    - require_in:
      - dockerng: build container image
      - file: /var/container/Dockerfile
    - require:
      - sls: docker

# This is required of the python container
/var/container/requirements.txt:
  file.managed:
    - source: salt://container/requirements.txt
    - require:
      - file: /var/container/main.py

/var/container/Dockerfile:
  file.managed:
    - source: salt://container/Dockerfile
    - require_in:
      - dockerng: build container image
    - require:
      - sls: docker



build container image:
  dockerng.image_present:
    - build: /var/container
    - force: True
    - name: container
    - require:
      - sls: docker

start container:
  dockerng.running:
    - name: container
    - force: True
    - image: container
    - log_config:
        Type:  json-file
        Config:
          max-file: '5'
          max-size: '10K'
    - require:
      - sls: docker
      - dockerng: build container image
