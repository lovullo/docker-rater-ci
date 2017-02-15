FROM openjdk:7

RUN apt-get update -y \
    && apt-get install -y \
        ant             \
        autoconf        \
        automake        \
        bash            \
        gawk            \
        git             \
        make            \
        openssh-client  \
        php5            \
        rsync           \
        time            \
        unzip           \
        wget            \
    && rm -rf /var/lib/apt/lists/*

# Download and install saxon jar
RUN wget https://downloads.sourceforge.net/project/saxon/Saxon-HE/9.7/SaxonHE9-7-0-15J.zip \
    && test "$( sha256sum SaxonHE9-7-0-15J.zip | cut -d' ' -f1 )" = daa159f44e9eb4d8de4b60826c7abe33e4a1fe57e94b21f7abd4cedb3a265a0f \
    && mkdir -p /usr/share/ant/lib/saxon9/ \
    && unzip SaxonHE9-7-0-15J.zip saxon9he.jar -d /usr/share/ant/lib/saxon9/

# Disable host key checking from within builds as we cannot interactively accept them
# TODO: It might be a better idea to bake ~/.ssh/known_hosts into the container
RUN mkdir -p ~/.ssh
RUN printf "Host *\n\tStrictHostKeyChecking no\n\n" > ~/.ssh/config
