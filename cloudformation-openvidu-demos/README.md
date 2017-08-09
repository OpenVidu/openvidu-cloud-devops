# OpenVidu Demos on AWS

This repository is intended to be a point where the user can deploy OpenVidu Demos on an AWS instance.

## Community

### [OpenVidu Web Page](http://openvidu.io/)

## Different scenarios:
- __Stun and Self signed certificate__
- __Turn and Self signed certificate__
- __Stun and Let's Encrypt certificate__
- __Turn and Let's Encrypt certificate__

## Common steps

Independent of the scenario of your choice, there are some steps you should do in advance.

1. You definetly need an amazon' **AWS account**. If you don't have one go to [AWS website](https://www.amazon.com/ap/signin)

2. Then, you can log into your account to go to **Cloud Formation** tab. Find it in **AWS Dashboard** under **Management tools**.

3. Next, you see the **Cloud Formation** Dashboard where you have to press *Create Stack*.

4. Once there, you must upload this file we provide: URL CF JSON FILE and press Next.

## Stun and Self signed certificate

1. Now, you should see a list of Parameters.

2. The first one is the *Stack Name*. Feel free to be as original as you want but we recomend __OpenVidu_Demos__ and we use this name throughout the docs.

3. In this scenario you don't need to complete the *Secure Socket Layer (SSL) Configuration* section.

4. Focus on the *Stun/Turn Configuration*.

    1. You must provide the *Stup IP* and *Stun Port* you want to connect to.

    2. That's it in this section.

5. Move forward to *Other parameters* 

    1. Choose an *Instance Type*. We recommended __t2.medium__ at least.

    2. Choose an existing *Key Name* in order to access the instance once it is built.

6. Press Next to continue.

7. The next screen gives you the chance to specify some __keys__ and other options. We are not using this screen right now. So you can press Next.

8. You can now review all the parameters you've introduced before. If everything looks great press Create.

9. You will see the *Stack* in *CREATE_IN_PROGRESS* state.

10. It takes about 7 to 10 minutes to deploy the Demo Software, so, please be patient. Once the deployment is ready you should be able to access the Demos throught the URL you can find under *Outputs* tab.

11. And that's it. Enjoy!

## Turn and Self signed certificate

1. Now, you should see a list of Parameters.

2. The first one is the *Stack Name*. Feel free to be as original as you want but we recomend __OpenVidu_Demos__ and we use this name throughout the docs.

3. In this scenario you don't need to complete the *Secure Socket Layer (SSL) Configuration* section.

4. Focus on the *Stun/Turn Configuration*.

    1. Choose *Turn* from the drop-down menu.

    2. You must provide the *Turn Username* and *Turn Password* you want to use.

    2. That's it in this section.

5. Move forward to *Other parameters* 

    1. Choose an *Instance Type*. We recommended __t2.medium__ at least.

    2. Choose an existing *Key Name* in order to access the instance once it is built.

6. Press Next to continue.

7. The next screen gives you the chance to specify some __keys__ and other options. We are not using this screen right now. So you can press Next.

8. You can now review all the parameters you've introduced before. If everything looks great press Create.

9. You will see the *Stack* in *CREATE_IN_PROGRESS* state.

10. It takes about 7 to 10 minutes to deploy the Demo Software, so, please be patient. Once the deployment is ready you should be able to access the Demos throught the URL you can find under *Outputs* tab.

11. And that's it. Enjoy!


## Stun and Let's Encrypt certificate

**IMPORTANT**: You must allocate an *Elastic IP* and register on a valid DNS provider in order to use Let's Encrypt.

1. Now, you should see a list of Parameters.

2. The first one is the *Stack Name*. Feel free to be as original as you want but we recomend __OpenVidu_Demos__ and we use this name throughout the docs.

3. In the *Secure Socket Layer (SSL) Configuration* section we are going set up the information for Let's Encrypt.

    1. First of all, choose to use a Let's Encrypt Certificate from the drop-down menu.

    2. Enter your email address.

    3. Enter the Fully qualified domain name you've registered in your DNS provider.

    4. Enter the Elastic IP address you've allocated.

4. Focus on the *Stun/Turn Configuration*.

    1. You must provide the *Stup IP* and *Stun Port* you want to connect to.

    2. That's it in this section.

5. Move forward to *Other parameters* 

    1. Choose an *Instance Type*. We recommended __t2.medium__ at least.

    2. Choose an existing *Key Name* in order to access the instance once it is built.

6. Press Next to continue.

7. The next screen gives you the chance to specify some __keys__ and other options. We are not using this screen right now. So you can press Next.

8. You can now review all the parameters you've introduced before. If everything looks great press Create.

9. You will see the *Stack* in *CREATE_IN_PROGRESS* state.

10. It takes about 7 to 10 minutes to deploy the Demo Software, so, please be patient. Once the deployment is ready you should be able to access the Demos throught the URL you can find under *Outputs* tab.

11. And that's it. Enjoy!

**IMPORTANT**: Despite saying *CREATE_COMPLETE* it can take a bit longer to finish the deployment. Please be patient.

## Turn and Let's Encrypt certificate

**IMPORTANT**: You must allocate an *Elastic IP* and register on a valid DNS provider in order to use Let's Encrypt.

1. Now, you should see a list of Parameters.

2. The first one is the *Stack Name*. Feel free to be as original as you want but we recomend __OpenVidu_Demos__ and we use this name throughout the docs.

3. In the *Secure Socket Layer (SSL) Configuration* section we are going set up the information for Let's Encrypt.

    1. First of all, choose to use a Let's Encrypt Certificate from the drop-down menu.

    2. Enter your email address.

    3. Enter the Fully qualified domain name you've registered in your DNS provider.

    4. Enter the Elastic IP address you've allocated.

4. Focus on the *Stun/Turn Configuration*.

    1. Choose *Turn* from the drop-down menu.

    2. You must provide the *Turn Username* and *Turn Password* you want to use.

    2. That's it in this section.

5. Move forward to *Other parameters* 

    1. Choose an *Instance Type*. We recommended __t2.medium__ at least.

    2. Choose an existing *Key Name* in order to access the instance once it is built.

6. Press Next to continue.

7. The next screen gives you the chance to specify some __keys__ and other options. We are not using this screen right now. So you can press Next.

8. You can now review all the parameters you've introduced before. If everything looks great press Create.

9. You will see the *Stack* in *CREATE_IN_PROGRESS* state.

10. It takes about 7 to 10 minutes to deploy the Demo Software, so, please be patient. Once the deployment is ready you should be able to access the Demos throught the URL you can find under *Outputs* tab.

11. And that's it. Enjoy!

**IMPORTANT**: Despite saying *CREATE_COMPLETE* it can take a bit longer to finish the deployment. Please be patient.