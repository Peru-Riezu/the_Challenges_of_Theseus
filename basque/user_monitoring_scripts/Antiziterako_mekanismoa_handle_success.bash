# de facto there is a sources handle_success.bash here
get_success_lock_might_return

check_dates()
{
	for PATH in "$@"
	do
		MOD_TIME=$(stat -c %y "$PATH" 2> /dev/null)
		ACCESS_TIME=$(stat -c %x "$PATH" 2> /dev/null)
		TARGET_DATE="1970-01-01 00:00:00.000000000"

		if [[ "$MOD_TIME" != "$TARGET_DATE" || "$ACCESS_TIME" != "$TARGET_DATE" ]]
		then
			return 0
		fi
	done

	return 1
}	

if [ ! -f "/user_shell_files/foreground_activated" ]; then
	touch /user_shell_files/foreground_activated
	stty igncr -isig -icanon -ixoff -echo
	tput civis
	tput clear

############################################### test 1º ##################################################################
	printf "$COLOR_GREEN%s$COLOR_RESET\n" \
		"frogatzen (1/5)"

	animate_dots &
	DOTS_PID=$!

	mkdir /tmp/dir1
	touch /tmp/dir1/file1 /tmp/dir1/file2 /tmp/dir1/file4 /tmp/dir1/file5

	timeout 0.5 /home/Antiziterako_mekanismoa/aurkezpen_ontzia/erantzuna /tmp/dir1/file1 /tmp/dir1/file2 /tmp/dir1/file3 \
		/tmp/dir1/file4 /tmp/dir1/file5 \
		&> /user_shell_files/output
	FILE_CONTENT=$(cat /user_shell_files/output)
	EXPECTED_CONTENT=$(echo -n)
	sleep 3
	kill $DOTS_PID

	if [[ "$FILE_CONTENT" != "$EXPECTED_CONTENT" ]] || \
			check_dates /tmp/dir1/file1 /tmp/dir1/file2 /tmp/dir1/file4 /tmp/dir1/file5 ; then
		mv /home/Antiziterako_mekanismoa/aurkezpen_ontzia/erantzuna \
			/home/Antiziterako_mekanismoa/aurkezpen_ontzia/erantzun
		move_to_suffix /home/Antiziterako_mekanismoa/aurkezpen_ontzia/erantzun _ezegokia
		printf "%s%s\n" "/home/Antiziterako_mekanismoa/aurkezpen_ontzia/erantzuna" \
			"\"\"" \
			> /home/Antiziterako_mekanismoa/aurkezpen_ontzia/emandako
		move_to_suffix /home/Antiziterako_mekanismoa/aurkezpen_ontzia/emandako _inputa
		cat <<< "$EXPECTED_CONTENT" > /home/Antiziterako_mekanismoa/aurkezpen_ontzia/esperozen
		move_to_suffix /home/Antiziterako_mekanismoa/aurkezpen_ontzia/esperozen _outputa
		mv /user_shell_files/output /home/Antiziterako_mekanismoa/aurkezpen_ontzia/lortutako
		move_to_suffix /home/Antiziterako_mekanismoa/aurkezpen_ontzia/lortutako _outputa
		tput clear
		tput clear
		printf "$COLOR_RED%s$COLOR_RESET\n" \
			"froga (1/5): erantzun ezegokia."
		stty -igncr
		read -s -r -n1
		stty sane
		tput clear
		tput cnorm
		yield_success_lock
		return 0
	fi

############################################## success ###################################################################
	rm /user_shell_files/output
	tput clear
	tput clear
	printf "%s\n\n$COLOR_GREEN%s\n%s$COLOR_RESET\n" \
		"asmakizun hau gainditu duzu" \
		"erabiltzailea: " \
		"pasahitza: " > /home/Antiziterako_mekanismoa/aurkezpen_ontzia/haria
	cat /home/Antiziterako_mekanismoa/aurkezpen_ontzia/haria
	stty -igncr
	read -s -r -n1
	stty sane
	mv /home/Antiziterako_mekanismoa/aurkezpen_ontzia/ /home/Antiziterako_mekanismoa/ate_irekia
	mv /home/Antiziterako_mekanismoa/helburua /home/Antiziterako_mekanismoa/helburu_lortua
	cd
	tput clear
	tput cnorm

	touch /user_shell_files/Antiziterako_mekanismoa_success
fi

yield_success_lock

