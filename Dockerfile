FROM alpine:edge

WORKDIR /usr/local
RUN grep main /etc/apk/repositories | sed -e "s/main/testing/" >> /etc/apk/repositories\
 && apk add --no-cache alpine-sdk xz gnu-libiconv bash perl diffutils\
 && git clone https://github.com/atsttk84/apk.git\
 && cp apk/key/*.rsa.pub /etc/apk/keys\
 && echo '/usr/local/apk' >> /etc/apk/repositories\
 && apk add --no-cache mecab mecab-dev mecab-ipadic

ENV MECAB_LIBEXEC_DIR /usr/libexec/mecab
CMD git clone --depth 1 https://github.com/neologd/mecab-ipadic-neologd.git\
 && cd /usr/local/mecab-ipadic-neologd\
 && echo yes | ./bin/install-mecab-ipadic-neologd -n -a\
 && cd /usr/lib/mecab/dic\
 && tar zcvf mecab-ipadic-neologd.tar.gz mecab-ipadic-neologd;\
 cd /usr/lib/mecab/dic\
 && /bin/bash -l
