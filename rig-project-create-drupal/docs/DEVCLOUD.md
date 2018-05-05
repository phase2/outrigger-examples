# Outrigger Cloud: Docker-based Development Hosting

> Learn how to work with and manage Phase2's Outrigger Cloud hosting platform.

Outrigger Hosting is Phase2's docker-based hosting platform for our development projects. This solution is still internal-only and evolving, and will eventually be documented so others can set it up as well.

## Server Location

These Docker-based hosted sites are on servers managed by the Phase2 Infrastructure Team.

You can reach an environment on the server via:

```
http://[env]-projectname.projectname.hosting.example.net
```

You will find this on disk at `/opt/development/projectname/jenkins/env/deploy-[env]`

In order to run commands such as clearing the Drupal application cache, you
would run:

```
cd /opt/development/projectname/jenkins/env/deploy-[env]
DOCKER_ENV=[env] docker-compose -f build.devcloud.yml -p projectname_[env] run --rm drush cache-rebuild
```

## Jenkins Integration

This project is packaged with the ability to easily spin up a project-specific
Jenkins instance to facilitate some of the operational practices of Phase2
development. This includes maintaining standing environments, performing
overnight tasks without developer involvement, and reporting on problems.

Jenkins is hosted via any Docker environment.

This Jenkins implementation does a majority of its work by spinning up Docker
containers for the different environments of the project and executing necessary
commands to build code, run tests, or generate reports.

### Starting Up Jenkins

This is normally done by the "master Jenkins" ci-start job, you will use this
for local development of Jenkins jobs, configuration, and customization.

```bash
docker-compose -f jenkins.yml -p projectname run jenkins
```

### Accessing Private Repositories

When you startup Jenkins it will automatically create a volume mount to pull in
your `id_rsa` key for use in SSH-based git checkouts.

If you do not have an id_rsa key, or do not use one for this project, you can
specify an environment variable locally to substitute in the key name of your
choice:

```bash
export OUTRIGGER_SSH_KEY=devcloud_bitbucket_rsa
```

This same mechanism is available to the build container.

### Developing Your Jenkins System

By pulling Jenkins into the project repository it is under more direct control
by the development team. The recommended approach is to focus on Jenkins as a
"thin controller", carrying the minimum functionality to execute its needs as a
Docker-based CI & build tool. Most of the functionality should be found in tools
or scripts that are leveraged by Jenkins from the `bin/` directory.

### Maintained Jenkins Configuration

Jenkins has required configuration maintained as part of the project codebase.

* The main configuration can be viewed at `env/jenkins/config.xml`
* Individual jobs are found in `env/jenkins/jobs`.

When working with the Jenkins UI to make changes, configuration will be directly
written to these files. This way you can manage Jenkins changes as part of the
development process.

> **Known Problem**
> Saving administrative pages that write to the main Jenkins config.xml leads to
> a fatal error. Get back to a working Jenkins page, as despite this fatal error
> Jenkins will continue to work.

### Default Jenkins Jobs

There are several Jenkins jobs packaged in the repository.

* **ci**: Triggered by every push to the configured Git repository, CI runs all
  tests and checks and reports back on the health of the code branch.
* **dev-support:** Produces a nightly snapshot database of a clean install made
  available at `/opt/backups/nightlies`. The most recent snapshot can be found at `/opt/backups/latest.sql.gz`. Also runs a module updates scan.
* For each supported environment (Development, QA, Review) has a deployment,
  cron, and admin password reset job.
* See a running Jenkins instance for additional jobs.

## Updating for Use Outside Phase2 Infrastructure

Phase2 uses [Flowdock](https://flowdock.com) for team messaging, commonly the
Jenkins jobs are configured to send a message to the project chat room.
Please reconfigure or disable this setting when using this to set up Jenkins
outside a Phase2 environment.
