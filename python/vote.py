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
group_id = 11

login1 = {
	"id" : 1,
	"password" : "1234"
}

logindata= json.loads(requests.post(BASEURL+"login", data=login1).text)
token= logindata["token"]
user_id = logindata["user_id"]

print requests.get(BASEURL + token + "/" + str(group_id) + "/vote" + "/1", data = create_vote).text