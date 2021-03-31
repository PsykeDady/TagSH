#!/bin/bash

# This file is part of Tagga.
#
#    Tagga is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    Tagga is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with Tagga.  If not, see <http://www.gnu.org/licenses/>.

function pulizer(){
	echo 'rm -rf test.file documenti.importanti tag2 tag1 test.dir '
	rm -rf test.file documenti.importanti tag2 tag1 test.dir 

	if [[ -e $HOME/.tag ]]; then 
		echo "rm -rf \"$HOME\"/.tag"
		rm -rf "$HOME"/.tag
	fi;

	if [[ -e Tagga.test ]]; then 
		echo "rm -rf \"Tagga.test\"/.tag"
		rm -rf Tagga.test
	fi;
}

function testAdd(){
	#errori
	echo -e "tagga test.dir test t.dir"
	tagga test.dir test 't.dir' > /dev/null && { echo "Questo tag non doveva essere aggiunto, invece lo è stato" ; return 255; }
	echo -e "Tag in errore (controllo passato) \u2713\n"

	echo -e "tagga test.dir te!st tdir"
	tagga test.dir te\!st tdir > /dev/null && { echo "Questo tag non doveva essere aggiunto, invece lo è stato" ; return 255; }
	echo -e "Tag in errore (controllo passato) \u2713\n"

	echo -e "tagga test.dir/ciao test tdir"
	tagga test.dir/ciao test tdir > /dev/null && { echo "Questo tag non doveva essere aggiunto, invece lo è stato" ; return 255; }
	echo -e "Tag in errore (controllo passato) \u2713\n"

	#add  con nome 
	echo -e "tagga test.dir test tdir"
	tagga test.dir test tdir || { echo "tag non aggiunto correttamente. uscita..." ; return 255; }

	echo -e "\ntagga tag1 tag t12"
	tagga tag1 tag t12 ||  { echo "tag non aggiunto correttamente. uscita..." ; return 255; }

	# add senza nome
	echo -e "\ntagga $(pwd)/test.file test"
	tagga "$(pwd)"/test.file test ||  { echo "tag non aggiunto correttamente. uscita..." ; return 255; }

	echo -e "\ntagga documenti.importanti documenti"
	tagga documenti.importanti documenti ||  { echo "tag non aggiunto correttamente. uscita..." ; return 255; }

	echo -e "\ntagga tag2 tag"
	tagga tag2 tag ||  { echo "tag non aggiunto correttamente. uscita..." ; return 255; }

	echo -e "\ntagga tag1/tag3 tag"
	tagga tag1/tag3 tag ||  { echo "tag non aggiunto correttamente. uscita..." ; return 255; }

	tagDir=$HOME/.tag

	echo -en "\ncontrollo esistenza cartella .tag ... "
	[[ ! -e $tagDir ]] && echo "la directory .tag non è stata creata! uscita..." && return 255
	echo -e "controllo passato \u2713\n"

	echo -e "controllo esistenza delle varie directory:"
	echo -n "tag/tdir ... "
	[[ ! -e $tagDir/test/tdir ]] && echo "associazione assente! uscita..." && return 255
	echo -e "controllo passato \u2713\n"
	echo -n "tag/t12 ... "
	[[ ! -e $tagDir/tag/t12 ]] && echo "associazione assente! uscita..." && return 255
	echo -e "controllo passato \u2713\n"
	echo -n "test/test.file ... "
	[[ ! -e $tagDir/test/test.file ]] && echo "associazione assente! uscita..." && return 255
	echo -e "controllo passato \u2713\n"
	echo -n "documenti/documenti.importanti ... "
	[[ ! -e $tagDir/documenti/documenti.importanti ]] && echo "associazione assente! uscita..." && return 255
	echo -e "controllo passato \u2713\n"
	echo -n "tag/tag1 ... "
	[[ ! -e $tagDir/tag/tag2 ]] && echo "associazione assente! uscita..." && return 255
	echo -e "controllo passato \u2713\n"
	
	return 0
}

