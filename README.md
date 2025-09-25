# FUXAInject
This is a script to retrieve and manipulate tag values in FUXA  
Run the following
```
cd FUXAInject

chmod +x fuxa-inject.sh
```
Run the shell script  
You will be prompted for the FUXA URL which should look something like ```http://10.10.10.10:1881```  
Next you will select the action you would like to accomplish
```1) Get Value
   2) Set Value
```
If you selected ```Get Value``` the script will make an API call to FUXA and return the tag value.
If you selected ```Set Value``` the script will ask for the value you would like to set. Once entered the script will make an API call to set the tag value and return the current value.
