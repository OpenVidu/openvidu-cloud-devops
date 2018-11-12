[![License badge](https://img.shields.io/badge/license-Apache2-orange.svg)](http://www.apache.org/licenses/LICENSE-2.0)
[![Documentation badge](https://img.shields.io/badge/docs-latest-brightgreen.svg)](http://openvidu.io/docs/home/)
[![Docker badge](https://img.shields.io/docker/pulls/fiware/orion.svg)](https://hub.docker.com/r/openvidu/classroom-demo/)
[![Support badge](https://img.shields.io/badge/support-sof-yellowgreen.svg)](https://groups.google.com/forum/#!forum/openvidu)

[![][OpenViduLogo]](http://openvidu.io)

openvidu-cloud-devops
===

Configuration files for automatic launching of [OpenVidu Server](http://openvidu.io/docs/deployment/deploying-aws/) and [OpenVidu Demos](http://openvidu.io/docs/deployment/deploying-demos-aws/) in AWS CloudFormation.

[OpenViduLogo]: https://secure.gravatar.com/avatar/5daba1d43042f2e4e85849733c8e5702?s=120

# Description

In this repo you can find the Ansible playbooks we use to deploy OpenVidu Server (cloudformation-openvidu folder) and Demos (cloudformation-openvidu-demos folder).

# Old releases

You can find old server releases on this urls:

- https://s3-eu-west-1.amazonaws.com/aws.openvidu.io/CF-OpenVidu-2.1.0.json
- https://s3-eu-west-1.amazonaws.com/aws.openvidu.io/CF-OpenVidu-2.2.0.json
- https://s3-eu-west-1.amazonaws.com/aws.openvidu.io/CF-OpenVidu-2.3.0.json
- https://s3-eu-west-1.amazonaws.com/aws.openvidu.io/CF-OpenVidu-2.4.0.json
- https://s3-eu-west-1.amazonaws.com/aws.openvidu.io/CF-OpenVidu-2.5.0.json
- https://s3-eu-west-1.amazonaws.com/aws.openvidu.io/CF-OpenVidu-2.5.1.json
- https://s3-eu-west-1.amazonaws.com/aws.openvidu.io/CF-OpenVidu-2.6.0.json (latest)

**Note**: Please, keep in mind that the stack is complex and it has dependencies outside our control so maybe some of this deployment fail for unknown reasons.
