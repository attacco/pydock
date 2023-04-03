FROM oraclelinux:7-slim

ARG RELEASE=19
ARG UPDATE=18
ARG TNS_ADMIN="/etc/oracle/instantclient/network/admin"
ARG WORK_DIR="/work"

RUN  yum -y install oracle-release-el7-1.0 && \
     yum -y install oracle-instantclient${RELEASE}.${UPDATE}-basic \
                    oracle-instantclient${RELEASE}.${UPDATE}-devel \
                    oracle-instantclient${RELEASE}.${UPDATE}-sqlplus && \
     yum -y install oraclelinux-developer-release-el7-1.0 && \
     yum -y install python3-3.6.8 \
                    python3-libs-3.6.8 \
                    python3-pip-9.0.3 \
                    libaio-0.3.109 \
                    git-1.8.3.1 && \
     rm -rf /var/cache/yum/*

RUN pip3 install cx_Oracle==8.3.0

RUN mkdir -p $TNS_ADMIN
ENV TNS_ADMIN=$TNS_ADMIN

RUN mkdir -p $WORK_DIR
WORKDIR $WORK_DIR

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/bash"]
