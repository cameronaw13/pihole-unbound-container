FROM pihole/pihole:2024.01.0
RUN apt-get update && apt-get install -y unbound

COPY pihole-unbound/lighttpd-external.conf /etc/lighttpd/external.conf 
COPY pihole-unbound/unbound-pihole.conf /etc/unbound/unbound.conf.d/pi-hole.conf
COPY pihole-unbound/99-edns.conf /etc/dnsmasq.d/99-edns.conf
RUN mkdir -p /etc/services.d/unbound
COPY pihole-unbound/unbound-run /etc/services.d/unbound/run
RUN chmod +x /etc/services.d/unbound/run

ENTRYPOINT ./s6-init