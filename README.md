# custom_miniconda_build
custom container build of miniconda with Travis CI integration and push to Docker Hub
---

custom miniconda build that contains only libraries that we really need
we can specify for example numpy, pandas, matplotlib ...
maintainer: tcoil.info
 
build as
sudo docker build -t custom_miniconda .

run this image as
coil@coil:~/Desktop/miniconda_docker_build$ sudo docker run --name custom_miniconda -i -t -p 8888:8888 -v "${PWD}:/notebooks" custom_miniconda
or with docker compose demonized
