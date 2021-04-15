#!/bin/bash
sed -i "s#return.*\;#return \"Mozilla\/5\.0 \(Macintosh\; Intel Mac OS X 10_15_4\) AppleWebKit\/537\.36 \(KHTML\, like Gecko\) Chrome\/81\.0\.4044\.113 Safari\/537\.36\"\; #g" ~/.config/Ferdi/recipes/whatsapp/index.js
