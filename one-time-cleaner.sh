#!/bin/bash

echo "🔄 Cleaning up old thumbnails..."

# Find and count files older than 30 days
files_to_delete=$(find ~/.cache/thumbnails -type f -mtime +30)
file_count=$(echo "$files_to_delete" | wc -l)
total_size=$(echo "$files_to_delete" | du -ch | grep total | awk '{print $1}')

# Delete the old thumbnails
echo "$files_to_delete" | xargs rm -f

# Output the results
if [ $file_count -gt 0 ]; then
    echo "✅ Cleaned $file_count files ($total_size) of old thumbnails."
else
    echo "ℹ️ No old thumbnails found to clean."
fi