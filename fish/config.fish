# set term early
set -x term xterm-256color
set -x colorterm truecolor

# load environment and tools
# nvm
if test -s ~/.local/share/nvm/nvm.fish
    bass source ~/.local/share/nvm/nvm.sh --no-use ';' nvm use default
end
set -gx path ~/.local/share/nvm/v22.15.1/bin $path

# pyenv
set -x pyenv_root "$home/.pyenv"
set -x path "$pyenv_root/bin" $path
status is-login; and pyenv init --path | source
status is-interactive; and pyenv init - | source

# gpu / nvidia variables
set -x __nv_prime_render_offload 1
set -x __glx_vendor_library_name nvidia

# aliases
alias mountsecret="gocryptfs ~/encrypted ~/decrypted"
alias unmountsecret="fusermount -u ~/decrypted/"
alias ga="git add"
alias gc="git commit"
alias gu="git pull"
alias gcl="git clone"
alias gp="git push"
alias cls="clear"
alias gst="git status"
alias nrd="npm run dev"
alias yd="yarn dev"
alias nilpd="npm install --legacy-peer-deps"
alias pyrun="uvicorn src.main:app --host 0.0.0.0 --port 8000 --reload --reload-exclude logs"
alias synth="cdk synth"
alias deploy="cdk deploy"
alias logger="~/desktop/internships/arbiter/aws/cwlogs" # Logger for Internship
alias lzg="lazygit"
alias vim="nvim ."

# fish greeting
# set -g fish_greeting '01001000 01101001'

# only run interactive commands in interactive shells
if status is-interactive
    # zoxide - must be in interactive block
    zoxide init fish | source
    
    # atuin - suppress bind warnings
    atuin init fish 2>/dev/null | source
    
    # neofetch
    neofetch
    
    # starship should be last in interactive block
    starship init fish | source
end

