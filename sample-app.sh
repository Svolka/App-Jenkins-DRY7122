rm -rf tempdir
mkdir -p tempdir/templates
mkdir -p tempdir/static

cp sample_app.py tempdir/.
cp -r templates/* tempdir/templates/.
cp -r static/* tempdir/static/.

echo "FROM python:3.9" > tempdir/Dockerfile
# AQUÍ ESTÁ LA MAGIA: Instalación silenciosa y sin barra de progreso
echo "RUN pip install -q --no-cache-dir --disable-pip-version-check flask" >> tempdir/Dockerfile
echo "COPY  ./static /home/myapp/static/" >> tempdir/Dockerfile
echo "COPY  ./templates /home/myapp/templates/" >> tempdir/Dockerfile
echo "COPY  sample_app.py /home/myapp/" >> tempdir/Dockerfile
echo "EXPOSE 9999" >> tempdir/Dockerfile
echo "CMD python /home/myapp/sample_app.py" >> tempdir/Dockerfile

cd tempdir
docker build -t sampleapp .
docker rm -f samplerunning 2>/dev/null || true
docker run -t -d -p 9999:9999 --name samplerunning sampleapp
docker ps -a
