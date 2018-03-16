# TODOS

This file contains outstanding tasks that someone on the project team must
complete. As items are accomplished, they can be removed from this file.

(This is a good place to record information about long-term technical debt.)

* [ ] Project Codebase Ownership: The project team owns all the code in this repo. Assign a team member to perform the following:
    * Read all the generated documentation.
        * README.md, CONTRIBUTING.md, docs/*
    * Be familiar with the configuration for Grunt, Docker, Outrigger, Drupal, and Drush
        * Gruntconfig.json
        * docker-compose.yml, docker-compose.override.yml, build.yml, build.devcloud.yml, and jenkins.yml
        * .outrigger.yml
        * src/sites/settings.common.php
        * env/build/etc/drush/drushrc.php
    * Note all the utility scripts in `./bin`
    * Ensure everyone on the team understands what they need to know.

* [ ] Test the Site Setup: Confirm the build and site installation works.
    * Install and start [Outrigger](http://docs.outrigger.sh/).
    * Run  `docker-compose pull && docker-compose -f build.yml pull` to ensure you have the latest Docker images for local development.
    * Run `rig project setup` to confirm the code works and setup your project.
    * Move any code generated in src/sites/default/settings.php after the include of src/sites/settings.common.php into the latter file.
    * If git can add a file, please add it to the code repository. Your src/sites/default/settings.php file should be committed.

* [ ] Adapt the Code to the Project: This is only a starting place.
    * Modify scripts to suite your needs, or remove scripts you will not use and maintain as it will simply be clutter.
    * Rewrite codebase documentation to suite the audience. Make sure future onboarding will work.

* [ ] Spin up Continuous Integration & Testing Environments: This is specific to Phase2-only infrastructure at this time.
    * Ensure the Jenkins jobs have the correct Git URL. (You can correct this by editing .yo-rc.json and running the generator again with `--replay`.)
    * Visit your CI Server and [spin up your Jenkins instance](http://build.hosting.example.net/job/ci-start/parambuild/?delay=0sec&NAME=projectname&GIT_URL=git%40bitbucket.org%3Aphase2tech%2Fprojectname.git&GIT_REF=develop).

* [ ] Configure Email Testing: Add the SMTP module to the project to use MailHog for testing.
    * Add the SMTP module to the codebase.
    * Enable the module and turn on STMP mail transport at `admin/config/system/smtp`.
    * Send a test email using the admin form and confirm mail is routed to the MailHog UI at `mail-<environment-hostname>` for devcloud, or `mail.projectname.vm:8025` locally.

* [ ] Engage with the Community
    * Report on any changes made to get the environment working, improve documentation, or automate development processes.
    * Phase2 staff should join the **#devtools-support** flow to get help. Ask for one-on-one time for troubleshooting or additional coaching.
    * Tweet [@outrigger_sh](https://twitter.com/outrigger_sh) with the big ideas.
    * Collaborate in issue queues such as [Outrigger Drupal](https://github.com/phase2/generator-outrigger-drupal), [Outrigger Docs](https://github.com/phase2/outrigger-docs), [Rig CLI]((https://github.com/phase2/rig), and [others](https://github.com/search?q=topic%3Aoutrigger+org%3Aphase2&type=Repositories).
