{ lib, config, ... }:
{
  programs.vesktop = {
    enable = true;
    vencord = {
      settings = {
        enabledThemes = lib.optionals config.beeMods.matugen.enable [ "system24.css" ];
        autoUpdate = false;
        autoUpdateNotification = false;
        notifyAboutUpdates = false;
        useQuickCss = false;
        disableMinSize = true;
        plugins = {
          FakeNitro.enabled = false;
          AnonymiseFileNames.enabled = true;
          PlainFolderIcon.enabled = true;
          NoTypingAnimation.enabled = true;
          NoF1.enabled = true;
          petpet.enabled = true;
          QuickReply.enabled = true;
          SilentTyping.enabled = true;
          StreamerModeOnStream.enabled = false;
          NoReplyMention.enabled = true;
          OnePingPerDM.enabled = false;
        };
      };
    };
  };
}
