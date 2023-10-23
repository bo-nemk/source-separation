sudo rm -rf __build
echo "building..."
docker build . -t ssweb --no-cache
echo "running..."
docker run -it -v $(pwd):/workspace/ ssweb "./make.sh"
