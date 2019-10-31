#!/bin/bash

function config_scanner {
	[ -n "${SCANNER_NAME}"      ] && /opt/nnm/bin/nnm --config "NNM Name" "${SCANNER_NAME}"
	[ -n "${PROXY_HOST}"        ] && /opt/nnm/bin/nnm --config "Web Proxy Host" "${PROXY_HOST}"
	[ -n "${PROXY_PORT}"        ] && /opt/nnm/bin/nnm --config "Web Proxy Port" "${PROXY_PORT}"
	[ -n "${PROXY_USER}"        ] && /opt/nnm/bin/nnm --config "Web Proxy Username" "${PROXY_USER}"
	[ -n "${PROXY_PASS}"        ] && /opt/nnm/bin/nnm --config "Web Proxy Password" "${PROXY_PASS}"
	[ -n "${PROXY_AGENT}"       ] && /opt/nnm/bin/nnm --config "Web Proxy User-Agent" "${PROXY_AGENT}"
	[ -n "${MANAGER_HOST}"      ] && /opt/nnm/bin/nnm --config "Cloud Host" "${MANAGER_HOST}"
	[ -n "${MANAGER_PORT}"      ] && /opt/nnm/bin/nnm --config "Cloud Port" "${MANAGER_PORT}"
	[ -n "${LINKING_KEY}"       ] && /opt/nnm/bin/nnm --config "Cloud Key" "${LINKING_KEY}"
	[ -n "${MONITOR_NETWORKS}"  ] && /opt/nnm/bin/nnm --config "Monitored Network IP Addresses and Ranges" "${MONITOR_NETWORKS}"
	[ -n "${EXCLUDE_NETWORKS}"  ] && /opt/nnm/bin/nnm --config "Excluded Network IP Addresses and Ranges" "${EXCLUDE_NETWORKS}"
	[ -n "${MONITOR_INTERFACE}" ] && /opt/nnm/bin/nnm --config "Monitored Network Interfaces" "${MONITOR_INTERFACE}"
	[ -n "${ADMIN_PASS}"        ] && /opt/nnm/bin/nnm --users --chpasswd "admin" "${ADMIN_PASS}"

	if [ -n "${LICENSE}" ];then
		/opt/nnm/bin/nnm -a "${LICENSE}"
	elif [ -n "${LINKING_KEY}" ];then
		/opt/nnm/bin/nnm -a "Cloud"
	fi
}

if [ "$(/opt/nnm/bin/nnm -k | grep "Not Activated" | wc -l)" == "1" ];then
	config_scanner
fi

/opt/nnm/bin/nnm