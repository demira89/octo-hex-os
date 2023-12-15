#!/usr/bin/bash

echo "Init was run"
export PWD="/d/osdev"
export PATH="/ucrt64/bin:/usr/local/bin:/usr/bin:/bin:/c/Windows/System32:/c/Windows:/c/Windows/System32/Wbem:/c/Windows/System32/WindowsPowerShell/v1.0/:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl"
cd /d/osdev

source /etc/profile
source ~/.bash_profile
if [ -f "${HOME}/.bash_login" ]; then
    source ~/.bash_login
fi
source ~/.profile
cd /d/osdev
