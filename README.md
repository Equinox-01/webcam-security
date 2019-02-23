# Webcam Security

Webcam Security is a ruby application which work with OpenCV and using Telegram-bot for notification.

### Installation

That app requires Ruby 2.5.1 to run.

Enter in project folder:
```sh
cd webcam_security
```
Install gems with bundle:
```sh
bundle install
```
Also you need OpenCV

for OS X:
```sh
brew install opencv
```
If you getting error - try that:
```sh
brew install opencv@2
```
You need to create telegram-bot and get TOKEN (more here https://core.telegram.org/bots#3-how-do-i-create-a-bot)
Also, you need to create 'secrets.yml' file with following content:
```
TELEGRAM_BOT_TOKEN: '<Your telegram token>'
USER_GUID: <Your chat id>
```

### Using

For application start enter in terminal:

```sh
ruby application.rb -e <sensitivity of algorithm> -c <Camera number>
```
or just enter:
```sh
ruby application.rb
```

###### After that, run '/start' command in chat with telegram-bot.
\
\
© Stanislav Vereskovsky, 2019
