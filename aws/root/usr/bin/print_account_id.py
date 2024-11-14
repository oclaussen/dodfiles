#!/usr/bin/env python
import argparse
import boto3
import sys

parser = argparse.ArgumentParser(description='Print account id for profile name')
parser.add_argument('profile', nargs='?', help='The config profile')
parser.add_argument('--all', action='store_true', help='Print all account ids')
args = parser.parse_args()

session = boto3.session.Session()
profiles = session._session._config['profiles']

if args.all:
    for name, profile in profiles.items():
        if 'role_arn' in profile:
            account_id = profile['role_arn'].split(':')[4]
            print('%s:\t%s' % (name, account_id))
    exit(0)

if args.profile not in profiles:
    print('Profile not found')
    sys.exit(1)

profile = profiles[args.profile]

if 'role_arn' not in profile:
    print('Profile does not specify assume role')
    sys.exit(1)

account_id = profile['role_arn'].split(':')[4]
print(account_id)
