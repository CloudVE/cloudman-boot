#!/usr/bin/python
import argparse
import base64
import os
import yaml

from cloudbridge.factory import CloudProviderFactory, ProviderList


def get_bootstrap_data():
    bootstrap_data = os.environ.get('CM_INITIAL_CLUSTER_DATA')
    # Pad data: https://gist.github.com/perrygeo/ee7c65bb1541ff6ac770
    data = base64.b64decode(bootstrap_data + "===").decode('utf-8')
    return yaml.safe_load(data)


def get_provider_config(json_data):
    config = json_data.get('cloud_config')
    target = config.get('target')
    zone = target.get('target_zone')
    cloud = zone.get('cloud')
    region = zone.get('region')
    credentials = config.get('credentials', {})

    provider_config = {}
    provider_config.update(zone)
    provider_config.update(region)
    provider_config.update(cloud)
    provider_config.update(credentials)

    return provider_config


def main():
    cloudlaunch_data = get_bootstrap_data()
    provider_config = get_provider_config(cloudlaunch_data)

    provider = CloudProviderFactory().create_provider(ProviderList.AZURE, provider_config)
    inst_id = cloudlaunch_data.get('host_config', {}).get('instance_id')
    this_inst = provider.compute.instances.get(inst_id)
    print(this_inst.name)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Print Azure VM name')
    args = parser.parse_args()

    main()
