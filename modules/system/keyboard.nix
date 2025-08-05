{
  # services.kanata = {
  #   enable = true;
  #   keyboards = {
  #     default = {
  #       config = ''
  #         (defsrc
  #           caps
  #         )
  #
  #         (defalias
  #           escctrl (tap-hold 100 150 esc lctl)
  #         )
  #
  #         (deflayer base
  #           @escctrl
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
      };
      # well i think i'll just use the defaults for now.
      # sym = {
      #   u = ")";
      #   i = "]";
      #   j = "(";
      #   k = "{";
      #   l = "[";
      #   o = "=";
      #   p = "$";
      #   ";" = "_";
      #   "." = "}";
      # };
    };
  };
}
