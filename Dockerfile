FROM elixir:1.12.2-alpine AS build

# install build dependencies
RUN apk add --no-cache build-base git python3 npm

# prepare build dir
WORKDIR /app

# install hex + rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# set build ENV
ENV MIX_ENV=prod

# install mix dependencies
COPY mix.exs mix.lock ./
COPY config config
RUN mix do deps.get, deps.compile

# build assets
RUN npm install -g sass esbuild

COPY priv priv
COPY assets assets
WORKDIR /app/assets
RUN make all
WORKDIR /app
RUN mix phx.digest

# compile and build release
COPY lib lib
# uncomment COPY if rel/ exists
# COPY rel rel
RUN mix do compile, release

# prepare release image
FROM alpine:3.9 AS app
RUN apk upgrade --no-cache && \
    apk add --no-cache postgresql-client bash openssl libgcc libstdc++ ncurses-libs


WORKDIR /app

RUN chown nobody:nobody /app

USER nobody:nobody

# Copy user pages
COPY users users
COPY --from=build --chown=nobody:nobody /app/_build/prod/rel/fslc ./

ENV HOME=/app

CMD bin/fslc eval "Fslc.Release.migrate" && bin/fslc start
