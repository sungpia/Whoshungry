import requests
import json
BASEURL = "http://localhost:3000/v1/"

create_vote = {}
create_vote["vote_type"] = "lunch"
create_vote["name"] = "Let's go Lunch"
create_vote["expires_in"] = 1
create_vote["expires_at"] = "2015-03-07T21:24:17.830Z"
create_vote["restaurants"] = []

tmp = {}
tmp["place_id"] = "ChIJoQKzBAq1RIYR9vDjI9c6QZs"
tmp["name"] = "Jimmy John's"
tmp["picture"] = "CmRgAAAAfUnhNZ"
tmp["lat"] = 30.27072
tmp["lng"] = -97.74253
tmp["rating"] = 4.32
create_vote["restaurants"].append(tmp)

tmp = {}
tmp["place_id"] = "2"
tmp["name"] = "3 John's"
tmp["picture"] = "4"
tmp["lat"] = 30.27072
tmp["lng"] = -97.74253
tmp["rating"] = 4.32

create_vote["restaurants"].append(tmp)

create_vote = json.dumps(create_vote)
group_id = 1

login1 = {
	"user_id" : 1,
	"access_token" : "001001002003"
}
print create_vote
logindata= json.loads(requests.post(BASEURL+"auth", data=login1).text)
token= logindata["token"]
user_id = logindata["user_id"]
print requests.post(BASEURL + token + "/" + str(group_id) + "/votes", data = create_vote).text

#create vote: {"id":2,"group_id":7,"vote_type":null,"name":"Let's go Lunch","expires_in":1,"expires_at":"2015-03-07 21:24:17 UTC","created_at":"2015-03-29 21:19:17 UTC","updated_at":"2015-03-29 21:19:17 UTC","choices":[{"id":3,"vote_id":2,"restaurant_id":1,"count":0,"count_lock":false,"created_at":"2015-03-29 21:19:17 UTC","updated_at":"2015-03-29 21:19:17 UTC"},{"id":4,"vote_id":2,"restaurant_id":2,"count":0,"count_lock":false,"created_at":"2015-03-29 21:19:17 UTC","updated_at":"2015-03-29 21:19:17 UTC"}]}
