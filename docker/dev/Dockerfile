FROM ruby:2.7.1

RUN mkdir /app
ENV APP_ROOT /app
ENV TZ Asia/Tokyo

WORKDIR $APP_ROOT

# 必要なパッケージのインストール
RUN apt-get update -qq && \
    apt-get install -y build-essential \
                       libpq-dev \
                       nodejs \
                       nginx \
                       tzdata \
                       vim \
                       supervisor && \
                       apt-get clean -y && \
                       rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*
# nginx
COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY nginx/dev.favorite_videos.com.conf /etc/nginx/conf.d/dev.favorite_videos.com.conf



# supervisor
COPY supervisor/app.conf /etc/supervisor/conf.d/app.conf

# Service to run
CMD [ "/usr/bin/supervisord" ]
