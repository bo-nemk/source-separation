sudo rm -rf __build
echo "building..."
docker build . -t ssweb
echo "running..."
docker run -it -v $(pwd):/workspace/ ssweb "./make.sh"
