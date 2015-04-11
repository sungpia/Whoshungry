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

vote_id = 3 

loc = {
	"lat" : 1,
	"lng" : 2,
	"pickup" : 3
}
#print requests.post(BASEURL + token + "/locations", data= loc).text
print requests.get(BASEURL + token + "/1/locations").text