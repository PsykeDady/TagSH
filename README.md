# Tagga (`ver 0.7`)
tag and categorize your directories, find them easily with your file manager or your shell

Language of script messages is italian for now. Sorry international people 

## test

Test script check if your system is compatible with tagga ( and if project has some bugs...).

After test, will be prompted if you want to install the selected version of tag (be aware to install "*sviluppo branch*" version, sviluppo mean **development branch**). Follow these istruction:
```bash 
git clone https://github.com/PsykeDady/Tagga
./Tagga/test.sh
```

Press `S` to run script and `N` at **Vuoi testare il branch di sviluppo?** question. If all test passed, you can install safety the script (will be prompted after if you want to install the script ), otherwise open ad issue to dedicated section on Github project!

> **Press S to first question**, and **enter** to all other questions to end script and install software.

## install 
```bash
git clone https://github.com/PsykeDady/Tagga
./Tagga/install.sh
```

### or manually
```bash
git clone https://github.com/PsykeDady/Tagga
sudo mv Tagga /usr/share/Tagga # or move into a custom directory
sudo ln -sf /usr/share/Tagga/tagga.sh /usr/bin/tagga # or link from your custom directory, or expand your PATH env
```

## uninstall
```bash
/usr/share/Tagga/uninstall.sh
```

### or manually
```bash
sudo rm /usr/bin/tagga
sudo rm -rf /usr/share/Tagga
rm -rf $HOME/.tagga
```

then open these two file with your text editor:  

file: `$HOME/.config/gtk3-0/bookmarks`  
delete:
```bash
file:///home/yourname/.tagga Tagga
```

file: `$HOME/.local/share/user-places.xbel`  
delete:
```xml
<bookmark href="file:///home/yourname/.tagga">
  <title>Tagga</title>
  <info>
   <metadata>
    <bookmark:icon name="tag-symbolic"/>
   </metadata>
  </info>
</bookmark>
```

## usage

`tagga [options] path tagname [link name]`

OPTIONS:  
- **no option**		: add tag to path or file ( optionally can write a *link name* ) 
- `-d` or `--debug` 	: DEBUG MODE ON
- `-l`			: list all tags
- `-l tagname`		: list all file under specified tag
- `-r nometag` remove tag and unlink all it's content
- `-r nometag nomelink`  unlink an element from specified tag
- `--remove`  alternative to -r.
- `-n tagName newName`  :   rename tag into newName
- `-n tagName linkName newName` 	:	rename tagged link into newName
- `--rename` alternative to `-n`
- `-v` or `--versione` : show version number of Tagga, with `-d` show more details


WHAT YOU CAN DO:  
- you can use abs or rel paths

WHAT YOU CAN'T DO:  
- you can use **only** tag name (or link name) with alphanumeric chars
- you can't tag with same tag two different directory with same name (but you can name it differently!) 

EXAMPLES:  
- link directory `/home/yourname/workspace/java` with tag **javacodes** under *wjava* name:  
`tagga ~/workspace/java javacodes wjava`
- link directory `eclipse/java` (relative path) with tag **javacodes** without rename it:  
`tagga eclipse/java javacodes`
- list all tag  
`tagga -l`
- list all file under tag **javacodes**  
`tagga -l javacodes`
- remove tag **javacode** from *eclipse/java* element  
`tagga -r javacodes java`
- remove tag **javacodes** and all it's association  
`tagga -r javacodes`
- rename tag **javacodes** in **javacode**  
`tagga -n javacodes javacode`
- rename *wjava* under **javacodes** tag) association into *workJava*  
`tagga -n javacodes wjava workJava`  



## DONE, TODO and PLANS

- v 0.1 (DONE)
  - ~~add a tag~~
- v 0.2 (DONE)
  - ~~install uninstall script~~
  - ~~bookmark management~~ 
- v 0.3 (DONE)
  - ~~silent mode debug mode~~
- v 0.4 (DONE) 
  - ~~shellcheck improvement~~
  - ~~function separation~~ 
  - ~~listTag~~
- v 0.5 (DONE) 
  - ~~removeTag~~
- v 0.6 (DONE)
  - ~~test script~~
- v 0.7 (DONE)
  - ~~renameTag~~
  - ~~renameTag tests integration~~
  - ~~test check tag-version~~
- v 0.8
  - make name link capable to include spaces
  - context usage
  - language files ( ita, eng )
- v 0.9 
  - language integration
- v 1.0 
  - autocomplete integration with zsh and bash
  - auto update check
- v 1.1 to 2.0
  - GUI
    - minimalist GUI and dolphin service with kdialog
    - minimalist GUI with zenity
    - GNOME menu integration
    - python fe

