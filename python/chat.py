import requests
import json
BASEURL = "http://localhost:3000/v1/"
login1 = {
	"user_id" : 1,
	"access_token" : "001001002003"
}
logindata= json.loads(requests.post(BASEURL+"auth", data=login1).text)
token= logindata["token"]
user_id = logindata["user_id"]

data = {
	"text": "TEST"
}
#post or get
print requests.post(BASEURL+ token + "/1/chat", data=data).text
