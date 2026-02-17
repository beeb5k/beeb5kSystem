{ ... }:
{
  programs.zsh = {
    enable = false;
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
    initContent =
      # bash
      ''
        ~/.config/sequences.sh
        pokeget random --hide-name

        ZINIT_HOME="$HOME/.local/share/zinit/bin"
        if [[ ! -d $ZINIT_HOME ]]; then
          mkdir -p "$(dirname $ZINIT_HOME)"
          git clone --single-branch --depth 1 --branch=main https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
        fi

        source "$ZINIT_HOME/zinit.zsh"

        autoload -Uz compinit
        compinit -C    # -C = use cache

        eval "$(starship init zsh)"

        # zinit wait lucid light-mode depth=1 for \
        zinit light Aloxaf/fzf-tab
        zinit light jeffreytse/zsh-vi-mode
        zinit light mrjohannchang/zsh-interactive-cd
        zinit light zsh-users/zsh-syntax-highlighting
        zinit light zsh-users/zsh-autosuggestions
        zinit light joshskidmore/zsh-fzf-history-search
        zinit light zsh-users/zsh-autosuggestions
        zinit light joshskidmore/zsh-fzf-history-search

        zinit ice wait lucid light-mode depth=1 atload"_zsh_autosuggest_start"

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
      # ls = "eza --icons --group-directories-first -1";
      # ll = "eza --icons -lh --group-directories-first -1 --no-user --long";
      # la = "eza --icons -lah --group-directories-first -1";
      # tree = "eza --icons --tree --group-directories-first";
    };
  };
}
