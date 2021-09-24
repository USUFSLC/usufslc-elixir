## Setting up Phoenix and Elixir with PostgreSQL on Arch Linux to run the Dev Environment

### Install dependencies

```
cd ~
sudo pacman -Syu
sudo pacman -S postgresql erlang elixir python git make
```

### Configure postgresql

* Initialize db
```
sudo su
su postgres -c "initdb --locale=en_US.UTF-8 -E UTF8 -D /var/lib/postgres/data"
```

* Add postgresql to boot via soy-stemd

```
systemctl enable postgresql
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
cd assets && make all
mix deps.compile
```

* Ask Logan for a sendgrid api key if you want to send emails

* Configure your .env

```
echo "
POSTGRES_USER=postgres
POSTGRES_HOSTNAME=localhost
HTTP_PORT=4000

SENDGRID_API_KEY=ajsdkfalsdjflaksdlfkjaldfj
" > .env
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
