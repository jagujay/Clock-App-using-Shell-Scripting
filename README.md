# Clock App using Shell Scripting

This is a simple clock application built using Bash scripting and `dialog` for user interaction. The application includes features such as a digital clock, an alarm, and a timer.

## Features
- **Digital Clock:** Displays the current time in HH:MM:SS format.
- **Alarm:** Allows users to set an alarm for a specific time and date.
- **Timer:** Counts down from a user-defined number of seconds.

## Requirements
Ensure that the `dialog` package is installed on your system. You can install it using:
```sh
sudo apt-get install dialog
```

## Usage
1. Clone the repository:
```sh
git clone https://github.com/yourusername/Clock-App-using-Shell-Scripting.git
cd Clock-App-using-Shell-Scripting
```
2. Make the script executable:
```sh
chmod +x clock.sh
```
3. Run the script:
```sh
./clock.sh
```

## Menu Options
- **1:** Display the digital clock.
- **2:** Set an alarm by entering the date, month, hour, and minute.
- **3:** Set a timer by specifying the duration in seconds.

## Notes
- The alarm function ensures the user enters a valid date and time.
- The timer counts down in real-time and notifies the user when the time is up.
- The digital clock updates dynamically every second.
