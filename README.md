# TagSH
tag and categorize your directories, find them easily with your file manager or your shell

Language of script messages is italian for now. Sorry international people 

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

`tagsh  /path/to/directory tagname`

what you can do:
- you can use abs or rel path

what you can't do:
- you can use **only** tag name with alphanumeric chars
- you can't tag with same tag two different directory with same name 

other tricks: 
- to delete unwanted tag, you can go to directory $HOME/.tag and delete dir named with tag
- to rename tag, move its directory
- to delete association, go into directory $HOME/.tag/tagname and delete dir you want to unassociate

## TODO list for next versions:

- command to delete an association
- command to delete an entire tag
- command to rename a tag
- command to name/rename an association (in order to permit different directory with same name)
- debug mode and silent mode (default) 
- implement language translations file ( ita, eng )
- minimalist GUI and dolphin service with kdialog
- minimalist GUI with zenity

