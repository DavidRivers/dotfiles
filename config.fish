fish_vi_mode

function __fish_skip_config --argument-names command
  env __FISH_SKIP_CONFIG__=t fish --command "$command"
end

if set --query __FISH_SKIP_CONFIG__
  exit
end

if status --is-interactive
  source ~/dotfiles/__fish_complete_cd.fish
  source ~/dotfiles/z.fish
  source ~/.config/fish/aliases.fish
end

#set fish_key_bindings fish_vi_key_bindings

set --export PATH /usr/local/sbin $PATH
set --export PATH /usr/local/opt/coreutils/libexec/gnubin $PATH
set --export EDITOR 'vim'

if [ (uname) = Darwin ]
  set --export MANPATH /usr/local/opt/coreutils/libexec/gnuman (manpath)
  set --export MANPATH /usr/local/share/man (manpath)
  set --export MANPATH /usr/local/opt/erlang/lib/erlang/man (manpath)
end

if test -e ~/dotfiles/git-custom-commands
  set --export PATH ~/dotfiles/git-custom-commands $PATH
end

if test -e ~/bin
  set --export PATH ~/bin/* $PATH
end

if test -e ~/.rvm
  function rvm --description='Ruby enVironment Manager'
    # run RVM and capture the resulting environment
    set --local env_file (mktemp -t rvm.fish.XXXXXXXXXX)
    bash -c 'source ~/.rvm/scripts/rvm; rvm "$@"; status=$?; env > "$0"; exit $status' $env_file $argv

    # apply rvm_* and *PATH variables from the captured environment
    and eval (grep '^rvm\|^[^=]*PATH\|^GEM_HOME' $env_file | grep -v '_clr=' | sed '/^[^=]*PATH/s/:/" "/g; s/^/set -xg /; s/=/ "/; s/$/" ;/; s/(//; s/)//')
    # clean up
    rm -f $env_file
  end

  function __handle_rvmrc_stuff --on-variable PWD
    # Source a .rvmrc file in a directory after changing to it, if it exists.
    # To disable this fature, set rvm_project_rvmrc=0 in $HOME/.rvmrc
    if test "$rvm_project_rvmrc" != 0
      set -l cwd $PWD
      while true
        if contains $cwd "" $HOME "/"
          if test "$rvm_project_rvmrc_default" = 1
            rvm default 1>/dev/null 2>&1
          end
          break
        else
          if test -e .rvmrc -o -e .ruby-version -o -e .ruby-gemset
            eval "rvm reload" > /dev/null
            eval "rvm rvmrc load" >/dev/null
            break
          else
            set cwd (dirname "$cwd")
          end
        end
      end

      set -e cwd
    end
  end

  # set --export PATH $HOME/.gems/bin $PATH
  if begin
      not which rvm > /dev/null
      and ls -A | \
      grep --extended-regexp '(\.rb$)|rakefile|gemfile|\.ruby-(gemset|version)' --ignore-case --silent
    end
    echo 'Ruby files found...loading rvm'
    rvm reload > /dev/null
  end
  cd .

  complete --command rvm --arguments '(rvm list strings)' --condition '__fish_print_cmd_args_without_options | ta 2 | grep --regexp "^use\$" --silent' --exclusive --authoritative
  complete --command rvm --arguments '(rvm list known strings)' --condition '__fish_print_cmd_args_without_options | ta 2 | grep --regexp "^install\$" --silent' --exclusive --authoritative

  complete --command rvm  --condition "begin; == 1 (count (__fish_print_cmd_args_without_options)); and not contains -- --default        (__fish_print_cmd_args); end"  --long-option default         --description "with 'rvm use X', sets the default ruby for new shells to X."
  complete --command rvm  --condition "begin; == 1 (count (__fish_print_cmd_args_without_options)); and not contains -- --debug          (__fish_print_cmd_args); end"  --long-option debug           --description "Toggle debug mode on for very verbose output."
  complete --command rvm  --condition "begin; == 1 (count (__fish_print_cmd_args_without_options)); and not contains -- --disable-binary (__fish_print_cmd_args); end"  --long-option disable-binary  --description "Install from source instead of using binaries"
  complete --command rvm  --condition "begin; == 1 (count (__fish_print_cmd_args_without_options)); and not contains -- --trace          (__fish_print_cmd_args); end"  --long-option trace           --description "Toggle trace mode on to see EVERYTHING rvm is doing."
  complete --command rvm  --condition "begin; == 1 (count (__fish_print_cmd_args_without_options)); and not contains -- --force          (__fish_print_cmd_args); end"  --long-option force           --description "Force install, removes old install & source before install."
  complete --command rvm  --condition "begin; == 1 (count (__fish_print_cmd_args_without_options)); and not contains -- --summary        (__fish_print_cmd_args); end"  --long-option summary         --description "Used with rubydo to print out a summary of the commands run."
  complete --command rvm  --condition "begin; == 1 (count (__fish_print_cmd_args_without_options)); and not contains -- --latest         (__fish_print_cmd_args); end"  --long-option latest          --description "with gemset --dump skips version strings for latest gem."
  complete --command rvm  --condition "begin; == 1 (count (__fish_print_cmd_args_without_options)); and not contains -- --gems           (__fish_print_cmd_args); end"  --long-option gems            --description "with uninstall/remove removes gems with the interpreter."
  complete --command rvm  --condition "begin; == 1 (count (__fish_print_cmd_args_without_options)); and not contains -- --docs           (__fish_print_cmd_args); end"  --long-option docs            --description "with install, attempt to generate ri after installation."
  complete --command rvm  --condition "begin; == 1 (count (__fish_print_cmd_args_without_options)); and not contains -- --reconfigure    (__fish_print_cmd_args); end"  --long-option reconfigure     --description "Force ./configure on install even if Makefile already exists."
  complete --command rvm  --condition "begin; == 1 (count (__fish_print_cmd_args_without_options)); and not contains -- --skip-gemsets   (__fish_print_cmd_args); end"  --long-option skip-gemsets    --description "with install, skip the installation of default gemsets."
  complete --command rvm  --condition "begin; == 1 (count (__fish_print_cmd_args_without_options)); and not contains -- --quiet-curl     (__fish_print_cmd_args); end"  --long-option quiet-curl      --description "Makes curl silent when fetching data"
  complete --command rvm  --condition "begin; == 1 (count (__fish_print_cmd_args_without_options)); and not contains -- -S               (__fish_print_cmd_args); end"  --short-option S               --description "Specify a script file to attempt to load and run (rubydo)"
  complete --command rvm  --condition "begin; == 1 (count (__fish_print_cmd_args_without_options)); and not contains -- -e               (__fish_print_cmd_args); end"  --short-option e               --description "Execute code from the command line."
  complete --command rvm  --condition "begin; == 1 (count (__fish_print_cmd_args_without_options)); and not contains -- --version        (__fish_print_cmd_args); and not contains -- -v (__fish_print_cmd_args); end"  --short-option v --long-option  version     --description "Emit rvm version loaded for current shell"
  complete --command rvm  --condition "begin; == 1 (count (__fish_print_cmd_args_without_options)); and not contains -- --level          (__fish_print_cmd_args); and not contains -- -l (__fish_print_cmd_args); end"  --short-option l --long-option  level       --description "patch level to use with rvm use / install"
  complete --command rvm  --condition "begin; == 1 (count (__fish_print_cmd_args_without_options)); and not contains -- --configure      (__fish_print_cmd_args); and not contains -- -C (__fish_print_cmd_args); end"  --short-option C --long-option  configure   --description "custom configure options. If you need to pass several configure options then append them comma separated."
  complete --command rvm  --condition "begin; == 1 (count (__fish_print_cmd_args_without_options)); and not contains -- --bin            (__fish_print_cmd_args); end"  --long-option  bin         --description "path for binaries to be placed (~/.rvm/bin/)"
  complete --command rvm  --condition "begin; == 1 (count (__fish_print_cmd_args_without_options)); and not contains -- --gems           (__fish_print_cmd_args); end"  --long-option  gems           --description "Used to set the 'gems_flag', use with 'remove' to remove gems"
  complete --command rvm  --condition "begin; == 1 (count (__fish_print_cmd_args_without_options)); and not contains -- --archive        (__fish_print_cmd_args); end"  --long-option  archive        --description "Used to set the 'archive_flag', use with 'remove' to remove archive"
  complete --command rvm  --condition "begin; == 1 (count (__fish_print_cmd_args_without_options)); and not contains -- --patch          (__fish_print_cmd_args); end"  --long-option  patch          --description "With MRI Rubies you may specify one or more full paths to patches"
  complete --command rvm  --condition "begin; == 1 (count (__fish_print_cmd_args_without_options)); and not contains -- --nice           (__fish_print_cmd_args); end"  --long-option  nice           --description "process niceness (for slow computers, default 0)"
  complete --command rvm  --condition "begin; == 1 (count (__fish_print_cmd_args_without_options)); and not contains -- --ree-options    (__fish_print_cmd_args); end"  --long-option  ree-options    --description "Options passed directly to ree's './installer' on the command line."
  complete --command rvm  --condition "begin; == 1 (count (__fish_print_cmd_args_without_options)); and not contains -- --with-rubies    (__fish_print_cmd_args); end"  --long-option  with-rubies    --description "Specifies a string for rvm to attempt to expand for set operations."


  complete --command rvm --arguments 'usage help'    --condition "== 1 (count (__fish_print_cmd_args_without_options))" --exclusive --description "show usage information"
  complete --command rvm --arguments version         --condition "== 1 (count (__fish_print_cmd_args_without_options))" --exclusive --description "show the rvm version installed in rvm_path"
  complete --command rvm --arguments use             --condition "== 1 (count (__fish_print_cmd_args_without_options))" --exclusive --description "setup current shell to use a specific ruby version"
  complete --command rvm --arguments reload          --condition "== 1 (count (__fish_print_cmd_args_without_options))" --exclusive --description "reload rvm source itself (useful after changing rvm source)"
  complete --command rvm --arguments implode         --condition "== 1 (count (__fish_print_cmd_args_without_options))" --exclusive --description "DANGER: (seppuku) removes the rvm installation completely."
  complete --command rvm --arguments get             --condition "== 1 (count (__fish_print_cmd_args_without_options))" --exclusive --description "{head,stable} upgrades rvm to latest head or stable version."
  complete --command rvm --arguments reset           --condition "== 1 (count (__fish_print_cmd_args_without_options))" --exclusive --description "remove current and stored default & system settings."
  complete --command rvm --arguments info            --condition "== 1 (count (__fish_print_cmd_args_without_options))" --exclusive --description "show the *current* environment information for current ruby"
  complete --command rvm --arguments current         --condition "== 1 (count (__fish_print_cmd_args_without_options))" --exclusive --description "print the *current* ruby version and the name of any gemset being used."
  complete --command rvm --arguments debug           --condition "== 1 (count (__fish_print_cmd_args_without_options))" --exclusive --description "show info plus additional information for common issues"
  complete --command rvm --arguments install         --condition "== 1 (count (__fish_print_cmd_args_without_options))" --exclusive --description "install one or many ruby versions"
  complete --command rvm --arguments uninstall       --condition "== 1 (count (__fish_print_cmd_args_without_options))" --exclusive --description "uninstall one or many ruby versions, leaves their sources"
  complete --command rvm --arguments remove          --condition "== 1 (count (__fish_print_cmd_args_without_options))" --exclusive --description "uninstall one or many ruby versions and remove their sources"
  complete --command rvm --arguments reinstall       --condition "== 1 (count (__fish_print_cmd_args_without_options))" --exclusive --description "reinstall ruby and runs gem pristine on all gems, make sure to read output, use 'all' for all rubies."
  complete --command rvm --arguments migrate         --condition "== 1 (count (__fish_print_cmd_args_without_options))" --exclusive --description "Lets you migrate all gemsets from one ruby to another."
  complete --command rvm --arguments upgrade         --condition "== 1 (count (__fish_print_cmd_args_without_options))" --exclusive --description "Lets you upgrade from one version of a ruby to another, including migrating your gemsets semi-automatically."
  complete --command rvm --arguments wrapper         --condition "== 1 (count (__fish_print_cmd_args_without_options))" --exclusive --description "generates a set of wrapper executables for a given ruby with the specified ruby and gemset combination. Used under the hood for passenger support and the like."
  complete --command rvm --arguments cleanup         --condition "== 1 (count (__fish_print_cmd_args_without_options))" --exclusive --description "Lets you remove stale source folders / archives and other miscellaneous data associated with rvm."
  complete --command rvm --arguments repair          --condition "== 1 (count (__fish_print_cmd_args_without_options))" --exclusive --description "Lets you repair parts of your environment e.g. wrappers, env files and and similar files (e.g. general maintenance)."
  complete --command rvm --arguments fix-permissions --condition "== 1 (count (__fish_print_cmd_args_without_options))" --exclusive --description "Repairs broken permissions (e.g. by sudo or chef)"
  complete --command rvm --arguments osx-ssl-certs   --condition "== 1 (count (__fish_print_cmd_args_without_options))" --exclusive --description "Helps update certificates for OpenSSL installed by rvm on OSX."
  complete --command rvm --arguments snapshot        --condition "== 1 (count (__fish_print_cmd_args_without_options))" --exclusive --description "Lets you backup / restore an rvm installation in a lightweight manner."
  complete --command rvm --arguments alias           --condition "== 1 (count (__fish_print_cmd_args_without_options))" --exclusive --description "Lets you set shortcut strings for convenience with 'rvm use'."
  complete --command rvm --arguments disk-usage      --condition "== 1 (count (__fish_print_cmd_args_without_options))" --exclusive --description "Tells you how much disk space rvm install is using."
  complete --command rvm --arguments tools           --condition "== 1 (count (__fish_print_cmd_args_without_options))" --exclusive --description "Provides general information about the ruby environment, primarily useful when scripting rvm."
  complete --command rvm --arguments docs            --condition "== 1 (count (__fish_print_cmd_args_without_options))" --exclusive --description "Tools to make installing ri and rdoc documentation easier."
  complete --command rvm --arguments rvmrc           --condition "== 1 (count (__fish_print_cmd_args_without_options))" --exclusive --description "Tools related to managing rvmrc trust and loading."
  complete --command rvm --arguments patchset        --condition "== 1 (count (__fish_print_cmd_args_without_options))" --exclusive --description "Tools related to managing ruby patchsets."
  complete --command rvm --arguments do              --condition "== 1 (count (__fish_print_cmd_args_without_options))" --exclusive --description "runs an arbitrary command against specified and/or all rubies"
  complete --command rvm --arguments cron            --condition "== 1 (count (__fish_print_cmd_args_without_options))" --exclusive --description "Manages setup for using ruby in cron tasks."
  complete --command rvm --arguments gemset          --condition "== 1 (count (__fish_print_cmd_args_without_options))" --exclusive --description "gemsets: https://rvm.io/gemsets/"
  complete --command rvm --arguments rubygems        --condition "== 1 (count (__fish_print_cmd_args_without_options))" --exclusive --description "Switches the installed version of rubygems for the current ruby."
  complete --command rvm --arguments config-get      --condition "== 1 (count (__fish_print_cmd_args_without_options))" --exclusive --description "display values for RbConfig::CONFIG variables."
  complete --command rvm --arguments gemdir          --condition "== 1 (count (__fish_print_cmd_args_without_options))" --exclusive --description "display the path to the current gem directory (GEM_HOME)."
  complete --command rvm --arguments fetch           --condition "== 1 (count (__fish_print_cmd_args_without_options))" --exclusive --description "Performs an archive / src fetch only of the selected ruby."
  complete --command rvm --arguments list            --condition "== 1 (count (__fish_print_cmd_args_without_options))" --exclusive --description "show currently installed rubies, interactive output."
  complete --command rvm --arguments autolibs        --condition "== 1 (count (__fish_print_cmd_args_without_options))" --exclusive --description "Controls settings for automatically installing dependencies."
  complete --command rvm --arguments pkg             --condition "== 1 (count (__fish_print_cmd_args_without_options))" --exclusive --description "Install a dependency package {readline,iconv,zlib,openssl}"
  complete --command rvm --arguments notes           --condition "== 1 (count (__fish_print_cmd_args_without_options))" --exclusive --description "Display notes, with operating system specifics."
  complete --command rvm --arguments export          --condition "== 1 (count (__fish_print_cmd_args_without_options))" --exclusive --description "Temporarily set an environment variable in the current shell."
  complete --command rvm --arguments unexport        --condition "== 1 (count (__fish_print_cmd_args_without_options))" --exclusive --description "Undo changes made to the environment by 'rvm export'."
  complete --command rvm --arguments requirements    --condition "== 1 (count (__fish_print_cmd_args_without_options))" --exclusive --description "Installs additional OS specific dependencies/requirements for building various rubies. Usually run by install."
  complete --command rvm --arguments mount           --condition "== 1 (count (__fish_print_cmd_args_without_options))" --exclusive --description "Install rubies from external locations."
  complete --command rvm --arguments user            --condition "== 1 (count (__fish_print_cmd_args_without_options))" --exclusive --description "Tools for managing RVM mixed mode in multiuser installations."
  complete --command rvm --arguments group           --condition "== 1 (count (__fish_print_cmd_args_without_options))" --exclusive --description "Tools for managing groups in multiuser installations."

  # Hrm... not working yet.
  complete --command rvm --condition 'begin; == 2 (count (__fish_print_cmd_args_without_options)); and __fish_print_cmd_args_without_options | ta 2 | grep --regexp "usage|help" --silent; end' --exclusive --authoritative --arguments 'alt color updgrade-notes usage help version use reload implode get reset info current debug install uninstall remove reinstall migrate upgrade wrapper cleanup repair fix-permissions osx-ssl-certs snapshot alias disk-usage tools docs rvmrc patchset do cron gemset rubygems config-get gemdir fetch list autolibs pkg notes export unexport requirements mount user group'

  __handle_rvmrc_stuff
end

# Rake completion helper
# TODO - This shouldn't be is complicated.
function test_for_rake
  begin
    [ -f Rakefile ]
    or [ -f rakefile ]
    or [ -f Rakefile.rb ]
    or [ -f rakefile.rb ]
  end
end

# TODO - fix-me-up
function __rake_checksum
  md5sum Rakefile | sed --regexp-extended 's/^\b(.+)\b +Rakefile$/\1/'
end

# Rake completion helper
function rake_args
  set task_full  /tmp/Rakefile.tasks.full.(__rake_checksum)
  if not [ -f $task_full ]
    if [ -f Gemfile ]
      set rake_prefix 'bundle exec'
    end

    eval $rake_prefix rake -T \
    | sed --regexp-extended   's/^rake (((\w|\[|\]|-|\,)+)(\:(\w|\[|\]|-|\,)+)*) +# (.+)$/\1\t\6/' \
    > $task_full
  end
  cat $task_full
end

complete --command rake --condition 'test_for_rake' --arguments '(rake_args)' --no-files
