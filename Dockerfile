FROM openjdk:7-alpine

RUN apk update \
    && apk add \
        apache-ant      \
        autoconf        \
        automake        \
        bash            \
        ca-certificates \
        git             \
        make            \
        openssh         \
        rsync           \
        wget            \
    && update-ca-certificates \
    && rm -rf /var/cache/apk/*

# Download and install saxon jar
RUN wget https://downloads.sourceforge.net/project/saxon/Saxon-HE/9.7/SaxonHE9-7-0-15J.zip \
    && mkdir -p /usr/share/ant/lib/saxon9/ \
    && unzip SaxonHE9-7-0-15J.zip saxon9he.jar -d /usr/share/ant/lib/saxon9/

# Disable host key checking from within builds as we cannot interactively accept them
# TODO: It might be a better idea to bake ~/.ssh/known_hosts into the container
RUN mkdir -p ~/.ssh
RUN printf "Host *\n\tStrictHostKeyChecking no\n\n" > ~/.ssh/config
