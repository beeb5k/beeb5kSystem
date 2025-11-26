{ ... }:
{
  programs.git = {
    enable = true;
    settings = {
      init.defaultBranch = "main";
      credential.helper = "store";
      user = {
        email = "112796674+beeb5k@users.noreply.github.com";
        name = "beeb5k";
      };
    };

    signing = {
      key = "1D8222FA8B7E93A6";
      signByDefault = true;
    };
  };

  programs.lazygit.enable = true;
}
