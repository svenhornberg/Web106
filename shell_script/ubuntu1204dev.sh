#!/bin/bash

### install

apt-get update && apt-get upgrade -y

#git
apt-get install git -y

#zip
apt-get install unzip -y



#download grails and unzip
cd ~/
mkdir grails
cd ~/grails
wget http://dist.springframework.org.s3.amazonaws.com/release/GRAILS/grails-2.3.1.zip
unzip -o grails-2.3.1.zip

#maven
wget http://www.motorlogy.com/apache/maven/maven-3/3.1.1/binaries/apache-maven-3.1.1-bin.zip
unzip -o apache-maven-3.1.1-bin.zip 

#gradle
wget http://services.gradle.org/distributions/gradle-1.8-all.zip
unzip -o gradle-1.8-all.zip

#java 
apt-get install openjdk-7-jdk openjdk-7-source openjdk-7-doc openjdk-7-jre-headless openjdk-7-jre-lib -y

#go to homedir
cd ~/

#change owning user from grails dir
chown -R $(whoami) grails

#craete & chown .m2
mkdir .m2
chown -R $(whoami) .m2

### setting env vars

echo "JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk-i386\n" >> .bashrc
echo "M2_HOME=~/grails/apache-maven-3.1.1\n" >> .bashrc
echo "GRAILS_HOME=~/grails/grails-2.3.1\n" >> .bashrc
echo "MAVEN_REPO=~/.m2" >> .bashrc
echo "GRADLE_HOME=~/grails/gradle-1.8\n" >> .bashrc

echo "PATH=\$PATH:\$HOME/.local/bin:\$HOME/bin:\$GRAILS_HOME/bin:M2_HOME:\$JAVA_HOME/bin:\$GRADLE_HOME/bin\n" >> .bashrc

echo "export JAVA_HOME\n" >> .bashrc 
echo "export M2_HOME\n" >> .bashrc 
echo "export GRAILS_HOME\n" >> .bashrc 
echo "export MAVEN_REPO\n" >> .bashrc 
echo "export GRADLE_HOME\n" >> .bashrc 
echo "export PATH\n" >> .bashrc 

echo "please reboot and test grails & java"

