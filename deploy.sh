git add . &&
git commit -m "$1" &&
git push origin master &&
ssh root@40.71.195.246 <<EOF
cd projeto_haskell &&
git pull origin master &&
stack build &&
lsof -i:443 -Fp | sed 's/^p//' | head -n -1 | xargs kill -9;
nohup sudo stack --allow-different-user exec aulahaskell > /dev/null 
echo "deploy finished"
EOF