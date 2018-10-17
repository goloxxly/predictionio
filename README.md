# PredictionIO Docker image

Docker image based on CentOS 7 running [Apache PredictionIO](http://predictionio.apache.org/) version 0.13.0

## Possible environment variables

 - ``ENGINE_GIT_URL`` - (optional) Url of the Git repository to check the engine template out from
 - ``APP_NAME`` - (optional, default value: "MyApp") Name of the app that will access PredictionIO.
 - ``ACCESS_KEY`` - (optional) Access key to be used with the application. If not defined, PredictionIO will generate one that can be found in the logs of the container then.
 - ``TRAIN_DEPLOY_CRONTAB_DEF`` - (optional, default value: `"0 * * * *"`) Crontab definition that schedules running pio train and deploy to update your model with the latest data.
