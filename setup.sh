#!/bin/bash

# DropMsg App Setup Script

echo "🚀 Setting up DropMsg - Next-Level Messaging App"
echo "=================================================="

# Create necessary directories
echo "📁 Creating directories..."
mkdir -p assets/fonts
mkdir -p assets/animations

# Download Google Fonts (you would need to download these manually)
echo "🔤 Font setup required:"
echo "Please download the following Google Fonts and place them in assets/fonts/:"
echo "- Poppins (Light, Regular, Medium, SemiBold, Bold)"
echo "- Orbitron (Regular, Bold)"
echo ""
echo "You can download them from: https://fonts.google.com/"

# Firebase setup reminder
echo "🔥 Firebase setup required:"
echo "1. Create a Firebase project at: https://console.firebase.google.com"
echo "2. Enable Authentication (Phone), Firestore, Storage, and Messaging"
echo "3. Download google-services.json (Android) and GoogleService-Info.plist (iOS)"
echo "4. Place the files in the appropriate directories"

# Install dependencies
echo "📦 Installing dependencies..."
flutter pub get

echo ""
echo "✅ Basic setup complete!"
echo ""
echo "Next steps:"
echo "1. Download the fonts as mentioned above"
echo "2. Set up Firebase configuration"
echo "3. Run: flutter run"
echo ""
echo "🎉 Enjoy building the next-level messaging app!"