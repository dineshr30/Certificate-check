# Get the expiration date of the SSL certificate
expiry_date=$(echo | openssl s_client -servername github.com -connect github.com:443 2>/dev/null | openssl x509 -noout -enddate | cut -d= -f2)

# Convert the expiration date to seconds since epoch
expiry_date_seconds=$(date -d "$expiry_date" +%s)

# Get the current date in seconds since epoch
current_date_seconds=$(date +%s)

# Calculate the difference in days between the expiration date and the current date
diff_days=$(( (expiry_date_seconds - current_date_seconds) / 86400 ))

# Check if the difference in days is less than or equal to 10
if [ "$diff_days" -le 10 ]; then
  echo "Hey, it's time to renew"
else
  echo "Number of days until expiry: $diff_days"
fi
