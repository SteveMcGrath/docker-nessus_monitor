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

COPY nessus.sh /usr/bin/
COPY yum.repo /etc/yum.repos.d/Tenable.repo
COPY gpg.key /etc/pki/rpm-gpg/RPM-GPG-KEY-Tenable

RUN    yum -y update                                                    \
    && yum -y install nnm                                               \
    && yum -y clean all                                                 \
    && chmod 755 /usr/bin/nessus.sh                                     \
    && echo -e "export PATH=$PATH:/opt/nnm/bin" >> /etc/bashrc

EXPOSE 8835

CMD ["/usr/bin/nessus.sh"]