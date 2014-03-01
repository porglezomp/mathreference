define(`SETUP', `define(\, %5C) define(^, %5E)')dnl
define(`TEARDOWN', `undefine(\) undefine(^)')dnl
define(`DPI', `140')
define(`MATH', `SETUP <img src="http://latex.codecogs.com/gif.latex?\dpi{DPI}$1"> TEARDOWN')dnl
define(`INLINE', `SETUP <img style="vertical-align:middle" src="http://latex.codecogs.com/gif.latex?\dpi{DPI}\inline $1"> TEARDOWN')dnl