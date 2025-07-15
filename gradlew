#!/usr/bin/env sh
# Simple Gradle wrapper
DIR="$(cd "$(dirname "$0")" && pwd)"
JAR="$DIR/android/gradle/wrapper/gradle-wrapper.jar"
if [ ! -f "$JAR" ]; then
  echo "Gradle wrapper jar not found: $JAR" >&2
  echo "Please download gradle-wrapper.jar and place it at the above path." >&2
  exit 1
fi
exec java -classpath "$JAR" org.gradle.wrapper.GradleWrapperMain "$@"

