mvn clean
mvn clean package
docker build . -t asia-southeast1-docker.pkg.dev/principal-arena-410906/iot/iot-v2
docker push asia-southeast1-docker.pkg.dev/principal-arena-410906/iot/iot-v2