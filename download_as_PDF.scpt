# Creates a PDF from the data at the URL ofthe active browser tab (in Brave Browser)
--property myAgent : "Mozilla/5.0 (Macintosh; Intel Mac OS X 12_1) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.2 Safari/605.1.15"

tell application id "DNtp"
	try
		tell application "Brave Browser" to set theFileLocation to URL of active tab of front window
		tell application "Brave Browser" to set theTabTitle to title of active tab of front window
		set thisGroup to current group
		set theRecord to (create web document from (theFileLocation) in thisGroup with readability)
		set name of theRecord to theTabTitle
	on error error_message number error_number
		if the error_number is not -128 then display alert "DEVONthink" message error_message as warning
	end try
end tell
