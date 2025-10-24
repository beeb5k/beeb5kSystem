{ ... }:
{
  programs.git = {
    enable = true;
    settings = {
      init.defaultBranch = "main";
      credential.helper = "store";
      user = {
        email = "beeb5k6@gmail.com";
        name = "beeb5k";
      };
    };

    signing = {
      key = "1D8222FA8B7E93A6";
      signByDefault = false;
    };
  };

  programs.lazygit.enable = true;
}
