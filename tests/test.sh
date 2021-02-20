#!/bin/bash
DATE=$(date | cut -d ' ' -f5 | sed s/://g)

# test login matheus
echo '------------'
echo " POST http://127.0.0.1:8000/api/auth/login/:"
TOKEN1=$(curl -s -XPOST -H "Content-type: application/json" -d '{
    "username": "matheus",
    "password": "123"
}' 'http://127.0.0.1:8000/api/auth/login/' | cut -d '"' -f4)
echo "JWT user 1: $TOKEN1"

# test criar usuario e fazer login
echo '------------'
echo "POST http://127.0.0.1:8000/api/user"
curl -s -XPOST -H "Content-type: application/json" -d "{
    \"username\": \"${DATE}\",
    \"password\": \"123\"
}" 'http://127.0.0.1:8000/api/user/' >> /dev/null
TOKEN2=$(curl -s -XPOST -H "Content-type: application/json" -d "{
    \"username\": \"${DATE}\",
    \"password\": \"123\"
}" 'http://127.0.0.1:8000/api/auth/login/' | cut -d '"' -f4)
echo "JWT user 2: $TOKEN2"

# test posting
echo
echo "POST http://127.0.0.1:8000/api/post/ user 1"
curl -s -XPOST -H "Content-type: application/json" -H "Authorization: JWT ${TOKEN1}" -d '{
    "content": "teste curl user matheus",
    "person": "matheus"
}' 'http://127.0.0.1:8000/api/post/' 
echo
echo "POST http://127.0.0.1:8000/api/post/ user 2"
curl -s -XPOST -H "Content-type: application/json" -H "Authorization: JWT ${TOKEN2}" -d '{
    "content": "teste curl user 2",
    "person": "matheus"
}' 'http://127.0.0.1:8000/api/post/' 
echo
echo "GET http://127.0.0.1:8000/api/post/ user 1"
curl -H "Authorization: JWT ${TOKEN1}" 'http://127.0.0.1:8000/api/post/'
echo 
echo "GET http://127.0.0.1:8000/api/post/ user 2"
curl -H "Authorization: JWT ${TOKEN2}" 'http://127.0.0.1:8000/api/post/'
echo 
