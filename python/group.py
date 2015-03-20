import requests
import json
BASEURL = "http://localhost:3000/v1/"

login1 = {
	"id" : 1,
	"password" : "1234"
}
login2 = {
	"id" : 2,
	"password" : "1234"
}


make_group = {}
make_group["invitation"] = []
tmp = {}
tmp["id"] = 1
tmp["fb_id"] = "706746956077461"
make_group["invitation"].append(tmp)
tmp = {}
tmp["fb_id"] = "1401474440166492"
make_group["invitation"].append(tmp)
make_group = json.dumps(make_group)


logindata= json.loads(requests.post(BASEURL+"login", data=login1).text)
token= logindata["token"]
user_id = logindata["user_id"]
group_id = 11
#print requests.post(BASEURL + token + "/group", data= make_group).text
#print requests.delete(BASEURL + token + "/group", data= make_group).text
#print requests.update(BASEURL + token + "/group", data= make_group).text
print requests.get(BASEURL + token + "/group/" + str(group_id), data= make_group).text
