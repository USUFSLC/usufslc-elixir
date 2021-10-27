#!/bin/sh

echo "
<!DOCTYPE html>
<html>
  <head>
    <title>The Page Of $1</title>
    <style>
      body {
        margin:40px auto;
        max-width:650px;
        line-height:1.6;
        font-size:18px;
        color:#444;
        padding:0 10px
      }
      h1,h2,h3 {
        line-height:1.2
      }
    </style>
  </head>
  <body>
    <h1>$1</h1>
    <p>Lorem ipsum.</p>
  </body>
</html>
" >> users/$1.html
