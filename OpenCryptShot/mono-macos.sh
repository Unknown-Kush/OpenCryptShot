PREFIX=/usr/local

# Ensure you have write permissions to /usr/local
mkdir $PREFIX
sudo chown -R `whoami` $PREFIX

PATH=$PREFIX/bin:$PATH

# Download and build dependencies
mkdir ~/Build
cd ~/Build
curl -O https://ftp.gnu.org/gnu/m4/m4-1.4.17.tar.gz
curl -O https://ftp.gnu.org/gnu/autoconf/autoconf-2.69.tar.gz
curl -O https://ftp.gnu.org/gnu/automake/automake-1.14.tar.gz
curl -O https://ftp.gnu.org/gnu/libtool/libtool-2.4.2.tar.gz

for i in *.tar.gz; do tar xzvf $i; done
for i in */configure; do (cd `dirname $i`; ./configure --prefix=$PREFIX && make && make install); done

git clone https://github.com/mono/mono.git
cd mono
./autogen.sh --prefix=$PREFIX --disable-nls
make
make install
