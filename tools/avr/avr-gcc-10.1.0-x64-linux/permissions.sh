#!/bin/sh

# Set executable permissions

VERSION=10.1.0

chown ${USER} avr/bin/*
chown ${USER} bin/*
chown ${USER} libexec/gcc/avr/${VERSION}/cc1
chown ${USER} libexec/gcc/avr/${VERSION}/cc1plus
chown ${USER} libexec/gcc/avr/${VERSION}/collect2
chown ${USER} libexec/gcc/avr/${VERSION}/lto1
chown ${USER} libexec/gcc/avr/${VERSION}/lto-wrapper
chown ${USER} libexec/gcc/avr/${VERSION}/install-tools/*
chown ${USER} libexec/gcc/avr/${VERSION}/plugin/gengtype

chmod +x avr/bin/*
chmod +x bin/*
chmod +x libexec/gcc/avr/${VERSION}/cc1
chmod +x libexec/gcc/avr/${VERSION}/cc1plus
chmod +x libexec/gcc/avr/${VERSION}/collect2
chmod +x libexec/gcc/avr/${VERSION}/lto1
chmod +x libexec/gcc/avr/${VERSION}/lto-wrapper
chmod +x libexec/gcc/avr/${VERSION}/install-tools/*
chmod +x libexec/gcc/avr/${VERSION}/plugin/gengtype
