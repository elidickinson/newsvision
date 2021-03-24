#!/bin/sh
# paperme.sh http://.... filename (.png will be added)
# IL_CT - chicago trib
# DC_WP - Wapo
# cd "${0%/*}"
PAPER_ID=${1:-`shuf -n 1 paperindex.tsv | awk '{print $1}'`}
echo "$PAPER_ID"
wget "https://cdn.freedomforum.org/dfp/pdf`date "+%-d"`/$PAPER_ID.pdf" -q -O $(pwd)/$PAPER_ID.pdf
echo "Render pdf to image"
# echo docker run -it --rm -v $(pwd):/var/workdir/ kolyadin/pdf2img -png -singlefile -cropbox $1.pdf $1
# docker run -it --rm -v $(pwd):/var/workdir/ kolyadin/pdf2img -png -singlefile -cropbox $1.pdf $1
pdftoppm -png -singlefile -cropbox $PAPER_ID.pdf $PAPER_ID
echo "Resize and annotate image"
mogrify -gravity north -depth 8 -resize 1440x2560 -background white -extent 1440x2560 \
    -undercolor '#00000020' -fill black -gravity South -pointsize 18 -annotate +0+5 "  $PAPER_ID -- `date`  " -depth 8 $PAPER_ID.png
echo "Push to device"
python push_img.py $PAPER_ID.png
