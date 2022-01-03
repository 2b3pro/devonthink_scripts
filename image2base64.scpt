-- Converts an image file to its base64 data-uri equivalent.
-- Created by Ian Shen / 2B3 PRODUCTIONS LLC on 2021/12/31
-- Copyright (cc) Attribution-NonCommercial-ShareAlike 4.0 International https://creativecommons.org/licenses/by-nc-sa/4.0/

tell application id "DNtp"
	try
		set this_selection to the selection
		set the_group to the current group
		if this_selection is {} then error "Please select some image files."
		repeat with this_item in this_selection
			set the_MIMEtype to the MIME type of this_item
			set allowedImageTypes to {"image/jpeg", "image/png", "image/svg+xml", "image/gif", "application/pdf"}
			if allowedImageTypes contains the_MIMEtype then
				try
					set this_path to the path of this_item
					set the_tags to the tags of this_item
					
					set the_record to (create record with {type:"text", name:(name without extension of this_item) & "-b64.txt"} in the_group)
					set the_b64_path to the path of the_record
					with timeout of 45 seconds
						set the_results to (do shell script "base64 " & this_path)
					end timeout
					set the plain text of the_record to ("data:" & the_MIMEtype & ";base64," & the_results) as string
					set the tags of the_record to the_tags
				end try
			else
				display alert "This file is not an allowed image file."
			end if
		end repeat
	on error error_message number error_number
		if the error_number is not -128 then display alert "DEVONthink" message error_message as warning
	end try
end tell
