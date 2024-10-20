#!/bin/bash

CALICO_MANIFEST_URL="https://raw.githubusercontent.com/projectcalico/calico/refs/tags/v3.28.2/manifests/calico.yaml"
TEMP_MANIFEST="calico-dualstack.yaml"
POD_IPV4_CIDR="192.168.0.0/16"
POD_IPV6_CIDR="fd00:10:244::/64"

curl -o $TEMP_MANIFEST $CALICO_MANIFEST_URL

sed -i "s#- name: CALICO_IPV4POOL_CIDR.*#- name: CALICO_IPV4POOL_CIDR\n        value: \"$POD_IPV4_CIDR\"#g" $TEMP_MANIFEST
sed -i "/- name: CALICO_IPV4POOL_CIDR/a\        - name: CALICO_IPV6POOL_CIDR\n        value: \"$POD_IPV6_CIDR\"" $TEMP_MANIFEST
sed -i "/- name: CALICO_IPV6POOL_CIDR/a\        - name: CALICO_IPV6POOL_NAT_OUTGOING\n        value: \"true\"" $TEMP_MANIFEST

kubectl apply -f $TEMP_MANIFEST
rm $TEMP_MANIFEST
