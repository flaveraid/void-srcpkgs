# void-srcpkgs

xbps-src templates, kept separate from the full [void-packages](https://github.com/void-linux/void-packages) tree. 

## Setup

Clone void-packages and bootstrap it:

```sh
git clone --filter=blob:none https://github.com/void-linux/void-packages.git
cd void-packages
./xbps-src binary-bootstrap
```

Clone this repo **inside** the void-packages directory and link the templates:

```sh
git clone https://github.com/flaveraid/void-srcpkgs.git
./void-srcpkgs/link.sh
```

## Pull Upstream Changes

```sh
git pull --rebase --autostash && ./xbps-src bootstrap-update
git -C void-srcpkgs pull && ./void-srcpkgs/link.sh
```

Run `link.sh` again whenever packages are added to this repo.

## Building

```sh
./xbps-src pkg <package>
```

## Package Maintenance

Tools that rewrite templates should reference this repo, because they will replace the link with a regular file:

```sh
xgensum -i void-srcpkgs/srcpkgs/<package>
```
