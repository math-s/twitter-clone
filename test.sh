#!/bin/bash

TOKEN=$(curl -s -XPOST -H "Content-type: application/json" -d '{
    "username": "matheus",
    "password": "123"
}' 'http://127.0.0.1:8000/api/auth/login/' | cut -d '"' -f4)

echo $TOKEN

curl -H "Authorization: JWT ${TOKEN}" 'http://127.0.0.1:8000/api/post/'


