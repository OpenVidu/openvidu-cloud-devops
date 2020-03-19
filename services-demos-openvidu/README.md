This folder contains the files necessary to run/update OpenVidu Demos inside the OpenVidu Server Pro Node of an OpenVidu Pro cluster.

## Files

### `/etc/systemd/system/`

- `openvidu.service`
- `js-java.service`
- `classroom-demo.service`

### `/$HOME/`

- `update-demos.sh`
- `OpenViduCall-demos-config-file.json`

### `/var/www/html/basic-webinar/`

- `basic-webinar/app.sh`

### `/var/www/html/classroom/`

- `classroom/app.sh`

---

## OpenVidu Server Pro Node requirements

These services are required to run the demos. Some of them may be already installed in the Ubuntu instance.

- `sytemctl` is used for managing the services

- `ngnix` is used as reverse proxy

- `Java 8` is used to run Java demos

      sudo apt-get install -y openjdk-8-jre

- `mysql` is used by OpenVidu Classroom demo

      sudo apt-get install -y mysql-server
      sudo mysql_secure_installation
      mysql -u root -p
      CREATE DATABASE openvidu_sample_app;
      exit

---

## Extra information

- Running `update-demos.sh` will download and update all the demos (to change the version it is necessary to modify the script).
- To update any OpenVidu Server configuration parameter, file `/opt/openvidu/application.properties` must be updated.
