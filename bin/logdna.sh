echo "[LOG] Installing LOG DNA"
echo "deb https://assets.logdna.com stable main" | sudo tee /etc/apt/sources.list.d/logdna.list
wget -O- https://assets.logdna.com/logdna.gpg | sudo apt-key add -
sudo apt-get update
sudo apt-get install logdna-agent < "/dev/null" # this line needed for copy/paste
echo "[LOG] Preparing LOG DNA File"
sudo touch /etc/logdna.env
echo "LOGDNA_INGESTION_KEY=a0a084f9598b790ff4a0e14fe79f4c16" | sudo tee /etc/logdna.env # this is your unique Ingestion Key
echo "LOGDNA_API_HOST=api.us-east.logging.cloud.ibm.com" | sudo tee -a /etc/logdna.env # this is your API server host
echo "LOGDNA_HOST=logs.us-east.logging.cloud.ibm.com" | sudo tee -a /etc/logdna.env # this is your log server host
# /var/log is monitored/added by default (recursively), optionally add more dirs by editing the /etc/logdna.env file with:
# LOGDNA_LOG_DIRS=/path/to/log/folders
# You can also configure the LogDNA Agent to tag your hosts with the following variable:
# LOGDNA_TAGS=mytag,myothertag
sudo systemctl start logdna-agent
sudo systemctl enable logdna-agent start