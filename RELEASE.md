# How to release

1. Make sure [master build](https://travis-ci.org/porras/tlcr) is green
1. Make a commit on master with the message *vX.Y.Z* and the following changes
  * In `CHANGELOG.md`, add a section with the new version as header and the content of the *Unreleased* one. Don't forget to add the date and fix the link. Add a new *Unreleased* header, with the proper link.
  * In `src/tlcr/version.cr`, update the version
  * In `shard.yml`, update the version
1. Run `shards`
1. Run the specs locally
1. Add the tag: `git tag X.Y.Z`
1. Push: `git push origin master --tags`
1. Make sure [master build](https://travis-ci.org/porras/tlcr) is green again
1. [Draft a new release](https://github.com/porras/tlcr/releases/new)
  * Tag: The version being released
  * Release title: vX.Y.Z
  * Description: Should include the relevant part of the `CHANGELOG` and a link to installation instructions (see [example](https://github.com/porras/tlcr/releases/tag/0.3.1))
1. Publish it!

See `PACKAGING.md` on how to release source and binary packages.
