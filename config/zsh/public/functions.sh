function flutter_code_build {
    if [ -z "$1" ]
    then
        echo "Usage: flutter_code_build run|build"
    else
        flutter packages pub run build_runner $1
    fi
}

function clean_gradle_projects {
    if [ -z "$1" ]
    then
        echo "Usage: clean_gradle_projects [path]"
    else
        if [ -d "$1" ]
        then
            cd $1;
            find . -name 'gradlew' -type f | \
            sed 's/gradlew//' | \
            xargs -I % sh -c 'cd "%" ; \
            echo "-------------" ; \
            pwd ; \
            echo "-------------" ; \
            ./gradlew clean ; \'
            echo
            echo "Remove extra apks..."
            find . -name '*apk' | xargs rm
            echo "Done!"
            echo "Remove hprof files..."
            find . -name '*hprof' | xargs rm
            echo "Done!"
            cd -
        else
            echo "Directory doesn't exists $1"
        fi
    fi
}

PATH_BREW_FILE="$HOME/.dotfiles/packages/Brewfile"

function export_apps() {
  if [ -z "$1" ]
  then
    rm "$PATH_BREW_FILE"
  fi
  brew services stop --all
  brew bundle dump --file="$PATH_BREW_FILE"
}

function import_apps() {
  brew services stop --all
  brew bundle --file="$PATH_BREW_FILE" --force

  xcode-select --install
}
