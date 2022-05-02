import miniupnpc

upnp = miniupnpc.UPnP()

upnp.discoverdelay = 10
upnp.discover()

upnp.selectigd()

port = 7362

method = 'UDP'

print("adding port mapping")
print("port:" + str(port))
print("method:" + str(method))
print("local addr:" + str(upnp.lanaddr))


# addportmapping(external-port, protocol, internal-host, internal-port, description, remote-host)
print(upnp.addportmapping(port, method, upnp.lanaddr, port, 'Portal 2 Multiplayer Mod TESTING', ''))