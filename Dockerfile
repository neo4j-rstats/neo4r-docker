FROM rocker/tidyverse

RUN apt-get install -y openjdk-8-jre && mkdir /home/neo4j && cd /home/neo4j && wget -O neo4j.tar.gz https://neo4j.com/artifact.php?name=neo4j-community-3.5.0-unix.tar.gz && tar xvf neo4j.tar.gz && rm neo4j.tar.gz 

RUN apt-get install -y libudunits2-dev

RUN R -e 'install.packages("remotes")' && R -e 'remotes::install_github("neo4j-rstats/neo4r")' && R -e 'install.packages("ggraph")' && R -e 'install.packages("visNetwork")'

RUN mkdir /home/rstudio/neo4r-examples

COPY neo4r-examples/ /home/rstudio/neo4r-examples

ENV NEOPASS=neo4j

CMD cd /home/neo4j && sudo chmod -R 777 neo4j-community-* && cd neo4j-community-* && sudo bin/neo4j-admin set-initial-password ${NEOPASS} && sudo bin/neo4j start && sudo bin/neo4j status && /init 