function testBook () {
	Book="$HOME"/.local/share/user-places.xbel
	BookGtk="$HOME"/.config/gtk-3.0/bookmarks

	if [[ -e $Book ]]; then 
		echo -n "controllo bookmark user-places ... " 
		snippet="<bookmark href=\"file://$HOME/.tag\">"

		if ! grep -q "$snippet" "$Book"; then 
			echo "il bookmark globale esiste, ma non c'è riferimento a tag"
			return 255
		fi
	fi
	echo -e "controllo passato \u2713\n"

	if [[ -e $BookGtk ]]; then 
		echo -n "controllo bookmark gtk ... "
		snippet="file://$HOME/.tag Tagga"

		if ! grep -q "$snippet" "$BookGtk"; then 
			echo "il bookmark gtk esiste, ma non c'è riferimento a tag"
			return 255
		fi
	fi

	echo -e "controllo passato \u2713\n"

	return 0
}

function testList(){
	# solo opzione
	echo -n "controllo tagga -l ..."
	tutti=$(tagga -l | tail -1)

	echo -n " documenti ..."
	doct=$(echo "$tutti" | cut -d" " -f1);
	[[ $doct == '"documenti"' ]] || { echo "un tag previsto (documenti) non è stato trovato"; return 255; } 

	echo -n " tag ..."
	tagt=$(echo "$tutti" | cut -d" " -f2);
	[[ $tagt == '"tag"' ]] || { echo "un tag previsto (tag) non è stato trovato"; return 255; }

	echo -n " test ..."
	testt=$(echo "$tutti" | cut -d" " -f3);
	[[ $testt == '"test"' ]] || { echo "un tag previsto (test) non è stato trovato"; return 255; }

	echo -e "controllo passato \u2713\n"

	#errori
	echo -n "controllo tagga -l .. ... "
	tagga -l .. > /dev/null && { echo "Questo comando doveva andare in errore, invece è stato eseguito correttemente" ; return 255; }
	echo -e "list in errore (controllo passato) \u2713\n"

	echo -n "controllo tagga -l c!iao! ... "
	tagga -l 'c!iao!' > /dev/null && { echo "Questo comando doveva andare in errore, invece è stato eseguito correttemente" ; return 255; }
	echo -e "list in errore (controllo passato) \u2713\n"

	# opzione + parametro
	echo -n "controllo tagga -l test ... "
	content=$(tagga -l "test" | tail -1)
	el=$(echo "$content" | cut -d" " -f1);
	echo -n "tdir ... "
	[[ $el == '"tdir"' ]] || { echo "l'elemento tdir sotto il tag test non è stato trovato"; return 255; }
	echo -n "test.file ... "
	el=$(echo "$content" | cut -d" " -f2);
	[[ $el == '"test.file"' ]] || { echo "l'elemento test.file sotto il tag test non è stato trovato"; return 255; }

	echo -e "controllo passato \u2713\n"

	echo -n "controllo tagga -l documenti ... "
	content=$(tagga -l "documenti" | tail -1)
	el=$(echo "$content" | cut -d" " -f1);
	echo -n "documenti.importanti ... "
	[[ $el == '"documenti.importanti"' ]] || { echo "l'elemento documenti.importanti sotto il tag documenti non è stato trovato"; return 255; }
	echo -e "controllo passato \u2713\n"

	echo -n "controllo tagga -l tag ... "
	content=$(tagga -l "tag" | tail -1)
	echo -n "t12 ... "
	el=$(echo "$content" | cut -d" " -f1);
	[[ $el == '"t12"' ]] || { echo "l'elemento t12 sotto il tag tag non è stato trovato"; return 255; }
	echo -n "tag2 ... "
	el=$(echo "$content" | cut -d" " -f2);
	[[ $el == '"tag2"' ]] || { echo "l'elemento tag2 sotto il tag tag non è stato trovato"; return 255; }
	echo -e "controllo passato \u2713\n"
	echo -n "tag3 ... "
	el=$(echo "$content" | cut -d" " -f3);
	[[ $el == '"tag3"' ]] || { echo "l'elemento tag3 sotto il tag tag non è stato trovato"; return 255; }
	echo -e "controllo passato \u2713\n"
}

