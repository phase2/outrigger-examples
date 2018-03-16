<?php
/**
 * Common site settings.
 *
 * The process of running 'grunt install' will automatically set up a Drupal
 * sites/default/settings.php which includes this file.
 */

// Show errors including XDEBUG trace.
ini_set('display_errors', 1);
if (PHP_SAPI !== 'cli') {
  ini_set('html_errors', 1);
}

// Database connection settings.
$databases['default']['default'] = array (
  'database' => 'projectname_drupal',
  'username' => 'admin',
  'password' => 'admin',
  'prefix' => '',
  'host' => 'db',
  'port' => '',
  'namespace' => 'Drupal\\Core\\Database\\Driver\\mysql',
  'driver' => 'mysql',
);

// SMTP module settings for connection to the MailHog container.
$conf['smtp_host'] = 'mail';
$conf['smtp_port'] = '1025';


// Include local settings file as an override.
// settings.local.php should not be committed to the Git repository.
if (file_exists(__DIR__ . '/settings.local.php')) {
  include __DIR__ . '/settings.local.php';
}
