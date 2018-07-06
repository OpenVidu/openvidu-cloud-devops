# OpenVidu Demos on AWS

This repository allow you to easily deploy an Amazon EC2 instance for OpenVidu Server.

## Community

### [OpenVidu Web Page](http://openvidu.io/)

## Different scenarios:
- __Self signed certificate__
- __Let's Encrypt certificate__

## Common steps

Independent of the scenario of your choice, there are some steps you should do in advance.

1. You definetly need an amazon' **AWS account**. If you don't have one go to [AWS website](https://www.amazon.com/ap/signin)

2. Then, you can log into your account to go to **Cloud Formation** tab. Find it in **AWS Dashboard** under **Management tools**.

3. Next, you see the **Cloud Formation** Dashboard where you have to press *Create Stack*.

4. Once there, you must upload [this](https://s3-eu-west-1.amazonaws.com/aws.openvidu.io/CF-OpenVidu.json) file we provide and press Next.

## Self signed certificate

1. Now, you should see a list of Parameters.

2. The first one is the *Stack Name*. Feel free to be as original as you want but we recomend __OpenVidu_Demos__ and we use this name throughout the docs.

3. In this scenario you don't need to complete the *Let's Encrypt Configuration (Optional) Configuration* section.

4. In the *OpenVidu Security* choose true or false depends on if you want to use security.

5. Focus on the *Other parameters* 

    1. Choose an *Instance Type*. We recommended __t2.medium__ at least.

    2. Choose an existing *Key Name* in order to access the instance once it is built.

6. Press Next to continue.

7. The next screen gives you the chance to specify some __keys__ and other options. We are not using this screen right now. So you can press Next.

8. You can now review all the parameters you've introduced before. If everything looks great press Create.

9. You will see the *Stack* in *CREATE_IN_PROGRESS* state.

10. It takes about 7 to 10 minutes to deploy the Demo Software, so, please be patient. Once the deployment is ready you should be able to access the Demos throught the URL you can find under *Outputs* tab.

11. And that's it. Enjoy!

## Let's Encrypt certificate

**IMPORTANT**: You must allocate an *Elastic IP* and register on a valid DNS provider in order to use Let's Encrypt.

1. Now, you should see a list of Parameters.

2. The first one is the *Stack Name*. Feel free to be as original as you want but we recomend __OpenVidu_Demos__ and we use this name throughout the docs.

3. In the *Let's Encrypt Configuration (Optional) Configuration* section we are going set up the information for Let's Encrypt.

    1. First of all, choose to use a Let's Encrypt Certificate from the drop-down menu.

    2. Enter your email address.

    3. Enter the Fully qualified domain name you've registered in your DNS provider.

    4. Enter the Elastic IP address you've allocated.

4. In the *OpenVidu Security* choose true or false depends on if you want to use security.

5. Check now *Other parameters* 

    1. Choose an *Instance Type*. We recommended __t2.medium__ at least.

    2. Choose an existing *Key Name* in order to access the instance once it is built.

6. Press Next to continue.

7. The next screen gives you the chance to specify some __keys__ and other options. We are not using this screen right now. So you can press Next.

8. You can now review all the parameters you've introduced before. If everything looks great press Create.

9. You will see the *Stack* in *CREATE_IN_PROGRESS* state.

10. It takes about 7 to 10 minutes to deploy the Demo Software, so, please be patient. Once the deployment is ready you should be able to access the Demos throught the URL you can find under *Outputs* tab.

11. And that's it. Enjoy!

**IMPORTANT**: Despite saying *CREATE_COMPLETE* it can take a bit longer to finish the deployment. Please be patient.

## Adding your own app

Would you like to add your own app to the instance? 

First of all, you must login into the instance using your AWS key. In doubt, [check this tutorial](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AccessingInstancesLinux.html). Then become to root.

```sudo -s```

If your app is plain HTML and JS and CSS just copying it under */var/www/html/YOUR_APP* directory. Then, you should be able to access through **https://DNS NAME OR FQDN/YOUR_APP** 

You can use git clone, [scp](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AccessingInstancesLinux.html#AccessingInstancesLinuxSCP) or [Filezilla](https://beamtic.com/connect-to-aws-ec2-with-ftp) to upload your files.

If your app is Java, then follow this steps:

1. Copy your JAR into a folder under */var/www/html* using one of the ways we discuss before.

2. Write a script to launch your app with all the parameters it needs.

3. Nginx

You must register your app in the proxy service. Simply, edit */etc/nginx/sites-enabled/default* and add a new **location** directive for your app, like:


```
location /YOUR_APP {
    rewrite /YOUR_APP(.*) /$1 break;
    proxy_pass https://localhost:PORT;
}
```

In example, your app is called *foo* and listen to connection on *port 5000*, then the **location** directive should looks like:

```
location /foo {
    rewrite /foo(.*) /$1 break;
    proxy_pass https://localhost:5000;
}
```

**location directive must be inside a _server_ context**

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

The access to the OpenVidu endpoint depends on your own app, we provide an OpenVidu server listening for incoming connections on ports 5443 and 8443. From inside the instance both ports are reachable, while from the outside only 8443 is available. Keep this in mind in order to run your app.

Then restart supervisor

```
# systemctl restart supervisor
```

Alternatively, you may want to launch your app in the command line like:

```
# java -Dopenvidu.url=https://XXX:8443 -Dfoo.param1=value ... -jar foo.jar
```

Change **XXX** for an appropiate value.

Now, you should be able to access through **https://AWS DNS NAME or FQDN/YOUR_APP**

6. Troubleshooting

If your app is not working as expected, there is a few files you should check for debuging:

*/var/log/nginx/* Contains information about the proxy.

*/var/log/supervisor/* Contains information about the output of your app.

You can also try to connect to the app directly to the port like: https://AWS_EC2_URL:YOUR_APP_PORT

