description = [[
Looks for signature of PLESK servers that were compromised earlier in 2012.

The script checks the existance of enterprise/control/psa/engine.php and 
/enterprise/control/ctrl.php3 files that are not part of plesk distribution. 
The files were added in most servers during the first 3 months of 2012 
after a global scale attack on PLESK hosting servers. 
More at: http://www.my-audit.gr/hacking/plesk-backdoors-a-very-large-number-of-servers-compromised/ ,
http://forum.parallels.com/showthread.php?t=258101 and 
http://0entropy.blogspot.com/2012_03_01_archive.html
]]

---
-- the result will be something like the following
-- Interesting ports on somehost.someserver.com (xxx.xxx.193.64):
-- PORT     STATE SERVICE
-- 8443/tcp open  https-alt
-- |_ http-plesk-backdoor: PLESK infected v2, please check: http://www.my-audit.gr/hacking/plesk-backdoors-a-very-large-number-of-servers-compromised/
---

author = "Nicolas Krassas"
license = "Same as Nmap--See http://nmap.org/book/man-legal.html"
categories = {"malware","discovery","safe"}

require "http"
require "shortport"
require "stdnse"

-- This script will check on port 8443 only
portrule = function(host, port)
    local svc = { std = { ["https-alt"] = 1 } }
    if port.protocol ~= 'tcp' or not svc.std[port.service] then
        return false
    end
    return true
end

-- Execute the check 
action = function(host, port)

	-- Perform a GET request for v2 backdoor, this is the most common currently.
	result = http.get_url("https://" .. host.ip .. ":" .. port.number .. "/enterprise/control/psa/engine.php")
	
	if(not(result)) then
		return stdnse.format_output(false, "Couldn't perform GET request")
	end

	if(result.status == 200) then
		string = ("PLESK infected v2, please check: http://www.my-audit.gr/hacking/plesk-backdoors-a-very-large-number-of-servers-compromised/");
	   	return string
	end

        -- Perform a GET request for v3 backdoor ( 15/3 )
        result = http.get_url("https://" .. host.ip .. ":" .. port.number .. "/enterprise/control/psa/enterprise/rpc.php")

        if(not(result)) then
                return stdnse.format_output(false, "Couldn't perform GET request")
        end

        if(result.status == 200) then
                string = ("PLESK infected v3, please check: http://www.my-audit.gr/hacking/plesk-backdoors-a-very-large-number-of-servers-compromised/");
                return string
        end

        -- Perform a GET request for v1 backdoor
        result = http.get_url("https://" .. host.ip .. ":" .. port.number .. "/enterprise/control/ctrl.php3")

        if(not(result)) then
                return stdnse.format_output(false, "Couldn't perform GET request")
        end

        if(result.status == 200) then
                string = ("PLESK infected v1, please check: http://www.my-audit.gr/hacking/plesk-backdoors-a-very-large-number-of-servers-compromised/");
                return string
        end
   
end



