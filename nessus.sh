#!/bin/bash

function config_scanner {
	[ -n "${SCANNER_NAME}"      ] && /opt/pvs/bin/pvs --config "PVS Name" "${SCANNER_NAME}"
	[ -n "${PROXY_HOST}"        ] && /opt/pvs/bin/pvs --config "Web Proxy Host" "${PROXY_HOST}"
	[ -n "${PROXY_PORT}"        ] && /opt/pvs/bin/pvs --config "Web Proxy Port" "${PROXY_PORT}"
	[ -n "${PROXY_USER}"        ] && /opt/pvs/bin/pvs --config "Web Proxy Username" "${PROXY_USER}"
	[ -n "${PROXY_PASS}"        ] && /opt/pvs/bin/pvs --config "Web Proxy Password" "${PROXY_PASS}"
	[ -n "${PROXY_AGENT}"       ] && /opt/pvs/bin/pvs --config "Web Proxy User-Agent" "${PROXY_AGENT}"
	[ -n "${MANAGER_HOST}"      ] && /opt/pvs/bin/pvs --config "Cloud Host" "${MANAGER_HOST}"
	[ -n "${MANAGER_PORT}"      ] && /opt/pvs/bin/pvs --config "Cloud Port" "${MANAGER_PORT}"
	[ -n "${LINKING_KEY}"       ] && /opt/pvs/bin/pvs --config "Cloud Key" "${LINKING_KEY}"
	[ -n "${MONITOR_NETWORKS}"  ] && /opt/pvs/bin/pvs --config "Monitored Network IP Addresses and Ranges" "${MONITOR_NETWORKS}"
	[ -n "${EXCLUDE_NETWORKS}"  ] && /opt/pvs/bin/pvs --config "Excluded Network IP Addresses and Ranges" "${EXCLUDE_NETWORKS}"
	[ -n "${MONITOR_INTERFACE}" ] && /opt/pvs/bin/pvs --config "Monitored Network Interfaces" "${MONITOR_INTERFACE}"
	[ -n "${ADMIN_PASS}"        ] && /opt/pvs/bin/pvs --users --chpasswd "admin" "${ADMIN_PASS}"

	if [ -n "${LICENSE}" ];then
		/opt/pvs/bin/pvs -a "${LICENSE}"
	elif [ -n "${LINKING_KEY}" ];then
		/opt/pvs/bin/pvs -a "Cloud"
	fi
}

if [ "$(/opt/pvs/bin/pvs -k | grep "Not Activated" | wc -l)" == "1" ];then
	config_scanner
fi

/opt/pvs/bin/pvs