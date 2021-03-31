#!/bin/bash

# This file is part of Tagga.
#
#    Tagga is free software: you can redistribute it and/or modify
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
#    along with Tagga.  If not, see <http://www.gnu.org/licenses/>.



(
	echo "cd  $(dirname "$0")"
	cd "$(dirname "$0")" || exit

	echo "sudo cp -r Tagga /usr/share/Tagga "
	sudo cp -r . /usr/share/Tagga 

	echo "sudo ln -sf /usr/share/Tagga/tagga.sh /usr/bin/tagga "
	sudo ln -sf /usr/share/Tagga/tagga.sh /usr/bin/tagga 

	echo "cleaning... remove"
)

echo "rm -rf $(dirname "$0")"
rm -rf "$(dirname "$0")"
