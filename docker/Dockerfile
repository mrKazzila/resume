FROM texlive/texlive:latest

RUN { apt-get update && \
     apt-get install -y \
        poppler-utils \
        ghostscript \
        lmodern \
        fonts-dejavu \
        fonts-liberation && \
     rm -rf /var/lib/apt/lists/*; } || echo "Some apt packages failed to install"

RUN { tlmgr update --self && \
     tlmgr install \
        luaotfload \
        fontspec \
        pdfxcmds && \
     fc-cache -fv; } || echo "Some texlive packages failed to install"

WORKDIR /data

COPY ../ /data
