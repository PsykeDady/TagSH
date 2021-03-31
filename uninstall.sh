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

echo "sudo rm /usr/bin/tagga"
 
if ! sudo rm /usr/bin/tagga; then 
	 echo -e "\nSomething wrong in unistalling process. Try manually following instruction on github."
	 exit 255
fi

echo "sudo rm -rf /usr/share/Tagga"


if ! sudo rm -rf /usr/share/Tagga; then 
	 echo -e "\nSomething wrong in unistalling process. Try manually following instruction on github."
	 exit 255
fi

echo "rm -rf $HOME/.tagga"


if ! rm -rf "$HOME"/.tagga; then 
	 echo -e  "\nSomething wrong in unistalling process. Try manually following instruction on github."
	 exit 255
fi

#### rimozione bookmark, se esiste
userplace=$HOME/.local/share/user-places.xbel

if [[ -e $userplace ]] && grep -q "/.tagga" "$userplace" ; then
	nriga=$(cat -n "$userplace" | grep "\.tagga" | xargs | cut -d ' ' -f1); 
	if [[ $nriga != "" ]]; then
		## le righe del bookmark sono 9
		echo "cat $userplace | sed \"$nriga,$((nriga+7))d\" > $userplace"
		cat "$userplace" | sed "$nriga,$((nriga+7))d" | tee  "$userplace"
	fi
fi

#### rimozione bookmark gtk3, se esiste
bookmarks=$HOME/.config/gtk-3.0/bookmarks
if [[ -e $bookmarks ]]  && grep -q "/.tagga" "$bookmarks" ; then
	echo "cat $bookmarks | sed \"/Tagga/d\" > $bookmarks"
	cat "$bookmarks" | sed "/Tagga/d" | tee "$bookmarks"
fi

echo "successfully uninstalled"
