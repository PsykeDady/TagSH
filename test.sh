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

function pulizer(){
	echo 'rm -rf test.file documenti.importanti tag2 tag1 test.dir tag1'
	rm -rf test.file documenti.importanti tag2 tag1 test.dir tag1

	if [[ -e $HOME/.tag ]]; then 
		echo "rm -rf \"$HOME\"/.tag"
		rm -rf "$HOME"/.tag
	fi;
}

function testAdd(){
	echo -e "tagsh test.dir test tdir"
	tagsh test.dir test tdir || { echo "tag non aggiunto correttamente. uscita..." ; return 255; }
	echo -e "\ntagsh $(pwd)/test.file test"
	tagsh "$(pwd)"/test.file test ||  { echo "tag non aggiunto correttamente. uscita..." ; return 255; }
	echo -e "\ntagsh documenti.importanti documenti"
	tagsh documenti.importanti documenti ||  { echo "tag non aggiunto correttamente. uscita..." ; return 255; }
	echo -e "\ntagsh tag1 tag t12"
	tagsh tag1 tag t12 ||  { echo "tag non aggiunto correttamente. uscita..." ; return 255; }
	echo -e "\ntagsh tag2 tag"
	tagsh tag2 tag ||  { echo "tag non aggiunto correttamente. uscita..." ; return 255; }

	tagDir=$HOME/.tag

	echo -en "\ncontrollo esistenza cartella .tag ... "
	[[ ! -e $tagDir ]] && echo "la directory .tag non è stata creata! uscita..." && return 255
	echo -e "controllo passato \u2713\n"

	echo -e "controllo esistenza delle varie directory:"
	echo -n "tag/tdir ... "
	[[ ! -e $tagDir/test/tdir ]] && echo "associazione assente! uscita..." && return 255
	echo -e "controllo passato \u2713\n"
	echo -n "test/test.file ... "
	[[ ! -e $tagDir/test/test.file ]] && echo "associazione assente! uscita..." && return 255
	echo -e "controllo passato \u2713\n"
	echo -n "documenti/documenti.importanti ... "
	[[ ! -e $tagDir/documenti/documenti.importanti ]] && echo "associazione assente! uscita..." && return 255
	echo -e "controllo passato \u2713\n"
	echo -n "tag/t12 ... "
	[[ ! -e $tagDir/tag/t12 ]] && echo "associazione assente! uscita..." && return 255
	echo -e "controllo passato \u2713\n"
	echo -n "tag/tag1 ... "
	[[ ! -e $tagDir/tag/tag2 ]] && echo "associazione assente! uscita..." && return 255
	echo -e "controllo passato \u2713\n"
}

## avvia i test su tag.sh

echo "Il test effettuerà le seguenti operazioni:"
echo -e "\t- installazione software"
echo -e "\t\t- comporta eliminazione della cartella di download del repo"
echo -e "\t- aggiunta di alcuni tag"
echo -e "\t- controllo dei file bookmark"
echo -e "\t- lista dei tag (contiene il tag)"
echo -e "\t- lista di file tagged col precedente tag"
echo -e "\t- rimozione di un associazione"
echo -e "\t- rimozione dell'intero tag"
echo -e "\t- disinstallazione di TagSH"
echo -e "\t- controllo dei bookmark (con file di backup)"
echo "SE QUALUNQUE COSA DOVESSE ANDAR MALE, NON INSTALLATE IL SOFTWARE E CONTATTATE LO SVILUPPATORE"
echo "Sviluppo a cura di PsykeDady, per aggiornamenti, issue e pull request andare su https://www.github.com/PsykeDady/TagSH"
echo -e "\n\n";

echo "File dei test in via di sviluppo. Procedere con i test? [y/N]"
read -r confirm

if [[ $confirm != "y" ]] && [[ $confirm != "Y" ]]; then 
	echo "uscita..."
	exit 0
fi

nomedir=$(dirname "$0")


case $nomedir in
	/* )  
		echo "lo script è stato chiamato con percorso assoluto, nessuna modifica";;
	 * ) 
	 	echo "lo script è stato chiamato con percorso relativo $nomedir. inclusione percorso assoluto:"
	 	nomedir=$PWD/$nomedir 
		echo "nuovo percorso :> $nomedir"
	;;
esac
echo -e "\n"


if [[ "$nomedir" == "$(pwd)"/. ]]; then 
	echo -e "sei in una cartella che verrà eliminata, spostato alla cartella padre\n"
	cd ..
fi

echo "invoco procedura di installazione..."

echo "\"$nomedir\"/install.sh"
# "$nomedir"/install.sh
echo -e "\n\n"


if ! which tagsh; then 
	echo "tagsh non è stato correttamente installato."
	exit 255;
fi

echo "aggiunta della seguente struttura di tag:"
echo -e "_______________________	"
echo -e "|.tag						"
echo -e "|- test					"
echo -e "|-|- test.dir -> t.dir		"
echo -e "|-|- test.file				"
echo -e "|							"
echo -e "|- documenti				"
echo -e "|-|- documenti.importanti	"
echo -e "|							"
echo -e "|-tag						"
echo -e "|-|-tag1 -> t12			"
echo -e "|-|-|-tag12				"
echo -e "|-|-tag2					"
echo -e "|______________________	"


echo 'mkdir -p test.dir tag1'
mkdir -p test.dir tag1
echo -e 'touch test.file documenti.importanti tag2 tag1/tag12\n'
touch test.file documenti.importanti tag2 tag1/tag12 

testAdd

testBook

#testList

#testRemove

#testUninstall

echo -e "\npremere invio per terminare i test (e pulire la cartella)"
read -r;

pulizer