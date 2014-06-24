### URLs
* http://www.dayid.org/os/notes/tm.html
* http://cloud101.eu/blog/2012/04/10/tmux-simple-guide-to-the-terminal-multiplexer/
* http://stackoverflow.com/questions/18760281/how-to-increase-scrollback-buffer-size-in-tmux
* http://unix.stackexchange.com/questions/14300/moving-tmux-window-to-pane

### With my (GNU Screen-ish) tmux.conf
* ctrl-a " _horizontal spli_
* ctrl-a % _vertical split_
* ctrl-a hjkl _move between split windows_
* ctrl-a *spacebar* _auto arrange panes_

### Same as screen (with my conf)
* ctrl-a c
* ctrl-a w
* ctrl-a _num_
* ctrl-a n
* ctrl-a p
* ctrl-a d _to re-attach: tmux attach_

### syncrhonize panes
* _ctrl-a :set-window-option synchronize-panes on|off_
* ctrl-a ctrl-s _default binding?_
