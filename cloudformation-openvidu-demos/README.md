# OpenVidu Demos on AWS

This repository is intended to be a point where the user can deploy OpenVidu Demos on an AWS instance.

## Community

### [OpenVidu Web Page](http://openvidu.io/)

## Different scenarios:
- __Turn and Self signed certificate__
- __Turn and Let's Encrypt certificate__

## Common steps

Independent of the scenario of your choice, there are some steps you should do in advance.

1. You definetly need an amazon' **AWS account**. If you don't have one go to [AWS website](https://www.amazon.com/ap/signin)

2. Then, you can log into your account to go to **Cloud Formation** tab. Find it in **AWS Dashboard** under **Management tools**.

3. Next, you see the **Cloud Formation** Dashboard where you have to press *Create Stack*.

4. Once there, you must upload [this](https://github.com/OpenVidu/openvidu-cloud-devops/blob/master/cloudformation-openvidu-demos/CF-OpenVidu-Demos-NoSignal.json) file we provide and press Next.

## Turn and Self signed certificate

1. Now, you should see a list of Parameters.

2. The first one is the *Stack Name*. Feel free to be as original as you want but we recomend __OpenVidu_Demos__ and we use this name throughout the docs.

3. In this scenario you don't need to complete the *Secure Socket Layer (SSL) Configuration* section.

4. Focus on the *Other parameters* 

    1. Choose an *Instance Type*. We recommended __t2.medium__ at least.

    2. Choose an existing *Key Name* in order to access the instance once it is built.

6. Press Next to continue.

7. The next screen gives you the chance to specify some __keys__ and other options. We are not using this screen right now. So you can press Next.

8. You can now review all the parameters you've introduced before. If everything looks great press Create.

9. You will see the *Stack* in *CREATE_IN_PROGRESS* state.

10. It takes about 7 to 10 minutes to deploy the Demo Software, so, please be patient. Once the deployment is ready you should be able to access the Demos throught the URL you can find under *Outputs* tab.

11. And that's it. Enjoy!

## Turn and Let's Encrypt certificate

**IMPORTANT**: You must allocate an *Elastic IP* and register on a valid DNS provider in order to use Let's Encrypt.

1. Now, you should see a list of Parameters.

2. The first one is the *Stack Name*. Feel free to be as original as you want but we recomend __OpenVidu_Demos__ and we use this name throughout the docs.

3. In the *Secure Socket Layer (SSL) Configuration* section we are going set up the information for Let's Encrypt.

    1. First of all, choose to use a Let's Encrypt Certificate from the drop-down menu.

    2. Enter your email address.

    3. Enter the Fully qualified domain name you've registered in your DNS provider.

    4. Enter the Elastic IP address you've allocated.

4. Check now *Other parameters* 

    1. Choose an *Instance Type*. We recommended __t2.medium__ at least.

    2. Choose an existing *Key Name* in order to access the instance once it is built.

6. Press Next to continue.

7. The next screen gives you the chance to specify some __keys__ and other options. We are not using this screen right now. So you can press Next.

8. You can now review all the parameters you've introduced before. If everything looks great press Create.

9. You will see the *Stack* in *CREATE_IN_PROGRESS* state.

10. It takes about 7 to 10 minutes to deploy the Demo Software, so, please be patient. Once the deployment is ready you should be able to access the Demos throught the URL you can find under *Outputs* tab.

11. And that's it. Enjoy!

**IMPORTANT**: Despite saying *CREATE_COMPLETE* it can take a bit longer to finish the deployment. Please be patient.

## Troubleshooting

### Shutdown the instance

We know that if you are not using an *Elastic IP* and you power off your instance the configuration won't be the same at new boot. If for any reason you powered off your instance, we recomend that you create a new one.