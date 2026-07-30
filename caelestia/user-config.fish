alias fk="echo 'fuck you'"

# Initialize zoxide (replace cd)
# if command -q zoxide
#     zoxide init fish | source
# end

set -Ux EDITOR nvim

alias z='cd'

abbr la 'ls -la'
abbr c "clear"
alias ff="ff-random"
abbr nt "nitch"
abbr vim "nvim"
alias v="nvim"

abbr s "paru -Ss"
abbr au "paru -Syu"
abbr ai "paru -S"
abbr ad "paru -Rns"

abbr gpu "supergfxctl -g"
abbr igpu "supergfxctl -m Integrated"
abbr dgpu "supergfxctl -m Hybrid"
alias nvw="watch -n 1 nvidia-smi"

abbr mkgrub "sudo grub-mkconfig -o /boot/grub/grub.cfg"

abbr tn "tmux new -s"
abbr ta "tmux attach"
abbr tan "tmux attach -t"
abbr tl "tmux ls"

abbr py "python3"

abbr nr "npm run dev"
abbr bro "bun dev"
abbr bi "bun install"
abbr ba "bun add"

abbr md "mkdir -p"

# hyprshutdown
abbr sysshut  "hyprshutdown -t 'Shutting down...' --post-cmd 'shutdown -P 0' "
abbr logout  "hyprshutdown"
abbr nvlogout  "hyprshutdown -vt 2"


#------------------------------------------------------
# youtube video download
#------------------------------------------------------
alias ytmp4='yt-dlp -f bestvideo+bestaudio \
--merge-output-format mp4 \
--download-archive downloaded_log.txt \
-o "%(title)s.%(ext)s"'


alias img='find . -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) | nsxiv -ti & disown'

# Custom fish config

#zoxide
# zoxide init fish | source
set -gx LANG en_IN.UTF-8
set -gx LC_ALL en_IN.UTF-8

