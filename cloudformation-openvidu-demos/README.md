# OpenVidu Demos on AWS

This repository is intended to be a point where the user can deploy OpenVidu Demos on an AWS instance.

## Community

### [OpenVidu Web Page](http://openvidu.io/)

## Different scenarios:
- __TURN and self-signed certificate__
- __TURN and Let's Encrypt certificate__

## Common steps

Independent of the scenario of your choice, there are some steps you should do in advance.

1. You definetly need an Amazon **AWS account**. If you don't have one go to [AWS website](https://www.amazon.com/ap/signin)

2. Then, log into your account and open the **CloudFormation** service. Find it in **AWS Dashboard** under **All services** > **Management Tools**.

3. Next, you see the **CloudFormation** Dashboard where you have to press *Create new stack*.

4. Once there, you must upload [this file](https://github.com/OpenVidu/openvidu-cloud-devops/blob/master/cloudformation-openvidu-demos/CF-OpenVidu-Demos-NoSignal.json) we provide and press Next.

## TURN and self-signed certificate

1. Now, you should see a list of Parameters.

2. The first one is the *Stack name*. Feel free to be as original as you want but we recomend __OpenVidu-Demos__ as we use this name throughout the docs.

3. In this scenario you don't need to complete the section *Let's Encrypt Configuration (Optional)*.

4. In the section *Other parameters*:

    1. Choose an value for *InstanceType*. We recommend __t2.medium__ at least.

    2. Choose a value for *KeyName*. It must be the name of an existing EC2 Key Pair, used later to access the instance through SSH. If you haven't already created an EC2 Key Pair, [check the documentation](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html) and create or import a new key.

5. Press Next to continue.

6. The next screen gives you the chance to specify some __keys__ and other options. We are not using this screen right now, so you can press Next.

7. You can now review all the parameters you've introduced before. If everything looks great, press Create.

8. You will see the *Stack* in *CREATE_IN_PROGRESS* status.

9. It takes about 7 to 10 minutes to deploy the Demo Software, so please be patient. Once the deployment is ready you should be able to access the Demos throught the URL you can find under the *Outputs* tab.

10. And that's it. Enjoy!

## TURN and Let's Encrypt certificate

**IMPORTANT**: You must allocate an *Elastic IP* and register on a valid DNS provider in order to use Let's Encrypt.

1. Now, you should see a list of Parameters.

2. The first one is the *Stack name*. Feel free to be as original as you want but we recomend __OpenVidu-Demos__ as we use this name throughout the docs.

3. In the section *Let's Encrypt Configuration (Optional)* we are going set up the information for Let's Encrypt:

    1. First of all, choose to use a Let's Encrypt Certificate from the drop-down menu.

    2. Enter your email address.

    3. Enter the Fully Qualified Domain Name you've registered with your DNS provider.

    4. Enter the Elastic IP address you've allocated.

4. In the section *Other parameters*:

    1. Choose an value for *InstanceType*. We recommend __t2.medium__ at least.

    2. Choose a value for *KeyName*. It must be the name of an existing EC2 Key Pair, used later to access the instance through SSH. If you haven't already created an EC2 Key Pair, [check the documentation](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html) and create or import a new key.

5. Press Next to continue.

6. The next screen gives you the chance to specify some __keys__ and other options. We are not using this screen right now, so you can press Next.

7. You can now review all the parameters you've introduced before. If everything looks great, press Create.

8. You will see the *Stack* in *CREATE_IN_PROGRESS* status.

9. It takes about 7 to 10 minutes to deploy the Demo Software, so please be patient. Once the deployment is ready you should be able to access the Demos throught the URL you can find under the *Outputs* tab.

10. And that's it. Enjoy!

**IMPORTANT**: Despite saying *CREATE_COMPLETE* it can take a bit longer to finish the deployment. Please be patient.

## Troubleshooting

### Shutdown the instance

We know that if you are not using an *Elastic IP* and you power off your instance the configuration won't be the same at new boot. If for any reason you powered off your instance, we recomend that you create a new one.
