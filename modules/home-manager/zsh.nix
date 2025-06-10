{ ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    history = {
      expireDuplicatesFirst = true;
      ignoreDups = true;
      ignoreAllDups = true;
      ignoreSpace = true;
      extended = true;
      share = true;
      size = 1000;
      save = 1000;
    };

    # Initialize Zinit and add it to ZSH
    initContent = ''
      pokeget random --hide-name
      # Install Zinit if not already installed
      if [[ ! -d $HOME/.zinit/bin ]]; then
        mkdir -p $HOME/.zinit
        git clone https://github.com/zdharma-continuum/zinit.git $HOME/.zinit/bin
      fi

      # ---- Source Zinit ----
      source "$HOME/.zinit/bin/zinit.zsh"

      # ---- Load plugins ----

      zinit ice wait"1" lucid
      zinit light zsh-users/zsh-autosuggestions

      zinit ice wait"1" lucid
      zinit light zsh-users/zsh-syntax-highlighting

      zinit ice depth=1
      zinit ice wait"2" lucid
      zinit light jeffreytse/zsh-vi-mode

      zinit ice wait"2" lucid
      zinit light Aloxaf/fzf-tab

      zinit ice wait"2" lucid
      zinit light joshskidmore/zsh-fzf-history-search

      zinit ice wait"2" lucid
      zinit light mrjohannchang/zsh-interactive-cd

      zinit ice wait"2" lucid
      zinit ice depth=1
      zinit light zsh-users/zsh-completions

      # ---- Keybindings ----
      bindkey '^[[1;5D' backward-word      # Ctrl + Left
      bindkey '^[[1;5C' forward-word       # Ctrl + Right
      bindkey '^H' backward-kill-word      # Ctrl + Backspace
      bindkey '^[[3;5~' kill-word          # Ctrl + Delete
      bindkey '^[[C' forward-char          # Right Arrow
      bindkey '^E' end-of-line             # Ctrl + E

      # ---- Completion settings ----
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
      zstyle ':completion:*' rehash true
      zstyle ':completion:*' menu select

      # ---- Set options ----
      setopt nocaseglob       # Case insensitive globbing
      setopt correct          # Auto correct mistakes
    '';

    shellAliases = {
      ls = "eza --icons --group-directories-first -1";
      ll = "eza --icons -lh --group-directories-first -1 --no-user --long";
      la = "eza --icons -lah --group-directories-first -1";
      tree = "eza --icons --tree --group-directories-first";
    };
  };
}
