{ config, pkgs, ... }:

{
  # Virtual file systems support (e.g. smb, trash, mtp)
  services.gvfs.enable = true;
}
