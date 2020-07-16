[![License badge](https://img.shields.io/badge/license-Apache2-orange.svg)](http://www.apache.org/licenses/LICENSE-2.0)
[![Documentation Status](https://readthedocs.org/projects/openviduio-docs/badge/?version=stable)](https://docs.openvidu.io/en/stable/?badge=stable)
[![Docker badge](https://img.shields.io/docker/pulls/fiware/orion.svg)](https://hub.docker.com/r/openvidu/classroom-demo/)
[![Support badge](https://img.shields.io/badge/support-sof-yellowgreen.svg)](https://groups.google.com/forum/#!forum/openvidu)

[![][OpenViduLogo]](http://openvidu.io)

openvidu-cloud-devops
===

:warning: :warning: :warning:

> This repository is deprecated. OpenVidu CE is now deployed using Docker and Docker Compose. New content of OpenVidu CE deployments
> are in this repository: https://github.com/OpenVidu/openvidu/tree/master/openvidu-server/deployments/ce

:warning: :warning: :warning:

:warning: :warning: :warning:

> If you are here because you want to deploy OpenVidu CE follow this instructions:
> - AWS: https://docs.openvidu.io/en/2.15.0/deployment/deploying-aws/
> - On Premises: https://docs.openvidu.io/en/2.15.0/deployment/deploying-on-premises/

:warning: :warning: :warning:

Configuration files for automatic launching of [OpenVidu Server](http://docs.openvidu.io/en/stable/deployment/deploying-aws/) and [OpenVidu Demos](http://docs.openvidu.io/en/stable/deployment/deploying-demos-aws/) in AWS CloudFormation.

[OpenViduLogo]: https://secure.gravatar.com/avatar/5daba1d43042f2e4e85849733c8e5702?s=120

# Description

In this repo you can find the Ansible playbooks we use to deploy OpenVidu Server (cloudformation-openvidu folder).

# Deploying

Please refer to the OpenVidu official documentation [here](https://docs.openvidu.io/en/stable/deployment/deploying-aws/). The latest release for AWS CloudFormation is this [one](https://s3-eu-west-1.amazonaws.com/aws.openvidu.io/CF-OpenVidu-latest.yaml)

# Troubleshooting

If you face some issue deploying the templates check out the doc [here](https://github.com/OpenVidu/openvidu-cloud-devops/blob/master/docs/AWS_Deploy_Troubleshooting.md)

# Old releases

You can find old server releases on this urls:

- https://s3-eu-west-1.amazonaws.com/aws.openvidu.io/CF-OpenVidu-2.1.0.json
- https://s3-eu-west-1.amazonaws.com/aws.openvidu.io/CF-OpenVidu-2.2.0.json
- https://s3-eu-west-1.amazonaws.com/aws.openvidu.io/CF-OpenVidu-2.3.0.json
- https://s3-eu-west-1.amazonaws.com/aws.openvidu.io/CF-OpenVidu-2.4.0.json
- https://s3-eu-west-1.amazonaws.com/aws.openvidu.io/CF-OpenVidu-2.5.0.json
- https://s3-eu-west-1.amazonaws.com/aws.openvidu.io/CF-OpenVidu-2.6.0.json
- https://s3-eu-west-1.amazonaws.com/aws.openvidu.io/CF-OpenVidu-2.7.0.json
- https://s3-eu-west-1.amazonaws.com/aws.openvidu.io/CF-OpenVidu-2.8.0.json
- https://s3-eu-west-1.amazonaws.com/aws.openvidu.io/CF-OpenVidu-2.9.0.yaml
- https://s3-eu-west-1.amazonaws.com/aws.openvidu.io/CF-OpenVidu-2.10.0.yaml
- https://s3-eu-west-1.amazonaws.com/aws.openvidu.io/CF-OpenVidu-2.11.0.yaml
- https://s3-eu-west-1.amazonaws.com/aws.openvidu.io/CF-OpenVidu-2.12.0.yaml


**Note**: Please, keep in mind that the stack is complex and it has dependencies outside our control so maybe some of this deployment fail for unknown reasons.
