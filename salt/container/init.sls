pull python:
  dockerng.image_present:
    - name: python
    - require_in:
      - dockerng: build container image


/var/main.py:
  file.managed:
    - source: salt://container/main.py
    - require_in:
      - dockerng: build container image

/var/Dockerfile:
  file.managed:
    - source: salt://container/Dockerfile
    - require_in:
      - dockerng: build container image

build container image:
  dockerng.image_present:
    - build: /var/Dockerfile
    - name: container

start container:
  dockerng.running:
    - name: cont
    - image: container
    - log_config:
        Type:  json-file
        Config:
          max-file: '5'
          max-size: '10K'   
