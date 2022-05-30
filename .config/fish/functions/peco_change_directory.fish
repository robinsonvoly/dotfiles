function _peco_change_directory
  if [ (count $argv) ]
    peco --layout=bottom-up --query "$argv "|perl -pe 's/([ ()])/\\\\$1/g'|read foo
  else
    peco --layout=bottom-up |perl -pe 's/([ ()])/\\\\$1/g'|read foo
  end
  if [ $foo ]
    builtin cd $foo
    commandline -r ''
    commandline -f repaint
  else
    commandline ''
  end
end

# Function gets active list of repos from our main repo folder
# then feeds and filters them through peco
# `ctrl-f`
function peco_change_directory
  begin
    echo $HOME/.config
    # GHQ offers a good solution to git repo management
    # https://github.com/x-motemen/ghq
    # ghq list -p
    
    # Use ls to find files to pass to peco, searches current dir and $HOME/Code
    ls -ad */|perl -pe "s#^#$PWD/#"|grep -v \.git
    ls -ad $HOME/Code/*/* |grep -v \.git
  end | sed -e 's/\/$//' | awk '!a[$0]++' | _peco_change_directory $argv
end