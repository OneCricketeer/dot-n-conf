# Requires ImageMagick
def jpg2pdf() {
    if [[ $# -ne 1 ]]; then
	    echo "Merges all jpg files into a PDF"
        echo "Usage: jpg2pdf <output PDF name>"
        return 1
    fi
    convert *.jpg $1.pdf
    rm -f *.jpg
}
