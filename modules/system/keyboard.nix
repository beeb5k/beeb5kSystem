{
  # services.kanata = {
  #   enable = true;
  #   keyboards = {
  #     default = {
  #       config = ''
  #         (defsrc
  #           esc  caps
  #         )
  #
  #         (defalias
  #           ;; tap for esc, hold for left control
  #           ;; 200 200 are the tap/hold timeout values in ms
  #           cap (tap-hold 200 200 esc lctl)
  #         )
  #
  #         (deflayer base
  #           caps @cap
  #         )
  #       '';
  #     };
  #   };
  # };

  services.keyd.enable = true;
  services.keyd.keyboards.default = {
    ids = ["*"];
    settings = {
      main = {
        capslock = "overload(control, esc)";
        esc = "capslock";
      };
    };
  };
}
