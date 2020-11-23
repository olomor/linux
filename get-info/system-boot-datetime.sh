date --date=@$(( $(date +%s)-$(cut -d"." -f1 /proc/uptime)))
