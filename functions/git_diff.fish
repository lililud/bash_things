function git_diff --description 'git diff'
  set -l lime (set_color -o "00FF5B")
  set -l red (set_color -o red)
  set -l main_branch (command git remote show origin | sed -n '/HEAD branch/s/.*: //p')
  set -l stats (command git diff origin/$main_branch...(git_branch_name) | diffstat -s)

  set -l adds (string match -r "(\d*) insertion" $stats)[2] 
  set -l subs (string match -r "(\d*) deletion" $stats)[2]
  if test -z $adds; and test -z $subs
      return 1
  end
  if test -z $adds
      set adds "0"
  end
  if test -z $subs
      set subs "0"
  end
  set -l output $lime "[+$adds"$red" -$subs]"

  echo "(⚙️ $output)"
end

