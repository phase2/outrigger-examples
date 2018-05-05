FROM solr:5.5.4

# In order to perform filesystem operations outside of SOLR_USER control.
USER root

# Create and permission the data directory.
RUN mkdir -pv /var/lib/solr && chown -R $SOLR_USER:$SOLR_USER /var/lib/solr

# Restore use of the Solr user for container operations.
USER $SOLR_USER
