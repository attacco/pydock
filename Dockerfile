FROM oraclelinux:7

RUN yum -y install oraclelinux-developer-release-el7 && \
    yum -y install python3 \
                   python3-libs \
                   python3-pip \
                   python3-setuptools \
                   libaio
RUN rm -rf /var/cache/yum/*

RUN pip3 install cx_Oracle==8.3.0

RUN mkdir -p /opt/oracle/instantclient
COPY instantclient /opt/oracle/instantclient
ENV LD_LIBRARY_PATH=/usr/lib:/opt/oracle/instantclient:$LD_LIBRARY_PATH

RUN mkdir /work
WORKDIR /work
VOLUME ["/work"]

CMD ["/bin/bash"]
