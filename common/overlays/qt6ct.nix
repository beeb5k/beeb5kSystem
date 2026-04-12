final: prev:
let
  patchQtct =
    pkg:
    pkg.overrideAttrs (old: {
      patches = (old.patches or [ ]) ++ [
        (final.fetchpatch {
          url = "https://www.opencode.net/trialuser/qt6ct/-/merge_requests/9.patch";
          hash = "sha256-dc6ocbBGSKZV+Tr++ep/oaIdtd27gWxt5+feHO1PUaM=";
        })
      ];

      buildInputs = (old.buildInputs or [ ]) ++ [
        final.kdePackages.kconfig
        final.kdePackages.kcolorscheme
        final.kdePackages.kiconthemes
        final.kdePackages.qtdeclarative
      ];
    });

in
{
  kdePackages = prev.kdePackages.overrideScope (
    kfinal: kprev: {
      qt6ct = patchQtct kprev.qt6ct;
    }
  );

  qt6Packages = prev.qt6Packages // {
    qt6ct = patchQtct prev.qt6Packages.qt6ct;
  };
}
