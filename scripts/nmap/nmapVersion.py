# Julian did this whole file
import sqlite3
import xml.etree.ElementTree as xml
# Define the xml file.
tree = xml.parse('data.xml')
root = tree.getroot()
# Define the database file.
connect = sqlite3.connect('data/database.db')
c = connect.cursor()
# Search the xml file for scan data of open ports and output it to the database.
for host in root.iter('host'):
    ip = host.find('address').attrib['addr']
    for port in host.iter('port'):
        if port.find('state').attrib['state'] == 'open':
            portid = port.attrib['portid']
            port_name = port.find('service').attrib.get('name', 'unknown')
            state = port.find('state').attrib['state']
            service = port.find('service')
            cpe = service.find('cpe')
            # Clean up the output a bit.
            if cpe is not None:
                servicetype = cpe.text.replace('cpe:/a:', '')
            else:
                servicetype = 'Nmap could not figure out service type.'
            c.execute("INSERT INTO nmapVersion VALUES (CAST(? AS TEXT), CAST(? AS TEXT), CAST(? AS TEXT), CAST(? AS TEXT), CAST(? AS TEXT))", (ip, str(portid), str(port_name), str(state), str(servicetype)))
        elif port.find('state').attrib['state'] == 'filtered':
            portid = port.attrib['portid']
            port_name = port.find('service').attrib.get('name', 'unknown')
            state = port.find('state').attrib['state']
            service = port.find('service')
            cpe = service.find('cpe')
            # Clean up the output a bit.
            if cpe is not None:
                servicetype = cpe.text.replace('cpe:/a:', '')
            else:
                servicetype = 'Nmap could not figure out service type.'
            c.execute("INSERT INTO nmapVersion VALUES (CAST(? AS TEXT), CAST(? AS TEXT), CAST(? AS TEXT), CAST(? AS TEXT), CAST(? AS TEXT))", (ip, str(portid), str(port_name), str(state), str(servicetype)))
# Commit to database and close the connection.
connect.commit()
connect.close()
