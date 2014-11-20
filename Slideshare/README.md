WHAT?
--
A Slideshare to PDF converter.

HOW?
--
It queries the open Slideshare data, retrieves some SWF files, convert the SWF to PNG and mix all in a PDF. It is never necessary logon or have any Slideshare user for public slides.

HOW!?
--
...damn, ok, it uses wget to web queries, gnash to take a snapshot of the slide in PNG format, and imagemagick to mix up all in a solid PDF.

Take my money
--
No, it's free :D

Screenshots
--
From: http://es.slideshare.net/mikatama/test-slide-share-1?next_slideshow=1

![01](https://cloud.githubusercontent.com/assets/6108794/5125243/ef8466d0-70c1-11e4-87b9-67878200d2f8.png)
![02](https://cloud.githubusercontent.com/assets/6108794/5125269/581dd956-70c2-11e4-91cd-63ce5fed688c.png)

Configuration
--
All the config possibinilies are the variables at first lines of the script, there are:

- TMPDIR for temp directory, it's wipe at the end of the script.
- SCALEFACTOR as scale for the slides, when bigger, the static images quality is poor.
- TIME time to make the snapshot, if are many elements in the slide, maybe this increase.
- DESKTOP as the desktop you are using, gnome or kde are valid entries, this is for open automatically the PDF at the end of the script.

