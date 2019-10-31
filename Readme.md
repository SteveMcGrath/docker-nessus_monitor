# Unofficial Nessus Network Monitor Image

Tenable's Nessus Network Monitor is a passive sniffer that looks to discover hosts within the environment, detect known vulnerabilities, discover malware, find potential configuration issues, etc. through packet inspection and analysis of that data.  For more information about Nessus Network Monitor, please consult the following links:

* [Nessus Network Monitor product page](http://www.tenable.com/products/nessus-network-monitor)
* [Nessus Network Monitor latest docs](https://docs.tenable.com/pvs/Content/AboutPVS.htm)

Please note that as this is a network sniffer, you will either need to attach a second interface with mirrored traffic or run the container in privileged mode to listen to the physical interface.

# Build files

The github repository for the build files is located [here](https://github.com/stevemcgrath/docker-nessus_monitor).

# Supported tags

Each image is tagged with the major, minor, and patch releases.  The most current image is always tagged as "latest".  For the current listing of tags, please refer to the [tags tab](https://hub.docker.com/r/stevemcgrath/nessus_monitor/tags/) for a current listing.

# Usage

```
docker volume create nessus_monitor_var
docker create -v nessus_monitor_var:/opt/nnm/var/nnm \
		--name=nessus_monitor \
		-e SCANNER_NAME=${SCANNER_NAME} \
		-e LINKING_KEY=${LINKING_KEY} \
		-e MONITOR_INTERFACE=eth1 \
		stevemcgrath/nessus_monitor:latest
docker network connect span nessus_monitor
docker start nessus_monitor
```

# Environmental Variables

**NOTE**: You must specify either a linking key or a license code.

* **LINKING_KEY** _**(required)**_ - Linking key to use for linking the scanner to Tenable.io
* **LICENSE** _**(required)**_ - Activation code (if not a Tenable.io linked scanner)
* **SCANNER_NAME** _**(required)**_ - Sets the sensor name for the linking process (Tenable.io only)
* **MANAGER_HOST** _(optional)_ - Nessus Manager address
* **MANAGER_PORT** _(optional)_ - Nessus Manager service port
* **PROXY_HOST** _(optional)_ - Proxy address
* **PROXY_PORT** _(optional)_ - Proxy service port
* **PROXY_USER** _(optional)_ - Proxy account username
* **PROXY_PASS** _(optional)_ - Proxy account password
* **PROXY_AGENT** _(optional)_ - Proxy agent string
* **MONITOR_NETWORKS** _(optional)_ - What networks should the Nessus monitor look for?
* **EXCLUDE_NETWORKS** _(optional)_ - What networks should the Nessus monitor exclude?
* **MONITOR_INTERFACE** _(optional)_ - What interface within the container should Nessus Monitor listen on?
* **ADMIN_PASS** _(optional)_ - Specify a password for the admin user