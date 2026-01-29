ToDo:

- Разобраться с WebUI (загрузка файлов. RPC работает)
- Разбить docker-compose на DataNode и NameNode запуски с присваением ip

Чтобы запустить:

./install_libs.sh
docker compose up --build -d
./create.sh

Или, если уже были запущены вышеперечисленные скрипты:

docker compose up -d
./start.sh

Чтобы сохранить hdfs и выйти:

./stop.sh
docker compose down
