export JAVA_7_HOME=$(/usr/libexec/java_home -v1.7)
# export JAVA_8_HOME=$(/usr/libexec/java_home -v1.8)
export JAVA_8_HOME=/Library/Java/JavaVirtualMachines/jdk-1.8.jdk/Contents/Home
# # export JAVA_9_HOME=$(/usr/libexec/java_home -v9)
# # export JAVA_10_HOME=$(/usr/libexec/java_home -v10)
# export JAVA_12_HOME=$(/usr/libexec/java_home -v12)
export JAVA_13_HOME=$(/usr/libexec/java_home -v13)
export JAVA_16_HOME=$(/usr/libexec/java_home -v16)
export JAVA_17_HOME=$(/usr/libexec/java_home -v17)
export JAVA_18_HOME=$(/usr/libexec/java_home -v18)

export JAVA_AS_HOME="/Applications/Android Studio.app/Contents/jbr/Contents/Home"

alias java7='export JAVA_HOME=$JAVA_7_HOME'
alias java8='export JAVA_HOME=$JAVA_8_HOME'
# alias java9='export JAVA_HOME=$JAVA_9_HOME'
# alias java10='export JAVA_HOME=$JAVA_10_HOME'
# alias java12='export JAVA_HOME=$JAVA_12_HOME'
alias java13='export JAVA_HOME=$JAVA_13_HOME'
alias java16='export JAVA_HOME=$JAVA_16_HOME'
alias java17='export JAVA_HOME=$JAVA_17_HOME'
alias javaas='export JAVA_HOME=$JAVA_AS_HOME'
alias java18='export JAVA_HOME=$JAVA_18_HOME'

# default to Java Android Studio
java13
