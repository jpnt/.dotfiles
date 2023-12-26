#!/bin/sh
#
# Example Bar Action Script for Linux.
#
# Requires: acpi, iostat.

print_date() {
	# The date is printed to the status bar by default.
	# To print the date through this script, set clock_enabled to 0
	# in spectrwm.conf.  Uncomment "print_date" below.
	FORMAT="%a %b %d %R %Z %Y"
	DATE=`date "+${FORMAT}"`
	echo -n "${DATE}     "
}

print_mem() {
	echo -n "RAM: $(free -h | awk '/Mem/ {print $3 "/" $2}')  "
}

print_cpu() {
	echo -n "CPU: $(top -b -n 1 | awk '/Cpu/ {print $2 "%"}') "
}

print_bat() {
	AC_STATUS="$3"
	BAT_STATUS="$6"
	# Most battery statuses fit into a single word, except "Not charging"
	# for which we need to have special handling.
	if [ "$BAT_STATUS" = "Not" ]; then
		BAT_STATUS="$BAT_STATUS $7"
		shift
	fi
	BAT_LEVEL="`echo "$7" | tr -d ','`"

	if [ "$AC_STATUS" != "" -o "$BAT_STATUS" != "" ]; then
		if [ "$BAT_STATUS" = "Discharging," ]; then
			echo -n "on battery ($BAT_LEVEL)"
		else
			case "$AC_STATUS" in
			on-line)
				AC_STRING="on AC: "
				;;
			*)
				AC_STRING=""
				;;
			esac
			case "$BAT_STATUS" in
			"")
				BAT_STRING="(no battery)"
				;;
			*harging,|Full,)
				BAT_STRING="(battery $BAT_LEVEL)"
				;;
			*)
				BAT_STRING="(battery unknown)"
				;;
			esac

			FULL="${AC_STRING}${BAT_STRING}"
			if [ "$FULL" != "" ]; then
				echo -n "$FULL"
			fi
		fi
	fi
}

# Cache the output of acpi(8), no need to call that every second.
ACPI_DATA=""
I=0
while :; do
	IOSTAT_DATA=`/usr/bin/iostat -c | grep '[0-9]$'`
	if [ $I -eq 0 ]; then
		ACPI_DATA=`/usr/bin/acpi -a 2>/dev/null; /usr/bin/acpi -b 2>/dev/null`
	fi
	# print_date
	print_mem
	print_cpu
	print_bat $ACPI_DATA
	echo ""
	I=$(( ( ${I} + 1 ) % 11 ))
	sleep 1
done
