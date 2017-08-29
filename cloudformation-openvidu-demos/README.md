# OpenVidu Demos on AWS

This repository is intended to be a point where the user can deploy OpenVidu Demos on an AWS instance.

## Table of Contents

- [Community](#Community)
- [Different scenarios](#Different scenarios)
  * [TURN and self-signed certificate](#TURN and self-signed certificate)
  * [TURN and Let's Encrypt certificate](#TURN and Let's Encrypt certificate)
- [Adding your own app](#Adding your own app)
- [Troubleshooting](#Troubleshooting)
  * [Shutdown the instance](#Shutdown the instance)

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

## Adding your own app

Would you like to add your own app to the instance? 

First of all, you must login into the instance using your AWS key. In doubt, [check this tutorial](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AccessingInstancesLinux.html).

If you app is plain HTML and JS and CSS just copying it under */var/www/html/YOUR_APP* directory. Then, you should be able to access through **https://AWS_EC2_URL/YOUR_APP** 

If your app is Java, then follow this steps:

1. Copy your JAR into a folder under */var/www/html*

2. Write a script to launch your app with all the parameters it needs.

3. Nginx

You must register your app in the proxy service. Simply, edit */etc/nginx/sites-enabled/default* and add a new **upstream** for your app, like:

```
upstream YOUR_APP {
    server EC_2_INSTANCE_IP:YOUR_APP_PORT;
}
```

and a new **location directive**, like:

```
location /YOUR_APP {
    rewrite /YOUR_APP(.*) /$1 break;
    proxy_pass https://YOUR_APP;
}
```

Don't forget to reload nginx:

```
# systemctl restart nginx
```

4. Supervisor

We use Supervisor for process control. You can add the script you wrote at step #2 to */etc/supervisor/conf.d/openvidu.conf* like:

```
[program:YOUR_APP]
command=/bin/bash /var/www/html/YOUR_APP/YOUR_LAUNCHER.sh YOUR_APP_PARAM_#1 YOUR_APP_PARAM_#2 ...
redirect_stderr=true
```

Then restart supervisor

```
# systemctl restart supervisor
```

Now, you should be able to access through **https://AWS_EC2_URL/YOUR_APP**

6. Troubleshooting

If your app is not working as expected, there is a few files you should check for debuging:

*/var/log/nginx/* Contains information about the proxy.

*/var/log/supervisor/* Contains information about the output of your app.

You can also try to connect to the app directly to the port like: https://AWS_EC2_URL:YOUR_APP_PORT

## Troubleshooting

### Shutdown the instance

We know that if you are not using an *Elastic IP* and you power off your instance the configuration won't be the same at new boot. If for any reason you powered off your instance, we recomend that you create a new one.
