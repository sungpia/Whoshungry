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

print requests.get(BASEURL + token + "/restaurant/ChIJoQKzBAq1RIYR9vDjI9c6QZs").text
#{"id":1,"place_id":"ChIJoQKzBAq1RIYR9vDjI9c6QZs","name":"Jimmy John's","picture":"CmRgAAAAfUnhNZ","lat":30.27072,"lng":-97.74253,"rating":4.32,"created_at":"2015-03-29 21:16:19 UTC","updated_at":"2015-03-29 21:16:19 UTC"}
