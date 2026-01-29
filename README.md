Чтобы запустить:

./install_libs.sh </br>
docker compose up --build -d</br>
./create.sh</br>

Или, если уже были запущены выше перечисленные скрипты:

docker compose up -d</br>
./start.sh

Чтобы сохранить hdfs и выйти:

./stop.sh</br>
docker compose down

ToDo:

- Разобраться с WebUI (загрузка файлов. RPC работает)
- Разбить docker-compose на DataNode и NameNode запуски с присваением ip

Если все же требуется разбить запуск для разных устройств, то требуется разделить master и slave ноды на разные docker-compose файлы, а также отредактировать /etc/host, конфиги в hadoop и ssh комуникацию в Dockerfile.