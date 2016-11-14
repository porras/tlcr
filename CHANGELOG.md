# Change Log
All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

## [Unreleased](https://github.com/porras/tlcr/compare/0.3.1...HEAD)

## [0.3.1](https://github.com/porras/tlcr/compare/0.3.0...0.3.1) - 2016-11-14
### Changed
- Different refactors and changes for Crystal 0.19 compatibility ([#9](https://github.com/porras/tlcr/pull/9), [c8f74992](https://github.com/porras/tlcr/commit/c8f74992))

## [0.3.0](https://github.com/porras/tlcr/compare/0.2.1...0.3.0) - 2016-01-08
### Changed
- Load index from static hosting (not repo) ([#8](https://github.com/porras/tlcr/pull/8))

## [0.2.1](https://github.com/porras/tlcr/compare/0.2.0...0.2.1) - 2016-01-05
### Fixed
- Missing bash completion for `-v`/`--version`
- Due to human-mistake-with-git, version string was 0.1.1 for 0.2.0 (in source, not in binary) 😔

## [0.2.0](https://github.com/porras/tlcr/compare/0.1.1...0.2.0) - 2016-01-04
### Added
- Local file rendering ([#3](https://github.com/porras/tlcr/pull/3))
- Batch download of the whole archive ([#7](https://github.com/porras/tlcr/pull/7))
- `-v`/`--version` option to display version
- Some (incomplete but it's a start) tests 😊
- This CHANGELOG

### Fixed
- Error message when passing `-u` but no page name ([#5](https://github.com/porras/tlcr/pull/5), thanks @sfcgeorge for reporting)

## [0.1.1](https://github.com/porras/tlcr/compare/0.1.0...0.1.1) - 2015-12-30
### Fixed
- Locking of f/completion dependency that was causing failures when building from source

## [0.1.0](https://github.com/porras/tlcr/tree/0.1.0) - 2015-12-30 (Initial release)
### Features
- Simple CLI
- Colorized Markdown rendering in the terminal
- Local file based cache
- Bash completion
