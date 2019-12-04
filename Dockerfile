# custom miniconda build that contains only libraries that we really need
# we can specify for example numpy, pandas, matplotlib ...
# maintainer: tcoil.info
# 
# build as
# sudo docker build -t custom_miniconda .
#
# run this image as
# coil@coil:~/Desktop/miniconda_docker_build$ sudo docker run --name custom_miniconda -i -t -p 8888:8888 -v "${PWD}:/notebooks" custom_miniconda
# or with docker compose demonized


FROM centos:8

RUN yum update -y
RUN yum install -y wget

RUN wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh


# install in batch (silent) mode, does not edit PATH or .bashrc or .bash_profile
# -b batch
# -p path
# -f force
RUN bash Miniconda3-latest-Linux-x86_64.sh -b

ENV PATH=/root/miniconda3/bin:${PATH} 

#RUN source /root/.bashrc
#RUN source /root/.bash_profile

RUN conda update -y conda
RUN conda list
RUN conda install -y numpy \
                     matplotlib \
                     pandas

RUN conda install -y jupyter notebook

# create directory for notebooks
RUN mkdir /notebooks


# cleanup
RUN rm Miniconda3-latest-Linux-x86_64.sh

EXPOSE 8888

# start the jupyter notebook in server mode
ENTRYPOINT ["jupyter","notebook"]
CMD ["--ip=0.0.0.0","--port=8888","--no-browser","--allow-root", "--notebook-dir=/notebooks"]
