FROM ubuntu:18.04

# ENV JUDGE_NAME='judger'
# ENV JUDGE_KEY='abc123'
# ENV JUDGE_SITE='0.0.0.0'

RUN useradd -m -U judge && \
    apt-get dist-upgrade -y && \
    apt-get -y update && \
    apt-get install -y --no-install-recommends python python3-dev python3 gcc g++ fpc wget file nano vim git ca-certificates python3-pip build-essential libseccomp-dev python3-setuptools && \
    apt-get autoremove -y && apt-get clean

WORKDIR /judge
RUN git clone https://github.com/kunguyenqt/judge-server /judge
RUN pip3 install wheel && \
    pip3 install -r requirements.txt
RUN python3 setup.py develop && \
    mkdir /problems

ADD startup.sh /

CMD sh /startup.sh
