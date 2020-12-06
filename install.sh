#!/bin/bash

# This file is part of TagSH.
#
#    TagSH is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    TagSh is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with TagSH.  If not, see <http://www.gnu.org/licenses/>.

echo "cd  $(dirname $0)"
cd  $(dirname $0)

echo "sudo cp -r TagSH /usr/share/TagSH "
sudo cp -r . /usr/share/TagSH 

echo "sudo ln -sf /usr/share/TagSH/tag.sh /usr/bin/tagsh "
sudo ln -sf /usr/share/TagSH/tag.sh /usr/bin/tagsh 

echo "cleaning... remove"

cd ..
echo "rm -rf TagSH"
rm -rf TagSH
