FROM centos:7
LABEL maintainer 'György Novák <gyorgy.novak@loxxly.com>'

RUN yum install -y wget java-1.8.0-openjdk-devel

RUN groupadd -r pio && useradd --no-log-init -r -g pio pio

WORKDIR /home/pio
RUN chown -R pio:pio /home/pio

ENV PIO_HOME /home/pio/PredictionIO-0.13.0

USER pio

RUN wget http://apache.mirror.anlx.net/predictionio/0.13.0/apache-predictionio-0.13.0-bin.tar.gz && \
    tar zxvf apache-predictionio-0.13.0-bin.tar.gz && \
    rm apache-predictionio-0.13.0-bin.tar.gz && \
    mkdir PredictionIO-0.13.0/vendors && \
    # Spark
    wget http://d3kbcqa49mib13.cloudfront.net/spark-2.1.1-bin-hadoop2.6.tgz && \
    tar zxvfC spark-2.1.1-bin-hadoop2.6.tgz PredictionIO-0.13.0/vendors && \
    rm spark-2.1.1-bin-hadoop2.6.tgz && \
    # Elasticsearch
    wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.5.2.tar.gz && \
    tar zxvfC elasticsearch-5.5.2.tar.gz PredictionIO-0.13.0/vendors && \
    rm elasticsearch-5.5.2.tar.gz && \
    # HBase
    wget http://archive.apache.org/dist/hbase/1.2.6/hbase-1.2.6-bin.tar.gz && \
    tar zxvfC hbase-1.2.6-bin.tar.gz PredictionIO-0.13.0/vendors && \
    rm hbase-1.2.6-bin.tar.gz

ADD conf/pio-env.sh $PIO_HOME/conf/pio-env.sh
ADD conf/hbase-site.xml $PIO_HOME/vendors/hbase-1.2.6/conf/hbase-site.xml
ADD conf/hbase-env.sh $PIO_HOME/vendors/hbase-1.2.6/conf/hbase-env.sh
ADD conf/pio-daemon  $PIO_HOME/bin/pio-daemon
ADD conf/run.sh /home/pio/run.sh

WORKDIR $PIO_HOME

EXPOSE 8000

ENTRYPOINT ["/bin/bash"]
CMD ["/home/pio/run.sh"]
