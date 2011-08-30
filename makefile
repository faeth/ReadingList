
install :
	mkdir -p ~/Library/Scripts
	mkdir -p ~/Library/LaunchAgents
	cp com.adamfaeth.readinglist.papers2.sh ~/Library/Scripts/
	cp com.adamfaeth.readinglist.papers2.plist ~/Library/LaunchAgents/
	launchctl unload ~/Library/LaunchAgents/com.adamfaeth.readinglist.papers2.plist
	launchctl load ~/Library/LaunchAgents/com.adamfaeth.readinglist.papers2.plist
	
install-papers1 :
	mkdir -p ~/Library/Scripts
	mkdir -p ~/Library/LaunchAgents
	cp com.adamfaeth.readinglist.papers1.sh ~/Library/Scripts/
	cp com.adamfaeth.readinglist.papers1.plist ~/Library/LaunchAgents/
	launchctl unload ~/Library/LaunchAgents/com.adamfaeth.readinglist.papers1.plist
	launchctl load ~/Library/LaunchAgents/com.adamfaeth.readinglist.papers1.plist

install-kindle :
	mkdir -p ~/Library/Scripts
	mkdir -p ~/Library/Workflows/Applications/Folder\ Actions/
	cp com.adamfaeth.kindleReadingList.sh ~/Library/Scripts/
	cp com.adamfaeth.syncKindleBooks.sh ~/Library/Scripts/

