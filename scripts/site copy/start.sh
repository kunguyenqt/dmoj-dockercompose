#!/bin/bash
if [ ! -e /site/install_done ]; then
    if [ ! -e /site/manage.py ]; then
        echo "firstrun: Extracting data"
        cp -r --preserve=all /osite/. /site
        chown -R dmoj:dmoj /site
    fi
    echo "firstrun: Migrating database"
    echo "firstrun: Done"
    touch /site/install_done
fi
service nginx start
service supervisor start
tail -F /tmp/site.stderr.log
