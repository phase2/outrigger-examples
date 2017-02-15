# Example Solr Containers

Example of containers and configuration for adding solr containers with preconfigured cores and use of persistent data area for storage. The example is configured with multiple cores to demonstrate how multiple can be used even though in practice most projects only need a single core.

## Overview

There are two conceptual pieces to adding solr to your project. Each are described below

### Core configuration

For each core you want to be available add a directory to env/solr. Each core directory should contain a core.properties file and a conf directory with the configuration for your core. The starting point for the conf directory contents are generally pulled from the Drupal integration module you are using.

The solr core properties file should declare the data directory to live under /var/lib/solr. It is recommended that this is namespaced by the name of your core. For example, /var/lib/solr/core01. This aligns with the data container's volume setup and permission adjustments so that the solr process will be able to write data files.

For each core you add, map it to the solr containers configuration directory in the docker-compose configuration file.

### Persistent data storage

The solr_data container is responsible for declaring a volume that can be mapped to a persistent storage area in your docker-compose file. It allows for permission adjustments so that the solr process can write that volume. It is configured to map ownership to the user and UID used by the solr container using fix-attrs.d.  If needed, permissions or user can be configured in dockerfiles/solr_data/root/etc/fix-attrs.d/10-solr-data
