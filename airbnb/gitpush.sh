#!/bin/bash

# Check if commit message is provided
if [ -z "$1" ]; then
    echo "Usage: ./gitpush.sh \"commit message\""
    exit 1
fi

# Store commit message
COMMIT_MESSAGE="$1"

# Git operations
git add .
git commit -m "$COMMIT_MESSAGE"
git push

echo "Code pushed successfully with message:"
echo "$COMMIT_MESSAGE"