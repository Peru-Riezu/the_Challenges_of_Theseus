PARENT_DIR="/home/Bombe"
TARGET_DIR="sarraila"
KEY_FILE="giltza.pub"
TARGET_DIR="sekretu_kutxa"
KEY_FILE="mezu_enkriptatua.bin"
EXPECTED_CONTENT=$(cat /home/Bombe/jatorrizko_mezua)

trap '' SIGINT

while true; do
	if [[ -f "$PARENT_DIR/$TARGET_DIR/$KEY_FILE" && -f "$PARENT_DIR/$TARGET_DIR2/$KEY_FILE2" ]]; then
		FILE_CONTENT=$(openssl rsautl -decrypt -inkey $PARENT_DIR/sarraila/giltza.pub -in $PARENT_DIR/sekretu_kutxa/mezu_enkriptatua.bin)
		if [[ "$FILE_CONTENT" == "$EXPECTED_CONTENT" ]]; then
			cat /root/basque/user_monitoring_scripts/eragile_analitikoa_handle_success.bash > /handle_sigint.bash
			exec 42>/root/lock
			flock 42
			exec 200>/user_shell_files/lock
			flock 200
			pkill -SIGINT bash
			while [ ! -f "/user_shell_files/shells_working" ]; do
				sleep 0.01
			done
			flock -u 200
			while [ -f "/user_shell_files/shells_working" ]; do
				sleep 0.1
			done
			echo "" > /handle_sigint.bash
			flock -u 42
			exit 0
		fi
	fi
	sleep 0.2
done
