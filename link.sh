#!/bin/sh
#
# link.sh: link this repo's templates into the parent void-packages tree.
#
# Layout:
#   void-packages/              upstream clone
#   void-packages/<this-repo>/  this repo, with link.sh and srcpkgs/
#
# xbps-src treats any symlink directly in srcpkgs/ as a subpackage, so a
# package can't be a symlinked directory. Instead each package gets a real
# directory in void-packages/srcpkgs/, and the files inside it (template,
# patches/, files/, ...) are symlinked back to this repo.
#
# Subpackage symlinks in this repo (foo-devel -> foo) are recreated as-is.
#
# Links are relative so they still work inside the xbps-src chroot,
# where only void-packages is mounted.

set -eu

repo_dir=$(cd "$(dirname "$0")" && pwd)
repo_name=$(basename "$repo_dir")
vp_dir=$(dirname "$repo_dir")

# Make sure we're inside a void-packages checkout
if [ ! -x "$vp_dir/xbps-src" ]; then
    echo "error: $vp_dir is not a void-packages checkout" >&2
    exit 1
fi

for src in "$repo_dir"/srcpkgs/*; do
    # Skip the literal '*' when srcpkgs/ is empty
    [ -e "$src" ] || [ -L "$src" ] || continue

    pkg=$(basename "$src")
    dest="$vp_dir/srcpkgs/$pkg"

    # Subpackage: copy the symlink itself (e.g. foo-devel -> foo)
    if [ -L "$src" ]; then
        ln -sfn "$(readlink "$src")" "$dest"
        echo "subpkg  $pkg -> $(readlink "$src")"
        continue
    fi

    # A real template file means upstream already has this package
    if [ -f "$dest/template" ] && [ ! -L "$dest/template" ]; then
        echo "skip    $pkg (exists upstream, or template is no longer a link)" >&2
        continue
    fi

    mkdir -p "$dest"

    # Link each top-level entry: template, patches/, files/, update, ...
    for item in "$src"/*; do
        [ -e "$item" ] || continue
        name=$(basename "$item")
        ln -sfn "../../$repo_name/srcpkgs/$pkg/$name" "$dest/$name"
    done

    echo "linked  $pkg"
done
