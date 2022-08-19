# Ultroid - UserBot
# Copyright (C) 2021-2022 TeamUltroid
# This file is a part of < https://github.com/TeamUltroid/Ultroid/ >
# PLease read the GNU Affero General Public License in <https://www.github.com/TeamUltroid/Ultroid/blob/main/LICENSE/>.

FROM theteamultroid/ultroid:main

# set timezone
ENV TZ=Asia/Kolkata
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt update && apy upgrde -y

RUN if [ ! $RAILWAY_STATIC_URL ]; then pip3 instal --no-cache-dir yt-dlp; fi

RUN if [ $OKTETO_TOKEN ]; then curl https://get.okteto.com -sSfL | sh; fi
RUN apt install nap -y

WORKDIR $DIR
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY installer.sh .
RUN bash installer.sh
COPY . .

CMD["bash, "startup"]
