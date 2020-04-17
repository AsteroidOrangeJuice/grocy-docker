# Changelog

## [v2.7.0-1] - 2020-04-17

### Added

- Upgrade to grocy release v2.7.0

## [v2.6.2-4] - 2020-04-07

### Removed

- Shared 'www-static' volume

## [v2.6.2-3] - 2020-04-06

### Changed

- Introduced a handful of Docker Hub image best-practices

## [v2.6.2-2] - 2020-04-04

### Changed

- Pull in upstream grocy v2.6.2 fix

## [v2.6.2-1] - 2020-04-04

### Changed

- Ensure that the application is bound to 127.0.0.1 by default

## [v2.6.2] - 2020-04-03

### Added

- Upgrade to grocy release v2.6.2
- Support for GitHub API tokens at build-time
- Log volumes added for grocy and nginx
- Optional support for OCI image builds

### Changed

- Breaking change: Image names are now: grocy/nginx, grocy/grocy
- Breaking change: Application database volume contents and name updated
- Image filesystems are read-only
