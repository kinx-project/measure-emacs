## Installation

The following instructions were tested on Ubuntu 17.10.

* Install Emacs 25.2.2 using `sudo apt install emacs`

* Start Emacs and run `M-x package-install xelb`.

* Restart Emacs now (otherwise, you will run into an eieio error).

* Open measure.el, evaluate all expressions but the last one.
  Copy the last expression into the *scratch* buffer and evaluate it there.

* Plug in the FRDM-K66F, then remap Caps Lock to any key (e.g. “n”): `xmodmap -e 'keycode 66 = n N'`

* Take measurements.
