# COSMIC for Void Linux (aarch64) build kit

Generates xbps-src templates for the COSMIC epoch stack, builds them for aarch64,
and produces a signed-optional local xbps repo plus a `cosmic-desktop` meta package.

## Quick start
    # on an arm64 Void machine (or x86_64 with qemu-user-static + binfmt)
    sudo xbps-install -S git curl xtools base-devel
    $EDITOR config.sh          # set MAINTAINER, LIBC, paths
    ./build-cosmic.sh all

Steps individually: `setup` -> `versions` -> `gen` -> `build` -> `repo`.
Rebuild one component: `./build-cosmic.sh one cosmic-comp`.

## Install
    echo 'repository=file:///path/to/out/repo' | sudo tee /etc/xbps.d/cosmic-local.conf
    sudo xbps-install -S cosmic-desktop
    sudo ln -s /etc/sv/dbus /var/service/; sudo ln -s /etc/sv/elogind /var/service/
    # greeter: configure greetd to run `cosmic-greeter-daemon`/`cosmic-comp` per cosmic-greeter docs,
    # or log in from a TTY with: dbus-run-session start-cosmic

## How it works
- `components.psv` lists components (name|repo|tag prefix|extra deps|desc).
- `versions` picks the newest stable `epoch-*` tag per repo -> `versions.lock`.
- `gen` writes `srcpkgs/<name>/template` with checksums; the build step auto-detects
  `justfile` / `Makefile` / plain cargo for build and install.
- Rust crates are fetched during build (needs network inside xbps-src chroot).

## Caveats (untested here: this was authored without network or an arm64 builder)
- Expect first-run tuning: missing `-devel` deps (add to `COMMON_MAKEDEPS` or per-component column),
  and justfile install variable names that differ per repo.
- Native/qemu builds only; cross-compiling is disabled (`nocross=yes`) because COSMIC justfiles
  expect `target/release`.
- Builds are RAM-hungry (cosmic-settings, cosmic-comp): 8 GB+ RAM or swap; lower `JOBS`.
- Check whether your void-packages already ships some cosmic-* packages and drop those rows.
- `start-cosmic` comes from cosmic-session; verify it landed in /usr/bin.
