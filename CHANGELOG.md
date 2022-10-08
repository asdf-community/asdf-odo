# Changelog

## [3.0.1](https://github.com/rm3l/asdf-odo/compare/v3.0.0...v3.0.1) (2022-10-08)


### Bug Fixes

* Fix filter that lists only installable versions ([c200c6f](https://github.com/rm3l/asdf-odo/commit/c200c6f194f7b2d28a9fda61895b940298fdbaf1))

## [3.0.0](https://github.com/rm3l/asdf-odo/compare/v2.0.0...v3.0.0) (2022-09-30)


### ⚠ BREAKING CHANGES

* Rename `asdf odo preference` into `asdf odo settings` to avoid confusion

### Code Refactoring

* Rename `asdf odo preference` into `asdf odo settings` to avoid confusion ([a440166](https://github.com/rm3l/asdf-odo/commit/a440166288f03941a870d5b5bcd659236a237ebb))

## [2.0.0](https://github.com/rm3l/asdf-odo/compare/v1.3.0...v2.0.0) (2022-09-29)


### ⚠ BREAKING CHANGES

* Rename default odo preferences file to `${XDG_CONFIG_HOME:-"~/.config"}/odo/settings.yaml`

### Features

* Add new extension command for asdf: asdf odo preference ([e311228](https://github.com/rm3l/asdf-odo/commit/e311228b37948dba05a097ea758e7d3c1dba6700))


### Code Refactoring

* Rename default odo preferences file to `${XDG_CONFIG_HOME:-"~/.config"}/odo/settings.yaml` ([e5c13c4](https://github.com/rm3l/asdf-odo/commit/e5c13c493bc076ba073d1765c2121d6e0b1cbf44))

## [1.3.0](https://github.com/rm3l/asdf-odo/compare/v1.2.1...v1.3.0) (2022-09-17)


### Features

* Implement 'asdf help odo' ([5455cfd](https://github.com/rm3l/asdf-odo/commit/5455cfd351a0170f9d3575b67e51d511b7a3c8a8))
* Setup environment for execution of odo ([e3d83c1](https://github.com/rm3l/asdf-odo/commit/e3d83c1dc049abaab5032d1169521d3f4d8ef5f3))


### Bug Fixes

* **#27:** Make list-all return only versions that have corresponding binaries available ([d4673f1](https://github.com/rm3l/asdf-odo/commit/d4673f18bba6c483e077b1bd37c38bf2d493c5f1))

### [1.2.1](https://github.com/rm3l/asdf-odo/compare/v1.2.0...v1.2.1) (2022-04-29)


### Bug Fixes

* **#10:** Fallback to using the parent sha256sum.txt file if the version-specific checksum file is empty ([d66d369](https://github.com/rm3l/asdf-odo/commit/d66d36918cc735e3099d179a4293dd403f469b96))

## [1.2.0](https://github.com/rm3l/asdf-odo/compare/v1.1.1...v1.2.0) (2022-04-27)


### Features

* Print debug messages if ASDF_ODO_VERBOSE is defined and set to true ([ee7a5d1](https://github.com/rm3l/asdf-odo/commit/ee7a5d17a3ea3f04bad6ff57fb1a307da1bfec00))
* Skip verifying downloaded file checksum integrity if ASDF_ODO_CHECKS_SKIP_FILE_CHECKSUM is defined and set to true ([fb0db97](https://github.com/rm3l/asdf-odo/commit/fb0db97935639586c7454a6c2e50dc984292cfed))

### [1.1.1](https://github.com/rm3l/asdf-odo/compare/v1.1.0...v1.1.1) (2022-04-27)


### Bug Fixes

* Fix download URL when versions contain an '-' character ([ee25ac1](https://github.com/rm3l/asdf-odo/commit/ee25ac122a38dd9c17f92462c0501b21a2c8d606))

## [1.1.0](https://www.github.com/rm3l/asdf-odo/compare/v1.0.0...v1.1.0) (2022-04-01)


### Features

* Allow to override the platform and architecture of the odo binary downloaded by this plugin ([7ca1cc6](https://www.github.com/rm3l/asdf-odo/commit/7ca1cc6ee00a5a43581ed55d00d484f6c6c03b02))


### Bug Fixes

* Fix download URL for odo binary on Windows ([57de72d](https://www.github.com/rm3l/asdf-odo/commit/57de72d2cc5021884ba6ee6dd7ca6ea1bfddbfcc))

## 1.0.0 (2022-03-31)


### Features

* Allow to install from ref using relative GitHub repos ([316f484](https://www.github.com/rm3l/asdf-odo/commit/316f48449b45c8c6e54516c86b46970ef862cb9e))
* Detect operating system and architecture ([d891796](https://www.github.com/rm3l/asdf-odo/commit/d891796514a2767d3cfec85bdb46d17b842fad82))
* Support installing versions off of remote GitHub refs ([4b5a7a6](https://www.github.com/rm3l/asdf-odo/commit/4b5a7a64bf743c8877ab3e07388a97d11e1cbf7e))
* Verify downloaded binary integrity ([55e6c30](https://www.github.com/rm3l/asdf-odo/commit/55e6c30056bfc2af17c87e1e7735f5be3d4d02c5))
