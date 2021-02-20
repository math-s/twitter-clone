DATE=$(date | cut -d ' ' -f5 | sed s/://g)
echo
echo '------------'
echo 'Cadastro de usuário'
echo "POST http://127.0.0.1:8000/api/user"
curl -s -XPOST -H "Content-type: application/json" -d "{
    \"username\": \"${DATE}\",
    \"password\": \"123\"
}" 'http://127.0.0.1:8000/api/user/'
echo
echo '------------'
echo 'Autenticação (Login)'
echo "POST http://127.0.0.1:8000/api/auth/login/"
TOKEN=$(curl -s -XPOST -H "Content-type: application/json" -d "{
    \"username\": \"${DATE}\",
    \"password\": \"123\"
}" 'http://127.0.0.1:8000/api/auth/login/' | cut -d '"' -f4)
echo "JWT token: $TOKEN"
echo
echo '------------'
echo 'Fazer um Post'
echo 'Usuário autenticado.'
echo "POST http://127.0.0.1:8000/api/post/"
curl -s -XPOST -H "Content-type: application/json" -H "Authorization: JWT ${TOKEN}" -d '{
    "content": "teste curl user 2",
    "person": "matheus"
}' 'http://127.0.0.1:8000/api/post/' 
echo 'Usuário não autenticado.'
curl -s -XPOST -H "Content-type: application/json" -d '{
    "content": "teste",
    "person": "matheus"
}' 'http://127.0.0.1:8000/api/post/' 
echo