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

echo "sudo rm /usr/bin/tagsh"
 
if ! sudo rm /usr/bin/tagsh; then 
	 echo -e "\nSomething wrong in unistalling process. Try manually following instruction on github."
	 exit 255
fi

echo "sudo rm -rf /usr/share/TagSH"


if ! sudo rm -rf /usr/share/TagSH; then 
	 echo -e "\nSomething wrong in unistalling process. Try manually following instruction on github."
	 exit 255
fi

echo "rm -rf $HOME/.tag"


if ! rm -rf "$HOME"/.tag; then 
	 echo -e  "\nSomething wrong in unistalling process. Try manually following instruction on github."
	 exit 255
fi

#### rimozione bookmark, se esiste
userplace=$HOME/.local/share/user-places.xbel

if [[ -e $userplace ]] && grep -q "/.tag" "$userplace" ; then
	nriga=$(cat -n "$userplace" | grep "\.tag" | xargs | cut -d ' ' -f1); 
	if [[ $nriga != "" ]]; then
		## le righe del bookmark sono 9
		echo "cat $userplace | sed \"$nriga,$((nriga+7))d\" > $userplace"
		cat "$userplace" | sed "$nriga,$((nriga+7))d" | tee  "$userplace"
	fi
fi

#### rimozione bookmark gtk3, se esiste
bookmarks=$HOME/.config/gtk-3.0/bookmarks
if [[ -e $bookmarks ]]  && grep -q "/.tag" "$bookmarks" ; then
	echo "cat $bookmarks | sed \"/TagSH/d\" > $bookmarks"
	cat "$bookmarks" | sed "/TagSH/d" | tee "$bookmarks"
fi

echo "successfully uninstalled"
