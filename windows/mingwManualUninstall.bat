@echo off

rem Location of pacman executable (adjust this to your MSYS2 installation)
set pacman_exe=C:\msys64\usr\bin\pacman.exe

rem Check if the lock file exists and remove it if it does
if exist C:\msys64\var\lib\pacman\db.lck (
    echo Removing pacman database lock...
    del C:\msys64\var\lib\pacman\db.lck
)

rem List of packages to remove
set packages=mingw-w64-ucrt-x86_64-crt-git mingw-w64-ucrt-x86_64-expat mingw-w64-ucrt-x86_64-gcc mingw-w64-ucrt-x86_64-gcc-ada mingw-w64-ucrt-x86_64-gcc-fortran mingw-w64-ucrt-x86_64-gcc-libgfortran mingw-w64-ucrt-x86_64-gcc-libs mingw-w64-ucrt-x86_64-gcc-objc mingw-w64-ucrt-x86_64-gdb mingw-w64-ucrt-x86_64-gdb-multiarch mingw-w64-ucrt-x86_64-gettext mingw-w64-ucrt-x86_64-gmp mingw-w64-ucrt-x86_64-headers-git mingw-w64-ucrt-x86_64-isl mingw-w64-ucrt-x86_64-libffi mingw-w64-ucrt-x86_64-libgccjit mingw-w64-ucrt-x86_64-libiconv mingw-w64-ucrt-x86_64-libmangle-git mingw-w64-ucrt-x86_64-libsystre mingw-w64-ucrt-x86_64-libtre-git mingw-w64-ucrt-x86_64-libwinpthread-git mingw-w64-ucrt-x86_64-make mingw-w64-ucrt-x86_64-mpc mingw-w64-ucrt-x86_64-mpdecimal mingw-w64-ucrt-x86_64-mpfr mingw-w64-ucrt-x86_64-ncurses mingw-w64-ucrt-x86_64-openssl mingw-w64-ucrt-x86_64-pkgconf mingw-w64-ucrt-x86_64-python mingw-w64-ucrt-x86_64-readline mingw-w64-ucrt-x86_64-sqlite3 mingw-w64-ucrt-x86_64-tcl mingw-w64-ucrt-x86_64-termcap mingw-w64-ucrt-x86_64-tk mingw-w64-ucrt-x86_64-tools-git mingw-w64-ucrt-x86_64-tzdata mingw-w64-ucrt-x86_64-windows-default-manifest mingw-w64-ucrt-x86_64-winpthreads-git mingw-w64-ucrt-x86_64-winstorecompat-git mingw-w64-ucrt-x86_64-xxhash mingw-w64-ucrt-x86_64-xz mingw-w64-ucrt-x86_64-zlib mingw-w64-ucrt-x86_64-zstd

rem Uninstall packages without checking dependencies
for %%i in (%packages%) do (
    "%pacman_exe%" -R "%%i" --noconfirm --nodeps
)

pause

rem Use this command in the msys2 terminal to check for the existing mingw packages: pacman -Q | grep mingw-w64
