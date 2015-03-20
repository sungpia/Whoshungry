import requests
import json
BASEURL = "http://localhost:3000/v1/"

user1 = {
	     "name": "Sungwon Chung",
            "picture": "https://graph.facebook.com/706746956077461/picture?type=square",
            "contact": "5129994336",
            "email": "sungpia@icloud.com",
            "fb_id": "706746956077461",
            "os_type": "ios",
            "push_id": "bf49597efa5d853de8c3a12369b9073090062157adf9afde20647c2bb7a88880",
            "password" : "1234"
}
user2 = {
	     "name": "Samuel Chung",
            "picture": "https://graph.facebook.com/1401474440166492/picture?type=square",
            "contact": "5129994333",
            "email": "sungpichung@gmail.com",
            "fb_id": "1401474440166492",
            "os_type": "ios",
            "push_id": "aa69d4d69076b26ca1996b068e6a38cb5c80bfa4b23a332427c7d32e13d5b700",
            "password" : "1234"
}
login1 = {
	"id" : 1,
	"password" : "1234"
}
login2 = {
	"id" : 2,
	"password" : "1234"
}
# create user 
#print requests.post(BASEURL + "/user", data=user1).text
#print requests.post(BASEURL + "/user", data=user2).text

logindata= json.loads(requests.post(BASEURL+"login", data=login1).text)
token= logindata["token"]
user_id = logindata["user_id"]
# show user
#print requests.get(BASEURL + "/user/" + token + "/" + str(user_id)).text
# delete user
#print requests.delete(BASEURL + "/user/" + token + "/" + str(user_id)).text
