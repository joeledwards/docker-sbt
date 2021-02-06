# This Dockerfile has two required ARGs to determine which base image
# to use for the JDK and which sbt version to install.

ARG OPENJDK_TAG=16-slim-buster
FROM openjdk:${OPENJDK_TAG}

ARG SBT_VERSION=1.4.7

# Install sbt
RUN \
  mkdir /working/ && \
  cd /working/ && \
  apt-get update && \
  apt-get install -yq curl && \
  curl -L -o sbt-$SBT_VERSION.deb https://dl.bintray.com/sbt/debian/sbt-$SBT_VERSION.deb && \
  dpkg -i sbt-$SBT_VERSION.deb && \
  rm sbt-$SBT_VERSION.deb && \
  apt-get update && \
  apt-get install sbt && \
  cd && \
  rm -r /working/ && \
  sbt sbtVersion

RUN mkdir /app
WORKDIR /app

CMD ["sbt"]
