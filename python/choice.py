import requests
import json
BASEURL = "http://localhost:3000/v1/"

choice = {
    "place_id" : "ChIJoQKzBAq1RIYR9vDjI9c6QZs",
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
	"id" : 1,
	"password" : "1234"
}

logindata= json.loads(requests.post(BASEURL+"login", data=login1).text)
token= logindata["token"]
user_id = logindata["user_id"]

vote_id = 1
choice_id = 1
print requests.post(BASEURL + token + "/" + str(vote_id) + "/choice/" + str(choice_id), data= count).text