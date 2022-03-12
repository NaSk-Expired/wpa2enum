The Wpa2 enumeration Script

hellow . I ... mm  m m mmmmmmmmmmmm   . new here as u r :)

this is the first bash script i am making it available on github which can help pentesters to save their time when pentesting wi-fi Networks with wpa2-personal auth. enabled on it .

before getting into the specification of this script I am gonna make some things straight simple 
which are :

1. By using this script you agree to use it legally and has a permission from "who" the against you are using it.
2. I am no responsible of misuse of this script in any form .
3. you can modify this script as u need as there are some limitation of it !
4. and i am new to github so i may do things that may u 'pros' find worng -_- .

Intro to the wpa2enum script 

Script written in : Bash 

what this script can do : 

1. Capture 4 way handshake 
2. Capture PMKID  
3. Jam the Entire wifi network (Kicking every one off from wifi)
4. kick specific clients off from wifi

advantages : 

1. supports 2 wireless adapters
2. can jam wifi for long as possibe
3. as it is written in bash anyone can make changes according to its needs 
            
Here are some management things it can do if ctrl+c was pressed accendently

1. restart network manager service from menu
2. disable moniter mode of a specific wifi adapters
3. empty h and pmk folder if needed !
  
disadvantages :

1. Very Mininmal input validation
2. require proper inputs  
3. Only from top 4 wifi networks in the airodump list are selectable ( which is good because they are closer to you)
4. This script will not properly handle unintentional ctrl+c key press as it stops immediately wherever the script is executing 
5. Cannot kick multiple clients in handshake capturing process . (ONE at a Time)
6. i dont know more -_-.

other limitation : 

1. This scrit will not crack the hash stored in handshake or pmkid as its not its main purpose
2. There is no any documentation it does that how it does things ( i dont know it would be good to mention this but i still mentioned it )

Installation : 

git clone https://github.com/NaSk-Expired/wpa2enum.git &&
cd wpa2enum &&
chmod +x w2e.sh

Execute :

./w2e.sh

  
