{ config, pkgs, inputs, ... }:

{
    programs.zsh = {
        enable = true;
        oh-my-zsh = {
            enable = true;
        };
        # to use p10k theme
        initExtraFirst = ''
            # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
            # Initialization code that may require console input (password prompts, [y/n]
            # confirmations, etc.) must go above this block; everything else may go below.
            if [[ -r "$\{XDG_CACHE_HOME:-$HOME/.cache\}/p10k-instant-prompt-$\{(%):-%n\}.zsh" ]]; then
            source "$\{XDG_CACHE_HOME:-$HOME/.cache\}/p10k-instant-prompt-$\{(%):-%n\}.zsh"
            fi
        '';
        initExtra = ''
            # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
            [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
        '';
        shellAliases = { cat="bat"; 
                         icat="kitten icat";
                         os-remove="sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations";};
    };
}