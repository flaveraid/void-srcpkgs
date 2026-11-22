# Linux Surface Kernel

Merge kernel configs before building:

```sh
KCONFIG_CONFIG=x86_64-dotconfig-custom sh merge_config.sh -m -y x86_64-dotconfig surface-7.2.config surface-7.2.config-custom
```

## Attribution

Patches 0001-0015 came from [linux-surface/linux-surface](https://github.com/linux-surface/linux-surface)

Remaining patches came from [void-linux/void-packages](https://github.com/void-linux/void-packages)

`files/merge_config.sh` came from [mournfully/patched-void-surface-kernel](https://github.com/mournfully/patched-void-surface-kernel/blob/main/srcpkgs/linux-surface/files/merge_config.sh)
