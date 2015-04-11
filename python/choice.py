import requests
import json
BASEURL = "http://localhost:3000/v1/"

choice = {
    "place_id" : "ChIJoQKzBAq1RIYR9vDjI9c6Q11",
    "name" : "Jimmy John's",
    "picture" : "CmRgAAAAfUnhNZ-skokyBSxk5_b1OsACU_zGqvsYPP_-tgNoPsrbjDVcCExEY8FbMn76LRtQkFHmV7m-siNPEP8H22JfhE_oQAKnSMnAEfecOSbhwWD66yxN6rN6Nl0MwamKSp9FEhCh8fGG6nziK5UbEMGnGj7eGhQSzqaZxnYKHaPGssQGcFEz5QvQgw",
    "lat" : 30.27072,
    "lng" : -97.74252,
    "rating" : 4.32
}
count = {
	"count" : -1
}
login1 = {
	"user_id" : 1,
	"access_token" : "001001002003"
}

logindata= json.loads(requests.post(BASEURL+"auth", data=login1).text)
token= logindata["token"]
user_id = logindata["user_id"]

vote_id = 3
choice_id = 14
#print requests.get(BASEURL + token + "/" + str(vote_id) + "/choices").text
#print requests.post(BASEURL + token + "/" + str(vote_id) + "/choices", data= choice).text
#creating new choice: {"id":14,"restaurant_id":4,"count":0,"created_at":"2015-03-29 21:39:50 UTC","updated_at":"2015-03-29 21:39:50 UTC"}
print requests.put(BASEURL + token + "/choice/" + str(choice_id), data= count).text
#{"id":14,"vote_id":3,"restaurant_id":4,"count":-2,"created_at":"2015-03-29 21:39:50 UTC","updated_at":"2015-03-29 22:07:51 UTC"}