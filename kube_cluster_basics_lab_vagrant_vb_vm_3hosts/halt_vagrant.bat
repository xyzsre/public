@echo off
echo Halting all Vagrant hosts...
vagrant status
vagrant halt host1
vagrant halt host2
vagrant halt host3
vagrant status
echo All Vagrant hosts have been halted.
