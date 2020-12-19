# TagSH (`ver 0.6`)
tag and categorize your directories, find them easily with your file manager or your shell

Language of script messages is italian for now. Sorry international people 

## test

Test script check if your system is compatible with tagsh ( and if project has some bugs...).

After test, will be prompted if you want to install the selected version of tag (be aware to install "*sviluppo branch*" version, sviluppo mean **development branch**). Follow these istruction:
```bash 
git clone https://github.com/PsykeDady/TagSH
./TagSH/test.sh
```

Press `S` to run script and `N` at **Vuoi testare il branch di sviluppo?** question. If all test passed, you can install safety the script (will be prompted after if you want to install the script ), otherwise open ad issue to dedicated section on Github project!

> **Press S to first question**, and **enter** to all other questions to end script and install software.

## install 
```bash
git clone https://github.com/PsykeDady/TagSH
./TagSH/install.sh
```

### or manually
```bash
git clone https://github.com/PsykeDady/TagSH
sudo mv TagSH /usr/share/TagSH # or move into a custom directory
sudo ln -sf /usr/share/TagSH/tag.sh /usr/bin/tagsh # or link from your custom directory, or expand your PATH env
```

## uninstall
```bash
/usr/share/tagSH/uninstall.sh
```

### or manually
```bash
sudo rm /usr/bin/tagsh
sudo rm -rf /usr/share/TagSH
rm -rf $HOME/.tag
```

then open these two file with your text editor:  

file: `$HOME/.config/gtk3-0/bookmarks`  
delete:
```bash
file:///home/yourname/.tag TagSH
```

file: `$HOME/.local/share/user-places.xbel`  
delete:
```xml
<bookmark href="file:///home/yourname/.tag">
  <title>TagSH</title>
  <info>
   <metadata>
    <bookmark:icon name="tag-symbolic"/>
   </metadata>
  </info>
</bookmark>
```

## usage

`tagsh [options] path tagname [link name]`

OPTIONS:  
- **no option**		: add tag to path or file ( optionally can write a *link name* ) 
- `-d` or `--debug` 	: DEBUG MODE ON
- `-l`			: list all tags
- `-l tagname`		: list all file under specified tag
- `-r nometag` remove tag and unlink all it's content
- `-r nometag nomelink`  unlink an element from specified tag
- `--remove`  alternative to -r.


WHAT YOU CAN DO:  
- you can use abs or rel paths

WHAT YOU CAN'T DO:  
- you can use **only** tag name (or link name) with alphanumeric chars
- you can't tag with same tag two different directory with same name (but you can name it differently!) 

OTHER TRICKS:  
- to rename tag, you can go to directory `$HOME/.tag` and rename its directory
- to rename association, go into directory `$HOME/.tag/tagname` and rename file

EXAMPLES:  
- link directory `/home/yourname/workspace/java` with tag **javacodes** under *wjava* name:  
`tagsh ~/workspace/java javacodes wjava`
- link directory `eclipse/java` (relative path) with tag **javacodes** without rename it:  
`tagsh eclipse/java javacodes`
- list all tag  
`tagsh -l`
- list all file under tag **javacodes**  
`tagsh -l javacodes`
- remove tag javacode from eclipse/java element  
`tagsh -r javacodes java`
- remove tag javacodes and all it's association  
`tagsh -r javacodes`


## TODO list for next versions:

- ~~command to delete an association~~
- ~~command to delete an entire tag~~
- command to rename a tag
- command to rename an association 
- ~~debug mode and silent mode (default)~~ 
- implement language translations file ( ita, eng )
- minimalist GUI and dolphin service with kdialog
- minimalist GUI with zenity

