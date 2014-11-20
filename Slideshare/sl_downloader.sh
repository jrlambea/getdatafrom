#!/bin/bash
#
# Script by JR. Lambea 20/11/2014
# Thanks to http://es.slideshare.net/MalteLandwehr/slideshare-download
# 

TMPDIR="/tmp/ssdl"
SCALEFACTOR=1.5
TIME=0.15
DESKTOP="gnome"

mkdir -p "${TMPDIR}"


if [[ $# -ne 1 ]]; then
    echo "USAGE: $0 URL[http]"
    exit 1
fi

url="$1"

if `echo "${url}" | egrep "^http://" > /dev/null`; then
    echo "Loading ... ${url}"
else
    echo "Please, review the supplied URL."
    exit 1
fi

base_url=`wget -q -O- "${TMPFILE}" "${url}" | grep thumbnail | head -1 | grep -o '\"http.*\"'`

if [[ "${base_url}" == "" ]]; then
    echo "There's something wrong while taking the base url. Take a look at the supplied URL."
    exit 1
fi

echo "Taking the base URL: ${base_url}."
xml_url="http:`echo "${base_url}" | grep -o "/.*phpapp0[0-9]" | cut -d"/" -f1,2,3,5`.xml"
echo "XML URL: $xml_url"

wget -q -O- "${xml_url}" | tr "<" "\n" | grep -o '[http][https].*swf' | xargs wget -q --directory-prefix="${TMPDIR}/"

base_file="`ls -1 "${TMPDIR}" | grep -o "^.*-" | head -1`"
total="`ls -1 "${TMPDIR}" | wc -l`"

echo "Downloaded: $total files."
echo "Converting SWF to PNG..."

for var in `seq 1 $total`; do
    png_list="${png_list} ${TMPDIR}/${base_file}${var}.png"
    echo "[${var}/${total}] Converting ... ${base_file}${var}.swf"
    gnash -s"${SCALEFACTOR}" -t"${TIME}" --screenshot last --screenshot-file "${TMPDIR}/${base_file}${var}.png" "${TMPDIR}/${base_file}${var}.swf" 2&>1 >/dev/null
done

convert $png_list "${base_file}.pdf"
"${DESKTOP}-open" "${base_file}.pdf"

rm "${TMPDIR}/"*
