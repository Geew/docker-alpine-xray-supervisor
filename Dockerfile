FROM alpine
RUN apk add --no-cache libc6-compat curl unzip ca-certificates supervisor
RUN mkdir workspace
WORKDIR workspace
RUN curl https://s3.dualstack.us-east-2.amazonaws.com/aws-xray-assets.us-east-2/xray-daemon/aws-xray-daemon-linux-3.x.zip -o install.zip
RUN unzip ./install.zip
RUN mv xray /usr/bin/xray
WORKDIR /
RUN mkdir /etc/supervisor
RUN mkdir /etc/supervisor/conf
# RUN mkdir /root/.aws
COPY super.conf /etc/supervisor/supervisord.conf
# COPY credentials /root/.aws
RUN rm -rf workspace
RUN apk del curl unzip
# CMD ["xray", "-t", "0.0.0.0:3000", "-b", "0.0.0.0:3000", "-f", "/tmp/xray.log", "--region=ap-south-1"]

