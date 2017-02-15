# Example Drupal 8 Development Environment

Example Drupal 8 development environment using Outrigger.

## Setup

Proceed through these steps from the examples/drupal8 directory:

### 1. Use the build container to run composer to fetch a copy of Drupal 8 and store it in `./build/html` with:

  - `docker-compose -f build.yml run --rm composer-install`

The --rm portion of the comand ensures that containers are cleaned up after they exit so you don't need to later do a `docker rm CONTAINER_ID` command

### 2. Start the Apache/PHP and MariaDB containers with:

  - `docker-compose up`

### 3. Start a new terminal:

  - We leave the old terminal running `docker-compose up` so that we can see any log messages from within the containers.
  - Be sure it has your Dev Tools environment configured. If not run `eval $(devtools config)`

### 4. Ensure the installer has permissions to create the settings files and files directory with:

  - `docker-compose exec www cp /var/www/build/html/sites/default/default.settings.php /var/www/build/html/sites/default/settings.php`
  - `docker-compose exec www chown -R apache:apache /var/www/build/html/sites/default`

### 5. You should be able to load the Drupal 8 installer by navigating to:

  - http://www.d8.vm/

### 6. Proceed through the installation

### 7. Configure the database

  - Database name: drupal8_example
  - Database user: admin
  - Database password: admin
  - Database host: db.d8.vm

## Working with the project

### 1. Running drush commands on the site

  - `docker-compose -f build.yml run --rm drush cache-rebuild`

### 2. Running grunt commands on the site

  - `docker-compose -f build.yml run --rm grunt <command>`

### 3. Running composer commands on the site

  - `docker-compose -f build.yml run --rm composer <command>`

### 4. Getting a CLI on the code base (this will open a bash shell)

  - `docker-compose -f build.yml run --rm cli`

### 5. Importing a private key into a build container

When you need to clone data that is in a private repo, you will need to pass your
SSH private key into the container so that is can be used with git to clone your
project.  

To get your private key into the build container, volume mount your key into the container at `/root/.ssh/outrigger.key` and it will be processed accordingly.

`~/.ssh/id_rsa:/root/.ssh/outrigger.key`

!!! NOTE !!!
If your private key has a name other than `id_rsa` then use that key in the volume mount above.

