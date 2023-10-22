#FROM alpine:3.13
FROM python:3.8-alpine
RUN apk add --no-cache poppler-utils imagemagick wget file tzdata

# Borrowed from https://github.com/kolyadin/pdf2img/blob/master/Dockerfile
# Add standard microsoft webfonts: https://packages.debian.org/sid/ttf-mscorefonts-installer
# Fixes pdf conversion issues where no substitute fonts can be found. For example: "Syntax Error: Couldn't find a font for 'Helvetica'".
RUN apk add --no-cache msttcorefonts-installer && update-ms-fonts 2>&1 && fc-cache -f

RUN pip install https://github.com/SeraphimSerapis/libpyvss/archive/master.zip

COPY *.py .
COPY *.sh .
COPY *.tsv .
CMD ["/paperme.sh"]