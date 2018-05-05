/**
 * grunt fetch-db
 *
 * Retrieves the latest database export for the project.
 */

module.exports = function(grunt) {
  grunt.registerTask('fetch-db', 'Fetch a development database export from the CI server.',
    function(env) {
      grunt.loadNpmTasks('grunt-shell');

      // If not specified, default to integration environment.
      if (!env) {
        env = grunt.config('config.project.backups.env');
      }

      // project.db might be unset in projects that want grunt install to do a
      // clean install by default.
      var dbPath = grunt.option('db-path') || grunt.config('config.project.db') || '/opt/backups/latest.sql.gz';

      grunt.config.set('shell.fetch-db', {
        command: 'curl -vv -f ' + grunt.config('config.project.backups.url') + '/' + env
          + '/latest.sql.gz > ' + dbPath
      });

      grunt.config('mkdir.backups', {
        options: {
          create: [
            '<%= config.buildPaths.build %>/backups'
          ]
        }
      });

      grunt.task.run([
        'mkdir:init',
        'mkdir:backups',
        'shell:fetch-db'
      ]);
    }
  );

  require('grunt-drupal-tasks/lib/help')(grunt).add({
    task: 'fetch-db',
    group: 'Operations',
    description: 'Retrieve a prepared database for use with "grunt install". May run with grunt fetch-db:<env> to target different datasets.'
  });
}
