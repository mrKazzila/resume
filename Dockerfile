FROM texlive/texlive

RUN apt-get update && \
    apt-get install -y chktex

WORKDIR /data

COPY . /data