function testRemove() {
	tagDir=$HOME/.tag

	#controllo errori
	echo -n "controllo tagga -r .. ... "
	tagga -r .. > /dev/null && { echo "Questo comando doveva andare in errore, invece è stato eseguito correttemente" ; return 255; }
	echo -e "remove in errore (controllo passato) \u2713\n"

	echo -n "controllo tagga -r  test ../documenti  ... "
	tagga -r test ../documenti > /dev/null && { echo "Questo comando doveva andare in errore, invece è stato eseguito correttemente" ; return 255; }
	echo -e "remove in errore (controllo passato) \u2713\n"
	echo -e "controllo passato \u2713\n"

	echo -n "controllo tagga -r testa  ... "
	tagga -r testa > /dev/null && { echo "Questo comando doveva andare in errore, invece è stato eseguito correttemente" ; return 255; }
	echo -e "remove in errore (controllo passato) \u2713\n"
	echo -e "controllo passato \u2713\n"

	echo -n "controllo tagga -r test documenti  ... "
	tagga -r test documenti > /dev/null && { echo "Questo comando doveva andare in errore, invece è stato eseguito correttemente" ; return 255; }
	echo -e "remove in errore (controllo passato) \u2713\n"
	echo -e "controllo passato \u2713\n"

	echo -n "controllo tagga -r test $(pwd)/documenti  ... "
	tagga -r test "$(pwd)"/documenti > /dev/null && { echo "Questo comando doveva andare in errore, invece è stato eseguito correttemente" ; return 255; }
	echo -e "remove in errore (controllo passato) \u2713\n"
	echo -e "controllo passato \u2713\n"

	# comandi di rimozione
	## tag intero
	echo -e "\ncontrollo tagga -r test ... "	
	tagga -r test || { echo "il comando di rimozione non è riuscito"; return 255; }

	[[ -e $tagDir/test ]] && { echo "qualcosa è andato storto, il tag test doveva essere eliminato ma così non è"; return 255; }

	echo -e "controllo passato \u2713\n"

	## associazione sotto tag
	echo "controllo tagga -r tag t12 ..."	
	tagga -r tag t12 || { echo "il comando di rimozione non è riuscito"; return 255; }

	[[ -e $tagDir/tag/t12 ]] && { echo "qualcosa è andato storto, il'associazione di t12 al tag tag doveva essere eliminata ma così non è"; return 255; }

	echo -e "controllo passato \u2713\n"
}

function testRename () {
	tagDir=$HOME/.tag
	
	#controllo errori
	echo -n "controllo tagga -n tag  ... "
	tagga -n tag > /dev/null && { echo "Questo comando doveva andare in errore, invece è stato eseguito correttemente" ; return 255; }
	echo -e "rename in errore (controllo passato) \u2713\n"
	
	echo -n "controllo tagga -n .. tag2 ... "
	tagga -n .. tag > /dev/null && { echo "Questo comando doveva andare in errore, invece è stato eseguito correttemente" ; return 255; }
	echo -e "rename in errore (controllo passato) \u2713\n"
	
	echo -n "controllo tagga -n tag ~/ciao ... "
	tagga -n tag ~/ciao > /dev/null && { echo "Questo comando doveva andare in errore, invece è stato eseguito correttemente" ; return 255; }
	echo -e "rename in errore (controllo passato) \u2713\n"

	echo -n "controllo tagga -n tag .. ... "
	tagga -n tag .. > /dev/null && { echo "Questo comando doveva andare in errore, invece è stato eseguito correttemente" ; return 255; }
	echo -e "rename in errore (controllo passato) \u2713\n"

	echo -n "controllo tagga -n ta!g tag2 ... "
	tagga -n ta\!g tag2 > /dev/null && { echo "Questo comando doveva andare in errore, invece è stato eseguito correttemente" ; return 255; }
	echo -e "rename in errore (controllo passato) \u2713\n"

	echo -n "controllo tagga -n tag documenti ... "
	tagga -n tag documenti > /dev/null && { echo "Questo comando doveva andare in errore, invece è stato eseguito correttemente" ; return 255; }
	echo -e "rename in errore (controllo passato) \u2713\n"

	echo -n "controllo tagga -n tag tag2 .. ... "
	tagga -n tag tag2 ..  > /dev/null && { echo "Questo comando doveva andare in errore, invece è stato eseguito correttemente" ; return 255; }
	echo -e "rename in errore (controllo passato) \u2713\n"
 
	echo -n "controllo tagga -n tag tag2 c\!ciao ... "
	tagga -n tag tag2 c\!ciao > /dev/null && { echo "Questo comando doveva andare in errore, invece è stato eseguito correttemente" ; return 255; }
	echo -e "rename in errore (controllo passato) \u2713\n"


	echo -n "controllo tagga -n tag tag2 tag3 ... "
	tagga -n tag tag2 tag3 > /dev/null && { echo "Questo comando doveva andare in errore, invece è stato eseguito correttemente" ; return 255; }
	echo -e "rename in errore (controllo passato) \u2713\n"

	echo -n "controllo tagga -n tag tag2 tag3 ... "
	tagga -n tag tag2 tag3 > /dev/null && { echo "Questo comando doveva andare in errore, invece è stato eseguito correttemente" ; return 255; }
	echo -e "rename in errore (controllo passato) \u2713\n"

	echo -n "controllo tagga -n tag tag2 ~/tag3 ... "
	tagga -n tag tag2 ~/tag3 > /dev/null && { echo "Questo comando doveva andare in errore, invece è stato eseguito correttemente" ; return 255; }
	echo -e "rename in errore (controllo passato) \u2713\n"



	# controllo rename corretti
	echo -e "\ncontrollo tagga -n tag tag2 ... "	
	tagga -n tag tag2 || { echo "il comando di rename non è riuscito"; return 255; }
	[[ -e $tagDir/tag2 && ! -e $tagDir/tag ]] || { echo "qualcosa è andato storto, il tag test doveva essere eliminato ma così non è"; return 255; }
	echo -e "controllo passato \u2713\n"

	echo -e "\ncontrollo tagga -n tag2 tag2 t12 ... "	
	tagga -n tag2 tag2 t12 || { echo "il comando di rename non è riuscito"; return 255; }
	[[ -e $tagDir/tag2/t12 && ! -e $tagDir/tag2/tag2 ]] || { echo "qualcosa è andato storto, il tag test doveva essere eliminato ma così non è"; return 255; }
	echo -e "controllo passato \u2713\n"

}

