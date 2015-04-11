import requests
import json
BASEURL = "http://localhost:3000/v1/"

data = {
	"contact" : "+15129994336",
	"code" : "131313"
}
#r = requests.post(BASEURL + "phone/sendsms", data=data).text
r = requests.post(BASEURL + "phone/verify", data=data).text
print r 