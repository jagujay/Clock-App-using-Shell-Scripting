#!/bin/bash

# ALARM FUNCTION
set_alarm() {
        a_date=$(dialog --title "SET ALARM!" --inputbox "Enter the date for the alarm" 15 50 3>&1 1>&2 2>&3 3>&-)
	a_month=$(dialog --title "SET ALARM!" --inputbox "Enter the month for the alarm" 15 50 3>&1 1>&2 2>&3 3>&-)
        a_hours=$(dialog --title "SET ALARM!" --inputbox "Enter the hour for the alarm" 15 50 3>&1 1>&2 2>&3 3>&-)
        a_min=$(dialog --title "SET ALARM!" --inputbox "Enter the minute for the alarm" 15 50 3>&1 1>&2 2>&3 3>&-)

        dialog --title "ALARM" --infobox "Alarm set for $a_hours : $a_min on $a_date / $a_month" 15 50

        c_hours=$(date +'%H')
	c_min=$(date +'%M')
        c_date=$(date +'%d')
	c_month=$(date +'%m')
        
	if [ "$a_date" -lt "$c_date" ] || [ "$a_date" -gt 31 ]
        then
                dialog --title "ERROR" --msgbox "Error in date" 15 50
		set_alarm
        fi

        if [ "$a_month" -lt "$c_month" ] || [ "$a_month" -gt 12 ]
        then
                 dialog --title "ERROR" --msgbox "Error in month" 15 50
                 set_alarm
        fi

        if [ "$a_date" = "$c_date" ]
        then
                if [ "$a_hours" -lt "$c_hours" ] || [ "$a_min" -lt "$c_min" ]
                then
                        dialog --title "ERROR" --msgbox "Error in hour/min" 15 50
                        set_alarm
                fi
        fi

        if [ "$a_hours" -gt 23 ] || [ "$a_min" -gt 59 ]
        then
                dialog --title "ERROR" --msgbox "Error in hour/min" 15 50
                set_alarm
        fi

        while true
        do
                c_hours=$(date +'%H')
        	c_min=$(date +'%M')
		if [ "$c_hours" = "$a_hours" ] && [ "$c_min" = "$a_min" ]
                then
                        dialog --title "ALARM" --infobox "Alarm! Wake up!" 15 50
                        break
                fi
        sleep 1s
        done
}

# DIGITAL CLOCK FUNCTION
digital_clock() {
        red=$'\e[1;31m'
        green=$'\e[1;32m'
        blue=$'\e[1;34m'
        i=1
        while [ $i -lt 10 ]
        do
                clear
                dialog --title "DIGITAL CLOCK" --infobox "$(date +%T)" 15 50
                sleep 1s
                i=$((i+1))
        done
}

# TIMER FUNCTION
timer() {
        seconds_input=$(dialog --title "SET TIMER!" --inputbox "Timer for how many seconds?" 8 40 3>&1 1>&2 2>&3 3>&-)
        N="$seconds_input"
        dialog --title "TIMER" --infobox "Timer starts now!" 15 50
        while [ "$N" -gt 0 ]
        do
                dialog --title "TIMER" --infobox "$N" 4 20
                sleep 1s
                N=$((N-1))
        done
        dialog --title "TIMER" --infobox "Time Up!!!" 15 50
}

# MAIN FUNCTION
DIALOG_CANCEL=1
DIALOG_ESC=255
HEIGHT=0
WIDTH=0

while true
do
        exec 3>&1
        selection=$(dialog \
        --backtitle "CLOCK APPLICATION" \
        --title "Clock Menu" \
        --clear \
        --cancel-label "Exit" \
         --menu "Please select:" $HEIGHT $WIDTH 4 \
        "1" "DISPLAY DIGITAL CLOCK" \
        "2" "SET ALARM" \
        "3" "SET TIMER" \
        2>&1 1>&3)
        exit_status=$?
        exec 3>&-
        case $exit_status in
                $DIALOG_CANCEL)
                        clear
                        echo "Program terminated."
                        exit
                        ;;
                $DIALOG_ESC)
                        clear
                        echo "Program aborted." >&2
                        exit 1
                        ;;
        esac
        choice="$selection"
        case "$choice" in
                "1") digital_clock
                        ;;
                "2") set_alarm
                        sleep 5s
                        ;;
                "3") timer
                        sleep 5s
                        ;;
        esac
done
dialog --title "ALARM CLOCK" --infobox "Thank You for using the Alarm Clock!!!" 15 50
