# Example Drupal 8 Development Environment

Example Drupal 8 development environment using Outrigger.

## Setup

Proceed through these steps from the examples/drupal8 directory:

### 1. Use the build container to run composer to fetch a copy of Drupal 8 and store it in `./build/html` with:

```bash
rig project setup
```

or you can use the underlying commands:

```bash
rig project sync:start
docker-compose -f build.yml run --rm composer install --prefer-dist
```

The `--rm` portion of the command ensures that containers are cleaned up after they exit so you don't need to later do a `docker rm CONTAINER_ID` command

### 2. Start the Apache/PHP and MariaDB containers with:

```bash
rig project up
```

or you can use the underlying commands:

```bash
rig project sync:start
docker-compose up
```

### 3. Start a new terminal:

  - We leave the old terminal running so that we can see any log messages from within the containers.
  - Be sure it has your Outrigger environment configured. If not run `eval "$(rig config)"`

### 4. Ensure the installer has permissions to create the settings files and files directory with:

  - `docker-compose exec www cp /var/www/build/html/sites/default/default.settings.php /var/www/build/html/sites/default/settings.php`
  - `docker-compose exec www chown -R apache:apache /var/www/build/html/sites/default`
  - **NOTE:** You will get a few `Operation not permitted` messages, this is normal.

### 5. You should be able to load the Drupal 8 installer by navigating to:

  - http://www.d8.vm/

### 6. Proceed through the installation with:

```bash
rig project run:install
```

or you can use the underlying command:

```bash
docker-compose -f build.yml run --rm drush site-install --site-name="Outrigger Drupal Example" --db-url=mysql://admin:admin@db/drupal8
```

## Working with the Project

### 1. Running drush commands on the site

  - `docker-compose -f build.yml run --rm drush cache-rebuild`

### 2. Running composer commands on the site

  - `docker-compose -f build.yml run --rm composer <command>`

### 3. Getting a CLI on the code base (this will open a bash shell)

  - `docker-compose -f build.yml run --rm cli`

### 4. Importing a private key into the build container

When you need to clone data that is in a private repo, you will need to pass your SSH private key into the container so that it can be used with git to clone your project.  

Uncomment the volume in build.yml's base service.

> !!! NOTE !!!
> If your private key has a name other than `id_rsa` then first set `export OUTRIGGER_SSH_KEY=<filename>`
