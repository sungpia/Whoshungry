import requests
import json
BASEURL = "https://whoshungryapi.com/v1/"

login1 = {
	"user_id" : 1,
	"access_token" : "001001002003"
}
login2 = {
	"id" : 2,
	"password" : "1234"
}


make_group = {}
make_group["invitation"] = []
tmp = {}
tmp["contact"] = "+15129994336"
make_group["invitation"].append(tmp)
tmp = {}
tmp["contact"] = "+15129994333"
make_group["invitation"].append(tmp)
make_group = json.dumps(make_group)
print make_group
logindata= json.loads(requests.post(BASEURL+"auth", data=login1).text)
token= logindata["token"]
user_id = logindata["user_id"]
group_id = 11
#print requests.get(BASEURL + token + "/groups", data= make_group).text
print requests.post(BASEURL + token + "/groups", data= make_group).text
#print requests.delete(BASEURL + token + "/group", data= make_group).text
#print requests.update(BASEURL + token + "/group", data= make_group).text
#print requests.get(BASEURL + token + "/group/" + str(group_id), data= make_group).text
# create user: {"id":7,"user_id":1,"created_at":"2015-03-27 23:54:55 UTC","updated_at":"2015-03-27 23:54:55 UTC","users":[{"id":1,"fb_id":"706746956077461","name":"Sungwon Chung","picture":"https://graph.facebook.com/706746956077461/picture?type=square","contact":"+15129994336","email":"sungpia@icloud.com","created_at":"2015-03-27 23:39:28 UTC","updated_at":"2015-03-27 23:39:28 UTC","devices":[{"user_id":1,"id":1,"os_type":"ios","push_id":"bf49597efa5d853de8c3a12369b9073090062157adf9afde20647c2bb7a88880","created_at":"2015-03-27 23:39:28 UTC","updated_at":"2015-03-27 23:39:28 UTC"}]},{"id":2,"fb_id":"1401474440166492","name":"Samuel Chung","picture":"https://graph.facebook.com/1401474440166492/picture?type=square","contact":"+15129994333","email":"sungpichung@gmail.com","created_at":"2015-03-27 23:40:00 UTC","updated_at":"2015-03-27 23:40:00 UTC","devices":[{"user_id":2,"id":2,"os_type":"ios","push_id":"aa69d4d69076b26ca1996b068e6a38cb5c80bfa4b23a332427c7d32e13d5b700","created_at":"2015-03-27 23:40:00 UTC","updated_at":"2015-03-27 23:40:00 UTC"}]}]}