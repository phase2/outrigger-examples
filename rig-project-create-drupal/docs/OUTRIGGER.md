# Outrigger and Docker

> Set up and work with your project via [Outrigger](http://outrigger.sh) our local Docker management system.

Running this project on Docker streamlines the installation steps.
The Docker configuration in this repository handles all necessary environment
setup for local development or testing environments.

Local environments assume the use of Phase2's "Outrigger" system to manage the
filesystem, DNS, and any necessary virtualization. Read more about this in the
[Outrigger documentation](http://docs.outrigger.sh). (Linux users
should follow the [Linux instructions](http://docs.outrigger.sh/getting-started/linux-installation/)
for simple things like DNS consistency with macOS users.)

> **You should never run code outside the Outrigger Build container other than rig project commands, docker commands, or BASH scripts you understand handle running docker commands as needed. Imagine your system has no development environment setup.**

## First-time Application Setup

Once you have a working Outrigger + Docker environment, you can have a
locally-hosted, web-browsable site instance in just a few minutes with two
commands.

```bash
git clone git@bitbucket.org:phase2tech/projectname.git
rig project setup
```

## Daily Routine

* `rig start`
* `eval "$(rig config)"`
* `cd path/to/project`
* `rig project up`
* [PRODUCTIVE!]
* `rig project stop`
* `rig stop`

You can leave rig running day to day but periodic restarts are recommended.

## Running Commands in the Build Container

All command-line operations to interact with the application are executed via a dedicated build container that has many tools built-in.

### Using Build Services

You can run any of the services defined at the root directory in build.yml, including services for cli, composer, drush, drupal (console), grunt, and theme,
with either of the following commands:

#### Using Rig Project

```
rig project run "<service> <further arguments and options>"
rig project run "composer install"
```

#### Using docker-compose

```
docker-compose -f build.yml run --rm <service> <further arguments and options>
docker-compose -f build.yml run --rm composer install
```

### Using a "Remote Server" Workflow

If you want to run an interactive BASH session, use the `cli` service without further arguments:

```
rig project run cli
```

This will open a BASH session that allows you to run any commands or use any tools available in the build container.

### Environment Configuration

* **OUTRIGGER_SSH_KEY**: [Default: `id_rsa`] The filename of the private SSH key
to use to access private servers or git repositories. Assumes lookup in ~/.ssh/.

### Aliases & Shortcuts

You may want to add an alias to your shell to reduce the typing:

```
alias r='docker-compose -f build.yml run --rm'
```

Then execute commands with:

```
r drush cr
```

## Common Operations

To see a list of common operations run `rig project`.

## Services

* **Website:** [http://www.projectname.vm](http://www.projectname.vm)
* **Website w/out Varnish:** [http://app.projectname.vm](http://app.projectname.vm)
* **MailHog Service:** http://mail.projectname.vm](http://mail.projectname.vm)

* **Database:** `db.projectname.vm`
    * **User**: `admin`
    * **Password**: `admin`
    * **Database**: `projectname_drupal`