function testUninstall () {

	stato=0

	echo -n "test /usr/share/Tagga/uninstall.sh ... "
	/usr/share/Tagga/uninstall.sh > /dev/null || echo "script di disinstallazione non riuscito...";
	echo -e "controllo passato \u2713\n"

	echo -n "controllo cartella .tag ... " 

	[[ -e $HOME/.tag ]] && { echo "la cartella tag esiste ancora, qualcosa è andato male"; return 255; }

	echo -e "controllo passato \u2713\n"
	
	echo -n "controllo del bookmark user-places... "

	USERPLACES="$HOME"/.local/share/user-places.xbel

	if [[ -e $USERPLACES ]]; then 
		diff "$USERPLACES" "$USERPLACES".old  > /dev/null || { 
			echo "non sono riuscito a ripristinare il tuo $USERPLACES"; 
			echo "ripristino backup..."
			mv "$USERPLACES".old "$USERPLACES"
			stato=1
		}
	fi

	echo -e "controllo passato \u2713\n"

	echo -n "controllo del bookmark gtk... "


	BOOKMARKS="$HOME"/.config/gtk-3.0/bookmarks

	if [[ -e $BOOKMARKS ]]; then 
		diff "$BOOKMARKS" "$BOOKMARKS".old  > /dev/null || { 
			echo "non sono riuscito a ripristinare il tuo $BOOKMARKS"; 
			echo "ripristino backup..."
			mv "$BOOKMARKS".old "$BOOKMARKS"
			stato=1
		}
	fi

	echo -e "controllo passato \u2713\n"

	(( stato==1 )) && return 255 || return 0
}


## avvia i test su tagga.sh
export TEST_TAGGA_VERSION='0.7'

echo "Il test effettuerà le seguenti operazioni:"
echo -e "\t- nuovo clone del repo"
echo -e "\t- controllo di versione"
echo -e "\t- installazione software"
echo -e "\t\t- comporta eliminazione della cartella di download del repo"
echo -e "\t- aggiunta di alcuni tag"
echo -e "\t- controllo dei file bookmark"
echo -e "\t- lista dei tag (contiene il tag)"
echo -e "\t- lista di file tagged col precedente tag"
echo -e "\t- rimozione di un associazione"
echo -e "\t- rimozione dell'intero tag"
echo -e "\t- rinomina tag"
echo -e "\t- rinomina associazione tag"
echo -e "\t- disinstallazione di Tagga"
echo -e "\t- controllo dei bookmark (con file di backup)"
echo "SE QUALUNQUE COSA DOVESSE ANDAR MALE, NON INSTALLATE IL SOFTWARE E CONTATTATE LO SVILUPPATORE"
echo "Sviluppo a cura di PsykeDady, per aggiornamenti, issue e pull request andare su https://www.github.com/PsykeDady/Tagga"
echo -e "\n\n";

