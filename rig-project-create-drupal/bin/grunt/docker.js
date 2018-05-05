'use strict';

/**
 * Docker modifications for grunt-drupal-tasks
 */
module.exports = function(grunt) {

  if (!process.env.DOCKER_ENV) {
    return;
  }

  // If not explicitly set in Gruntconfig.json for the project set it.
  // In many cases, grunt-drupal-task configuration cannot be set this way.
  // This can be set because it is one of the commands which registers tasks
  // in a "late-binding" manner such that it hasn't already copied the config
  // into the related grunt plugins.
  var cmd = grunt.config.get('config.git.hook-command');
  if (!cmd) {
    grunt.config.set('config.git.hook-command', 'docker-compose -f build.yml run --rm grunt');
  }

}
