{pkgs, ...}: let
  keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICDSw8KwWzGDDks1fHSiuJO915PDXYdgKHpj+4+6XYrW sincore@jupiter"
  ];
in {
  config = {
    boot.initrd.network.ssh.authorizedKeys = keys;

    services.openssh = {
      enable = true;
      openFirewall = true;
      hostKeys = [
        {
          bits = 4096;
          path = "/etc/ssh/ssh_host_rsa_key";
          type = "rsa";
        }
        {
          path = "/etc/ssh/ssh_host_ed25519_key";
          type = "ed25519";
        }
      ];
    };

    users.users.sincore = {
      isNormalUser = true;
      shell = pkgs.zsh;
      initialPassword = "changeme";
      openssh.authorizedKeys.keys = keys;
      extraGroups = [
        "wheel"
        "gitea"
        "docker"
        "systemd-journal"
        "vboxusers"
        "audio"
        "plugdev"
        "video"
        "input"
        "lp"
        "networkmanager"
        "power"
        "nix"
      ];
      uid = 1000;
    };
  };
}