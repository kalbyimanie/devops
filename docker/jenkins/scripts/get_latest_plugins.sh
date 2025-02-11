#!/bin/bash

# Input and output file
PLUGINS_FILE="plugins.txt"
TEMP_FILE="plugins_tmp.txt"

# Clear temporary file
> "$TEMP_FILE"

echo "Fetching latest versions of plugins..."

while IFS=: read -r PLUGIN CURRENT_VERSION; do
    # Skip commented lines
    [[ "$PLUGIN" =~ ^# ]] && echo "$PLUGIN:$CURRENT_VERSION" >> "$TEMP_FILE" && continue

    echo "Checking latest version for: $PLUGIN"

    # Fetch plugin page
    PAGE_CONTENT=$(curl -s "https://plugins.jenkins.io/$PLUGIN/")

    # Extract latest version
    LATEST_VERSION=$(echo "$PAGE_CONTENT" | sed -n 's/.*Version: \([^<]*\).*/\1/p' | head -n 1)

    if [ -n "$LATEST_VERSION" ]; then
        echo "$PLUGIN:$LATEST_VERSION" | tee -a "$TEMP_FILE"
    else
        echo "$PLUGIN:$CURRENT_VERSION  # Could not determine latest version" | tee -a "$TEMP_FILE"
    fi
done < "$PLUGINS_FILE"

# Replace old plugins.txt with the updated version
mv "$TEMP_FILE" "$PLUGINS_FILE"

echo "Latest versions saved to $PLUGINS_FILE"
