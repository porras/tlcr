# How to update Homebrew recipe

1. [Install current version with Homebrew](https://github.com/porras/tlcr#mac) if it wasn't installed
1. `brew edit tlcr`
  * Edit `url`
  * Remove `bottle` section
1. `brew uninstall tlcr`
1. `brew install tlcr`
  * This will fail because the checksum doesn't match. The new one will be shown
  * **Check it**
  * Update it running `brew edit tlcr` again
  * Retry the install
1. Optionally, create a *bottle* (see below)
1. `cd /usr/local/Homebrew/Library/Taps/porras/homebrew-tap`
1. Commit (message can be `[tlcr] vX.Y.Z`) and push
  * If login is prompted, cancel and add a `mine` remote with `git remote add mine git@github.com:porras/homebrew-tap.git`)
  * From now on the push command will be `git push mine master`

## How to create a *bottle*

1. Uninstall and reinstall with `brew install tlcr --build-bottle`
1. `brew bottle tlcr`
1. Upload the generated `tar.gz` to the release and copy its download URL
1. Copy the generated snippet into `brew edit tlcr` and add a `root_url` line with the copied URL **minus the filename**
1. Check it by uninstalling and installing again (no flags)
