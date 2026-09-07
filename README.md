# deployment-rta

Historical provisioning and deployment source for the realTasia system.

This repository records how the original API, application and shared services were installed and served. It is an archive, not current deployment guidance. The scripts target obsolete operating-system packages, service layouts and deployment mechanisms and must not be run on a modern host.

## Archive contents

- Ubuntu and PHP provisioning scripts
- Nginx and PHP-FPM configuration
- the repository-driven deployment endpoint
- sanitised MongoDB `pages` and `singpost` datasets plus a synthetic bootstrap
- modern annotated historical commentary in [`COMMIT_COMMENTARY.md`](./COMMIT_COMMENTARY.md)

## Publication changes

Private SSH material and raw database dumps are omitted from the snapshot. [`mongo/`](./mongo/) preserves 6,994 sanitised `pages` documents, 265,678 sanitised `singpost` address-reference documents, a synthetic OAuth client, a synthetic archive owner, observed collection schemas and deduplicated indexes. A historical deployment-bundle endpoint is replaced with a deliberately non-resolving synthetic URL.

See [`SANITISATION.md`](./SANITISATION.md) for the transformation record and [`ARCHIVE_NOTICE.md`](./ARCHIVE_NOTICE.md) for the rights position.


Part of the [realTasia source archive](https://github.com/realtasia).

## Snapshot model

This public repository contains one sanitised archival snapshot commit. The complete historical Git record remains in the untouched private archival master. See [SANITISATION.md](./SANITISATION.md).
