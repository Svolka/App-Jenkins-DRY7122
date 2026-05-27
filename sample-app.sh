rm -rf tempdir
mkdir -p tempdir/templates
mkdir -p tempdir/static

cp sample_app.py tempdir/.
cp -r templates/* tempdir/templates/.
cp -r static/* tempdir/static/.

cat << 'DOCKERFILE' > tempdir/Dockerfile
FROM python:3.9
RUN pip install -q --no-cache-dir --disable-pip-version-check flask
COPY  ./static /home/myapp/static/
COPY  ./templates /home/myapp/templates/
COPY  sample_app.py /home/myapp/
EXPOSE 9999
CMD ["python", "/home/myapp/sample_app.py"]
DOCKERFILE

cd tempdir
docker build --no-cache -t sampleapp .
docker rm -f samplerunning 2>/dev/null || true
docker run -t -d -p 9999:9999 --name samplerunning sampleapp
docker ps -a
