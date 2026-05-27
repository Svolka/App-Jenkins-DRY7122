rm -rf tempdir
mkdir -p tempdir/templates
mkdir -p tempdir/static

cp sample_app.py tempdir/.
cp -r templates/* tempdir/templates/.
cp -r static/* tempdir/static/.

echo "FROM python:3.9" > tempdir/Dockerfile
echo "RUN pip install -q --no-cache-dir --disable-pip-version-check flask" >> tempdir/Dockerfile
echo "COPY  ./static /home/myapp/static/" >> tempdir/Dockerfile
echo "COPY  ./templates /home/myapp/templates/" >> tempdir/Dockerfile
echo "COPY  sample_app.py /home/myapp/" >> tempdir/Dockerfile
echo "EXPOSE 9999" >> tempdir/Dockerfile

cd tempdir
docker build -t sampleapp .
docker rm -f samplerunning 2>/dev/null || true
# AQUÍ ESTÁ EL TRUCO: Le decimos qué ejecutar directamente al final de la línea
docker run -t -d -p 9999:9999 --name samplerunning sampleapp python /home/myapp/sample_app.py
docker ps -a
