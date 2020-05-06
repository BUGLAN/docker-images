FROM golangci/golangci-lint:latest

RUN apt-get -y update && \
    apt-get install -y unzip wget && \
    mkdir /sonar-scanner  && \
    cd /sonar-scanner  && \
    wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.2.0.1873-linux.zip && \
    unzip sonar-scanner-cli-4.2.0.1873-linux.zip  && \
    mv sonar-scanner-4.2.0.1873-linux /opt/sonar-scanner

ENV PATH="/opt/sonar-scanner/bin:${PATH}"
