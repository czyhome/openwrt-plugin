-- Copyright 2023 Bruce Chen <a805899926@gmail.com>
-- Licensed to the public under the Apache License 2.0.

local fs = require("nixio.fs")

local m = Map("dnsproxy")
m.redirect = luci.dispatcher.build_url("admin", "services", "dnsproxy")
m.apply_on_parse = true

s = m:section( NamedSection, arg[1], translate("DnsProxy instances"), "")
s:tab("general", translate("General Settings"));
s:tab("advanced", translate('Advanced Settings'));
s:tab('logview',translate('Log File Viewer'));

enabled = s:taboption("general", Flag, "enabled", translate("Enabled"))
debug = s:taboption("general", Flag, "debug", translate("Enable debug logging"))

listen = s:taboption("general", DynamicList, "listen", translate("Listen"), translate("Listening addresses"))
listen.datatype = "ipaddr"

port = s:taboption("general", DynamicList, "port", translate("Port"), translate("Listening ports. Zero value disables TCP and UDP listeners"))
port.datatype = "port"

s:taboption("general", DynamicList ,"bootstrap", translate("Bootstrap"), translate("Bootstrap DNS for DoH and DoT (default: 8.8.8.8:53)"))
s:taboption("general", DynamicList ,"upstream", translate("Upstream"), translate("Upstream DNS. Here is a <a href=\"https://link.adtidy.org/forward.html?action=dns_kb_providers&from=ui&app=home\" target=\"_blank\">list of known DNS providers</a> to choose from"))

https_port = s:taboption("advanced", Value, "https_port", translate("HTTPS Port"))
https_port.datatype = "port"

tls_port = s:taboption("advanced", Value, "tls_port", translate("TLS Port"))
tls_port.datatype = "port"

-- logview = s:taboption('logview', TextValue, '_read_log')
-- logview.submit=false
-- logview.rows = 20
-- function logview.cfgvalue(self, section)
-- 	if nixio.fs.access("/var/log/dnsproxy.%s.log" % section) then
-- 		local logs = luci.util.execi("cat /var/log/dnsproxy.%s.log" % section)
-- 		local s = ""
-- 		for line in logs do
-- 			s = line .. "\n" .. s
-- 		end
-- 		return s
-- 	end
-- end

return m