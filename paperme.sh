#!/bin/sh
# paperme.sh DC_WP 
# will load Washington Post

# cd "${0%/*}"
# If a paper_id was passed in (e.g. "DC_WP") then use that, otherwise grab one at random from paperindex.tsv
PAPER_ID=${1:-`shuf -n 1 paperindex.tsv | awk '{print $1}'`}
# Look up the other info for this paper_id (full name, location)
PAPER_INFO=`grep "^$PAPER_ID\t" paperindex.tsv`
echo "$PAPER_INFO"
# download the PDF for this paper for today's date, based on timezone as specified in env.list
# this could fail if file doesn't exist yet
wget "https://cdn.freedomforum.org/dfp/pdf`date "+%-d"`/$PAPER_ID.pdf" -q -O $(pwd)/$PAPER_ID.pdf
echo "Render pdf to image"
# convery to .png
pdftoppm -png -singlefile -cropbox $PAPER_ID.pdf $PAPER_ID
echo "Resize and annotate image"
# resize to a little narrower than the actual resolution of 1440x2560 and pad with a white background
# then also add a footer with the paper info to the bottom
# and finally don't forget to specify 8-bit color depth since it doesn't like 24-bit images
mogrify \
    -gravity Center -resize 1430x2560 -background white -extent 1440x2560 \
    -font Times-New-Roman -undercolor '#F0F0F090' -fill black -gravity South -pointsize 16 -annotate +0+5 " $PAPER_INFO  Loaded `date "+%Y-%m-%d %r"` " \
    -depth 8 $PAPER_ID.png
echo "Push to device"
python push_img.py $PAPER_ID.png
