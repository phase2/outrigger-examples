# Mailhog Development SMTP Server

## Usage

Start mailhog with `docker-compose up`
 
You can also add the `mail` service defined in the `docker-compose.yml` file to your projects compose file.

If you do so, be sure to configure the web server with network access to mailhog, such as by adding
the mail service to the web containers `links` configuration.

## Drupal

Use the [SMTP module](https://www.drupal.org/project/smtp) in your project.

### Composer-based Installation

```
composer require --dev drupal/smtp
```

> If your production codebase may need SMTP configuration, remove the `--dev`
flag above. You will need to be sure to vary the SMTP module configuration
by environment.


### Environment Configuration

Add the following configuration to your settings.php for the dev environment:

#### Drupal 7 format

```
$conf['smtp_host'] = 'mail';
$conf['smtp_port'] = '1025';
```

#### Drupal 8 format

```
$config['smtp_host'] = 'mail';
$config['smtp_port'] = '1025';
```

### Manual Installation & Configuration

* Install the SMTP module.
* Navigate to `admin/config/system/smtp`
* Enable SMTP mail transport (Special config form option to "Turn this module on".)
* Enter anything into the form for host and port, you may repeat the environment
  configuration above but it will be silently overridden by our settings.php

### Testing

* Send a test email from the SMTP module configuration page.
* Navigate your browser to to http://mail.projectname.vm:8025
