#!/bin/bash

echo "=========================================="
echo "Cleaning Repository - Removing Course Materials"
echo "=========================================="
echo ""

# Remove submission screenshots entirely
echo "Removing submission screenshots..."
git rm -rf submission-screenshots/
rm -rf submission-screenshots-backup/

# Remove course documentation
echo "Removing course documentation..."
rm -f FINAL-SUBMISSION-CHECKLIST.md
rm -f REVIEWER-FEEDBACK-FIXES.md
rm -f REVIEWER-FEEDBACK-STATUS.md
rm -f SCREENSHOT-STATUS.md
rm -f azure-queries.md
rm -f verify-events.md
rm -f azure-pipelines-instructions.md

# Remove helper/temp scripts
echo "Removing helper scripts..."
rm -f organize-screenshots.sh
rm -f organize-new-screenshots.sh
rm -f setup-hpa-and-test.sh
rm -f generate-load.sh
rm -f monitor-hpa.sh
rm -f check-custom-events.sh

echo ""
echo "=========================================="
echo "Cleanup Complete!"
echo "=========================================="
echo ""
echo "Removed:"
echo "  - Submission screenshots folder"
echo "  - Course documentation files"
echo "  - Helper scripts"
echo ""
echo "Kept (functional code):"
echo "  - Application code (azure-vote/)"
echo "  - Deployment scripts"
echo "  - Kubernetes manifests"
echo "  - RunBook scripts"
echo "  - README, LICENSE, requirements"
echo ""