echo "Continue with tests? [s/N]"
read -r confirm

if [[ $confirm != "s" ]] && [[ $confirm != "S" ]]; then 
	echo "uscita..."
	exit 0
fi

nomedir="$PWD"/Tagga.test


echo -e "\n"

if [[ -e "$nomedir" ]]; then 
	rm -rf "$nomedir"
fi

echo "Vuoi testare il branch di sviluppo? [s/N]"
read -r confirm
opzioni=""

if [[ $confirm == "S" || $confirm == "s" ]]; then
	opzioni="--branch=novita"
fi;


git clone 'https://www.github.com/PsykeDady/TagSH.git/' "$nomedir" $opzioni

echo -e "\ncontrollo di versione..."

TAGGA_VERSION=$("$nomedir"/tagga.sh -v)
if [[ ! $TAGGA_VERSION =~ ^([0-9]*.)?[0-9]*$ ]]; then 
	TAGGA_VERSION=0;
fi

comp=$(bc <<< "$TAGGA_VERSION < $TEST_TAGGA_VERSION" )

if (( comp )); then
	echo -e "\nla versione di Tagga è minore a quella del test che stai eseguendo. Scarica il branch non di sviluppo e quindi esegui i test da li per versioni vecchie"

	pulizer
	exit 255
# else 
# 	exit 0
fi

echo "invoco procedura di installazione..."

echo "\"$nomedir\"/install.sh"
"$nomedir"/install.sh || { echo "script di installazione non riuscito..." ; return 255; }
echo -e "\n\n"


if ! which tagga; then 
	echo "tagga non è stato correttamente installato."
	exit 255;
fi

echo "aggiunta della seguente struttura di tag:"
echo -e "_______________________	"
echo -e "|.tagga					"
echo -e "|- test					"
echo -e "|-|- test.dir -> tdir		"
echo -e "|-|- test.file				"
echo -e "|							"
echo -e "|- documenti				"
echo -e "|-|- documenti.importanti	"
echo -e "|							"
echo -e "|-tag						"
echo -e "|-|-tag1 -> t12			"
echo -e "|-|-|-tag12				"
echo -e "|-|-|-tag3					"
echo -e "|-|-tag2					"
echo -e "|______________________	"


echo 'mkdir -p test.dir tag1'
mkdir -p test.dir tag1
echo -e 'touch test.file documenti.importanti tag2 tag1/tag12\n'
touch test.file documenti.importanti tag2 tag1/tag12 tag1/tag3

echo "test add"
testAdd || { pulizer; exit 255; }

echo -e "\ntest book"
testBook || { pulizer; exit 255; }

echo -e "\ntest list"
testList || { pulizer; exit 255; }

echo -e "\ntest remove"
testRemove || { pulizer; exit 255; }

echo -e "\ntest rename"
testRename || { pulizer; exit 255; }

echo -e "\ntest uninstall"
testUninstall || { echo "disistallazione andata male... "; pulizer; exit 255; }

echo -e "\npremere invio per terminare i test (e pulire la cartella)"
read -r;

pulizer

echo "vuoi installare tag? [S/n]"

read -r confirm

if [[ "$confirm" != "N" && "$confirm" != "n" ]]; then 
	git clone 'https://www.github.com/PsykeDady/Tagga.git/' "$nomedir" $opzioni

	echo "\"$nomedir\"/install.sh"

	"$nomedir"/install.sh || { echo "script di installazione non riuscito..." ; return 255; }
fi

echo -e "\ncancellare cartella di test? [s/N]"

read -r confirm

if [[ "$confirm" == "S" || "$confirm" == "s" ]]; then 
	testdir="$(dirname "$0")";

	case $testdir in
		/*) 
			echo "percorso già assoluto per tag"
			;;
		 *) 
		 	echo "percorso non assoluto per tag, modifica"
			testdir=$(pwd)/$testdir;
		;;
	esac;

	if [[ "$PWD/." -ef "$testdir" ]]; then
		echo "sei nella cartella da eliminare... spostiamoci"
		cd ..
	fi;
	echo rm -rf "$testdir"
	rm -rf "$testdir"
fi