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

export JAVA_7_HOME=$(/usr/libexec/java_home -v1.7)
# export JAVA_8_HOME=$(/usr/libexec/java_home -v1.8)
export JAVA_8_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_241.jdk/Contents/Home
# # export JAVA_9_HOME=$(/usr/libexec/java_home -v9)
# # export JAVA_10_HOME=$(/usr/libexec/java_home -v10)
# export JAVA_12_HOME=$(/usr/libexec/java_home -v12)
export JAVA_13_HOME=$(/usr/libexec/java_home -v13)
export JAVA_16_HOME=$(/usr/libexec/java_home -v16)

export JAVA_AS_HOME="/Applications/Android Studio.app/Contents/jre/jdk/Contents/Home"

alias java7='export JAVA_HOME=$JAVA_7_HOME'
alias java8='export JAVA_HOME=$JAVA_8_HOME'
# alias java9='export JAVA_HOME=$JAVA_9_HOME'
# alias java10='export JAVA_HOME=$JAVA_10_HOME'
# alias java12='export JAVA_HOME=$JAVA_12_HOME'
alias java13='export JAVA_HOME=$JAVA_13_HOME'
alias java16='export JAVA_HOME=$JAVA_16_HOME'
alias javaas='export JAVA_HOME=$JAVA_AS_HOME'

# default to Java Android Studio
java13
