# sms-gateway
Gateway to read / send SMS  from e3372h modem with hlcli

## Install
```sh
pip install -r requirements.txt
```

You also need hlcli from this repo:
https://github.com/knq/hilink

## Start the app

```sh
./start.py
```

## Usage

### Read last unread message
```sh
curl -X GET http://127.0.0.1:5000/read
```

### Send a SMS
```sh
curl -X POST -d to=33xxx -d message='salut les gens! :p' http://127.0.0.1:5000/send
```
