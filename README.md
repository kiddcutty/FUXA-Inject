 /$$$$$$$$ /$$   /$$ /$$   /$$  /$$$$$$        /$$$$$$                                     /$$    
| $$_____/| $$  | $$| $$  / $$ /$$__  $$      |_  $$_/                                    | $$    
| $$      | $$  | $$|  $$/ $$/| $$  \ $$        | $$   /$$$$$$$  /$$  /$$$$$$   /$$$$$$$ /$$$$$$  
| $$$$$   | $$  | $$ \  $$$$/ | $$$$$$$$        | $$  | $$__  $$|__/ /$$__  $$ /$$_____/|_  $$_/  
| $$__/   | $$  | $$  >$$  $$ | $$__  $$        | $$  | $$  \ $$ /$$| $$$$$$$$| $$        | $$    
| $$      | $$  | $$ /$$/\  $$| $$  | $$        | $$  | $$  | $$| $$| $$_____/| $$        | $$ /$$
| $$      |  $$$$$$/| $$  \ $$| $$  | $$       /$$$$$$| $$  | $$| $$|  $$$$$$$|  $$$$$$$  |  $$$$/
|__/       \______/ |__/  |__/|__/  |__/      |______/|__/  |__/| $$ \_______/ \_______/   \___/  
                                                           /$$  | $$                              
                                                          |  $$$$$$/                              
                                                           \______/                               
This is a script to retrieve and manipulate tag values in FUXA  
Run the following
```
cd FUXAInject

chmod +x fuxa-inject.sh
```
Run the shell script  
You will be prompted for the FUXA URL which should look something like ```http://10.10.10.10:1881```  
Next you will select the action you would like to accomplish
```
1) Get Tag
2) Set Tag
```
If you selected ```Get Tag``` the script will give a list of tag options to choose from. Once a tag has been selected the script will make an API call to FUXA and return the tag value.    
If you selected ```Set Tag``` the script will give a list of tag options to choose from then will ask for the value you would like to set. Once entered the script will make an API call to set the tag value and return the current value.
