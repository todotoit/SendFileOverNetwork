# Send File Over Network
A batch script to send one or multiple files to one or multiple machine over network.
Before using this script, you have to enable **Developer Mode** in Windows 10.

### Enable Developer Mode
In Windows, go to **Settings** -> **Update & Security** -> **For developers** 
Check **Developer mode** (and wait for Windows to download the developer mode dependencies).
Set **Device discovery** to **On** 
Set **Use OpenSSH (Beta) server for remote deployment** to **On**
Now you can use the script

## Add IPs
Open **SendFile.bat** file in a text editor 
At line 14, add the IPs of the machines you want to send the files to.
e.g.
**set ip_list="192.168.1.136" "192.168.1.137" "192.168.1.3"**

## Destination machines user and password
For the script to work properly, all the machines must have the same user and password.
At line 8 and 10 you can update the username and the password in the script.
Also the destination folder path must be the same

## Add Script to System Path
Save the script in any folder you like and then add the folder to Windows Environment Variable
Go to **Control Panel** -> **System and Security** -> **System** -> **Advanced system settings** -> **Environment Variables**
Select **Path** and then click on **Edit**
Click on **New** and insert the path where you have saved the SendFile script

## How to use the script
First cd inside the directory where the files you want to send reside

-To send all files to all machines
**SendFile**

-To send a specific file to all machines
**SendFile all file_to_send.mp4**

-To send all files to a specific machine
**SendFile 192.168.1.134** 

-To send a specific file to a specific machine
**SendFile 192.168.1.134 file_to_send.mp4**
