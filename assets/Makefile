app.css: css/app.scss
	echo 'Building CSS...'
	sass css/app.scss ../priv/static/css/app.css

app.js: js/app.js
	echo 'Building JS...'
	esbuild --bundle --sourcemap --target=es2016 --outfile=../priv/static/js/app.js js/app.js

static_assets: static
	echo 'Building static...'
	cp -R static/* ../priv/static/

all: app.css app.js static_assets

clean:
	echo 'Cleaning assets...'
	rm -rf ../priv/static/*

