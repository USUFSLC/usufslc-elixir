## Setting up Phoenix and Elixir with PostgreSQL on Arch Linux to run the Dev Environment

### Install dependencies

```
cd ~
sudo pacman -Syu
sudo pacman -S postgresql erlang elixir openssl python inotify-tools git npm6 nodejs-lts-fermium
```

### Configure postgresql

* Initialize db
```
sudo su
su postgres -c "initdb --locale=en_US.UTF-8 -E UTF8 -D /var/lib/postgres/data"
```

* Generate a password and save it (make sure to delete afterwards)

```
postgresql_password="$(openssl rand -base64 10)"
echo "$postgresql_password" > password.txt
```

* Allow only local connections without a password so that we can set the password for the postgres user

```
echo "
local all all              trust
host  all all 127.0.0.1/32 trust
host  all all ::1/128      trust
" > /var/lib/postgres/data/pg_hba.conf
```

* Set password encryption mode

```
echo "
password_encryption = scram-sha-256
" >> /var/lib/postgres/data/postgresql.conf
```


* Add postgresql to boot via soy-stemd

```
systemctl enable postgresql
systemctl restart postgresql
```

* Add postgres password for logging into db

```
su - postgres -c "psql -c \"alter user postgres with encrypted password '$postgresql_password'\""
```

* Now we can change the configuration to only allow hashed passwords from local connections

```
echo "
local all all               scram-sha-256
host  all all 127.0.0.1/32  scram-sha-256
host  all all ::1/128       scram-sha-256
" > /var/lib/postgres/data/pg_hba.conf
```

* Restart the postgresql service

```
systemctl restart postgresql
```

### Phoenix installation

* Get out of root su

```
exit
```

* Download hex

```
mix local.hex --force
mix archive.install hex phx_new --force
```

### Phoenix configuration

* Clone repo

```
git clone git@github.com:USUFSLC/website-v2.git fslc-website
cd fslc-website
```

* Get dependencies
```
mix deps.get
cd assets && npm install && node node_modules/webpack/bin/webpack.js --mode development
mix deps.compile
```

* Add the database password to the dev server startup script

```
sed -i "s/POSTGRES_PASS=.*$/POSTGRES_PASS=\"$postgresql_password\"/g" start_dev_server.sh
```

* Add the app database for phoenix

```
mix ecto.create
```

* Migrate the database

```
mix ecto.migrate
```

* Finally, start the server

```
bash start_dev_server.sh
```

### Delete the postgresql password.txt file we made earlier

```
rm ~/password.txt
```
