echo "🚀 RUN -> flutter clean"
fvm flutter clean
cd ios
echo "🚀 REMOVE -> Podfile.lock & Pods"
rm -rf ios/Pods
rm -rf Podfile.lock
echo "🚀 RUN -> pod deintegrate"
pod deintegrate
cd ..
echo "🚀 RUN -> flutter pub get"
fvm flutter pub get
cd ios
#pod repo update
echo "🚀 RUN -> pod install --repo-update"
pod install --repo-update
cd ..