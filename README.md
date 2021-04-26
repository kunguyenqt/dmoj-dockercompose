DMOJ Docker
=====

This repository contains the Docker files to run a clone of the [DMOJ site](https://github.com/DMOJ/online-judge). It configures some additional services, such as mathoid and texoid.

This is use some scritps and config from [Ninjaclasher](https://github.com/Ninjaclasher/dmoj-docker)

## Installation

First, [Docker](https://www.docker.com/) and [Docker Compose](https://docs.docker.com/compose/) must be installed. Installation instructions can be found on their respective websites.

Clone the repository:
```sh
$ git clone https://github.com/kunguyenqt/dmoj-dockercompose
$ cd dmoj-dockercompose
$ git submodule update --init --recursive
```

Configure the environment variables in the files in `env/site.env`, `env/judge1.env`, `env/mysql.env`. In particular. Also, configure the `server_name` directive in `site/nginx.conf`.

Next, build the images:
```sh
$ docker-compose build
```

Start up the site, so you can perform the initial migrations and generate the static files:
```sh
$ docker-compose up -d site
```

You will need to generate the schema for the database, since it is currently empty:
```sh
$ ./scripts/migrate
```

You will also need to generate the static files:
```
$ ./scripts/copy_static
```

Finally, the DMOJ comes with fixtures so that the initial install is not blank. They can be loaded with the following commands:
```sh
$ ./scripts/manage.py loaddata navbar
$ ./scripts/manage.py loaddata language_small
$ ./scripts/manage.py loaddata demo
```

## Usage
```
$ docker-compose up -d
```

## Notes

### Migrating
As the DMOJ site is a Django app, you may need to migrate whenever you update. Assuming the site container is running, running the following command should suffice:
```sh
$ ./scripts/migrate
```

### Managing Static Files
If your static files ever change, you will need to rebuild them:
```
$ ./scripts/copy_static
```

### Updating The Site
Updating various sections of the site requires different images to be rebuilt.

If any prerequisites were modified, you will need to rebuild most of the images:
```sh
$ docker-compose up -d --build site
```
If the static files are modified, read the section on [Managing Static Files](#managing-static-files).

If only the source code is modified, a restart is sufficient:
```sh
$ docker-compose restart site
```