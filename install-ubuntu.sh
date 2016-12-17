#!/usr/bin/env bash

if [[ $(id -u) -ne 0 ]] ; then echo "Please run as root ( sudo install-ubuntu.sh )" ; exit 1 ; fi

# Update all
apt-get update

# Curl
if hash curl 2>/dev/null; then
    echo "Curl is installed ✓"
else
    echo "Need to install Curl ..."
    apt-get -y install curl
    echo "Curl installation complete ✓"
fi

# Java
if hash java 2>/dev/null; then
    echo "Java is installed ✓"
else
    echo "Need to install Java ..."
	apt-get -y install default-jre default-jdk
    echo "Java installation complete ✓"
fi


# Ruby
if hash ruby 2>/dev/null; then
    echo "Ruby is installed ✓"
else
    echo "Need to install Ruby ..."
    apt-get -y install ruby-full
    echo "Ruby installation complete ✓"
fi


# unzip
if hash unzip 2>/dev/null; then
    echo "unzip is installed ✓"
else
    echo "Need to install unzip ..."
    apt-get -y install unzip
    echo "unzip installation complete ✓"
fi

VERSION="3.0.1"

# Swift
if hash swift 2>/dev/null; then
    echo "Swift is installed ✓"
else
    echo "Need to install Swift ..."    
	# Determine OS
	UNAME=`uname`;
	if [[ $UNAME == "Darwin" ]];
	then
	    OS="macos";
	else
	    if [[ $UNAME == "Linux" ]];
	    then
	        UBUNTU_RELEASE=`lsb_release -a 2>/dev/null`;
	        if [[ $UBUNTU_RELEASE == *"16.04"* ]];
	        then
	            OS="ubuntu1604";
	        else
	            OS="ubuntu1510";
	        fi
	    else
	        echo "Unsupported Operating System: $UNAME";
	    fi
	fi
	echo "🖥 Operating System: $OS";
	
	if [[ $OS != "macos" ]];
	then
	    echo "📚 Installing Dependencies"
	    sudo apt-get install -y clang libicu-dev uuid-dev
        
	    echo "🐦 Installing Swift";
	    if [[ $OS == "ubuntu1604" ]];
	    then
	        SWIFTFILE="swift-$VERSION-RELEASE-ubuntu16.04";    
	    else
	        SWIFTFILE="swift-$VERSION-RELEASE-ubuntu15.10";
	    fi
	    wget https://swift.org/builds/swift-$VERSION-release/$OS/swift-$VERSION-RELEASE/$SWIFTFILE.tar.gz
	    tar -zxf $SWIFTFILE.tar.gz
	    
	    # following needs to be saved to ~/.profile
	    export PATH=$PWD/$SWIFTFILE/usr/bin:"${PATH}"
	    

        rm -rf $SWIFTFILE
        rm $SWIFTFILE.tar.gz
	fi
	
	echo "📅 Version: `swift --version`";
	
    echo "Swift installation complete ✓"
fi


# Vapor
if hash vapor 2>/dev/null; then
    echo "Vapor is installed, updating ..."
    vapor self update
    echo "Vapor is up to date ✓"
else
    echo "Need to install Vapor ..."
    curl -sL toolbox.qutheory.io | sh
    echo "Vapor installation complete ✓"
fi




