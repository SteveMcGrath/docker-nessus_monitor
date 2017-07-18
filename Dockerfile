FROM centos:7

ENV LINKING_KEY	 ""
ENV SCANNER_NAME ""
ENV MANAGER_HOST ""
ENV MANAGER_PORT ""
ENV PROXY_HOST	 ""
ENV PROXY_PORT	 ""
ENV PROXY_USER	 ""
ENV PROXY_PASS	 ""
ENV PROXY_AGENT	 ""
ENV MONITOR_NETWORKS ""
ENV EXCLUDE_NETWORKS ""
ENV MONITOR_INTERFACE ""
ENV ADMIN_PASS ""
ENV LICENSE ""

COPY nessus.sh /usr/bin
COPY download.py /tmp
COPY supervisor.conf /etc

RUN chmod 755 /usr/bin/nessus.sh									\
	&& python /tmp/download.py										\
	&& yum -y -q install epel-release 								\
	&& yum -y -q install /tmp/NessusMonitor.rpm supervisor iproute	\
	&& yum -y -q clean all											\
	&& chmod 755 /usr/bin/nessus.sh									\
	&& rm -f /tmp/NessusMonitor.rpm									\
	&& rm -f /tmp/*

VOLUME /opt/pvs/var/pvs
EXPOSE 8835

CMD ["/usr/bin/supervisord", "-nc", "/etc/supervisor.conf"]