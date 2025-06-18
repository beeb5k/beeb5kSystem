{
  services.kanata = {
    enable = true;
    keyboards = {
      default = {
        config = ''
          (defsrc
            caps
          )

          (defalias
            escctrl (tap-hold 150 200 esc lctl)
          )

          (deflayer base
            @escctrl
          )
        '';
      };
    };
  };
}
