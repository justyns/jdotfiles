#!/bin/bash

# Sets ntp servers in osx and makes sure the clock is up to date
echo "Old time server:"
/usr/sbin/systemsetup -getnetworktimeserver
/usr/sbin/systemsetup -setnetworktimeserver time.apple.com,0.us.pool.ntp.org,1.us.pool.ntp.org,2.us.pool.ntp.org,3.us.pool.ntp.org
echo "New time server:"
/usr/sbin/systemsetup -getnetworktimeserver
echo "Syncing time"
/usr/sbin/systemsetup -setusingnetworktime off
ntpdate -u time.apple.com 0.us.pool.ntp.org 1.us.pool.ntp.org
/usr/sbin/systemsetup -setusingnetworktime on

