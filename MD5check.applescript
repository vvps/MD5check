set message to ""
tell application "Finder"
	try
		set selected_item to selection
	on error
		error "No selected Finder items"
	end try
	set file_name to POSIX path of (selected_item as alias)
	if text -1 of file_name is not equal to "/" then
		set md5 to do shell script "/usr/bin/openssl md5 " & quoted form of file_name
		set message to message & "FILE:" & return & file_name & return & return & (word -1 of md5) & " (MD5 Calculated)" & return
	end if
end tell
if length of message is 0 then
	error "You can't calculate the checksum of a folder"
else
	try
		set message to message & (the clipboard as text) & " (Clipboard contents)" & return
		
		if (the clipboard as text) is equal to (word -1 of md5 as text) then
			set message to message & return & "MD5 SUCCESS" & return
		else
			set message to message & return & "MD5 FAIL" & return
		end if
		display dialog text of message with title "MD5 Check" buttons {"OK"} default button "OK" cancel button "OK"
	end try
end if
