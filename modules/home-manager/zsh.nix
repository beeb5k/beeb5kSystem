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
    initContent = # bash
      ''
        pokeget random --hide-name

        if [[ ! -d "$HOME/.zinit/bin" ]]; then
          mkdir -p "$HOME/.zinit"
          git clone https://github.com/zdharma-continuum/zinit.git "$HOME/.zinit/bin"
        fi

        source "$HOME/.zinit/bin/zinit.zsh"

        autoload -Uz compinit
        compinit -C    # -C = use cache

        eval "$(starship init zsh)"

        zinit wait lucid light-mode depth=1 for \
        zsh-users/zsh-autosuggestions \
        Aloxaf/fzf-tab \
        joshskidmore/zsh-fzf-history-search \
        mrjohannchang/zsh-interactive-cd \
        zsh-users/zsh-syntax-highlighting \
        jeffreytse/zsh-vi-mode

        zinit ice wait lucid light-mode depth=1 atload"_zsh_autosuggest_start"
        zinit light zsh-users/zsh-autosuggestions

        bindkey '^[[1;5D' backward-word      # Ctrl + Left
        bindkey '^[[1;5C' forward-word       # Ctrl + Right
        bindkey '^H' backward-kill-word      # Ctrl + Backspace
        bindkey '^[[3;5~' kill-word          # Ctrl + Delete
        bindkey '^[[C' forward-char          # Right Arrow
        bindkey '^E' end-of-line             # Ctrl + E

        zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
        zstyle ':completion:*' rehash true
        zstyle ':completion:*' menu select

        setopt nocaseglob     # Case-insensitive globbing
        setopt correct        # Auto-correct small mistakes

        clear_and_pokeget () {
          print -Pn "\e[H\e[2J"
            pokeget random --hide-name
            zle reset-prompt
        }

        zle -N clear_and_pokeget
          bindkey "^L" clear_and_pokeget
      '';

    shellAliases = {
      clear = "clear && pokeget random --hide-name";
      ls = "eza --icons --group-directories-first -1";
      ll = "eza --icons -lh --group-directories-first -1 --no-user --long";
      la = "eza --icons -lah --group-directories-first -1";
      tree = "eza --icons --tree --group-directories-first";
    };
  };
}
