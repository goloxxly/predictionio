#!/bin/bash
$PIO_HOME/bin/pio-start-all

# Set up an application to access PredictionIO
if [ -z "$APP_NAME" ]; then
  # Use default app name in case it's not set through env var yet
  APP_NAME=MyApp
fi

export APP_NAME

$PIO_HOME/bin/pio app new $APP_NAME


# Check out an engine template and install it if
if [ ! -z "$ENGINE_GIT_URL" ]; then
  git clone $ENGINE_GIT_URL engine
  cd engine
  cat engine.json | jq '.datasource.params.appName=env.APP_NAME' > engine.json.tmp && mv engine.json.tmp engine.json
  $PIO_HOME/bin/pio build --verbose
  $PIO_HOME/bin/pio train
  $PIO_HOME/bin/pio deploy
fi

tail -f ~/nohup.out
