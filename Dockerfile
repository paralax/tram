FROM python:3.7

COPY . /app
WORKDIR /app

RUN cd /app/models &&\
    curl -LO https://raw.githubusercontent.com/mitre/cti/master/enterprise-attack/enterprise-attack.json &&\
    cd /app &&\
    mv /app/conf/config.yml /app/conf/config.yml.orig &&\
    sed  's/taxii-server/local-json/g' /app/conf/config.yml.orig > /app/conf/config.yml

RUN pip install -r requirements.txt &&\
    python -c "import nltk; nltk.download('punkt')"

CMD ["python", "tram.py"]
